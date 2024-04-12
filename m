Return-Path: <linux-kernel+bounces-143327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92258A3743
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF29EB22B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088724086B;
	Fri, 12 Apr 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3w2dZt3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C11249E8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954942; cv=fail; b=ZRtw7x4a9mYO7bUzIDuTCSueHqGyJRdiIwr3jRvK1mzl+e+Wp+b0fp+H+pw+29kqrzFknv1LwaqKjaRnmZqiXKho2OMdGazrN9KlggEUt+j16dmOjN74mUOCXrUa5oafUfeff0/sZ0GbFt8mqm9Hs9LGGv9OeSArLclgyiGanpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954942; c=relaxed/simple;
	bh=WWB2Yy7IgnG18eJ095H20rhfWX66WoWsmZj6BP9Od/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKbAynvcSBIOQ6TC4/Mf6fYN+kifVmIllEemaG5kZRWdznsmseuGORtzSRAm/W3uXAOzkjqhsoIIFmQkcM4oJQa2CGRwFERMucz8LtUlyTR4g9ix1VZRArAtvPEKVsWujS9tQiiLl4qvDq9zFfedVeKHIcm1K2t2PE771U1sdOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3w2dZt3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712954940; x=1744490940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WWB2Yy7IgnG18eJ095H20rhfWX66WoWsmZj6BP9Od/s=;
  b=e3w2dZt3ysnc+diaiyWW9e5y7xtVh1Vy9TnmsA+/WB+EJZTlFEIlTpKh
   mIx2KSbQyHyGiwWIq7lwcNnaMjQrSquG1JN+EUQhmYShAgzlUnTNnSeAO
   4opxuzfPIZjTfsTjw7BpA/SYSzCa3+LrQsBw94pAQKwX3Hw30bSZF6qjf
   5KgzXbuZ3PGW+1Df5iQSXaL/Y6eaWjjzZH7ACCnp55oFrE1NFo908sjxK
   PNVo8mWRMOwVmtk61rz/NloJwLhAKqMjItfz1G7GCstMpIE5tRGHU9Dmj
   PXVs54znf3mz0meL+xUgv7tFHiAioNtjZb7IHNgJBgciuz5iwzMk3nxq8
   w==;
