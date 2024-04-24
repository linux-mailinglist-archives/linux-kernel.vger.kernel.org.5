Return-Path: <linux-kernel+bounces-157371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A732E8B10AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B328721D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A516D32A;
	Wed, 24 Apr 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kc20VS4Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC416C6B7;
	Wed, 24 Apr 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978509; cv=fail; b=CHrIJL9mQQJUVVqkxeyPz4WXpQmJy2nq7SBBKLCl6EetWfGfIihK8nNn+7OxYTA9U6iymTBLezwU0S7Gg8gGQsARSH+fTvSMMBHgGHBBgHg/X/eItwbLxKYtbBzZdXVJleK1Va1FXg/T3dTfuB/LJT50cha5uHRQHZRCfwOodew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978509; c=relaxed/simple;
	bh=ALf4G/hXn+SIvgALMl9GmFGbS8M/iLuntTrrcPU2M/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7RN3KxIb8cz3MBBxegPs851LribCCRmCQSgiTtJkSxElUHsMVbUGo6omIEzZC5yIoX88xX+463cYtrN+trPhuD1rcxnhB2AG4i6XwiXEVnueRhjnFty4Kza9N8pHM31v7uJ5ek2gVzJ+SG1uDQLyVtjtwz0X2iuhHkebL3gaaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kc20VS4Y; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713978508; x=1745514508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ALf4G/hXn+SIvgALMl9GmFGbS8M/iLuntTrrcPU2M/Y=;
  b=kc20VS4Y0kJQubb39HXmokrAdxuflUWDVmz9dC/9ln4LVw84x/b23t1C
   D7V0dDR2/BNYonUH2hAQWCW276kn0vmTb0Gf8X796CHxekD8k2Gl0HluM
   8knEuQGHOJkz+uFmUPvbNlf4KSdVS4DpRqAflgRzucGTERwzPiyGsvHAF
   8cvn4QkMP5tquxMxLUucWvR+F9htQ2WKL+bfdSDU0IfhuK8Z5NV1Pa501
   qxjr1uvTlBQK44A4XZxf+50voNrkiAxVOEJhqW7v2sG4gRf4lZ74DfD97
   3weEysS87J8NMaa4LqS4ioAZT8VOOijpV3XrQzJ/ye+omkJR8j1qTgZUG
   g==;
X-CSE-ConnectionGUID: o18NsuoFRAiF6g5BOBtS3w==
X-CSE-MsgGUID: jmT0tnv3TzW6l99p4cthRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27140628"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="27140628"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:08:27 -0700
X-CSE-ConnectionGUID: YNKXohzsT3KZui/xM7ybFQ==
X-CSE-MsgGUID: vHV/I63eQjSlq/60Smf1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24663911"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 10:08:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:08:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:08:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 10:08:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 10:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0xXgzI+JpJnuRXNBqTD+g41JdbtueL3Zeazogg+7g9ifGe7wGc/ZFY6H6xTnXT7RbryIXboGwnHVb1VylRsK8XMzbys69e66slb4yWp3jGZ+dJ7CTwe8SPM/mN2GXfLFNm4uA02aYuq+z7bNxXU99Pk7Nkz3BB2yfsrvrnGCV4aWiHNAsq0aMAf1Wp5g8YQHzBJ6Lswp/tfMeTaDqLkry+Vg8nYfZaDa5WkBItPKhn8rQHAPRmFTGrJ42qLQFY9c5SxD67DhQ+HcjBXmuvNLzg1ps5YhqnUNd9/3yzbTKI1lkEvDpaBCMJjI71pEFpQRnR8JLiQq4OZ1baGP7o9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALf4G/hXn+SIvgALMl9GmFGbS8M/iLuntTrrcPU2M/Y=;
 b=EESA9JCtp1QrHavc1sh/aMxgTXooIHbzqrQKb0FL00jK1YwfwxnI/W3tOx1W1Q4j2weVgaQXsYocSV0gLMUucDMjk4HFXD1FUDvzY90CfCUKuLR0RLyuGERx1Wl5Dzx2K56p1uUEXbPv1A0dR2DHcl4Tory1K4l3bbSC4gEuJPFbHJNZZrZm5lmS2/A4Hii9H0yN2yHVJFXdEpfEOemnUY4CDQTY/kSpu4HKVbTRdVszbcrBroQmWg7z5f/GwLmnaZBVj99BrND6pKVUqrUBZ8TGUoJj1liN4QViH+OPp9aY1igPv+TTM5/lu2p9W7XHLm9tWuLWuuEeamz1Rj5pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 17:08:23 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 17:08:23 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHagg0bJu1HXMAx+EKTfolw5tlMzLFT6nUAgAADChCAIpCggIAAE36ggAAP1wCAAStEAA==
