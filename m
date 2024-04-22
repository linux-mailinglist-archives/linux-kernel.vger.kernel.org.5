Return-Path: <linux-kernel+bounces-153760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747318AD2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE01281250
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914FE153831;
	Mon, 22 Apr 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNE4tKm0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF51514E2;
	Mon, 22 Apr 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805049; cv=fail; b=ZXOE35ZxOvdhMsfMyDbaYF7XVq02U6kheOW8qF/ZHdrktCfzF71aIxQqu1hgCI5DPjQwoxca/qbCHN1Fpz1IITo5ahmB5cWqXN/V+r8sxqTrZ2LRC4utF+9DcFm/qqW9MmVLpBlNN8FRXK4glrgV0si+yjusfJIPiqUwMzKuGiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805049; c=relaxed/simple;
	bh=QcXmLnCOgrV5I5NbzNwLw1O/9YK7Wz5ze077LLNS9lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/usmmgin1OHoLyAG4m/UxmIgef0pEISOqcAhYTltSHNOHafmXyynViYh11k0Iz2pV8CwIaeSUjGvGpyZcKa73yfpVVR0/DYAq+qAazCiziSah6rI9eCNhp1fI9u6kzkss5vtj+Vfr3QX8EETqa/HqKKkXkE3unvlLQwdv+gBMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNE4tKm0; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713805047; x=1745341047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QcXmLnCOgrV5I5NbzNwLw1O/9YK7Wz5ze077LLNS9lU=;
  b=CNE4tKm0XYyuclU7XVAF5QvuLJTANCNdeUMJi/6L8+HjjB7XYxgKTGBd
   0ptQbdme16VXUCsl0Wg3EEtp7QvawwTUCvJ5Kks1hX3wxdnVwFLEITdmi
   8/KbOsy4dalwkw2bK17LSrUKLaB9VSNj1I/CgraRMdHSdpBJ7m/3lPfcJ
   2JUZ6pTjuRiXpxmQm/CZ9wKuoKIXSBWiDzWZx83sPRuyRj6MBYQaTVm/5
   hlbcaPK55a89UbFNnEFRJ0NG27x+PdiTE9dIZ38wPhAWM/8q56u3SYoZe
   QgD+PIpxH0Z6eyBIOywkGt7FiWwWKPn+nbUSELTtk8duaJOPcsyziYp24
   g==;
X-CSE-ConnectionGUID: ilIqvPxBTYeHK5KrYAylUQ==
X-CSE-MsgGUID: xnR44I0YRCeMm0JN608Zqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26809098"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="26809098"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:57:27 -0700
X-CSE-ConnectionGUID: PxWi1I8cT6KiyxMa86rgIA==
X-CSE-MsgGUID: seGxXqq9T9aP6lvTGFbJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28859553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 09:57:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 09:57:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 09:57:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 09:57:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:57:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA5+Dv6VtW8BnpdtOv2g9OWBGaaljZa8DrGU9Ju0EPpwZyD4jtm45RbC3uua1O9A92fyGgqW/iYnQnFUHOg4m1ROElhmJ1+oobA4p8RMTwUU7ztaMOMdVV36wNYjCIgJSWpKPN3Y4B/Q6eYUfOFh9rWDa1BOh4hJM6YHNHsA/WEo1JF9fwVwhkQECZOmOI5K7QXQYXbzZFfh6emFfNVysMwPxBqjvbEx2ckxRGw5m629NOMrtfo+BftX9m+lxS26LgeLFkmdlLTJpxpnFeUb1YhrwRgeRV/uSniB5DTQFUnrupIw6eZLF7ZOQp+qCyC+na/V6gX892OoDIyarJLk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcXmLnCOgrV5I5NbzNwLw1O/9YK7Wz5ze077LLNS9lU=;
 b=QfVhwZljplpEtCbQ7a0o1KUToYHPTKHvECNOS5k8nPYwp0Tfgt2rKFf6tjPPFnqs0DEjY/W57Nl7Ggxl765DMwwk69mHVnxsqFWgCCuYrkHjTE30Nh90NvlyfUfUDTjkmPSBypiiSjdrdQcm6LRMt4FFGFLEaUsuDcoPtUkQiFhStVKc8+2r6wY1HZ5yAmi6O5auWX3FjAYjBm1djSce77feOM1d8qozzxkChvk8r4Bg7tmJi+aGoBaqGOW/xH1l/lvupXcI5X+N8DTb98nfG5k3LorkYIBkNTkViMdvXY0HI+G0T2uDgdJRrgUe8gTvL1d8Rrm0nZF5hEbTTSRz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6902.namprd11.prod.outlook.com (2603:10b6:510:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 16:57:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Mon, 22 Apr 2024
 16:57:23 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH] x86/mce: Implement recovery for errors in TDX/SEAM
 non-root mode
