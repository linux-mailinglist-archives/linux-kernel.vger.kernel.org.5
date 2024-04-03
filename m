Return-Path: <linux-kernel+bounces-130005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79C897313
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0754B22C71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288114900E;
	Wed,  3 Apr 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgaumdt5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF57B66E;
	Wed,  3 Apr 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156014; cv=fail; b=uBwqiKxvx9PS0ajagDYAZzgh8WUcKwi+GpLs/0g5PjoKnsGY8DNAbB2ZNCgDPl+HuTI39cWOJDnBg3TRup1ccf5LlH9/8geaSZlNU5u/P+1Ino+Is4lrrwDpV/dbBlIGNhxd9lr6UAoNq06FFinnkMkRWxF0VbNyc/v6jRIkPiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156014; c=relaxed/simple;
	bh=naXdqDc5YRv/tqgFPNYmbHe+gJflUnriaq8LK3s8Qco=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eraDbkcFfYBwuC6t9bz1ln5xFM7JkNJRmd7wKkxQmeB+q99jjafrLka8A8u/seJEl0R/OrezTuJn+wJ8y1Qzt6ejMf9mnFWad9ZVdYgKzWY7FLR2voWtvxPhwlJDJsBLEFW6Q5cYveVbody9tINXDcJVSI9zfrkSUPV2IkMACfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgaumdt5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712156013; x=1743692013;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=naXdqDc5YRv/tqgFPNYmbHe+gJflUnriaq8LK3s8Qco=;
  b=Kgaumdt5IIcGXRyeXvP5pUMvj30Rj2qm4Smyh3x+KanAj8ogFw/XrZjB
   nRRHdgevTD0mcTHqmbCrRfVD3d/FEb3nl/9Kgq2alhcTlF43ESE1dnCMQ
   f9pThADJXryjQoiGUTrkM43xq//aLoqE6Ay94qJIruBDbHUHSnumH+7Iq
   IBFrcDvu3oSvKq3Sf3D3BHVSqsgv/yDZ/x0ZyzCynRxER9Ci7CwypDW81
   SNlUPxIB+VpUvJ9sQs3PJoCQb0RMGPIpkmcvmaD7+FT3cyjgXZ2zQTAHu
   wOI8gkBLXOu6/ascEtiKDHc5rJiKciNLexLMepMsCjwyCma3U7LmxadHL
   Q==;
X-CSE-ConnectionGUID: XsQNqwzUS8ebcTZ4UEk9lA==
X-CSE-MsgGUID: umlWqbYUSou+vor3ieJUQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7557797"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7557797"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:53:31 -0700
X-CSE-ConnectionGUID: MGO8A6tORVC6hx83hDzbCg==
X-CSE-MsgGUID: Tje/+GbyTDCRY/PO3OfrQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23221862"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 07:53:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 07:53:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 07:53:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 07:53:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 07:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QADfIv8WMgS12nsic6HDjbrWmFGYZpK1Ah7+ULN7hqpnMeNMFAnQleN1o2yusfk+t2jTJMICz0/aJOqGfREN5yncThF5VOwUbhRAT6uiCmsvYiVgr5M/f+mC6h35xOCsmswwRBJ5v8j308uliK7skB0eX79tl8xBNSU7LDpb6evcOcjEQb7GEQCKvUacADtGYyXRllXyme0G86y7C/bOw5gTWZOngWWPYwoZzhg4kvlBVzKh1C3sJKR/Vi/5BIhN3y6/9d1su0V/87QfGWvM2VmwXRPOfRiIqkn3p+RE8iXq3e8Up2f8b6neaTd2Ft/L7XxOj7hDQpeFYMGnfPJ/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4+CVDBuX2yQ0FRwXd2nJpeKuHaMRo1yUf3fYDUmcek=;
 b=FRIineywNdm3k4GK4nWaS/gCw1A1IVZpU/A4SC4uPQoEbxcKZtk+IeCmg3Ra2DaDz0vgkNblhUnte3lfjh5q0jIRmV8HRCFb7ICSX9Px0odG7jm9Ed85E0RMHBlQl8TRfS50VBvazTgZf75E03bMewgPXobygXfv2YwbwBvG9xrkCjIDBGn5GSArMN07jb4DArW5hg2+w+jcRL0VTdaXxKFZK5x8HTLPb4PDPThw1QUBuV2Tav7ncnAUG0uZGl73en25jFZZVAbs9bWPvkq3i6ZB3V/Y9nsNeW4uQsVmfjz1XD+ihevGQkP60XYtlkrQzedcQr0t+QmsGpSIwthh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Wed, 3 Apr
 2024 14:53:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Wed, 3 Apr 2024
 14:53:26 +0000
Date: Wed, 3 Apr 2024 07:53:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel_team@skhynix.com>
Subject: RE: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out
 in get event
