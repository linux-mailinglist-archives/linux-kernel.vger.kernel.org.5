Return-Path: <linux-kernel+bounces-154693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94A18ADFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803DD283C44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC945EE78;
	Tue, 23 Apr 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="yF9q8C6F";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="fn5oDqYw"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85955C3C;
	Tue, 23 Apr 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861124; cv=fail; b=qnHqJrKuEP4ew8BU2LeJybQWm75pHtJzV5DU/z4gJLsDUxUxZ4nCM+6rMYrNCWOj0lmAIVBKkMfUTgJ4DewkKzbjVhbLyLk8cMexJfDlCsgSUBipEk0zQEqQw33ObcbZLFWrXoY9McZBmno5UeUhH/jPvo0yUY2y+eH9WEy5pBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861124; c=relaxed/simple;
	bh=plfHtmcVm0dDZKgnxWE0km2OViWojsLeZqL8BmKN6rI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jTxCXlUdFjydNpDGXuqT6YjavamMQh27+9Xg/iIfCj/TKk4C2s1JDRD8xCCudvmnnF9PmByqJ1e+ejWGMOKgVP/JQYLnm0ZAeW3D8VOg8QfNsPh/tgjOmSnR0NMHEsOfvpN+X/bCd7VhPLhRh0Y1Y5nM76FDK5Lk6hrzis0cEVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=yF9q8C6F; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=fn5oDqYw; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N7obvj022877;
	Tue, 23 Apr 2024 09:31:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=dk201812; bh=2jX6S2Jmtbftu32V500UF
	q3k1R7UV0EnOLOSCxdrgoQ=; b=yF9q8C6FRlRmaGuJIy5RWem04hqPGlh2sZSM0
	2sYitFb2WOeTIQ7RTbQgA5b7VPIJbU1MtgtB6maXfyW4YOsXG2/fHoIpbm2JAmQk
	IYP9L9trJE9ajipknjxd/n+CYeyh2XbxGQfBHFLQYkJ9l7yZWD8ibI9b9D8P2Ymu
	9vL0Xci7inUnx3KrQNc+Tr4DrrzRcodALyfCPcuf4wEaGnNvWBYFA6Rl3N4dtdmo
	fzaXZ5WLd82DNBswbqL7O/5I7SwO1oSxaN1FGPTlybcTuaTOWy/EppVTJ12u0T5s
	/3QDX0unXAjn695fcKNocKzgNLEioxy48vtX0P/TkC0UFtkHw==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 3xm3ynkbx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 Apr 2024 09:31:28 +0100 (BST)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 23 Apr 2024 09:31:27 +0100
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (104.47.85.104)
 by email.imgtec.com (10.100.10.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Tue, 23 Apr 2024 09:31:27 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBfuASqX1UjvwlDjZGkMw0VmeMBJRkWsAMMX9GaE8xauYuDyUD69ksYF5fFEVmkp5LRsnY1zE6S7paXJT6jBWhxgG+Flt/mJ95nDp4A1iJwbbQnuibDoD+FhXUFGYXkC928t6MV+vyWumz5iNYdnt86WzdoIjjlUEmf0deg9xOAjIPLziJOO+cyegYT1+u1MiY4FQm/VpOqyM8dBcgqkGkbcE6Ip+CONBfVDO2goxgzdZYWPSd+6+Ggt9GPzoGLsJ/Z2Audodw81H1B2gIxYznpa7Z2P8qFAXxVmz5lfpL6leRhXMR1PDvnMPQ9KRIUfi19pbEP9f9/iEiOTvV8tjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jX6S2Jmtbftu32V500UFq3k1R7UV0EnOLOSCxdrgoQ=;
 b=inNNScx0iUnYNlaRJYJeRPV8XUiqOi+k1+kEVOIo5bjue4ydg+rPYO7Nvt+i4KLrD+ZnrYmoTJVi/R8CZst4QYN6ntUCntuR7G3sOfVjeaaUGJzRLSsASOfpbDDrSZwJ/iKF2s6ZrYwvxHitvfG+VHhLRCFmP1Md35uXcQxZINQPKU+WdfOWoDB4oRYoAP/eGYID/hb/JtidBvsvDkSGwD3jDcPX2qCui4dKNu7P3Y5D8bjN9ERuaBj18kvxkrW41HPAp7cHBAnWHexeI3tNpK9DeSSQAGvcSAFlaWwRwVRNM0g/yrcEW36OjnNHvuv/Ib3fag2zEZDx8LZzH41mpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jX6S2Jmtbftu32V500UFq3k1R7UV0EnOLOSCxdrgoQ=;
 b=fn5oDqYwsxPurnL12yqw7xspgP0lAnwlF7/xiKTNZWaKPU8YqlYfVoLxLp4XFjibI7gNszDEqnyuilpD1BcCy41pRvyg5IM+axGPn2+pLySK4nddSrwDfcwqzdI5ts23Cq4y5yAdlKBuwkjFehUdzRgOP7bm1e2VuKnrptQiwDk=
Received: from CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e7::8) by
 LOYP265MB1839.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 08:31:26 +0000
