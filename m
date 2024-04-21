Return-Path: <linux-kernel+bounces-152438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE98ABE6F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 04:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528271F211EC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2624C70;
	Sun, 21 Apr 2024 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="SO5cP2sg"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5036C;
	Sun, 21 Apr 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713667788; cv=fail; b=pxO0r0hZpM8IuANym83C3zdovgq5+tBonhMq/yzAtOGXZNzBIrAuZyQ71ogqKI8FApf7ODYrVRGyEoHgt7HTG1DBnucFBPUjMlakCboBGI7RTOrUwnjjVEoozoSMN2MIh/qDW71X14uKhesdxRNWqlLa9CXPZ45T3qAHXe+uXkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713667788; c=relaxed/simple;
	bh=Ia6cmitlDwnnY0jXZoqSmZW5SC5S/08Lhks+VtX6sqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q70fv4JJDXM0TLee3GNci1yviUtToOqzOWdnoJzoVZK1eQOTfdTNZEn8JjM1VJv+JG8Ox6dfbouIdvZ3WIJ7xrqhfAd/68wAUt/2l2egNLri9K5IDfnrX0spWS6+EKQfb3K8O6Oj6mzSJ2uYupO0/HslrY73Eo7tDWWV6aL9PvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=SO5cP2sg; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43L2DOWT012577;
	Sat, 20 Apr 2024 19:49:23 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7g96k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 19:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajjJ15/AIzKzeu6qFPg9zwJZxtL0YioyS4Xs/xUUhmV8mWeUlhgckzToO+VSoWv/9E4NvF3R/aZsWSLc7g7vd7kSoQvGd5DWO5hKnc6vxrz5xayo9yLyMx6wMl9b3E8YREO4J4xKGPqg4cq6V9COSwkawf4OdzWGbVJ73TxOGCYxutDIW25EFdHTSzwuum2Bh0THzVpZGA/xC5iDUab8Ue3UjG4ThkRAuO2lz97Fi+I24u6qJ+kjy3GIiQGwV0bHshyqj12EfWfJIK6C16z8O0EIUWWvUtKUiiAFGKLnrF536B9sRoKKKqK1pZgLU7HVyJDLwWkKotSj36sseaHzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia6cmitlDwnnY0jXZoqSmZW5SC5S/08Lhks+VtX6sqw=;
 b=DsyG5mNOXukSJ1xa87vpapjXm2lplaI1qmXUvLVU5gzZn4VIK39Yty3uOX3BgwMuHXcw9cMKy7eruWHQclFpMw8hugrbB+SXvyM0ky2hZyw2xCIk6tvUxmy1uetEFD5/swBSH5dI+Gf+ZZmOEB9mvXt97BpKM8JM5YEU7oQYfXqMzRpyHdLXnKF3UMlGGA8ct5+kbW2rCwjwXXeoKt2WEgObY33zte2bxI8ymdnS9Z4QqhyM0x+MkWVgmCj6AN9tU1fqz+lCte+q9PnfZiZLfK+UeHyStURw8B2YDW8WpPmr1OmO0OeCo0IDCU0JYz+G/Usy2C754JVSJWPJH5Zutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia6cmitlDwnnY0jXZoqSmZW5SC5S/08Lhks+VtX6sqw=;
 b=SO5cP2sg0BK1G8WrAVm1Ma/MIHYFVi5YLTmtHJJB1kFuuPwNEq2kZwZt+FniD6hE6jGrJ51hcSw/YqfdthX/0s9a94JEV4WGZTzrE1YAL70es6NgvYFBoE4wGfl5r4qsfPnNXhVGn5MyGS2dOIOUYKyXSW88avQb8ns69gjgUz8=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by DS0PR18MB5411.namprd18.prod.outlook.com (2603:10b6:8:158::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 02:49:18 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0%7]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 02:49:18 +0000
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Anil Kumar Reddy H
	<areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org"
	<leo.yan@linaro.org>
Subject: Re: [PATCH v7 5/7] coresight: tmc: Add support for reading crash data
Thread-Topic: [PATCH v7 5/7] coresight: tmc: Add support for reading crash
 data
