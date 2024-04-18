Return-Path: <linux-kernel+bounces-149415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FF8A90DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59654283698
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A425570;
	Thu, 18 Apr 2024 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sfas9T4n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E55CB8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404862; cv=fail; b=RFvoup8mniQOO2V2uwycx153M07p8mDqaCTAOG3oClgWdLhUmuoJcvZuTs1IjxTUw8NNIFNbUDX0KH4KPfIhPlz/8bTbskI0gC9WG0BWeXKlzLTnj5PtKq3RCZYrO4/WoyKxu77LnsUdjEhe6F0/GfxlZ/0hmGR3t6KHSdCPiRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404862; c=relaxed/simple;
	bh=ZqnJQjsIYfA/NXAn0kanrBrFo4PVWVY376wCwcHrqOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tWxwDfWz/u1nHDKj0gx9mw7nITV7PJKJ+kJEE8Dxe0HlonQ5vTeKBUkhAq20/a5ud1271z0OaBR481y1hSSf4Jyt2BqCAtJaxGNn2Q77VlZD396JVOsUBGkFmgP6FZtyzCQUhnEHKmy0ff3S1Wg4nA3A07ITdYQvi1Rin393yFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sfas9T4n; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713404860; x=1744940860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZqnJQjsIYfA/NXAn0kanrBrFo4PVWVY376wCwcHrqOA=;
  b=Sfas9T4npYtcjFjFzlk8KOkKZDnxEvAd5tb/98BbJOhq3qfcu8cOFDAp
   fXcJhEhVzfP6cBlw27QHSMDklwBSaAlZpXzS9s07+KSWGzP58GgpTc+E4
   gb9kv4XoTJ/UEHUBbYzG04q7k0AkyG6r/PWbcABCu/TxeR7zLhtLd4vKx
   4ns1wPBwiL6bVGzB2RQe8RluFaTAJW/1JMNR9fcma0IUDDYTcCWSjmYqW
   LO0s1pkWZIMiQJqbc21VSWWla+pEbUrDMjRp+Chgs2EeraXKJ/Ya6qI+3
   uwDMSOR00q+2rUJNZ35KtN1IGSCwnwobqDbcmDGjITRuzMPCVKQ740PuB
   g==;
