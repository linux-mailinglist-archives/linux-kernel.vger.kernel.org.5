Return-Path: <linux-kernel+bounces-153431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6D8ACE0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7571C21248
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267514F9C9;
	Mon, 22 Apr 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJmiIZ+5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9114A0A5;
	Mon, 22 Apr 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791993; cv=fail; b=Mp7ocs7PxnXKBBfNgSNw0ww/O8z9l8iB52sSQpraZKwlpG4i3jObqjBnAEUjFo99w93+IN8WhSLU7GFmgVGSdhLGBktwGi8IiHWmhku6VKU/HhdSl6DZ1BgKWLBsRlKj7IBsRsFo1cyYGbGXtnbZBUtuNxBC+2QezFI29sNeJTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791993; c=relaxed/simple;
	bh=+o4294sHqJhVo2zBS1KmmCrCxCKp0rF6c/Z3Nhb8oLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tGs9QFb/o1iSsYdYyEL57xsvG3UtqoUtbG5tYkL61uTDQ4dwY9k/oxsYrTVCtxx5NoqMUmunXBS2u9RqmscTp1EO6/8aun2V83Jt8wGFmAP2/UR01jp32VMf16pJWupYThrj+BOp7aLNBmegbc47QCaoaz5J0R8hOvRAe89ZWvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJmiIZ+5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713791991; x=1745327991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+o4294sHqJhVo2zBS1KmmCrCxCKp0rF6c/Z3Nhb8oLM=;
  b=HJmiIZ+5WYumHMt2LQ6tnEI3jcJ94TYQWbVmworTTwcQfiv3PaXepQBt
   PhJik6zhT2ncG1ILFNu13ge2pi7sSc4Uf5HO8Xzp01nnMrap4wxRkVEEy
   P8hFhM4lVqI0C6xSbv2Lxgut7nEEfbN5dfwX7HpB1WUJrgVay3wcCFKtL
   Jk7L/Yhc/4/thUDKqJwsjJwlw1TqREWZFHnFMCXEjwdPBujB+L27QIdL9
   DgekkPA227WVZ7wbYY7rl+1C7adK2mi4QKDJ9yLrz8Np1BFKMcPb/TuQZ
   rAVRxnY6ZJ4VZbDAxigYvkJNeFB5PAoNMKomZzonXDcVzclDP23bqv71T
   Q==;
X-CSE-ConnectionGUID: Zd/JwnMXROStQ3Y0JwQ8Gg==
X-CSE-MsgGUID: M5YT9awHQzWLv3/2TFK+0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13164063"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13164063"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 06:19:50 -0700
X-CSE-ConnectionGUID: Whu2iqGWQxS8i809ubR9CA==
X-CSE-MsgGUID: zzwAZyLsQPiNQjPaZUnaLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28675410"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 06:19:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 06:19:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 06:19:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 06:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiYPGtnf8uB/aZXLoNBXkHK4HAx5RsS6/wMqS7YQs4gLN9rVoMQJm9snu0zoRRVN7VfkQfGwQ8SRUPdqU/ZpeEogd3bdRVRtY3NA/mkIlMwOHtgOhow679gBTyyZozoxoOWRfAuQWxYFJUrosk2KFdO6YzqnCOWnUDruApez3HL/hhV9vupifxpNjzfQ4f8bbBYO2uPi3d6goz5MYrS9ulR2sdjSOXjy11DllxxX46n/71fAdTofPmAa8GDjCwrmHLex35p+IR4vWp4FncmyQsHEwPbwW3YUdnxwcbk9lRi24xjWoHXScfLlWCKBLXSAwFcJvQoaeXxhneZaOmJ9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o4294sHqJhVo2zBS1KmmCrCxCKp0rF6c/Z3Nhb8oLM=;
 b=lma8dgrLF3WVNq1DgUpyrZlomkgF8uTgo63/VlwXxPFSErupahaFkkjPcGhuwEWBBwuEDeL8BAY42Z7vHHTzkjm0vcRKxqwUVvIjZr9Vs6KPsOXSWBC1oGVUFNjT4WdN7xgXmuAO+/9nmt8WsGMhPc4mBU3aDY1IhK5kjMsFB0PzFUBSZfuS166nrcyqp/L5oapOMWxwverHFmRvMnzWCBiAYOnlRGxFEkJpEp8lAYHot4ybUgaZmkvg9Uc2iN21+1LU6tZuWX6ylckERz69yp7pSoPY/oV0A3uxLCfsansn60Mvw0kVGSqFenhBbB71wpYv66KWVsbMtkrfbpStkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 13:19:45 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 13:19:45 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Erwan Velu <erwanaliasr1@gmail.com>