Thread-Index: AQHak5aBWXyywcvWg0uC8DohaEKemA==
Date: Sun, 21 Apr 2024 02:49:18 +0000
Message-ID: 
 <PH0PR18MB5002CFB5DD77312CE0337896CE132@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
 <20240307033625.325058-6-lcherian@marvell.com>
 <d707430f-00ee-4427-a9e4-6e42bc5b6aa9@arm.com>
 <PH0PR18MB5002D42E980EDF6317051B77CE092@PH0PR18MB5002.namprd18.prod.outlook.com>
 <a7b8d15f-5bcf-4774-a5b2-eb95d6174c43@arm.com>
In-Reply-To: <a7b8d15f-5bcf-4774-a5b2-eb95d6174c43@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|DS0PR18MB5411:EE_
x-ms-office365-filtering-correlation-id: f83727a9-013a-446f-3c86-08dc61ada3ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Qm5lRllvK2hHT1NhZDgwaklnSm1OVEZuMEExa1hPbmdBRXJRcGdJVzJGeEhW?=
 =?utf-8?B?Rk9iYktYL3dQOUg1eHBzWGQ2Um5oamFXUFVCNi9IRlVlTXR3TVA2b0NNRHRW?=
 =?utf-8?B?T2JpenhtSDZmSEVKRkFCeTdLT3cyNUdudTZVMi9yakpJTnVoRWNqMElYemk5?=
 =?utf-8?B?aWhtaTBHeWJKc3J0YXpTRDMraFlNZTU5bHpaU0g1MVZvUUhaeE5ud1NTUDYw?=
 =?utf-8?B?eW1wLzV4SWc1NHZjbjVSejJVR1hKSXlIdkxFTkNnOXJxRExSR0FqZ2t5YlZW?=
 =?utf-8?B?OGdyMm1JV1BwK1c5WWFqQVNoTlg4QjZ3VExMb2lmZ2Z4RkVYd1BOUGEyZUkw?=
 =?utf-8?B?ZTJENmd5UDJMcDZibnltQ1QrdDM1SU5OVUpHcHR5WmlKUTZpc2Y1V09DcS9O?=
 =?utf-8?B?TDNzUTZ2RUxKcEZ2K1Y0QStkL1l0anE3d2VBY1djTlE1T0FpTDU2VFJ4Q2xK?=
 =?utf-8?B?TXUrNW5BV1krdXp5S21aYXEyVUtDNEJwUkRjNWVxbFhlUEhYUEowNnNFc28y?=
 =?utf-8?B?alRJVzhaUW9VS3QrbjhjZ1FaQWNBZmg1ellkdHJqemZVMzlvSFZmRG5TUHhq?=
 =?utf-8?B?NzM1OURLZHZ2TXROVkJlb0I1b2gxUHdGSGxDUGFCVW9IVVo0RFFkZ2tJRGxo?=
 =?utf-8?B?Y3AxZkNYZXJlUElybGlmOWxlVkFGN1hWRlRTejEydXBKd2xPQUFXamJaKzRH?=
 =?utf-8?B?dFlENS9PVHZtQWdmcE1Uek90cURTWmxHTHdiTTJ0TDRUd2JsS3JDdVVkNHhw?=
 =?utf-8?B?NWluamVyak9VMVlWVTFoWGd0cW9iTys5ZmNJeTZVYmtQcHgvay9LdmVtd0NF?=
 =?utf-8?B?VC9rODFRSDVCQlBNMW1sQVhxSmRkZXlTZGVQbzRtdEQzVEUrRklhcEY4bXlN?=
 =?utf-8?B?UVZ1YjU3cU5zK3YvSU9XcnhmbVNnV24zV0Q2QnhJdThYdHg3UWVKUW96Qks5?=
 =?utf-8?B?R3pmdFdXVUNaOCsvaDZJSWpNa3pZV0lvTmVBM1lSLzgvajlrR0JqcTF1RUho?=
 =?utf-8?B?SjZ2WTcveU5QSG9GQnlzam9vQmJtdjg2Q1pFTVNDb3JXd2FSekRTK0hzakV2?=
 =?utf-8?B?YldiMHQ0c2oxUlFhTU94OXhJNCtMRzQvSEg1N1ZDSTE0WEtONmJwZFdhckkr?=
 =?utf-8?B?bzVuSTdKWTV6S3FJbHFKcWluckVJSG5VbWpzQ2lKRCtSR0Izb2Q4V0RadThy?=
 =?utf-8?B?SFNxMWt5Sk1UQmUyeUpaR0daSHU1V2tEQTRWMWNscklnYS9Lelltdm4rOW0r?=
 =?utf-8?B?b1BVL0NnQ0xEOHA4bloxRkZhaEROY0lSdFBHb3NIdTM1YmIrTHRZVFB5Y1hv?=
 =?utf-8?B?UE03WmQ0TEJIRXMyek44cjVjdldIYVZBVXVHQkJXczl4VkJ1MC9vZWN3aDc1?=
 =?utf-8?B?bmMxdVozZTREQlBHWHN2RVVOaVVWNlIySVZGRnlhWGlsZTh1bkRRVW1vckZP?=
 =?utf-8?B?S0l2SGQ2eEVvenB5c2NOYmdIV21mTzZaL01DY2JtY3IxOVVJeDVoQ1JxNmJT?=
 =?utf-8?B?R2dXdG1SenVER2NOUWs4aWJPbUhyRkRiUDdFdE0vTWcvZUk1TFBnT1lpZG9q?=
 =?utf-8?B?eVVWVHBFSDBHOU5kUlMwbDM1b0ZDOUovMWZ1QjlQT1VoQ2IzU2UxeElkSC93?=
 =?utf-8?B?U3dTZ0lXR2sxeUhPdytzNDRHbUJsTTJvZURpcTZkdkZDMGxUd2RuOER6THJi?=
 =?utf-8?B?TkFzZHptM0dhMG52YUh2aWFhaFgzN0FwRDZkRjNlcTBZTDl0eVFXYktSNndI?=
 =?utf-8?B?YzBxblhMZjQ1My9wWHJ5NUFMVFlwQUozbzN0WjZYU1IyZFMzc0hJNlJrdEM1?=
 =?utf-8?B?eStvVXp3V3IwSGxmdklyUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bmxpYXVjRGpmSTFuZ2RmNjVlTTY3ZmY5UXFKTkhQN2xVTXpJZXlEUG9BRCs0?=
 =?utf-8?B?eWY0aGZiYUZ5YnNFV0pjWU43cFhHU1haRkpFcUdqK2J6Qks3OEk5cWRUaEw0?=
 =?utf-8?B?N2h6TXVGZ2JPdmNHTGtOWUR6ek5YcG12cEhPeGwvU3VYWDZMclhTWDJHZkk3?=
 =?utf-8?B?bkk1T3lUK3lNcHhrdTk5VHFUN0VzOGpaVDZhaURtVEovbWZzOE5TY2FSMXZa?=
 =?utf-8?B?VGZVcXVlYUhWMURpMEpRRmdNN0EycUV5TmFzZmN4YlFxelQrODFuNS8zeU95?=
 =?utf-8?B?OUZzNVRKdDBhV09mV1lDY0ZCNSt2VFJQTm1hc2VEbE9ySk1qRHJvWjFBSW4y?=
 =?utf-8?B?VVhaeXhVOWQ2T3VmMXJXSytJRTRoOVdMQm0yQUc5QWY1TW9JYTdFWnNEYjEr?=
 =?utf-8?B?bGNFV1NSRllIeGFITGRaYjY3K0NmcW5SbEFYSzFuQlU4RTExL0tpdEU5UzBh?=
 =?utf-8?B?NHVUUzkvUnluVGhDUkV0VWFwT0xKT0N2YmZUbUh1K2VBNlBGUlVlaG1lWEU5?=
 =?utf-8?B?U1o3aU9HT2c1bTZ4UFc5c1FwNGlhZE85OXd2R3ZVZWdldU9nazVjRGJ6TGNL?=
 =?utf-8?B?ajVwczZ1K2tXUUFIZTlFRE1lMW5xVHVRcHpoTVpZQlBZcHRRVXhXWUtXdmht?=
 =?utf-8?B?bTA0UTFGTVpnOW0xN0Jmb05pYzdCQm1ocDR0Y1pXaDlKeWxrMkhLWnFQUHFt?=
 =?utf-8?B?cWRYQkE2Ukpha05PTmNWTzF0UUdPK3VqZ2JPblc3L1BrTmg0V3NPVzNVbUEv?=
 =?utf-8?B?YnNRajVpTjBGbncraXZnUGVDb0d0SGhHN0o1NC9zbGpEZ2NmVzByb0UvSUd5?=
 =?utf-8?B?WDFLSENFYjJIM0RsT3gxM2JybkI0dS9hdFRHY2xFVkprZ2lzK1I5RHBURzcv?=
 =?utf-8?B?TUFBRVllNW9NQjNGK1BJM3lpNjZXd2hONmN5TEo4QTRZcWxydFZHSlF1UnRD?=
 =?utf-8?B?akdWRTIraGlvRzR6aFNZRkIvNkV2N2xrdWhyUlpoMDc0MVpSeGpDaXJ3cE83?=
 =?utf-8?B?VXJTY1czcldJVWtpL3A0VGU0ZVpBbGVNQlZsOTVPeFJiTGdQSEZFd20zVSts?=
 =?utf-8?B?YldPQjV1cmRXczNlMENvcXlKWHhLbjllaDRtellTRDdkRk9sZndmRC9tY09Y?=
 =?utf-8?B?Nmo0L09wMDY0QjJYNzhVNi9UcWtZSkIxdW1GZ3RpT3puZjdVTG1rRVNqMGhi?=
 =?utf-8?B?QWRWejRremRZT0tYRk9mME5NUzJxZXNVajFxTHNmbnE4TDQzcFYraFp6Q1Zu?=
 =?utf-8?B?eUd4bElEcHl0QWZqMDBpdFRyQzMzbmE2aXE1dGJnK3FFcElHSG14ZXhFQ0FV?=
 =?utf-8?B?a3NlY1JiZ3pCZmlWeEdRM1JHYlErZDhDZXlmN1U2Y3RMTzMrVUpyNW5WTXpP?=
 =?utf-8?B?YU4rWStaRGgwZE84RVVaYUFqTmtSY0JkeWRuSnFYQmtGd3llRHhMSkdZMVY5?=
 =?utf-8?B?MzMvdXZaSDdVTFV5ZmpiMEU0UWdZLytmRjRUZldZZStGekVrTlBEZkwzRDJJ?=
 =?utf-8?B?eEoyM2VyNndvZWh4T3dJQkNSR1VtbUVTRHNRYTRCcVYyMHRSbXh1LzVJSC9S?=
 =?utf-8?B?N2ZxbWVzY2hWaFYwL0tYYmtvYkNzUm9KUmthWHB6WERvbCticitmNndVcE9x?=
 =?utf-8?B?bzZPQitkcG1IY1gwNS95SkRGZ1E4QU0wN0pVN0hsWWNnSHFSL2xlVDZOYWh5?=
 =?utf-8?B?RmFpRCtQelRJcDJodGxDbTIyNXUzYnRpNlM5UEpMaU5hNm1UM0tYdzF2UFRN?=
 =?utf-8?B?V2VrNTJYZkQvckg3WE1DanhBSEZkeTVDTm9hbGdEKzZyVitqd1NoWU1SUS8x?=
 =?utf-8?B?UGdYVDhjbXAraWVIQWtZOVJNSWhQekhheE56bkoyU1NndXZhMTUwLzhIQlNw?=
 =?utf-8?B?Q1k3aEtqbUYrMEhmcXlMQ1U4QkhuZ1lNMCtzdjM0ZkxvakdaRnRRRnI0UXBh?=
 =?utf-8?B?Z3lhdVdZalp4VUdNS08vRWt1bDZJWUg1QkFoSDFHWE9PRTNybldwdVVRdUUw?=
 =?utf-8?B?TEpPempvaEprMHIwV0FZQldHVk1FY1c2K3lKY3NtQkljb3lKMnFTaWxHR3kv?=
 =?utf-8?B?SFVvb25ET1FoVVd5ZHNlSHFWQ2M2RVVCTU10M0FsaDlvamVPdG5idG04d3lN?=
 =?utf-8?Q?SnQEg77ha5Q8I/lOf8t6lqzuo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83727a9-013a-446f-3c86-08dc61ada3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2024 02:49:18.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9X0DUFQO2E+yO1Mntib/njwUp6BzlEXzFVdqyeU8dk/fLf6Z3EdVxGTlCMMhJ6GGJjJyWtj/9n/6KEvZy5vkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5411
