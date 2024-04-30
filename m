Return-Path: <linux-kernel+bounces-163337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12498B699C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55621C219F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712F13FFC;
	Tue, 30 Apr 2024 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FR7frI5m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AD8BF0;
	Tue, 30 Apr 2024 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452777; cv=fail; b=WwD4zozFAFWReFQdXa/MHWf+oHBXxkqdNvoi3lZvEu49rSQEqhGXa8KPcBtZNehyTtCleVpJ0ZzacNvIVzdvFGhFGDgps5xwYEgTzGxL6qd/qC66ak99PokVEEZPy5SeHdJa5WyS9DAcEJSb3hRqT9ghELyy+aKOAF29EYUcTCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452777; c=relaxed/simple;
	bh=/+hudyS4dfBzaXrAWuK52ergGE+EzdXLRdNbOszV2vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ukheSBvJy2AWod48UmcfeEV8j0HlQTnLDubicHPUmNCTZGCv8YZyj4WmXiUkVDqcNAIJxDql1vFRye6ICWJ8/4Hd8qr0oEYhtjQRhWfMA/daW50CAxPLZvAIQI8tt1p9gyV6nuULbcdtqdJe3aDMYqQgK/fNG0ng4dYPNjHMA1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FR7frI5m; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714452776; x=1745988776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/+hudyS4dfBzaXrAWuK52ergGE+EzdXLRdNbOszV2vo=;
  b=FR7frI5mGdw22YH+001knQUBflAADeJfM+CgxLQIcXiYQBIxE83VJ0XK
   giVUFNnzEpadPT5iQUxyJx0sp77WCnOuCvKEBHxHbERtdkOnlJmUCtNbC
   mGIFa8ahg2Lay5lz10A0YockcKYiuU7zj4YAAiMVx/gT8z3zEwLEVEi66
   2jdRe82M4EBZvwGrIDVl/3tBJaUalLQ4g8bwgc4v61zkwAKicXRp6Un+D
   plEDYwd1AsF1xAL10nBSyrZvEk2/62qJSRqv+rxxsrL1ftWhg9lRHn1rZ
   MVzuNcR09aaQ8y7fnVc1tNP2PeUFj2565dooUdIF4QF/4wgO7k9WT+W/r
   w==;
X-CSE-ConnectionGUID: H1Zvrt5hSY2AeIT+7eVxwQ==
X-CSE-MsgGUID: NSuLUf5vT1KM6LFGwC+vEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10259399"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10259399"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 21:52:55 -0700
X-CSE-ConnectionGUID: QYUKN7KoTkCa6XnfbaS3Qg==
X-CSE-MsgGUID: thnmLNP+Ssa4PiP4TV4NuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30966408"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 21:52:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 21:52:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 21:52:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 21:52:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 21:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekfdg1v1FNZRwkmK+GhyK6EtLvrpFJ3j/XHorrTnAjkMjJ99RnuYaRdZ7peaixv84ACL83H1ST9p5RacTyowX0OiYnpbiEBf0a9Oe8/v/k8f4dlcEX9a+vq+AzmaNRdzWLCC7mhk7fUBZnb8gEbwX4wkdm5IgpmMehUpDCvPZwzjs5YmW1D8+9zTd1/TUm4u5Q6zaiPNRTYBT3Mi//e4YNtYWGWXsYa+88nn8w95B5x3cduwZjuqZ7lMCZPcCSYrU8AkR03k5+kkcKCUtkNt+kC46oH4forlciSS+5MO47vbeSV0OXWyUN9SuQXITeod2pRQZ7BX0pQeZOgVqLoEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+hudyS4dfBzaXrAWuK52ergGE+EzdXLRdNbOszV2vo=;
 b=FJA+SFXa2I9k8sWx1JdxjiWib4UrHsfghJNY7q3fDEiMC2WbiVHm3GGtajiTKDVQ9ejIIi1cpvQS9uBN1cYNJwQ1boXNCHq5pdAamk9hYlEoYSUol2kcDrhaVxdPyYud7rcBXQcde6tj/QTcR9sjG/NKMO33ci7Pjdi5pvXbWgMk3NYrCJL9bnJqifhxpepFmq7zkjBnuCtbyTkuVs8gSluJZ5ilpp8btJOn5UpsRdR4mM2UtuiVI9uCJSa1ENizypcDtkTlH93CN1p1OwUDHJGL7hn0nnWyUnoATtMAdf2j5NxGj+6Fdmt6tpmFOl2FYbd4K7quc+zo5e1ZqBx2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Tue, 30 Apr
 2024 04:52:52 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 04:52:52 +0000
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
Subject: Re: [PATCH 2/4] thermal: intel: hfi: Tune the HFI thermal netlink
 event delay via debugfs
