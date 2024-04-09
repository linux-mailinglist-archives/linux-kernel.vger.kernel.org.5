Return-Path: <linux-kernel+bounces-137624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202789E4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EE4283C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B615885E;
	Tue,  9 Apr 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lH9vjUUg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B45158879;
	Tue,  9 Apr 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695875; cv=fail; b=LfF83U15DvCu1nJzyovjANi8ySLso0VQdYdVM4gOgTdqofYoItMh+J6qNcvcfW8L7RjSJc+Owsq9tBCqTrpezdE3zE0xKESvrMrJHyojubgS+E0wZ/qikshgpiPzjABcqGdOPyrf/d0t3aZjF6gSng03OworZn9641NHM1K4fsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695875; c=relaxed/simple;
	bh=XxBPJPC6WRPQ+C64qWzYoTYud/4mE/jsVbURgCyh46k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QCAZsSBZM0k1iw7zd4xsdxG1Lc8nW9aPWYLtosOpJZispF5sqQI90+h3zmMlTDxTsDtpXD98g8MhMghm+smjHoURf000mxnn06vztC4DI0QxyTRwrvwngfKMQ/cGInXrCK87Sa0SVZlm9PbX/dr/lk8d67F05KIFlNkGKTivNfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lH9vjUUg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712695873; x=1744231873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XxBPJPC6WRPQ+C64qWzYoTYud/4mE/jsVbURgCyh46k=;
  b=lH9vjUUg0JI/5qi42kVJl9eRFyuxpYXYmfr81LgMlWtIRpOBedaTqRDH
   JzVkMz3+Qp8HlnS3PanI6E2Ieqzdwt/YQBCA5qxLuB9MpsANQGltkpK97
   Znk1PPoCRqXnj7UNQGZPTlStbhBm+CCBPjlIsMZZE7RS+FL9zfGjNfMmZ
   v40W4/ysmWSSp7+I+9N6WxcC7T+Lu9mmPmJ148YL5u8e5FIaig7+5g2d+
   A4jWrMZfzGJvzzwyLO5MNUCF7G4kSLI8q0tXgMjWCctC3F34TFol2ITQM
   yj9m//iKndBzDCth+Ee1XmmXv4jCQKl8woDHx1BahEablc9LmkDbJRgBF
   g==;
X-CSE-ConnectionGUID: BSizgwAYQ/WyIuaVzqeCOw==
X-CSE-MsgGUID: 8MKz/tDeRn+aW5mo6NKcZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25477036"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25477036"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 13:51:12 -0700
X-CSE-ConnectionGUID: 0mvfFhd3TrG4gYqkFQtb8Q==
X-CSE-MsgGUID: c/aRkqvIQ52xoG+tauIdFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20447640"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 13:51:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 13:51:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 13:51:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 13:51:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 13:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb0oVRtD357ZX8VovJ91PPmKPaz15XNx1YytgoXg247UJcVzWFuAEuVoHVFHj0RXIb3VNcQ7FyL2/uQCbVv/v7ifkNt6/zmU4v163Exx3byYmYdQpakfbUdjG9k9t6uE5spe3DdZtd8Wz1Jf7V001yWXypVTCRZTbvDBFfZ6Y2lb/ROY7T3bNPUyIvTc6yp+rcZA4Zf65J+kyoiXrTZP18wr7Hsegf5vVzie5KxgIvGW6lIZLu09/TxCRjlvOmf+hPZXkqnQaisUMgkogzK/fhDvlSFtyNTSspEWFImS/psVfG5S7bLfMhiEoGAjqUv+PfwlhQjsGXy8y3TRcjd/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxBPJPC6WRPQ+C64qWzYoTYud/4mE/jsVbURgCyh46k=;
 b=hyNd/gUV2PVA2KsMPEm59pQiVn/vAcuufxe2UXX3Z56V3mmWpkqEPvX2xko7Sw/ASAA8Q9wBq+9U46d+xk4Y8m9nwaxZvxil79Dd33qhq36Lx1nrFR0RB5VaUO7b81DamIKTphxGxUksRqjryucJNvZF68fMSUd7dsXbpWD53Ti0LfuxF2KSt7xoUfTUx9zv8JxGHcCmlzoQ4dzDLsb/Pbwyii/YLKCgcMAQAotqEN1N2VhyTeGkaIeygypaLu/YAhzWm+6SFF0CR2RdF1g7Fr/6uWlylxdyswF24qZ9UeAAWbk/WPE0+I5lT3rYmKpO9YjWZmr2aEYk1GoZAwZr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 20:51:02 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 20:51:02 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>, Mark Rutland <mark.rutland@arm.com>
