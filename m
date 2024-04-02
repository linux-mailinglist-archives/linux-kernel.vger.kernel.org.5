Return-Path: <linux-kernel+bounces-128516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97226895BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CCE1C22E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CA715B121;
	Tue,  2 Apr 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0Em3Pxe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055D1756A;
	Tue,  2 Apr 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083477; cv=fail; b=uTSiUx6qSS7LFsnlSNMJ+qouNBE126Yp36RbeW5fjdJuad2iXQEWm1LO9yGk/fXTQIU+nt0hLVn1h6ahPk9wrGnOCzNUvjsP/mrosDsg9PBQrFZpNI+noQag6JCxeZXvMoNRzM8mUSE/f3JgI2rXnYt35tLRAUJ64id3agwruZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083477; c=relaxed/simple;
	bh=1m9HL50zLxvw1ZajjL8ZV2jeJCfon11Gn0nUNxqpymI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FyLAOnQRXsNpEMNpoWA63nrZ9xQRmM8ApZpdrOFsb7+ZSBPPNlVsBkgNE2DmnaInUls2NKmpXQYnLvDvMkMTJy4nhPrktfKugt3Ce7ztofzdXqw4YOfedmg8G2/am1PRwEpeLYApVDDgGvTKEkvIvKJjkGhc2EpTwrQr3KIpxWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0Em3Pxe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712083475; x=1743619475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1m9HL50zLxvw1ZajjL8ZV2jeJCfon11Gn0nUNxqpymI=;
  b=N0Em3Pxe4DuxBZ1cTuxUWAm4leLaA+dgJeqeTi0JbVSNHqvA4ZR5m3cV
   RGoGUuRVGr/K1RCzoH73682VpVU6DDsU2mmS/MSOsmzZQhZNbEyxSbE+D
   xMIq3hAxTSXyrPzhrrOQaTb+GTLQYbYBqeUMQFs5crRK3k4CWzGyjdzQp
   7Zw8TP0KdJSZqGXJx7HpKIS+Lj6Lkdu1ucmz7KAPCZv8r6NHSZVMejkZs
   sfYsILP2qEuWcmpZ7HvCa6eT+kwPwNx9C2fSKRX2GzJMPs+NSAFDRwXnZ
   vR2pYByWD+bLZV+6dYqB93CLvqwieaT+nwkryhqSgeNei7Qd58wJCv5v+
   A==;
X-CSE-ConnectionGUID: XE2L3k96QbOPjI4uwK7jPg==
X-CSE-MsgGUID: /ujP0YM2TzyT2vIXoU5gmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17848502"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17848502"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:44:35 -0700
X-CSE-ConnectionGUID: DbEZGpUkTUe91Jp84+frAA==
X-CSE-MsgGUID: ktc84dAbTpW1oZ+GildEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="55619607"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 11:44:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 11:44:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 11:44:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 11:44:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrPNsuF0CZUaTa5rGNpmuIK4ogsomk0yWBYyRoghmYxafowlSUpm13vef4TT7HZfygPO6NRM1sAPlb8RQvOfrNpTjInOEhrPltOoofVSEPE/mXD5sGP5rjQEBUINoGFWBOwbRVlWPNxR2mw2gq1MYk7NlNb9LaUsnE16nSqZCTyavNkzWA41RW5aOnsnVxJsJlirGtJWWks/9IePIzBXrZH2cbMJPyqRkuIuZI5mNBWRMqw+D3ixxdqhe+DjaBKtLRzliLeBE854pEcS6VBcWxYX2UreUcsBNeAxkMTEm8x9W7lHKMqwbiiycAiL055fX2GqWxhIb9pN73ogQ/9r6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m9HL50zLxvw1ZajjL8ZV2jeJCfon11Gn0nUNxqpymI=;
 b=KOQOhtCfeqOIm+bqTA0bXb21/SMOJb81wLn/jkkd2HdZT5mWbn87VGJphQIfoo+tX6/qLHe5JGerw/PU2hLfYqzsumOr/bYR4LrWglocLhA43K4GJ33+5JpOgPtgUIjm56bmmKkCDFurl/V3d0fszLZsSvsiNA8VN3XG9acV6F19n6ekxNLfzNGMvDdT+uYxsiinalqM3gQwnFpezxHJb7TsUlX6QleorxaXwiEagrKmHCCrqL7sgyrCCD9klar03FzjpGSYpl/lGPDz/+eIaNFkBQ5Ne0tRNf0U4s2jo8WFGLFtZ32jc76XNH4+5ihUitr9HOFVDvBgElxUXLqWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 18:44:31 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 18:44:31 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "russ.weight@linux.dev" <russ.weight@linux.dev>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "lee@kernel.org" <lee@kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pagani,
 Marco" <marpagan@redhat.com>, "russell.h.weight@intel.com"
	<russell.h.weight@intel.com>, "Rix, Tom" <trix@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-m10-bmc: Change staging size to a variable