CC: "Velu, Erwan" <e.velu@criteo.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v4 iwl-net] i40e: Prevent setting MTU if
 greater than MFS
Thread-Topic: [Intel-wired-lan] [PATCH v4 iwl-net] i40e: Prevent setting MTU
 if greater than MFS
Thread-Index: AQHadSYFc04RgPtII0iMq+CRVHx6vLFv3SlggAAHdYCABJ9WQA==
Date: Mon, 22 Apr 2024 13:19:45 +0000
Message-ID: <CYYPR11MB8429BF7A90F0A57D5154F9FEBD122@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240313090719.33627-2-e.velu@criteo.com>
 <CYYPR11MB84296C9EE9AFC32766E65630BD0D2@CYYPR11MB8429.namprd11.prod.outlook.com>
 <CAL2JzuxraP5xCxt4_EK3zbz9kyAyxJFuEadtq4zHsdMjR5PGTw@mail.gmail.com>
In-Reply-To: <CAL2JzuxraP5xCxt4_EK3zbz9kyAyxJFuEadtq4zHsdMjR5PGTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB6332:EE_
x-ms-office365-filtering-correlation-id: 55055ac1-c6a2-4740-1c3a-08dc62cee0f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WjR2RDdiVFVsbkVWMXFDY3dCNzNYc1Y2RER4WlpaUXNmeWRWQ2F0WmdmWWFi?=
 =?utf-8?B?ajkySjNXTGYxdFZNQnI4ZlplSDUycm5VZ3ZuQXFTbUFpT3h1U0t1QUJOQ0Zu?=
 =?utf-8?B?MWJ2NWVGVjNOblhldDN2Y2k5aStObUhLbEFZS044SGIxeGdDY2VlUTMyamRI?=
 =?utf-8?B?SjdRcm1yNFBxOXY2YW4rVWZwM2JSWW10WExFNTF0ZHZwU0x0MXpoU3ozbXJH?=
 =?utf-8?B?MlFFdjNLQnZrZE1oRm1jOVRGbi91ZjQrTkZYcFljN0l1U3RzbWNaTDBEK3d0?=
 =?utf-8?B?aFhCUmI2K0oweGFUK3FXR1Q1MUxXVTNqQlcyZzI4elhEcFFhc0laUDRxS1pm?=
 =?utf-8?B?T3JTSEFtcllWRkhybGdNeS9EcGlyZkFMdDNKNDdLYXZPR1dROS9WemxJRGF4?=
 =?utf-8?B?TkJMbDhFRWFuRDhkeitYVjB4UXk5a1B2aFBvc0NXckdmaE1YZXZOQmdhNXVt?=
 =?utf-8?B?UmFQMzJZUnViNHkrdXBqRkpzVmVpTkxnTlVpSDVoajZMYVZ4QjBNanQyTlNl?=
 =?utf-8?B?R05jRUNjZllRVUdPODcxditpamV2eHRiNEFXWWNjVi8yV2VaSjRjVmZWczQw?=
 =?utf-8?B?TVNHQTJrNWc4SkJDekl4d2V6MjlqWFJCRGpWcENZOTl3VlduTEl0V2hiRDI3?=
 =?utf-8?B?Vkl3c0NkellFNVlYbU5tOW5FV2VIYVdzazRBaE5tMDVJU3IyYTVxNW5HbGVU?=
 =?utf-8?B?cUhzQTRBS3VveXp0MXV2RFlNbmtwVy9mTWUwZS9tQTR0WEZpamptSHIrWHZl?=
 =?utf-8?B?WkcrT0plbTBhT3dkNTZqd3VVRjgwYWNEb0VDTWlsdlBJRTk3K2VCKzM4UlUr?=
 =?utf-8?B?RWxGVGtYeFNxZFVmYVQrdzIxbFQvMkxaYXBwRTV1NElsL0tpazV1MlJKakN6?=
 =?utf-8?B?OThCK1VJb1lRVWw3VnpHU29OdFBHdjcrSDI5VFBXZEZkNEdsb1ArTjVzVEhW?=
 =?utf-8?B?RmNOb0RwRTNaNDNIdTlHQlZManpNeE1DRGVOUDRoYWI4aXhnd04wUGt2WEIy?=
 =?utf-8?B?SVJTVW5Ob3VPNUJ4TmNKS2VOVmNoSnBiL3dWRmVrQUlnZWtLUllNRWtRWFhO?=
 =?utf-8?B?NzZXMng2Zk5XcWNDUlhpZlpsa2FuQWlDbmpBNUV3YmhRQVlpRnJ6UCtBZHBx?=
 =?utf-8?B?R3NUZzFuMW01VEJSWFVuV2J2elNOQnpjUDhsVzI5S25TN0R6amlDQ25ZV2Jx?=
 =?utf-8?B?UWVYanV0T1QxWHdxckdMeEh0NDU1QmRYcEpzUjdIV28zNHNjakxTRzgyM0Vp?=
 =?utf-8?B?djljSUdtZTJrUk1EMVJzVEhRc216MmF2ZnVxMm5JRDZuZXVzZUlsWFhydkZ5?=
 =?utf-8?B?c3AzNTVkWW12YjNMQ1hVeTdxdjg4a3dsY1E2RUR4aWYxMzFnTlNTem41Z3Fw?=
 =?utf-8?B?bXg5MFlSb3VXRnZzS2twWHZ3cUdNZEwybjdlV0R2ejZPSms3N0dHV3pZTEk0?=
 =?utf-8?B?cFN1YmdrZitpUmxWdDdFSHVxVFY2dkR3SHduNkxCZlFQdy9GNVMzbVlPeXE1?=
 =?utf-8?B?c2ZXK3hJa0dENjMvck1seFNpdGZuU3gwVmxkYjJIbXNJV210LzBVN1lrUEVS?=
 =?utf-8?B?VUFKM3E2Y0lpSnd4b2VDS1VpcFVRNDZFMVQveXUwM09yaEhWbjhkdzM2ejdq?=
 =?utf-8?B?QUUwbHpkbVFPZkhUWXFjYnZHd2dURXhYNnE1b3IvYkJvYXdLM1dxUVZrVGFs?=
 =?utf-8?B?NWowVkd4bGhRMmxXTlNwbzVNWTRoUXRLZGhjR1ZXYnN6NHg1WFNXaVdIN3NW?=
 =?utf-8?B?cDRMQzZSMS9DbDNIWXRlVTI0OXFlS1U4N0JZWUlpRWpiWERoZlhyN1NKMkZx?=
 =?utf-8?B?UUdneU9qVG85QTdRUjlCZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVoyZ29yVG1Nb1hXL1VvSUYweVZBU0c4ZFRFLzV4NzR6aGJuVlk4QkNwcmty?=
 =?utf-8?B?bjk2NjBJSjVFbVM2NjBUNTU1ZEQ1alN0TVpjeWRVZzZFdmVBalZvdWZsVTA3?=
 =?utf-8?B?SE1kRnlzTkQvVjFMdklDbE5vVzA4QkNzOUU3eEx3aWVxbzlpWVczYlNCSEdI?=
 =?utf-8?B?a3JsZWgvamhFVHkrWXliNWdidFZDVkhSVDUyWkpoUGhQd2NuZC9mSjFyR2kz?=
 =?utf-8?B?NC9LTnc3SVNUNExWUzFGUnNQc3dmeUtOVXU1VUNTZFBZdzNyamxpRDlrcXZO?=
 =?utf-8?B?dTdqNHhmSnd2bXFzR3A4MCtzay9wek9HdHhPREZjZWgvN1NTdEord2twRzNp?=
 =?utf-8?B?YTBXL3ZiV1dtaHB5ODhHV1dYR1kzU0xRWmF6Y05VSEpjQWd3NldEajlUNi95?=
 =?utf-8?B?T1BUWXkyRHRuZVlXTE1RQXAwRXZlNmFObnVkQTdGdVNyOEJ1WE9EQndkQWo5?=
 =?utf-8?B?aVFMbTlXNms5YTJxcTRGQ3ByV1FaeWtST09oZ0FQUkIvSmxzcW5ZckZsMm4v?=
 =?utf-8?B?dlRqQWhJaDEwdzFIT0RyWlN3S2ROTTMxVXRMMUFuVHJBV2FJSDl3d3ErQmRS?=
 =?utf-8?B?RjlHSFVOMjQ4UHFuMDR0eXdUbXdVVW5yeVZGc3NTRXNwUDFCOUhHRE50c3k4?=
 =?utf-8?B?SkF5OEZWTGZFQ0ZXOHBOaGI1Q2J2NWZjS1B3SHRNYzA5emM5Umd1Z1drWkN3?=
 =?utf-8?B?dlhTbytRdGc4NkVJREtGNXdLOG9zc01CYkFvcy8vTzVXWEhhR1dxekkxUnhr?=
 =?utf-8?B?eXR2Z3ljMnpSUTQ1RmlDMFRxaG5UM1VBTDdTTFdIb0dxZHdQMHhGQzBISUp3?=
 =?utf-8?B?OEVjaFc1cGpCSHpZL3Z4bnlJbWpKcTQ2RkJQVUg0TSs0b3NwazYycUFuT1Zs?=
 =?utf-8?B?dlVlUU1yeFJmNTBRc1dyUUt3M3pnUVAyMlBtQUtxcVd3T0FnNUM3QnVRMUUv?=
 =?utf-8?B?YTBKRVlUbW5uSzU0TzZ0QTBwMElQWDNhZFFjenZON1hoOE85L2RvSkxSTUZo?=
 =?utf-8?B?UVZ1OXVENmJidHVUTHc2dWRpdnlKTDUxYStXVU1jcVdlZjN0NlM3cEVwZXFh?=
 =?utf-8?B?Y0YzMXEvdDdraEZERGZvSHBJMkdxdmE5RkljeWlYRmg0S3BOZHhRdytFd1JT?=
 =?utf-8?B?QU9DcEdKNnZVck1OOXY3V2pJdjU0U0NQcm95M0grTVlZYXNHL0hZVUlNVTVj?=
 =?utf-8?B?ZU5TbTV2SmF4MFJmZmxYR3RHRkFwOFcxcHNBeHF4dFFFZDFIZ0xJRnhxbjhC?=
 =?utf-8?B?bm8xZEpKY1c4ZTM2NE1PZ2FHTXc2T1laZGpYU2pjM0I5WVFyaUthWlZ0bHk0?=
 =?utf-8?B?clFWdGVqWGV1aGs2eUhGbUdCMlZYdS9RZ1lEU3lGc2QvRHMrTStDSVIvNnZS?=
 =?utf-8?B?RE9wRWNZdmdQMzlmeEVqNE1sVVpuMzZxUVF3Y0FLUFo2STF1bnptWTlydDY2?=
 =?utf-8?B?b3pCR0ExR2xQMlVRaFF5cEo0NVBjQ3diQkdCbjRpSllUamZ3ZDAzL2thVDlK?=
 =?utf-8?B?enpraXBSMElRbEN2Y0JucHd0cjcxQ2tYRVN6YTVnVis4WWtSdDV4d0dXR3Rp?=
 =?utf-8?B?ejFUWHIwWEZ1V0JHRXRYZWE1SUVrUjdVTkQvTEs4WmxEbFhxQnZRL0xkMW1U?=
 =?utf-8?B?SDk4akZVRDd5UkNTRDU4aGlXVnBuc0JnYmRnOTBNVDBDSkNCdmRrS21oS2ZV?=
 =?utf-8?B?dys5Y1NvRW1HNlVGMCtBLzJURjdJbzhkUDRoYmpGR0liZlI1a0VLY2xXT2FN?=
 =?utf-8?B?blozVFlXdUtmVHV3TG8ydDNVWnZ5cUlvNE1ZbWlERCszM05XYVFWTElmR2gz?=
 =?utf-8?B?WUVpVUJFL285U1gvREQrckpKazM2V3g3R1NsY0FHQ3RjdXNYRVNkMkpxRVl1?=
 =?utf-8?B?aDlWVmgyU1lmcW5uSythU3B1Sjk1ZWR3WGVXV2lrMytITERJM2lsSHlKWitW?=
 =?utf-8?B?QmIvN1EyMytlSlNEdExQM2U5a0VpN0crU05VWVZINWpHZDJka1ZNSUE0YlNJ?=
 =?utf-8?B?ZHBCL0J1MndMSTl2aDJ3T21LYWFYenlock0xMG5BZGxqNVdEaWFwQzk1ZzFq?=
 =?utf-8?B?bDVjQUhHOThtMEg4TnBhSGxoVlI5dE5WNTkzOHhKZ3Z3SnpHSjZSdS9FRzRH?=
 =?utf-8?B?YXhZbFB4NnhxVnJqWC82VWxkWmlrQlo4aFUzQXpQQXFwcE9QUmtZYVpwM0g3?=
 =?utf-8?Q?YD52BTUwaSb2DissOyiOKNk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55055ac1-c6a2-4740-1c3a-08dc62cee0f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 13:19:45.6787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lOm0271VTi3sTImR3Sj7rZrY3luG/rifJy7XDbiT37VUv5Ii5DdFU36hXM4W7G96c0lritwxM7V8rdmYvdeaqNJZXjCF/jIUu1DOYhAo6VLgpy12NIBe/0w6W0XNgO3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcndhbiBWZWx1IDxlcndhbmFs
