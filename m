Return-Path: <linux-kernel+bounces-157792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8088B1641
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D01C22CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE6216E861;
	Wed, 24 Apr 2024 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jTv2tc+y";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SYZakbzw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vti4Fhhj"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CC2263E;
	Wed, 24 Apr 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998205; cv=fail; b=SRlnvwrTcuR0VMDzLWJSSH5RyXsf3ZvPehMD5nKzo3BUybrVJjmLVQmm8QvWsP90VDt9nXErXeeh8buWQpaPelTzq2F9n3jaULwYgBPhZiuNlnpCyma44FN3zMg6H1cuL1BbxaYIPk8x6DvDvIUvADM+O1r2HjqVwqxyLMhQgKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998205; c=relaxed/simple;
	bh=NCXDiApv20mwMUWDeiiBzbt3P+0e07bnqftdVS+3ToQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLqLja7R1nMu7pOdqLiDWcUm0nIaUV16eWDxBOcbQZ4d3davke4WY+MmvL2qXqoxGF26IPso3JCzMUWjsnWRYElFR4CVOZIrB4u7Tzf7BED4AUVDAay9DWKmwjtEct0tN1FGcyb+XCYdVdRSPGUxv8EOqEs4+cK+sV3vmXE6u9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jTv2tc+y; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SYZakbzw; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vti4Fhhj reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OKF16n018832;
	Wed, 24 Apr 2024 15:36:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=NCXDiApv20mwMUWDeiiBzbt3P+0e07bnqftdVS+3ToQ=; b=
	jTv2tc+yPpt/fZDLM/bNIOX8/YfpcsaWRwR+rFxGRYZEPyML+pnJ9EH4AK9DwYq5
	Wt5/VbTn7rWGwol0SJSG+qX6HhfKMtkM0zVO3WMcJWBSCkl4rkICZPHbOoIznmWK
	08p5ZXqxy+dMfv07KiORGR7orkJwL0nVwqQozAmRhx9VIW0Qcn0St5ypAau4B6f5
	1dC3QecmSQRcs19ybnltsx+MOc3GoUzN9SiBOuQJuNMlDBXrYCE+vMRLHsS2m5Tn
	v8uE0gZyfUMWdTJ9wnHoBmyBlnH80pcxEKcbwMXUmou3x5TLtHikzWv2QSodIx6p
	hhn1mru+gwQni3ZI9u7lxw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6yewtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713998199; bh=NCXDiApv20mwMUWDeiiBzbt3P+0e07bnqftdVS+3ToQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=SYZakbzwWABVjAF2GBtqbk5wO3Z6+MarMaG+JIq6TWME6q+m31usE4YlcRytj23q9
	 p2Ffxf0NgkAvp5kMcVrFOLJA/dVExGpAtyBGyaBvyGMEjFyTW7+ofEG5X4y7Etd9oY
	 iZzjv7ZN75d2B2CHOIBcg/ByaE5NwKHKy6NicX0EutQkA7C3UAz4qg4k24s7ByOxYV
	 UvwAiAj440OCa4h89A25JswEFml1RsYll90DVGmf0V3YpRpQSE74W5wbDI6UI9t2YD
	 4E4F3OJCHUVvU/T79iDeKgQbaDdHPONrubWVanGFeWcxNbGCYrNl+InL/7QcGh6g8J
	 Lg55MKhbpRjxA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0571C4035D;
	Wed, 24 Apr 2024 22:36:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 90BD4A0077;
	Wed, 24 Apr 2024 22:36:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=vti4Fhhj;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0EB8C40522;
	Wed, 24 Apr 2024 22:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtEAb/NqShx6v7G9PmnWDD4iNB3JmMbO1CjS64sTvRGhkezWxUnpRC0qCo1XW4ZPD++SvV6FVv76Jtp+b/tLM048b/8GvUyXBOXZsFsVXHtvo0a2L20F4UDVwf71RmbBhgsFFyIJl8XDlHQe6FPeNIzAu8P8KMFwOCQX2xfhY7UA8uzPcy11hzhyNr5CbF8RTJhgXDuuMKk01vgWh2MjuVtJZGe+5eexZXuD0RRyTwr+DqW/os/9l0oGzh+x7gk6verOROLGftkLMNOeng1VgU51StQrPl6gj/xX4gEAU6jReCMyLnGhQioRIZ5N4hDC1d/7EmNvbqkMHysdfZBqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCXDiApv20mwMUWDeiiBzbt3P+0e07bnqftdVS+3ToQ=;
 b=RO2jppQ3ssPBMGACO4s2dBdXzOShx2E6awl9Ivpab7tYXEDXMIOu3N5JWo3kS+iE/hjNKHevW09We8WYdc33cHeiugXlRigFF0W27kp8sQ7I8ySgBmlRcX9Jc/Wu0hriavHcdsY64o9h2aMNamjC68CIXi/8WjpXeFF9OcwnlLmQlgI8ZSJzdmLwoWMdEwrs2RI1s+IBFUFhC0q5cCxS+yB4afNY4FkFC1r2f2kKOS4DYuljHag2k0DTY+Gqq8GtZlNlCVrnFzNlRV/ooscHHt1tH3KIhcR95yohXHe0z1k/xXsF0kV1CdUgRDv7T6hXcxSg1B0I8kv3pVELTu0Lsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCXDiApv20mwMUWDeiiBzbt3P+0e07bnqftdVS+3ToQ=;
 b=vti4Fhhjm/wDyT2zSQrP7lNlK1CzREgz4VMEFiPyKXe8spdNHTJGHnDgIsYNG41axtnGgIrJw/Ik+5nBnL3eFlWb4fBiUwZqvVzOT+AMKeBY93GsvCvvy/+znJsRall+PVmkQfW3+BqmxYjc/++rLECVqVyRNe9LU9WN/Itjxt4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 22:36:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 22:36:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc3: Poll CMDACT after issuing EndXfer command