Subject: RE: [RFC PATCH v4 14/15] perf stat: Add tool events support in
 hardware-grouping
Thread-Topic: [RFC PATCH v4 14/15] perf stat: Add tool events support in
 hardware-grouping
Thread-Index: AQHaWwYoyFDeI4FtZEinYUXGKy+ziLFGqfGAgBodThA=
Date: Tue, 9 Apr 2024 20:51:02 +0000
Message-ID: <CO6PR11MB56358253F9CE3C3772A665EEEE072@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240209031441.943012-1-weilin.wang@intel.com>
 <20240209031441.943012-15-weilin.wang@intel.com>
 <CAP-5=fU1R7QYKCWPrrZ_wA1RCfat+BqiA12=UG2a-GrBLPL0BA@mail.gmail.com>
In-Reply-To: <CAP-5=fU1R7QYKCWPrrZ_wA1RCfat+BqiA12=UG2a-GrBLPL0BA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|MW6PR11MB8392:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AAID5C2Vh1vfKajbm6Qa3kHm64hX5v2RX1wzwO/qSDmCp9B/edhIGrozH4uJRCzAwzDWz7+d/uUZ/TyJrxMHCktjKe0TPhQOA7M9bhrEXuI268qQ/7su6hsiwgFBifqpyy3Pp4bRebftx8POiu0HeKXthcVcUPXRs2WnO3JYFx+BhN2I4/dBmJd4p0IBQvBWBZirB+4j33FV+9M2HcbYmsa5M62SZSASlYiRQ7vlCxlOGX7T2JdiYljsTm19mMJsOxBamjUXrMKapa+2/5qS5Vm3wVPGaXUkhIGdmc673uYV7ZH+9DXDkHZt9+BTUpJ/TbhXDdfzODdfEJ4Gr4K56wJvear7Q8o3bboJuCmioN/K7rX2/txqDFYb30mAQPcjd/oqFrRP584Uut0PSKUvntwPfD4RQtBeh4V/R8MhKUQ9hzcpX9QUSbxTLdHx/A8yPt0IHgPsh5z1hbv9BTRkCVGFdrS5xR1UTk3aDkhiD/L0Qh5kCsR8QoerRkQA2abk30mHeJKKedIWl0tK/wzWRdZBMmYkcGVytHBanM1+IMzfxx8ry86t8yBjb8GczryzBxozGT9sh6cvrFrBUNhz1lqI6HEqIx+cukwIa1nLiB2EP/PU7ARCiMKxu9xaF/Z0lp0bKhFcKVOknM886KqTsFl6CBiEyyAi00OVOzXhG8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFVHNjRreXc2azhZWkhneFZ6RFdyTWhDanJ5S3pjZGw0TUFNVnpXdmJkS1Vt?=
 =?utf-8?B?Q0VwREZEd1FVc1M0NGE2b25wd2F6UHFNa2t6dVhTT1J6bkErdkRXaXc0eHhX?=
 =?utf-8?B?T0pyZ0E3ckZxcC9RWFRaTUROWUFHb1ZTM056aVVNOCtKS21kbENqL3dFcWZ2?=
 =?utf-8?B?K2MxWC9VQmllYzM5UzlaWjJKcEJ6TmJUZUJtaDJiendxWWVzeCtqcGlkWTVO?=
 =?utf-8?B?RUJRMjJlK1VVZHhaTXJQSkc5Q0w2RXlITTlSRDNZc3dzSmNibU1tTi9iNXhj?=
 =?utf-8?B?QmhVVVpvSk1lTmRLRnBtUVFDMCtNU0xvaU5vTkgyQS9zcHhOb1BmWmM2TFpC?=
 =?utf-8?B?cWNaaDdsVVVGNGhpSjRUTlBiT2tkNmlhNVJjRUdPclFCQVVzT240S3QvQjhS?=
 =?utf-8?B?aXc5ZlpnU01nZXhuYm5meURJTEZCV1JQK0hTK3oyaEJKdkcyblNlNzkxZk5Q?=
 =?utf-8?B?dG4xc05raTdaK2lWVnh1amdWdXVEbENva21vU04ydGZzTFlzbERWcEJYeno4?=
 =?utf-8?B?aWRHUG9OTlFEZGExTWFZeXZZK0o3QlJpeU5MQUg2VDVGd0ttcDFYMElHWmpN?=
 =?utf-8?B?dU8ydHNneEQxa0NnYy8rNEdENkRzR3RtdFZLeFZJNzRic2cvRHZ0cXhONTZC?=
 =?utf-8?B?N1EvNG9RSDhkS0J1MHJ3cDZYYlQ2djcrNVZXdmRhcER4L3FYLzVENTdPQmM5?=
 =?utf-8?B?Ujk2Wk5NMHNZWnhWMzYycVJuQ0Jzc1Vxb1dNSVo1b0FDYmlCZ0wzSCtDNHR4?=
 =?utf-8?B?U1hBZ1dsK3cyVDFja3ZjdU5vc3g4aVgzcDhZT2hQM0xLa3pYcU40RVFFUkkx?=
 =?utf-8?B?YXlFUUJmUWJGY3RhQ1lydnZjbVltdElBYWRHem5EMWhmcGxTVW42a0kvc285?=
 =?utf-8?B?bVpwajN3TDhMeFNJR2taTHhaNkQ4aHhxTU5VSkxoVkIwOG90dDdFenFhQWNH?=
 =?utf-8?B?UTAvZXdiaEVidTBCVzkxdSszSWNjNHJPKzJBMWFaSU9sZEZYOUlrK1gzK0Zn?=
 =?utf-8?B?aVJkVkFWOE9GNlNXWC9iWStueXMzNTUxa0JZaTdsMk5TWjYxZFNDUi8rWVZ0?=
 =?utf-8?B?d3FCMGJCM1UzbzExZWZBL0hiVmM5Yk1DSzNRNXZkSTdWYkZkWDduTFdkSTBw?=
 =?utf-8?B?TVVaU2hpNDJnM1pvbTV4OVc2bFJ6QmJLUE10RXZDYS9xQ3E2T3hxVkZxc1ps?=
 =?utf-8?B?SlRFM2hqZzFUejR1cTB1VTlQZzh5SVVERjFYTEJUWHRlQXY4bDJSTlo4S1hO?=
 =?utf-8?B?UjdXTzh6MDBSK0tscjZZU0UrTVFodUFzL3YyYUcyNjVqRUJiR2hwODRuRVA1?=
 =?utf-8?B?aWJYaWxiZW5FY1BhY2NJdVRESXBMOXpzanJBVVJzK3BKSlU0VHNiUEtsV0Va?=
 =?utf-8?B?MFMvSFlGTDZpdndVanVuMVZ3Vk4xdWI5anZhYjVoRGFSUTdoV0JNNTJzV1ll?=
 =?utf-8?B?V1cxeFJ2RHBIZGFhWUJ4SG15ckxHaU9ucUdOZG9QUFVYa1NlYUNwTis0U05D?=
 =?utf-8?B?aTUxYlB1Z1pQSHRRSWlJTUMxWG1RVjJTVnE5UTB5Mk5wdVJDS0UzVXEwSFRn?=
 =?utf-8?B?YnNHdERuVXlDMGNZM2NYNnE5aURrQzd3dVpLZnRMS3NQU0ovdmkzZmhkY2px?=
 =?utf-8?B?ZFBqTlpITTBhaU1jT0hUVXZsNS9WeXM0bzNlcmJFMFZET01wU3Y3K0NOem50?=
 =?utf-8?B?bjMybGdiWlpwSHAxZHR1cmszR3hBazNtL0JYVS9nd3dRazJZazN5WVE4cytX?=
 =?utf-8?B?ajhSQmxtZUxPQjI4cGN1bWcrQTZ3ZStwQkxwRDFkZ1NBaDBiK0hpNEdMM3B1?=
 =?utf-8?B?WHg0RUJVdGhRdXlBREN4bllMcWtudU0yUENCbkRtamd1UmlBbjFsUzlZQkZN?=
 =?utf-8?B?WFFIRExtbHFqMHBtUzBDWWliOUNFN3NUcElsSU1YOXVhTk9ucGpFaEQxbFVD?=
 =?utf-8?B?MGpMTEVQZTkzS1kwZitFY2YwdWFtbEIvbXVlUkVvSHZ5TTBlRWNjZ3FSTjlT?=
 =?utf-8?B?WWovaUV1dFVuYktqMmI2YXNZOFc0UXRmRUZuWmE5QVRZQ1ZqV0IyM2ZHUjlH?=
 =?utf-8?B?M0c3K2tFbEdMYldEWDRlQWNZNTJqSzdvZXNkMUFtd1IzR0dTZVlvWnd1V01V?=
 =?utf-8?Q?UYyqbOWwqVP4NiXi0XYrEmYKh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29598aa7-d5e2-469d-3727-08dc58d6c4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 20:51:02.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6ay4XwgppL8Msw3oTxXNwWDh73InT5FPR/l7NqCB0RhM2ssjuBLBJs8Wa5anoLljs4PXhcz7gg4PpTGzSwROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMjMsIDIwMjQgMTA6NTYg
UE0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzogS2Fu
IExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgTmFtaHl1bmcgS2ltDQo+IDxuYW1o
eXVuZ0BrZXJuZWwub3JnPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQGtlcm5lbC5v
cmc+Ow0KPiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5h
ciA8bWluZ29AcmVkaGF0LmNvbT47DQo+IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxleGFuZGVyLnNo
aXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYQ0KPiA8am9sc2FAa2VybmVsLm9yZz47
IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IGxpbnV4LXBlcmYtDQo+
IHVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5
bG9yLCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNh
bWFudGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0Bp
bnRlbC5jb20+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCB2NCAxNC8xNV0gcGVyZiBzdGF0OiBBZGQgdG9vbCBldmVudHMgc3Vw
cG9ydCBpbg0KPiBoYXJkd2FyZS1ncm91cGluZw0KPiANCj4gT24gVGh1LCBGZWIgOCwgMjAyNCBh
dCA3OjE04oCvUE0gPHdlaWxpbi53YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRkIHRvb2wg
ZXZlbnRzIGludG8gZGVmYXVsdF9jb3JlIGdyb3VwaW5nIHN0cmluZ3MgaWYgZmluZCB0b29sIGV2
ZW50cyBzbw0KPiA+IHRoYXQgbWV0cmljcyB1c2UgdG9vbCBldmVudHMgY291bGQgYmUgY29ycmVj
dGx5IGNhbGN1bGF0ZWQuIE5lZWQgdGhpcyBzdGVwDQo+ID4gdG8gc3VwcG9ydCBUb3Bkb3duTDQt
TDUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYyB8IDQ5
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3VwLmMgYi90b29scy9wZXJmL3V0aWwvbWV0cmlj
Z3JvdXAuYw0KPiA+IGluZGV4IGNmZGJiNWY3ZmI3Ny4uZTViODQ1NmQwNDA1IDEwMDY0NA0KPiA+
IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5jDQo+ID4gKysrIGIvdG9vbHMvcGVy
Zi91dGlsL21ldHJpY2dyb3VwLmMNCj4gPiBAQCAtMTQ4Niw2ICsxNDg2LDM1IEBAIHN0YXRpYyB2
b2lkIGZpbmRfdG9vbF9ldmVudHMoY29uc3Qgc3RydWN0DQo+IGxpc3RfaGVhZCAqbWV0cmljX2xp
c3QsDQo+ID4gICAgICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICsvKioNCj4gPiArICogZ2V0X3Rv
b2xfZXZlbnRfc3RyIC0gR2VuZXJhdGUgYW5kIHJldHVybiBhIHN0cmluZyB3aXRoIGFsbCB0aGUg
dXNlZCB0b29sDQo+ID4gKyAqIGV2ZW50IG5hbWVzLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGlu
dCBnZXRfdG9vbF9ldmVudF9zdHIoc3RydWN0IHN0cmJ1ZiAqZXZlbnRzLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGJvb2wgdG9vbF9ldmVudHNbUEVSRl9UT09MX01B
WF0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCAqaGFzX3Rvb2xfZXZl
bnQpDQo+ID4gK3sNCj4gPiArICAgICAgIGludCBpID0gMDsNCj4gPiArICAgICAgIGludCByZXQ7
DQo+ID4gKw0KPiA+ICsgICAgICAgcGVyZl90b29sX2V2ZW50X19mb3JfZWFjaF9ldmVudChpKSB7
DQo+ID4gKyAgICAgICAgICAgICAgIGlmICh0b29sX2V2ZW50c1tpXSkgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnRtcCA9IHN0cmR1cChwZXJmX3Rvb2xfZXZlbnRf
X3RvX3N0cihpKSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghdG1w
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgKmhhc190b29sX2V2ZW50ID0gdHJ1ZTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBzdHJidWZfYWRkc3RyKGV2ZW50cywgIiwiKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICByZXQgPSBzdHJidWZfYWRkc3RyKGV2ZW50cywgdG1wKTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAg
ICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qKg0KPiA+ICAgKiBidWlsZF9jb21i
aW5lZF9leHByX2N0eCAtIE1ha2UgYW4gZXhwcl9wYXJzZV9jdHggd2l0aA0KPiBhbGwgIWdyb3Vw
X2V2ZW50cw0KPiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1ldHJpYyBJRHMsIGFz
IHRoZSBJRHMgYXJlIGhlbGQgaW4gYSBzZXQsDQo+ID4gQEAgLTIwNDksNiArMjA3OCw3IEBAIHN0
YXRpYyBpbnQgYXNzaWduX2V2ZW50X2dyb3VwaW5nKHN0cnVjdA0KPiBtZXRyaWNncm91cF9fZXZl
bnRfaW5mbyAqZSwNCj4gPg0KPiA+ICBzdGF0aWMgaW50IGh3X2F3YXJlX21ldHJpY2dyb3VwX19i
dWlsZF9ldmVudF9zdHJpbmcoc3RydWN0IGxpc3RfaGVhZA0KPiAqZ3JvdXBfc3RycywNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbW9k
aWZpZXIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IGJvb2wgdG9vbF9ldmVudHNbUEVSRl9UT09MX01BWF0sDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmdyb3VwcykNCj4g
PiAgew0KPiA+ICAgICAgICAgc3RydWN0IG1ldHJpY2dyb3VwX19wbXVfZ3JvdXBfbGlzdCAqcDsN
Cj4gPiBAQCAtMjA1Niw4ICsyMDg2LDEyIEBAIHN0YXRpYyBpbnQNCj4gaHdfYXdhcmVfbWV0cmlj
Z3JvdXBfX2J1aWxkX2V2ZW50X3N0cmluZyhzdHJ1Y3QgbGlzdF9oZWFkICpncm91cF9zdHJzDQo+
ID4gICAgICAgICBzdHJ1Y3QgbWV0cmljZ3JvdXBfX2dyb3VwX2V2ZW50cyAqZ2U7DQo+ID4gICAg
ICAgICBib29sIG5vX2dyb3VwID0gdHJ1ZTsNCj4gPiAgICAgICAgIGludCByZXQgPSAwOw0KPiA+
ICsgICAgICAgc3RydWN0IHN0cmJ1ZiB0b29sX2V2ZW50X3N0ciA9IFNUUkJVRl9JTklUOw0KPiA+
ICsgICAgICAgYm9vbCBoYXNfdG9vbF9ldmVudCA9IGZhbHNlOw0KPiA+DQo+ID4gICNkZWZpbmUg
UkVUVVJOX0lGX05PTl9aRVJPKHgpIGRvIHsgaWYgKHgpIHJldHVybiB4OyB9IHdoaWxlICgwKQ0K
PiA+ICsgICAgICAgcmV0ID0gZ2V0X3Rvb2xfZXZlbnRfc3RyKCZ0b29sX2V2ZW50X3N0ciwgdG9v
bF9ldmVudHMsDQo+ICZoYXNfdG9vbF9ldmVudCk7DQo+IA0KPiBEb2VzIG1ldHJpY2dyb3VwX19i
dWlsZF9ldmVudF9zdHJpbmcgbmVlZCB1cGRhdGluZyB0byB1c2UgdGhpcyBoZWxwZXINCj4gZnVu
Y3Rpb24gdG9vPw0KDQpIaSBJYW4sDQoNCkluIHBhcnNlX2lkcywgdG9vbCBldmVudHMgYXJlIGlu
c2VydGVkIHRvIHRoZSBpZHMgdGhhdCBwYXNzZWQgdG8gDQptZXRyaWNncm91cF9fYnVpbGRfZXZl
bnRfc3RyaW5nLiBJZiB3ZSB3YW50IHRvIHVzZSB0aGlzIGZ1bmN0aW9uIGhlcmUsIEkgdGhpbmsN
CndlIGFsc28gbmVlZCB0byB1cGRhdGUgdGhlIGNvZGUgaW4gcGFyc2VfaWRzIHRvIG5vdCBpbnNl
cnQgdG9vbCBldmVudHMuIA0KDQpJIGNvdWxkIGFkZCB0aGlzIGNoYW5nZSBpZiB5b3UgdGhpbmsg
d2Ugc2hvdWxkIGRvIHRoaXMgdXBkYXRlLg0KDQpUaGFua3MsDQpXZWlsaW4NCg0KPiANCj4gVGhh
bmtzLA0KPiBJYW4NCj4gDQo+ID4gKyAgICAgICBSRVRVUk5fSUZfTk9OX1pFUk8ocmV0KTsNCj4g
Pg0KPiA+ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShwLCBncm91cHMsIG5kKSB7DQo+ID4g
ICAgICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkoZywgJnAtPmdyb3VwX2hlYWQsIG5k
KSB7DQo+ID4gQEAgLTIxMjksNiArMjE2MywxMiBAQCBzdGF0aWMgaW50DQo+IGh3X2F3YXJlX21l
dHJpY2dyb3VwX19idWlsZF9ldmVudF9zdHJpbmcoc3RydWN0IGxpc3RfaGVhZCAqZ3JvdXBfc3Ry
cw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSBzdHJidWZfYWRkZihldmVudHMsICJ9OlciKTsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBSRVRVUk5fSUZfTk9OX1pFUk8ocmV0KTsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKCFzdHJjbXAocC0+cG11X25hbWUsICJkZWZhdWx0X2NvcmUiKSAm
JiBoYXNfdG9vbF9ldmVudCkNCj4gew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0ID0gc3RyYnVmX2FkZHN0cihldmVudHMsIHRvb2xfZXZlbnRfc3RyLmJ1Zik7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSRVRVUk5fSUZfTk9OX1pFUk8ocmV0KTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHByX2RlYnVnKCJldmVudHMtYnVmOiAlc1xuIiwgZXZlbnRzLT5idWYpOw0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGxpc3RfYWRkX3RhaWwoJm5ld19ncm91cF9zdHItPm5k
LCBncm91cF9zdHJzKTsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+IEBAIC0yMjE0LDYgKzIy
NTQsNyBAQCBzdGF0aWMgaW50IGh3X2F3YXJlX2J1aWxkX2dyb3VwaW5nKHN0cnVjdA0KPiBleHBy
X3BhcnNlX2N0eCAqY3R4LA0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX291dDsNCj4gPiAgICAgICAgIH0NCj4gPiArDQo+
ID4gICAgICAgICByZXQgPSBnZXRfcG11X2NvdW50ZXJfbGF5b3V0cygmcG11X2luZm9fbGlzdCwg
bHRhYmxlKTsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX291dDsNCj4gPiBAQCAtMjI1OSw2ICsyMzAwLDcgQEAgc3RhdGljIHZvaWQNCj4gbWV0cmlj
Z3JvdXBfX2ZyZWVfZ3JvdXBpbmdfc3RycyhzdHJ1Y3QgbGlzdF9oZWFkDQo+ID4gICAqLw0KPiA+
ICBzdGF0aWMgaW50IGh3X2F3YXJlX3BhcnNlX2lkcyhzdHJ1Y3QgcGVyZl9wbXUgKmZha2VfcG11
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGV4cHJfcGFyc2VfY3R4
ICppZHMsIGNvbnN0IGNoYXIgKm1vZGlmaWVyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3QgYm9vbCB0b29sX2V2ZW50c1tQRVJGX1RPT0xfTUFYXSwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBldmxpc3QgKipvdXRfZXZsaXN0KQ0KPiA+ICB7
DQo+ID4gICAgICAgICBzdHJ1Y3QgcGFyc2VfZXZlbnRzX2Vycm9yIHBhcnNlX2Vycm9yOw0KPiA+
IEBAIC0yMjcyLDcgKzIzMTQsOCBAQCBzdGF0aWMgaW50IGh3X2F3YXJlX3BhcnNlX2lkcyhzdHJ1
Y3QgcGVyZl9wbXUNCj4gKmZha2VfcG11LA0KPiA+ICAgICAgICAgcmV0ID0gaHdfYXdhcmVfYnVp
bGRfZ3JvdXBpbmcoaWRzLCAmZ3JvdXBpbmcpOw0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAg
ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gLSAgICAgICByZXQgPSBod19hd2FyZV9tZXRy
aWNncm91cF9fYnVpbGRfZXZlbnRfc3RyaW5nKCZncm91cGluZ19zdHIsDQo+IG1vZGlmaWVyLCAm
Z3JvdXBpbmcpOw0KPiA+ICsgICAgICAgcmV0ID0gaHdfYXdhcmVfbWV0cmljZ3JvdXBfX2J1aWxk
X2V2ZW50X3N0cmluZygmZ3JvdXBpbmdfc3RyLA0KPiBtb2RpZmllciwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0b29sX2V2ZW50cywg
Jmdyb3VwaW5nKTsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAgICAgICAgIGdv
dG8gb3V0Ow0KPiA+DQo+ID4gQEAgLTI0MDcsNiArMjQ1MCw3IEBAIHN0YXRpYyBpbnQgaHdfYXdh
cmVfcGFyc2VfZ3JvdXBzKHN0cnVjdCBldmxpc3QNCj4gKnBlcmZfZXZsaXN0LA0KPiA+ICAgICAg
ICAgc3RydWN0IGV2bGlzdCAqY29tYmluZWRfZXZsaXN0ID0gTlVMTDsNCj4gPiAgICAgICAgIExJ
U1RfSEVBRChtZXRyaWNfbGlzdCk7DQo+ID4gICAgICAgICBzdHJ1Y3QgbWV0cmljICptOw0KPiA+
ICsgICAgICAgYm9vbCB0b29sX2V2ZW50c1tQRVJGX1RPT0xfTUFYXSA9IHtmYWxzZX07DQo+ID4g
ICAgICAgICBpbnQgcmV0Ow0KPiA+ICAgICAgICAgYm9vbCBtZXRyaWNfbm9fZ3JvdXAgPSBmYWxz
ZTsNCj4gPiAgICAgICAgIGJvb2wgbWV0cmljX25vX21lcmdlID0gZmFsc2U7DQo+ID4gQEAgLTI0
MjUsMTEgKzI0NjksMTQgQEAgc3RhdGljIGludCBod19hd2FyZV9wYXJzZV9ncm91cHMoc3RydWN0
IGV2bGlzdA0KPiAqcGVyZl9ldmxpc3QsDQo+ID4gICAgICAgICBpZiAoIW1ldHJpY19ub19tZXJn
ZSkgew0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZXhwcl9wYXJzZV9jdHggKmNvbWJpbmVk
ID0gTlVMTDsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICBmaW5kX3Rvb2xfZXZlbnRzKCZtZXRy
aWNfbGlzdCwgdG9vbF9ldmVudHMpOw0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0g
aHdfYXdhcmVfYnVpbGRfY29tYmluZWRfZXhwcl9jdHgoJm1ldHJpY19saXN0LA0KPiAmY29tYmlu
ZWQpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIGlmICghcmV0ICYmIGNvbWJpbmVkICYmIGhh
c2htYXBfX3NpemUoY29tYmluZWQtPmlkcykpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXQgPSBod19hd2FyZV9wYXJzZV9pZHMoZmFrZV9wbXUsIGNvbWJpbmVkLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qbW9kaWZpZXI9Ki9O
VUxMLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHRvb2xfZXZlbnRzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZjb21iaW5lZF9ldmxpc3QpOw0KPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4N
Cj4gPiAtLQ0KPiA+IDIuNDIuMA0KPiA+DQo=