Received: from CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8e9d:6b2f:9881:1e15]) by CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8e9d:6b2f:9881:1e15%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:31:26 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
CC: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Frank
 Binns" <Frank.Binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chun-Kuang Hu
	<chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Matthias
 Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] gpu: Convert to platform remove callback returning
 void
Thread-Topic: [PATCH 0/4] gpu: Convert to platform remove callback returning
 void
Thread-Index: AQHalVihfkdKJ3jFHUSYCeIzJWQcvQ==
Date: Tue, 23 Apr 2024 08:31:26 +0000
Message-ID: <614f6fa5-a2e4-4077-a5bc-4a1fffb9c30b@imgtec.com>
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
 <xqwcrxfrg3ogplh35c5etl6nbzw6zueilm4h6euh7bnpszyir4@6dtn5qdvijv3>
In-Reply-To: <xqwcrxfrg3ogplh35c5etl6nbzw6zueilm4h6euh7bnpszyir4@6dtn5qdvijv3>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB3397:EE_|LOYP265MB1839:EE_
x-ms-office365-filtering-correlation-id: bf370ddf-5bcc-467b-9707-08dc636fc425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?UmtBUXZRSTh4VkFXNnNsendQN005UytOeitRWi95SkdlWEtsVklMNC8yVm9K?=
 =?utf-8?B?ZitWby85UUtNNjJwZHVmZW9MK3NIZ01nOTJPZ0IwcXRsY0pnNnhXOEhVM1hi?=
 =?utf-8?B?alB2dE4zZ3haWk53SFl4emRSL3pxV0lHYXNwMWNrNWFuanhxNm9Jb25lWndT?=
 =?utf-8?B?aGdNdDBnVmRwVHNveThzbXdDckRiaktqMGVSWHZyeDFxaStQUDRKaGhaSGhH?=
 =?utf-8?B?Z2lmUVdyeld5MWhOaW85Y29JM1Y1REIxbWFEdEdpLytHdG9nS3dXa2x4S2Vw?=
 =?utf-8?B?WURIT3pQM2NveTFCWm4vbXd1czZIQ2g4eHg2SGJRV21vQnk3aFBPU2M0amho?=
 =?utf-8?B?a1ROTU1xQmx3V0QzSmU1L2dHL1V5SmtVUHh4ZUtiUDc5dlBNYjdrNUpiTHVI?=
 =?utf-8?B?WXdKK2VIM3ZjUTZnY1hmNEpsMWNKeTlIamFjVUJUUzdsbTZ0VnVVaklsOXhi?=
 =?utf-8?B?blVvdmhuRnBkRnhRWnFpMnR5UTArM1RsaHZZbE0veG4wT2puejlnUy9yMUZN?=
 =?utf-8?B?amNmVDJhbHQ2MkxtSzRRMjRmaWdUSmxXVExYaHpSRTM5b2x5ZS9FbTAxYjZn?=
 =?utf-8?B?N0YwejFyb2s0cEY1c0FMdlkyVkdLcysxOXhLbUpJNjAvS0Z5ckc2TDEyYWRo?=
 =?utf-8?B?c3hIaGIvV256MW5paXlRSlF3b1NkUVhJbHg3WTQxdWJ0cVBDT3dFTzNuU1dG?=
 =?utf-8?B?UUJtRGZZV2d5VFFtUGNHNEx6R3RESStsbzhseHBYanlWbjZlOWxES0dURU94?=
 =?utf-8?B?elgzNE5sWnB5TUphZE1iUzBnY1BUYWhNUVhtNElZd3d2S3VDY0FKV3hKUHJv?=
 =?utf-8?B?OWhRUUtVNnZUNVI5U2krMERiWUxLRVFzTkpmUVRYdHcrMW9mOVdZdUJ6Zm52?=
 =?utf-8?B?TzhhRXRSM1NtdHprY1A2YlNDTHFxQm02ZUdya3NaRTAvSXY0ZThtbDFNdDFI?=
 =?utf-8?B?dWsxU1RvV1V6dVZ5NURtREdCcWtKZkZSU3g2YjNSQWVldllvS3ljblp4TnZP?=
 =?utf-8?B?TUI5VWZyY29qeXpHRklxMnB2WWx6SktEV2NJYTFnMUhKV0ZuZ3FTWXhEdFpm?=
 =?utf-8?B?R1doZmJ6eDhZbEU3L3UzSTFwSWlvUjBYNFJDazFneDVYOEV4K0lxL3p3RCtl?=
 =?utf-8?B?UW9IY01lOTZZZm50Q1BHZ2VtT2d6RVpFaFBSaUVYL1NpeWtvMjcveDhFKzRr?=
 =?utf-8?B?cFUzOElOVXhSQ0VOQ0ppa0MrclpQN2JqWEJVOVFCcko2eDlKWEE3ZFpxeVRH?=
 =?utf-8?B?Z211S3phcVVqalRHZ2NEVnpyZndQdXBTZXUzUy9xM3JlTEcwUW9MVmF0OUVq?=
 =?utf-8?B?UFB0YnJ1ODNtTkIwRk83Y25pcHRuem11UmplYTlXblZLS2RBdDBIS28vMGMr?=
 =?utf-8?B?WFFCcXNxVVJKZXI3ZmlhTWZBZDViZ2lIY2UraGVOaHlkWlRidTVvYzRQV1cv?=
 =?utf-8?B?VU03WGF5YmZPN0RkWG9jZlZEVWwvQ1RLdE5LOWp0VWp3a2JWcG5VQzhRNm1o?=
 =?utf-8?B?alVuSGlYRjBMYk1sT1FKR25nZXpmRnh6dVZxNWczUGtPTVlPZWpRSFVjUDZO?=
 =?utf-8?B?Q1VLbUphTTJwTG02ZWZVOEdtTWtUZDZ0VWo3UkJSNXc0cFhEZTFIM3BNUlJn?=
 =?utf-8?B?YUsrZDRhV0cyT2xEcUFibFhrMlpucVlxeGRMZVROdHRwNEVvdkxudS9DdTRr?=
 =?utf-8?B?ZGczcERPWUlDdG1sWFBSR1prRDRyaGIrNXJxdFNCQlpIQTZnbjRmSElMMnB4?=
 =?utf-8?B?VXhYcG1UdG5IOXBWTENBTjdzd3NEZ0trM09SdnNhbG5WYnFyVGV4dUxLOE5W?=
 =?utf-8?B?Z3JrMXpWejNhNXhNZ2g2Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVV3WGZROCtkUGdkUUE3NW83ZUZVaCs4MndDTEhxSWdnNlFXV1lTcHU4U1BT?=
 =?utf-8?B?Wm9UK1ByMmhMdWJJUnhrN0cxaEJaVHNZaUZURG53bWtSa2VMTFIvcWVKV2lK?=
 =?utf-8?B?MmJIWkN0V0ZEbXIvZ0FrNHZoclQ2TTM1Mjl2VEp1ZUNTVVhYMzB1THhsYWJS?=
 =?utf-8?B?YmlXR0xIQzNmZmtkVGpsT2o5ZGhCbmNETk5NcXRaT0t6dXozYk9ldXRHUFps?=
 =?utf-8?B?WG1VbDNqUENaT21yWlBjUkRhK295VGI2Q3lLT1ZNbHlsaDlFUmVTVFllRXhG?=
 =?utf-8?B?VzB0RWhJRUtROVgxYlBGYjF6ZS9KK0gvaW5GZ0Jya3J2dkp1UG1NODhjRlZZ?=
 =?utf-8?B?NnNnWExjTXFlR1ZxQ2tKQnNRVmhLdXIvVUpVa29uMXBsN1hzSHdGcTh5eGdH?=
 =?utf-8?B?Q1dtS0JZTlBTdW9GbExMT1V3RFBvd3Y5Nm1TdU9rRm1SbnlKRU5PQmk5Vit0?=
 =?utf-8?B?c2FMRmVFK3F1YWlmMmVzdG5aNVNxY0gwM0FuY1h1cXk4Wi9CTG54Q2EyTFVk?=
 =?utf-8?B?NkxBeDdpVkJUM0JJMm56QnNqekhLcE8yMUlBVHRHRTczMHc3K3hPL3dSVDBh?=
 =?utf-8?B?ck5NdzkwakNML25uV2Y0M0x2V3NYK1FMcWs3ZGd0eVk3WVZCMUNvOW1VTkk5?=
 =?utf-8?B?RWlsckczL1BDYnRpaWRWRTlrdGpzNldvSjBPam95b3ZzdmM3Wi85bk5xYXVN?=
 =?utf-8?B?VzIwdFVuNlZPNmlhL0tYY2E3Wno5WGkvckFrbHk4cWo2dE4yeE1zOXVRSmVq?=
 =?utf-8?B?U1VqUzdmQjZHd0lBcVdnU21JcVpDRG5ySDM0RkhKOGxxdDg1ekdzcGNPNnc0?=
 =?utf-8?B?aGFNK1F4UkkyZlZqV2FiNG9aRStBV1ZMSGVHQnQzUXVnNWtFUWNYbERna3Q5?=
 =?utf-8?B?NmVXWndLU2Z5d01HWFA0YWdUMTQ3cTY4UU10RjRiN1RCbCtpRS9HY1ozcmxm?=
 =?utf-8?B?TGQ1NzViNWJWZHlzR1UwdVpFUVRYZUUrY1Z1ai9ZOGpPUkJqSjRtOVpacHl6?=
 =?utf-8?B?SXBWaG8rNmFaWVRoeDVHVGFsSUVGRHFxcmhFNjJTRWlzVy9KQmhudVNpV09N?=
 =?utf-8?B?Sm5xRnN2S1hGR0E0bE1aSmJ3dkQybHd3dFhKc2w4T2JiNEczMTNYa1p4WDV1?=
 =?utf-8?B?R2pnSXZaMEtXaUdHOHNaUi9kT1V6Z2lLUnI5Um5tV0NkUFVCRE15YkZHY09Y?=
 =?utf-8?B?MXdLbmlvZXpieWVabnI5dW13RmZhQVZ5Qkw4MUd0V1U0cGVCSFBpZ2NVY3lO?=
 =?utf-8?B?bkRNdTNweXJNR2RyRVNnYi92R1p4Y2diT3J3VVIwUDZCMDJ3V1h1SzkrTWgr?=
 =?utf-8?B?U3N1UWVKcGNxOFVSUlZIazd2SGRzeDdTVkZLaVpvSnVWQ1BObmZrcnNiaGdP?=
 =?utf-8?B?ZUk1bDB5VUdwcTVhWTZPVUMyMmJoampmQkM2b2lUWXVqQlhxbDhJK0JMS2NZ?=
 =?utf-8?B?djJHOVY3cnRMOUdnSlc0dkFQS0FpcHdnYUhzQm1TaWwzWFo2a09hVWFBSVdt?=
 =?utf-8?B?MktrSGdxNVVBL0xIQ0VZam9CYkpXWHJzUGxyV3FxazVDajhvNkg0QjY5RmZn?=
 =?utf-8?B?eTBBODdUYVUwaEc2M1V3ZVJxcVdKTHNKTjRYOWVBbXlrVmtoVjUwUjJMWFQ4?=
 =?utf-8?B?S1NNRlJNeDFHTzhKbzEwZmdlTXczYm52TGt6Z0pPVUpkbVU4dE9IUE9ITlhY?=
 =?utf-8?B?K1A3WGRFQS91MlAxcUFNOEZZQ2lJdWFBTitTZ0lQS25EOXpVM0lNbUJQRUJn?=
 =?utf-8?B?MlRrampJUnlvcVE0YUk1Z3BhcFVnRy8xd1A1YUlaRENLWkxEVUlZMDhuckNy?=
 =?utf-8?B?dmdzWENaRXBBcGZMeE5IajVvOG5jY1VxQTFYSEh6dWNROVpCODc0SHZZbjVD?=
 =?utf-8?B?UFhjdUF1bWlrMGw4SmxTRG1aLzZEMkJES2RwZFhmQjdEdUlxbjg5VXgrTUk4?=
 =?utf-8?B?eTlac3V2NklTL1BsVFduYzdEd0ZxeVA0TXNCR2dhWFdWWTc2RjRmU0RySXA4?=
 =?utf-8?B?M3ZFcUdSOUtGMlJONFpYL2I2YUkwRGp1TXUrVklsVklRcG83eURLOC9DNUlE?=
 =?utf-8?B?L3lFODl6QUVjZk1YczlkbGloTnBPbithcHkwNFNmbVgzZU04NzJKVkh1bGZF?=
 =?utf-8?B?U0hvZ0FiRUFlUVMwSkgyS3VtY3dxMktPUEJLRzJNdVh4OWNrTHJzaDZjbG5r?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oZc3a6xB0gTSt0epCq0NT5Q4"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf370ddf-5bcc-467b-9707-08dc636fc425
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:31:26.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GPNExAx/61r4qsnqioNYQoW6rsw/JNmXn5ht+pU/X4x5durx8Ej5t06muuHYoNnCud1CsgqQyR4acTGijFNBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1839
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: tkj4vd2PAFfhQr1S-C1sh-NDuPBBmjAj
X-Proofpoint-GUID: tkj4vd2PAFfhQr1S-C1sh-NDuPBBmjAj

