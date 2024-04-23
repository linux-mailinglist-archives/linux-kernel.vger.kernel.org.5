Return-Path: <linux-kernel+bounces-155968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF38AFC17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C7728ABE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F788339AC;
	Tue, 23 Apr 2024 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHyh3ZNA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF12E63B;
	Tue, 23 Apr 2024 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912095; cv=fail; b=Zep7cCMvVFWD7STWdTaZ1INXZyr5oCMyqJWsD9izcja85WkSzMJf611RxmAr4xwrYTVCX+i3BthckfGr00k9tMA1uQwOEsoiwIjk4z0tsfoaDx3CeLJtIvlIKQ5W7FSxUEkPVnwNqWDASIbBL+J+KBZSbsR/gEMPifx+F2YFpOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912095; c=relaxed/simple;
	bh=Gm9oig2g8sARl+AphlWz6nEW7uP2yJFZGz6gXN4dWbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qbocXYIxx17jP7cSWmhmVHagiikQTm5pxkXFfCFHlZIIHsQEx2TcldxTOhcxDvFJCszzspfbIcl3Tx9f3el5IJaBNvi1a0jWBQwfxdnpqNzKtW8VR/N4JbHPTmpEp8ZiMWS7+ih+AuR2QkBLekzTG9HvlVvd1r8CzOZjbedcAhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHyh3ZNA; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713912094; x=1745448094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gm9oig2g8sARl+AphlWz6nEW7uP2yJFZGz6gXN4dWbg=;
  b=KHyh3ZNAQGYsMbAJXOD42zZHV749lkAghrJ+Iu9asbI+uC1f6f7T+B1V
   cUiJS3vGW9VkGG/91+t18qbTxIKnRFb/GJBi6Ri4urDVW2Hys7RiKQQ3m
   YeWaMu1n6NVlYui1ePYmmBFc3XonzaEWNyuhwCFTcOhwyghqb5Y08I6oz
   couiUrM4YbeuAPkQz8YWGYCnqOHEqnoBpeOEeXnETUO6bk+da8z3lYIp+
   QtnI/BdmX+gjkMrKWeu+XrmQCQo6UxmdB9nkEfwrzCh/gASE4kbtI6NwJ
   5dUqoZKLzXRoP1wyP2yI9aO+U6c+Xghk9aI/96vs2kZzGXQObKjlyivy1
   w==;
X-CSE-ConnectionGUID: 4vaN4tp5SU+6piv9Fn9l+g==
X-CSE-MsgGUID: 4HwG37wNQVKFzZKw1kRtbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20942261"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20942261"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 15:41:33 -0700
X-CSE-ConnectionGUID: yjlDK/aKQPOe6iykAhqYGA==
X-CSE-MsgGUID: gFvQi//bT6y6Mf3R6R3UJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61963529"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 15:41:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 15:41:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 15:41:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 15:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMUNXrjVYDxXMnoF9KsEO6Qxy09niZe/ztX1FHjVhFJxCmpx1SPLCvDNw6Dx/UBXX06w4qCfEVGMDet6p6Ia1w9CvoT+VOqfW8hNOP+Cm2qT9YWPmKepSizXsYcHFrK2E9SWGMMTTClBtkc9ihuM5cnIWgYLoJBpRXX+PWXxKlpZePTWZS/DzatlcaN5bqaVdPxAmkLXkRaIJsYvNAFWya1ZZ/sTZhYUpSowvtsqXTZh13IYxcFmsP6YqiizSs7Em323ZrozvHzzuqWBHZ++R8K9Ujs11HBemxv1lCic/HdxsI1GEPPLQLjegCUdYR/T1/+5/ppxBQCDzuY6kbDFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm9oig2g8sARl+AphlWz6nEW7uP2yJFZGz6gXN4dWbg=;
 b=mD8Z9PjpACIGx93WZb6MuCwPa/MBjjR/0wC8xArAhtiM7uYuX1o7VW/kbQehieXr4NM72MzmK1fQpmyH3cF/iaqU419XqSzXWd50u7iEZAlnb7iQlkspNPTIL6/EqeQPv6oBDAQUynsnyQCc+bRR2zk5veqX/QHdB3vBBtn4NGcbkuBgvGOw+D1iMySATS3AK7yZT0oq28EnhCfdJDa5JIaviPGb/PW6RDiR+gCoyxXKBQ0RBMBz4pFlQZ2uBcbAmM2OwdRXUo3P3819u5o3YIlrTOMCCOCcmCVzSScAeNkoiAIVrGSKdCXpcLRMSiJAlSze62b1HuUuw4nR6BqAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 22:41:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 22:41:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "zhubojun.zbj@antgroup.com" <zhubojun.zbj@antgroup.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Liu, Shuang" <ls123674@antgroup.com>
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
Thread-Topic: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
Thread-Index: AQHalWKxh3aLqK2oAEW0jm6Q2AbS37F1vfoAgABZAgCAAEhHAIAAFLcA
Date: Tue, 23 Apr 2024 22:41:29 +0000
Message-ID: <2e90cdca48426a5ab04ac7d50d1cd5c1b7805872.camel@intel.com>
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
	 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
	 <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
	 <bfdb5787-65db-4c64-bce1-d39f37ad09fa@intel.com>
	 <D0RTJVEHLLZ8.3967ZI3I5UO28@kernel.org>