Thread-Topic: [PATCH] x86/mce: Implement recovery for errors in TDX/SEAM
 non-root mode
Thread-Index: AQHaid/3N/IOIBD6MUmfsB3UuoLE7rFuZTUAgAYwVCA=
Date: Mon, 22 Apr 2024 16:57:23 +0000
Message-ID: <SJ1PR11MB6083B1533EA1AB79F091B3A4FC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240408180944.44638-1-tony.luck@intel.com>
 <354cce06-b1b9-4523-9b71-d0576eb3a01f@amd.com>
In-Reply-To: <354cce06-b1b9-4523-9b71-d0576eb3a01f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6902:EE_
x-ms-office365-filtering-correlation-id: db25b1f8-72dc-4b0d-160a-08dc62ed47d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZmRDdG1QOW4yUzFreCs1OHhjYXF5V0pMOEhoTmdnZFQ2WUJLaVVndmh0T2t3?=
 =?utf-8?B?Z2R6TSsxQy84UnIrckNZREJCeHJaUW9td3lzZGFTOHBzM3JGVWVnNUY3blJa?=
 =?utf-8?B?TTBjdG05T000Qm1FZE5BdDR6TlJFcXFaaW56d0dEcjllblplZ1MzWWJzR3hk?=
 =?utf-8?B?Ylh3VGRvbnF6cXFkQVI5SVEzYXlWY21NT1BrUnkrYzFlUHVGY29OcEJZRnpZ?=
 =?utf-8?B?aG1rdk9iK2hCLzcwc0ZkNXVLTkZCaDhEbzhLelJ0Y2xqT25QOFJYdHhlWDNQ?=
 =?utf-8?B?S1Y1Uy9JL3VyK3BBaE9FUVlmcnhlRGVCVUwxMWkxQVFTUXNHcU1uS1FsSTFG?=
 =?utf-8?B?N05ZRjI5V0UxWExWeVpKM2hqbFhwTnFiT3Y5eG1pRFBibVZvam5tbDE0SVhz?=
 =?utf-8?B?Ky8zUmJwMnA0QVk5ZTZ4UkRyQnluV3ZaMFV6S0kvUkpaMGczQjhERGRXci82?=
 =?utf-8?B?elpUclVRYy9SRmFhNVZkTk5BaDJoUDZJN29rOUUzalVNUEZxSWkzbUNDd2cv?=
 =?utf-8?B?SUJ0a1pwenZLU3NGaTMwR2c0Tzg2ZEh3YmR0cDBTUGZHQXNTM2h1Vk1yVTNK?=
 =?utf-8?B?VDV4cytmeXpjaisxc1h5Q0Z0Ym93bnN3ZEVHQ1pBTXdaSFVyM2RINnd6Znls?=
 =?utf-8?B?MXlRazcwUE5SLzBnVVp5MFA1WE02ejFEcTM2bXBJVmo1b09NWnhCdFdFWTh3?=
 =?utf-8?B?aVBFTTh5RHk3SnRzSXNqSUZ0ZUpFdVNaVDc4VlhXbG93U0pzdTJ3U3ZyTU1G?=
 =?utf-8?B?Sk1hZm92M1J0SUlwQjh1KyswUi9DZlZzYk5xSnArVFArelR2Qjh6ei80QW1z?=
 =?utf-8?B?VDJ1Mit1VXU3SlhickI0Nzgrc3NoNEpKMWk0NUN0M0JXRzdsbEd4RUN2TjEw?=
 =?utf-8?B?ak1iMnBReVNYbmtVOHIwYVdDMW53S0wzb3dOdC9KUnJIOGhQZWV4ZlFtb2Jj?=
 =?utf-8?B?R0laT2poMkJCcXc2TmcwNXJVc3NGRmFhcEJuZ1RaMVhSVUJrQm5mVlRYUkZB?=
 =?utf-8?B?K3M2UHJKRStUQkdBUjYvRlNGQlNtdmRabG1veFlIclI1TElkeXg5NGRndjR4?=
 =?utf-8?B?dnNxTTB3QVFwSW43Mm5lellCSi91OE43MmdLZ1pqSWJkUnEwZVRaYTQ3UFpD?=
 =?utf-8?B?eStMdW5RdkVnZUZmZ2luQ3pnRGR6ZUtveFArYXlYdTV5czFTMCtqYThZQzZK?=
 =?utf-8?B?TXk2aDdHWHBEZ2E0elZIdUUyaDFQZkpQSWxrQ2lmM28zaUFQMk1xaVlLelM1?=
 =?utf-8?B?Mlg2U3NHRC9aRUN2cWE4aDE0T1JHOFVSSUxMTnVRUWd4VS83WEtXOWtCZmNM?=
 =?utf-8?B?YVhoeEJ0UllrYndUeDRoTlBCTjJRb3pPck9odm9SdWxEK0tPckhIbHA1SU9Q?=
 =?utf-8?B?dWVyV1dEQi8rUlI1VlV5WDZpbVJIZVRYYm83d1RoWUJ5aVhyVWFsYm0zeXNw?=
 =?utf-8?B?UmJIb1hoLzU1YUNZY1NCUjNyeGdPd2RxRDZkZDFBaHFtZ0lPTGdGNjl1dVpE?=
 =?utf-8?B?dlE4QkhUUHY1dThkU0NneVc4QW5JWkNybms4WEhrUG03TnpPOFJsQnk5VVI1?=
 =?utf-8?B?YXk4WitxNXV1b1p0SUV6VjFZYThTWHFmYjhBNmFmbVpNVkVIQU5Kd2hYY08w?=
 =?utf-8?B?OEljVWlwUUVNeW5veXIvcUFJQUJyakhvTVBmSFZWZi92MjVBWmFBN0xzK0oy?=
 =?utf-8?B?emNCdFhOSytqN1pUeUgzdVhaYWZ4aUdQa05sdC9NTHU1RU9zMWxTVFphdGdS?=
 =?utf-8?B?VER1OTI2aVpmdlNmV29yRUY0SEVPWFpJb0dRWmpxQm1UT2xqODF0NEp4c1Ri?=
 =?utf-8?B?OW9ZZ0ZVM1ZqVTI5QUNqdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUw3N2VkQzhibUtXZCtJWG9qcHBvc3hzU2QrUW9FRy9CYkRCRHg3ejFnU3ZB?=
 =?utf-8?B?K2pXQm94cGkzb3Q0MDlkQVR2N0RIU1pQUGF3S1I2SFlFZkJWUnRDQXo2cUNx?=
 =?utf-8?B?OWRwdUllL2lXL1BzaGV6MW42cWl4TmxuaVZXUmJkVmNzSU8xeWRoNXZSYXBJ?=
 =?utf-8?B?OWtVeDRGZStXdTIxWk4wRUpMTEhHZWRwbDEzMmdVTnJJOUc5YmN1cDlCMFBP?=
 =?utf-8?B?UUI2OFZON0NXTzNya0s0K0RiQTMyakZsd05WVlJITVVtc3BNSFpNR0piR1A0?=
 =?utf-8?B?d3pIN2Z1RjJmbmVMcS96U2xkdzZOMHNrK1pEVUF6blFHamlSd0V5a3ZnUFgv?=
 =?utf-8?B?RUw0WUlsWHpLRmJOUDVvNEhGY09QblBZbDhZcTFpajdIVlVYckZHZGQ4V2JM?=
 =?utf-8?B?dnJLdmo5ckJGWjhZeG52RzVkTkJVUTZLWkg0clVPQUJEQ0JZaGZ4OEUzZnRC?=
 =?utf-8?B?eW44K3ZiMDZBQjVFbC9TaVBxNDRZWVowTkNxbkQrQUJyaUl6ZXNNWkhoTDNa?=
 =?utf-8?B?UXZzcGl2OVFlL0lSa1NybklVS0RqMXhGdTFiZGl5cGp5Nk8waGg1KzZycGhw?=
 =?utf-8?B?TTlJbmQ2Ylg1eCswc3FwcnNmbENVNVNUQ0xCdUs2VHl5eXNlRU5La2l3aWxP?=
 =?utf-8?B?Z3RDZTlHQ0xnT0FJZ2FzY2VRd0s0Y0diQkl1WTFYTEFCdUs3SVUwNHluWHBi?=
 =?utf-8?B?YVVpU3VVT0FwMC83c3VaajBwUDExRE51UDBwYzdqRzI3b20xV3FxbWliVm8x?=
 =?utf-8?B?cUc3ZjFLL2EvMm5pSlBZN0U0UTJubXlHUlN5KzFlSWlDMU5TWW5BQU91UGwx?=
 =?utf-8?B?VHJkV3ZhWjFLd1grSlJsd2NPQlFvT2dOL1dDRFF5aVg4OStsRElwSEV0NWxj?=
 =?utf-8?B?akw4dU5UZzJYM2RSdzdxRGs5WUpwZ0xjUGFwWTJJSzdZbFg0SzFLRVdpUkRU?=
 =?utf-8?B?aHVZZ1E0ZXZNVlRHK2MzenBJWjFkRU53U1F3eHBLWDM5SG92RXlPUE1PLzZJ?=
 =?utf-8?B?ZjI5citPZXhpczBPb0RTSi9qeDF4WHErS3gwTHRnamZqY2MzLy9TM2xpeTE1?=
 =?utf-8?B?UDdIZDdRWjJaWldyOW1kekp2MnQzeWlFYThWc0t3eTN3RmF0MDBLU1VuU3BD?=
 =?utf-8?B?VWhsdjhqT21RTUI0TkQvNlBkRVMrLytFN1hUSGpjRkFscnFpQm81d0dsSGw5?=
 =?utf-8?B?bmdSL3g2VENlRTJDbzIwSHFNWTdOMWtyd2dRdWx2eXdnRWR0d0lST2lIL3c2?=
 =?utf-8?B?YmFwR2ZsTUZUQjZMbHBNRXZibGpYRHloM2tPZGRMY21iSk55dVY2d3pYVzdy?=
 =?utf-8?B?d2Qwc3NPNW1zMGNSNjlsb1RxODdxQitqRndXbE9kSGQ2TW4wTDJGeGNMQ1ZI?=
 =?utf-8?B?Z09qRXVWMi9qRTlRTTBwNnZ0YUZvZmNKVnF2T2JqU0J5VEdhT0JsZzVzaTF4?=
 =?utf-8?B?cWpUTHYzOHQ1d1hFZWt1NWxTN2ZzNW50VzB3Mnpic1lPbmZXNHNiQ0VvWEZY?=
 =?utf-8?B?dEZkaTZrcllqYzhUeEF6NC9qdVJwNTNaamJKL1psT3lKTU10cE91Y1dvVnlJ?=
 =?utf-8?B?UTdhakxldGQ4RUZPdFJKZ2xLK2toaWlVNmlUTC9RbHFDeXg2czFCVFY2WDVC?=
 =?utf-8?B?UXYxenNkd2dsZldvYU1mTlJISzFUWVd1UnNUL3I3eEk3dkFPZ0wvTm9UQ2ls?=
 =?utf-8?B?Vm9JRzVhVnZ0amxZWjVIRFVkOU9sWE1QU0Q2blcyeE55S2VnZy9QUVVvRFpM?=
 =?utf-8?B?bEFRZDBsK0Iwa1ljQTRnTEwzMnpXc1hXeEs0RzR3UTZuSEdvT2xaUzBjT0kr?=
 =?utf-8?B?U0NtWVFNUlZMT0dEZVZHTjlQNUhHU1B4Z2Z0K2NSZWpyVUpDaW5WYnRWREJJ?=
 =?utf-8?B?a2xKYlgxb1lRRVZ0MGtzcEJONXF5SkZsWUp4TEowNVorMWNKRnFna0x1L2pU?=
 =?utf-8?B?aUhLZEZPNHhnZkVrTk5aU3l4VnE1VjNQQWtXU1JSVUxrQit1cjNVS25CUERy?=
 =?utf-8?B?TncxeU9CSjNteDF6cFQrNW9ueVN4R2JzUUZkeDZiM0lEQ0d6TkwzTWl5bXdv?=
 =?utf-8?B?S0IvWjhVdVQ5MCtVQWRnbjlTSWh5cEIyRFdvR0FMY0gyOVJ5bkxtR3Rjdzl3?=
 =?utf-8?Q?1hlSyX4TQ1El9jf91Fj/EV5Kw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db25b1f8-72dc-4b0d-160a-08dc62ed47d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 16:57:23.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUqVHIes1gdRrL4r+9xmI0uJihWcilcyL3X6zHD61iAqlflSyYiP+KEDxiYDp85NXxacjuMnbuO+FypxVNch7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6902