--------------oZc3a6xB0gTSt0epCq0NT5Q4
Content-Type: multipart/mixed; boundary="------------jLHcRli2zq9u9HHHEqcF5eMZ";
 protected-headers="v1"
From: Matt Coster <matt.coster@imgtec.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <614f6fa5-a2e4-4077-a5bc-4a1fffb9c30b@imgtec.com>
Subject: Re: [PATCH 0/4] gpu: Convert to platform remove callback returning
 void
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
 <xqwcrxfrg3ogplh35c5etl6nbzw6zueilm4h6euh7bnpszyir4@6dtn5qdvijv3>
In-Reply-To: <xqwcrxfrg3ogplh35c5etl6nbzw6zueilm4h6euh7bnpszyir4@6dtn5qdvijv3>

--------------jLHcRli2zq9u9HHHEqcF5eMZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19/04/2024 08:20, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Apr 09, 2024 at 07:02:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> with some patches sent earlier[1], this series converts all platform
>> drivers below drivers/gpu to not use struct platform_device::remove()
>> any more.
>>
>> See commit 5c5a7680e67b ("platform: Provide a remove callback that
>> returns no value") for an extended explanation and the eventual goal.
>>
>> All conversations are trivial, because the driver's .remove() callback=
s
>> returned zero unconditionally.
>>
>> There are no interdependencies between these patches. This is merge
>> window material.
>=20
> I wonder how this series will make it in. While I would prefer these
> patches to go in together (that I can consider this thread completed in=

> one go), I think with how drm maintenace works, it's best if the patche=
s
> are picked up by their individual maintainers. I guess that's:
>=20
>  - Frank Binns + Matt Coster for imagination

I've acked the imagination patch - feel free to land it however you
like. We don't have a separate tree so we'd just land it in
drm-misc-next.

Cheers,
Matt

>  - Chun-Kuang Hu + Philipp Zabel for mediatek
>=20
>  - Thierry Reding + Mikko Perttunen for the host1x driver
>    (Note there is another patch for this driver set at
>     20240409165043.105137-2-u.kleine-koenig@pengutronix.de that is
>     relevant for the same quest.)
>=20
>  - Philipp Zabel for ipu-v3
>=20
> I plan to send a patch changing struct platform_driver::remove after th=
e
> end of the merge window leading to 6.10-rc1 for inclusion in next via
> Greg's driver core. So please either care the patches land in 6.10-rc1
> or ack that I include them in the submission to Greg.
>=20
> Thanks for your cooperation,
> Uwe
>=20

--------------jLHcRli2zq9u9HHHEqcF5eMZ--

--------------oZc3a6xB0gTSt0epCq0NT5Q4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCZidx3QUDAAAAAAAKCRB5vBnz2d5qsDY/
AP9qOYXsl+w7C8t0MrAGyMO42memXKD6hm8sROqWpUwr2QEAipJwNmin6WZ1oVg7cNqy2VZJUvae
018oCIgTs6TKvQU=
=SwOB
-----END PGP SIGNATURE-----

--------------oZc3a6xB0gTSt0epCq0NT5Q4--