In-Reply-To: <D0RTJVEHLLZ8.3967ZI3I5UO28@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB7091:EE_
x-ms-office365-filtering-correlation-id: 0670a455-6096-4ffd-f282-08dc63e68479
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SHlvMGZQZ0lRcUlxSTBOOHBFN2RUeGJRME9Ea2Q0SDB6SHFoczlGeUZqTlli?=
 =?utf-8?B?eXp2ZnZDRDlWalpybVphc0ZMekk0TFp6Z09sbm5wTGJXSnBGOFlVNEZWY0Vi?=
 =?utf-8?B?dmJ5UTFqUmFGRnFKczRFZVNaaC8wbVkxV1d3TTRwT0FadXpINUNmRHZFTG44?=
 =?utf-8?B?U1dCbm04enJRdTZPZGI3VnpJeTAzRHUza0pFT2FOaktwbEpheHhsMTFJVHBn?=
 =?utf-8?B?SVpKaEJIM3JBMDBORFFJTWI4SzFtd1JPWnhQZGxRTDNFK081QWdiR2VqUkhl?=
 =?utf-8?B?VmNmRHRieW43ZUhhM0pwcGlXV0NxVXFZUG45djF5MFRCcEVuNVVnMUljV2Zt?=
 =?utf-8?B?d0FpTjN2dlExQWlzMkVSMVY2b2VSMXJRbFc4OHNDVms0U1B5NE16alFScWY2?=
 =?utf-8?B?dUJnT2o0WStsNE1INlZFcWxSL3ltZWFWWTRrWm8wQkVTaVZycDNXS2JGWnlq?=
 =?utf-8?B?TCt6MjhySTUyQ05KdXFJQy9TTUpiNzhHNUpiVU5PeVA5dUVyRHdmdnVYRFpI?=
 =?utf-8?B?Wnd2NjNQUExtQTczV2l3SThWUHNTNHNqRzEvVHUyT045WldrNWxOd2tSMDNh?=
 =?utf-8?B?dDRwRHlCekIyRXVubmZZcFhqYXFENm43cEFlSERRbmROUGJ4TnVUVXVkMUVq?=
 =?utf-8?B?b3JpR3J5bSt2QXo4Q3dTOGN2ck9lSTFNOGZTUGphbU42VmxYWGI4cmFNWXF6?=
 =?utf-8?B?UmhMaDNQZFJDRTl4WUZpSWFiZFVJVE1aR1dYVTI1UU94SVQ2ZUpDMEpwY21r?=
 =?utf-8?B?K01HeGtjOTA1YmNRMjN0cXByZ294NWRvMjRUcmdOK2c4bzAvNkhVK1A2L1hE?=
 =?utf-8?B?UEVWaDkzeFV6NEM5MllSay9pMHVrUXF6dFl6dVM3RXFhdGNtUGh3UWhwdUVG?=
 =?utf-8?B?Y3dJcVNKMXJsVEEySHpGbTc0S0pNbENtUXR2VGxMTy9vYllMN25hcCtlWGlG?=
 =?utf-8?B?NEx0Znd0djd5WXV3TUowZWR5cTBicEZRMzBoZjNwTDNqRm1NRXNZK2l2aHU0?=
 =?utf-8?B?TzVqbmZFaDBZc3ZyZHdpUXZZa0tGQTBqN1lvU1ZSb0o0OTVMeTZQNXliRDBH?=
 =?utf-8?B?TkIxN3JqcnZUY0wwRnVZUGY2c0ZzVWFRRDNKdTl4eHh4K0Q2T0pna2hycnpI?=
 =?utf-8?B?dC9aTVFJTG92dFhsTGNhcTRmQ0FLazdVamJiRUxIMjVpSEVmRjJTNFhEU3Z2?=
 =?utf-8?B?Uktyckg3bUxCdGs2bG1kWTRoNklLUW1TL1lzUEpFNVNCbFNMUFNiakJPYkJ0?=
 =?utf-8?B?MnFEVTBSUlpCcnBFYzM1NnMrcUMzTzlYSUs2NmszbThUK0swRjNWOEdFNjdV?=
 =?utf-8?B?SDY0MmdyQk1sV2N3MTJCek54VURLRGFRMGkxL1E5Y2NiUWhlbEhRRnBvQXV3?=
 =?utf-8?B?RHdGRUkzdUpEZ0E2UUovWXd3b1ZaU21YYnFNRHJtUTM2aUZsckRURGZDVFNW?=
 =?utf-8?B?QUdxaXZ0b1FwVHFhZFA3cTNSOWtPaUpXeFJHb3NjcGFTeEVZbjVWWExnRHF4?=
 =?utf-8?B?cUFLRHpHMnNlai81ZTRZTHJVcVJiem0wSmIxTDMvbkpCRFljVzQ0MlJJRU1h?=
 =?utf-8?B?WWU1WkhvTElhT2srdzFJbVQwRXFSV0VPN09EWVBZK0NzQjI3bURJbDVSaHRk?=
 =?utf-8?B?anJtWFZvMnBZVU1tS1I2VER4VFl6U0pFeXB6bWlSVjhYMGlxOGUvZHEwRGJi?=
 =?utf-8?B?L0gweHdnNC9ucjV5QWFaTTlDWXBXQkZkQXlDV2pncWppaU4rakc5eTZGUlI3?=
 =?utf-8?B?RVhXT3dDNnB2R05wUTVLeVJIbVRyeUJWL2YzWk5jeVhtRkF0SS9qaW5rMVhQ?=
 =?utf-8?B?ZXlldUx4Rm54UWJhaVlLQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVNrdDJRM2NGMlQyYURrc05KcENwRWs2MWszODRPT25FcXo3dHV0bUFYU0d2?=
 =?utf-8?B?N3hXNGM0N2tEMjh5cXRCOURvVG5xVVRoRE5TdDlZY3ZYWkFoODN5RFNVN3dn?=
 =?utf-8?B?eklpVFZaRGoyNG5mTmRBT0tCUTBxUXNkTFlHdGVVeWU4NCtoKzJVMmtOZXZn?=
 =?utf-8?B?YzNENzgyd3dPMmJOKzhINnJSQ25waUN3aUQrYU9JOTRPQW9Cdjh1NFdnSElj?=
 =?utf-8?B?bmFWa0JOTHI5dzFQcnhmZmdUb1o5d0krNjI2Ynh3TjNQV3JPRk9uV3ZnZjhZ?=
 =?utf-8?B?d1E2TEdYWUIyMldxL2huZ0NDanBTbk8zTHdwQjhVZjQ4Q3kxOWJQM0RHSWpO?=
 =?utf-8?B?OU1xYUEyeEVJRzF3Vk5CM0pXN043KzJIUkhROG5oS0h4Uzl1a243VFdkZlB2?=
 =?utf-8?B?amJ0ZXBCSnVYaUxwbkZVTUt6Ukc5UWUxbDNhcHFUa0RZbFlrKzZKN2hGdU9X?=
 =?utf-8?B?QkZxOEFLM1pvSjZyZlVXWEZ2WU9WL0FobnVsNmF4UmRoaks0M2FEaVloS29E?=
 =?utf-8?B?MGlnK09OQUc1UGE1eWZUTktIdXFPQzNtRWo0UDZubE03TWJpR1BVQlo5MitM?=
 =?utf-8?B?cVRpRHdTNERXaHNmQnZwVytOdmpzYlI0TjJJcnNabVFrcEsvSHF6dWprVjQw?=
 =?utf-8?B?MW5pbFVLSEpkVXNoL0FRbUt6dHoyV2t3clY0Sk81ZzlxSTNvVElZMzlFNWE3?=
 =?utf-8?B?WXRoVFZkNnJBcVVqWXJjYjRPS1ltdVROWERYWkdBbTVTdGFGK3VxeXIxWmh5?=
 =?utf-8?B?Rk1rN2VucjZHY1BhUzB5NjJuU05ZWXhXK2pPN3ZseFUwWHFGQlNjR0N5T2Ft?=
 =?utf-8?B?aGoyc3JHM2NlYjhVK05EUk1hSjlwOHdaUGFoNkFFSldOTWZoMmhaMk1DODNZ?=
 =?utf-8?B?RGd3VlQyZnJsQTFVcHFjS1BYTHFLa3dUd01MR0RNK3dxSnJKL3g3d3pmcTVo?=
 =?utf-8?B?SnVGUG9RUE8rRXZ1YjIvYXVqZzVDcGEvMi9MMDBpQ2xKWEpERDZUanZaR0hW?=
 =?utf-8?B?L3F4dlNVdEZ0b1RwYXdPaExab3FRdE1zOGJWdWM5bksrWVBKZWJxdFZLQUhU?=
 =?utf-8?B?a21nckkveUI0RzVNdmtPd2lvbVlxbGYxWTNiWUdMdHEwM0FtRkNrUG1nY2lu?=
 =?utf-8?B?ZGdrQXFQaEo2akhvTWo2L0hzOHV0S3QvSmFDMTlVTlFtY3RRRFNyQ0lNTzBR?=
 =?utf-8?B?WnVrTW5aa3RRYUFQVkgwNXpsM1FoaTlZL3ZpY2tHazlFeXgzS2JHRXhZMEV2?=
 =?utf-8?B?VzE2L3ZZajJYcVk1a016R2diTjkwVTlDYm1qQW5DVFQ1VnJ3WGhjZ0NLYjNp?=
 =?utf-8?B?TTBwRlJRMTNocnlZa0F1Uy9YdmVBUnc5YmVDU3UxTGpEbGl0VlBuL3VqZFFh?=
 =?utf-8?B?eDdNR2xETFFYNzVtV3QzbmJreHl0UTZ0OGpQaXNOSm5aaXpsV0NBd2EyT0Jv?=
 =?utf-8?B?WlhML2tDeFl3WkcxQVY2ZUQxTGNnVDhRd0tuTFpwRFErZmtlMVZHaVFkdEUx?=
 =?utf-8?B?bmZ1WCs2bytEV3RndWVkQm03WUlJcy93bUFSTUlzaXFROTB4QThlV2ZGci9r?=
 =?utf-8?B?eEZDdkUvMjQxdEIvRkRCZlVNS1h6K0dNNFMzVml0dStwZ2pScDM2emlUWU1O?=
 =?utf-8?B?T3BGekdVTm52bjhtWm1aOFpJeWR5bFJoSlJEaTRLSVRHOHN3cUFIS2F1Sk4w?=
 =?utf-8?B?MkhNRFZ0TW8vbmd0Q0pBQzU1bkxrdTU5YzNXMmFnMWVQWGU1bHBYbGdpYmdv?=
 =?utf-8?B?bjUrOURnd3FTOVVKQkdmbmo3eFRJZkZDT09hR1FZelJoVjZVWXp4TTFubzhP?=
 =?utf-8?B?UUlWeW5LWFRrT0tBNkRUQlNFN2NKd25NYlg2ZFJPL3NvVnNRdlVQeGh1MkxS?=
 =?utf-8?B?dHRUUDdzR3JSeWVDRWZzZWpEU3RFd3RnTUVYQmo4cng3czZNbXFXS2NTcUlF?=
 =?utf-8?B?NFV4ZjhRU2JPZHBtYlFsdVMzaUU0cENxN2dRa21KcXpEbU5BZmplczZ5aTJk?=
 =?utf-8?B?NVh3RGdLQjJmTm10NUhJK04yaWM0WWdaWTF2cXE0NTZZT3VadnFvYzBRVXpm?=
 =?utf-8?B?ZDFlMi9lNWI0N1NBanJ1TVFSOG5CanArbHl1MzUyMkVEeVh4VGFzV0pkbFpa?=
 =?utf-8?B?YVE5Y3FyWTNRMGx6dER4TXlNSlpzZVVOQ0NXaHpwTis5RktCblJwM1RtUDYr?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5274D8B8A2811A4581D65AFAF1EE42AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0670a455-6096-4ffd-f282-08dc63e68479
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 22:41:29.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnS47ThxVrYQICZYdW0tyj/iGf4vLO1LVJY1WYT7P2OuaO1xDOudqgrv+SIx3ZwWqGl+1nbAARTM0e5v0iAXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTI0IGF0IDAwOjI3ICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIFR1ZSBBcHIgMjMsIDIwMjQgYXQgODowOCBQTSBFRVNULCBSZWluZXR0ZSBDaGF0cmUg
d3JvdGU6DQo+ID4gSGkgS2FpLA0KPiA+IA0KPiA+IE9uIDQvMjMvMjAyNCA0OjUwIEFNLCBIdWFu
ZywgS2FpIHdyb3RlOg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9z
Z3gvaW9jdGwuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2lvY3RsLmMNCj4gPiA+ID4gaW5k
ZXggYjY1YWIyMTRiZGY1Li4yMzQwYTgyZmE3OTYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvc2d4L2lvY3RsLmMNCj4gPiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVs
L2NwdS9zZ3gvaW9jdGwuYw0KPiA+ID4gPiBAQCAtODA2LDYgKzgwNiw5IEBAIHNneF9lbmNsYXZl
X3Jlc3RyaWN0X3Blcm1pc3Npb25zKHN0cnVjdCBzZ3hfZW5jbCAqZW5jbCwNCj4gPiA+ID4gIAkJ
fQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJCW11dGV4X3VubG9jaygmZW5jbC0+bG9jayk7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwkJaWYgKG5lZWRfcmVzY2hlZCgpKQ0KPiA+ID4gPiArCQkJY29uZF9y
ZXNjaGVkKCk7DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJcmV0ID0gMDsNCj4g
PiA+ID4gQEAgLTEwMTAsNiArMTAxMyw5IEBAIHN0YXRpYyBsb25nIHNneF9lbmNsYXZlX21vZGlm
eV90eXBlcyhzdHJ1Y3Qgc2d4X2VuY2wgKmVuY2wsDQo+ID4gPiA+ICAJCWVudHJ5LT50eXBlID0g
cGFnZV90eXBlOw0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJCW11dGV4X3VubG9jaygmZW5jbC0+bG9j
ayk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJaWYgKG5lZWRfcmVzY2hlZCgpKQ0KPiA+ID4gPiAr
CQkJY29uZF9yZXNjaGVkKCk7DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJcmV0
ID0gMDsNCj4gPiA+ID4gQEAgLTExNTYsNiArMTE2Miw5IEBAIHN0YXRpYyBsb25nIHNneF9lbmNs
X3JlbW92ZV9wYWdlcyhzdHJ1Y3Qgc2d4X2VuY2wgKmVuY2wsDQo+ID4gPiA+ICAJCWtmcmVlKGVu
dHJ5KTsNCj4gPiA+ID4gIA0KPiA+ID4gPiAgCQltdXRleF91bmxvY2soJmVuY2wtPmxvY2spOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsJCWlmIChuZWVkX3Jlc2NoZWQoKSkNCj4gPiA+ID4gKwkJCWNv
bmRfcmVzY2hlZCgpOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFlvdSBj
YW4gcmVtb3ZlIHRoZSBuZWVkX3Jlc2hjZWQoKSBpbiBhbGwgMyBwbGFjZXMgYWJvdmUgYnV0IGp1
c3QgY2FsbA0KPiA+ID4gY29uZF9yZXNjaGVkKCkgZGlyZWN0bHkuDQo+ID4gPiANCj4gPiANCj4g
PiBUaGlzIGNoYW5nZSB3aWxsIGNhbGwgY29uZF9yZXNjaGVkKCkgYWZ0ZXIgZGVhbGluZyB3aXRo
IGVhY2ggcGFnZSBpbiBhDQo+ID4gcG90ZW50aWFsbHkgbGFyZ2UgcGFnZSByYW5nZSAoY292ZXIg
bWVudGlvbnMgMzBHQiBidXQgd2UgaGF2ZSBhbHNvIGhhZCB0bw0KPiA+IG1ha2Ugb3B0aW1pemF0
aW9ucyBmb3IgZW5jbGF2ZXMgbGFyZ2VyIHRoYW4gdGhpcykuIEFkZGluZyBhIGNvbmRfcmVzY2hl
ZCgpDQo+ID4gaGVyZSB3aWxsIHN1cmVseSBwbGFjYXRlIHRoZSBzb2Z0IGxvY2t1cCBkZXRlY3Rv
ciwgYnV0IHdlIG5lZWQgdG8gdGFrZSBjYXJlDQo+ID4gaG93IGNoYW5nZXMgbGlrZSB0aGlzIGlt
cGFjdCB0aGUgcGVyZm9ybWFuY2Ugb2YgdGhlIHN5c3RlbSBhbmQgaGF2aW5nIGFjdGlvbnMNCj4g
PiBvbiB0aGVzZSBwYWdlIHJhbmdlcyB0YWtlIG11Y2ggbG9uZ2VyIHRoYW4gbmVjZXNzYXJ5Lg0K
PiA+IEZvciByZWZlcmVuY2UsIHBsZWFzZSBzZWUgN2I3MmM4MjNkZGY4ICgieDg2L3NneDogUmVk
dWNlIGRlbGF5IGFuZCBpbnRlcmZlcmVuY2UNCj4gPiBvZiBlbmNsYXZlIHJlbGVhc2UiKSB0aGF0
IHR1cm5lZCBmcmVxdWVudCBjb25kX3Jlc2NoZWQoKSBpbnRvIGJhdGNoZXMNCj4gPiB0byBhZGRy
ZXNzIHBlcmZvcm1hbmNlIGlzc3Vlcy4NCg0KQWggSSBkaWRuJ3Qga25vdyB0aGlzLiAgVGhhbmtz
IGZvciB0aGUgaW5mby4NCg0KPiA+IA0KPiA+IEl0IGxvb2tzIHRvIG1lIGxpa2UgdGhlIG5lZWRf
cmVzY2hlZCgpIG1heSBiZSBhIHF1aWNrIGNoZWNrIHRoYXQgY2FuIGJlIHVzZWQNCj4gPiB0byBp
bXByb3ZlIHBlcmZvcm1hbmNlP8KgDQo+ID4gDQoNClBlcmhhcHM/ICBNeSBhc3N1bXB0aW9uIGlz
IGV2ZW50dWFsbHkgY29uZF9yZXNjaGVkKCkgd2lsbCBkbyBzaW1pbGFyIGNoZWNrDQpvZiBuZWVk
X3Jlc2NoZWQoKSBidXQgSSBhbSBub3QgZW50aXJlbHkgc3VyZSBhYm91dCBvZiB0aGF0Lg0KDQpS
ZWFkaW5nIHRoZSBjb2RlLCBpdCBzZWVtcyBjb25kX3Jlc2NoZWQoKSBldmVudHVhbGx5IGRvZXMN
CnNob3VsZF9yZXNjaGVkKCkuICBUaGUgZ2VuZXJpYyB2ZXJzaW9uIGluZGVlZCBkb2VzIHNpbWls
YXIgY2hlY2sgb2YNCm5lZWRfcmVzY2hlZCgpIGJ1dCBpdCBzZWVtcyB0aGUgeDg2IHZlcnNpb24g
aGFzIGEgZGlmZmVyZW50DQppbXBsZW1lbnRhdGlvbi4NCg0KPiA+IEkgYW0gbm90IGZhbWlsaWFy
IHdpdGggYWxsIHVzZSBjYXNlcyB0aGF0IG5lZWQgdG8gYmUNCj4gPiBjb25zaWRlcmVkIHRvIGRl
dGVybWluZSBpZiBhIGJhdGNoaW5nIHNvbHV0aW9uIG1heSBiZSBuZWVkZWQuDQoNCkxvb2tzIGF0
IGxlYXN0IHRoZSBSRU1PVkVfUEFHRVMgaW9jdGxzKCkgY291bGQgaGF2ZSB0aGUgc2FtZSBpbXBh
Y3QgdG8gdGhlDQpwZXJmb3JtYW5jZSBkb3duZ3JhZGUgcHJvYmxlbSBtZW50aW9uZWQgaW4gY29t
bWl0IDdiNzJjODIzZGRmOCAoIng4Ni9zZ3g6DQpSZWR1Y2UgZGVsYXkgYW5kIGludGVyZmVyZW5j
ZSBvZiBlbmNsYXZlIHJlbGVhc2UiKSwgYnV0IEkgZ3Vlc3MgaXQncw0KYWNjZXB0YWJsZSB0byBm
aXggc29mdGxvY2t1cCBmaXJzdCBhbmQgdGhlbiBpbXByb3ZlIHBlcmZvcm1hbmNlIGlmIHRoZXJl
J3MNCnNvbWVvbmUgaGl0IGFueSByZWFsIGlzc3VlLiANCg0KPiANCj4gWWEsIHdlbGwgbm8gbWF0
dGVyIGl0IGlzIHRoZSByZWFzb25pbmcgd2lsbCBuZWVkIHRvIGJlIGRvY3VtZW50ZWQNCj4gYmVj
YXVzZSB0aGlzIHNob3VsZCBoYXZlIHN5bW1ldHJ5IHdpdGggc2d4X2lvY19lbmNsYXZlX2FkZF9w
YWdlcygpDQo+IChzZWUgbXkgcmVzcG9uc2UgdG8gS2FpKS4NCg0KWWVhaCBJIHdhcyBhY3R1YWxs
eSBnb2luZyB0byBtZW50aW9uIHRoaXMsIGJ1dCBzb21laG93IEkgZGlkbid0IGNob29zZSB0by4N
Cg0KPiANCj4gSSBiZWNhdXNlIHRoaXMgbWFrZXMgZGVhbGluZyB3aXRoIG5lZWRfcmVzY2hlZCgp
IGEgY2hhbmdlIGluIGNvZGUNCj4gZXZlbiBpZiBpdCBpcyBsZWZ0IG91dCBhcyBhIHNpZGUtZWZm
ZWN0LCBJJ2Qgc3VwcG9ydCBvZiBub3QgcmVtb3ZpbmcNCj4gd2hpY2ggbWVhbnMgYWRkaW5nIG5l
ZWRfcmVzY2hlZCgpIGFzIGEgc2lkZS1lZmZlY3QuDQoNCkkgYW0gZmluZSB3aXRoIGtlZXBpbmcg
dGhlIG5lZWRfcmVzY2hlZCgpLg0K