X-Proofpoint-ORIG-GUID: IFbz6lPNXyW2DF--rXp9u7-u6EvToDrF
X-Proofpoint-GUID: IFbz6lPNXyW2DF--rXp9u7-u6EvToDrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_02,2024-04-19_01,2023-05-22_02

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMg
Q2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTUsIDIw
MjQgMjo1OSBQTQ0KPiBUbzogTGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IFN1
enVraSBLIFBvdWxvc2UNCj4gPHN1enVraS5wb3Vsb3NlQGFybS5jb20+DQo+IENjOiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGNvcmVzaWdodEBsaXN0cy5saW5hcm8ub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0K
PiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj4g
PHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2VvcmdlIENoZXJpYW4gPGdjaGVyaWFuQG1hcnZlbGwu
Y29tPjsgQW5pbA0KPiBLdW1hciBSZWRkeSBIIDxhcmVkZHkzQG1hcnZlbGwuY29tPjsgVGFubWF5
IEphZ2RhbGUNCj4gPHRhbm1heUBtYXJ2ZWxsLmNvbT47IG1pa2UubGVhY2hAbGluYXJvLm9yZzsg
bGVvLnlhbkBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0gg
djcgNS83XSBjb3Jlc2lnaHQ6IHRtYzogQWRkIHN1cHBvcnQgZm9yDQo+IHJlYWRpbmcgY3Jhc2gg
ZGF0YQ0KPiANCj4gDQo+IA0KPiBPbiAxNS8wNC8yMDI0IDA1OjAxLCBMaW51IENoZXJpYW4gd3Jv
dGU6DQo+ID4gSGkgSmFtZXMsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogSmFtZXMgQ2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+ID4+IFNlbnQ6
IEZyaWRheSwgQXByaWwgMTIsIDIwMjQgMzozNiBQTQ0KPiA+PiBUbzogTGludSBDaGVyaWFuIDxs
Y2hlcmlhbkBtYXJ2ZWxsLmNvbT47IFN1enVraSBLIFBvdWxvc2UNCj4gPj4gPHN1enVraS5wb3Vs
b3NlQGFybS5jb20+DQo+ID4+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGNvcmVzaWdodEBsaXN0cy5saW5hcm8ub3JnOw0KPiA+PiBsaW51eC0ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+PiBrcnp5c3p0b2Yua296bG93c2tp
K2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj4gPj4gPHNnb3V0aGFtQG1hcnZl
bGwuY29tPjsgR2VvcmdlIENoZXJpYW4gPGdjaGVyaWFuQG1hcnZlbGwuY29tPjsNCj4gQW5pbA0K
PiA+PiBLdW1hciBSZWRkeSBIIDxhcmVkZHkzQG1hcnZlbGwuY29tPjsgVGFubWF5IEphZ2RhbGUN
Cj4gPj4gPHRhbm1heUBtYXJ2ZWxsLmNvbT47IG1pa2UubGVhY2hAbGluYXJvLm9yZzsgbGVvLnlh
bkBsaW5hcm8ub3JnDQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2NyA1Lzdd
IGNvcmVzaWdodDogdG1jOiBBZGQgc3VwcG9ydA0KPiA+PiBmb3IgcmVhZGluZyBjcmFzaCBkYXRh
DQo+ID4+DQo+ID4+IFByaW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczogQ29u
ZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQNCj4gPj4gc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5r
cyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzDQo+ID4+DQo+ID4+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAt
DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDA3LzAzLzIwMjQgMDM6MzYsIExpbnUgQ2hlcmlhbiB3cm90
ZToNCj4gPj4+ICogSW50cm9kdWNlIGEgbmV3IG1vZGUgQ1NfTU9ERV9SRUFEX0NSQVNIREFUQSBm
b3IgcmVhZGluZyB0cmFjZQ0KPiA+Pj4gICBjYXB0dXJlZCBpbiBwcmV2aW91cyBjcmFzaC93YXRj
aGRvZyByZXNldC4NCj4gPj4+DQo+ID4+PiAqIEFkZCBzcGVjaWFsIGRldmljZSBmaWxlcyBmb3Ig
cmVhZGluZyBFVFIvRVRGIGNyYXNoIGRhdGEuDQo+ID4+Pg0KPiA+Pj4gKiBVc2VyIGNhbiByZWFk
IHRoZSBjcmFzaCBkYXRhIGFzIGJlbG93DQo+ID4+Pg0KPiA+Pj4gICBGb3IgZXhhbXBsZSwgZm9y
IHJlYWRpbmcgY3Jhc2ggZGF0YSBmcm9tIHRtY19ldGYgc2luaw0KPiA+Pj4NCj4gPj4+ICAgI2Rk
IGlmPS9kZXYvY3Jhc2hfdG1jX2V0ZlhYIG9mPX4vY3N0cmFjZS5iaW4NCj4gPj4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBBbmlsIEt1bWFyIFJlZGR5IDxhcmVkZHkzQG1hcnZlbGwuY29tPg0KPiA+
Pj4gU2lnbmVkLW9mZi1ieTogVGFubWF5IEphZ2RhbGUgPHRhbm1heUBtYXJ2ZWxsLmNvbT4NCj4g
Pj4+IFNpZ25lZC1vZmYtYnk6IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5AbWFydmVsbC5jb20+DQo+
ID4+PiAtLS0NCj4gPj4+IENoYW5nZWxvZyBmcm9tIHY2Og0KPiA+Pj4gKiBSZW1vdmVkIHJlYWRf
cHJldmJvb3QgZmxhZyBpbiBzeXNmcw0KPiA+Pj4gKiBBZGRlZCBzcGVjaWFsIGRldmljZSBmaWxl
cyBmb3IgcmVhZGluZyBjcmFzaGRhdGENCj4gPj4+ICogUmVuYW1lZCBDUyBtb2RlIFJFQURfUFJF
VkJPT1QgdG8gUkVBRF9DUkFTSERBVEENCj4gPj4+ICogU2V0dGluZyB0aGUgUkVBRF9DUkFTSERB
VEEgbW9kZSBpcyBkb25lIGFzIHBhcnQgb2YgZmlsZSBvcGVuLg0KPiA+Pj4NCj4gPj4NCj4gPj4g
Wy4uLl0NCj4gPj4NCj4gPj4+IEBAIC02MTksNiArNzQwLDE5IEBAIHN0YXRpYyBpbnQgdG1jX3By
b2JlKHN0cnVjdCBhbWJhX2RldmljZSAqYWRldiwNCj4gPj4gY29uc3Qgc3RydWN0IGFtYmFfaWQg
KmlkKQ0KPiA+Pj4gIAkJY29yZXNpZ2h0X3VucmVnaXN0ZXIoZHJ2ZGF0YS0+Y3NkZXYpOw0KPiA+
Pj4gIAllbHNlDQo+ID4+PiAgCQlwbV9ydW50aW1lX3B1dCgmYWRldi0+ZGV2KTsNCj4gPj4+ICsN
Cj4gPj4+ICsJaWYgKCFpc190bWNfcmVzZXJ2ZWRfcmVnaW9uX3ZhbGlkKGRldikpDQo+ID4+PiAr
CQlnb3RvIG91dDsNCj4gPj4+ICsNCj4gPj4+ICsJZHJ2ZGF0YS0+Y3Jhc2hkZXYubmFtZSA9DQo+
ID4+PiArCQlkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUwsICIlc18lcyIsICJjcmFzaCIs
DQo+ID4+IGRlc2MubmFtZSk7DQo+ID4+PiArCWRydmRhdGEtPmNyYXNoZGV2Lm1pbm9yID0gTUlT
Q19EWU5BTUlDX01JTk9SOw0KPiA+Pj4gKwlkcnZkYXRhLT5jcmFzaGRldi5mb3BzID0gJnRtY19j
cmFzaGRhdGFfZm9wczsNCj4gPj4+ICsJcmV0ID0gbWlzY19yZWdpc3RlcigmZHJ2ZGF0YS0+Y3Jh
c2hkZXYpOw0KPiA+Pj4gKwlpZiAocmV0KQ0KPiA+Pj4gKwkJcHJfZXJyKCIlczogRmFpbGVkIHRv
IHNldHVwIGRldiBpbnRlcmZhY2UgZm9yIGNyYXNoZGF0YVxuIiwNCj4gPj4+ICsJCSAgICAgICBk
ZXNjLm5hbWUpOw0KPiA+Pj4gKw0KPiA+Pg0KPiA+PiBJcyB0aGlzIGFsbCBvcHRpb25hbCBhZnRl
ciB0aGUgaXNfdG1jX3Jlc2VydmVkX3JlZ2lvbl92YWxpZCgpPw0KPiA+PiBTa2lwcGluZyB0byBv
dXQgc2VlbXMgdG8gYmUgbW9yZSBsaWtlIGFuIGVycm9yIGNvbmRpdGlvbiwgYnV0IGluIHRoaXMN
Cj4gPj4gY2FzZSBpdCdzIG5vdD8gSGF2aW5nIGl0IGxpa2UgdGhpcyBtYWtlcyBpdCBtb3JlIGRp
ZmZpY3VsdCB0byBhZGQNCj4gPj4gZXh0cmEgc3RlcHMgdG8gdGhlIHByb2JlIGZ1bmN0aW9uLiBZ
b3UgY291bGQgbW92ZSBpdCB0byBhIGZ1bmN0aW9uIGFuZCBmbGlwDQo+IHRoZSBjb25kaXRpb24g
d2hpY2ggd291bGQgYmUgY2xlYXJlcjoNCj4gPj4NCj4gPg0KPiA+IEFjay4NCj4gPg0KPiA+PiAg
ICBpZiAoaXNfdG1jX3Jlc2VydmVkX3JlZ2lvbl92YWxpZChkZXYpKQ0KPiA+PiAgICAgICByZWdp
c3Rlcl9jcmFzaF9kZXZfaW50ZXJmYWNlKGRydmRhdGEpOw0KPiA+Pg0KDQpEaWQgeW91IG1lYW50
IGNoYW5naW5nIHRoZSBjb25kaXRpb24gb2YgImlzX3RtY19yZXNlcnZlZF9yZWdpb25fdmFsaWQi
ICBieSAiZmxpcCB0aGUgY29uZGl0aW9uIi4NCklmIHllcywgdGhhdOKAmXMgbm90IHJlcXVpcmVk
IElNSE8sIHNpbmNlIHRoZSByZXNlcnZlZCByZWdpb24gaXMgc3RpbGwgdmFsaWQuDQoNCklJVUMs
IHRoZSBpZGVhIGhlcmUgaXMgdG8gbm90IHRvIGZhaWwgdGhlIHRtY19wcm9iZSBkdWUgdG8gYW4g
ZXJyb3IgY29uZGl0aW9uIGluIHJlZ2lzdGVyX2NyYXNoX2Rldl9pbnRlcmZhY2UsDQogc28gdGhh
dCB0aGUgbm9ybWFsIGNvbmRpdGlvbiBpcyBub3QgYWZmZWN0ZWQuIEFsc28gdGhlIGVycm9yIGNv
bmRpdGlvbiBjYW4gYmUgbm90aWZpZWQgdG8gdGhlIHVzZXIgdXNpbmcgYSBwcl9kYmcgLyBwcl9l
cnIuDQoNClRoYW5rcy4NCg0K

