Return-Path: <linux-kernel+bounces-31653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432EC8331F5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05852832B8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE690A53;
	Sat, 20 Jan 2024 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MyXKZfus";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XjJvfn1m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HUvqp00r"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B57650;
	Sat, 20 Jan 2024 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711894; cv=fail; b=cdgSvoAuuwfdVuU19WzYtXdzXR+M3MsrEcQbw8vnL6T3c5duuMJyg6DRb+zoP+em3xLj4PqIqL/lQLYH1goQuhMh0UmYy2xkhzXPUSFw4INCoWOF2s/H/BkTfMz8OeqIYnWTDaxSNw3FZFzv+s0d4MTTXqsZMtv5NX7iMLmTIv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711894; c=relaxed/simple;
	bh=7OCBvTC5Vu1e83enlBy8IDk1C3HbYIivZmYP6fy48kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KU/JxMkQGCkpnR0eaA8RJzd3q15Owp0sCBkW6IfoR8gBAcWoJanIZh2rcW/3v7JbjmH9GsukE6Hj72+G5tz4OGyeDTiIuXqw/sasHpxzPiSy81XCElef2fqpA82fdFct+LwkxuZjTPysRdEleAtI0NH8OZ3PwMbbAQXSy6cqH64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MyXKZfus; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XjJvfn1m; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HUvqp00r reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JIDrdn016752;
	Fri, 19 Jan 2024 16:51:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=7OCBvTC5Vu1e83enlBy8IDk1C3HbYIivZmYP6fy48kA=; b=
	MyXKZfusgAp4Whcfa7IqZGpQ+Qt0StTQRfvcHNYG77BqhToPrIPrMKc8YZncfSj6
	2k3y5uQ3XMfpk3CnJOEd4il7EvonYNVQLNVuyk1kG3XI76mwYH0XlP+2lAGdnMQv
	4v0hPtRSr0fsKdHSDn4KszO3515dGSbw+IQ2IAQ252q4NUTHXNSN7R/OCZQ2dONh
	oHKDGZXd5ob2P5L+8fW3/7sqpZN3b/RIJV3OEsRTlgK/1TELEe+UEL4YpVyq27BX
	ptFszNNiUfwgrLj61KJgQD9NHYbmd/2SYkt4UPFgoJkH3fw5JIval1aM91AXzIrz
	DMqA5huoz9IXtQX/mdATfQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktn6rrjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705711874; bh=7OCBvTC5Vu1e83enlBy8IDk1C3HbYIivZmYP6fy48kA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XjJvfn1mkxv0wXuVFgNmZuzcV+sPVn0Z8dkVTQ/yTL2JvZyv6dL8JmLtxQayI84La
	 U1kh7hGaKL16XA1Tw6HUwkF903QeDU6r/kBK9g6nfs4QPdjoC+upzguX12XEA40tVN
	 Wa5xwogTqex4y7RpU/F8AFL9SNmyJgohNeehpkAXf6950zeWc0qjFxQp51EhCyNAgc
	 bc59GT+gP5T92WVJYYi8CVAFNLugdOV55AtFPETGr0lbnqSB9kEsVyOh9PDqvrzjQG
	 WGSg+TDt3xQju+0PrqUK2IOElseh45dPMZwU6w2DjwEF9HYooAKbhz68UEr7lXjKD0
	 WAGF8sk5oP3vw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 85A0440407;
	Sat, 20 Jan 2024 00:51:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1B355A006F;
	Sat, 20 Jan 2024 00:51:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HUvqp00r;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 58EC5401C4;
	Sat, 20 Jan 2024 00:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEpwAYqO8L3ez0q672d1hcqI+mUQZE6VB6Z+cmmuCBTQVmNHemCesBug4vXW9K5zdwxvQ0azkEmtG0URzi5xgzaem6kMREaukaZu9ai5KyZdwBj2P3+GPGBNt3gurJIRWclWYXBErhm+nHgnelfRyJbWhLc/wwBex1XrTVU7QtwjdbL2kCNrvWYfSkHKuaWwY7dzSVKNY/vNzjAMww0evbDM0Fy6BNXLm9zIARem4zVYs/nvTyhDC4SsJEQrlKoJvuYIlK/OgtOuectWOCeaor/FLEmFeKAWSvwrsN7CGEeju2DwrqSfB7H1mYd0rh24wAl/0jp9avTeC6CDjV0b7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OCBvTC5Vu1e83enlBy8IDk1C3HbYIivZmYP6fy48kA=;
 b=cJsqQVk18Qng2J8WYiocPm8t3RMSjlKOFrTO23zpfdw2ghKbI1QChoXJR12xCwgo825LE8Fm+ct44WvQqEAPbPPYx1mlBVm/s2+nSOi34YvNYnHrsfDetKGKaqvnYxpkr5lEiKdTKD59z/es4MhpRWjHl/dQlHIJp4UxZV//dfgiuMZHINqBX3x9HgDmYkCjqUf27YdzUJuZBu8vDcC9pX0kNf1mmHyAiT6+01FxWqjtD/abCgslwvka6+/6S5lFcbEIOhshnI/aLouk38I0laFer+gq4GHzav3DvZtJ/w849fZ2glu1SvD8jwxOAeQOqf56sfN16PP0tc5baCVXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OCBvTC5Vu1e83enlBy8IDk1C3HbYIivZmYP6fy48kA=;
 b=HUvqp00rrf7dDElgJJa/qVUCV4ZwR8zMKQzRQ3RH9YH5wFw8vNEo/EoLqjJuNHnKvBXRkGJE3WYRDDUQKNF80MVmQ8XTu45zcdEcxAhgIrNPvA7DtJZ2BtNceBmBtX8GNeetX2vC7dI58hVG82nX76ZOikDKoxb7Iye8ZBhUBVU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Sat, 20 Jan
 2024 00:51:08 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.026; Sat, 20 Jan 2024
 00:51:07 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: "ran.wang_1@nxp.com" <ran.wang_1@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open  list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pku.leo@gmail.com" <pku.leo@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Topic: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Index: AQHaSx7vIkvixdmjvU6Ts0lYv2QFCLDh3zUA