Thread-Topic: [PATCH] mfd: intel-m10-bmc: Change staging size to a variable
Thread-Index: AQHahMsUwNbDrRit0EOHSlasy+brJLFVUgCA
Date: Tue, 2 Apr 2024 18:44:31 +0000
Message-ID: <64f93fd3c7720b28adf4cffd562ed91da2a421f3.camel@intel.com>
References: <20240328233559.6949-1-peter.colberg@intel.com>
	 <ZgqCdfCSatazEkIj@yilunxu-OptiPlex-7050>
	 <20240401170905.v2xin3fzoe3m3tmz@4VRSMR2-DT.corp.robot.car>
	 <20240401171947.dncdvc3gxna33nxq@4VRSMR2-DT.corp.robot.car>
	 <ZgurQETbga0Q/PVE@yilunxu-OptiPlex-7050>
In-Reply-To: <ZgurQETbga0Q/PVE@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|PH7PR11MB6723:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yITUpLPA/zTgrjamE89zk5SHj9Ug7DWdZjqUVdwXAV+XFdIBJuKxUvOB86zLZDnM+z/iTAD+qwttpcRNDpPUDVUiPxkg0GNu9Cb6NyUXsifJ9p5l//EUCjLGV1fih7smhSNqTgd8c0NL6gnqMyUMbvs+vbiQpcTDpNeHA8Rj0jVsZcvIeIDfCiJBMfZi6qsXkJL+V2++FOwz1V5GIjDnnqk9CHM4IKA/eJJ5wSZ6gZvlOs3FciBdsEXaov/auPA+bit6JZuNUiuz5vKIil9IXS8JGmP7kC11tILJdXti47dq5WHh5T/Lp4sdJcixW8ssJmqZzambSD6QICfSq9+b0a2dMrOB/d8ht3XW6TNyH+fanW7MsH7W73A8hgpEfP0WaK0dhQsun4JAB0x6+bgUH1G8UJtwZPQDs9F9MBEyBiN4ZyuPYuxwpyInzuzQ5WL0zXCvrtYU7BtVldhOVO5+rPgwXiY19XdOwJMiINGBIgfVTkWw+14LztFvIIo9mPELrE0ReN371emkHms06Zlx0dhEh9CYwr9eBS8Elgw79H1wBXEDkQMZNq69aCBGnNxqVXqPssp+0DGynu2JQZe04McU+bBS+mrxjGTZ5+Ec4fLEIVMM+Q5/YfAu1AzYC1rpokPkCEVlTPTc1PcPa72bcGEQI+52+aZAOsjCdDBmw3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VYZU8rbE8zUWF1SGg5d2U5Z2c3bWlEK0tOKzVKWWtpM2ZrUm5xQU5oOFpn?=
 =?utf-8?B?bDJ4RHEyeldxb3NsS04xTDUwak5BMFV6QTIxc1VwRUtZUnJXK2JRY3JUYWNK?=
 =?utf-8?B?WG11Q2cvMElIZ2VGREttUHl2TDBsODh2NGRkMEVMU1IrWDB3WFdHUGN3YVVE?=
 =?utf-8?B?VCsyU1BlVXltcTFpK3EzaE5HeDFHM2R6Mlc2S25lRmlJR0NWbyt1WGJpbnlx?=
 =?utf-8?B?VDg1WFVvZG81eHJUcU5QVXNjdi9QZkRzaDR2WXNQOHdCeFA0VVZZMC9pZmxH?=
 =?utf-8?B?VmVEUVNueFovVXByamxJalY5NzBlZWNEZmNaQ1p0ck5sNSs4WktiWk5uR3lv?=
 =?utf-8?B?YjRyNVFLdDYwS3dlRk1wQndRTWhHOWsySmRxTjZaVEYvVk1NLzAwSFdCY1Rt?=
 =?utf-8?B?M2tKdjFhaWJJSnBtOEc1bUJZNE4yU0k4K0dXaHBJNEpwRExkK1B6RlNMOWFr?=
 =?utf-8?B?aVRXK3RObUZqVFg4bXprUG5lQjhMVnovaExqQ05YbUFjVElmb25rTklUV1dS?=
 =?utf-8?B?aE1BUllBbEt2NkxBclByd3BqQmpzNFl6UVJPSHFGOC9UMHE1MmRXMjFzV2xu?=
 =?utf-8?B?ZzlrQ2Y1Unpab3YxNlV0WWVhcFpuSkhpNGxXai85M3RmUjg4ZGZRSUhLUjRm?=
 =?utf-8?B?NXVlcStKc1JOd0dBRHJudGQ2NTJQTVdQeGpGMlVDRHZQOGc2MUFNM2Z3anJL?=
 =?utf-8?B?TThJVFVndS9CdkEzcjRIZWZ0ZFNIZ0RzSXVWd3hkaHQ2WVJVOUFmTVkxZ1l1?=
 =?utf-8?B?dVN2SE1GYUpwOCsvZi9GUmxFMlNyamlqcTN0ZmdCbkszWmdjV3NjRWRVREZt?=
 =?utf-8?B?NG1STjZKa3NrMEtzZHBPUEVVU3JhT1B3akIzcWJxbjM5anhsVDRrNkZKKzZu?=
 =?utf-8?B?bUQzWkcxb1dNTG1ONGlxZzJFQ0RWN3FEa083ZTZpUXk2MzI2QzFyb0tiWG1C?=
 =?utf-8?B?cGZmblVGVWNEa1I0SGVCL1BrQmhJOHlZWW4xa3FRbEhvaDVoN2k4LzFGV3cw?=
 =?utf-8?B?TmJKRkxWU2VHUjIwV1p1Ry9mME9aMG91a0J4ZENyTk5xZ0xwZ0h2Mm1GN1Q0?=
 =?utf-8?B?WndHck02QUoxYXdsakpOWTFtalEwWVUzNUY5ejRnSGlzSkY4d2tHOXdmL0Iz?=
 =?utf-8?B?ekN2Y0JtRHhGT2VKWWI2aStJelZ1aHUyYWJGM3RzaERQU3Q1NHQ1MER4VFoz?=
 =?utf-8?B?a0dDNERrdms0ckJoektLelpXTmlra2ZYUEkvUHFuZTNLTndtSkFEdVp3QWNF?=
 =?utf-8?B?aHFqdWVKMlU3UTNSdFA5MUJQSStXNkovWithUStHS3c5QVdjR0hzNnJaUFN4?=
 =?utf-8?B?WkZYNEk5akM4OXdidFFDUjNCOEhZR3RpTlVXVzgyTGFoeWc4UWxrQ01HNENz?=
 =?utf-8?B?Zm9wRy9rc29TRU11dFdRRG5VZVZXTkg3aHpkaWJoM2RSOVpDTUYzc1lrS3VS?=
 =?utf-8?B?QWdsQysxOTM0RjE0c0pYOHBWdlRMZlFNSW5tcDBJNDE4cTBtWi9iNTFvVDI5?=
 =?utf-8?B?ZE1TaHlkSmZZRDJSc0kzbDFwajJhTU51MERTK2wzbEt3QXNkdlVndk1oeTB5?=
 =?utf-8?B?Z3NQQmhvTklsZEd3VDFPQ2JoRmxwRlV2NU5BWTZlaDNSR1B2RlRmd0VMeXp0?=
 =?utf-8?B?VTI3bnVLY2M5MXVtL29sOU1lalpXSndhWlo5OUNzdk9HcG5Id3J3TGUzUGw4?=
 =?utf-8?B?YlNRU1pJblNBWW5QMUhzSUxSS3dwOVVMcTcrYUIrN29lbTVQcXVKTmxDNy9K?=
 =?utf-8?B?S3p4QjJCN0l4cllzamFicmtoQk1UZjNjZW1GVStqQ0t4b0JZdkRjVlQyZXRU?=
 =?utf-8?B?K2JzYWw4cDdiOWUrSmRFR3VkNzRGSGdidEJLWlZ4ejhzWWJrR1VVMEdjNmJk?=
 =?utf-8?B?TmtBRk12cFpCeWxpQThZWFp6Q0ltNFdRbFJjdHBNaEFNTkU0VjdIVnRUTGd6?=
 =?utf-8?B?ZkhtV3kzbXV4UFRxZFFVZkIvTFlpdjdSdmRCRGNHSEpHbzF6WnpNaE4xOTBH?=
 =?utf-8?B?YzR5S01oZVpHR2RjVlBlWWNKKzdnR0tQZzZ3R1g3a0ZZMEZIdk5sL0dTZ1p1?=
 =?utf-8?B?QVdNWG4zVEJTR2I4YkJSSVZwQWxYRkxQc3ZXZ1NqVWdHUWh1L09hYTlyS2t0?=
 =?utf-8?B?aGYwYWc2emd5cXhhMFFYdWV5TjJOOUxKVjVTUFFIUlZ4OXRPRDlIT3NhQ1Jp?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A67E24DB2C228408C8436B6FF1F7680@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db5112c-a5f0-48c5-2c9e-08dc5344eefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 18:44:31.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icjisZ5Sr83vqstx/02mB6zGNQN6ozXc6XPlMlRxhPtIwrqVZs+YrFQl9HK5qYRm4IDA/PZivYLH5X4yZc2pZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDE0OjUyICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
