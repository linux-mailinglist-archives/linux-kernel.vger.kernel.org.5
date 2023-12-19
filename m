Return-Path: <linux-kernel+bounces-4826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C862818289
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6021F23FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980911712;
	Tue, 19 Dec 2023 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="Q59DZL3e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB911702
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRvMddlVCYxVqJpXURACWCwDladCTsqZj7jgM0EQGdygiejRhMTcFVth+1e/DhVq+SmCNcNlfrUsusZjVlHInUqyfaguTIv0J4xuNMIZCTY3p6jjh5eaRWG7pGJ2WH/kZ2w2IKu0q+p2e9+lT95MqK1d7uaFlM0RwjGQ5/BWg2Bj+I5pLZZCYG5t3g+/in2zdH3k8dNLhPsi45KdhP3ml2m9PuMnHaqzb/gVrs35YNrV1A1kAQ9SW7XzC/JuoMR92B29ELfp5CZScrFfnyPNsvZo/T7XtfCF6L9s+aEs3dBsR94NRmnsR5nKRWak3HYOKivilQ3vj0mlXvYuu+V/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJHTsUDceWWwGc084OVNU6hXke3bO1NZYXKXpc1VBAo=;
 b=Lw9APv4Eh1Hpy1PWGF3TCe5cGtq+8IBEyBBxaun9o+nxiFB7BzU6bVGY5e/KbUL3dC+3pjWjbyhzhV6TWSg97QRCJicnI9T5GjGQDwu9I8yk07zy2O6bYoV3wRQZYPC+11m2j6TwMfmXVCe3xADcOZL17RJL2KyjlcEhXnuwxTjR1Ywuk/WSF+ljEucnXZIKNmK56Ychbk7dM20fMmko6lUMKeVWUGJyB/Vj35ZOLfQ893tRTJ0fSiC89N5/EulqFSq5zy7qlUaDHiuCV2oN1deL5pf1ksKOkgr2zhDE2XS5/Nybhms3LQWgIYnbCL/8VFRlTPTB8AUm/lM+CwcpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJHTsUDceWWwGc084OVNU6hXke3bO1NZYXKXpc1VBAo=;
 b=Q59DZL3eVe5vZlMgLkIi43kWYx0gdhkGS7WXExwRFtwS2fAymTjXOg9tVmskkfl4iZ+kkjnQPC+b8G4rwQpYgpIVwy8t0khDdjpSUmpJiWGhrTgFDsTM5ASGO9t6dEFLbkI+oLEzgDJgK7dPpYpDunRwVECf5atFP+cZTmQtNXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by PH0PR03MB6689.namprd03.prod.outlook.com (2603:10b6:510:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 07:47:47 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::8362:a405:a3e3:5f12]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::8362:a405:a3e3:5f12%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:47:46 +0000
Message-ID: <b8ccbd62-7a0d-49eb-bc32-c48e59adeae6@synaptics.com>
Date: Tue, 19 Dec 2023 15:47:38 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Hsia-Jun Li <Randy.Li@synaptics.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 catalin.marinas@arm.com, will@kernel.org, sumit.garg@linaro.org,
 daniel.thompson@linaro.org, liwei391@huawei.com, ayaka <ayaka@soulik.info>
