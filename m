Return-Path: <linux-kernel+bounces-10083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E2E81CFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344261C22C91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49571EB47;
	Fri, 22 Dec 2023 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qJUPwiEf";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UIGnCdo6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kyN/Z+fk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C01EB31;
	Fri, 22 Dec 2023 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4kMH011079;
	Fri, 22 Dec 2023 14:31:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=oHikxW0ZSDj7IDmXKHSHuIuK264/z4eC+klHKnzXi3M=; b=
	qJUPwiEfhei/GV1B2zxy8GxVEyVRxGgcu0FBgZvgcnOWMj6YU0GiX+cSdKW3scnV
	9r2lsSAZv/0rysUhkfO7nbry1RZP0s+RLPLGBx1VQj+NVgyUXDCCZ7XTFai/9Qx+
	Xe0gZzKlWpNwn9sMvbgV9C+99xfH65tmTYpw1DDJ78mVoaoGd85WPhQjN+kyXeOS
	P0kbTe20P8Xij1FwMs8UmEYDHj/TXLHftWVnq9w5DkYy3QlE4EnY/jiorkLJKHqK
	hp3m8GZbQ1drtkW96Sg4goYvRNnbTIhxZjKHibyWVlk40ueirqI0nXrlMOM9KBJR
	eFirWf4133BLhBMrH28A7Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpw8f24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703284316; bh=oHikxW0ZSDj7IDmXKHSHuIuK264/z4eC+klHKnzXi3M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UIGnCdo64llDEMQxLaAM6leG93+E150TGtIJ+eHbNO5+Z5mwigTontQno8YqvLQcA
	 fq+85vsIKgfnrcor/2wp5k3sjoj/qneEAsebI4b+Andf0hW6wOzJGTWVWd9m3cZkmk
	 QZMeznG7lyxl7h0PHAbpPN/95N3MlXT/vhrrkcA0a/AZiNnONfvuiAOKnkoqr10hzo
	 QOEBLqPXKsNtugUpUSxgYjd+QeZMEKBXKRY67020a8i//RnY2dqlFMFbd7VzoEJ6Il
	 y75K8VSrbM5N7/STapD26766bReD4Pj/tHcm184f3fBqwTd/H3DStBjxY8x7/sVjHt
	 qGPs3bDPdNYug==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8132403B9;
	Fri, 22 Dec 2023 22:31:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8714DA005F;
	Fri, 22 Dec 2023 22:31:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kyN/Z+fk;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 504354052A;
	Fri, 22 Dec 2023 22:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti7CXL46gvUvWIny2B5NV/SLBxOX0XVJViLS0PEcCWp/uz64k6aKfsSoeLqXQ+TMo7vLWz1XZFotW+iuIb8tXl1Htsl19qXln8HefueGModAMbkQmAIBjQUWBhzjxzAu6xLUKXu1eTEIV+QCKdkN9qwe97RqLnbOplCFGKcGDW4x4Y4PZW57S3S3GrSc1c722nD0wa99P5Of+n+DkIf4HUjGHqQ4096bLIcVVejeYl4Z0DJrVeXIH/25cC+0xUFYSFXDrF/QfKWwuNx0RKvwx2b2EzrKUu/1a6IkfbGMLDaOBKcF9asxPFXhuPu5X2J/uM+/ubUQXUnxLEwHliTQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHikxW0ZSDj7IDmXKHSHuIuK264/z4eC+klHKnzXi3M=;
 b=j6In2XSozPKjhqllPekqrPE4Et1ixx0e2xB96KHX0KOcVlFRAUv2rRaMLuiFp/5Uwpg2Ouh4UiHrlCXWhoDYOJCwHtc63Qwa/M09Yc5aN3JueTyAgZUUoSrr+9ZdIjWyaTTQXwo2A9HHmTu5eg96kS93Jsz4pWfrXa33/sWwDv6r1109eVtoh1VY0EL3K9CxDQzx50yfF1iSqllnitX/ZixI01Cddx3nFeWnQxv/xG18+8kikpkh0QmBJXw9puBmCa/TtZu9hq+EkBJTxm2rncGDaNh11li+wd52xYtTBzL5XCMmMYk8e0h150piAAh0PSbW0m5wSEi0czoh49MkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHikxW0ZSDj7IDmXKHSHuIuK264/z4eC+klHKnzXi3M=;
 b=kyN/Z+fkr2MDutgDEqXs1wChee3PPtsCLpP8xT3vpNYRfRwkVDQAUywqPhPQhwc/HMht4g8E/WJlb/puK87KvYeepRrbsQZikDlvue6RecL27re94dr3oWTphvFd4rjoEySfUWzD6/CshyjAlk7majO08raHN5w6Z7GfZrsOqgk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:31:50 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:31:50 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v3] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Topic: [PATCH v3] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Index: AQHaMjIgGlmCk37XhU+Ode2AoN0Z0rC16OKA
