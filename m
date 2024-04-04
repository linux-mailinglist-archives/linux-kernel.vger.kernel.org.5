Return-Path: <linux-kernel+bounces-131287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98098985B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063631C214C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225484D06;
	Thu,  4 Apr 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afmnAUlP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CF8592E;
	Thu,  4 Apr 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228649; cv=fail; b=HGHFnC4hpd5l8O/fx9PzGL1fkSA8MaJpe6iVSxA20BMrGmCsg7L6YikU2yCNYlQpbRqC8nSU+ImigXajf2E1zO8jUAVqiFQbl6b85fL/MYKpN9klML/q6XFgbuM18uvG8N0D2feXf7MQArkXkCZGOSWIGr+7KJvDGsnOGxwzASA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228649; c=relaxed/simple;
	bh=dGD/jEuPsc973n2SuNuu6mgTIZdkuoI0oRFl08LbM1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IGmRbvMOGrk7AdOnQFL7RAMydVA9qM1KixOZv2/RXxFeJp0UiO3jdbRFiPhbQ45Bcx3bUyceg+J1W2s8xG+jQEKdNdQyvFUSAA+94SSmZZM2K1d7WdWS6F+efRZXDzwjoQnON0lJI4PdNH76suJ9zlPoKxsLBCGycKw9Cd00S78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afmnAUlP; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712228642; x=1743764642;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dGD/jEuPsc973n2SuNuu6mgTIZdkuoI0oRFl08LbM1k=;
  b=afmnAUlP+tm7KM5xGwDtPpZQAuQQ+ISJvpIjBBl0q/uBW5XmYFsTkMmJ
   Ake5CMB6l30fELG3IL7he+75YWi0hPiI1J9GjgXb5g4wvcPIT6oE0Ob4n
   9O8aAXNkMZC5E0x2eipf8mahJ5FX99t7NS3BY6LQn/ZHbwjWYOSkMqfod
   a9h2WDLdFX2pHyaixct0SKhzQdKPcTX4PyPDIwKEfqEXbfNUUw65JHNYI
   6993ZyJDFR0Rx7qsIwMWhLswozU0XJVL6rfdjHAL8AcX2QXFYv7eBW8R8
   oRtTcr1IEoyqJ3cTxMXcxRbs7Pka7lc5oBzrIrztChh9cRq/PvzIac7D8
   w==;
X-CSE-ConnectionGUID: eDUMequUTKyMiL16ui9PMA==
X-CSE-MsgGUID: gyDInrrTRT+N5ViRThD7zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7611624"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7611624"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:02:18 -0700
X-CSE-ConnectionGUID: gJINxjiKTeCOmZO2XxmdQA==
X-CSE-MsgGUID: HxuAdBdjSJCYWVgKTZuuug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18786097"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 04:02:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 04:02:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 04:02:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 04:02:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 04:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT17jzlZSeMmIsSB3sa9Gt13pJ70YY4RmyUYF219lowTdWBdVvZgYZt3OAZ+d+zai7pmTwz4z54FbpBEOg3ty92+WP2ZhsGsJWip5wOyRl7CCc2SQNJdnUky2D5aKWfKnxGVuRfOO6+h3WVXaZnxif8yDPxp4hxl5QMOFKSkiuYvsqk0ZElvWlBPVPB0Sp7Z/ZCEwdftw3NoqE+vxXQzDPtLa9m9mTRKVrsw7J1+ls+eYTjAPwl2TP3EIYHkFp6GXxYOToAoGeYhqFsYk4k+xKnSredDqwfi2A4ZUy5W4QailoMrk5lUU/OB2WNSasCAx7z7qDUso69WWvILsXlSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekU4aGJgy8arJ4T8UwYjk0siKv2Nc/aC0YjWjSXUZIY=;
 b=kH2JfoXtO5B/dj55AJBdauDYtB5lRAOdErNNMseuhdPuWZIsu79cxmbgatzxdX1vKVqzV5gFxC/xlnz9ssa9N+1YIxEN9HoTD9bXoBpQycQc7IswHm+kxpHjz1c1r6Ptw7o8eEXp4Bt/f2VnuHAOwYVunldypjnLDWhuNa/YCjmwiVYDNxVTRKIBAi5xaubxDQuP923G/CaUDaqZ0IErTA5yYIJ+fIvnzjHvGYXLGd60YxnExxXRp7Mm9kJRIi0QcayHjwv8gx3hXN9hdHwyPZW4SjoG9qVWg+qS8mcDmQNQ6Bzsmjtn3/UjfYslcyDXkzMLUhkNDsflU/BUHF7iUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 4 Apr
 2024 11:02:08 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::7e2b:daee:37b2:c2b9]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::7e2b:daee:37b2:c2b9%7]) with mapi id 15.20.7409.039; Thu, 4 Apr 2024
 11:02:08 +0000