Subject: Could external jtag debugger trap page fault instead of kernel
 handler?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:74::35) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|PH0PR03MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f2c9b6-b977-4030-4f56-08dc0066ca5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wlo6avQYc08uFOFpj8eljPaY5DXQSoUilV4KiBMrCbAenwUhZ1Se/gYxLpHI4F7FFVMhu377HWZ242G/rvCgNZStv8117GnhYYANLL//B9J/B3iX54nJJpRqbtfBFILOIuJe11h+HV96FjWAyndKNlmY1GHdJVdMQJdI2dg7hl8eu8yRHt6/C1oYqa7MWC3ggJzXdsSql/FeIPS5bmm1IeXUbD+HoCC46an+MrG2WKnN0VHjEisJ6C2tdNwB7js9mHvxx8BAX/TylWcPQ5EO9rSwDz7p+B8y8Vme7Up/FK8Nwc8bF/1C81amTHaVmcaVVC777R63FpqvUB3NAYWqtboEluMvvpUtfTdbQ/ZFJGMKz3VolF3af4daQMlN56lfKlaTDZMpZ7Chq82Lhq8bYWNh/j+PrKk8blmiT526yl9WTQBy1VkOfhf5YiPs9HXO6QUZB82A2B+RBrsfD5vzQCvieLsJOsIs5XKxdg0LCXXHpap0ZZB3cHR5r83rjBuq6gyFwkzr8gD4HOWyOtvGtyIaNuwyilPgTvHXVQv8YR8UMMr2H+wgieRc0Mn4NAIn1Zg7UwVWSiAfSwNL50cZRSnUq4lI6scAfdt3AeUPvz7Nv54KiImHGQJDb9ZvwUEt3Nb0DFQf89tIoW+afpNPfzzLeEdgscSf7y1u7I5pqZ99ZQ38cfZfvHBg6Kni8xZI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39850400004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(8936002)(8676002)(4326008)(6666004)(6512007)(6506007)(45080400002)(52116002)(316002)(83380400001)(66556008)(5660300002)(6916009)(66476007)(66946007)(38100700002)(2616005)(478600001)(31686004)(26005)(6486002)(41300700001)(36756003)(86362001)(31696002)(38350700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2s1QjA4aWllR0pwWmN0QndZMWJ3NHpVYU83NE9OTFhBYTBFVENhSGNobTMy?=
 =?utf-8?B?bm83aWpnSkVyTmFKOFRqNEgyMFBzbUdkeUZyNGhScEtrSmRjRk5hNi9SaGd0?=
 =?utf-8?B?VlNsd1d2emlScWk2dTBGWmhYR25HMzNQNytyZkpjRU1VaU5RMEt0SVRPL0NY?=
 =?utf-8?B?cWxlUFo4QzZUb1dZN2RTR0xLcjRDaWtsaEpzTTlTMG5EaFBINDV0aFljMktN?=
 =?utf-8?B?YWxDWDF2NEdMYmE5L0JieEI2WXFtcWdyOURJQ0xkYzNBY1FRMUpzZkFOVjNK?=
 =?utf-8?B?RDJkMlRnZ2ZsczdSRnFyUWpPaFA0NjZXdVpxRlEvYU1haFczeXo2VHgyNDJU?=
 =?utf-8?B?TjEvRVRLQk9ScC9MbUlJQUFnc0VjQXlXTjc1ZUdsc1JnR1VkSWFqYnZRYjZv?=
 =?utf-8?B?OTl5VU1IRVZwWlFSTmJielRwRlY5RXVHbG9XQ1hwUTU0TFZOWjdHbWFWTXk1?=
 =?utf-8?B?d1hGdFlVWm9SRzJvak9yQlUvdW1nRm5mRkgyZUI3TmNHZ2pzTkk3cHJuU0tX?=
 =?utf-8?B?eUdnNXQ3bEJ6T0YyS0RDNFpYeGk3dWxaWXY5Q09RM3BvMnZxVFFJVWhHRHlC?=
 =?utf-8?B?dTNmOGdhNitEaUpVeHBwQmExSUdnTEJsamFwL09Vc2lBTmltQWJVRElWalJV?=
 =?utf-8?B?dWQvYm9MU2lNakdicjVzK1ErbGM5TWJDQ1hPS2thQ1ZLQ2dKdE56UjBDZ2R3?=
 =?utf-8?B?eEFmUDBNenBmUHBFZzhjRTc0eFFYOVZoM2JrbWxPZUhNSi9INDR3V1hLQVZL?=
 =?utf-8?B?OFVRZEh0SHlzMFlIb3B1UVZaTGk3djljMlpFQU9NWERQN3dYUHJIVnFhTlJs?=
 =?utf-8?B?VlBSSnlPQmpXSS9INE9tdS9zZlFwc2VMUXltZkpvWHMrNU5ZMkpQUjZWVUlv?=
 =?utf-8?B?YlpaaG9SYzdIYkNubzJiM2lGWklSUHBORExvVE04UmZadGdnZ0lSV2p0Ynhp?=
 =?utf-8?B?cTd0aGFRenZUQ2kwcXcyK2p1NGhIQjRnYTNXU283S0t1Z1liUUl6OFA2elFF?=
 =?utf-8?B?T3pTM0QxdjczN2VzVFMxczMzVDhYMVA1VzNvLytXakNtSDZYNmxHbE1IVHRv?=
 =?utf-8?B?bjd6Z2hMMjNud2FSbEJaNE5sSHRCZFFKa0VPOUhDQzg5VUFKbzUzemlkMlBq?=
 =?utf-8?B?RlZxd09XUW8ybUtJbVJTakk1M3VkVmg4SFN1QWhkbjhndUU2K1RuQ2o1WGV3?=
 =?utf-8?B?WXc1STlzUXN2bXZIZWVyL3djSnUwenRXZEV5OG9qdmxCSmEyaWpmUXRseHZv?=
 =?utf-8?B?cXhEMWFVOXI2YmdwSUkwMGtwck9RckZGQkRqVUFtRWgyL3BkbmhiYVFNSWky?=
 =?utf-8?B?T2lKZm1jaS9DNHozc0JMZ09xSEZlaTFFd3UwdDNIa1psRlRDa0RlWVBNS0dy?=
 =?utf-8?B?dm04cmlkL0ZUTDdhRkgwdXpSNlVwbWdYdStUWkdTWVBjRmovbkM4RU56SVl3?=
 =?utf-8?B?d0Z2b1hCSWhwUnN3OHFENDNvUm5TRi80OStXek1HN2czTWk3cldrMW5SQXlL?=
 =?utf-8?B?T2FJalVwYXJIdExmaEFsK2VCbitEaVh4Z2tGNGo1ZnRVYXZFTTdCYTFNVkQ3?=
 =?utf-8?B?c2Z0Q0ZtYkQ2dWNIQ2FRa1FtRG1MUFppbVUxaFM5TXVuZVh6NGd3QmRFeDVK?=
 =?utf-8?B?dDdsdTBnVmoxZ092SkxjM1lmUWQyU3VXVGpDQWdHRUtWRmxGZkZrTjBuekM1?=
 =?utf-8?B?RE5GTis1SUszeFVkUnZ2SzgwK0h0WWFJZlRhSE8xNFQ0OU9rbFlLRzhGNFA4?=
 =?utf-8?B?VEhjZmM2LzZiVmQ3aVlKOTYxVm1hS2REVlBuc0cydmhsWUFLV2RueldsRkQ0?=
 =?utf-8?B?MElLSElESWxnZjFTR3g2R0J2WTVvYVRtaWdud01kS2FydGE0UERBejQ4NFFB?=
 =?utf-8?B?dDhKbW5Mdyt6SE1zTE1CbEd4eXlYZmR0QUFBYjNOZUpPYjUxcDYzd0creG14?=
 =?utf-8?B?TVBjdXJBYkNqOUJMT3JOMmdmWkNKSEdzVlJYdE5qckxSaU1rNUNMTWtOb1FV?=
 =?utf-8?B?VGRVVzJhT1JEdVV6ajE0cG9RQWVVd0xlaEVvOUh2V001WW10RkxRMldUQmlR?=
 =?utf-8?B?TVg0NmNqWVRuSFdReEdyQWpjTUNhMmFZNFJVWVA4QnI4Mmo2L2pETjFNZGxp?=
 =?utf-8?Q?LAYwv6Vej6Yt+3c1+MjvbL3TV?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f2c9b6-b977-4030-4f56-08dc0066ca5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:47:46.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AtG0YuRDy/WgCbcmxms9svOX8+BWDZ/o0uR8NCEpi9R4AYijMwMAJ65Rf9FFPTj+sxQ+rIUG23Lmc7AvlXcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6689