Date: Fri, 22 Dec 2023 22:31:50 +0000
Message-ID: <20231222223143.kbbni2uqwf4nt3yi@synopsys.com>
References: <20231219041559.15789-1-quic_kriskura@quicinc.com>
In-Reply-To: <20231219041559.15789-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB6909:EE_
x-ms-office365-filtering-correlation-id: 6d2446f4-5fe4-444c-9ed2-08dc033dca70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BB896RPcJAVb18MheBDkGtb0zagIGQbzVDFnTqpdzfOA8wIYabagca1P8hgssRjsV7elgJAI8eKjcjnuVgzX5A1hvB0RagVzKKIBrHP948FFgrzWzUzzdyNrLOdd/SPG70eLpkMCJL7lOCxXsqtRnU/4MFR56Tm5Y2SJOIQ3r5Ukaq6F56g+YcFJPOFHg4XroKtHk4KoT1CTBqeo7l2LOLcBwMwS+ISdfRtT0+tXGxllXY+YxPYl+Bnphhh9YkInqKwqad8HJaRo8qUgQpqD0ud0DMO9+Am0aUbx4O2aoL0iYL6tQ13C5HfRO+k3oYAgzmOb6aXvbcvl+voHYRkINNEeCkCuaY2r09mzUM0U+SFwC+7LrYl+vOWSaG3uRyyfXW+3DZF9P4h1DlgFKlaRyO+276qcY3++hHsBwDKxDwpiEpaEfOVjPHBX2ngS7lsSNMwptQBEdSjzj04i5dAi4gAHR81DoCWV8NdJ5IlPma4UIRLpY0vWLrCV70UOEJbpsmNEEW0o02J+7WCbU5H4PSlMHxH4j5cGOZkDhMZhkVszhQc/a9Ud4vReBeb3E7D+yJeQhl5KtoPOrHpotAX6Zfzr5m8Pos7j5Al9NBgfF5s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(4326008)(8936002)(5660300002)(2906002)(478600001)(6506007)(6512007)(316002)(66946007)(6916009)(66446008)(54906003)(66476007)(64756008)(6486002)(66556008)(76116006)(966005)(41300700001)(122000001)(38070700009)(83380400001)(38100700002)(26005)(36756003)(1076003)(71200400001)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWNRcjkyYzVxckNhYU4vOEQycU5xMlNGRnpJYmttY3ZZd2xsMFllV1VtUGUz?=
 =?utf-8?B?MFE3NDJyZWszMFdYYWxMZ1g1UU02TmdHYlRyMm8wK3VHeE1WL01lOTFMTHYr?=
 =?utf-8?B?djB0NVNTUTh2VDhmRnRKQVdqRndpVGNVc0M5ay9VQjlMa2VnNHRtUEQ4WDRC?=
 =?utf-8?B?d0FQSWxTeXBQZEtCNUpMWlRaSDR1Qnlwb2tDVk9VZk1KSHlSVzFLcWVWVXl3?=
 =?utf-8?B?T2ZlVEg5YXZMbEpNNU5BcWlQLzNKY2NLZytYdTFWdUl3L2JieW9VZGEyVVkz?=
 =?utf-8?B?ZXlaUHNCVWxDME5PdkZBY0tla25tM2tndHhDTTlBWDFFSDlnOUliSUdzeWpk?=
 =?utf-8?B?RTZ5Vms4YXZVN3BBN1VnRmpkcVNkNnpCUVl0NVhEVnErUEk4alltTFphaExC?=
 =?utf-8?B?NDc2RFNDc0hrcmVDaUF0UENNVnRVMnl6K0NydVR3aEE0WnVMQnQvWFpoZURH?=
 =?utf-8?B?cEFieTBmUzZFVHdBcEhETy9LdVNzQnpna0lvd3ZpazFjanN6blpKS3g1cURq?=
 =?utf-8?B?WHc3WXJ5VDFuLytFeFlGTldnUUhLbFRGU0xWWlRYRlM0OS90V2pXR1dqekc2?=
 =?utf-8?B?RFRVTS9YcmRZaGtVRDBqTVgvVWEwV2hrd3RJUHpoblhHSXJkRjUzRUdQSDRv?=
 =?utf-8?B?T0g3TjJjZGxlaUVJV3RKVHIxV09ZVkVjV1VaaDdUVStpZVA2dWxRczhIQVY0?=
 =?utf-8?B?Yi9tais5WkZIajVVSWR1MUIrSnVNMEJUZGdENGNBaWRseTI0SnpjeVdjSzZY?=
 =?utf-8?B?MW1EejJZNzBjZDBneDlISHQ0ZzIyMTVEdmEyTVgvR2hCZllnL1VBZVZqOCtW?=
 =?utf-8?B?ZWJZTFBsa3grK1JwM0FZcmp5OGJTam1TQ1RCV0p5TEpOTjBKdFFZZzFiV2pT?=
 =?utf-8?B?d1lMditLUkNWR1lreHlmNUo5TmlHRmJTQ25jRjY0RUFmRytVQSsrT3lqQmp5?=
 =?utf-8?B?OUx0UmJITElwSWk0VHZmRDkrVTBOZjFyNEx6OU5tdHJhRmlsUjB5K2ZSdjZI?=
 =?utf-8?B?WEkrTlVqUWNmSjN3NGF5RUplUDZXcXZIYTYyNjVMVHZ0VlZ0Yk5qNS9QOS9Z?=
 =?utf-8?B?b0dWQXZ5dGVSM0s1eVIwbjd2OFNXcTBlVlFPZ0QycGRlTm5BSHprcnR1L3Vm?=
 =?utf-8?B?ZHdzZEVIK01IVFNqbHd4YTNLS2tRT3YxUHBZRDFPTWpNL0h0OFFWQ2Y2NjBa?=
 =?utf-8?B?R2xoSG9wUWFpRHVZUGJwRDVYMUdBdmYwZkpqVGRaZERobWhrMTNSVURXay80?=
 =?utf-8?B?NnhUQWc0Q1J1cUxBMzRRV3oxdWlWOCtBaU8zVlh2WFkxTUhjN3lNYndMU0V0?=
 =?utf-8?B?Q2ptaHl2a1VzQVVBSStoRVBoTGswbkUwNlVHYUZHZDkrL3AwZ2NRVXpwQlFq?=
 =?utf-8?B?WlNTb01tVlRoeHZRWm1QMmVmV3pNbkNvUlVTUGJ0VkhFajRPa0dmc3BkSlpv?=
 =?utf-8?B?OE51OFhTRHNmMXZsN25jSGNnaWF5d05JSW9Ic0xkQ3VtMVJSVUlhNUduTUNo?=
 =?utf-8?B?VDFVMkZLQi9neHBtRkRFaVo4MFBUby9Rem1yUE9vc0FnWS9TazZDbEhFejZH?=
 =?utf-8?B?dlVnYUZJNjF6RllLNW5TM09IR0JaSUQveFdEUHNITGRjMVNMRnlEaHJaUEFD?=
 =?utf-8?B?Q1pJWGl4MjlBeVE5SDh5WERON09Kd3dYZHRlbkFOUzdmemJ2ellvMndHWTNV?=
 =?utf-8?B?TXc3ZGJEOWVBMTdjWjV0UjI5ZW9scDN4STVHOXlzNlFOMXFiMDhocEkxaFZ4?=
 =?utf-8?B?SCtYZ21GNzJ0MDhZQ3hxd2JvL1pZenFvaFNoQ2N6aVAyVXV6OW5uRUFMTkZP?=
 =?utf-8?B?VWV2MXBJaU1ZeU5va1RBeTRkLzdLQ2U3NTB6Zm02ZzZpRnZZVitZd04rYWph?=
 =?utf-8?B?Mk1ERHFCMi9hc1pOcGtmNWI3ZEkrdTNESUxaNElObDFMbmVGYUJsVWh6UVRQ?=
 =?utf-8?B?b0lnTU1IWk5EL09kVlZHQ0p5RU1pbnVvN0JSUXVQRGltRklwQnY5d1MrY1g3?=
 =?utf-8?B?QXdqc3B0RVI0d2dudmdtNWJ2Mjk1NXd6WVMvZjFob0RUaHhiQ0cwY3BveEQv?=
 =?utf-8?B?eEk4NEpCaitWaGdxZEtNRzZ3UHptUVJNcmZOa2dyN0xBL1RpYmh5RzF6R3Bz?=
 =?utf-8?Q?GVkFCQSUDJ/Ae55AnuJnZv4uP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97E4A934CE882940A86455FA3CC9FAF2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mIEbKY1Jir0gChOm/bnV+RWwGK8LJ83D6+XBrIbETd95TtJYoUohDnTp4KiQK+jbqaaG6V52BkQbRGZV0XjmM5i5QNDoQFP82fgMoLceqIBckg7sP8ygBeH9VFlUM093B8SkkRKm96ye79IfWnXLnSr71nVERhtv9LZRiMvkhZp0UYsbbNZfIupzRBYcOo9pRfjwK0Mz+W32NZG9hJCN0rkVZVu4wDoFAIgrwHm8TXjXZFI0NPpO3j9BmCnroeJqlVjP8QieSeeVWlockkJWxwpV9VY8uxTh6EZta15XgSn35a7XjB+oqLoSX973aGl6mAwr5UMxr2nd6o5lyrtBGj9/a8BmEKK695quRq8fJBxSlN0RvkE6XBF0CoBacZCjewaHYZTw/G1LCE5a0rtYarAG/zqJRVN86uvEXiCmTloS7B+kDjyWGDZdE0N7Us2i3vQARFm6CjsR4xT9DR27d3lF99k3FdGKNsXg+HhAnNn4Q6XfcmTeZEXkuOxGzkHa+qsJPo+5pwgC2cM8NnCyd/Gl1Zom7FIECblwCc2DgFF9Ke2DNKM8ZXPeJt0/g6BXsLGOLDhYSXFAryxkR8Hp8HFWtndSE8TvOHLPVIyErQcvNPHtPMmArIwhvxY/8VTNW+qkUqE6oKv7u+Sb2jlPrA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2446f4-5fe4-444c-9ed2-08dc033dca70
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:31:50.3976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR5Pie1FfklW+zCHXKnGQU7wMGWRgCg50FzWxljQQ7MWA9S4dOoyEnWQ6wm2Dj3njpSycGQez13CD/Y+w7RyBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
X-Proofpoint-GUID: 6XHYLkP-vIbeR4RatJWrmAy8LNOqhSZh
X-Proofpoint-ORIG-GUID: 6XHYLkP-vIbeR4RatJWrmAy8LNOqhSZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220166

T24gVHVlLCBEZWMgMTksIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBmb3IgZHdjM191c2IzMSBjb250cm9sbGVyLCBpZiBtYXhpbXVtX3NwZWVkIGlzIGxpbWl0ZWQg
dG8NCj4gc3VwZXItc3BlZWQgaW4gRFQsIHRoZW4gZGV2aWNlIG1vZGUgaXMgbGltaXRlZCB0byBT
UywgYnV0IGhvc3QgbW9kZQ0KPiBzdGlsbCB3b3JrcyBpbiBTU1AuDQo+IA0KPiBUaGUgZG9jdW1l
bnRhdGlvbiBmb3IgbWF4LXNwZWVkIHByb3BlcnR5IGlzIGFzIGZvbGxvd3M6DQo+IA0KPiAiVGVs
bHMgVVNCIGNvbnRyb2xsZXJzIHdlIHdhbnQgdG8gd29yayB1cCB0byBhIGNlcnRhaW4gc3BlZWQu
DQo+IEluY2FzZSAgdGhpcyBpc24ndCBwYXNzZWQgdmlhIERULCBVU0IgY29udHJvbGxlcnMgc2hv
dWxkIGRlZmF1bHQgdG8NCj4gdGhlaXIgbWF4aW11bSBIVyBjYXBhYmlsaXR5LiINCj4gDQo+IEl0
IGRvZXNuJ3Qgc3BlY2lmeSB0aGF0IHRoZSBwcm9wZXJ0eSBpcyBvbmx5IGZvciBkZXZpY2UgbW9k
ZS4NCj4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIG5lZWQgdG8gbGltaXQgdGhlIGhvc3QncyBt
YXhpbXVtIHNwZWVkIHRvDQo+IFN1cGVyU3BlZWQgb25seS4gVXNlIHRoaXMgcHJvcGVydHkgZm9y
IGhvc3QgbW9kZSB0byBjb250cmFpbiBob3N0J3MNCj4gc3BlZWQgdG8gU3VwZXJTcGVlZC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2lu
Yy5jb20+DQo+IC0tLQ0KPiBMaW5rIHRvIHYyOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwNTE0MTQ1MTE4LjIwOTczLTEtcXVpY19r
cmlza3VyYUBxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGchZDhPc0FyTmVLWXJRcURHODlNLUxo
LTFfYzd6SU1acDB4MUNYNlhfbV9EMm1hSEVBM1FNM3FpUVYtZzRtcGIxMlpPUFQ2RjhELUVTdUN3
SHhNMjZwZUhxZTVqdElrUSQgDQo+IExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA1MTIxNzAxMDcuMTg4MjEtMS1x
dWljX2tyaXNrdXJhQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFkOE9zQXJOZUtZclFxREc4
OU0tTGgtMV9jN3pJTVpwMHgxQ1g2WF9tX0QybWFIRUEzUU0zcWlRVi1nNG1wYjEyWk9QVDZGOEQt
RVN1Q3dIeE0yNnBlSG9TV2xMRGF3JCANCj4gDQo+IERpc2N1c3Npb24gcmVnYXJkaW5nIHRoZSBz
YW1lIGF0Og0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL2U0NjVjNjljLTNhOWQtY2JkYi1kNDRlLTk2Yjk5Y2ZhMWE5MkBxdWljaW5jLmNv
bS9fXzshIUE0RjJSOUdfcGchZDhPc0FyTmVLWXJRcURHODlNLUxoLTFfYzd6SU1acDB4MUNYNlhf
bV9EMm1hSEVBM1FNM3FpUVYtZzRtcGIxMlpPUFQ2RjhELUVTdUN3SHhNMjZwZUhxZHlTMlpNUSQg
DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxMiArKysrKysrKysrKysNCj4g
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDUgKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggYjEwMWRiZjhjNWRjLi4wNTZi
YTk1ZDkyOTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xMzY3LDYgKzEzNjcsMTggQEAgc3RhdGlj
IGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICAJZHdjM19jb25m
aWdfdGhyZXNob2xkKGR3Yyk7DQo+ICANCj4gKwkvKg0KPiArCSAqIE1vZGlmeSB0aGlzIGZvciBh
bGwgc3VwcG9ydGVkIFN1cGVyIFNwZWVkIHBvcnRzIHdoZW4NCj4gKwkgKiBtdWx0aXBvcnQgc3Vw
cG9ydCBpcyBhZGRlZC4NCj4gKwkgKi8NCj4gKwlpZiAoaHdfbW9kZSAhPSBEV0MzX0dIV1BBUkFN
UzBfTU9ERV9HQURHRVQgJiYNCj4gKwkgICAgKERXQzNfSVBfSVMoRFdDMzEpKSAmJg0KDQo+ICsJ
ICAgIGR3Yy0+bWF4aW11bV9zcGVlZCA9PSBVU0JfU1BFRURfU1VQRVIpIHsNCj4gKwkJcmVnID0g
ZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfTExVQ1RMKTsNCj4gKwkJcmVnIHw9IERXQzNfTExV
Q1RMX0ZPUkNFX0dFTjE7DQo+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19MTFVDVEws
IHJlZyk7DQo+ICsJfQ0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gIGVycl9wb3dlcl9vZmZf
cGh5Og0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlZmU2Y2FmNGQwZTguLmUxMjA2MTFhNTE3NCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gQEAgLTE3Miw2ICsxNzIsOCBAQA0KPiAgI2RlZmluZSBEV0MzX09FVlRFTgkJ
MHhjYzBDDQo+ICAjZGVmaW5lIERXQzNfT1NUUwkJMHhjYzEwDQo+ICANCj4gKyNkZWZpbmUgRFdD
M19MTFVDVEwJCTB4ZDAyNA0KPiArDQo+ICAvKiBCaXQgZmllbGRzICovDQo+ICANCj4gIC8qIEds
b2JhbCBTb0MgQnVzIENvbmZpZ3VyYXRpb24gSU5DUnggUmVnaXN0ZXIgMCAqLw0KPiBAQCAtNjU3
LDYgKzY1OSw5IEBADQo+ICAjZGVmaW5lIERXQzNfT1NUU19WQlVTVkxECQlCSVQoMSkNCj4gICNk
ZWZpbmUgRFdDM19PU1RTX0NPTklEU1RTCQlCSVQoMCkNCj4gIA0KPiArLyogRm9yY2UgR2VuMSBz
cGVlZCBvbiBHZW4yIGxpbmsgKi8NCj4gKyNkZWZpbmUgRFdDM19MTFVDVExfRk9SQ0VfR0VOMQkJ
QklUKDEwKQ0KPiArDQo+ICAvKiBTdHJ1Y3R1cmVzICovDQo+ICANCj4gIHN0cnVjdCBkd2MzX3Ry
YjsNCj4gLS0gDQo+IDIuNDIuMA0KPiANCg0KSSBiZWxpZXZlIHlvdSBjYW4gYWxzbyBsb29wIHRo
cm91Z2ggYW5kIGFwcGx5IHRvIGFsbCAxNiBvZmZzZXRzIG9mDQpyZWdpc3RlciBMTFVDVEwgd2l0
aG91dCBhZmZlY3RpbmcgdGhlIGNvbnRyb2xsZXIuIFJlZ2FyZGxlc3Mgd2hldGhlciB5b3UNCndp
bGwgYXBwbHkgdGhhdCBmb3IgdjIgb3Iga2VlcCB0aGlzIHZlcnNpb246DQoNCkFja2VkLWJ5OiBU
aGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