Date: Thu, 4 Apr 2024 18:57:24 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: syzbot <syzbot+93cdc797590ffc710918@syzkaller.appspotmail.com>
CC: <dgilbert@interlog.com>, <jejb@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<martin.petersen@oracle.com>, <syzkaller-bugs@googlegroups.com>,
	<pengfei.xu@intel.com>, <Alexander@wetzel-home.de>
Subject: Re: [syzbot] [scsi?] WARNING in sg_remove_sfp_usercontext
Message-ID: <Zg6HlGO8ZyRQZSUA@xpf.sh.intel.com>
References: <000000000000a6e0450614b960ac@google.com>
 <00000000000007e8290614c036a6@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00000000000007e8290614c036a6@google.com>
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|BY1PR11MB8030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOylEKVFcIVrjPFArTWHdES+/3wePjJFrDiIw7EAHWkOeENb/iC4KlC0yYsBEA3UQdoNsxPTnEBD9Pbdaegdit1SgowJDvP+63aNc65GNe3R+/maCKmZorvTO6EMKWWOtxC8sXchl8zsF1U983TUWM8Rm87BQj9msCAHFJA6cCmvCjF7yDV6BAX8M34uSSZ8wKil0xgpApf6ilcfNlXnYSKt5hlct74GXfRHGpcraq1o6tkBZsN4PE8LNR94+8IHtsTlsTjlSustp3j2IkLcnR1MQ3d85M2q9enxJzwmNSIybC+8RNJzEf2lyMtmtSHCyh1WP5MeA4AqxfA+lqWoq1tEKHDmppi+J6cr5ofJxldN/U3vRa6rCZt3zxo5nH5V4iyonH18bt9lwovuf++Z75PsusSl3c5HcNe4AcTvOzXNK4PdjIJA/xpF005MglX4pTMLgwDfcZ2UFpNpgqWJICgUJOyel7QPkjZLLVbfBv3YU5qlXj+XhF+L43r8HzhkQZWvdswtgA/EpZPu63V5m8UPm5B/f/197pgv8rwKYLd4XQJBp8QvNxcL1fdlgEJA9AlF6zKatTXz1y/Ickr6joIkWE+Mi16Jx8Gzmd+Q8k/fywoaC9fhbV8+28P9hDvv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2YjOVFyxSGDvTntGWR7NPydu1VfolvUWqJU6Krhe3jt+DYJR9hjS0nNxLykq?=
 =?us-ascii?Q?jsZk0DOs10t2XFMpEyiC2+tUDUJYf1t9T7fqxKrP+rnCsaoFQBSHE3NF9pXm?=
 =?us-ascii?Q?+RB3ciyjyywcRnvypssnt6vvtHqqUHdOBeC5hSA/U37G319zTPmLPGT4qT5C?=
 =?us-ascii?Q?KTLZGJPHGGY0LqQ/IaHMYwYkXI9mub6NWhu2QackRMMwj0lWL6RIotRcTYBM?=
 =?us-ascii?Q?2tnNVqC79V/rrltOHm5XyfYvj9/Odd/GNn4PmFOX7WBXBO0u0NGeXU5K3H2W?=
 =?us-ascii?Q?24cmA8CXT6FuSy4BTDvqFWhaXpUzbOTcXWibX8YxxISlnZkPRLMTI6rLz22E?=
 =?us-ascii?Q?DwM2lBmNt5ES8KdsEnWdLzkoai0zpFiFVw5zcMkDNRaM0jmIQb7NkbEiDCrR?=
 =?us-ascii?Q?+pXHLFTG5KY+xTPkjixphFnx1W5hYMH4XhSC/YUhcBn6WQaWZhMTApqrOn5l?=
 =?us-ascii?Q?S+4fHQEG+S/Upfz56ivHl0vml3+n/JSaPxfR6eoCT8UgHcm26yg/FQU/PZZl?=
 =?us-ascii?Q?MnVa8B+wsSGgltf1v5GKYXvKAoknAOtiyZ3OHfwvk5QSv8zT9tz+to3fwKOk?=
 =?us-ascii?Q?/gsMbPpYyZNgsifWoJ0lDMXbQxsVikbZh1uA/915qsNExpU/HRqe6Bl9gOXQ?=
 =?us-ascii?Q?tTh85yRw27vfh5qP1p15tov2IsLUgPEQ04xV+B3AewIBG3gUAuSIPOc8VCBw?=
 =?us-ascii?Q?HPH9Kb3M1im7HSMwN2slLvGRFOzVnPgkrhswg9nQLnyVB68m5yKkY1liV9NR?=
 =?us-ascii?Q?AgAXxxVF5nlzYyvVz1ohbVWZB4QIhWNVndT/GjEdzkOf8nYwjfYJNQla7tR1?=
 =?us-ascii?Q?PJLhlf+0YjF1y8uvZoy6HYx+SEVABOiEFa2IQ6p4snKgUV4xSu2kDoCKwhbs?=
 =?us-ascii?Q?9xCGD3oSPuBWFphTf7OEIkHoXcuX5cFVZj27r9WLAPgrvcuw04GYPwIeogU5?=
 =?us-ascii?Q?BhKtvG1yT/dXC+5uGKewAE2RpAXJukBuJ23ivq98z2y68v/k4GcRgMnvQvh/?=
 =?us-ascii?Q?IxGci0kqVQ12y3Zhyf7hDsWu0cZ+l8qSlaVTLyqI4l0wO83OMLi76ORFK7X/?=
 =?us-ascii?Q?1zFwQwfAkTTdoW9WygCuCtn8iv0jAgPKU31lsdcWTiBcqJpGOjbGWpQP0BRM?=
 =?us-ascii?Q?2UTZRpmp8KFndLFds8Y8gsAXTgOXt2tV4pvT8BIY2gLLZb/fI8lTGv4IHxqw?=
 =?us-ascii?Q?sO9MDZKYOqLnAuV45T01fiA4nNXIfr9aT7/dpiaCYVtGRvdAA6DoX2DE/fRW?=
 =?us-ascii?Q?CIWsN9SOVcU1qEQtzSuyEe2kPBFWmlOf1amo0IzT+Gfec/E9bsm3IE8wlIIi?=
 =?us-ascii?Q?+RdIeYxzw68xT24NZqHgRqWroe/70oTV4x9mO4UGfwpnuX5Bx0x0iax18guN?=
 =?us-ascii?Q?id1hSgVLtwsLzFAFuLlIf9dfjQwVNRCbT0ivM+JmOrwWH7qVvac9AQXnQQPA?=
 =?us-ascii?Q?tEpd3ulPuftDaUXcciEQrYiou4a1fmuj1HmTkmb/DHRsUftpTaVK7YbL67RF?=
 =?us-ascii?Q?MnRJgTRqvqU+3aMyxgwoDYWhkizMwqO9TR0zQV2eqJ/NFnplPYXApBBjY1yS?=
 =?us-ascii?Q?AdwOGQSoTA5+eXkHbEnqeD48wT6aLwnwQP5oN/rY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9043a50f-a4a3-4d06-bf1e-08dc5496abda
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 11:02:08.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SntG3ObT9deAv6meSkqh006b+Say5LYXjtzJT+6j3iCpPJLWuXfQNwN+ovQSzGR9BL/wNRmoqOFA1w4C0O9wMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
X-OriginatorOrg: intel.com