Date: Sat, 20 Jan 2024 00:51:07 +0000
Message-ID: <20240120005056.o52hqn2sershhm76@synopsys.com>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240119213130.3147517-2-Frank.Li@nxp.com>
In-Reply-To: <20240119213130.3147517-2-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4879:EE_
x-ms-office365-filtering-correlation-id: 8f0bc395-f88c-476b-fb3c-08dc1951e357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MPq+6pa9Ajkv4ltw/fZGv1c4+IXdzK1OU2np2iabdOymQUzd09iLI5W8LQJFHXeOmJ2G8SWXI+SfwxjNygHNgYEBaHw9DK9hs+8TZ+D4CVnnslLI/SHuH0uUvYLZ/e/Ve2W87C5CXLavbuKFP9aPwV96PklMfBbDFqzVmszgSqnSggQeGc1y74Rm91+rgNi3ToV/foff6cTr+Iy2rKs7NbbiUih9q4DdmFMXCMw9Ok2SJTdt4OSci5nljs7aIIjjweRPNoxpXGkaaxZJfOwC8lYH5HDEqu/OMJILiLViBNXl/6WnSbvf10cN0QONeW7naA1zzqPrV2xXmILRxNykQ72Uj6njF4PH5bV4jMIh6PQYzFhdlTSxy4jtWyFwm77qMN/a1/2ZOehNTQKlshARWOax5DgQmgAKsj7b0x4H622eC+KpNf3QzfGQs9gB0Sj9uKB6t1N5cQj8/PMUAvYIGyNXYbBTplJ150kR2HE85yRnl+hjtbBm2SfaS77ImGmf5BxHCimbKgwcYBTo8ny9aKDm8xAqeHFJ5ijmzTCA4QL3nWv7YmgquyXmzVBwFW1GCa4CsGllPK17bJIRgOqFBfRNjhcCHJq+o3R6rIBeWgGu8w8ZGlVjR9CYmhhJ9889TfnI914cGOwRED3xCKpIsQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(6506007)(26005)(2616005)(1076003)(71200400001)(6512007)(83380400001)(38100700002)(86362001)(36756003)(38070700009)(8936002)(4326008)(41300700001)(966005)(6486002)(8676002)(122000001)(2906002)(7416002)(5660300002)(316002)(76116006)(478600001)(66946007)(66556008)(45080400002)(91956017)(6916009)(54906003)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d25aekpwSUp1ZFlQbjB2bjVGWkZidDh2NUhaWWprNWVWUzgwa3lvTFNickhZ?=
 =?utf-8?B?QW90V0VXRlpjR21aaS90enRwaC9XQW8rdUJZSU1IaXBoMVVOTStKdGtiUERQ?=
 =?utf-8?B?SHlIalZId0dzWmFpR3RqUWhxTnQ3QmU0VjBjMzRuLzNrT0NHTGtTU2FIZjVO?=
 =?utf-8?B?RUs0SThNR2RlYWJ0eXlUdHFhOW16dVNGSDF4cElqNWRtQmJ4cmRxbW1nb01n?=
 =?utf-8?B?RzJQWEJGb05CTVZFQ0lkaXpnWWpDbzdQWVpEQ25Jb1dmK2NMaHo1YWR2dWMw?=
 =?utf-8?B?czhaYW1KWUIwQWdDcDNtUGFXR0FxQVpPSStxREU0bGNOM09XaUJuY3ovdjZL?=
 =?utf-8?B?TFNoM1g4WStWSGxuSXkrNDc0RThxbDNsMTMzZjhHQTg0a0FTc1VtVFJtYkdo?=
 =?utf-8?B?UDVNSDRPdDN3SDViMjk4SnB4c2FPbHYzeW5ydEIrY3NveXpMUFZFZmsyMlNo?=
 =?utf-8?B?Ym1YL04yeklRUStOYUwzMjhqY29qZEFoUEhxMXZtQmtxUUVwWGQ4MVI4c3Rq?=
 =?utf-8?B?d2hVWEVPckNxSDI5QjZMSUFUZjdYbXVJcHJXVXhEcVNlNTgxaTZoT0pHdzAr?=
 =?utf-8?B?YWRnbDFReitQb0ROUThzdHhUeDFFcnlnK09ZU003ZDJ6L0dQeTNxQzY1QWk5?=
 =?utf-8?B?M09tZnF3NXFTdTlwZUJsN0piVUhDWmRkeFEybmo3anlPRHBpNE5OMWNTdXFw?=
 =?utf-8?B?Q1JMemJ3Ujg0UVpsbjloMEg2U2NXa1JNbW9IeGtBRExXV2hNaEYwU3J6VDV4?=
 =?utf-8?B?YmdtYkRhdVNOdDNTb1U1WjErd3pSQjZ5VTVhOE9DUFhKajdITmN0MkQxZGZP?=
 =?utf-8?B?UEp3TzRSNmFYejhLdTBEM2FoSytxdUYvdHc4OWxwUHpWTXg1bStVSHRiV1BK?=
 =?utf-8?B?SVhnQ1VadktvSVFoeEZWb1pZS0lwVC85SG9XdFY4clJVWXNGZ3N0S3F1eVhz?=
 =?utf-8?B?NnRZaTBzQ0hLbUlablJoRjVXSm1CVFlVWHp5RkozeGYzSGsxbE5GbEpIVzRU?=
 =?utf-8?B?Ti8wbk5aVlNoZUlSbHdSVmhsSnQ2RGlxQ3JGeUk1ZHRqbmNZRXVQR2xqWTBV?=
 =?utf-8?B?UVhKbEhJM3lmbi9IbEltT3FZS21hemZjSTFidFZMS0VXc0ZjTzhPVzM2d1Yz?=
 =?utf-8?B?NXRDM21kMnFibm9abjFibzdCYkRSbTB5SUlmM3Z5eVdrZDBPS20rdVlERTFF?=
 =?utf-8?B?WFc3RmhuWktzYlg5UHYzZTQ5SFVSYjVLc3lmekVuL1dOQTFtZDRpMkFvRzQz?=
 =?utf-8?B?eGYxTnMrT0Vzai9xTjNBTnQzTFRJTWFUUVpyeFlQSkV6ajQrZ2lyMlZHWjdp?=
 =?utf-8?B?eGx2RGlZTDhUL0tHem5YZzBReXhjRk1GWkgxNEhlMWZOQ21sT3MvZXh4SFBM?=
 =?utf-8?B?V2lhU1Boc0ZkZjZkRG5LeStPTzJBVEU0NVY1UnB6aE52RENyL25rRUx0WHhP?=
 =?utf-8?B?U3crTk8xVnhJWGlnSm8wVUxVM0NVT2dPZFNSOEs1UFNqNEhkTnJwZElRRVlk?=
 =?utf-8?B?eXB6NEVYanZuSms0UWR6dmtUSk5HNHB4aDZ2Z3c3elNaTWlWK3oyeDdIc3p4?=
 =?utf-8?B?cXVGeTJVZWt3WUZtaVJFM2RQN25rUkNRQjQ5cU84OEdUZmNZTDhLN0tPNFdJ?=
 =?utf-8?B?Rk1KK1hkek5lNzgycVJLeXlaSzZ1TGZPWTBqWDk3Vi9NL2UwOEd0Yk5lWGN2?=
 =?utf-8?B?WnN1L2dBcm5oeHUyL3pmWktkcktxUXRLcHUrYTJzK3I2TWRsSCtBWGROcW9t?=
 =?utf-8?B?WDhuWVI1N0tZcWk3VlRCUnNOMnJ0QzU1S29CY1Q5WXQ5Tjd5QThXTmY0QzJ3?=
 =?utf-8?B?ZHZtMm1ZSGNGVFBDRXJBQk82THVwK0EyajZTVG91NW1LUTN5REtPZnZzM2Zk?=
 =?utf-8?B?alNqRy9EeFlYbi9SUGsxRjdOeTRkb0IvdFk3UmJzZk15M1EwWExPSW9RanBu?=
 =?utf-8?B?OG1Fd29EbnhOeWpUWDdJWkFXbTdDNVp4SWR6NHhtL2p4dkQ1MlZhVnBWR1lY?=
 =?utf-8?B?YzhjcitKZngzYmFpWUhsbndQa3lQZk5LSkdibkFrN3RmUjZLQzZybE5makVY?=
 =?utf-8?B?NHdSSTh1UjhGOXlENTlyM0NZWVNrTE1hSkdKWFl5RGRRWDRxWTEzQkFkY2xn?=
 =?utf-8?B?UWU4Z09MUGhNdng2UFJTMS80Tjd3em00bks1OG1aVkMxTmxReWU4bjA5ZHZW?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5DD8A73AB4CCB45A29BDE08B51BD4B8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Stu9fu7rPucoWC9+6xf/g4qc8Tr7YthnF//V+4nmtrWQReI/37HPfPeTqWv+4WWv6aRnb57H2HA5RYDkEAeI5ZtNxFCrTdLI4HdVOphhvg6bRy2NCthMvOKYUwG57XuZHkGXwBXF4nw9Q8q2STIKARtPiWFDsCFl4qulDJlan4x/rn48iwVbmq+TJplqRDCoZI7cB1wJr2hGuD8oUJbvugnhp0xTQniP5/TOqJCIpYcupvb7DrWFfhfsdw/orrAVt4GMdZag+jvnCd9PNiJANj8+9UMdeqyWFdJPt++xjET+wdXNdDeiIoUtnEbjm4a4l9iyUXgRNeM2WYkgFsgVz37iZayDsUA6BINxgxRHZRRyxynkuejEeC3cmoK6qeXApr11iA/b8Q+A9BWNInrfwKw0c6y6Pr78h8iZ7/Wh6Og2mUYH4WEpzVmXEzxMtxx3wfLGTreI9sE/FqGkKk1iampSYor0HnvJmevTwnlvbdkBCb6IWqkJpXj5l+9AY1mAgP7r+hcSqRia1C4f8Rf70h1ZRnj9cYKsAtuwBZH42Nz1p7g1n91ev12Ir53g5tzrgQxf9Z0lF8rCYEo8kj5Zp1sV8yGoFt4k46e3PqbaLYfw9rdlR6DOV3Z/5Z6lzdIMvHg/rvdzbNxCEpmCG/WcTg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0bc395-f88c-476b-fb3c-08dc1951e357
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2024 00:51:07.6802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFPQXAiIaTmybhEQXFTaBM5RRvVr6r9+9vekyPp50wZMLzt9rDSITjQZFBns39TqA06VX7Pfk1iGLT1nu1wWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
X-Proofpoint-ORIG-GUID: e93acG0U5cgH9ZEGGLnPEKt1tYHfG3WZ
X-Proofpoint-GUID: e93acG0U5cgH9ZEGGLnPEKt1tYHfG3WZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401200005