X-CSE-ConnectionGUID: m7nz8oGNShis4YnWuJl/ng==
X-CSE-MsgGUID: StZRJgW6ShWjUGuHymkXFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8642823"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="8642823"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 13:48:59 -0700
X-CSE-ConnectionGUID: bpGQCwSJT6KqAMrIQaZ9vg==
X-CSE-MsgGUID: JHPU6I8GQhSKgMe/KMziyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21262524"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 13:48:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 13:48:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 13:48:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 13:48:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 13:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNd6Ru3IVxIakbGIaRUXkeKODtwFAyVsc+GGAEYih8A08cvbkm+A163+D1yK+3gZ1jHMvRuLDpnZhYmUz3T3Y2x1LEJeyKHrZlwP+Sk7QCkPZxJquXPWIY7ggDzldJ2TouJh9Ng1l8NURRpAqiFXPsoJh72JgiuDBT49GZEVqa8y+ADWdmRhN5DjEQqE3G7dQf+Ay9sYVOhAzD8Rou5kV01lsxFNEFgg3IQajlc8PzpWXzFsTBNZqtax45OYQUng35ooujTczgE/0lsLUVY8QRArdg3fUwWRDpQ4suZ+JZtKJB+m9r56/7j+IBkFekCP0KkciWoy3XAYtVlIIEIjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWB2Yy7IgnG18eJ095H20rhfWX66WoWsmZj6BP9Od/s=;
 b=HA+4H1NSaKqiYpoavqqjc2jkySwh6hSqT6ecrgFjpPryjAcFPfi9Rez4+TfpLLiTB2rGsMnDpTzPgGQAgJhIPaQfi5rxLPgb0f4BXdKc74Xbxn4cY+uy8EVBi0RI+GNhdSnUROjar/nXmG7MJCrqmz+XSnIKsxnTz+HWGawXbWsoL6ezXFqmPUoPaRQKRuCzLecWXLZuCxoXUi/qbdLfKcsgC1RHbVl7Wmkx2xiG0jKRlQgzI6wi2XnV/hn3KtaGjMikBhEPrrtBEBlqUIVm7gSg5XpGmWOaNCH8Hfeb6Iw2nvWarQ+ClGyFJwHWFIgP38LnwKyZBk5ozCbrheurNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB8131.namprd11.prod.outlook.com (2603:10b6:8:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 20:48:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 20:48:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "Cui, Dexuan" <decui@microsoft.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "cho@microsoft.com" <cho@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Preserve shared bit on mprotect()
Thread-Topic: [PATCH] x86/tdx: Preserve shared bit on mprotect()
Thread-Index: AQHajQ1xQbkcTQSBEU26r4KkbvMUxLFlG4+A
Date: Fri, 12 Apr 2024 20:48:56 +0000
Message-ID: <40abc379ba6c690fd5a768070b7906c694a1b49d.camel@intel.com>
References: <20240412191247.369841-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240412191247.369841-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB8131:EE_
x-ms-office365-filtering-correlation-id: 8097b942-15ff-4db4-7f48-08dc5b31f880
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4oQqRZYvRyLo4r99Miti3cN3KL9cLqAxzhS+kayqGEWD6dYODyj/E6SSa/069MRviRoyFfrgMLqXn1lapI5oJr6Q2I4nv2Zv7n2XjkZ+gui1i9JYTkYffgBGG1m6fRBRHRB1vrkxBEPVQa6g50l2oj8mfvBJzUnuwMn4o/dkOF/eF1RI5wIinubFH9QApwAe52hu0+SIqHkuoMj4//6SXtzohfVGEuz69PjcK8w0IQE2a+QeA/wbfbu31LLcUus8HTK45u8WDlXuIR499491gJ688wX50Nl11Q7vZEEa4zeUTBdB05FgJyCQzulVUS1o4uP1Fb1VKSJ4VXHq7qkU8yzoxkJqCzI9Lc6kKBDt+g1M1cliw85Niy1w2+fOiMxfthrGuMydJV65ELfflegV79WFLJBLBuKGwxLLwFrKrarRFtnG/WQ6Nq3xTkHdzPZX9xXlekD0cD4WkLifxjrKbVMP6+DGNFyXcKccDFwKtjvYGErOR4XpQRvnXvWsePTOMsvtMFrWcx2PSpeKmltiVmZEF/TU5t0pA/N2J8jbKKgiJls3GDV3odkhMVZDwUAfoYD1x8Nnu3Du9wxgPdALJ+CAo0YofL+ZY6/xYFoomTBZWajrcXfNUc3v5touqxb170VJGIvWXdDwMs0Q94CZeQPZM9y/jo6TSnFsQZJGQwA8hBhD563ayC8USGwB5zAcjHPWA0/qmeFonDheip+vkquJ80MUBeX31DY93z0KJdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SktBbkh6S3FCcW1YblFHRlhZdzdxalFheDZrc3JySXc2MVRpM0R6SHpJVWpV?=
 =?utf-8?B?cmlBNkN5cXR0WDRwU2Z6VW5rVmlHMVI0M2d0YUJsdmtCZHBHSTRVaTBsWEZu?=
 =?utf-8?B?Ulk2S0g4TXYwVFVKMGpZRGliZ2gvZlpRRFBnNTZvbElxcGJhbzJWS3ROT1Vl?=
 =?utf-8?B?dHRFbXJFeG92VVAvdUZJTkRITnJDNHBJM1hxUGpQQnI1L2Y2NkRFQmZ0b3N1?=
 =?utf-8?B?SWozY0RLL0thR1VHazBMU3Q1eHVLcG1EMGN3U25aa0xML2NkT29sWUVnSXhM?=
 =?utf-8?B?QTdGdlF4dHRtcmFNcFhodEFLUU5RVmFZVitVSk1YUjBKNGt6dVZIUVV5aWEw?=
 =?utf-8?B?aEZnVkRCNmVsMTlDVmF4YlZsTnVpNzF3eVBjM0NNREZiYS9iOE1YcVkyOUdo?=
 =?utf-8?B?YWR6Q0pncDE3S1VCWWgrTTJyaG1mc21JRHFNS1BmTFdRUUtCNnFEL1NmYko4?=
 =?utf-8?B?TFZlaHMrSmRuQ0ZhU0hXbEdhUlJKNzdRTU5vTUlPaWFQU0tLVWRxMFNmWmVo?=
 =?utf-8?B?TElGQ2NsZ1lCQTRGRVg4d29hRG5SRkNFMzUzVnAzVVo5TFd0b2g5TU1FRkxs?=
 =?utf-8?B?c1h2K1JsTjZ1eFdhMEhIVEQvMFoxOC9qVUJ2TmNkOUs1UnpxZUxWenF1TE5B?=
 =?utf-8?B?NDFXcldxZTFIR2JFZllUN2xybW4vazREK0NrZ0RLdnRJSXRhc0NsbzJIUmpl?=
 =?utf-8?B?b0pCWmFRMkhjZjkzYkRyeVpNdFBXOFJ0UFU5NU8xbXdSOHV0c2hZZnpCd3lq?=
 =?utf-8?B?cFl6QzUrU1JQdHEwVy90eHc2U2x5cyt4aGNEZmx3TmE4cis1UXIwYzQ4VXpr?=
 =?utf-8?B?V3FzblY1SFFqOWNkYmJQUk5jSTdiNjk3SndsMmpwRi91eVdqN2YrU09ERmtN?=
 =?utf-8?B?WkdNemw4dEZhUFc2THhoUHllTFZDdGp2a2dpWDM1TVJzcXp2Si9LZkRaaGRi?=
 =?utf-8?B?Mk5tN3d5MEVCOWtiWFRGUkMzWmsxQWhhdkxTTEVRMzl6NlFVNS9DbHc1c29m?=
 =?utf-8?B?cHhmUEZsbWk0WTZMNGx6WWtsS3NUNzAvQStrSGR2cFQreDN5VmV5SnFZWlJ6?=
 =?utf-8?B?bkxBTzRXSTJFSitvb0xCNHdrcmNzVHFQcnp6Z1V1NmErOTlYYUhTMTMybVFY?=
 =?utf-8?B?SGNQVC9EWXYvUWZZSDhCMWlIY3U0cEZETXYzZFdpeHpjOGpWbUNjTkJEdmRB?=
 =?utf-8?B?dXJxS2VsYTRPWTdiTzV5Q29oVnJEdFNMbk0vQ2FwTW9xVzZQa3N6Um81aEMv?=
 =?utf-8?B?TkFuMTB6YlRSMEtiUnYrcGpQQS9MTnRUOU1KS1pnUzBwbHNFRDIyM2tmSDVG?=
 =?utf-8?B?UkxLSm1VTCtqZVhZcGRBeCthMjYwV3NZbnk5R3RBZ0pnNGtKQVFJcEFITGpa?=
 =?utf-8?B?RmplWGZFdUpWNERFbVBUTXJiUTZ3N0ZaRm5pQ1oxQ0I4L0hZaW15MUNiVW1X?=
 =?utf-8?B?T1FSMlZCN0FVUmdLcUllUlpQd0JoU25udW84ZDZTR2lJRk9tZjNlUGRPYXFh?=
 =?utf-8?B?cVZCY3RyZlJEWUVvMDhFRnVGVm1SbVorSmNiZHpabFdnOGFyYnk1NTlMeTNN?=
 =?utf-8?B?TmF4VDMyZEZnTlJWY3p1NkFBNlhYR04zNFZjQnFRblVvY0FTb3MvR0FSak9j?=
 =?utf-8?B?YUJldHRYWkszb2VMeVI2ZW1lRGR2QWRVbkVHWWs4dTRnUDA5bU4yTlArSXor?=
 =?utf-8?B?ZHp4Vm1vOUFsUXI0YmQ2Q3JxL3dPUFUrQ2lEeVdXOE01c0w3eHgvSXNFeUhU?=
 =?utf-8?B?NTVWeFMxUUN4N0RGWWwwN0JsNnM5TWVLdkVRTGpZNkkyK2dxbk9uQVkvWXBI?=
 =?utf-8?B?RU5TZW9MUlBjZFlCS3FNN3Q4R3YzdVdUSVh5V2crb0xjeGJSZjlwQzRidTJz?=
 =?utf-8?B?cm82cGdKaUIxZWI5Ylp6ck5GY0FQcWJFODd3OUhhMFVvKzA3NGZ6L29WR3ZK?=
 =?utf-8?B?ZXZyOXlSZy9TbFJCNW1jUWwyV1JDbGszOHZScGdUMjBVd2kwQUZFbFRHcFds?=
 =?utf-8?B?eUlJbGxBMzZoZ3EwYnFPb0RpbkV4TjhibWEra056Q3gwNGdzRW9zTGJjdTlH?=
 =?utf-8?B?bkVBVW5ZK1RFM21nVkVyNWFEY21nbElGMlZGeG9GU2pwbTVJZ004ejc3QTMz?=
 =?utf-8?B?WG5PN2FpUkgrMTZiRVRkT1BzMXFiQ1hxUUtiQTFNRmNwcnJCUEttSS9nWnht?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A88B4A69FEE09488058941C8C25DCF5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8097b942-15ff-4db4-7f48-08dc5b31f880
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 20:48:56.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Er5W1kKlnlHK1Of6QNAJiwGeu6RYgxZjSX4waQTkIaA79LjvyMHXiTF8wv6YIWAql1NgdFjNM4VNPi7blmIwacy00NR7Knf79a5IoUR5gcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8131
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTEyIGF0IDIyOjEyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBURFggZ3Vlc3QgcGxhdGZvcm0gdGFrZXMgb25lIGJpdCBmcm9tIHRoZSBwaHlz
aWNhbCBhZGRyZXNzIHRvDQo+IGluZGljYXRlIGlmIHRoZSBwYWdlIGlzIHNoYXJlZCAoYWNjZXNz
aWJsZSBieSBWTU0pLiBUaGlzIGJpdCBpcyBub3QgcGFydA0KPiBvZiB0aGUgcGh5c2ljYWxfbWFz
ayBhbmQgaXMgbm90IHByZXNlcnZlZCBkdXJpbmcgbXByb3RlY3QoKS4gQXMgYQ0KPiByZXN1bHQs
IHRoZSAnc2hhcmVkJyBiaXQgaXMgbG9zdCBkdXJpbmcgbXByb3RlY3QoKSBvbiBzaGFyZWQgbWFw
cGluZ3MuDQo+IA0KPiBfQ09NTU9OX1BBR0VfQ0hHX01BU0sgc3BlY2lmaWVzIHdoaWNoIFBURSBi
aXRzIG5lZWQgdG8gYmUgcHJlc2VydmVkDQo+IGR1cmluZyBtb2RpZmljYXRpb24uIEFNRCBpbmNs
dWRlcyAnc21lX21lX21hc2snIGluIHRoZSBkZWZpbmUgdG8NCj4gcHJlc2VydmUgdGhlICdlbmNy
eXB0JyBiaXQuDQo+IA0KPiBUbyBjb3ZlciBib3RoIEludGVsIGFuZCBBTUQgY2FzZXMsIGluY2x1
ZGUgJ2NjX21hc2snIGluDQo+IF9DT01NT05fUEFHRV9DSEdfTUFTSyBpbnN0ZWFkIG9mICdzbWVf
bWVfbWFzaycuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmls
bC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IEZpeGVzOiA0MTM5NGUzM2YzYTAgKCJ4ODYv
dGR4OiBFeHRlbmQgdGhlIGNvbmZpZGVudGlhbCBjb21wdXRpbmcgQVBJIHRvDQo+IHN1cHBvcnQg
VERYIGd1ZXN0cyIpDQo+IENjOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29t
Pg0KPiBDYzogQ2hyaXMgT28gPGNob0BtaWNyb3NvZnQuY29tPg0KPiBDYzogRGV4dWFuIEN1aSA8
ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg0KU28gZG9lcyB0aGlzIG1lYW4gdGhlcmUgaXMgc2hh
cmVkIG1lbW9yeSBtYXBwZWQgdG8gdXNlcnNwYWNlPyBPciBpcyB0aGlzIGENCnRoZW9yZXRpY2Fs
IGNvcnJlY3RuZXNzIHRoaW5nPw0K