cc Alexander Wetzel,

I used syzkaller and found the similar problem.

And bisected and found the related commit:
27f58c04a8f4 scsi: sg: Avoid sg device teardown race
Reverted the commit on top of v6.9-rc2, this issue was gone.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240401_231147_sg_remove_sfp_usercontext
Bisect log: https://github.com/xupengfe/syzkaller_logs/blob/main/240401_231147_sg_remove_sfp_usercontext/bisect_info.log
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240401_231147_sg_remove_sfp_usercontext/kconfig_origin
v6.9-rc2 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240401_231147_sg_remove_sfp_usercontext/bzImage_v6.9-rc2.tar.gz
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240401_231147_sg_remove_sfp_usercontext/repro.c
Syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240401_231147_sg_remove_sfp_usercontext/repro.prog

I hope it's helpful and if it could be fixed.
Feel free to add the reported-by tag from me.

Best Regards,
Thanks!

On 2024-03-28 at 15:40:33 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    a6bd6c933339 Add linux-next specific files for 20240328
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17e3ac29180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b0058bda1436e073
> dashboard link: https://syzkaller.appspot.com/bug?extid=93cdc797590ffc710918
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c87791180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1013ac29180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7c1618ff7d25/disk-a6bd6c93.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/875519f620fe/vmlinux-a6bd6c93.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ad92b057fb96/bzImage-a6bd6c93.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+93cdc797590ffc710918@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 24 at drivers/scsi/sg.c:2236 sg_remove_sfp_usercontext+0x3f3/0x530 drivers/scsi/sg.c:2236
> Modules linked in:
> CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: events sg_remove_sfp_usercontext
> RIP: 0010:sg_remove_sfp_usercontext+0x3f3/0x530 drivers/scsi/sg.c:2236
> Code: 8b 36 49 8d 96 4d 01 00 00 48 c7 c7 a0 fe 4b 8c 48 c7 c1 c0 07 4c 8c 4d 89 e0 e8 d8 a3 eb ff e9 f7 fe ff ff e8 8e 9d 74 fb 90 <0f> 0b 90 e9 3f ff ff ff e8 80 9d 74 fb 48 8b 44 24 08 48 b9 00 00
> RSP: 0018:ffffc900001e7b48 EFLAGS: 00010293
> RAX: ffffffff8620cd42 RBX: 0000000000000002 RCX: ffff8880176f8000
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
> RBP: 0000000000008000 R08: ffffffff8620cc7c R09: 1ffff11003fccfaf
> R10: dffffc0000000000 R11: ffffed1003fccfb0 R12: ffff888022830000
> R13: ffff888022831688 R14: ffff88801fe67d78 R15: ffff888022830148
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005fdeb8 CR3: 000000000e134000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  process_one_work kernel/workqueue.c:3218 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