Message-ID: <660d6d64a50bd_7702a29466@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
 <20240402081404.1106-2-kwangjin.ko@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402081404.1106-2-kwangjin.ko@sk.com>
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7193:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q70RsD3KpJcnr7Ehu1v6pB8BNNBWiV5UdPevNOq9mGCIyUgx4gRD+T7Wk2OHdUh3o2dcvdKCtKFcVooqlowqQJR2FV8wgC7DgMHpMtzrftUlKCa/DxoVzxv31Oa+oDO1WP+5+I1qkXrHLDBGzyR5pcNVwWWJSxIyGkZC2NJK4bNdkg4XVsYcnyucRVOJ69L1OH7jK4AHUidSywuueUW87/6ewmydhlXfNT4hgi5Z8nOzG3Xjfzbojv+1tQBV1aq4tYOXlP/t00dU4vNLgQ8vMyP/Ss2RULS1p5+cKMlZKmUnZOLJUGbxOQbdMd+Wdqp2JVAu9J2GzzdhlPW7MEDaf0xyoQOVBhGIo2qph7cCh9/csaCQhR9q4RHIiQ91zROG4LLafMp0Oe8r7MkWz7ZCwIj7xbHjqvOtiEdKJGP/TL9Kg1oy+oOu0Rd8tu5wdQgrbgmoWPjz8ubKVk7/X+J2KR701aZNzwLS7kAcrDwy5mNsGLwEVvuKLiImzd3RKIxxfv4/NIQCoQrwRlxySGcRWlmIU4/kp/aZgQEBbo94dSRJ9Kgh4HTRlhLj9zscSTCVDp82u3rr6BQK767WsjiW8/8hNVmlkWcN853n8mN1CwibYHG2KGyuQwZ08bU/P8PVsqa8fhR9QFxldTnfaKJgf5bSoNhQiz+BoGBatvcXDLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QY2D71+T92nge6a5axiOnwEeQ7AXJVYCmiClTOTORoFkSZ5N5qBl/EEYlHi/?=
 =?us-ascii?Q?KxBlE254csR4xRfk1pTfcnVti5jTo0jIF1QpCatVT7tM+3V7NnYX8Sjl/TIU?=
 =?us-ascii?Q?Pg9TJX7hZR8hyoEQnXFq4pVnmurWJ6BtCRtTMlMHORalo9VDyXS2q7fOEHhd?=
 =?us-ascii?Q?UAfGO3XZJf+yhc+sei5x0dED/Z1QFi/GYSf6cxcI8tWR2kemWgjDTeQLPzNt?=
 =?us-ascii?Q?Bf7uTUcKJ6FetZClRu2AYEnI3rtzuOmPlmBwDJcB2k4gOX11/l4UvYFMDC7F?=
 =?us-ascii?Q?cWyr2clcPV1n9NrzeQlabreTD3B7tbHv0Cro0UgaRP/h8vX4s9s2O164ypYd?=
 =?us-ascii?Q?EjUEU6fsTEhDkxT705UralITr+oKkGSdhcyd5b3uKpkShJ3rVM6nAK7ADEic?=
 =?us-ascii?Q?DWQJ3afSVk8GuGM6WVI3EX4VSzCpLR9sU1A0091PJCy/N5E2qmXPkGYRrH07?=
 =?us-ascii?Q?eIqQLqWS8Xgbk1NgAcCJs4LzWhCnq/iUQuFC3/SSD7WmWFVX1/xufCFUddwK?=
 =?us-ascii?Q?RMR/Qqfvp+nIx0MGlPA43eYE8dusgtBm2Gq9vww9L0dHYVYKxRgQz4Jpoh/E?=
 =?us-ascii?Q?f6p7IxWpIHcDL1zjBt8bao9bG3uw7GZHmJni/Zhml0Iwul/5P89G7yHCe9nr?=
 =?us-ascii?Q?+nLmBBjuuQi/V/wAldB6PygwPc18okt6HYKuJgtzfJdD9NO1x+1d1tfWtir9?=
 =?us-ascii?Q?VCd7guIOxZtYB9VIsgc8vVOU5wlDwxkBHak2pW2MoP8gAuLjqds8J9/+uNsY?=
 =?us-ascii?Q?O6QYDaQcoK2sOjvSS2Vj8k9qpJdoA/KUrC5F82XbduzV+AomTl/6Zyf5QIfD?=
 =?us-ascii?Q?pAwPhlShx5nZ6zSCP1gWriG+xn9TaMPMHz+JMYBd9dnLSBeLNU0IIlIrQC0E?=
 =?us-ascii?Q?7v8mSkjlCLOaYUAfbiVLatmToeXovNvR7LFeZsuPuEb9H8CNZHc/zMgwt9dY?=
 =?us-ascii?Q?uqaDo+OsgpljinV7lp1qg8mHYqa3/MDsoWQtufXSRpYu8w+VoNg18vToQrQd?=
 =?us-ascii?Q?zf+rcgzauAKRROmCc/BQKhh7qYSZrG4jBf6wKbgFnmpRy4mwlrYiIytcqQuF?=
 =?us-ascii?Q?M+48FNG6FJFKw1g5IsvP1b1TWAR6IDTiJg/N2O+NJCfY69gZl40xnGykMME1?=
 =?us-ascii?Q?8nSUZm8kBfEr3+6kXcbnQbYRvBdj0TTt2mRlzVUyZp3iJRy40V682ZJFjHmu?=
 =?us-ascii?Q?V+z2CQxhCcPheHrNehEaDeBh2PkEiWII8p0w5TLfg39LsyPphPW/F6E2wooD?=
 =?us-ascii?Q?WwFc/8kOeps+AeNsH5QWMYJO3l6vBHiuKDj0H0LPEmlIE/WdOfBtRIfmWK31?=
 =?us-ascii?Q?G0wEY9DBccvGrG3M+Y7aIFALv01wgjc/PX9nl3oM81Gdn37eLOrBcfsAZ6+y?=
 =?us-ascii?Q?KxmmLr5YM9Vdu2yuMPKm8N4LmUWyq5tkl1GpHco96OH4k/FHw9QrLhJ39z89?=
 =?us-ascii?Q?COEuAYmCZiWUXp7m6I30zPL+Ms3nrLyWfYZIg5qe+pdGPlFUeqN7WxifFJUh?=
 =?us-ascii?Q?xPZiciHDHe9Y9gWf0GisKFO4TWyDNxA65EOVVIKCKtF82G0Tw+rG5nD5lwtH?=
 =?us-ascii?Q?TTxMgI7s0ZT5++ZtDIOeeGhxw2DASXUxVYwqSe4q7bBgYyMAVhh1OhirBwFj?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeb8ad5-ee84-47d7-262e-08dc53edd17d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:53:26.8371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64NUsuGuyeE5E3Bx0+klIGFNF+3HNjbV79ncF0tJBf/0EYa502fygsymtI8JzsAExu0ikwCOXME8Qtfw619rxtbov7N/ihG4oZ5dPZh/7KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com