X-OriginatorOrg: intel.com

PiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPiA+ICsrKyBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPiA+IEBAIC0xNTkzLDYgKzE1OTMsMjQgQEAgbm9p
bnN0ciB2b2lkIGRvX21hY2hpbmVfY2hlY2soc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ID4gICAg
ICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgcXVldWVfdGFza193b3JrKCZt
LCBtc2csIGtpbGxfbWVfbWF5YmUpOw0KPiA+DQo+ID4gKyAgIH0gZWxzZSBpZiAobS5tY2dzdGF0
dXMgJiBNQ0dfU1RBVFVTX1NFQU1fTlIpIHsNCj4NCj4gTUNHX0NBUFsxMl0gKE1DR19TRUFNX05S
KSBzaG91bGQgYmUgY2hlY2tlZCBmaXJzdCwgY29ycmVjdD8gVGhpcyBjb3VsZCBiZSBhDQo+IG5l
dyBtY2VfdmVuZG9yX2ZsYWdzIGZpZWxkIHNldCBkdXJpbmcgTUNBIGluaXQuDQoNCkZvciBhYnNv
bHV0ZSBhcmNoaXRlY3R1cmFsIHB1cml0eSB5b3UgYXJlIHJpZ2h0LiBCdXQgdGhlIE1DR19TRUFN
X05SIGJpdCBoYXMgbmV2ZXIgYmVlbg0KdXNlZCBpbiBJQTMyX01DR19TVEFUVVMsIHNvIEkgZmVs
dCBpdCB3b3VsZCBqdXN0IGJlIGV4dHJhIG5vaXNlIGluIGEgYnVzeSBwaWVjZSBvZiBjb2RlDQp0
byBhZGQgaXQuDQoNCj4gPiArICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAqIFNhdmVk
IFJJUCBvbiBzdGFjayBtYWtlcyBpdCBsb29rIGxpa2UgdGhlIG1hY2hpbmUgY2hlY2sNCj4gPiAr
ICAgICAgICAgICAgKiB3YXMgdGFrZW4gaW4gdGhlIGtlcm5lbCBvbiB0aGUgaW5zdHJ1Y3Rpb24g
Zm9sbG93aW5nDQo+ID4gKyAgICAgICAgICAgICogdGhlIGVudHJ5IHRvIFNFQU0gbW9kZS4gQnV0
IE1DR19TVEFUVVNfU0VBTV9OUiBpbmRpY2F0ZXMNCj4gPiArICAgICAgICAgICAgKiB0aGF0IHRo
ZSBtYWNoaW5lIGNoZWNrIHdhcyB0YWtlbiBpbnNpZGUgU0VBTSBub24tcm9vdA0KPiA+ICsgICAg
ICAgICAgICAqIG1vZGUuICBDUFUgY29yZSBoYXMgYWxyZWFkeSBtYXJrZWQgdGhhdCBndWVzdCBh
cyBkZWFkLg0KPiA+ICsgICAgICAgICAgICAqIEl0IGlzIE9LIGZvciB0aGUga2VybmVsIHRvIHJl
c3VtZSBleGVjdXRpb24gYXQgdGhlDQo+ID4gKyAgICAgICAgICAgICogYXBwYXJlbnQgcG9pbnQg
b2YgdGhlIG1hY2hpbmUgY2hlY2sgYXMgdGhlIGZhdWx0IGRpZA0KPiA+ICsgICAgICAgICAgICAq
IG5vdCBvY2N1ciB0aGVyZS4gTWFyayB0aGUgcGFnZSBhcyBwb2lzb25lZCBzbyBpdCB3b24ndA0K
PiA+ICsgICAgICAgICAgICAqIGJlIGFkZGVkIHRvIGZyZWUgbGlzdCB3aGVuIHRoZSBndWVzdCBp
cyB0ZXJtaW5hdGVkLg0KPiA+ICsgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgIGlmICht
Y2VfdXNhYmxlX2FkZHJlc3MoJm0pKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
cGFnZSAqcCA9IHBmbl90b19vbmxpbmVfcGFnZShtLmFkZHIgPj4gUEFHRV9TSElGVCk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgICAgICAgaWYgKHApDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNldFBhZ2VIV1BvaXNvbihwKTsNCj4gPiArICAgICAgICAgICB9DQo+DQo+IEkg
dGhpbmsgdGhpcyBpcyBva2F5LCBhbmQgaXQgY291bGQgZXZlbiBiZSBtb3JlIGdlbmVyYWxpemVk
IGFzIGEgInBhZ2UNCj4gb2ZmbGluZSIgYWN0aW9uLg0KPg0KPiBIZXJlJ3Mgc29tZSBXSVAgZm9y
IGEgZ2VuZXJpYyBNQ0UgImFjdGlvbiB0YWJsZSI6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9BTURF
U0UvbGludXgvY29tbWl0L2NmMGI4YTk3MjQwYWINCj4gVGhpcyBpcyBiYXNlZCBvbiB0aGUgc2hv
cnQgZGlzY3Vzc2lvbiBoZXJlOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1lZGFj
L1pEN2dQa2ZXUWVFZUVmQmVAYWdsdWNrLWRlc2szLnNjLmludGVsLmNvbS8NCj4NCj4gQmFzaWNh
bGx5LCBhbGwgdGhlIHN0YXR1cyBiaXRzIHdvdWxkIGJlIGNoZWNrZWQgaW4gbWNlX3NldmVyaXR5
KCkgYW5kIHRoZQ0KPiBhcHByb3ByaWF0ZSBhY3Rpb24gaXMgc2V0IHRvIGJlIGRvbmUgbGF0ZXIu
DQo+DQo+IFRoaXMgd291bGQgYmUgZnV0dXJlIHdvcmssIG9mIGNvdXJzZS4gV2hhdCBkbyB5b3Ug
dGhpbms/DQoNClRoYXQgbG9va3MgbGlrZSBhIHZlcnkgbmljZSBzdGFydCB0byB0YWNrbGUgdGhp
cy4gTXVjaCBhcHByZWNpYXRlZCBhcyBJJ20NCmluIHRoZSBiZWdpbm5pbmcgc3RlcHMgdG8gZmln
dXJlIG91dCBzb21lIG90aGVyIFNSQVIgcmVjb3ZlcnkgYWN0aW9ucy4NCkhhdmluZyBhIHdheSB0
byBrZWVwIHRyYWNrIG9mIHdoaWNoIGFjdGlvbiB0byB0YWtlIHdpbGwgbWFrZSBldmVyeXRoaW5n
DQptdWNoIGNsZWFuZXIuDQoNCkl0IHdvdWxkIGFsc28gc29sdmUgdGhlICIgYXJjaGl0ZWN0dXJh
bCBwdXJpdHkiIGlzc3VlIGFib3ZlIGFzIHRoZSBjaGVjayBmb3IgdGhlDQpNQ0dfQ0FQIGJpdCBj
b3VsZCBiZSBpbWJlZGRlZCBpbiB0aGUgc2V2ZXJpdHkgLT4gYWN0aW9uIGNvZGUuIFNvIGRvX21h
Y2hpbmVfY2hlY2soKQ0Kd291bGQganVzdCBoYXZlIGEgc3dpdGNoKGFjdGlvbikgeyBjYXNlIE1D
RV9ET19USElTOiAuLi4gfQ0KDQotVG9ueQ0KDQotVG9ueQ0K