Date: Wed, 24 Apr 2024 17:08:23 +0000
Message-ID: <CO6PR11MB56359754A01778EA3EA53981EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com>
 <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com>
 <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com>
In-Reply-To: <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SN7PR11MB7592:EE_
x-ms-office365-filtering-correlation-id: a1dc8925-838a-48fa-59bf-08dc6481263a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eGMvalM1ZzROWjFValM2WVpzb3BpOUNjTFRwM3NuK3V4dkFEclpPVmhqYkwv?=
 =?utf-8?B?Nlp2d1pjdjBNTDdrcS9ETzE3OUx6MGNjN1l2aTlJNnA3MnluaFFJbHVqY2tO?=
 =?utf-8?B?b0hPVlMxOWF0UUF6M3dEWFp2Ti82NXB5WkxDSmZQY0E2OVYvYzdpTTlJZDV2?=
 =?utf-8?B?RXpTQ2NXakcxREdOTG5FQVpBNEFyT3YrTGFkVjBnbS9yUHd0SkZidFRuZ2ly?=
 =?utf-8?B?RVE2ZkljeWtqU2ZId0xrWmQ0S2RBUWc0cEhJK2ZrU3ZKaWJ6UGJ3U1dkYjhH?=
 =?utf-8?B?OTIvZFV3R3lEamdpWGtlL2NZVzEyN0JobWE2UjlmTGxETFJQeW5jZVpZME5F?=
 =?utf-8?B?QXU2byszZ1ZVVENXVjlBY3YwU2lvSXFGUi9FUUtraWJHeHJpa0dPMEdFVUcr?=
 =?utf-8?B?bElNR2pNdThBY1dOQXdlMzhuQTF1Q3FHOGpJTGduQWlrVlB0ay9UallzaXAw?=
 =?utf-8?B?UmwyNzVaT1FGMFZDbDUxK2hjcC9lK1V2R2hYVHVoWWNndTA4WjFmNTVLZmE1?=
 =?utf-8?B?OUhRUjNTT1FSM0kyZ0Vhd3pIWFV2TnZPcTFtOWNRV1ZvbU9qUzZ4ZERXVGlP?=
 =?utf-8?B?WVQ4MHNxZ1MveXVlNDlPT1ZzVVlDZGUzemNsd1BTeTM1OUM1RXA2TGRzMmc5?=
 =?utf-8?B?WU90SlNzeUdBYk9sME10ZGc1bS9Wc2pKNlQ0SXBRTmk3MERZTkFiWXNUMXBv?=
 =?utf-8?B?VCs3R0FzNmVNNjJaYnFHSlBlVS9sb0lwWXNHQ1dYUkkyZURzcmlEQ29aMGRk?=
 =?utf-8?B?RTQ4Y3Y3c1pZeGg1amJ3SDRKakJTdEkzTDdqL3g4WWhTLzI0eEhWeUJJaDB5?=
 =?utf-8?B?RWtTQmQ2eWhIT3A5VmlHc3pobnh4bWFDeHpSKzlOb2VLdU10R1Y3ZUJhRzJ5?=
 =?utf-8?B?dTRWUDQwc2dnWENnUVJLRmtXN2F5bjlhNlZVRTZLendVZC9LTUVwOWRxUDJH?=
 =?utf-8?B?RkxnbG5NeTVpcHJyODgyUzJmaFcvd1hwSURnNThmYzU5c2NIcVo5VzVwTjNC?=
 =?utf-8?B?cEt0VU5ZcTgxbzNyazJmcDZBZm9XZ3dGSFRaUnpuZm5oL0kxSVRJYThTeEpL?=
 =?utf-8?B?TEhBelRCb20wWmwvZDZmV3dMMkZVZFRFMGR2aktUNE05QkIyWXRNS0JlL00r?=
 =?utf-8?B?SzkyRG1jM0VQenhoZ1g4ams0QUZuTEhHS2FVdVVFOW8vcnVFT3VQWW1DbXIz?=
 =?utf-8?B?WU55L0tIOEpkSGhvVDBGQUJGZk5ydkQ1Z1dMSjQ1ZG1UVGdsVUkwVzZNVkQv?=
 =?utf-8?B?V1ZUem1jZ2Z3MmkwcVBkTnBZbUNuOGRkZjNSai9ZV0pZbjhOSlh0eWZBQVRM?=
 =?utf-8?B?SXhTTkFhZWp2Y2E0UGNva1RrM0FDWk1ZV0RpcTh3TThSTW5DWHdzUVJmZHhp?=
 =?utf-8?B?a3J6YXlDbGM2ZUdPU3hzTTdFc3cvZlNHS2d1RitBamIySzIwby9IUkkwdUk2?=
 =?utf-8?B?ZzR1eUZVSUZpVnRtVU1nLzJxaVdTaWVxT2ZsWUlwaUt2eXhHSzdlTGs3VTVn?=
 =?utf-8?B?L2pIUmxndXFnNkRSNVl1TXBFMUhFK2ZNY3RCWjY0S3pBRzBBRE41T1ZyS2du?=
 =?utf-8?B?OHZxbGc0OHZabml3WE0zMXg2d3QzL2REZnNEMjh5b3NVYXYvMC84UGN0UWtT?=
 =?utf-8?B?UWU2a0hueGEzQStxNUR0MG1NMU11TmFZREtIU1VsVnAzRHp0WFZybjVZVDVr?=
 =?utf-8?B?dWVDc2FkTytjaVVRemw1alNUTmtwWTJ2R2lZd0UyZmtMWHo4Vk5kM0dmM2M2?=
 =?utf-8?B?MTZoZXBIc3Vjd093R0tVN013YTRKRDBDclMvL0piZXhvMzdJZ1BNMWhqMmJs?=
 =?utf-8?B?WjFZVVlyVW5VcC9zWHJmZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmlRVFlwRjUwazJkY28wcWVMbUJhWFh2eEt6bWRyakxVYWorZk1tU1Bjdmt4?=
 =?utf-8?B?OVJqWGdJSHJPangvNDc1Ky9kQ2VyR3pwTHZRT016YXFRRlJNL01YaURwWjlW?=
 =?utf-8?B?NWRvWHB6RUVBcEpaOWJpeS9wR1Z4MDZLRy9Ua0prME1KcHZHV0wwTmdRMmdy?=
 =?utf-8?B?L3VibWN5a0VhUTdNUERnUEFFTCtPbm1heS9kdGNKdzdjTVdCWlIxaXRXK0d0?=
 =?utf-8?B?QjFDQUNGZmZ6MHRoZHVKbmlpdGlIQmRTUmcrUWNKaHJVb2drRjdLRlNiM3R2?=
 =?utf-8?B?NnkwdWFDcUM5bEtyVTlOVHo3L2xYa1FPSWY2eGNSV1lzN1BZK2NQOUVGZjdP?=
 =?utf-8?B?WDNyekpWa3N4R2pqWU4yazNad29pajZwQjZjYVhTQmpGUUI0TStnN3VRdTdO?=
 =?utf-8?B?WnVnNnJLcERMcThYVFJCOEZpYTVaMU9CYUJqLzNjZktkZWprZVRYZzhXZi9q?=
 =?utf-8?B?VU5uaDZIbEFUbE5JTGw0a2N5VEVnTlNQdFlUUWdzaHF2M0hkVGloeTlGRk1S?=
 =?utf-8?B?UUhRNndIb0gwbFI2V2t2S3RKeHcyZEJaQUk2ek9TWk4vZi9kT0phdDM0eHRz?=
 =?utf-8?B?NzJoRnhGTmxQQ0ZwS2lTdFpJbjYrR2pVSkEwd0svZExPMHNNWjBNSXlXdUlq?=
 =?utf-8?B?RFlSN2VpYlNoYmFzS2hJcnVjcVl2REk5bmlZeDVZbzJJOXkrUkYrUm5SZEpU?=
 =?utf-8?B?ZCtZeVhSNlpqcHVhc2ZzWE0vYTV2cFNOU0czTFZuTjQzY1lGNlZhZStkdkxk?=
 =?utf-8?B?c3RWNHFVSWh3U3hJSXNMOWFOb25XblZUTmlZdWUrZC9JRXJMZk5ETnJhVUZl?=
 =?utf-8?B?ZnhNVE8yL0k1QkluWEIwUjU1eVRhSnA2UjNZeFpZeUFOb2ZmZUtHTy8zWGdr?=
 =?utf-8?B?RXJCVGJUeHkzMVJKRTZLZno3cmNyaFQrcTRBR0hreHBpRkRpYzBtaTlBRDJk?=
 =?utf-8?B?OE14U1RYNVNMYXQ1dWN3YmpyZkU2R3JNV1Bjbk5yK2J1blFOcjhYc1JKMTFm?=
 =?utf-8?B?b2ZQWDJ6NnJ0RXVRK2dNV3NnZlRoemtMN2JySlhhS3BkYWNIc1AyK3ZDam1P?=
 =?utf-8?B?SkNEdndKaWxyOU1Ec2NIanFwUUQwZDErdzNxb003NW94MjhQUWlPYmN0YW9o?=
 =?utf-8?B?c3AvSElpa1dFUnlZUTFEeVFnb0ZjY09QS2JMWWIvU3QxbnhXRGlESWx0QTJ0?=
 =?utf-8?B?QXR2Rk1PbmRjaG5HbEp3SUZPZmd1RDhlRUpyR05zZDhPWjdKQ29UeEN0elpo?=
 =?utf-8?B?NmtCQlFmZUlKTDJuTDFQOU5ma1FoZ3hjYTRZNjVmK0ZYR0Jlb3kzZUxJQ0tD?=
 =?utf-8?B?ay9sV3hpaVYrSEZyYjF3cTVzNVF3WVJqZk9ubHlUYTlLWWx3RExncmNlVkRC?=
 =?utf-8?B?a1M0Z1JEMDh0bnloSm4ybmRVaDJnWldwVDduRjFmcE1ITDBVNUo5NGIyVUlN?=
 =?utf-8?B?TDMvYjVBSGxWdGw3SWxDVWM3RHJnU1JzQkU1WEt4Wk1TSmZGV1cvNCtIenVH?=
 =?utf-8?B?Mk1JYlVtdVpaWDhFdDBPcFpBZWVDOXdNOGg5eDg4R2Q4bkVYWWZiS3VORzJ2?=
 =?utf-8?B?RVhocFY4Uld2RWlFMHlQZGxvZWNCZTU2NmdvaEFMZm1IaXp3dDhjSnBXMXl0?=
 =?utf-8?B?ZVl3VEdMZTBhVTVqZmdJQ2dxL2NkZE9KRkFIcXJySjhnczVjQzA2dkRpTUt2?=
 =?utf-8?B?TDdoNXNTaFQvMmxZZE92eFc2ek1BMFBEUzZLWWd2VDAxT0JISjhZRlE4Z1Vv?=
 =?utf-8?B?NzVzRktoNTlPZm4vcTRZSmVMdVhjc1dHalp6UGpqY3RnNERPblFvYzN2VllH?=
 =?utf-8?B?dGh5K1lieE44T0pGb2RBNWFWZWRvRS8xdFMvazRWSlRNcXhvS0xleUMxNWtj?=
 =?utf-8?B?UFFMZFAvakJpaG9iZFo2Y2M1SnRnR21NTEg1YlNPK2lUc3A3Kzlwa2dLY0FR?=
 =?utf-8?B?YUM0cFR4cEdEYlNHNC92ZXp0Ymg4OFdDK2pFSEptdzhSU2dFd3VmOHFDNmxQ?=
 =?utf-8?B?aGNzcFJmRFZOR0JnMDJTV2NiejVjc3VmN3B4NFlwanlyV1dBd0xJRGZ0MllY?=
 =?utf-8?B?L2t3S1psZ1RnZFRlTjhQVzBSVjVOd3R0cFNGRy80TG5CUEJJODljOUxKZU9r?=
 =?utf-8?Q?jHGzlBwbRKzsAeGl8HkFDlS9a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dc8925-838a-48fa-59bf-08dc6481263a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 17:08:23.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fag6U9l/0wdiB31+f497NE23blE6EQCF/mk4aTSLkOg3fDTp5igPhQ8r4DkP/bojHTwJddsw1NMLPu3el/fxqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyMywgMjAyNCA0OjA2
IFBNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0K
PiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY2IDIvNV0gcGVyZiBzdGF0OiBGb3Jr
IGFuZCBsYXVuY2ggcGVyZiByZWNvcmQgd2hlbg0KPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJl
dGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJpYy4NCj4gDQo+IE9uIFR1ZSwgQXByIDIzLCAy
MDI0IGF0IDM6MTbigK9QTSBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4g
d3JvdGU6DQo+ID4gPiA+ID4gPiAtc3RhdGljIGludCBfX3J1bl9wZXJmX3JlY29yZCh2b2lkKQ0K
PiA+ID4gPiA+ID4gK3N0YXRpYyBpbnQgX19ydW5fcGVyZl9yZWNvcmQoY29uc3QgY2hhciAqKnJl
Y29yZF9hcmd2KQ0KPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgaW50IGkgPSAw
Ow0KPiA+ID4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgdHBlYnNfZXZlbnQgKmU7DQo+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiAgICAgICAgIHByX2RlYnVnKCJQcmVwYXJlIHBlcmYgcmVjb3JkIGZv
ciByZXRpcmVfbGF0ZW5jeVxuIik7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAg
IHJlY29yZF9hcmd2W2krK10gPSAicGVyZiI7DQo+ID4gPiA+ID4gPiArICAgICAgIHJlY29yZF9h
cmd2W2krK10gPSAicmVjb3JkIjsNCj4gPiA+ID4gPiA+ICsgICAgICAgcmVjb3JkX2FyZ3ZbaSsr
XSA9ICItVyI7DQo+ID4gPiA+ID4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLS1zeW50
aD1ubyI7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIGlmIChzdGF0X2NvbmZp
Zy51c2VyX3JlcXVlc3RlZF9jcHVfbGlzdCkgew0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
IHJlY29yZF9hcmd2W2krK10gPSAiLUMiOw0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJl
Y29yZF9hcmd2W2krK10gPSBzdGF0X2NvbmZpZy51c2VyX3JlcXVlc3RlZF9jcHVfbGlzdDsNCj4g
PiA+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICBp
ZiAoc3RhdF9jb25maWcuc3lzdGVtX3dpZGUpDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAg
cmVjb3JkX2FyZ3ZbaSsrXSA9ICItYSI7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAg
ICAgIGlmICghc3RhdF9jb25maWcuc3lzdGVtX3dpZGUNCj4gPiA+ICYmICFzdGF0X2NvbmZpZy51
c2VyX3JlcXVlc3RlZF9jcHVfbGlzdCkNCj4gPiA+ID4gPiB7DQo+ID4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgcHJfZXJyKCJSZXF1aXJlIC1hIG9yIC1DIG9wdGlvbiB0byBydW4gc2FtcGxpbmcu
XG4iKTsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVDQU5DRUxFRDsNCj4g
PiA+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICBs
aXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZzdGF0X2NvbmZpZy50cGVic19ldmVudHMsIG5kKSB7DQo+
ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICItZSI7DQo+ID4g
PiA+ID4gPiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9IGUtPm5hbWU7DQo+ID4g
PiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAgICAgcmVj
b3JkX2FyZ3ZbaSsrXSA9ICItbyI7DQo+ID4gPiA+ID4gPiArICAgICAgIHJlY29yZF9hcmd2W2kr
K10gPSBQRVJGX0RBVEE7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiAgICAgICAgIHJldHVy
biAwOw0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFN0aWxsIEkgdGhpbmsg
aXQncyB3ZWlyZCBpdCBoYXMgJ3BlcmYgcmVjb3JkJyBpbiBwZXJmIHN0YXQgKGRlc3BpdGUgdGhl
DQo+ID4gPiA+ID4gJ3BlcmYgc3RhdCByZWNvcmQnKS4gIElmIGl0J3Mgb25seSBJbnRlbCB0aGlu
ZyBhbmQgd2UgZG9uJ3QgaGF2ZSBhIHBsYW4NCj4gPiA+ID4gPiB0byBkbyB0aGUgc2FtZSBvbiBv
dGhlciBhcmNoZXMsIHdlIGNhbiBtb3ZlIGl0IHRvIHRoZSBhcmNoDQo+ID4gPiA+ID4gZGlyZWN0
b3J5IGFuZCBrZWVwIHRoZSBwZXJmIHN0YXQgY29kZSBzaW1wbGUuDQo+ID4gPiA+DQo+ID4gPiA+
IEknbSBub3Qgc3VyZSB3aGF0IGlzIHRoZSBwcm9wZXIgd2F5IHRvIHNvbHZlIHRoaXMuIEFuZCBJ
YW4gbWVudGlvbmVkDQo+ID4gPiA+IHRoYXQgcHV0IGNvZGUgaW4gYXJjaCBkaXJlY3RvcnkgY291
bGQgcG90ZW50aWFsbHkgY2F1c2Ugb3RoZXIgYnVncy4NCj4gPiA+ID4gU28gSSdtIHdvbmRlcmlu
ZyBpZiB3ZSBjb3VsZCBrZWVwIHRoaXMgY29kZSBoZXJlIGZvciBub3cuIEkgY291bGQgd29yaw0K
PiA+ID4gPiBvbiBpdCBsYXRlciBpZiB3ZSBmb3VuZCBpdCdzIGJldHRlciB0byBiZSBpbiBhcmNo
IGRpcmVjdG9yeS4NCj4gPiA+DQo+ID4gPiBNYXliZSBzb21ld2hlcmUgaW4gdGhlIHV0aWwvIGFu
ZCBrZWVwIHRoZSBtYWluIGNvZGUgbWluaW1hbC4NCj4gPiA+IElJVUMgaXQncyBvbmx5IGZvciB2
ZXJ5IHJlY2VudCAob3IgdXBjb21pbmc/KSBJbnRlbCBDUFVzIGFuZCB3ZQ0KPiA+ID4gZG9uJ3Qg
aGF2ZSB0ZXN0cyAoaG9wZWZ1bGx5IGNhbiBydW4gb24gb3RoZXIgYXJjaC9DUFVzKS4NCj4gPiA+
DQo+ID4gPiBTbyBJIGRvbid0IHRoaW5rIGhhdmluZyBpdCBoZXJlIHdvdWxkIGhlbHAgZml4aW5n
IHBvdGVudGlhbCBidWdzLg0KPiA+DQo+ID4gRG8geW91IG1lYW4gYnkgY3JlYXRpbmcgYSBuZXcg
ZmlsZSBpbiB1dGlsLyB0byBob2xkIHRoaXMgY29kZT8NCj4gDQo+IFllYWgsIG1heWJlIHV0aWwv
aW50ZWwtdHBlYnMuYyAoaWYgaXQncyBiZXR0ZXIgdGhhbiBhcmNoL3g4Ni8uLi4pID8NCj4gDQo+
ID4NCj4gPiBZZXMsIHRoaXMgZmVhdHVyZSBpcyBmb3IgdmVyeSByZWNlbnQgSW50ZWwgQ1BVcy4g
SXQgc2hvdWxkIG9ubHkgYmUgdHJpZ2dlcmVkIGlmDQo+ID4gYSBtZXRyaWMgdXNlcyBldmVudChz
KSB0aGF0IGhhcyB0aGUgUiBtb2RpZmllciBpbiB0aGUgZm9ybXVsYS4NCj4gDQo+IENhbiB3ZSBo
YXZlIGEgdGVzdCB3aXRoIGEgZmFrZSBtZXRyaWMgc28gdGhhdCB3ZSBjYW4gdGVzdA0KPiB0aGUg
Y29kZSBvbiBub24tKG9yIG9sZC0pSW50ZWwgbWFjaGluZXM/DQoNCkFsbCB0aGUgZXhpc3Rpbmcg
bWV0cmljcyBpbiBub24tKG9yIG9sZC0pSW50ZWwgQ1BVcyBzaG91bGQgd29yayBhcyB1c3VhbC4g
U28gSSB0aGluayANCmV4aXN0aW5nIG1ldHJpYyB0ZXN0cyBzaG91bGQgd29yayBmb3IgaXQuIA0K
DQpJZiB3ZSB3YW50IHRvIGFkZCBhIGZha2UgbWV0cmljIHVzZXMgdGhlIDpSIG1vZGlmaWVyIGZv
ciB0aG9zZSBwbGF0Zm9ybXMsIHRoZSBtZXRyaWMNCnNob3VsZCBlaXRoZXIgZmFpbCAoaWYgdGhl
IGZha2UgbWV0cmljIHVzZXMgYW4gZXZlbnQgbm90IGV4aXN0IG9uIHRoZSB0ZXN0IHBsYXRmb3Jt
KSBvciANCnJldHVybiBhbGwgMCByZXRpcmUgbGF0ZW5jeSBkYXRhLiANCg0KU28sIEknbSBub3Qg
cXVpdGUgc3VyZSB3aGF0IHdlIHdhbnQgdGhlIGZha2UgbWV0cmljIHRvIHRlc3QgZm9yLiBNYXli
ZSB3ZSBjb3VsZCANCmNvbnRpbnVlIHVzaW5nIGV4aXN0aW5nIG1ldHJpYyB0ZXN0cyB0byBlbnN1
cmUgYWxsIHRoZSBkZWZpbmVkIG1ldHJpY3Mgd29yayBjb3JyZWN0bHkgDQppbiBlYWNoIG1hY2hp
bmUgdW5kZXIgdGVzdD8NCg0KVGhhbmtzLA0KV2VpbGluDQoNCj4gDQo+IFRoYW5rcywNCj4gTmFt
aHl1bmcNCg==