T24gRnJpLCBKYW4gMTksIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBGcm9tOiBSYW4gV2FuZyA8
cmFuLndhbmdfMUBueHAuY29tPg0KPiANCj4gV2hlbiBEV0MzIGlzIHNldCB0byBob3N0IG1vZGUg
YnkgcHJvZ3JhbW1pbmcgcmVnaXN0ZXIgRFdDM19HQ1RMLCBWQlVTDQo+IChvciBpdHMgY29udHJv
bCBzaWduYWwpIHdpbGwgYmUgdHVybmVkIG9uIGltbWVkaWF0ZWx5IG9uIHJlbGF0ZWQgUm9vdCBI
dWINCj4gcG9ydHMuIFRoZW4sIHRoZSBWQlVTIGlzIHR1cm5lZCBvZmYgZm9yIGEgbGl0dGxlIHdo
aWxlKDE1dXMpIHdoZW4gZG8geGhjaQ0KPiByZXNldCAoY29uZHVjdGVkIGJ5IHhoY2kgZHJpdmVy
KSBhbmQgYmFjayB0byBub3JtYWwgZmluYWxseSwgd2UgY2FuDQo+IG9ic2VydmUgYSBuZWdhdGl2
ZSBnbGl0Y2ggb2YgcmVsYXRlZCBzaWduYWwgaGFwcGVuLg0KPiANCj4gVGhpcyBWQlVTIGdsaXRj
aCBtaWdodCBjYXVzZSBzb21lIFVTQiBkZXZpY2VzIGVudW1lcmF0aW9uIGZhaWwgaWYga2VybmVs
DQo+IGJvb3Qgd2l0aCB0aGVtIGNvbm5lY3RlZC4gU3VjaCBhcyBMUzEwMTJBRldSWS9MUzEwNDNB
UkRCL0xYMjE2MEFRRFMNCj4gL0xTMTA4OEFSREIgd2l0aCBLaW5nc3RvbiAxNkdCIFVTQjIuMC9L
aW5nc3RvbiBVU0IzLjAvSmV0Rmxhc2ggVHJhbnNjZW5kDQo+IDRHQiBVU0IyLjAgZHJpdmVzLiBU
aGUgZmFpbCBjYXNlcyBpbmNsdWRlIGVudW1lcmF0ZWQgYXMgZnVsbC1zcGVlZCBkZXZpY2UNCj4g
b3IgcmVwb3J0IHdyb25nIGRldmljZSBkZXNjcmlwdG9yLCBldGMuDQo+IA0KPiBPbmUgU1cgd29y
a2Fyb3VuZCB3aGljaCBjYW4gZml4IHRoaXMgaXMgYnkgcHJvZ3JhbWluZyBhbGwgeGhjaSBQT1JU
U0NbUFBdDQo+IHRvIDAgdG8gdHVybiBvZmYgVkJVUyBpbW1lZGlhdGVseSBhZnRlciBzZXR0aW5n
IGhvc3QgbW9kZSBpbiBEV0MzIGRyaXZlcg0KPiAocGVyIHNpZ25hbCBtZWFzdXJlbWVudCByZXN1
bHQsIGl0IHdpbGwgYmUgdG9vIGxhdGUgdG8gZG8gaXQgaW4NCj4geGhjaS1wbGF0LmMgb3IgeGhj
aS5jKS4gVGhlbiwgYWZ0ZXIgeGhjaSByZXNldCBjb21wbGV0ZSBpbiB4aGNpIGRyaXZlciwNCj4g
UE9SVFNDW1BQXXMnIHZhbHVlIHdpbGwgYmFjayB0byAxIGF1dG9tYXRpY2FsbHkgYW5kIFZCVVMg
b24gYXQgdGhhdCB0aW1lLA0KPiBubyBnbGl0Y2ggaGFwcGVuIGFuZCBub3JtYWwgZW51bWVyYXRp
b24gcHJvY2VzcyBoYXMgbm8gaW1wYWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFuIFdhbmcg
PHJhbi53YW5nXzFAbnhwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBldGVyIENoZW4gPHBldGVyLmNo
ZW5AbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
DQo+IC0tLQ0KPiANCj4gTm90ZXM6DQo+ICAgICBMYXN0IHJldmlldyBhdCBKdW5lIDA2LCAyMDE5
LiBGaXhlZCBhbGwgcmV2aWV3IGNvbW1lbnRzIGFuZCBzZW50IGFnYWluLg0KPiAgICAgDQo+ICAg
ICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgta2VybmVsL0FNNVBSMDQwMk1CMjg2NTk3OUUyNjAxN0JDNTkzN0RCQkE1RjExNzBAQU01UFIw
NDAyTUIyODY1LmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20vX187ISFBNEYyUjlHX3BnIWJkdXRK
V2kxVGN6OFNZc2NCN01yOTZTV1lNS0lvOEVsVUtnRUlMRkpmSzNfNjBFYkVDUUhYUEJtSllBTU1o
TndRNFlyanhxTVpXSGRva1hoSEI2YSQgDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
fCAgMiArKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAgMiArKw0KPiAgZHJpdmVycy91
c2IvZHdjMy9ob3N0LmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiBpbmRleCAzZTU1ODM4YzAwMDE0Li5hNTdhZGYwYzExZGQxIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBA
QCAtMTYyNiw2ICsxNjI2LDggQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3Yy0+ZGlzX3NwbGl0X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5
X3JlYWRfYm9vbChkZXYsDQo+ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJrIik7DQo+ICANCj4g
Kwlkd2MtPmhvc3RfdmJ1c19nbGl0Y2hlcyA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2
LCAic25wcyxob3N0LXZidXMtZ2xpdGNoZXMiKTsNCg0KVGhpcyBpcyBhIHF1aXJrLiBUaGUgcHJv
cGVydHkgc2hvdWxkIGJlIG5hbWVkIHdpdGggInF1aXJrIiBzdWJmaXguDQpCdXQgZG8gd2UgbmVl
ZCBhIG5ldyBxdWlyaz8gSG93IG1hbnkgZGlmZmVyZW50IHBsYXRmb3JtcyBhcmUgYWZmZWN0ZWQ/
DQpJZiBpdCdzIGp1c3QgMSBvciAyLCB0aGVuIGp1c3QgdXNlIGNvbXBhdGlibGUgc3RyaW5nLg0K
DQo+ICsNCj4gIAlkd2MtPmxwbV9ueWV0X3RocmVzaG9sZCA9IGxwbV9ueWV0X3RocmVzaG9sZDsN
Cj4gIAlkd2MtPnR4X2RlX2VtcGhhc2lzID0gdHhfZGVfZW1waGFzaXM7DQo+ICANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gaW5kZXggZTNlZWE5NjVlNTdiZi4uMDI2OWJhY2JiZjZiZCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4g
QEAgLTExMzUsNiArMTEzNSw3IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAg
ICogQGRpc19zcGxpdF9xdWlyazogc2V0IHRvIGRpc2FibGUgc3BsaXQgYm91bmRhcnkuDQo+ICAg
KiBAd2FrZXVwX2NvbmZpZ3VyZWQ6IHNldCBpZiB0aGUgZGV2aWNlIGlzIGNvbmZpZ3VyZWQgZm9y
IHJlbW90ZSB3YWtldXAuDQo+ICAgKiBAc3VzcGVuZGVkOiBzZXQgdG8gdHJhY2sgc3VzcGVuZCBl
dmVudCBkdWUgdG8gVTMvTDIuDQo+ICsgKiBAaG9zdF92YnVzX2dsaXRjaGVzOiBzZXQgdG8gYXZv
aWQgdmJ1cyBnbGl0Y2ggZHVyaW5nIHhoY2kgcmVzZXQuDQoNClRoaXMgaXMgb25seSBhcHBsaWNh
YmxlIHRvIHRoZSBmaXJzdCB4aGNpIHJlc2V0IGluIGl0cyBpbml0aWFsaXphdGlvbg0KYW5kIG5v
dCBldmVyeSB4aGNpIHJlc2V0IHJpZ2h0PyBJZiBzbywgcGxlYXNlIHJld29yZC4NCg0KQWxzbywg
cGxlYXNlIHBsYWNlIGl0IGNvcnJlc3BvbmQgdG8gdGhlIG9yZGVyIG9mIHRoZSBmaWVsZC4NCg0K
PiAgICogQGltb2RfaW50ZXJ2YWw6IHNldCB0aGUgaW50ZXJydXB0IG1vZGVyYXRpb24gaW50ZXJ2
YWwgaW4gMjUwbnMNCj4gICAqCQkJaW5jcmVtZW50cyBvciAwIHRvIGRpc2FibGUuDQo+ICAgKiBA
bWF4X2NmZ19lcHM6IGN1cnJlbnQgbWF4IG51bWJlciBvZiBJTiBlcHMgdXNlZCBhY3Jvc3MgYWxs
IFVTQiBjb25maWdzLg0KPiBAQCAtMTM1Myw2ICsxMzU0LDcgQEAgc3RydWN0IGR3YzMgew0KPiAg
CXVuc2lnbmVkCQl0eF9kZV9lbXBoYXNpczoyOw0KPiAgDQo+ICAJdW5zaWduZWQJCWRpc19tZXRh
c3RhYmlsaXR5X3F1aXJrOjE7DQo+ICsJdW5zaWduZWQJCWhvc3RfdmJ1c19nbGl0Y2hlczoxOw0K
PiAgDQo+ICAJdW5zaWduZWQJCWRpc19zcGxpdF9xdWlyazoxOw0KPiAgCXVuc2lnbmVkCQlhc3lu
Y19jYWxsYmFja3M6MTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIGIv
ZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gaW5kZXggNjFmNTdmZTViYjc4My4uYWY4OTAzZWUz
N2MyMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9ob3N0LmMNCj4gQEAgLTExLDYgKzExLDcgQEANCj4gICNpbmNsdWRlIDxs
aW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgDQo+
ICsjaW5jbHVkZSAiLi4vaG9zdC94aGNpLmgiDQoNCkxldCdzIG5vdCBpbXBvcnQgdGhlIGVudGly
ZSB4aGNpLmguIElmIHdlJ3JlIGdvaW5nIHRvIHNoYXJlIHNvbWUgbWFjcm9zDQpmcm9tIHhoY2ku
aCwgcGxlYXNlIHNwbGl0IHRoZW0gZnJvbSB4aGNpLmggYW5kIHBlcmhhcHMgY3JlYXRlDQp4aGNp
LXBvcnRzLmggZm9yIGR3YzMgdG8gc2hhcmUuDQoNCj4gICNpbmNsdWRlICJjb3JlLmgiDQo+ICAN
Cj4gIHN0YXRpYyB2b2lkIGR3YzNfaG9zdF9maWxsX3hoY2lfaXJxX3JlcyhzdHJ1Y3QgZHdjMyAq
ZHdjLA0KPiBAQCAtMjgsNiArMjksNDQgQEAgc3RhdGljIHZvaWQgZHdjM19ob3N0X2ZpbGxfeGhj
aV9pcnFfcmVzKHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJCWR3Yy0+eGhjaV9yZXNvdXJjZXNbMV0u
bmFtZSA9IG5hbWU7DQo+ICB9DQo+ICANCj4gKyNkZWZpbmUgWEhDSV9IQ1NQQVJBTVMxCQkweDQN
Cj4gKyNkZWZpbmUgWEhDSV9QT1JUU0NfQkFTRQkweDQwMA0KPiArDQo+ICsvKg0KPiArICogZHdj
M19wb3dlcl9vZmZfYWxsX3Jvb3RodWJfcG9ydHMgLSBQb3dlciBvZmYgYWxsIFJvb3QgaHViIHBv
cnRzDQo+ICsgKiBAZHdjMzogUG9pbnRlciB0byBvdXIgY29udHJvbGxlciBjb250ZXh0IHN0cnVj
dHVyZQ0KPiArICovDQo+ICtzdGF0aWMgdm9pZCBkd2MzX3Bvd2VyX29mZl9hbGxfcm9vdGh1Yl9w
b3J0cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCWludCBpLCBwb3J0X251bTsNCj4gKwl1
MzIgcmVnLCBvcF9yZWdzX2Jhc2UsIG9mZnNldDsNCj4gKwl2b2lkIF9faW9tZW0gKnhoY2lfcmVn
czsNCj4gKw0KPiArCS8qIHhoY2kgcmVncyBpcyBub3QgbWFwcGVkIHlldCwgZG8gaXQgdGVtcGVy
YXJ5IGhlcmUgKi8NCj4gKwlpZiAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5zdGFydCkgew0KPiAr
CQl4aGNpX3JlZ3MgPSBpb3JlbWFwKGR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQsDQo+ICsJ
CQkJRFdDM19YSENJX1JFR1NfRU5EKTsNCj4gKwkJaWYgKElTX0VSUih4aGNpX3JlZ3MpKSB7DQo+
ICsJCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiRmFpbGVkIHRvIGlvcmVtYXAgeGhjaV9yZWdzXG4iKTsN
Cj4gKwkJCXJldHVybjsNCj4gKwkJfQ0KPiArDQo+ICsJCW9wX3JlZ3NfYmFzZSA9IEhDX0xFTkdU
SChyZWFkbCh4aGNpX3JlZ3MpKTsNCj4gKwkJcmVnID0gcmVhZGwoeGhjaV9yZWdzICsgWEhDSV9I
Q1NQQVJBTVMxKTsNCj4gKwkJcG9ydF9udW0gPSBIQ1NfTUFYX1BPUlRTKHJlZyk7DQo+ICsNCj4g
KwkJZm9yIChpID0gMTsgaSA8PSBwb3J0X251bTsgaSsrKSB7DQo+ICsJCQlvZmZzZXQgPSBvcF9y
ZWdzX2Jhc2UgKyBYSENJX1BPUlRTQ19CQVNFICsgMHgxMCooaS0xKTsNCj4gKwkJCXJlZyA9IHJl
YWRsKHhoY2lfcmVncyArIG9mZnNldCk7DQo+ICsJCQlyZWcgJj0gflBPUlRfUE9XRVI7DQo+ICsJ
CQl3cml0ZWwocmVnLCB4aGNpX3JlZ3MgKyBvZmZzZXQpOw0KPiArCQl9DQo+ICsNCj4gKwkJaW91
bm1hcCh4aGNpX3JlZ3MpOw0KPiArCX0gZWxzZQ0KPiArCQlkZXZfZXJyKGR3Yy0+ZGV2LCAieGhj
aSBiYXNlIHJlZyBpbnZhbGlkXG4iKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX2hv
c3RfZ2V0X2lycShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCXN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UJKmR3YzNfcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkd2MtPmRldik7DQo+IEBAIC02
Niw2ICsxMDUsMTMgQEAgaW50IGR3YzNfaG9zdF9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJ
aW50CQkJcmV0LCBpcnE7DQo+ICAJaW50CQkJcHJvcF9pZHggPSAwOw0KPiAgDQo+ICsJLyoNCj4g
KwkgKiBXZSBoYXZlIHRvIHBvd2VyIG9mZiBhbGwgUm9vdCBodWIgcG9ydHMgaW1tZWRpYXRlbHkg
YWZ0ZXIgRFdDMyBzZXQNCj4gKwkgKiB0byBob3N0IG1vZGUgdG8gYXZvaWQgVkJVUyBnbGl0Y2gg
aGFwcGVuIHdoZW4geGhjaSBnZXQgcmVzZXQgbGF0ZXIuDQo+ICsJICovDQo+ICsJaWYgKGR3Yy0+
aG9zdF92YnVzX2dsaXRjaGVzKQ0KPiArCQlkd2MzX3Bvd2VyX29mZl9hbGxfcm9vdGh1Yl9wb3J0
cyhkd2MpOw0KPiArDQoNCkl0J3MgcGFydCBvZiB0aGUgZHdjM19ob3N0X2luaXQoKSwgYnV0IGRv
bid0IGRvIHRoaXMgaW4NCmR3YzNfaG9zdF9nZXRfaXJxKCkuIFBsYWNlIGl0IHdoZXJlIGl0IG1h
a2VzIHNlbnNlLg0KDQo+ICAJaXJxID0gZHdjM19ob3N0X2dldF9pcnEoZHdjKTsNCj4gIAlpZiAo
aXJxIDwgMCkNCj4gIAkJcmV0dXJuIGlycTsNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KUGxlYXNl
IHJ1biBjaGVja3BhdGNoLnBsIGFuZCBmaXggdGhlbSBuZXh0IHRpbWUuIFJlZ2FyZGluZw0KUEFS
RU5USEVTSVNfQUxJR05NRU5UIG9yIGxpbmUgY29udGludWF0aW9uLCBpdCBjYW4gYmUgdHdvIGlu
ZGVudGF0aW9ucw0Kb3IgcGFyZW50aGVzaXMgYWxpZ25lZCwgd2hpY2hldmVyIG9uZSBtYWtlcyBp
dCBlYXNpZXIgdG8gcmVhZC4NCg0KDQpGcm9tIGNoZWNrcGF0Y2g6DQoNCkNIRUNLOlBBUkVOVEhF
U0lTX0FMSUdOTUVOVDogQWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVudGhlc2lzDQoj
MTE5OiBGSUxFOiBkcml2ZXJzL3VzYi9kd2MzL2hvc3QuYzo0ODoNCisJCXhoY2lfcmVncyA9IGlv
cmVtYXAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5zdGFydCwNCisJCQkJRFdDM19YSENJX1JFR1Nf
RU5EKTsNCg0KQ0hFQ0s6U1BBQ0lORzogc3BhY2VzIHByZWZlcnJlZCBhcm91bmQgdGhhdCAnKicg
KGN0eDpWeFYpDQojMTMwOiBGSUxFOiBkcml2ZXJzL3VzYi9kd2MzL2hvc3QuYzo1OToNCisJCQlv
ZmZzZXQgPSBvcF9yZWdzX2Jhc2UgKyBYSENJX1BPUlRTQ19CQVNFICsgMHgxMCooaS0xKTsNCiAJ
CQkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCg0KQ0hF
Q0s6U1BBQ0lORzogc3BhY2VzIHByZWZlcnJlZCBhcm91bmQgdGhhdCAnLScgKGN0eDpWeFYpDQoj
MTMwOiBGSUxFOiBkcml2ZXJzL3VzYi9kd2MzL2hvc3QuYzo1OToNCisJCQlvZmZzZXQgPSBvcF9y
ZWdzX2Jhc2UgKyBYSENJX1BPUlRTQ19CQVNFICsgMHgxMCooaS0xKTsNCiAJCQkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCg0KQ0hFQ0s6QlJBQ0VT
OiBVbmJhbGFuY2VkIGJyYWNlcyBhcm91bmQgZWxzZSBzdGF0ZW1lbnQNCiMxMzc6IEZJTEU6IGRy
aXZlcnMvdXNiL2R3YzMvaG9zdC5jOjY2Og0KKwl9IGVsc2UNCg0KdG90YWw6IDAgZXJyb3JzLCAw
IHdhcm5pbmdzLCA0IGNoZWNrcywgODYgbGluZXMgY2hlY2tlZA0KDQoNClRoYW5rcywNClRoaW5o