aWFzcjFAZ21haWwuY29tPiANCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxOSwgMjAyNCA4OjEwIFBN
DQo+IFRvOiBQdWNoYSwgSGltYXNla2hhclggUmVkZHkgPGhpbWFzZWtoYXJ4LnJlZGR5LnB1Y2hh
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCB2NCBp
d2wtbmV0XSBpNDBlOiBQcmV2ZW50IHNldHRpbmcgTVRVIGlmIGdyZWF0ZXIgdGhhbiBNRlMNCj4N
Cj4gSHVtIHRoYXQncyBwcmV0dHkgdW5leHBlY3RlZC4NCj5DYW4geW91IHByaW50ICJuZXdfbXR1
IiAgYW5kICJtYXhfbXR1IiBpbiBpNDBlX2NoYW5nZV9tdHUoKSA/DQoNCkhpIHZlbHUsDQoNClBs
ZWFzZSBmaW5kIGJlbG93IGxvZ3MNCg0KDQpbcm9vdEAgfl0jIGlmY29uZmlnIGVuczgwM2YwbnAw
DQplbnM4MDNmMG5wMDogZmxhZ3M9NDE2MzxVUCxCUk9BRENBU1QsUlVOTklORyxNVUxUSUNBU1Q+
ICBtdHUgMTUwMA0KICAgICAgICBldGhlciAwMDowMDowMDowMDowMTowMCAgdHhxdWV1ZWxlbiAx
MDAwICAoRXRoZXJuZXQpDQogICAgICAgIFJYIHBhY2tldHMgNiAgYnl0ZXMgMTkwOCAoMS44IEtp
QikNCiAgICAgICAgUlggZXJyb3JzIDAgIGRyb3BwZWQgMCAgb3ZlcnJ1bnMgMCAgZnJhbWUgMA0K
ICAgICAgICBUWCBwYWNrZXRzIDQgIGJ5dGVzIDEzNjggKDEuMyBLaUIpDQogICAgICAgIFRYIGVy
cm9ycyAwICBkcm9wcGVkIDAgb3ZlcnJ1bnMgMCAgY2FycmllciAwICBjb2xsaXNpb25zIDANCg0K
W3Jvb3RAIH5dIyBpZmNvbmZpZyBlbnM4MDNmMG5wMCBtdHUgOTcwMA0KW3Jvb3RAIH5dIyBpZmNv
bmZpZyBlbnM4MDNmMG5wMA0KZW5zODAzZjBucDA6IGZsYWdzPTQxNjM8VVAsQlJPQURDQVNULFJV
Tk5JTkcsTVVMVElDQVNUPiAgbXR1IDk3MDANCiAgICAgICAgZXRoZXIgMDA6MDA6MDA6MDA6MDE6
MDAgIHR4cXVldWVsZW4gMTAwMCAgKEV0aGVybmV0KQ0KICAgICAgICBSWCBwYWNrZXRzIDEwICBi
eXRlcyAzMTgwICgzLjEgS2lCKQ0KICAgICAgICBSWCBlcnJvcnMgMCAgZHJvcHBlZCAwICBvdmVy
cnVucyAwICBmcmFtZSAwDQogICAgICAgIFRYIHBhY2tldHMgNiAgYnl0ZXMgMjA1MiAoMi4wIEtp
QikNCiAgICAgICAgVFggZXJyb3JzIDAgIGRyb3BwZWQgMCBvdmVycnVucyAwICBjYXJyaWVyIDAg
IGNvbGxpc2lvbnMgMA0KDQpbcm9vdEB+XSMgaWZjb25maWcgZW5zODAzZjBucDAgbXR1IDEwMDAN
Cltyb290QCB+XSMgaWZjb25maWcgZW5zODAzZjBucDANCmVuczgwM2YwbnAwOiBmbGFncz00MTYz
PFVQLEJST0FEQ0FTVCxSVU5OSU5HLE1VTFRJQ0FTVD4gIG10dSAxMDAwDQogICAgICAgIGV0aGVy
IDAwOjAwOjAwOjAwOjAxOjAwICB0eHF1ZXVlbGVuIDEwMDAgIChFdGhlcm5ldCkNCiAgICAgICAg
UlggcGFja2V0cyAxMCAgYnl0ZXMgMzE4MCAoMy4xIEtpQikNCiAgICAgICAgUlggZXJyb3JzIDAg
IGRyb3BwZWQgMCAgb3ZlcnJ1bnMgMCAgZnJhbWUgMA0KICAgICAgICBUWCBwYWNrZXRzIDYgIGJ5
dGVzIDIwNTIgKDIuMCBLaUIpDQogICAgICAgIFRYIGVycm9ycyAwICBkcm9wcGVkIDAgb3ZlcnJ1
bnMgMCAgY2FycmllciAwICBjb2xsaXNpb25zIDANCg0KRG1lc2c6DQoNClsgICswLjAxMzc0NF0g
aTQwZSAwMDAwOjg2OjAwLjA6IGZ3IDkuMTQwLjc2ODU2IGFwaSAxLjE1IG52bSA5LjQwIDB4ZWZk
MGVkMTIgMS4zNTM0LjAgWzgwODY6MTU4Yl0gWzgwODY6MDAwMl0NClsgICswLjEwMjA0Nl0gaTQw
ZSAwMDAwOjg2OjAwLjA6IE1BQyBhZGRyZXNzOiAwMDowMDowMDowMDowMTowMA0KWyAgKzAuMDAz
OTk5XSBpNDBlIDAwMDA6ODY6MDAuMDogRlcgTExEUCBpcyBlbmFibGVkDQpbICArMC4wMDYwMzhd
IGk0MGUgMDAwMDo4NjowMC4wIGV0aDA6IE5JQyBMaW5rIGlzIFVwLCAyNSBHYnBzIEZ1bGwgRHVw
bGV4LCBSZXF1ZXN0ZWQgRkVDOiBDTDEwOCBSUy1GRUMsIE5lZ290aWF0ZWQgRkVDOiBDTDEwOCBS
Uy1GRUMsIEF1dG9uZWc6IFRydWUsIEZsb3cgQ29udHJvbDogTm9uZQ0KWyAgKzAuMDAwNDQ4XSBp
NDBlIDAwMDA6ODY6MDAuMDogUENJLUV4cHJlc3M6IFNwZWVkIDguMEdUL3MgV2lkdGggeDgNClsg
ICswLjAwMDM4NV0gaTQwZSAwMDAwOjg2OjAwLjA6IE1GUyBmb3IgcG9ydCAwICg1ODg4KSBoYXMg
YmVlbiBzZXQgYmVsb3cgdGhlIGRlZmF1bHQgKDk3MjgpDQpbICArMC4wMDAxMjldIGk0MGUgMDAw
MDo4NjowMC4wOiBGZWF0dXJlczogUEYtaWRbMF0gVkZzOiA2NCBWU0lzOiA2NiBRUDogOTYgUlNT
IEZEX0FUUiBGRF9TQiBOVFVQTEUgRENCIFZ4TEFOIEdlbmV2ZSBQVFAgVkVQQQ0KWyAgKzAuMDA0
NTQwXSBpNDBlIDAwMDA6ODY6MDAuMCBlbnM4MDNmMG5wMDogcmVuYW1lZCBmcm9tIGV0aDANClsg
ICswLjAwOTAxMl0gaTQwZSAwMDAwOjg2OjAwLjE6IGZ3IDkuMTQwLjc2ODU2IGFwaSAxLjE1IG52
bSA5LjQwIDB4ZWZkMGVkMTIgMS4zNTM0LjAgWzgwODY6MTU4Yl0gWzgwODY6MDAwMl0NClsgICsw
LjIzNjk3NV0gaTQwZSAwMDAwOjg2OjAwLjE6IE1BQyBhZGRyZXNzOiAwMDowMDowMDowMDowMTow
MQ0KWyAgKzAuMDAwMjUyXSBpNDBlIDAwMDA6ODY6MDAuMTogRlcgTExEUCBpcyBlbmFibGVkDQpb
ICArMC4wMDYwNzhdIGk0MGUgMDAwMDo4NjowMC4xIGV0aDA6IE5JQyBMaW5rIGlzIFVwLCAyNSBH
YnBzIEZ1bGwgRHVwbGV4LCBSZXF1ZXN0ZWQgRkVDOiBDTDEwOCBSUy1GRUMsIE5lZ290aWF0ZWQg
RkVDOiBOb25lLCBBdXRvbmVnOiBUcnVlLCBGbG93IENvbnRyb2w6IE5vbmUNClsgICswLjAwMDQz
N10gaTQwZSAwMDAwOjg2OjAwLjE6IFBDSS1FeHByZXNzOiBTcGVlZCA4LjBHVC9zIFdpZHRoIHg4
DQpbICArMC4wMDAzODZdIGk0MGUgMDAwMDo4NjowMC4xOiBNRlMgZm9yIHBvcnQgMSAoNTg4OCkg
aGFzIGJlZW4gc2V0IGJlbG93IHRoZSBkZWZhdWx0ICg5NzI4KQ0KWyAgKzAuMDAwMTI5XSBpNDBl
IDAwMDA6ODY6MDAuMTogRmVhdHVyZXM6IFBGLWlkWzFdIFZGczogNjQgVlNJczogNjYgUVA6IDk2
IFJTUyBGRF9BVFIgRkRfU0IgTlRVUExFIERDQiBWeExBTiBHZW5ldmUgUFRQIFZFUEENClsgICsw
LjAwNDY5N10gaTQwZSAwMDAwOjg2OjAwLjEgZW5zODAzZjFucDE6IHJlbmFtZWQgZnJvbSBldGgw
DQoNCltBcHIyMiAxMDowNl0gaTQwZSAwMDAwOjg2OjAwLjAgZW5zODAzZjBucDA6IE5ldyBNVFUg
aXMgOTcwMCwgTWF4IE1UVSBpcyA5NzAyDQpbICsyMS42MDgyMjRdIGk0MGUgMDAwMDo4NjowMC4w
IGVuczgwM2YwbnAwOiBOZXcgTVRVIGlzIDEwMDAsIE1heCBNVFUgaXMgOTcwMg0KDQo+TGUgdmVu
LiAxOSBhdnIuIDIwMjQgw6AgMTY6MjYsIFB1Y2hhLCBIaW1hc2VraGFyWCBSZWRkeSA8aGltYXNl
a2hhcngucmVkZHkucHVjaGFAaW50ZWwuY29tPiBhIMOpY3JpdCA6DQo+ID4NCj4gPiA+LS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEludGVsLXdpcmVkLWxhbiA8aW50ZWwt
d2lyZWQtbGFuLWJvdW5jZXNAb3N1b3NsLm9yZz4gT24gQmVoYWxmIA0KPiA+ID5PZiBFcndhbiBW
ZWx1DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEzLCAyMDI0IDI6MzcgUE0NCj4gPiA+
IENjOiBWZWx1LCBFcndhbiA8ZS52ZWx1QGNyaXRlby5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyANCj4gPiA+RXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgTmd1eWVuLCANCj4gPiA+QW50aG9ueSBMIDxhbnRob255Lmwu
bmd1eWVuQGludGVsLmNvbT47IA0KPiA+ID5pbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9y
ZzsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IA0KPiA+ID5QYW9sbyBBYmVuaSA8
cGFiZW5pQHJlZGhhdC5jb20+OyBEYXZpZCBTLiBNaWxsZXIgDQo+ID4gPjxkYXZlbUBkYXZlbWxv
ZnQubmV0Pg0KPiA+ID4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHY0IGl3bC1u
ZXRdIGk0MGU6IFByZXZlbnQgc2V0dGluZyANCj4gPiA+TVRVIGlmIGdyZWF0ZXIgdGhhbiBNRlMN
Cj4gPiA+DQo+ID4gPiBDb21taXQgNjg3MWE3ZGU3MDUgKCJbaW50ZWx4bF0gVXNlIGFkbWluIHF1
ZXVlIHRvIHNldCBwb3J0IE1BQyBhZGRyZXNzIGFuZCBtYXhpbXVtIGZyYW1lIHNpemUiKSBmcm9t
IGlQWEUgcHJvamVjdCBzZXQgdGhlIE1GUyB0byAweDYwMCA9IDE1MzYuDQo+ID4gPiBTZWUgaHR0
cHM6Ly9naXRodWIuY29tL2lweGUvaXB4ZS9jb21taXQvNjg3MWE3ZGU3MDUNCj4gPiA+DQo+ID4g
PiBBdCBib290IHRpbWUgdGhlIGk0MGUgZHJpdmVyIGNvbXBsYWlucyBhYm91dCBpdCB3aXRoIHRo
ZSBmb2xsb3dpbmcgbWVzc2FnZSBidXQgY29udGludWVzLg0KPiA+ID4NCj4gPiA+ICAgICAgIE1G
UyBmb3IgcG9ydCAxIGhhcyBiZWVuIHNldCBiZWxvdyB0aGUgZGVmYXVsdDogNjAwDQo+ID4gPg0K
PiA+ID4gSWYgdGhlIE1UVSBzaXplIGlzIGluY3JlYXNlZCwgdGhlIGRyaXZlciBhY2NlcHRzIGl0
IGJ1dCBsYXJnZSBwYWNrZXRzIHdpbGwgbm90IGJlIHByb2Nlc3NlZCBieSB0aGUgZmlybXdhcmUg
Z2VuZXJhdGluZyB0eF9lcnJvcnMuIFRoZSBpc3N1ZSBpcyBwcmV0dHkgc2lsZW50IGZvciB1c2Vy
cy4gaS5lIGRvaW5nIFRDUCBpbiBzdWNoIGNvbnRleHQgd2lsbCBnZW5lcmF0ZXMgbG90cyBvZiBy
ZXRyYW5zbWlzc2lvbnMgdW50aWwgdGhlIHByb3BlciA+IHdpbmRvdyBzaXplIChiZWxvdyAxNTAw
KSB3aWxsIGJlIHVzZWQuDQo+ID4gPg0KPiA+ID4gVG8gZml4IHRoaXMgY2FzZSwgaXQgd291bGQg
aGF2ZSBiZWVuIGlkZWFsIHRvIGluY3JlYXNlIHRoZSBNRlMsIHZpYSBpNDBlX2FxY19vcGNfc2V0
X21hY19jb25maWcsIGluY29taW5nIHBhdGNoIHdpbGwgdGFrZSBjYXJlIG9mIGl0Lg0KPiA+ID4N
Cj4gPiA+IEF0IGxlYXN0LCBjb21taXQgcHJldmVudHMgc2V0dGluZyB1cCBhbiBNVFUgZ3JlYXRl
ciB0aGFuIHRoZSBjdXJyZW50IE1GUy4NCj4gPiA+IEl0IHdpbGwgYXZvaWQgYmVpbmcgaW4gdGhl
IHBvc2l0aW9uIG9mIGhhdmluZyBhbiBNVFUgc2V0IHRvIDkwMDAgb24gdGhlIG5ldGRldiB3aXRo
IGEgZmlybXdhcmUgcmVmdXNpbmcgcGFja2V0cyBsYXJnZXIgdGhhbiAxNTM2Lg0KPiA+ID4NCj4g
PiA+IEEgdHlwaWNhbCB0cmFjZSBsb29rcyBsaWtlOg0KPiA+ID4gWyAgMzc3LjU0ODY5Nl0gaTQw
ZSAwMDAwOjVkOjAwLjAgZW5vNTogRXJyb3IgY2hhbmdpbmcgbXR1IHRvIDkwMDAsIE1heCBpcyAx
NTAwLiBNRlMgaXMgdG9vIHNtYWxsLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVyd2Fu
IFZlbHUgPGUudmVsdUBjcml0ZW8uY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYyB8IDEwICsrKysrKysrKy0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+
DQo+ID4NCj4gPiBXaXRoIHBhdGNoIHdoZW4gd2Ugc2V0IHRoZSBNRlMgdG8gMTcwMCAoNTg4OCkg
aW4gdGhlIE5WTSAoYXMgc2VlbiBiZWxvdykgYW5kIHRoZW4gc2V0IHRoZSBNVFUgb24gUEYwIHRv
IDkwMDAgYW5kIGl0IHNldCBpdCB0byA5MDAwIHdpdGggbm8gZXJyb3JzIGFuZCBubyBtZXNzYWdl
cyBpbiBkbWVzZy4NCj4gPg0KPiA+IFtyb290QGxvY2FsaG9zdCB1c2VyXSMgaXAgbGluayBzZXQg
bXR1IDkwMDAgZGV2IGVucDEzMXMwZjBucDAgDQo+ID4gW3Jvb3RAbG9jYWxob3N0IHVzZXJdIyBp
cCBsaW5rIHNob3cgZGV2IGVucDEzMXMwZjBucDANCj4gPiA5OiBlbnAxMzFzMGYwbnAwOiA8QlJP
QURDQVNULE1VTFRJQ0FTVCxVUCxMT1dFUl9VUD4gbXR1IDkwMDAgcWRpc2MgbXEgc3RhdGUgVVAg
bW9kZSBERUZBVUxUIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQo+ID4gICAgIGxpbmsvZXRoZXIg
MDA6MDA6MDA6MDA6MDE6MDAgYnJkIGZmOmZmOmZmOmZmOmZmOmZmDQo+ID4NCj4gPiBkbWVzZyB3
aGVuIGxvYWRpbmcgdGhlIGRyaXZlcjoNCj4gPiBbMjU3LjAzNTgyM10gMTQwZSAwMDAwOjgzOjAw
LjE6IE1GUyBmb3IgcG9ydCAxICg1ODg4KSBoYXMgYmVlbiBzZXQgDQo+ID4gYmVsb3cgdGhlIGRl
ZmF1bHQgKDk3MjgpDQo+DQoNCg==