Thread-Topic: [PATCH 2/4] thermal: intel: hfi: Tune the HFI thermal netlink
 event delay via debugfs
Thread-Index: AQHamo3oDex/+iEM5EOV+lG32ubFxLGAP2UA
Date: Tue, 30 Apr 2024 04:52:52 +0000
Message-ID: <e7fa25681ed057988c5ed14ebddad72e09b20703.camel@intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
	 <20240429234152.16230-3-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240429234152.16230-3-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW4PR11MB7008:EE_
x-ms-office365-filtering-correlation-id: b27fb835-39fa-484a-b040-08dc68d16477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NkdjTmJlUkYxT05TTXBqUEl1eFdZTjRvaEU3OEJHTGhDYWZCTENEaURYeHE2?=
 =?utf-8?B?VldEZWxWOWJ2ektoY3R1TloxOVJiVWhXNVZPdVVuQ3BWT1B2MVVZZGx0bjha?=
 =?utf-8?B?K3NZdHg5MGozRWpWeHgwOWQwSjNNUVRTOGRNaStsU1FBdDVaS1BtR3hwVTlB?=
 =?utf-8?B?RzJTNVpva0ljVW54YWZKL1JveWYzYnZqcmR3Wit0QkxxUkdId203REdZcHgy?=
 =?utf-8?B?R3AwNTBsS2hweW1iZmRxcTd6NGg1eXVkS2gramxyemNvK2ppNXlxSjNLVzRH?=
 =?utf-8?B?alVsR1ZEVTU2OW5pWURlNGVhazcxZTJ1NjQzcy9mM1drRDVuL2RpNTVXRXBj?=
 =?utf-8?B?MGNaeldBL2dBdGhKUG0vMjhDR3RCcFNOak5FM24wRGU5cXMrM1RaODFPTnVQ?=
 =?utf-8?B?TWFVV3hrV3ZYelhTNzhaSWZ5TWRjWlpSNzBzcXpGcGVtNXNMM3Q3S1g2ZnRx?=
 =?utf-8?B?RVFvWWR1VG1taTVHS0ViNWFJOFRhTnJORlpmRUxUdlJ6ZXZ1T082M2o5SXdV?=
 =?utf-8?B?N1UrSEU2QkdXR1dNZW9QQ040NkZsYWZMTyswU3VtcWxJRTNicjBTUkg1SlBP?=
 =?utf-8?B?cC9DU2d6ODdiS0ZGbWlpSVJlbEFLRG5OUU9oSzh2VnQ4ODJaWUN1R1BMVWdU?=
 =?utf-8?B?UmhnNzBuQ1R5bXFweEJQMXovWjlCVkRNUkY2dkI1b2VuZjBGeHpHRlR0R1l5?=
 =?utf-8?B?b3JSZjNjaktxaXRiU1puYmZ4bjd2WTZYZ1dPQ0N1MFZTOVhSU291em5sZ0h5?=
 =?utf-8?B?RU9JYi9YbTRZck1tbll2eHZaR0M3UjdSK1NnNWtZOFFiY1diSnFsK3JNSmhK?=
 =?utf-8?B?cjZVZnJaL20yQzZFcXZWOGNYMURHTUxSZEgwMHVDcmZzTFJuS29Wbm1lQVJs?=
 =?utf-8?B?R2ErcXZNZzgxOU9OUm93SDhUZjU2Yy9OVUVlT211alZKb2NnNEtNb3NudzRr?=
 =?utf-8?B?MjNDWEtYQTJRNXdwVHpHY0dDTlo3RFZzaWpQNjZwRTVEQ2JnUnRpK1l5MWRJ?=
 =?utf-8?B?MUxnWkcvUkdrTTNrcHNtRzRibmNEVWhEdDBwUjZnNHNqRkphYTlTYnBFalpM?=
 =?utf-8?B?N3BiazFsQk56NTZyeW43OE9pT0o2dHZQSmkwZWdIcXNRK1FwUURsQ0xYdThI?=
 =?utf-8?B?ZStSM2JsOUtMUVJWblNBZks2YWo4OTB3VzJnQTZINjJnY3BORFRORkNTNzhG?=
 =?utf-8?B?VGF5Wm03MGVFTWYvTzFmcmxhM1pXWk5ENFdQM0VXSzRMMENYVWRzbEM0Tmc4?=
 =?utf-8?B?ZGZrbG1td0pSRFFxcDk4dXBSK1RlV3ZNVG5MWE9GanVUb1BrcnRkRnFzc2l1?=
 =?utf-8?B?eUJFRXNZUVRicWdZK0tCZTlSNThQYXpDbkVOM3FNeUpRY3NmNGc0ZjFzZHVC?=
 =?utf-8?B?SUh6cmVGWU9wSjdyNVB0OXA1QVdsRVcyRnVEdEZWMnZkcEV3bHRiRDBLYTRV?=
 =?utf-8?B?dmJXU0ZJanUvNWdEeGlvZUptdHh2Wk40YVlMcnN6TDRnVEs3RzMyZDBKYzcx?=
 =?utf-8?B?RDVRMWNnbUN6MDl4cEZKMjZvZjBpY2ZzdnB3WjRIQW4zZTB4ZzhaSDJ0eVhj?=
 =?utf-8?B?dnY2SExMcDV0YkdIakJQdmNpRVBkZVNFZ3lYWkhodXFZSVpSMVZUMk9iVzBU?=
 =?utf-8?B?MVJEQnBra1F0SE9iMWIxVFp1Q1Q3YTlscUhramtRVHVVdWNsc2FFck4rODhr?=
 =?utf-8?B?S0lJdFZFNlpSQXIvWWJZWVFyc0dMblZmS1p0QlZJK0R5K1F6allOMHUrWE5p?=
 =?utf-8?B?cFRVNmpsTkhaUlZkZGc0dkhmdUd4NzQ4d1JlNDBTK2x3ejVuMlVYV2hIZWUx?=
 =?utf-8?B?bU9PTFlpajRaNWNpRDNCZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkdvdGFMTks2c2lOT0dVSU1wS052NS9KWTAxLzZ2M0MvYUFtM1BKanNHMito?=
 =?utf-8?B?UThYMzl4WkFxT3crclU3Rjkrc25zOERPdXpjZjVFMHVIOTFqWEd2VUxMT3Qx?=
 =?utf-8?B?aTVwZWlXM09oR0ZWaEYyelIrOFZ1eGttbmtYRTNyYm5VVmdLa3B0WkhlUEx6?=
 =?utf-8?B?YUdjWHZMZ0dQV3BlZnJlUVgyanptYXovamJ4emJBSGlmSXJCY1I4VFk3ZlMv?=
 =?utf-8?B?aGVseVVKK3AzOHlvUVBsU2ZzZncvalBSbWkzNU92VmZ3RXpidE51Tk1QSTlQ?=
 =?utf-8?B?b0I0QlpRVGRlQThSVXZwYXZVbnRLTEtXYXNFeWZmc3VmTUFXcnBrOHFocmJj?=
 =?utf-8?B?WGJhQ3BGQUVnYVRyU2YrZFIxdGo2cysvYjdjTU5RY3Q5YUlXZDlCY2k2Vk5o?=
 =?utf-8?B?c1d5WnVMdzBudVh4NzZ1YmE3QUFOZmhMbXQrYjI3N2laQTZsOVcrYXZmMHVt?=
 =?utf-8?B?U1hhd0x1MXhqTS95OVVpUE95bGpFVWFkSUc1amt2TVp6VUFZZWJJWERNZHFi?=
 =?utf-8?B?R3hLeXlHaENmUHJiTXZxL3UzVGNJSjlMN0FoaHh2aUFjK3ZvZjVteWdtR3U5?=
 =?utf-8?B?M1RYS3pyM0NxeGxsaHB1M2Y5WjJOVWRGaFhkQlhhc2d2WnFPdmc0Q2RuTnhl?=
 =?utf-8?B?YnNzSFpnaUpSSmM3cWptNDJ4V3pPSXpESVR1Nmk5QnZYY3UzbWVaNzhqSFNO?=
 =?utf-8?B?cndYakVFZHh0SkQ5U25vMGx6Zzl5b2JRc1pLODJSSm9pa25Zd1JyL3JYNDNY?=
 =?utf-8?B?djlWZ3loaGFtd1lycWx6ajh2UmNneERFYlFSYzR2emxXR214TnI1WnFGYWVK?=
 =?utf-8?B?UUNmdjVMOGlvY3R4MS9lUUtoVGVDN3JLcTJ6OTJ4dVJnV3QydGNoTXZvdlEy?=
 =?utf-8?B?Vzl0Qk11ekhYVE44T2JCZXpPRWRLdS9DVzZlK3pPUTlwcmM0YmhVNUdIdVVY?=
 =?utf-8?B?bmhydjZzL2M0QnlkQ2U5U1k4RW9qeG1GN2xKZ0dRM0dnUms1N2o5a1NJYit0?=
 =?utf-8?B?Y3BSNDdpMHNnV2RzNldyZlJzMGVUUkRJNGxkVEp2N3R6MThoVWRjbldLV2JZ?=
 =?utf-8?B?eWtCbXd3K1Y4MHFQR3BhN1FUMlpCaGxEZTVEWWlnRGN3MFNFSU1XOUNNc1RL?=
 =?utf-8?B?a013a2c4UFgzUWk0UGVOdU9hYkZPZHdoc2tnZVdLQml4RnkxY0gvb0J3SC9i?=
 =?utf-8?B?Rkx2c1V2a2NiUTVwdEt3WGpmcnE4YU9nTVBTVURORDloREFmaC8wV25SYmhw?=
 =?utf-8?B?akxtbEdQNkh6Z0M0T0Y5UVI2ZkRTY3NyNzdpVXl1ZEtJTGhKVkJQdmh1NUZD?=
 =?utf-8?B?NHRYS1ZMUnZYVzJxY1J1ZjdsV2RoQUM4cHR6ZEpJZDZYV3lLSWdSRnhDZlJX?=
 =?utf-8?B?eldUR0U0TEhLZGpvUVlvT1l0V1oyNE5TbWFIbGZZVWlUbThlZmZwT1RMeGJX?=
 =?utf-8?B?UHc5aU5HTFBsa3Nsb2lWUHJtOVFIMDJpK2pocEJrTFFnT0VsRldiWmRUZXBI?=
 =?utf-8?B?YnBrd1htZGpyYmFKU2pqU3QzbE9pbk9yNnZpSTF4YVMvbm5WTzhvN2xOQTl3?=
 =?utf-8?B?OGIxY05HWHRaWDZkRjhLODBxalovSnlXN3pxVkpIV3Y2QzVoeUE5QWFUb2hy?=
 =?utf-8?B?OGFnbFhNejkxMWxsb0JQaXdIa0ZLWDNsRHFMakw3T212N0pLQjhHdDE3UnhM?=
 =?utf-8?B?U1NzVkFzQVBJc3ZJYkdZc3ZTbG5xNVZtYnExWlRsSzNndzVyRFJ4WmpEeC9L?=
 =?utf-8?B?WWJZM1Z5U00zMnh0UVBQRXRFT2lkbHhsSmh4akh6c2VTbjBDaFZVakRMNHVG?=
 =?utf-8?B?bXpiSnFyZFNNVXYvZ1hlUjR4SlZIbWxiQmxmY1Q2djJHUUd4Vm9GcnRBMU04?=
 =?utf-8?B?WHdLUE42N0MvQURxZUFuK04rN3piVXppemtxdWF5WnZ6d1NrVkVtY1c3WG8z?=
 =?utf-8?B?Q0JFa0krUDN1QmQ2YjFYZnVaRm1tRk1hNWFSaFRwQllrSVVRWlFFcmgwdVJV?=
 =?utf-8?B?dmpsV0FrMk41bmluZVl5cmVBZHJyT2tSbitZci9lVThrOUNCcm9Ec1FDUTdZ?=
 =?utf-8?B?SW5vT1hKeTdBZVZLZitCaE1raGw3NjBFVHpjMlI3SVI0U1J4WGtIckNjZWx3?=
 =?utf-8?B?ajNxcUR0NkxLTGwvczV1cHptRXZWV0EybnREdVdoN2oxd05UakFSM0F1NktV?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <878D0969643ED44D8C820015AA06020A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27fb835-39fa-484a-b040-08dc68d16477
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 04:52:52.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FH3slQjYAn3x/5rOGfGoeqvQ5NxsR/JYpzjdJncHf0eeXe7tJcpL28FwE0ajsCE4it7ne39ZeFvjYLSd4qvkDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDE2OjQxIC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6DQo+
IFRIZSBkZWxheSBiZXR3ZWVuIGFuIEhGSSBpbnRlcnJ1cHQgYW5kIGl0cyBjb3JyZXNwb25kaW5n
IHRoZXJtYWwNCg0Kcy9USGUvVGhlDQoNCj4gbmV0bGluaw0KPiBldmVudCBoYXMgc28gZmFyIGJl
ZW4gaGFyZC1jb2RlZCB0byBDT05GSUdfSFogamlmZmllcy4gVGhpcyBtYXkgbm90DQo+IHN1aXQN
Cj4gdGhlIG5lZWRzIG9mIGFsbCBoYXJkd2FyZSBjb25maWd1cmF0aW9ucyBvciBsaXN0ZW5lcnMg
b2YgZXZlbnRzLg0KPiANCj4gSWYgdGhlIHVwZGF0ZSBkZWxheSBpcyB0b28gbG9uZywgbXVjaCBv
ZiB0aGUgaW5mb3JtYXRpb24gb2YNCj4gY29uc2VjdXRpdmUNCj4gaGFyZHdhcmUgdXBkYXRlcyB3
aWxsIGJlIGxvc3QgYXMgdGhlIEhGSSBkZWxheWVkIHdvcmtxdWV1ZSBwb3N0cyBhDQo+IG5ldw0K
PiB0aGVybWFsIG5ldGxpbmsgZXZlbnQgb25seSB3aGVuIHRoZXJlIGFyZSBubyBwcmV2aW91cyBw
ZW5kaW5nIGV2ZW50cy4NCj4gSWYNCj4gdGhlIGRlbGF5IGlzIHRvbyBzaG9ydCwgbXVsdGlwbGUs
IGV2ZW50cyBtYXkgb3ZlcndoZWxtIGxpc3RlbmVycy4NCj4gDQo+IExpc3RlbmVycyBhcmUgYmV0
dGVyIHBsYWNlZCB0byBkZXRlcm1pbmUgdGhlIGRlbGF5IG9mIGV2ZW50cy4gVGhleQ0KPiBrbm93
IGhvdw0KPiBxdWlja2x5IHRoZXkgY2FuIGFjdCBvbiB0aGVtIGVmZmVjdGl2ZWx5LiBUaGV5IG1h
eSBhbHNvIHdhbnQgdG8NCj4gZXhwZXJpbWVudA0KPiB3aXRoIGRpZmZlcmVudCB2YWx1ZXMuDQo+
IA0KPiBTdGFydCBhIGRlYnVnZnMgaW50ZXJmYWNlIHRvIHR1bmUgdGhlIG5vdGlmaWNhdGlvbiBk
ZWxheS4NCg0KV2h5IHRoaXMgaXMgaW1wbGVtZW50ZWQgYXMgZGVidWdmcyByYXRoZXIgdGhhbiBh
IG1vZHVsZSBwYXJhbT8NCg0KdGhhbmtzLA0KcnVpDQo+IA0KPiBLZWVwIHRoaW5ncyBzaW1wbGUg
YW5kIGRvIG5vdCBhZGQgZXh0cmEgbG9ja2luZyBvciBtZW1vcnkgYmFycmllcnMuDQo+IFRoaXMN
Cj4gbWF5IHJlc3VsdCBpbiB0aGUgSEZJIGludGVycnVwdCBvY2Fzc2lvbmFsbHkgcXVldWVpbmcg
d29yayB1c2luZw0KPiBzdGFsZQ0KPiBkZWxheSB2YWx1ZXMsIGlmIGF0IGFsbC4gVGhpcyBzaG91
bGQgbm90IGJlIGEgcHJvYmxlbTogdGhlIGRlYnVnZnMNCj4gZmlsZQ0KPiB3aWxsIHVwZGF0ZSB0
aGUgZGVsYXkgdmFsdWUgYXRvbWljYWxseSwgd2UgZG8gbm90IGV4cGVjdCB1c2VycyB0bw0KPiB1
cGRhdGUNCj4gdGhlIGRlbGF5IHZhbHVlIGZyZXF1ZW50bHksIGFuZCB0aGUgZGVsYXllZCB3b3Jr
cXVldWUgb3BlcmF0ZXMgaW4NCj4gamlmZmllcw0KPiByZXNvbHV0aW9uLg0KPiANCj4gU3VnZ2Vz
dGVkLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhDQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4
LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBOZXJpIDxyaWNhcmRvLm5lcmkt
Y2FsZGVyb25AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gQ2M6IExlbiBCcm93biA8bGVuLmJy
b3duQGludGVsLmNvbT4NCj4gQ2M6IFNyaW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRy
dXZhZGFAbGludXguaW50ZWwuY29tPg0KPiBDYzogU3RhbmlzbGF3IEdydXN6a2EgPHN0YW5pc2xh
dy5ncnVzemthQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gwqBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50
ZWxfaGZpLmMgfCA3Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMNCj4gYi9kcml2ZXJzL3Ro
ZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMNCj4gaW5kZXggZTJiODJkNzFhYjZiLi4yNGQ3MDgyNjhj
NjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYw0KPiAr
KysgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMNCj4gQEAgLTQzLDYgKzQzLDEw
IEBADQo+IMKgDQo+IMKgI2luY2x1ZGUgPGFzbS9tc3IuaD4NCj4gwqANCj4gKyNpZmRlZiBDT05G
SUdfREVCVUdfRlMNCj4gKyNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+ICsjZW5kaWYNCj4g
Kw0KPiDCoCNpbmNsdWRlICJpbnRlbF9oZmkuaCINCj4gwqAjaW5jbHVkZSAidGhlcm1hbF9pbnRl
cnJ1cHQuaCINCj4gwqANCj4gQEAgLTE2OSw2ICsxNzMsNzAgQEAgc3RhdGljIHN0cnVjdCB3b3Jr
cXVldWVfc3RydWN0ICpoZmlfdXBkYXRlc193cTsNCj4gwqAjZGVmaW5lIEhGSV9VUERBVEVfREVM
QVnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBIWg0KPiDCoCNkZWZpbmUgSEZJX01BWF9U
SEVSTV9OT1RJRllfQ09VTlTCoMKgwqDCoMKgMTYNCj4gwqANCj4gKy8qIEtlZXAgdGhpcyB2YXJp
YWJsZSA4LWJ5dGUgYWxpZ25lZCB0byBnZXQgYXRvbWljIGFjY2Vzc2VzLiAqLw0KPiArc3RhdGlj
IHVuc2lnbmVkIGxvbmcgaGZpX3VwZGF0ZV9kZWxheSA9IEhGSV9VUERBVEVfREVMQVk7DQo+ICsN
Cj4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4gK3N0YXRpYyBpbnQgaGZpX3VwZGF0ZV9kZWxh
eV9nZXQodm9pZCAqZGF0YSwgdTY0ICp2YWwpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoG11dGV4
X2xvY2soJmhmaV9pbnN0YW5jZV9sb2NrKTsNCj4gK8KgwqDCoMKgwqDCoMKgKnZhbCA9IGppZmZp
ZXNfdG9fbXNlY3MoaGZpX3VwZGF0ZV9kZWxheSk7DQo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X3Vu
bG9jaygmaGZpX2luc3RhbmNlX2xvY2spOw0KPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4g
K30NCj4gKw0KPiArc3RhdGljIGludCBoZmlfdXBkYXRlX2RlbGF5X3NldCh2b2lkICpkYXRhLCB1
NjQgdmFsKQ0KPiArew0KPiArwqDCoMKgwqDCoMKgwqAvKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBU
aGUgbXV0ZXggb25seSBzZXJpYWxpemVzIGFjY2VzcyB0byB0aGUgZGVidWdmcyBmaWxlLg0KPiAr
wqDCoMKgwqDCoMKgwqAgKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBoZmlfcHJvY2Vzc19ldmVudCgp
IGxvYWRzIEBoZmlfdXBkYXRlX2RlbGF5IGZyb20gaW50ZXJydXB0DQo+IGNvbnRleHQuDQo+ICvC
oMKgwqDCoMKgwqDCoCAqIFdlIGNvdWxkIGhhdmUgc2VyaWFsaXplZCBhY2Nlc3NlcyB3aXRoIGEg
c3BpbmxvY2sgb3IgYQ0KPiBtZW1vcnkgYmFycmllci4NCj4gK8KgwqDCoMKgwqDCoMKgICogQnV0
IHRoaXMgaXMgYSBkZWJ1ZyBmZWF0dXJlLCB0aGUgc3RvcmUgb2YNCj4gQGhmaV91cGRhdGVfZGVs
YXkgaXMNCj4gK8KgwqDCoMKgwqDCoMKgICogYXRvbWljLCBhbmQgd2lsbCBzZWxkb20gY2hhbmdl
LiBBIGZldyBsb2FkcyBvZg0KPiBAaGZpX3VwZGF0ZV9kZWxheSBtYXkNCj4gK8KgwqDCoMKgwqDC
oMKgICogc2VlIHN0YWxlIHZhbHVlcyBidXQgdGhlIHVwZGF0ZWQgdmFsdWUgd2lsbCBiZSBzZWVu
DQo+IGV2ZW50dWFsbHkuDQo+ICvCoMKgwqDCoMKgwqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgwqBt
dXRleF9sb2NrKCZoZmlfaW5zdGFuY2VfbG9jayk7DQo+ICvCoMKgwqDCoMKgwqDCoGhmaV91cGRh
dGVfZGVsYXkgPSBtc2Vjc190b19qaWZmaWVzKHZhbCk7DQo+ICvCoMKgwqDCoMKgwqDCoG11dGV4
X3VubG9jaygmaGZpX2luc3RhbmNlX2xvY2spOw0KPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsN
Cj4gK30NCj4gKw0KPiArREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKGhmaV91cGRhdGVfZGVsYXlf
Zm9wcywNCj4gaGZpX3VwZGF0ZV9kZWxheV9nZXQsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhmaV91cGRhdGVfZGVsYXlfc2V0LCAiJWxsdVxuIik7
DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpoZmlfZGVidWdmc19kaXI7DQo+ICsNCj4g
K3N0YXRpYyB2b2lkIGhmaV9kZWJ1Z2ZzX3VucmVnaXN0ZXIodm9pZCkNCj4gK3sNCj4gK8KgwqDC
oMKgwqDCoMKgZGVidWdmc19yZW1vdmVfcmVjdXJzaXZlKGhmaV9kZWJ1Z2ZzX2Rpcik7DQo+ICvC
oMKgwqDCoMKgwqDCoGhmaV9kZWJ1Z2ZzX2RpciA9IE5VTEw7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyB2b2lkIGhmaV9kZWJ1Z2ZzX3JlZ2lzdGVyKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBkZW50cnkgKmY7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgaGZpX2RlYnVnZnNfZGly
ID0gZGVidWdmc19jcmVhdGVfZGlyKCJpbnRlbF9oZmkiLCBOVUxMKTsNCj4gK8KgwqDCoMKgwqDC
oMKgaWYgKCFoZmlfZGVidWdmc19kaXIpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm47DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgZiA9IGRlYnVnZnNfY3JlYXRlX2ZpbGUo
InVwZGF0ZV9kZWxheV9tcyIsIDA2NDQsDQo+IGhmaV9kZWJ1Z2ZzX2RpciwNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTlVM
TCwgJmhmaV91cGRhdGVfZGVsYXlfZm9wcyk7DQo+ICvCoMKgwqDCoMKgwqDCoGlmICghZikNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyOw0KPiArDQo+ICvCoMKgwqDC
oMKgwqDCoHJldHVybjsNCj4gK2VycjoNCj4gK8KgwqDCoMKgwqDCoMKgaGZpX2RlYnVnZnNfdW5y
ZWdpc3RlcigpOw0KPiArfQ0KPiArDQo+ICsjZWxzZQ0KPiArc3RhdGljIHZvaWQgaGZpX2RlYnVn
ZnNfcmVnaXN0ZXIodm9pZCkNCj4gK3sNCj4gK30NCj4gKyNlbmRpZiAvKiBDT05GSUdfREVCVUdf
RlMgKi8NCj4gKw0KPiDCoHN0YXRpYyB2b2lkIGdldF9oZmlfY2FwcyhzdHJ1Y3QgaGZpX2luc3Rh
bmNlICpoZmlfaW5zdGFuY2UsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGhlcm1hbF9nZW5sX2NwdV9jYXBzICpjcHVfY2FwcykNCj4g
wqB7DQo+IEBAIC0zMjEsOCArMzg5LDEzIEBAIHZvaWQgaW50ZWxfaGZpX3Byb2Nlc3NfZXZlbnQo
X191NjQNCj4gcGtnX3RoZXJtX3N0YXR1c19tc3JfdmFsKQ0KPiDCoMKgwqDCoMKgwqDCoMKgcmF3
X3NwaW5fdW5sb2NrKCZoZmlfaW5zdGFuY2UtPnRhYmxlX2xvY2spOw0KPiDCoMKgwqDCoMKgwqDC
oMKgcmF3X3NwaW5fdW5sb2NrKCZoZmlfaW5zdGFuY2UtPmV2ZW50X2xvY2spOw0KPiDCoA0KPiAr
wqDCoMKgwqDCoMKgwqAvKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBkZWJ1Z2ZzIG1heSBhdG9taWNh
bGx5IHN0b3JlIEBoZmlfdXBkYXRlX2RlbGF5IHdpdGhvdXQNCj4gbG9ja2luZy4gVGhlDQo+ICvC
oMKgwqDCoMKgwqDCoCAqIHVwZGF0ZWQgdmFsdWUgbWF5IG5vdCBiZSBpbW1lZGlhdGVseSBvYnNl
cnZlZC4gU2VlIG5vdGUgaW4NCj4gK8KgwqDCoMKgwqDCoMKgICogaGZpX3VwZGF0ZV9kZWxheV9z
ZXQoKS4NCj4gK8KgwqDCoMKgwqDCoMKgICovDQo+IMKgwqDCoMKgwqDCoMKgwqBxdWV1ZV9kZWxh
eWVkX3dvcmsoaGZpX3VwZGF0ZXNfd3EsICZoZmlfaW5zdGFuY2UtDQo+ID51cGRhdGVfd29yaywN
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhG
SV9VUERBVEVfREVMQVkpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaGZpX3VwZGF0ZV9kZWxheSk7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRp
YyB2b2lkIGluaXRfaGZpX2NwdV9pbmRleChzdHJ1Y3QgaGZpX2NwdV9pbmZvICppbmZvKQ0KPiBA
QCAtNzA4LDYgKzc4MSw4IEBAIHZvaWQgX19pbml0IGludGVsX2hmaV9pbml0KHZvaWQpDQo+IMKg
DQo+IMKgwqDCoMKgwqDCoMKgwqByZWdpc3Rlcl9zeXNjb3JlX29wcygmaGZpX3BtX29wcyk7DQo+
IMKgDQo+ICvCoMKgwqDCoMKgwqDCoGhmaV9kZWJ1Z2ZzX3JlZ2lzdGVyKCk7DQo+ICsNCj4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybjsNCj4gwqANCj4gwqBlcnJfbmxfbm90aWY6DQoNCg==