Thread-Topic: [RFC PATCH] usb: dwc3: Poll CMDACT after issuing EndXfer command
Thread-Index: AQHalJRPHyu5Rgz0VUSI068GgFefBrF2pbgAgAB4WwCAAOhpAA==
Date: Wed, 24 Apr 2024 22:36:32 +0000
Message-ID: <20240424223618.utauunrz7nud5wfi@synopsys.com>
References: <20240422090539.3986723-1-quic_prashk@quicinc.com>
 <20240424013342.5itkoewx7jdonyk4@synopsys.com>
 <168904cd-4806-0473-085d-43df45efba65@quicinc.com>
In-Reply-To: <168904cd-4806-0473-085d-43df45efba65@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB7560:EE_
x-ms-office365-filtering-correlation-id: 4384db65-3a16-40ee-55fe-08dc64aefdc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TkFuREFBdzVGVUJjSFB2RXdVY1o3ZE1IbEJLMHRLSGRVdHh6UnFTQ283RDBi?=
 =?utf-8?B?MUM1QWJFZVBUeGs4akdzSnF6MVEvUDNaUjdXRXJrcDB0WXRRSmJpYXZIbUNn?=
 =?utf-8?B?ZjFUT1U5V1pRR3pNUi9Ec1ZOZDJaVTl1SHZIa2QxalVaUVFydUY4WjhDNGI3?=
 =?utf-8?B?WnErKzFiSGhzYzBFMWlYTTM1cVFVSU85dW0vTkN4S1dvS3ZyL0Q3MktqRjFk?=
 =?utf-8?B?THF6WTMrOUxkNlcwdHdzbno0bXBsNUtUTG1wZlljN3BQSGI5bDZEWmJSME81?=
 =?utf-8?B?VTE0QlJrSHpUY2VQL1ZFRFIvWHNjVXRnWDM0dFFsVkZEL1BDS0dERlBlbllM?=
 =?utf-8?B?eFpVOVBJZ3V2Uk9zYURMTkZLdmt4Mk0vKzlWN1R0UHdINjhlMnR5WlI0alNu?=
 =?utf-8?B?Mm5LSitOUkNkVlpmTkUyemJRMERDcTYrK2o5bUE4SU9rR05COVNkWFlVYVVZ?=
 =?utf-8?B?RmdkdkRPWW9BVThneU5lUGtsek53UXFXS1pReENqdk5BaTU3dW5CQ280QlFZ?=
 =?utf-8?B?Q2hHMFU4SE5saG1WQWpNSm9TY0N1TGJJM3VveUdDenVzbjdKU0o3WTJMYytO?=
 =?utf-8?B?UFV4OHMxSnFhSXcvUjlBTHBPUCtjbWJQcmc4Y1dKOVl3TExkd2pMTnd2TmZp?=
 =?utf-8?B?VXZ2RS9BRVJPT0RWSVR0RFJWRHZDNW5lTDV5R0svY2dCL1hXRXZWWmd5WkZn?=
 =?utf-8?B?UVR0RE1rRW1xRkRQbGpkd1VrVU5yVWNUYWJNUVk4QmgvRjNhbHVnc09OU0ZX?=
 =?utf-8?B?cmF0M2gvREhHZEVZM05QYUp3UHhoSm9TQUNNUXNQNU45MTFsdUpPcVQ5YUNS?=
 =?utf-8?B?SFNLYStrd1phLzEwQ3F5OXFhZ25UUnluNTNUUFVFVEJ1VFRLS1NmVnErU1B1?=
 =?utf-8?B?Q3YvRE5JVTc1VnRPck43cGU0MXVrYm8rbW5XSitDZ2JPYmpuNGdPYTdXVWM5?=
 =?utf-8?B?WW01ZmZWT2NDWGR2TEhIVTQwNWhIaXp0QTQxSkxtY0I0WUlhUC9HdVlFVHU3?=
 =?utf-8?B?R3h6RjNFZ2JFZ1UvOWUyakNQNFp4QWJsMTBya2ZaZU1DRUNEVHlsTWxUS2VF?=
 =?utf-8?B?akJ5RUlOUTZkTFVkNlJzamdhVEprWUJYYThKUDFxUjczL3V6SU5pOFlIQmtJ?=
 =?utf-8?B?SDZtMURIWGJVN0JrRmZxZjAzWDRob2ZCSC9UU2MrMTFFZFB1UXNLTWNheGkw?=
 =?utf-8?B?eVlpWjBOZm0vc2NaUFVZTC9IU3hyRnRWZCtlMDJDVG9yRDlZMzlCaWszeWsw?=
 =?utf-8?B?S1plcUdzUVNNMjJwa1ZPNDlBSkxvTVJ3Z0pSTk90YTlGU3htY3I0emtDK1BO?=
 =?utf-8?B?c0RxbjM5R0pWN1NqdVFuMjNYM2N4d283aUNLZ0FVMnd0MmNlRG1BVVNvL1hZ?=
 =?utf-8?B?QVBFSklOVkZGeDAxMmJsVDZxbmpwNDNUZkdGSVE4K3ZHMlRBOHFZcThmenpP?=
 =?utf-8?B?dzl4ZUJZQVdYdFkvRFdDc3R2cGtydTJqdFdlK2hVZXp6TThpWGRnWTdFWm1m?=
 =?utf-8?B?dGdKZVNQaXBZVFgvR3k0ekRTeTVxaHdjcnNPOU5ONU1QQVFwV051b21aaUVj?=
 =?utf-8?B?bzFLbEpQeEZaaXF1UWh6OFpWRHRmSXVXdkx1MUxqblV3YVBKQkw4K05Eanc4?=
 =?utf-8?B?QXk4L2FDREJnbjJybGRXOG9TZENjcnA5OUUxbTg3TmNJZFE3MnIvcWRsSEcx?=
 =?utf-8?B?bnAyVnJRRmMwUHErYnhNdDlzbXVBeEJ3VGtldU9QNUI5MU81TXVFSEg2dmc5?=
 =?utf-8?B?TkRoQ2JVZGlFZ3VDSTJpNW9ZVkx2b1FHSFVvdC9nVlFjeVlwVTduS1hycUUy?=
 =?utf-8?B?LzEycFhJSFM2aG9yZk5YZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZnBJVStxRkc0SG5FSWFEc1VlSzFPQU5vVjBOa0l3VnY5WVU4U01zbGIvRzlQ?=
 =?utf-8?B?aHFrV1pwK3ZqdVEyNncxMGZVUEdRQWFvcFdIQTIrdnVDSGtzRHdNejA5Uktz?=
 =?utf-8?B?ZEtoekZ3RjFRNWlHNlIzU05sSmpNSjMvZ2V2SFk5Y1U2Y1BQRndJZjltZUVV?=
 =?utf-8?B?U3VacDVGaGRPS0U3K2Z3TnJsMjlmUkpVR0VYbUxDT09CYlJ4b3JyZ01WOHpr?=
 =?utf-8?B?ZWc4aG9rZWlubEk2dVpHUFh2UlVEUXd0MkZVYUUrT0t4QzdFU05wZmI2ODdl?=
 =?utf-8?B?dkJxdjZ2VUE4b3Rad3cvU04wTkIzRmltVFNjRVUzVmFLUSt5ME1hdGlTdHZk?=
 =?utf-8?B?STNxelVTUnZLaWNvU1drQml6a3l0c05IVU0wL3lsL1M0T0I3YTYyQ2pNQlFv?=
 =?utf-8?B?ZmdadGVHYklucXlRYkt5bnVGc0lJZ2FUZmluQmh5NzdTNXVHY1MrazNjbDZB?=
 =?utf-8?B?MlR1UFZHSmhWSm5uK0N4eWtGVGNPRmQ0K2RjVXJZbjZXcElxU1ZkUGZIUFZE?=
 =?utf-8?B?ZUJHL3JROVEyZmd1bzcwb3hqMjVOelRnNHNRVExJdiszRGkwSzN3UEJXY0FK?=
 =?utf-8?B?TjVKK04zcWV3ZEwyaElQa0dQZjByaTc1UEJ0TUdYa2lXSzNFeThBekhxVHdw?=
 =?utf-8?B?TXJOanJZblpsS2REcHplaG5NOHIxSFBRdDZVT01YTnZrMFhXbjdoUjNjSlk2?=
 =?utf-8?B?bzV6YU1mem1rTFRqVkEzSktHWFhHMU5VSm50dFV0dUNqTzlac3g3aHJEWTJG?=
 =?utf-8?B?NW9VbERmV0ZqRjJqZ3F5NGV4SnJCZzltRXh3Qk0vU1NSMk4ySzFIV3h6eDN6?=
 =?utf-8?B?R1lpOTdnU054MHdxZzh6MUR4eWV3MlRhQ3Fob2pDRE5GdzM0bjU2Vm4rVHFq?=
 =?utf-8?B?TVVOZ0Q5VUdraHdnejV6VjUyRWF3ZmpSR0QyeGxjbmIyRlVZNXBiU3pNU1F2?=
 =?utf-8?B?bzZTcDIrVG0yME5TVzRlWFVNMGNqQk9qeWQ4cDdyNEFnR3dKWERDTUZXT1ZT?=
 =?utf-8?B?RHhJQW04QjdYQ1J6TjljcjVOb3JVREp6MEVjdUc1c3htczA4MXphVG9HdW1O?=
 =?utf-8?B?Wjg2M3AzTEVYR1VGb1czeEw5czRqUWx3UGRCaS9QdGx0dXphcitROEZLcWpD?=
 =?utf-8?B?SDBaU0xxemRwYXY3bHl5eGltSDZPTis2Y3V2Q3dYOFd6NFMzU0EyT3NGZUcw?=
 =?utf-8?B?TGpvSnNYano5YVhiUW5uRHp3aEFaVmd4bVd2SU9qT0xQbmJlZkxGendVK3pn?=
 =?utf-8?B?R0kxT203REU2a0N3eGR0dkFsMUppck1JTEpidkZkRFN2blNHOEZMZDdtTU9R?=
 =?utf-8?B?ZHc2K1JGRkl1MmU3YmlZUFhtQkxia3QwOEJhSmdOSUFtVHRUQmNNM2w5dVJL?=
 =?utf-8?B?Ty8ydE95QnlobzdWWXlyNGFJRi9UbFEwZ2Y1L0NnYlE4LzI4bHkxZ3dtYnVs?=
 =?utf-8?B?WlB4WWZBK1ZOYnN2c1BVeEtvb0l1RzZxaDN2UHFMbEhTWkRzVVQxSVJsbGZ5?=
 =?utf-8?B?QlJJaFJTZ2xJMGxTVU93L3dxU3dQVXJlczg2TFpIVmRnU25BUENDZVhzVTly?=
 =?utf-8?B?Q2ZpK0xEQ3o1ZWdzcWh0dmgrWkFTM3hCOHNoRUtnSHhzNThhcnZmT0Jqa1py?=
 =?utf-8?B?bmVxQjhkeUxEWGFaU3lFYmxnUjE0VVdXRWJ5TVpIZTZGWnBBWUtPRnEvWDBi?=
 =?utf-8?B?T0lGcUNVNUVVdWFMR3lhdWxQZjBPbjFGMW5WeWYycWNVNm5EdWFQcUU1ZVJQ?=
 =?utf-8?B?WEJrcXBHVS9qWWdyVjZ6K29pRnNKMGFiUFYzTDBGUE5xN3FkTDZucThVZjZB?=
 =?utf-8?B?OXpucFUvbC9LY0hsNGN0UUU2eU1CTWlDMC9kcXYyR2dNQVhpL0w4ZUorVk5h?=
 =?utf-8?B?N0FQUWFYUUpQZjVFTDdDVmlFUDBML2xOaEpDc05ORThHRE9neVpyQzJyUFF2?=
 =?utf-8?B?amoxZ1ltRjUwQ2ErVnVESzNLQmdOL01iYUp3RkRpWXh2M2s2R01UNnFzZnJZ?=
 =?utf-8?B?TmNVaGlmOStkQnB3UUUzQjhNV0ZYdFVWcGg2elczaEZtRU9waVh3Uy96Ti9J?=
 =?utf-8?B?eW9Da0U1bXhjQzBkZ01rbEloYkwxTUZxaTBScEkybVpLdUplNEJrMVVDNlJW?=
 =?utf-8?B?cEtXSVJwSzVRQk95OWcxcVRTWUFSWnhreUs5VVhaMmw2TVR3VDA5b1UyTDRi?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A3EC8875788524E80B8D63624B4B134@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9qHdgkQ0obsCmB0IUGvx+BjFLGyG6xcjqouOmJWhXYfXY9Hvr0f8BrScg3Bt+8dn8U2UNZMohpT5Rdfhj4XuMjY1zWa5LDSCJI4hDtwtGEWCcSEeI7mQfJ/OaXq1oE3y0A/PFleQs6NufRvxSC2D7JMgYgzlFSXON9gAicWkALfbJB8PNx/Nu35YDIiHU+9TFmCzVMNxZJzyPJ/t5v7kVRYApoX4xqjMZNkxI9Isx7VpGf8xpfT5aCWMrmhw7aVcFJw3h7UUb2yDnGHgeBG64WAQOURz0Ft2lhh1jvCpw1/f7/Sp0St8607H+evhnoNSt5+1d5Ma+9F2hofKWJP2G3v+7xB+s+Nt7EG61MIuoCJzI1UdpIE1Ap6Q95aTLJKuVhmoz/N0wpa10UfiMUQ8O0QicHlhOBYXpiQa8hgWSP2m/NDWWCwhMX82UqiK8IMa3djTThaDaSh6k6I6627UpWgEerFihIuThXS57sADae11TbgqMj7XYeR0Smle7D/NwVFuN+P5gWzFO5LLOQdymmOdXQFh/mPOnawCQ+Lbx260zgQTYsufpFeCB1wM8rlIvpWCQwuLx7REGIEUH6aPVpGpCclXFrf/QCfsF5olkppIjC1GDP7PxNay7GKiEU16g1kO++QZcVc5zn1uz+Tbig==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4384db65-3a16-40ee-55fe-08dc64aefdc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 22:36:32.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVYyas4+gXb7HVYf7GCI2cS2g03AN783+rdT6NVTUHF5zmNX/iEIrjBfx4ewwA3FfM0BL6MNSd3MbU1vHn7g6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