TW9uLCBBcHIgMDEsIDIwMjQgYXQgMTA6MTk6NDdBTSAtMDcwMCwgUnVzcyBXZWlnaHQgd3JvdGU6
DQo+ID4gDQo+ID4gT24gTW9uLCBBcHIgMDEsIDIwMjQgYXQgMTA6MDk6MDVBTSAtMDcwMCwgUnVz
cyBXZWlnaHQgd3JvdGU6DQo+ID4gPiBPbiBNb24sIEFwciAwMSwgMjAyNCBhdCAwNTo0NjoyOVBN
ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCBNYXIgMjgsIDIwMjQgYXQg
MDc6MzU6NTlQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBJ
bHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gVGhlIHNpemUgb2YgdGhlIHN0YWdpbmcgYXJlYSBpbiBGTEFTSCBmb3IgRlBH
QSB1cGRhdGVzIGlzIGRlcGVuZGVudCBvbiB0aGUNCj4gPiA+ID4gPiBzaXplIG9mIHRoZSBGUEdB
LiBDdXJyZW50bHksIHRoZSBzdGFnaW5nIHNpemUgaXMgZGVmaW5lZCBhcyBhIGNvbnN0YW50Lg0K
PiA+ID4gPiA+IExhcmdlciBGUEdBcyBhcmUgY29taW5nIHNvb24gYW5kIGl0IHdpbGwgc29vbiBi
ZSBuZWNlc3NhcnkgdG8gc3VwcG9ydA0KPiA+ID4gPiANCj4gPiA+ID4gU29vbj8gV2hlbj8gWW91
IGNhbm5vdCBhZGQgc29tZSBmZWF0dXJlIHdpdGhvdXQgYSB1c2VyIGNhc2UuIElmIHlvdSBkbw0K
PiA+ID4gPiBoYXZlIGEgdXNlIGNhc2UsIHB1dCB0aGUgcGF0Y2ggaW4gdGhlIHNhbWUgcGF0Y2hz
ZXQuDQo+ID4gPiANCj4gPiA+IFRoZXJlIG1heSBuZXZlciBiZSBhbiB1cC1zdHJlYW1lZCB1c2Ut
Y2FzZS4gVGhpcyBpcyBhIHZlcnkgc21hbGwNCj4gPiA+IGNoYW5nZSBpbnRlbmRlZCB0byBtYWtl
IGl0IGVhc2llciBmb3IgYSB0aGlyZC1wYXJ0eSB2ZW5kb3IgdG8NCj4gPiA+IGJ1aWxkIGEgY2Fy
ZCB0aGF0IHJlcXVpcmVzIGEgbGFyZ2VyIHN0YWdpbmcgYXJlYSBpbiBGTEFTSC4gVGhleQ0KPiA+
ID4gd291bGQgaGF2ZSB0byBhZGQgYSBuZXcgInN0cnVjdCBtMTBibWNfY3NyX21hcCIsIGJ1dCB0
aGV5DQo+ID4gPiB3b3VsZG4ndCBoYXZlIHRvIHJlZmFjdG9yIHRoaXMgY29kZSBhcyBwYXJ0IG9m
IHRoZSBjaGFuZ2UNCj4gDQo+IEknbSBPSyB3aXRoIHRoaXMgZGVzY3JpcHRpb24uDQo+IA0KPiBQ
ZXRlciwgaXMgdGhhdCB3aGF0IHlvdSBtZWFuPw0KDQpZZXMuDQoNCj4gT3IgeW91IGRvIGhhdmUg
YSBib2FyZCB0eXBlIHRvIGZvbGxvdywgaW4NCj4gd2hpY2ggY2FzZSB5b3UgbmVlZCB0byBzdWJt
aXQgdGhlIG5ldyBib2FyZCB0eXBlIGFzIHdlbGwuDQo+IA0KPiA+ID4gDQo+ID4gPiBUaGlzIGNo
YW5nZSBkb2VzIG5vdCBpbnRyb2R1Y2UgYW4gdW51c2VkIGZ1bmN0aW9uIG9yIHZhcmlhYmxlLg0K
PiA+ID4gSXQgaXMgbW9yZSBvZiBhIGNsZWFuLXVwLCBtYWtpbmcgdGhlIGNvZGUgbW9yZSBmbGV4
aWJsZS4NCj4gPiA+IA0KPiA+ID4gQ2FuIGl0IG5vdCBiZSB0YWtlbiBhcyBpcz8NCj4gPiANCj4g
PiBXb3VsZCBpdCBiZSBhY2NlcHRhYmxlIHRvIGp1c3QgY2hhbmdlIHRoZSBjb21taXQgbWVzc2Fn
ZSB0byBzb21ldGhpbmcNCj4gPiBsaWtlOg0KPiA+IA0KPiA+IERvIG5vdCBoYXJkd2lyZSB0aGUg
c3RhZ2luZyBzaXplIGluIHRoZSBzZWN1cmUgdXBkYXRlIGRyaXZlci4gTW92ZQ0KPiA+IHRoZSBz
dGFnaW5nIHNpemUgdG8gdGhlIG0xMGJtY19jc3JfbWFwIHN0cnVjdHVyZSB0byBtYWtlIHRoZSBz
aXplDQo+ID4gYXNzaWdubWVudCBtb3JlIGZsZXhpYmxlLg0KPiANCj4gVGhhdCB3b3VsZCBiZSBt
dWNoIGJldHRlci4NCg0KVGhhbmtzIFJ1c3MsIHRoYW5rcyBZaWx1biwgSSB3aWxsIHNlbmQgYSBy
ZXZpc2VkIHBhdGNoLg0KDQpQZXRlcg0KDQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQoNCg==