Kwangjin Ko wrote:
> Since mbox_cmd.size_out is overwritten with the actual output size in
> the function below, it needs to be initialized every time.
> 
> cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd
> 
> Problem scenario:
> 
> 1) The size_out variable is initially set to the size of the mailbox.
> 2) Read an event.
>    - size_out is set to 160 bytes(header 32B + one event 128B).
>    - Two event are created while reading.
> 3) Read the new *two* events.
>    - size_out is still set to 160 bytes.
>    - Although the value of out_len is 288 bytes, only 160 bytes are
>      copied from the mailbox register to the local variable.
>    - record_count is set to 2.
>    - Accessing records[1] will result in reading incorrect data.
> 
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..a38531a055c8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		.payload_in = &log_type,
>  		.size_in = sizeof(log_type),
>  		.payload_out = payload,
> -		.size_out = mds->payload_size,
>  		.min_out = struct_size(payload, records, 0),
>  	};
>  
>  	do {
>  		int rc, i;
>  
> +		mbox_cmd.size_out = mds->payload_size;
> +

Fix looks correct, but I am concerned it is a band-aid for a more
general problem. For example, if I am not mistaken, we have a similar
bug in cxl_mem_get_poison().

So perhaps a convention to always define @mbox_cmd immediately before
cxl_internal_send_cmd() like this:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..5d44b5c095b7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -946,24 +946,22 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
        struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
        struct device *dev = mds->cxlds.dev;
        struct cxl_get_event_payload *payload;
-       struct cxl_mbox_cmd mbox_cmd;
        u8 log_type = type;
        u16 nr_rec;
 
        mutex_lock(&mds->event.log_lock);
        payload = mds->event.buf;
 
-       mbox_cmd = (struct cxl_mbox_cmd) {
-               .opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
-               .payload_in = &log_type,
-               .size_in = sizeof(log_type),
-               .payload_out = payload,
-               .size_out = mds->payload_size,
-               .min_out = struct_size(payload, records, 0),
-       };
-
        do {
                int rc, i;
+               struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd){
+                       .opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
+                       .payload_in = &log_type,
+                       .size_in = sizeof(log_type),
+                       .payload_out = payload,
+                       .size_out = mds->payload_size,
+                       .min_out = struct_size(payload, records, 0),
+               };
 
                rc = cxl_internal_send_cmd(mds, &mbox_cmd);
                if (rc) {
@@ -1296,7 +1294,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
        struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
        struct cxl_mbox_poison_out *po;
        struct cxl_mbox_poison_in pi;
-       struct cxl_mbox_cmd mbox_cmd;
        int nr_records = 0;
        int rc;
 
@@ -1308,16 +1305,16 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
        pi.offset = cpu_to_le64(offset);
        pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
 
-       mbox_cmd = (struct cxl_mbox_cmd) {
-               .opcode = CXL_MBOX_OP_GET_POISON,
-               .size_in = sizeof(pi),
-               .payload_in = &pi,
-               .size_out = mds->payload_size,
-               .payload_out = po,
-               .min_out = struct_size(po, record, 0),
-       };
-
        do {
+               struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd){
+                       .opcode = CXL_MBOX_OP_GET_POISON,
+                       .size_in = sizeof(pi),
+                       .payload_in = &pi,
+                       .size_out = mds->payload_size,
+                       .payload_out = po,
+                       .min_out = struct_size(po, record, 0),
+               };
+
                rc = cxl_internal_send_cmd(mds, &mbox_cmd);
                if (rc)
                        break;

