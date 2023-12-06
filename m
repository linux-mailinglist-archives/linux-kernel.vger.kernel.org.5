Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1448067E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376944AbjLFHCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376922AbjLFHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:02:41 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192301B5;
        Tue,  5 Dec 2023 23:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701846167; x=1733382167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mu2YN7PtneLVBuDs+I0mI/7lFHzujpC0wBCcGbRjt60=;
  b=K65rroqWS3+3YT5V8vYLdmmVO88EbxwciiRMQEWfnto9U9BfFQQ0GGg4
   91ASroUMiBpNHs0TN5nDg++h7sGtj9EkA4ssHJ5Zu/+kvMn14moQaocSD
   3PWAK9wBFwIsv/R4ov9hKr/5CetsC8auvoUzqPyX3g5tM+kJfLXPKJSaD
   X668BAzHOtEaMiHay3zvyfH1By0pLi7xKIYpFGKh4nAbBg0GbRKNJg0P5
   6GjwceFc5KcD/iNja7nLdJKYxozPrFKSmP+TY5iA526gTn/zL3+dCpn4S
   ULrNFb/J3m2g/EF2YS6fbC2GN5efAjnTL3JMOufnFFDpOSoQmUz8CRQye
   w==;
X-CSE-ConnectionGUID: SJSvKIuxQTasxUzWv95T2Q==
X-CSE-MsgGUID: TJBISoLQRViXjaoVIvsoAw==
X-IronPort-AV: E=Sophos;i="6.04,254,1695657600"; 
   d="scan'208";a="4105264"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 15:02:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5r8DuBZnPKxRMxerkeKZMmFR9quIp5F+qxoF39yHLopOwO/hkLfQsuMwLNwv7wuAhHh5r8mURd24woGyu3hqSsrbHHZXuwZ5tOMWn133KWqJ+LQ3ZUOZLYRQjyt98kAqfGY0o+wuTywWjTXz4OmNAasDTYDdDiUYICHAxhJFhgEHQetS3lk8oyXasxCF9yAyP48oV+hTd6OYUW/nHbosGF39TSvlHuRhhIjGlVhBoL/ZCO2Ns1jbkJSBPhv2jhoI9aRjT4E9vyg7a4Ce4c4oaGHNWGCLtgodfzMjrA0Sko7uvBUPw9JH/D2yz7txFgEzTNgqdgNBrs5nG+lkZZPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu2YN7PtneLVBuDs+I0mI/7lFHzujpC0wBCcGbRjt60=;
 b=SAdUgmQxN1BNSUKj07mAi/zm1S/GePuOYHethl7xNQ0InbOCfqHYztB1FuLP5S8ovPof8Fpnbmu7SIToKgYcPXtlaB0m2BAviTnBNhM23Bp3n/mEr6LOmsR0CKL59T30WI+pgxQT6SQR1JHxgvMeYIT1qChxtW1y7ugjurh26EfIv7OaeiZ6twLA7CI52ygF5LKsesSfxSAPGgFPt9bcT+6q3G3+1kTGVFVxk6NDuYzadVHSai/iUmJW3kqhev1CKIex3hSm6zcXpoRfLA60KeGKnb1EfwCehOml2LIrzbp5bUOWj7SPIp1G6e4FbnNSXuKYyJBuxeMFvkzJI6Smsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu2YN7PtneLVBuDs+I0mI/7lFHzujpC0wBCcGbRjt60=;
 b=tKj4GAEjs0bcpcnCiBgqhn5DLuaSwo7SMRk6R20WjcUJQjvnlLAlPhPljNVCS91vKtqIuTndHAqT4OpiSAYqhdPhKbU82vZX/VzeaslpQ4PGUveg0iypwkHLdFv0TLk9qkwlSfEEixpHy2j0MEpBxAgTKirmAzUZi8PJlfbQ+Vo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8794.namprd04.prod.outlook.com (2603:10b6:610:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:02:43 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 07:02:43 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "christian.loehle@arm.com" <christian.loehle@arm.com>
CC:     "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Thread-Topic: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Thread-Index: AQHaJsLBZ2sxhOoGTkWiMOgXX6Cv0bCbIS4AgAC094A=
Date:   Wed, 6 Dec 2023 07:02:43 +0000
Message-ID: <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
In-Reply-To: <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8794:EE_
x-ms-office365-filtering-correlation-id: 01151376-b17f-43d8-96a1-08dbf6295817
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: imy6aRqc7OlbeRdmyc5+wTO2JsJq/b5L9j2/YW1JoUmnSy878mlgN4qIz34kTeARjgsIB36YewFN2YpWzaF/A6NQzjYALVrqGRf912ZoF8kJ2R3tnf0b2omDWzLuSM7PLkF6WjXTixVDgfRRGDtX9P8Yr3Z03mZZhM2Lda4NOvuTWFIVLieYB6lK6aEY5Vef9iOWNwcwgNtVU4fIy2XO5ZhOL//zSKIdS4kmrAUPluXgA1X1cdLJytOb7V2OQucLDVHq6tx7LScXQsTlVoqpiDPZxZz7hpollreBRt/TGMHdrNuOri6q5lwkPsRIdvRZblS9dU0PvOMujQKzW24d52TNfKdZ0U/3y0Gjsq/U9EOsZOUbmxgkDPwW9YzzXYDpUmpHtAbguuwJIF8I/XF+688hg97fi3hnSjzBd+GjB6QsI7ljzXws/is0300gbUNdRTI5izk62D2q24ScOQ4rGTEwfobM0xQyCLXtuAOz/MeAhDvfyR8RH65ceZsosPsGuM5iYWG8Rryc5oo3GUZW7C0RIOJxL1kq/dxb1GRG8m8Cxf7PtTKNJZS+pyslS+zGRzGlUtZjqsPLnj13HwOPaQlPLS2w+xPVfn18KX9To7ZEYUBPMrytE/nfuQSnFJAe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(122000001)(8936002)(4326008)(8676002)(9686003)(7696005)(6506007)(53546011)(55016003)(83380400001)(82960400001)(26005)(38100700002)(71200400001)(478600001)(66446008)(110136005)(66946007)(64756008)(66476007)(76116006)(54906003)(66556008)(316002)(2906002)(33656002)(41300700001)(38070700009)(52536014)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWZNdytDaDVRdWV2M2hjWVkxMVE1SS83OVYyUnE1TFZtK3FVcXpCbU0vTzhZ?=
 =?utf-8?B?SWpQVnNEZzhMYTczT2VHQkpDOHZwZi9POENaRFpERnNLaUR0ZGVFRVlpT0JX?=
 =?utf-8?B?MVFZUEt4Q25ndEhJaHIzdGRMR0sxTnRSeTRFZlhVZ09MS3dsQTB2OE1mOElR?=
 =?utf-8?B?OFpKbHc4QXpoRTh2Q1Vsa2cwT0hQMm5Hd3dNMzNHN0MwRk54VHFSWEZHMmdF?=
 =?utf-8?B?eGZtNGI4ejV2MXR3MnhXTUg4NEwvdDdXcHRUU1dnakVpeGNJengvWFMxVlB1?=
 =?utf-8?B?ZlJnQ2pVZkl4RVdaV3lwc3JDbGwyMGF0THJ1TW0zZVgwTFlFWVZKWWMvcnho?=
 =?utf-8?B?cWsybEJ0TEFGTjNpcmZDbHhlSzc3cDVWOUNaMCtITVhhTmlyRFpEUG1WclBR?=
 =?utf-8?B?L01mUytIWllRNzNteUREaFRSZG9nSXM4N3dOSWl3b3g1S1M1WDh0OUxnVStO?=
 =?utf-8?B?bjRDTk9rQkRqN211a3E1ZFMrOSswbkl3ODZudkFSSEhhcWpnSlp1aFNqRUU4?=
 =?utf-8?B?QzhHQ1g5YzdQOGZmblRScVg3MnVXQy9nb0VacU8wZlROTzVEM3VNdjA5R3Uz?=
 =?utf-8?B?ZTBGUGE5M0YwUEc4cUhpbUNhMmJYbWw0VTQ1OHBCeVVweU9MdUw4NU9ydWdx?=
 =?utf-8?B?bHp1a0krbk95K3o5K2lUZ2tGTVpCcXY4ZHlpR0F1UW1ibyt5bi9qNmdwd1U1?=
 =?utf-8?B?WENueWp2ZzFvNElTUVRCRmsyN1N5WFVRVmxYRm1LcTV4NllPa2E0M25NelR1?=
 =?utf-8?B?K3MzRS9MZUdzMzhwK3Byd1ZQSkpZcThOTWtlN2Z0WXp5V003dDdZUnI1YlJx?=
 =?utf-8?B?ckh1Yks4cGdDSEIxdDd0R0RIR3RDT0xnQlZoRDR1Y0pzMTRJSlE4cWxyRk1r?=
 =?utf-8?B?RGxWc0tEQW9LczZ2YjFWL09JU2FmajNyQkVtYWZSbzFXQ2Yxa2s1RCtrc2tC?=
 =?utf-8?B?OWs4N1N6WGJDSWR4M1I5WWw4UHBLcFhoU0RkOTdKbTFaWDlJRXpvTThqRStD?=
 =?utf-8?B?Vll5ZWE4ZEdYRnQvVTJjaGVyRDIzc2hUV2RlUWo3L200WVJlczlSSkFYOWdS?=
 =?utf-8?B?MlJPY1NWVkJkSnMweGo3dUphMlkvRDROSk0xeldKZno5bGJrQkxrUmxtOGs1?=
 =?utf-8?B?eE9mcHpNa1RQZkE3OWVrQmJMaFFhNXk5UVRadG96enN1MUhjV1JMTGEvNmZE?=
 =?utf-8?B?c1EyTWhHSXZuY0FNNXpVdEtJbis0ZTVmUnhBcGljRFgzb2U0ZVlWOEhOaXFR?=
 =?utf-8?B?SDFpaFNOb3ZhaWtqOE5CTTlFa3ZaQzlmL20vRU02L2pPcGkzeVlIWEdyaHIr?=
 =?utf-8?B?NXNzblBGeFh4cjc1QzEybDVsZVk3QU1ZamNvMmFsSkFHYStpYVpmY2lvR3h1?=
 =?utf-8?B?T0FNNjdWNHRNS0N2MFFLMklPU3lGbG51dHMxSU5EZFFWRjl5aHd5WDU1NUNq?=
 =?utf-8?B?Q3JObXVPMlA3MXBWSlhEZU1mTVZhUGVOd0pMcmdkTjRqVHd6bGtjb2xFdmEr?=
 =?utf-8?B?TVZucXQvMkFVZ3FTMkJqNkF5U1lLakJoblF1WUtyd1Q3YUFtdTRTaWVNMWRW?=
 =?utf-8?B?YTFkUUd2cFpVUmFSVUFQOU9yNkhRbGwvZ2w5Y3Zlb2Q2Tlo2RjF6QTZDL1dR?=
 =?utf-8?B?YUtQbWFpYWtNUXVFVWZFY0xwbkRhUUxFUUZ6NjZKS3kvYnZLWUR5enZJbytK?=
 =?utf-8?B?MW9KdGllT1d4dmoydlJQcnNXVDFaaWYwQ0dZMGFrSyt4bjI5MGo1QXRKUnZ1?=
 =?utf-8?B?NGY3YzVucDU5aGJhQjVEL055b28raHpDL1BPZ2xEU2szeGpQa2kyQ2oxUlVU?=
 =?utf-8?B?dnhudElVOGU4RWd2ZSt2VVpYUzRndVJqNFhNU0hkR2FneTlMUXNkdjNrMWt2?=
 =?utf-8?B?cEg1MnlnYUNJUXdiRWFoL1Y0Zkh1aXh0dEErNWJyMUJyaUxFcG5IYmhvdmFP?=
 =?utf-8?B?d09RN2Z3VGhmVnFCRkZjVVM5VU5SdVJUbDdha0gxK0NiZzFkbzBjNFV3cUJr?=
 =?utf-8?B?K2ZRek5ldWFEeVEvVGxjOFBBdTRzK2pZRU0vakpNeEFPMmpBcWllSGFKT3Rm?=
 =?utf-8?B?T1owU3JDd2hTekVSL05XU3kzU1I3VnNBTDMyUktXU1FTYjUrajg2NGhSK0Nm?=
 =?utf-8?Q?0cID3UVuZ3ZiwNE53CsT0ePNw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MmtqdzE3TnZWbXpTVVMxa0RjZWZ5MG5rQ1haS3RuNVFwMWFuSnRmSENZRVFW?=
 =?utf-8?B?QnFvZjBXbVFNOWxQZ1RNQzlidCtYK1NEaEMxSGJrZWozUmd6VTc3TEMvdjFT?=
 =?utf-8?B?VDNoWEtTaXpoQWdQUlhVeVk2V0pKWGdsdW1uQkpOVWtWaHJFNGsrVWU1QzVP?=
 =?utf-8?B?WENiZFdGYlNkYkltR3dzNi92bVNtanRNL3dpRDBzRzZUWWVLdU1NR2RueFNr?=
 =?utf-8?B?bHpVeXN4ejV0YUNRbVlkdExZbnpvR3lvcTdVNkhGMzJiQ2FtOGpPdkFtZ29E?=
 =?utf-8?B?TzRXT0lQcHNnYjF1OWtoUGR2TmhYTUdkRlNtY2ZSNmNoVXBCMElVQnJEbXJB?=
 =?utf-8?B?U3NubmVXWWx5TDk2RStaY3o4VnZxUjhvUEkzVVJ6L2dFaGRRaDNJZFNuT1JU?=
 =?utf-8?B?ZUpmSkhKc2tkTi9Ta2MwNEJUYUVGWkhuYnN3Qy94ZVlZc2pYOTRpS0RkZGVR?=
 =?utf-8?B?UGMvTnROQXQ2d2VwZDdyR3dRakhSWXBlNTVJRHNLRy93aGVNWkxLcUJSa1h0?=
 =?utf-8?B?emV3RjFaU2RRSU5oTW9kM2lMOTNYa3JZUWxDTmpGWlVicTBodlhxUWRDSnBZ?=
 =?utf-8?B?UzB2Y3c1QXE1c0hiaXdTZExlYmw2U2Rud0VoTlZUSUVCZXFPUmNZakplOXZ2?=
 =?utf-8?B?U05zQ3I5ekwrOVhvcDNLZzAxOFZqWDhXZGpRajNHaElza1lSU0w5bXZPRWQx?=
 =?utf-8?B?S3I4YTFNTzhDWXhldEFmdlhMNklzMlNWSW9lVS8rQTlJZnh4Uld3UWE2M0NZ?=
 =?utf-8?B?YTZQdlBlQ0RpdVpjbVRxT0JlajZtK01vTnN6YU5qazZreHZGL3BXWVFDa2ZE?=
 =?utf-8?B?UkxVeUFOSmd1OUVHd0tORzdMYmZYa0w4TmJjNVNaYXJHZXdRQWdJa3RCMU1q?=
 =?utf-8?B?TE1uSUNkcFlaU20rV2cwa3hnQlBzQjZuUDk2WXBQeG9YSGtub2xqcG91QlMy?=
 =?utf-8?B?Q2lnVEh6REk2NytWVVBNNkMyam9zZW8wMHJQZVB4TFovRmEwUUlRSjZzSHdW?=
 =?utf-8?B?N0hkS3p4NXhkcWdQMXJVK2Rxb29qWjF6SG9RZ2d0dnJ2M2FhVkpDem5pYUcz?=
 =?utf-8?B?aHozQTdIcjZDeHlhaUxZanI5TnJSVEl2QTkrYWxzclgzdit1NVMwb1U5QkQ2?=
 =?utf-8?B?Y1hpa0FnVUJ0b20rdkhCUmI2WVBsUnNDTTkwZGgrMTNGN1l1eFZHd29xbmgy?=
 =?utf-8?B?OVgvRFpKbWNvWWpLK1hOQ2ZZU05ENEFlSHpaMDRsTE51Y1phZzBsU01FMlZn?=
 =?utf-8?B?YUd1VlExRWswRGF2NDV6VlNlNzAwamhjN0U5NXRML0pRSy90a29BWGhxeDJp?=
 =?utf-8?B?WUhnMitWcEtkQzBXc3dUSGtURllwWHZJSklweXkyMGYzWlRFVnRCWXdUa3F4?=
 =?utf-8?B?aTNDbGsvUjhjR2o1THQ3Z0k2NWcvVjVZTktYekhnTVhSbjFSSnJmS1UxWVh0?=
 =?utf-8?B?TEtRR3ZneFhHWWFUNmxhaFRZcjNzSlJpd1BXL2JIdm5RR1dQblozdEhMbFpJ?=
 =?utf-8?Q?8xraN0=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01151376-b17f-43d8-96a1-08dbf6295817
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 07:02:43.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btjp4xcdvsgiZ9Fmq1McZitDnEpCHMOB/5xP57lr6ahXUPfIIUBcWkRX1vzrFDI/qTiE94etq1BDkuD/FmP5xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gNC8xMi8yMyAxNzowMSwgSm9yZ2UgUmFtaXJlei1PcnRpeiB3cm90ZToNCj4gPiBS
ZXF1ZXN0aW5nIGEgcmV0dW5lIGJlZm9yZSBzd2l0Y2hpbmcgdG8gdGhlIFJQTUIgcGFydGl0aW9u
IGhhcyBiZWVuDQo+ID4gb2JzZXJ2ZWQgdG8gY2F1c2UgQ1JDIGVycm9ycyBvbiB0aGUgUlBNQiBy
ZWFkcyAoLUVJTFNFUSkuDQo+IA0KPiBUaGVyZSBhcmUgc3RpbGwgMiBjb25jZXJuczoNCj4gMSkg
V2UgZG9uJ3QgcmVhbGx5IGtub3cgdGhlIHJvb3QgY2F1c2UuICBIYXZlIHlvdSBkZXRlcm1pbmVk
IGlmIGhlcmUgYXJlDQo+IENSQyBlcnJvcnMgaW4gdGhlIG1haW4gcGFydGl0aW9uIGFsc28/DQo+
IDIpIEZvcmNpbmcgdGhpcyBvbiBldmVyeW9uZQ0KPiANCj4gVGhlIG9yaWdpbmFsIGlkZWEgd2Fz
IHRoYXQgYmVjYXVzZSByZS10dW5pbmcgY2Fubm90IGJlIGRvbmUgaW4gUlBNQiwgdGhlDQo+IG5l
ZWQgdG8gcmUtcnVuZSBpbiBSUE1CIGNvdWxkIGJlIGF2b2lkZWQgYnkgYWx3YXlzIHJlLXR1bmlu
ZyBiZWZvcmUNCj4gc3dpdGNoaW5nIHRvIFJQTUIgYW5kIHRoZW4gc3dpdGNoaW5nIHN0cmFpZ2h0
IGJhY2suIElJUkMgcmUtdHVuaW5nIHNob3VsZA0KPiBndWFyYW50ZWUgYXQgbGVhc3QgNE1CIG1v
cmUgSS9PIHdpdGhvdXQgaXNzdWUuDQpQZXJmb3JtYW5jZSBpcyBoYXJkbHkgYW4gaXNzdWUgaW4g
dGhlIGNvbnRleHQgb2YgUlBNQiBhY2Nlc3MgLSANCkZvciBtb3N0IGNhc2VzIGl04oCZcyBhIHNp
bmdsZSBmcmFtZS4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBUaGUgYWx0ZXJuYXRpdmUgdG8g
ZHJvcHBpbmcgcmUtdHVuaW5nIGluIHRoaXMgY2FzZSBjb3VsZCBiZSB0byBhZGQgYSByZXRyeSBs
b29wDQo+IGZvciBNTUNfRFJWX09QX0lPQ1RMX1JQTUIgaWYgdGhlIGVycm9yIGlzIC1FSUxTRVEN
Cj4gDQo+IA0KPiA+DQo+ID4gU2luY2UgUlBNQiByZWFkcyBjYW4gbm90IGJlIHJldHJpZWQsIHRo
ZSBjbGllbnRzIHdvdWxkIGJlIGRpcmVjdGx5DQo+ID4gYWZmZWN0ZWQgYnkgdGhlIGVycm9ycy4N
Cj4gPg0KPiA+IFRoaXMgY29tbWl0IGRpc2FibGVzIHRoZSByZXF1ZXN0IHByaW9yIHRvIFJQTUIg
c3dpdGNoaW5nIHdoaWxlDQo+ID4gYWxsb3dpbmcgdGhlIHBhdXNlIGludGVyZmFjZSB0byBzdGls
bCByZXF1ZXN0IGEgcmV0dW5lIGJlZm9yZSB0aGUNCj4gPiBwYXVzZSBmb3Igb3RoZXIgdXNlIGNh
c2VzLg0KPiA+DQo+ID4gVGhpcyB3YXMgdmVyaWZpZWQgd2l0aCB0aGUgc2RoY2ktb2YtYXJhc2Fu
IGRyaXZlciAoWnlucU1QKSBjb25maWd1cmVkDQo+ID4gZm9yIEhTMjAwIHVzaW5nIHR3byBzZXBh
cmF0ZSBlTU1DIGNhcmRzIChERzQwNjQgYW5kIDA2NEdCMikuIEluIGJvdGgNCj4gPiBjYXNlcywg
dGhlIGVycm9yIHdhcyBlYXN5IHRvIHJlcHJvZHVjZSB0cmlnZ2VyaW5nIGV2ZXJ5IGZldyB0ZW50
aHMgb2YNCj4gPiByZWFkcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvcmdlIFJhbWlyZXot
T3J0aXogPGpvcmdlQGZvdW5kcmllcy5pbz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29y
ZS9ibG9jay5jIHwgMiArLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2hvc3QuYyAgfCA3ICsrKyst
LS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9ob3N0LmggIHwgMiArLQ0KPiA+ICAzIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMg
aW5kZXgNCj4gPiBmOWE1Y2ZmYTY0YjEuLjFkNjkwNzhhZDliMiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2Nr
LmMNCj4gPiBAQCAtODU5LDcgKzg1OSw3IEBAIHN0YXRpYyBpbnQgbW1jX2Jsa19wYXJ0X3N3aXRj
aF9wcmUoc3RydWN0DQo+IG1tY19jYXJkICpjYXJkLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ID4gICAgICAgICAgICAgICB9DQo+ID4gLSAgICAgICAgICAgICBtbWNfcmV0dW5lX3BhdXNl
KGNhcmQtPmhvc3QpOw0KPiA+ICsgICAgICAgICAgICAgbW1jX3JldHVuZV9wYXVzZShjYXJkLT5o
b3N0LCBmYWxzZSk7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgcmV0dXJuIHJldDsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9ob3N0LmMgYi9kcml2ZXJzL21tYy9jb3Jl
L2hvc3QuYyBpbmRleA0KPiA+IDA5NjA5M2Y3YmUwMC4uYTliOTVhYWEyMjM1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9ob3N0LmMNCj4gPiBAQCAtMTE5LDEzICsxMTksMTQgQEAgdm9pZCBtbWNfcmV0dW5lX2VuYWJs
ZShzdHJ1Y3QgbW1jX2hvc3QNCj4gKmhvc3QpDQo+ID4NCj4gPiAgLyoNCj4gPiAgICogUGF1c2Ug
cmUtdHVuaW5nIGZvciBhIHNtYWxsIHNldCBvZiBvcGVyYXRpb25zLiAgVGhlIHBhdXNlIGJlZ2lu
cw0KPiA+IGFmdGVyIHRoZQ0KPiA+IC0gKiBuZXh0IGNvbW1hbmQgYW5kIGFmdGVyIGZpcnN0IGRv
aW5nIHJlLXR1bmluZy4NCj4gPiArICogbmV4dCBjb21tYW5kIGFuZCwgaWYgcmV0dW5lIGlzIHNl
dCwgYWZ0ZXIgZmlyc3QgZG9pbmcgcmUtdHVuaW5nLg0KPiA+ICAgKi8NCj4gPiAtdm9pZCBtbWNf
cmV0dW5lX3BhdXNlKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkNCj4gPiArdm9pZCBtbWNfcmV0dW5l
X3BhdXNlKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgYm9vbCByZXR1bmUpDQo+ID4gIHsNCj4gPiAg
ICAgICBpZiAoIWhvc3QtPnJldHVuZV9wYXVzZWQpIHsNCj4gPiAgICAgICAgICAgICAgIGhvc3Qt
PnJldHVuZV9wYXVzZWQgPSAxOw0KPiA+IC0gICAgICAgICAgICAgbW1jX3JldHVuZV9uZWVkZWQo
aG9zdCk7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0dW5lKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBtbWNfcmV0dW5lX25lZWRlZChob3N0KTsNCj4gDQo+IEJldHRlciB0byBqdXN0IGRy
b3AgbW1jX3JldHVuZV9uZWVkZWQoaG9zdCk7DQo+IA0KPiA+ICAgICAgICAgICAgICAgbW1jX3Jl
dHVuZV9ob2xkKGhvc3QpOw0KPiANCj4gVGhlcmUgaXMgc3RpbGwgYSBzbWFsbCBjaGFuY2UgdGhh
dCByZS10dW5pbmcgaXMgbmVlZGVkIGFueXdheSBpbiB3aGljaCBjYXNlIGl0DQo+IHdpbGwgc3Rp
bGwgYmUgZG9uZS4NCj4gDQo+ID4gICAgICAgfQ0KPiA+ICB9DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2NvcmUvaG9zdC5oIGIvZHJpdmVycy9tbWMvY29yZS9ob3N0LmggaW5kZXgNCj4g
PiA0OGM0OTUyNTEyYTUuLjMyMTc3NmI1MjI3MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9jb3JlL2hvc3QuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5oDQo+ID4gQEAg
LTE4LDcgKzE4LDcgQEAgdm9pZCBtbWNfcmV0dW5lX2Rpc2FibGUoc3RydWN0IG1tY19ob3N0ICpo
b3N0KTsNCj4gPiB2b2lkIG1tY19yZXR1bmVfaG9sZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpOyAg
dm9pZA0KPiA+IG1tY19yZXR1bmVfcmVsZWFzZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpOyAgaW50
IG1tY19yZXR1bmUoc3RydWN0DQo+ID4gbW1jX2hvc3QgKmhvc3QpOyAtdm9pZCBtbWNfcmV0dW5l
X3BhdXNlKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCk7DQo+ID4gK3ZvaWQgbW1jX3JldHVuZV9wYXVz
ZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIGJvb2wgcmV0dW5lKTsNCj4gPiAgdm9pZCBtbWNfcmV0
dW5lX3VucGF1c2Uoc3RydWN0IG1tY19ob3N0ICpob3N0KTsNCj4gPg0KPiA+ICBzdGF0aWMgaW5s
aW5lIHZvaWQgbW1jX3JldHVuZV9jbGVhcihzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQoNCg==
