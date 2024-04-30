Return-Path: <linux-kernel+bounces-163346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78E8B69B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DBD1C21469
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18D1754B;
	Tue, 30 Apr 2024 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/m6tAYM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA214AA9;
	Tue, 30 Apr 2024 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453686; cv=fail; b=exRdfwvUMs15717seltGwtK+FaLbHxXDBoqRgBbav7FJOpaVN940YFUgeR3/Emz80Opl1elXdR8ZEJVhe5mwm9loP0XnTtfSs+qjfQ6pkn3P+/ar3pKgey9et/Zvc7EJGKTUPD0AI0qlp3nFEaH28bL6TM5hD1sED/dcqQ4Zizw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453686; c=relaxed/simple;
	bh=jlepd5IDcphohgHEHP1EHa8fdDVqcgEJUQ/I6gx5sOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YoGYDEtuZHoXThkdsWxe7iPlqb9fdS0/VElLMc21sherD/wXThHZDdtMuuHHMwrqPKL7uLwnbgY3UgfpKufokA7+Wyq6anKALGrtdDYHrZeeqIHH3gfqurtSzLSTNv1dCdSU5nR2ABu6xHTeJ46pdlxu15J0P/75AB0O5ZHN4qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/m6tAYM; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714453685; x=1745989685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jlepd5IDcphohgHEHP1EHa8fdDVqcgEJUQ/I6gx5sOo=;
  b=j/m6tAYMCQ3ZCVOPeTnNtyA+Ax9P2Krodhwmre+M1hPxK5kcAbuIJHS/
   KMLLDnTStIAeJRCu1Iq8uKr57ZRpaWyJJOZikcmV5U6C/6ySbT+iDgW0+
   0aNOUTyN/j+SUeWS7KWHiYaJ2nAqaS+J1QssWF8/gJgcQUdXt9OSu/Mj7
   tDVcNLS/d53G/9KIOK0BiwuFCHZipmdzbhUuGjI8jOnsWvs6g5oPCNnq8
   GvxDmq/OWuyZpisMVZDPAtvVGWAsNdmwLlIMJMEB7RXonuaLpaktzI1tb
   B8ZsPEokGqKLkOgURF0AbUFbG0JciI3OeK5vzfnseqDJg9RCq/IHNprc+
   g==;
X-CSE-ConnectionGUID: grjeUl/hQM+P550EdD2N9Q==
X-CSE-MsgGUID: qRvbbw5fSIWZ0dm6Ov62Hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10310040"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10310040"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 22:08:04 -0700
X-CSE-ConnectionGUID: 6Ep+lCmFRj+n/qiggW11lw==
X-CSE-MsgGUID: Syac5U/vSsKVizcM6Zw9uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30813185"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 22:08:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 22:08:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 22:08:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 22:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg+IFdhjpj7YfDLhGCyo8s9Gfxv6eTb2ALIekp/UwovjYrtXmfYzCEU86f8+jJlbJ7EKc9ow/fX3tU8buy7yx28yjTYjYWE4JroxKTmwDe5nmKIjwmfFVuVQInTMl0erqLb/HF07oDSDEnRBRyJJp7nKp6BY3Fk6BwBsHyvDlRqBz64XqCZAGJ78t2OmclPZTRa6qxX7ml4Dh+r1IKGor9JcekiQJtEUUjHG5n3kwrCE0igIKikVw3EvSD7BAhR0QotcIb/eovg58ygVTV1ODCVjw2TzlBpXBNj3qAT06EdevPeywnJ8MANiNtvO5ARFHKRu/djuHODQt0ZaZbWEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlepd5IDcphohgHEHP1EHa8fdDVqcgEJUQ/I6gx5sOo=;
 b=HteKsXCOvEvK4urZMH8Cx/0z61YGvt/pUVWN+efSbOgAMM743OBZXeV/IIS5ivWKyxhxVTy7WY78XBTN0AEI/8BFTz3e0ScN+xIq1YgfXrcQszuXVafVd9SF1wmyf/Q8Ftigx1sjmyXHPqSGgzCr7w9Bh/BVyh0dZ4kkaKqc5VcdVbyxp8hfhEa3rzuq+iknZzVSBIlgch09lC+NX/uQMujvbVNa+bJd3PwRscwcYrNkMyKJZ4Xe3z48iUL0WurDLvedMUXgsNKLBOnQj9gBridZeIFByfuYhGmf8rJqPGetbEixOaGJ+GYpKznmaSHPQNO85IIfZbmVu3eOyElNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 05:07:55 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 05:07:55 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Brown, Len" <len.brown@intel.com>,
	"stanislaw.gruszka@linux.intel.com" <stanislaw.gruszka@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neri,
 Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH 4/4] thermal: intel: hfi: Tune the number of CPU
 capabilities per netlink event