X-CSE-ConnectionGUID: Bi+h7+ZPQam4Fmb5VB2tyQ==
X-CSE-MsgGUID: kLIB1nNaTJqMDD/bGVRNAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8789310"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="8789310"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 18:47:40 -0700
X-CSE-ConnectionGUID: 8o9azRvhTFORKIMSZNB9Nw==
X-CSE-MsgGUID: qWsGXI8/S/CZv+em1j5OxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27241468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 18:47:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 18:47:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 18:47:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 18:47:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 18:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZk4zHcY4TIfDJrQBds60mxh6zzxg25V6hIaAgEY3QhhOqU6VKwBzXue4TzYOMQ1UwmpJbuHMAQOzvvCrsuJ3zL0iPh1gToqSbgY6S89xOm5fuFrAN11kgD0lYWsBnNaV84XR6/3cbrvihh1V3D2FjPVQ/yFthiJtYYxjRxv7VMt2jy5YFM6eL4xEotb3DacLg1TewEKoaAU2RAFZDItTe2DFmT0owzgy57uKBJPOOlMa/dTvW9PjeiuRPs2x77lPaeCZCy9vxXkdvynMZegtMBW6b3pRsxh/ROgouiSoJp2S5uXwjMaNacLodNlGN38BrkiLMIxiM+AtG5u0/9GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqnJQjsIYfA/NXAn0kanrBrFo4PVWVY376wCwcHrqOA=;
 b=IZ4UhQEnBu2S7NoOom9VTaJgNbm/eq+jDQXI1aS2xPAmwPJVL6EMXBqCPXwz/MWJTzhoOx4zQJ9uI6/AZvUFjJOMz8eitgxo4OtvLw/kmnk3WTCTvinFPnMQa6AqiR+mUPcogxTmaEOSDcQKXEaCXU9T1G7EbSWuAW0AEXKOf4rYJfiUcvBKLIFPTs+WPRyDEBtTvHKrMOXtNOQyI5ndt1oi4NPrQOSxBJS2lCk2iLYe8/ZoTqOJZztkpvTseTBPxSo3srrJmvnNbvtTzQtfKuD9SVCrT/F6JMTw+ZBKcMiYkgtw3LOTOUUlktookOi98I7p9M/VIpkMvm+RDn94sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7881.namprd11.prod.outlook.com (2603:10b6:208:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 18 Apr
 2024 01:47:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Thu, 18 Apr 2024
 01:47:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Sean Christopherson <seanjc@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAABToCAAAEjsIAABDsAgAASPNCAASNagIAOGFGTgAHr5+CAAQ4ngIALqHC/gAACIbCAABhfgIAAHE3ggAFmP4CAAAscgIAAZhs1
Date: Thu, 18 Apr 2024 01:47:34 +0000
Message-ID: <B1D0D5D6-2338-4142-AF28-887FD99F3CE5@intel.com>
References: <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
 <Zh7AZY5X8_uyHrjz@agluck-desk3>
 <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local>
 <SJ1PR11MB6083F189AB9AB47D3DF74B19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240416195851.GJZh7Ye4eg_7VJrq8a@fat_crate.local>
 <SJ1PR11MB6083F100B4D957EC472AFF19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZiAcvRWwl9m4x2n0@google.com>
 <20240417194207.GFZiAmD4I8sdqhV1RO@fat_crate.local>
In-Reply-To: <20240417194207.GFZiAmD4I8sdqhV1RO@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7881:EE_
x-ms-office365-filtering-correlation-id: 6414935e-5c61-42bf-077e-08dc5f4984bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYqB8noCVBJipsaOFr9diUB24M6/wZ70WqL4bJD8miXySDQmEuGkgrrORwfsYVO7OJbZJvvxBVmtowIpre1E2LiafMw2yXZdbxKXtrcxaqLDqusyY9OwSusnHHnzWdxuPyQ6Q5BFC3qfzu6MsHFdPN5MawLzk/mjQ4aIj7GuKdPWFutkbG+Nyk4yPcIGgonr5cSHfQQmHe36C99EU6/wlYWYUZn7JaVf0HdICkgtPxpJmvuajvZGJiNNbaqhKDfbQUUgepvePJlDSY+mh9kH6Ah6s736aZBN35unlHclDm8OVgxhq3PMRegqOFE2CIgyiu8VU5knhA7LoOjDzfxUKsH4tcfvKgrFMGC+XykXgio6CrSZvY8zWx5V4jTL5xvPngbkbCYcDCyXCwNCuUbUY2vr4c1N3Yow8xNR4yKErb6J4lSiCE/X2xsEYMwDf+G56ylWqNatZ+t3ttKf5TEDBMzoNEzlsaese+huN3Xwvu5epSNSxsBoY4hx74r87lJUodr+OP6E5sOVtwNF+RZvLMwnh24M91eIH9usTmHvkulOFn0luRKBlb/F1hsbWXYQ/zz6c2TJs72Dgvl+/bLIMkK1OESLmc3oVJA1qoGDGJMb1IJk3tTSr/zQtpzh++7cXPNW/YTeoBxIXXM+Au/6yghmEEarXJscQfQCjCWODnY8GTrsnMbN/pdR0978i0DrZ+zuRzQdWvHAfHunLKWKy4N3ZfUzj0AxQqsZMbaiJ2I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjFvbzlUeVpQa1lLM0RienZVZ1RMdW5lUnJ6cVlHSXFwUGwxWmhTRFh0ckRo?=
 =?utf-8?B?UkRyTTNWV0QyMURJUW9QMlMySmdSdUpETHBCSVRHMXNBTWVwd0I4V3BUTURH?=
 =?utf-8?B?cjcxOUtaTW90YytBWkZ5OGdEYkpwUWUxK3F6cnQ4dHo5M0t1c2VLRVo4aW9v?=
 =?utf-8?B?cXVyUTNOakpwYjZwZ3dzRnhqbm1vUnBUckYrczhDeGZwanNrTUNKcUZJQStk?=
 =?utf-8?B?Ry9veU9CVUdFR3FTUC8rd2oxZTlsQ2pjdnd3UC9hc1Y5MEo4VERNZzZPd2Q5?=
 =?utf-8?B?azNWcEZJWGVlMEpnMFA1SU5TWXBnSEFzcjh4NFlVNGJhaWxIMllaTzFaMDJx?=
 =?utf-8?B?LytBV1Z1TVZYS1lMeXp0dkJXVy9sWlluMUVMUEllREMvMmc4SzJNaGpRbUxq?=
 =?utf-8?B?VjFxUTJsUy9wSFVkeEFKcS95YmoxbHByRTU5SUIyNURmQ3dNUjJyVk9zN1VS?=
 =?utf-8?B?ZnZidVpuRGRxNkNkT1R1eU55RU1tZkFUM2I3YUFUQUtoYWdIeU50UEhsQzVY?=
 =?utf-8?B?SVgwUnl3Z0tUZUxid0x6UksyZXJNMndLK1QvZG02b1grL0ZHTVN2TGdoVHVQ?=
 =?utf-8?B?aWFQNmFmNUl6V05lQVByVzdJVHJTeFQ4U0ZKRHBHUlpRLzJsNzhSSS8ySEJO?=
 =?utf-8?B?aHgwUGcrVGdFbmI2Sng3VHZsUjhpeFhuUTBJd2l1dk1TZm91RklSNGtNblA0?=
 =?utf-8?B?Q0lyZzNkSTdQTkpJZDcxZ0UzcVhIZ3Q0WVQwVmVqdURsTzMrM1ByclNVNEgr?=
 =?utf-8?B?NVJlK1h1MVFMeW5IdWlYRTA2MGYxTTU5Ni92UUVPVUVYNnduTFJFYjlIZFRk?=
 =?utf-8?B?SFNtTkFGVHZvdmFVbTVGazJ5OFdScFExdXZQbEd6VHgyOTE5czBkNVlYY2Nq?=
 =?utf-8?B?ajM4UFVzU1V3dnRvQ2pjN04rN0xWMEFHMFNqMFVsQXBXZzZZZFZnRTFFTmk3?=
 =?utf-8?B?RDJLZWR0VDFUaUwxWFl4RTk2cmxsVHdHNkNsRExzSStnVWNqSTdmaDFDbmg4?=
 =?utf-8?B?TFJ1dW0vdmZTWFloNG9JTlJFQ2o3Zk5GVlBOVW5GTWo5WDFYZGFUZVpzUnha?=
 =?utf-8?B?cVk1dVcybXpwaUgyQnpDTFMvckxJV2hsWDFmVE5sZUs1K2xSR2NBMkliR05q?=
 =?utf-8?B?aENzY25LQS9zeXZWUmtZS2lKYU8rTWhZK29iME1VWGRFbm0wYWxZOUxQbjBK?=
 =?utf-8?B?U0crR3BOQ2hlSURsUE0vMm1qZ21GdXB3OTJaRDNSenFCanJqeXVnMUFvQnN4?=
 =?utf-8?B?cEp2SW1NWXEyUlVUaElSMnVIYnpKUE5WVS9WcGNSSTV3VHJVSVVmZkVEd1Jo?=
 =?utf-8?B?OGRyOStQZG5iMFhrcXFkSCtkVEdKTFp2a1FxZG5jOWVCWHd4L3lMbCtydG9i?=
 =?utf-8?B?LzVBeG5IRUI5TXFld2FObjBYS0l2ZC9MT0RTLzNtVHFKbEdFYVg2dElqalMz?=
 =?utf-8?B?aFN0OUc3U2V5eWJhcm1WVGdKWGZKVzdhMHdjWkx2NWx0STg1Um1RMWF4ZUpi?=
 =?utf-8?B?LzdRT3laVVUxVWhHTUNpaDQ5dnZIcTcyVGJyQ204YldQaWkrcW9OVXhkTEND?=
 =?utf-8?B?WGlBQ2FIbFNBOHhhRi9WV25tNEZGUkIrcmc0MzRlQkF5a2NERGhrYng3TzR6?=
 =?utf-8?B?MFNrN1lWRVZKZ0NQVHdid1Z2ZUZMMWU0OTZIK2R2SmczRmVGUnNOMHRXNUVE?=
 =?utf-8?B?Nk5DVDYzRTBra1RjZDUvb1BlYy9idnU5bkJNc1hQZ24vZlFxbzNNYnlGVDUw?=
 =?utf-8?B?eWhXTEdwNERtMy9hZ1FoY3RlSkVnVGxNbFZmdnNkYm5MOFIyWUdFMi80Z1Nq?=
 =?utf-8?B?dFBFMkJ1OUJwcmhEU2xPbENJK0UrcERNdHZoQkJ5MkJsZ0tKUktUejNYWGRu?=
 =?utf-8?B?ejRTYnI0eUpiNFJaaCtXd1VRNGVmZjNmMURBdG9jRFo4b2l2TnE2bTllOUsv?=
 =?utf-8?B?cDY3OVBJSWZEK2ZqTmlCb1BoOU1qUW4zbkZFdXE1bGVrcjBjSjNOMk1VWk9S?=
 =?utf-8?B?NnhaWjdHenRJOTN5TldUdVIvZDQvU0N2RUs1Zk5mcStReXo2SmlOcWZmcy8w?=
 =?utf-8?B?RGZIa1F6Wlp0cGZGYXpRQUMwMG8yQ3lDaUdOS0RCeHVQaE9yd1RrMDRFdGM1?=
 =?utf-8?B?alFzN0h2bmdOdisrNEdNTzJJVmtMZVVnandCa3R0VEJNeEZQWXVpb2IwK096?=
 =?utf-8?B?NEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6414935e-5c61-42bf-077e-08dc5f4984bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 01:47:34.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aipz2pDpKBl3rHoJqmG0I9lCrEAP1VwdZvMmZZzJp1FEl+TFpGLa76R+LNfXcXj7LHVYxQWJepa4JkxFt9cm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7881
X-OriginatorOrg: intel.com

DQo+IE9uIEFwciAxNywgMjAyNCwgYXQgMTI6NDMsIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiB3cm90ZToNCj4gDQo+IO+7v09uIFdlZCwgQXByIDE3LCAyMDI0IGF0IDEyOjAyOjIxUE0g
LTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+PiBUaGVyZSBhcmUgdHdvIEtWTSBj
aGFuZ2VzIGhpZGluZyBpbiB0aGVyZSwgYnV0IHRoZXkncmUgb2J2aW91c2x5IHF1aXRlIHRyaXZp
YWwNCj4+IGFuZCBjYW4gdG8gdGhyb3VnaCB0aXAsIEkgZG9uJ3QgZXhwZWN0IGFueSBjb25mbGlj
dHMuDQo+IA0KPiBZZWFoLCB0aGUgcGxhbiBpcyB0byBxdWV1ZSBpdCBhbGwgdGhyb3VnaCB0aXAg
YXMgdGhhdCB3b3VsZCBiZSBhIGxvdA0KPiBsZXNzIGNvbmZsaWN0cyBhbmQgY3Jvc3MtdHJlZSBp
c3N1ZXMgc28geW91IGFja2luZyB0aGVtIGlzIHdoYXQgSSB3YXMNCj4gaG9waW5nIHRvIGdldC4N
Cj4gDQo+IFNvIHRoYW5rcy4gOi0pDQoNClRoZXJl4oCZcyBnZW5lcmFsIChqdXN0aWZpZWQpIGdy
dW1ibGluZyBhYm91dA0KbXkgYXV0by1nZW5lcmF0ZWQgU3ViamVjdCBsaW5lcy4gU28gSeKAmWxs
IG1ha2UNCmEgcGFzcyB0aHJvdWdoIHRoZSB3aG9sZSBzZXJpZXMgdG8gbWFrZSB0aGUNCmluaXRp
YWwgdGFnIG1hdGNoIGVhY2ggc3Vic3lzdGVtIGNvbnZlbnRpb24uIA0KQWxzbyBtYWtlIGl0IGdl
bmVyYWxseSBtb3JlIHVzZWZ1bC4gSS5lLiBsaWtlIHRoaXMNCmZvciBtb3N0IG9mIHRoZSBhcmNo
L3g4NiBwYXRjaGVzOg0KDQpTdWJqZWN0OiB4ODYvY3B1OiBVc2UgbmV3IEludGVsIENQVSBtb2Rl
bCAjZGVmaW5lcw0KDQpQZXJoYXBzIGFsbCB0aGUgcGllY2VzIHdpdGggUmV2aWV3ZWQgb3IgQWNr
ZWQNCnRhZ3MgY2FuIGdvIGludG8gdGlwIHRyZWUgbmV4dCB3ZWVrPw0KDQotVG9ueQ==