Hello

I am trying to debug an illegal memory access problem for a kernel 
driver. The JTAG could trap the kernel function likes 
die_kernel_fault(). But it won't provide a context environment in the 
place where this bug happens.

I know such page fault is more like a software interrupter, is there a 
way that I could move my debugging context back?

Here is what I got from gdb connected to openocd.
(gdb) bt 

#0  __do_kernel_fault (addr=16045481047390945544, addr@entry=264, 
esr=2516582468, regs=0xffffff802937b940)
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:372 

#1  0xffffffc00802c174 in do_bad_area (regs=<optimized out>, 
esr=<optimized out>, far=16045481047390945544)
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:485 

#2  do_translation_fault (far=16045481047390945544, esr=<optimized out>, 
regs=<optimized out>)
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:782 

#3  0xffffffc00802c2cc in do_mem_abort (far=16045481047390945544, 
esr=2516582468, regs=0xffffff802937b940)
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:918 

#4  0xffffffc00889738c in skb_dump (level=0xdead000000000108 "", 
skb=0xffffff802937b940, full_pkt=112)
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/core/skbuff.c:834 

#5  0x0000000000000000 in ?? () 

Backtrace stopped: not enough registers or memory available to unwind 
further
(gdb) info threads
   Id   Target Id 
         Frame
   1    Thread 1 "vs640.cpu_a53.0" (Name: vs640.cpu_a53.0, state: 
debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff, 
protonum=0 '\000', fmt=0x258208 "")
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
* 2    Thread 2 "vs640.cpu_a53.1" (Name: vs640.cpu_a53.1, state: 
breakpoint)    __do_kernel_fault (
     addr=16045481047390945544, addr@entry=264, esr=2516582468, 
regs=0xffffff802937b940)
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:372
   3    Thread 3 "vs640.cpu_a53.2" (Name: vs640.cpu_a53.2, state: 
debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff, 
protonum=0 '\000', fmt=0x9f2270 "")
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
   4    Thread 4 "vs640.cpu_a53.3" (Name: vs640.cpu_a53.3, state: 
debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff, 
protonum=0 '\000', fmt=0x20ded8 "")
     at 
/Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62

And here is the issue I am trying to debug:
[ 5478.863161] Unable to handle kernel paging request at virtual address 
dead000000000108
[ 5478.871093] Mem abort info:
[ 5478.873886]   ESR = 0x96000044
[ 5478.876938]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 5478.882249]   SET = 0, FnV = 0
[ 5478.885301]   EA = 0, S1PTW = 0
[ 5478.888440]   FSC = 0x04: level 0 translation fault
[ 5478.893318] Data abort info:
[ 5478.896195]   ISV = 0, ISS = 0x00000044
[ 5478.900029]   CM = 0, WnR = 1
[ 5478.902996] [dead000000000108] address between user and kernel 
address ranges
[ 5478.910129] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[ 5478.915701] Modules linked in: vpu videobuf2_memops v4l2_mem2mem 
videobuf2_v4l2 videobuf2_common videodev mc synap(O)
  pvrsrvkm syna_drm cfg80211 rfkill amp_bm
[ 5478.929897] CPU: 0 PID: 6613 Comm: gst-launch-1.0 Tainted: G        W 
  O      5.15.62 #1
[ 5478.937988] Hardware name: Synaptics VS640 EVK (DT)
[ 5478.942864] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[ 5478.949825] pc : v4l2_m2m_buf_remove+0x50/0x90 [v4l2_mem2mem]
[ 5478.955582] lr : v4l2_m2m_buf_remove+0x20/0x90 [v4l2_mem2mem]
[ 5478.961329] sp : ffffff8026c4fa90
[ 5478.964643] x29: ffffff8026c4fa90 x28: ffffff8026c201b0 x27: 
0000000000000000
[ 5478.971784] x26: 0000000000000000 x25: ffffff8026c4fd28 x24: 
ffffff8009774270
[ 5478.978921] x23: ffffff8025f4c100 x22: 0000000000000001 x21: 
ffffff8025e1f3a0
[ 5478.986059] x20: ffffff8025e6d7b0 x19: ffffff8025e1f028 x18: 
0000000000000000
[ 5478.993197] x17: 0000000000000000 x16: 0000000000000000 x15: 
00000055a1955a10
[ 5479.000335] x14: 0000000000000000 x13: 0000000000000000 x12: 
0000000000000000
[ 5479.007472] x11: 0000000000000000 x10: 0000000000000000 x9 : 
0000000000000000
[ 5479.014609] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 
0000000000000005
[ 5479.021746] x5 : dead000000000100 x4 : dead000000000122 x3 : 
dead000000000100
[ 5479.028884] x2 : dead000000000122 x1 : 0000000000000000 x0 : 
ffffff8025e1f3a0
[ 5479.036021] Call trace:
[ 5479.038467]  v4l2_m2m_buf_remove+0x50/0x90 [v4l2_mem2mem]
[ 5479.043867]  vb2ops_vdec_stop_streaming+0x98/0x160 [vpu]
[ 5479.049184]  __vb2_queue_cancel+0x30/0x210 [videobuf2_common]
[ 5479.054936]  vb2_core_streamoff+0x20/0xb4 [videobuf2_common]
[ 5479.060597]  vb2_streamoff+0x18/0x64 [videobuf2_v4l2]
[ 5479.065654]  v4l2_m2m_streamoff+0x70/0x140 [v4l2_mem2mem]
[ 5479.071055]  v4l2_m2m_ioctl_streamoff+0x14/0x20 [v4l2_mem2mem]
[ 5479.076889]  v4l_streamoff+0x20/0x30 [videodev]
[ 5479.081455]  __video_do_ioctl+0x174/0x3d0 [videodev]

Sincerely
-- 
Hsia-Jun(Randy) Li