Thread-Topic: [PATCH 4/4] thermal: intel: hfi: Tune the number of CPU
 capabilities per netlink event
Thread-Index: AQHamo3o8WSoHNrFr0a0BhiWD9a3lbGAQ5mA
Date: Tue, 30 Apr 2024 05:07:54 +0000
Message-ID: <849b5bd75707433c6a7d9b854f8e3b5fd17dcba0.camel@intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
	 <20240429234152.16230-5-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240429234152.16230-5-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BL3PR11MB6313:EE_
x-ms-office365-filtering-correlation-id: 41948688-b4b3-4bc5-fa56-08dc68d37e84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MFp3eEtoUXhJM3JHd3JtbkMrekxQekNmUUx5K3VzZGdid3VwZDdjamRTTlZJ?=
 =?utf-8?B?TXBtY2w3QnlaYTJjWU1RWFNFMXMyTUVQbXRzY2pETlV1aStkNFRpUXZ4dVlt?=
 =?utf-8?B?cldtQzdZeGdVdnRGSzRQTjBRb2ZkL2sxeTIyZXowL2t0SFN4ZUhIR1JkRS9Z?=
 =?utf-8?B?MnRuaUMrd0tsYUZkb3ZYdEJIT2ZGRkhNWEduNFNFbEdzSmc1KytncTJPdUt2?=
 =?utf-8?B?ckp0czA2QXNaYWhhZElPckhtNTdqSWhiNUpZQmwrR3Q5SmVWT1UwMEw4RTV4?=
 =?utf-8?B?NDNlaHltREdxN1poUXEwSnNqdzNSWlEwcDlRdm5FTHU3Rmdtc3JITW9pZWVm?=
 =?utf-8?B?d3o1Wjhsc2p4TXgybFNEVzlXdGY4OTVUaGFuRTNpYlBKNTNCNllMUkQwcEVQ?=
 =?utf-8?B?WUYrcWVxczFMZDIxR0Q3TEtQQXpydWdrZDFTNW5TOW5iN1U4TFNSdW5HcnQ1?=
 =?utf-8?B?RHFDaDBQVHRTODVOd21WSlVOZU5oeGVZdzcwekZBSEhFb3c2a2RCZjk0aW5i?=
 =?utf-8?B?TGQ0Q2tKTWVaaUk2ZnhMME5PVjJSYnQ4dEc5UnVtREdoNER4b3U5eldUenhE?=
 =?utf-8?B?a1FZcGdqc0NPcHZZTjJieWEyYjdmZDcrbmhVQ1FMbjhaOUJFY0pQaFRRTnN1?=
 =?utf-8?B?UU9hYVlWTFZxYjd6ekJmQVBIZlBkbEYzQmZOTnhGeS9aS1RORzBWN2NERW1G?=
 =?utf-8?B?Mk00V2h1Tjg4dmV2Vkp1NzR0WjVneTJyQndtd2JjNVNuV3drVzB6d1djbWFM?=
 =?utf-8?B?dTFld3FnNmtlVXBTbGxxbUVITDZ5N3MzQldkWThFYnp5enpLaEVOZEhpMDZa?=
 =?utf-8?B?VGJlR2c5ZUZadWRvSnRTeTA1WUlGaEkxSlpxNkZVZ3hycHoycVQwTndXaWdW?=
 =?utf-8?B?aWtyekprUjgvT2plRk9HSUlJKzNmY1FhbnRPQlV6YmJyMUM0QVBDOE56RWR0?=
 =?utf-8?B?QWEyTEY3ZzRwcWxFaWNVK1Vydm5vWnlsVEdwTkdmdGJKUWNUYk5hRWREeHdZ?=
 =?utf-8?B?cHBNWFhDY0lKcTBkTTBId1BBOEJsTlJrK0dVQjhwWEZhTXoyV1dDS1VDQktL?=
 =?utf-8?B?a2VINVJyTkc0czd6NS8ydVEwVmkwT0pnOXNxWnNnczlBbDJOMVFaOHR3dEVG?=
 =?utf-8?B?YnZOeDlDN0FmVlhEck9SNHVPVGt6c3N2Q3ZwTFlnUXRPeDdRbHE3SVdRQ0hk?=
 =?utf-8?B?UE5uTGdLSEdJS0Z2LzB5K2NzUWR4UFR5UlpkQjlsVlRwdS8yeFlQblM2TVVu?=
 =?utf-8?B?cWMrbWZEbENRSnVVcXd3SGQ2bVI0QW9vcVF5eXdhVFVNbGZZRmZNcFJ4cEJv?=
 =?utf-8?B?S1h4Rm9jVFRPNUNwRDFFNEhQL0lIdC9LWFpqYldYMkQ5SmVuQmFvb1hIa3FS?=
 =?utf-8?B?dDZmNXdDd3F0UXJ3dG5IZ2lCc2hEK3NWWURmSVJMYlFMdFh1RmxzMnoweVA2?=
 =?utf-8?B?elBRSW4rQlFVNXNUT3ErdzVBMnp4UEJIL1dBdnc2QWZxT1R5c1ZGcWtkTnJu?=
 =?utf-8?B?OW5rbXV3RUZtSVNvQTl1MCtzamJmN2JCUGlCUDlKckdXeGQ5NVRtTjVoN3R2?=
 =?utf-8?B?bnJ1VXhpbnAxR3dMaW1EOUNzbC9RcmFiaFZyOVVsU3ZEQlV5M2hIQXhBSXRu?=
 =?utf-8?B?dHdYMzU1WUlPbzQ2bGdMSkZub1M2Z2hOZHBNa09sS3FkMm1YRlFmeWtRZE9I?=
 =?utf-8?B?WTBIM3F6RUc1WXB6UHJrSEE4WlkyUDlnWkswVWp3YTFId3RZSVNzOXB6Si9n?=
 =?utf-8?B?WUZlZUN0VFRrUmR1Qmpya1lKS1RmbEtUQVBZczJ0eDNJTUxYdm55eWo0cy9Q?=
 =?utf-8?B?NkhBOXpJby9MOFoyaWZNZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1pieUpEUmxyWDFSQXhJQ2VhZFdPWS84MHZJTkNuQ0sxTEp5M0tSVnEzRkJI?=
 =?utf-8?B?TjQ1Z2pMY2NwWlJsdC96SUtGdUpzdyszaDYvMzBRcDcvN3QvMlRrQmQzUFFE?=
 =?utf-8?B?a3FoOWRKYlc1TTlMdU9hWHhOaHFtUzJoU1VlRTIwVENTTzhZd2xiWG51VDQ4?=
 =?utf-8?B?T3hyRlZzZWtBaFpkL1B2dmtnMkV1Nm5tQlp6Z2VHNWFUM25CaTFCSXUwS0dN?=
 =?utf-8?B?Um1SUHhkZGhZYmU5dlFCVGlYM0hDZk8xVWZkK0w5S1lRVEY3SmQzSXk2bzN3?=
 =?utf-8?B?QUx5a2MrYXJJaVZibzFJSVhVMkI5MTcwTTF6ckF0aGNwSTFNOUc5Y3RUOVR2?=
 =?utf-8?B?d3BEK2h1OGxLNzNCMnlOaUlTMTE3MDM3MS9PR1JtMHZRTkl4Y3A2Rmg4OC9t?=
 =?utf-8?B?NExvcHR0cEo2aDJvaW9aYU15TFI4SlhaWFRGYnlIbGRtL1FzV1BkR3J0VVpV?=
 =?utf-8?B?Y3BBZTdhcmQ0SnJTcjA0c2R5THlqUTl4amMrMlhic3BpM2VPYjZrbHRFdFla?=
 =?utf-8?B?SjJDOEFpWENBUmYxY3lmTlhSdjZsN2tacjk0QkNqNk1JOTQwT2VWR2F4MVFD?=
 =?utf-8?B?QXZiTUVVUVJyeW1UVlRKSW5CYzFlSHd5QXEwbzJWcFgxL2RMaXRIdEpvK0Ix?=
 =?utf-8?B?cVlLa0hHSHZNQWVWcTNYa0x5Y0ViTXR3ODBVeVF0OWxYb1YrU2xHckovS3By?=
 =?utf-8?B?NFU4N29kL3VuaWdxYVpadXNRUkQ0cThDVThqeW5sZFZYN290MDNVSHRLOHlM?=
 =?utf-8?B?bDJ3aHlwTkUvRG14TUJLTFV0Wm40d2FubWpYaCs1NzVrQTdiRGNkczJlL0FD?=
 =?utf-8?B?SVVDb2F2T1hudEFVZTNQVGRvSUFIYTRiNW5LR3BGTGZrZjQ2QWVGOGlPVUFn?=
 =?utf-8?B?OE81R1ZPS2Jhb1pMQnBLUEY3eU1ic0pRQTZNMFVRaDZKT1pEVHNMQUVoWjJz?=
 =?utf-8?B?ei9wNjhIVi9BYndMWVRGb3l0TnBsOGQ3ZGlQbStHMGgxS2NMcVNEWFdYL0I1?=
 =?utf-8?B?cVBFc1NFek9IVndCaFZEZnYvRkhEa2J0TFRNM0NDVXZGR0ozUFF1ZUNGM0Vj?=
 =?utf-8?B?SlBBVHNCbEVnM0d6cTRQcStQdDFlRGpHVzZWakdQUndGMDJZakJmN3lxMlhl?=
 =?utf-8?B?Q0w1akRvbkl3cFNJaTViTzFveUxDSVJvbnJLVWJzdmw3bmpXN0ZFU2k1T3Bz?=
 =?utf-8?B?eGgwQmswZmVhWnZtSlY3VUZrcGxNbWNOdXB2WmtPTkNjM1Y1SnpnZlNsUjVW?=
 =?utf-8?B?bWNUWk9ndVlQOGlHblR0UnlSQ0ZtcUtJdHFTVEtGUU1za3RHRHNjTzhDZ1Nv?=
 =?utf-8?B?SDVrdlJPN2swWElHK0N5WVFLOUxWZWZaMmM1L3FZaThzVWxMRjV1QndGMDdI?=
 =?utf-8?B?UUJScTMvSCtITGV2UHpJZVA1M3d4SUhOR3BJd0NUY3BBU2o4bE5BTThITWxn?=
 =?utf-8?B?aE11S2YwbFVYRXRxZzVxWDFHdVJPWVBTVzZpbUw3UHFMYVUvS2RwZEZmd0pM?=
 =?utf-8?B?M2p3MmNRNUp1d01IM29XT3pXWmQremwrc1h0UmF2dHFVd3JjK2Q5djFRcW5r?=
 =?utf-8?B?MzlNbnVqUEdGWjI0c0hLeDh5QWQ0TTRQZ0t3KzVWNXhRQXU5MGRIKzN3cTB6?=
 =?utf-8?B?eXZqUWc5QUFkcnNPaXJTL2RjWml3akVvV0NHVXZWZnNvS3dPbjdGNE9YbjJJ?=
 =?utf-8?B?enV3YklDZ0xRQzFVdGtERHZSaEZ3Sk5hSGdLRjNRaHM5Ky9yUnpYSlFjMi9a?=
 =?utf-8?B?RTFFK05hZmFBVmlyTlZhVG9BaFN3L21pM0ZQZ3JHSE5teThtVmc2VnBNTHpI?=
 =?utf-8?B?ZER6ZUNrSXJYYm8vS1YrVnpURW9rVXA3cU5kU3U5OHVZK2ovcSs0dWFSd2ZD?=
 =?utf-8?B?eHA2L1FsKzJ4VHRodlZYVjkxN1pkMnZNVmo5RVRYRW1ZTmE3cHY0cGE0cW0y?=
 =?utf-8?B?YzhWWEVITzFlcUcwN0cvaCtibEZNMlBiVHp6RnlSTkNsMElvclA4aDM2Z0FE?=
 =?utf-8?B?bk5kb29rdDlmeWpsQ2RvTEtQODBmRXRFQ0ZMTTJiQURtWUlMNk5yMTlhTndV?=
 =?utf-8?B?NURlanBNNDJJTTI1K1o1MmlHRU1RWm5idGtyRzNsVjRIcVRVR081eXJOMEZ0?=
 =?utf-8?Q?dDOmi0W9EB6L+2MSctXigdMjW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DE3E8D029B32E49B5B038EC3A861540@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41948688-b4b3-4bc5-fa56-08dc68d37e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 05:07:54.9713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czk6Nd2OgKcInruxy69+EfN6hjZlE6BLniES6bMZNNo9g9DwgYAo+FoT7KFGxhaSrkHwJJEk6jx7pOcBrDDZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDE2OjQxIC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6Cj4g