X-Proofpoint-GUID: 7_6g7l0pQcdAo6fiLViBb-SwqnvvNeGP
X-Proofpoint-ORIG-GUID: 7_6g7l0pQcdAo6fiLViBb-SwqnvvNeGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=947 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240116

SGkgUHJhc2hhbnRoLA0KDQpPbiBXZWQsIEFwciAyNCwgMjAyNCwgUHJhc2hhbnRoIEsgd3JvdGU6
DQo+IE9uIDI0LTA0LTI0IDA3OjAzIGFtLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gTW9u
LCBBcHIgMjIsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiA+ID4gKwkJCSAqIHRoZSBEV0Mz
IGNvbnRyb2xsZXIgKFRoaXMgaXMgZW5hYmxlZCBieSBzZXR0aW5nIEdVQ1RMMlsxNF0pDQo+ID4g
DQo+ID4gRGlkIHdlIGNoZWNrIHRvIGtub3cgdGhhdCB3ZSBzZXQgR1VDVEwyLlJzdF9hY3RiaXRs
YXRlciB0byBzdGFydA0KPiA+IHBvbGxpbmcgZm9yIENNREFDVD8NCj4gR1VDVEwyWzE0XSBpcyBz
ZXQgb25seSBmb3IgRFdDM191c2IzIGNvbnRyb2xsZXJzIHByaW9yIHRvIHZlcnNpb24gMzEwYSwN
Cj4gYmVjYXVzZSB0aGUgcmVnaXN0ZXIgaXMgbm90IGF2YWlsYWJsZSBmb3Igb3RoZXIgdmVyc2lv
bnMvcmV2aXNpb25zLg0KPiANCj4gZHdjMy9jb3JlLmMgLSBkd2MzX2NvcmVfaW5pdCgpDQo+IAkv
Kg0KPiAJICogRU5EWEZFUiBwb2xsaW5nIGlzIGF2YWlsYWJsZSBvbiB2ZXJzaW9uIDMuMTBhIGFu
ZCBsYXRlciBvZg0KPiAJICogdGhlIERXQ191c2IzIGNvbnRyb2xsZXIuIEl0IGlzIE5PVCBhdmFp
bGFibGUgaW4gdGhlDQo+IAkgKiBEV0NfdXNiMzEgY29udHJvbGxlci4NCj4gCSAqLw0KPiAJaWYg
KERXQzNfVkVSX0lTX1dJVEhJTihEV0MzLCAzMTBBLCBBTlkpKSB7DQo+IAkJcmVnID0gZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VDVEwyKTsNCj4gCQlyZWcgfD0gRFdDM19HVUNUTDJfUlNU
X0FDVEJJVExBVEVSOw0KPiAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUNUTDIsIHJl
Zyk7DQo+IAl9DQo+IA0KPiBIZW5jZSB0aGUgd2UgaGF2ZSBhZGRlZCB0aGUgQ01EQUNUIHBvbGxp
bmcgaW4gZWxzZSBjYXNlIG9mIHRoZSBmb2xsb3dpbmcNCj4gY2hlY2sgaW4gX19kd2MzX3N0b3Bf
YWN0aXZlX3RyYW5zZmVyKCkuDQo+IA0KPiBpZiAoIURXQzNfSVBfSVMoRFdDMykgfHwgRFdDM19W
RVJfSVNfUFJJT1IoRFdDMywgMzEwQSkpDQo+IA0KPiA+IA0KPiA+ID4gKwkJCSAqLw0KPiA+ID4g
KwkJCWRvIHsNCj4gPiA+ICsJCQkJcmVnID0gZHdjM19yZWFkbChkZXAtPnJlZ3MsIERXQzNfREVQ
Q01EKTsNCj4gPiA+ICsJCQkJaWYgKCEocmVnICYgRFdDM19ERVBDTURfQ01EQUNUKSkNCj4gPiA+
ICsJCQkJCWJyZWFrOw0KPiA+ID4gKwkJCQl1ZGVsYXkoMik7DQo+ID4gDQo+ID4gdWRlbGF5IG9m
IDIgaXMgcmVhbGx5IHNtYWxsLiBUcnkgYXQgbGVhc3QgMjAwdXMuDQo+IEFncmVlZCwgV2lsbCBt
YWtlIGl0IDIwMHVzIHdpdGggNSByZXRyaWVzLiBJJ20gbm90IHJlYWxseSBzdXJlIGhvdyBtYW55
DQo+IHJldHJpZXMgd2UgbmVlZCBoZXJlLiBJIGp1c3QgbWFkZSB0aGUgYWdncmVnYXRlIHRvIDFt
cyBzaW5jZSB3ZSB1c2UgMW1zDQo+IGRlbGF5IGZvciBvdGhlciByZXZpc2lvbnMuDQo+ID4gDQo+
ID4gPiArCQkJfSB3aGlsZSAoLS1yZXRyaWVzKTsNCj4gPiA+ICsNCj4gPiA+ICsJCQlpZiAoIXJl
dHJpZXMgJiYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQX1BIQVNFKSkgew0KPiA+ID4gKwkJ
CQlkZXAtPmZsYWdzIHw9IERXQzNfRVBfREVMQVlfU1RPUDsNCj4gPiA+ICsJCQkJcmV0dXJuIC1F
VElNRURPVVQ7DQo+ID4gPiArCQkJfQ0KPiA+ID4gKwkJfQ0KPiA+ID4gKw0KPiA+ID4gICAJCWRl
cC0+ZmxhZ3MgJj0gfkRXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRDsNCj4gPiA+ICAgCX0gZWxzZSBp
ZiAoIXJldCkgew0KPiA+ID4gICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9FTkRfVFJBTlNGRVJf
UEVORElORzsNCj4gPiA+IC0tIA0KPiA+ID4gMi4yNS4xDQo+ID4gPiANCj4gPiANCj4gPiBEaWQg
eW91IG9ic2VydmUgaXNzdWVzIHdpdGggRFdDX3VzYjMxPyBIb3cgbXVjaCBsb25nZXIgZGlkIHlv
dXIgc2V0dXANCj4gPiBuZWVkIHRvIGNvbXBsZXRlIEVuZCBUcmFuc2ZlciBjb21tYW5kPw0KPiA+
IA0KPiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgd2UgYXJlIGltbWVkaWF0ZWx5IHVubWFwcGlu
ZyB0aGUgcmVxdWVzdCBhZnRlcg0KPiBpc3N1aW5nIHRoZSBFTkRYRVIsIHdlIGFyZW4ndCB3YWl0
aW5nIGZvciB0aGUgY29tcGxldGlvbiB1bmxpa2Ugb3RoZXINCj4gY29tbWFuZHMuDQo+IA0KPiA5
MC44NzI2Mjg6ICAgIGRiZ19zZW5kX2VwX2NtZDogZXAxaW46IGNtZCAnRW5kIFRyYW5zZmVyJyBb
MzBjMDhdIHBhcmFtcw0KPiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBV
TktOT1dODQo+IDkwLjg3MjY1MjogICAgZGJnX2VwX3F1ZXVlOiBlcDFpbjogcmVxIDkzN2JjNzVj
IGxlbmd0aCAwLzEwNjkgenNJID09PiAtMTA4DQo+IA0KPiBGcm9tIHRoZSBhYm92ZSB0cmFjZXMs
IHdlIGNhbiB3ZSBzZWUgdGhhdCB0aGUgdGltZSBnYXAgYmV0d2VlbiBzZW5kX2VwX2NtZA0KPiBh
bmQgZGVxdWV1ZS91bm1hcCBpcyAyNHVzLCB3aGljaCBpcyBwcmV0dHkgc21hbGwuDQo+IEFuZCBp
bW1lZGlhdGVseSB3ZSBnb3QgYW4gc21tdSBmYXVsdCAoc2luY2UgRU5EWEZFUiBkaWRuJ3QgY29t
cGxldGUgaW4gdGhpcw0KPiAyNHVzIHRpbWUtZnJhbWUpLiBJIGR1bXBlZCB0aGUgRFdDMyByZWdz
IGFuZCBzYXcgdGhhdCBjbWRhY3Qgd2FzIG5vdCBjbGVhcmVkDQo+IGZvciBlcDFpbiB3aGljaCBt
ZWFucyB0aGUgY21kIG5ldmVyIGdvdCBjb21wbGV0ZWQuDQo+IA0KPiA5MC44NzMzNjA6ICAgIFtE
RVBDTUQoMyk6IDB4YzgzYwkweDAwMDMwQzA4XQ0KPiAtLT4gQ01EQUNUIChiaXQxMCkgc3RpbGwg
c2V0Lg0KPiANCj4gPiBJIHdvdWxkIHByZWZlciBhIHNvbHV0aW9uIHRoYXQgYXBwbGllcyBmb3Ig
YWxsIElQcy4gRG8geW91IG9ic2VydmUgYW55DQo+ID4gaW1wYWN0IHNob3VsZCB3ZSBpbmNyZWFz
ZSB0aGUgbWRlbGF5KCk/IEkgZG9uJ3QgZXhwZWN0IG11Y2ggaW1wYWN0IHNpbmNlDQo+ID4gdGhp
cyBzaG91bGQgb25seSBoYXBwZW4gZHVyaW5nIGVuZHBvaW50IGRpc2JsaW5nLCB3aGljaCBpcyBu
b3QgYSBjb21tb24NCj4gPiBvcGVyYXRpb24uDQo+ID4gDQo+IEkgY2hlY2tlZCB0aGUgZm9sbG93
aW5nIGNvbW1lbnRzIGluIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoKSwgc2luY2Ugd2UNCj4g
ZG9uJ3QgdXNlIElPQyBmb3IgRU5EWEZFUiwgd2UgYXJlIHVzZSBDTURBQ1QgcG9sbGluZyBvbiBy
ZXZpc2lvbnMgd2hpY2gNCj4gc3VwcG9ydHMgaXQsIG90aGVyIHJldmlzaW9ucyB1c2VzIGRlbGF5
IG9mIDFtcyBpbnN0ZWFkLg0KPiANCj4gQnV0IGN1cnJlbnRseSBmb3IgRFdDM191c2IzID49IDMx
MGEsIHdlIGRvbid0IHBvbGwgY21kYWN0IChldmVuIHRob3VnaCBpdA0KPiBzdXBwb3J0cyBpdCkg
bm9yIHdlIHdhaXQgMW1zIGZvciBjb21tYW5kIGNvbXBsZXRpb24uIEZvciBtZSB3YWl0aW5nIDFt
cyB3YXMNCj4gYWxzbyBoZWxwaW5nLCBidXQgdGhhdCBkb2Vzbid0IGd1YXJhbnRlZSB0aGUgIGNv
bW1hbmQgY29tcGxldGlvbiB0aG91Z2ggKHdlDQo+IGp1c3QgYXNzdW1lIHRoYXQgaXQgZ2V0cyBj
b21wbGV0ZWQgYnkgdGhhdCB0aW1lKS4NCj4gDQo+IAkgKiBBcyBvZiBJUCB2ZXJzaW9uIDMuMTBh
IG9mIHRoZSBEV0NfdXNiMyBJUCwgdGhlIGNvbnRyb2xsZXINCj4gCSAqIHN1cHBvcnRzIGEgbW9k
ZSB0byB3b3JrIGFyb3VuZCB0aGUgYWJvdmUgbGltaXRhdGlvbi4gVGhlDQo+IAkgKiBzb2Z0d2Fy
ZSBjYW4gcG9sbCB0aGUgQ01EQUNUIGJpdCBpbiB0aGUgREVQQ01EIHJlZ2lzdGVyDQo+IAkgKiBh
ZnRlciBpc3N1aW5nIGEgRW5kVHJhbnNmZXIgY29tbWFuZC4gVGhpcyBtb2RlIGlzIGVuYWJsZWQN
Cj4gCSAqIGJ5IHdyaXRpbmcgR1VDVEwyWzE0XS4gVGhpcyBwb2xsaW5nIGlzIGFscmVhZHkgZG9u
ZSBpbiB0aGUNCj4gCSAqIGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKCkgZnVuY3Rpb24gc28gaWYg
dGhlIG1vZGUgaXMNCj4gCSAqIGVuYWJsZWQsIHRoZSBFbmRUcmFuc2ZlciBjb21tYW5kIHdpbGwg
aGF2ZSBjb21wbGV0ZWQgdXBvbg0KPiAJICogcmV0dXJuaW5nIGZyb20gdGhpcyBmdW5jdGlvbi4N
Cj4gCSAqDQo+IAkgKiBUaGlzIG1vZGUgaXMgTk9UIGF2YWlsYWJsZSBvbiB0aGUgRFdDX3VzYjMx
IElQLiAgSW4gdGhpcw0KPiAJICogY2FzZSwgaWYgdGhlIElPQyBiaXQgaXMgbm90IHNldCwgdGhl
biBkZWxheSBieSAxbXMNCj4gCSAqIGFmdGVyIGlzc3VpbmcgdGhlIEVuZFRyYW5zZmVyIGNvbW1h
bmQuICBUaGlzIGFsbG93cyBmb3IgdGhlDQo+IAkgKiBjb250cm9sbGVyIHRvIGhhbmRsZSB0aGUg
Y29tbWFuZCBjb21wbGV0ZWx5IGJlZm9yZSBEV0MzDQo+IAkgKiByZW1vdmUgcmVxdWVzdHMgYXR0
ZW1wdHMgdG8gdW5tYXAgVVNCIHJlcXVlc3QgYnVmZmVycy4NCj4gDQo+IEJ1dCBhbnl3YXlzIEkg
Y29uZHVjdGVkIGEgc21hbGwgZXhwZXJpbWVudCB0byBjYWxjdWxhdGUgdGhlIEVORFhGRVIgY21k
DQo+IGNvbXBsZXRpb24sIGFkZGVkIHRyYWNlcyBiZWZvcmUgd3JpdGluZyB0byBERVBDTUQgYW5k
IGltbWVkaWF0ZWx5IHBvbGxlZCBmb3INCj4gdGhlIENNREFDVCB0byBnZXQgY2xlYXJlZC4gT2Jz
ZXJ2ZWQgdGhhdCBpdCB0YWtlcyAxMC0xNXVzIG9uIGF2ZXJhZ2UNCj4gKGNoZWNrZWQgb24gRFdD
M19SRVZJU0lPTl8zMTBBKSwgYnV0IHRoZXNlIGFyZSB0aGUgYmVzdCBjYXNlIHNjZW5hcmlvcy4N
Cj4gDQo+IDE5MS42MjMwMTY6IGR3YzNfd3JpdGVsOiBhZGRyIHh4IG9mZnNldCAwMDBjIHZhbHVl
IDAwMDQwYzA4IC0gd3JpdGUgdG8NCj4gREVQQ01EDQo+IDE5MS42MjMwMjc6IGR3YzNfcmVhZGw6
IGFkZHIgeHggb2Zmc2V0IDAwMGMgdmFsdWUgMDAwNDA4MDggLS0gQ01BQ1QgY2xlYXJlZA0KPiAx
OTEuNjIzMDc2OiBkd2MzX2dhZGdldF9lcF9jbWQ6IGVwMm91dDogY21kICdFbmQgVHJhbnNmZXIn
IFs0MGMwOF0gcGFyYW1zDQo+IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6
IFN1Y2Nlc3NmdWwNCj4gLg0KPiAxOTEuNjIzNDI1OiBkd2MzX3dyaXRlbDogYWRkciB4eCBvZmZz
ZXQgMDAwYyB2YWx1ZSAwMDA3MGMwOA0KPiAxOTEuNjIzNDM2OiBkd2MzX3JlYWRsOiBhZGRyIHh4
IG9mZnNldCAwMDBjIHZhbHVlIDAwMDcwODA4DQo+IDE5MS42MjM0ODM6IGR3YzNfZ2FkZ2V0X2Vw
X2NtZDogZXAzaW46IGNtZCAnRW5kIFRyYW5zZmVyJyBbNzBjMDhdIHBhcmFtcw0KPiAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+IA0KDQpUaGFua3Mg
Zm9yIHRoZSBkYXRhLg0KDQpPaywgSSByZW1lbWJlciBub3cgd2h5IHdlIGRpZCB3aGF0IHdlIGRp
ZC4gSSBqdXN0IG5vdGljZSB0aGUgRml4ZXMNCmNvbW1pdCB5b3UgdGFnOiBiMzUzZWI2ZGMyODUg
KCJ1c2I6IGR3YzM6IGdhZGdldDogU2tpcCB3YWl0aW5nIGZvcg0KQ01EQUNUIGNsZWFyZWQgZHVy
aW5nIGVuZHhmZXIiKQ0KDQpJIGZvcmdvdCB0aGF0IGF0IG9uZSBwb2ludCB3ZSBza2lwIENNREFD
VCBmb3IgRW5kIFRyYW5zZmVyIGNvbW1hbmQuDQpMZXQncyBub3QgcG9sbCBmb3IgQ01EQUNUIGZv
ciBFbmQgVHJhbnNmZXIgY29tbWFuZCBhbmQgdW5jb25kaXRpb25hbGx5DQp3YWl0IDFtcy4gT3Ro
ZXJ3aXNlIHdlIG1heSBydW4gaW50byB0aGUgaXNzdWUgYmVpbmcgc3R1Y2sgd2l0aCBDTURBQ1QN
CmFnYWluIHdoaWxlIFNFVFVQIHBhY2tldCBpcyBub3QgRE1BIG91dCBhZ2Fpbi4gMW1zIHNob3Vs
ZCBiZSBwbGVudHkgb2YNCnRpbWUgZm9yIHRoZSBFbmQgVHJhbnNmZXIgY29tbWFuZCB0byBjb21w
bGV0ZS4NCg0KSXQgc2hvdWxkIGxvb2sgbGlrZSB0aGlzOg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4IGY5
NGY2OGYxZTdkMi4uZGFkMzBjNmFiMTlkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTE3MjQsOCArMTcy
NCw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2Mz
X2VwICpkZXAsIGJvb2wgZm9yY2UsIGJvb2wgaW50DQogICAgICAgIGRlcC0+cmVzb3VyY2VfaW5k
ZXggPSAwOw0KIA0KICAgICAgICBpZiAoIWludGVycnVwdCkgew0KLSAgICAgICAgICAgICAgIGlm
ICghRFdDM19JUF9JUyhEV0MzKSB8fCBEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAzMTBBKSkNCi0g
ICAgICAgICAgICAgICAgICAgICAgIG1kZWxheSgxKTsNCisgICAgICAgICAgICAgICBtZGVsYXko
MSk7DQogICAgICAgICAgICAgICAgZGVwLT5mbGFncyAmPSB+RFdDM19FUF9UUkFOU0ZFUl9TVEFS
VEVEOw0KICAgICAgICB9IGVsc2UgaWYgKCFyZXQpIHsNCiAgICAgICAgICAgICAgICBkZXAtPmZs
YWdzIHw9IERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkc7DQoNClRoYW5rcywNClRoaW5oDQoN
ClBzLiBhbHNvIHBsZWFzZSBDYyBzdGFibGUu