VGhlIG51bWJlciBvZiB1cGRhdGVkIENQVSBjYXBhYmlsaXRpZXMgcGVyIG5ldGxpbmsgZXZlbnQg
aXMgaGFyZC0KPiBjb2RlZCB0bwo+IDE2LiBPbiBzeXN0ZW1zIHdpdGggbW9yZSB0aGFuIDE2IGl0
IHRha2VzIG1vcmUgdGhhbiBvbmUgdGhlcm1hbAo+IG5ldGxpbmsKPiBldmVudCB0byByZWxheSBh
bGwgdGhlIG5ldyBjYXBhYmlsaXRpZXMgd2hlbiBwcm9jZXNzaW5nIGFuIEhGSQo+IGludGVycnVw
dC4KPiBUaGlzIGFkZHMgdW5uZWNlc3Nhcnkgb3ZlcmhlYWQuCj4gCj4gTWFrZSB0aGUgbnVtYmVy
IG9mIHVwZGF0ZWQgY2FwYWJpbGl0aWVzIHBlciBldmVudCB0dW5lYWJsZSB2aWEKPiBkZWJ1Z2Zz
Lgo+IFVzZXJzIGNhbiB0aGVuIGV4cGVyaW1lbnQgd2l0aCBkaWZmZXJlbnQgdmFsdWVzLgo+IApJ
cyB0aGVyZSBhIGxpbWl0YXRpb24gYWJvdXQgdGhlIG51bWJlciBvZiBDUFVzIHN1cHBvcnRlZCBp
biBvbmUgbmV0bGluawpldmVudD8KCklNTywgd2Ugc3RpbGwgaGF2ZSB0byB1c2UgYSBmaXhlZCBu
dW1iZXIgaGVyZSBiZWNhdXNlIGRlYnVnZnMgY2FuIGJlCmNoYW5nZWQgYnkgc29tZW9uZSBlbHNl
LCBhbmQgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIGxpa2UgaW50ZWwtbHBtZApjYW5ub3QgbWFrZSBh
c3N1bXB0aW9uIHRoYXQgdGhlIG5ldGxpbmsgbWVzc2FnZSBmb2xsb3dzIHdoYXQgaXQgc2V0LgoK
b3IgY2FuIHdlIGFwcGVuZCBvbmUgbWFnaWMgaXRlbSBpbiB0aGUgZW5kIG9mIG9uZSB1cGRhdGU/
CnVzZXJzcGFjZSBjYW4ganVzdCBjaGVjayB0aGUgbWFnaWMgaXRlbSBubyBtYXR0ZXIgdGhlIG51
bWJlciBvZiBDUFUgcGVyCm5ldGxpbmsgZXZlbnQuCgp0aGFua3MsCnJ1aQoKPiBXZSBhbHJlYWR5
IHRha2UgdGhlIGhmaV9pbnN0YW5jZV9sb2NrIHdoZW4gc3VibWl0dGluZyB0aGVybWFsIG5ldGxp
bmsKPiB1cGRhdGVzLiBVc2UgaXQgdG8gc2VyaWFsaXplIGRlYnVnZnMgYWNjZXNzZXMgdG8KPiBo
ZmlfdGhlcm1fbm90aWZ5X2NvdW50Lgo+IAo+IFN1Z2dlc3RlZC1ieTogU3Jpbml2YXMgUGFuZHJ1
dmFkYQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5jb20+
Cj4gLS0tCj4gQ2M6IExlbiBCcm93biA8bGVuLmJyb3duQGludGVsLmNvbT4KPiBDYzogU3Jpbml2
YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Cj4gQ2M6
IFN0YW5pc2xhdyBHcnVzemthIDxzdGFuaXNsYXcuZ3J1c3prYUBsaW51eC5pbnRlbC5jb20+Cj4g
Q2M6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KPiBDYzogbGludXgtcG1Admdlci5r
ZXJuZWwub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiAtLS0KPiDCoGRy
aXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxf
aGZpLmMKPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYwo+IGluZGV4IGQ2ZDM1
NDQ1MDlmYy4uZDUxNjNiOTc2NmMwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnRlbF9oZmkuYwo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYwo+
IEBAIC0xNzUsNiArMTc1LDcgQEAgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpoZmlf
dXBkYXRlc193cTsKPiDCoAo+IMKgLyogS2VlcCB0aGlzIHZhcmlhYmxlIDgtYnl0ZSBhbGlnbmVk
IHRvIGdldCBhdG9taWMgYWNjZXNzZXMuICovCj4gwqBzdGF0aWMgdW5zaWduZWQgbG9uZyBoZmlf
dXBkYXRlX2RlbGF5ID0gSEZJX1VQREFURV9ERUxBWTsKPiArc3RhdGljIGludCBoZmlfdGhlcm1u
bF9jYXBzX3Blcl9ldmVudCA9IEhGSV9USEVSTU5MX0NBUFNfUEVSX0VWRU5UOwo+IMKgCj4gwqAj
aWZkZWYgQ09ORklHX0RFQlVHX0ZTCj4gwqBzdGF0aWMgaW50IGhmaV91cGRhdGVfZGVsYXlfZ2V0
KHZvaWQgKmRhdGEsIHU2NCAqdmFsKQo+IEBAIC0yMDUsNiArMjA2LDI1IEBAIHN0YXRpYyBpbnQg
aGZpX3VwZGF0ZV9kZWxheV9zZXQodm9pZCAqZGF0YSwgdTY0Cj4gdmFsKQo+IMKgREVGSU5FX0RF
QlVHRlNfQVRUUklCVVRFKGhmaV91cGRhdGVfZGVsYXlfZm9wcywKPiBoZmlfdXBkYXRlX2RlbGF5
X2dldCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aGZpX3VwZGF0ZV9kZWxheV9zZXQsICIlbGx1XG4iKTsKPiDCoAo+ICtzdGF0aWMgaW50IGhmaV90
aGVybW5sX2NhcHNfcGVyX2V2ZW50X2dldCh2b2lkICpkYXRhLCB1NjQgKnZhbCkKPiArewo+ICvC
oMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmhmaV9pbnN0YW5jZV9sb2NrKTsKPiArwqDCoMKgwqDC
oMKgwqAqdmFsID0gaGZpX3RoZXJtbmxfY2Fwc19wZXJfZXZlbnQ7Cj4gK8KgwqDCoMKgwqDCoMKg
bXV0ZXhfdW5sb2NrKCZoZmlfaW5zdGFuY2VfbG9jayk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
IDA7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgaGZpX3RoZXJtbmxfY2Fwc19wZXJfZXZlbnRfc2V0
KHZvaWQgKmRhdGEsIHU2NCB2YWwpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZo
ZmlfaW5zdGFuY2VfbG9jayk7Cj4gK8KgwqDCoMKgwqDCoMKgaGZpX3RoZXJtbmxfY2Fwc19wZXJf
ZXZlbnQgPSB2YWw7Cj4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZoZmlfaW5zdGFuY2Vf
bG9jayk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gK30KPiArCj4gK0RFRklORV9ERUJV
R0ZTX0FUVFJJQlVURShoZmlfdGhlcm1ubF9jYXBzX3Blcl9ldmVudF9mb3BzLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhmaV90aGVybW5sX2NhcHNf
cGVyX2V2ZW50X2dldCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBoZmlfdGhlcm1ubF9jYXBzX3Blcl9ldmVudF9zZXQsICIlbGx1XG4iKTsKPiDCoHN0
YXRpYyBzdHJ1Y3QgZGVudHJ5ICpoZmlfZGVidWdmc19kaXI7Cj4gwqAKPiDCoHN0YXRpYyB2b2lk
IGhmaV9kZWJ1Z2ZzX3VucmVnaXN0ZXIodm9pZCkKPiBAQCAtMjI2LDYgKzI0NiwxMSBAQCBzdGF0
aWMgdm9pZCBoZmlfZGVidWdmc19yZWdpc3Rlcih2b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
IWYpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycjsKPiDCoAo+ICvC
oMKgwqDCoMKgwqDCoGYgPSBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJ0aGVybW5sX2NhcHNfcGVyX2V2
ZW50IiwgMDY0NCwKPiBoZmlfZGVidWdmc19kaXIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTlVMTCwKPiAmaGZpX3RoZXJt
bmxfY2Fwc19wZXJfZXZlbnRfZm9wcyk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFmKQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycjsKPiArCj4gwqDCoMKgwqDCoMKgwqDC
oHJldHVybjsKPiDCoGVycjoKPiDCoMKgwqDCoMKgwqDCoMKgaGZpX2RlYnVnZnNfdW5yZWdpc3Rl
cigpOwo+IEBAIC0yODYsMTYgKzMxMSwxNSBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfY2FwYWJpbGl0
aWVzKHN0cnVjdAo+IGhmaV9pbnN0YW5jZSAqaGZpX2luc3RhbmNlKQo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoGdldF9oZmlfY2FwcyhoZmlfaW5zdGFuY2UsIGNwdV9jYXBzKTsKPiDCoAo+IC3CoMKg
wqDCoMKgwqDCoGlmIChjcHVfY291bnQgPCBIRklfVEhFUk1OTF9DQVBTX1BFUl9FVkVOVCkKPiAr
wqDCoMKgwqDCoMKgwqBpZiAoY3B1X2NvdW50IDwgaGZpX3RoZXJtbmxfY2Fwc19wZXJfZXZlbnQp
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGxhc3RfY21kOwo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoC8qIFByb2Nlc3MgY29tcGxldGUgY2h1bmtzIG9mIEhGSV9USEVSTU5M
X0NBUFNfUEVSX0VWRU5UCj4gY2FwYWJpbGl0aWVzLiAqLwo+IMKgwqDCoMKgwqDCoMKgwqBmb3Ig
KGkgPSAwOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpICsgSEZJX1RIRVJNTkxfQ0FQU19Q
RVJfRVZFTlQpIDw9IGNwdV9jb3VudDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpICs9IEhG
SV9USEVSTU5MX0NBUFNfUEVSX0VWRU5UKQo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB0aGVybWFsX2dlbmxfY3B1X2NhcGFiaWxpdHlfZXZlbnQoSEZJX1RIRVJNTkxfQ0FQU19Q
RVJfCj4gRVZFTlQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGkgKyBoZmlfdGhlcm1ubF9j
YXBzX3Blcl9ldmVudCkgPD0gY3B1X2NvdW50Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGkg
Kz0gaGZpX3RoZXJtbmxfY2Fwc19wZXJfZXZlbnQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHRoZXJtYWxfZ2VubF9jcHVfY2FwYWJpbGl0eV9ldmVudChoZmlfdGhlcm1ubF9jYXBz
X3BlCj4gcl9ldmVudCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAmY3B1X2NhcHNbaV0pOwo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgY3B1X2NvdW50ID0gY3B1X2Nv
dW50IC0gaTsKPiDCoAo+IMKgbGFzdF9jbWQ6Cgo=

