Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6049F7910D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbjIDFY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjIDFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:24:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B310E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 22:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7epJHJFkUWzOkM9q6PmOOnfOfKh9ZNMN71z7U+OVBgkAhSRXcRzMnGJ93w1AOTF93R56pGYxbKmpK/Aj8fV3jZEaCWQTzntlhRPqPwtq5tJLp21jORRrANnim+ojngGyHd78sdCJjCuKobjV5yCJIXPEvEQ5ELo2X8jz3Xm7Rczhxx1sRKZxscQoNdCWz1mOs9LAH6K+Og2BeL4zj7+elLHjMvP0FI3cg3yjLZErSr4HG58yXGTnnZAhmUzB05HQ1wuUGZW5JBLBsWWsG5yKexxsa7nSS1QofT3U7hJyJkVemOlWaBtG2gabz5a0FyeZhY28+w5dXKjBkKUn/4AfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxV4p/BQQKUi1Y99PX52ZGs4QUZ/it7kHpxfr5ZskrM=;
 b=gUvgaKJlQt4tIYYQ8G1/7l1yUHSey0YTGKmFjUNbLYZYM/9tqN+UwjIyq+PSLYKkepP2/AF2gfYE+M+KmLo54wMGEJ0jHGgdQDbnqc7KATzTR48JIdOutqYBrg7XQi056gNsjbqm0F8NzjTcUpOKrTuu5YkxlTna3HrosSogh7Aqn3a+OSpwQyQXdG0Wxlro0AhQwCPu3YXFae0EXg7A8F0GMWYalLiXzoWY0oUviHguGN0ekdr44cOrFa2jzqhwEjb0k+ORqdr8BwJ+PbMHvRCl6XjKI/k3saY4sT1PVEb0bbF1MA06JaOUddLgPp7ntAq4wW6zVJEKz1mzKydrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=de.bosch.com; dmarc=pass (p=reject sp=none pct=100) action=none
 header.from=de.bosch.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxV4p/BQQKUi1Y99PX52ZGs4QUZ/it7kHpxfr5ZskrM=;
 b=KEmeuIP6YnuxzwiG1UWEwXZeP5U2mgwPgbajsLV/r4xpTEneXkH7BD15SXItemEV/Md+rBMZtrFLyq/O0x45VBpvMQsUlJ50ZFrmchxWqKbscMakJddfzCJnLg1/1Tro6r8Sf5RbpyCYrVPXOeicum9MPajFLwx/37/ZoVPfdQTny6GcQ3ndQaSfjcsviH4dSKI1BL7SPfRcB82x24tFvMaVw01aIuZ1ikgTLU3MSH2pV6Ko4jl1/MmUskgBVX16JMsI3F2m+tcSaAlDqsF4tT4n6hHvFWo9IhzniEMYJKvggeBgNGm3q/5XScIDGfJ1jQyGEZKTJB9ZKGIY8+gKxA==
Received: from DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) by PAWPR10MB6854.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:33a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 05:24:20 +0000
Received: from DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3c3:cafe::99) by DUZPR01CA0014.outlook.office365.com
 (2603:10a6:10:3c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 05:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.200) by
 DBAEUR03FT021.mail.protection.outlook.com (100.127.142.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.23 via Frontend Transport; Mon, 4 Sep 2023 05:24:20 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 07:24:20 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Mon, 4 Sep 2023 07:24:20 +0200
Received: from [10.34.222.178] (10.34.222.178) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2507.31; Mon, 4 Sep 2023
 07:24:19 +0200
Message-ID: <cad171ca-dc61-21d9-3a88-08fc85af6d73@de.bosch.com>
Date:   Mon, 4 Sep 2023 07:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4.14 03/62] arm64: kprobe: make page to RO mode when
 allocate it
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181126105051.213025360 () linuxfoundation ! org>
Content-Language: en-US
CC:     Dirk Behme <dirk.behme@de.bosch.com>
From:   "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
In-Reply-To: <20181126105051.213025360 () linuxfoundation ! org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.222.178]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT021:EE_|PAWPR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e5a310-8c0b-4fcf-b8f3-08dbad073148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 341U3WlirUNEwIw64uJHd5B269vlI9epM8LHy3sbJHchFfBH6DMHzpZJKt7nXeF9L1RZuPVFGbCbzyd9YsCEyhpvDzQodLSQDjKzKb8M4Hkk1hDt2azEmhw6fnCnoW7BRxSB7LxWQX8x4WPIUGRFGQV+E2hWCurzNKviRkTDHcfruq1kvBWyIdGOQUqMSMwheFU09idcgaLI4Ez80nqJMM9+ytkd3lEaeT8cE1EiCTVWQ4czHtfZdZM+6gbSe2KRBhFAn1CFMd+w+Ea2uiL8hOgEgdy1IKH8ScW4QFKhpDbelA5HqMTaR8CuvuqaNwF+emCkJXI8NEcNqIW1ZhgucjCbezUrZTz0LKzsC7PLuzpv9WxSNvWeSrNc14WCOTuYJ487n2QlsUlBfal8TsHBC39Jdu/2GR+GjZRECX81wQq44SLDADL83yc45428Zk/j7P6PRoYXaHQma6w7ekwDj5dwdmI6oZRtfAURglkz2XsBYBmyekNgGz75bFvprZDcuDXbysuUnS7zXFf9h4WnoY+giWL1ppLTnwKLn6GWpvp6ve+LJ9VbsUxDD3Sdw7G6lilO51jH2Y6Luy7spUc8sFR25CODoEWRYBw9TrL84OS0jHqmvAzAr89Q6FojOJghQ5TWbwHy5vAJoh8zSsnJLTy0QAF+qv/KWucoN4EV+eOw0KkDFkYRDDusUivW7xhQWRCBGZkF7BJyOkf2m6ztBX0clamTiGP17nu3TdXhIov5wmkUDdqYrzYzGkXf9IFRRlnMx0aC5tvK6W+7CdGiYugxPNVzLbCY9n95yKSf4hopLbebmxV75jVP0dUGh6e4XdYlkwneGZ3OoDN0DtsLX4HApGCC0PtzOJzCPSSNsGUOOXcDuGP1vzPvwcUNZh0+
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(31686004)(70206006)(70586007)(110136005)(2906002)(16576012)(86362001)(31696002)(316002)(40480700001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(40460700003)(107886003)(47076005)(2616005)(83380400001)(426003)(336012)(16526019)(26005)(36860700001)(966005)(478600001)(81166007)(356005)(45080400002)(82960400001)(82740400003)(53546011)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 05:24:20.5189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e5a310-8c0b-4fcf-b8f3-08dbad073148
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6854
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.11.2018 11:50, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.


It looks like that this patch which was back ported from v4.20 to 
v4.14.100 needs the '__weak' on kernel/kprobes.c alloc_insn_page() from 
v4.15 commit

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63fef14fc98a8b4fad7

to make alloc_insn_page() being used properly.

But that '__weak' from 63fef14fc98a8b4fad7 was not back ported to 
v4.14.x and is missing in v4.14.x ?

Best regards

Dirk


> ------------------
> 
> [ Upstream commit 966866892cf89d606544bca22d584ba2ef9ec208 ]
> 
> Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
> has successfully identified code that leaves a page with W+X
> permissions.
> 
> [    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval____)/0xffff000000d90000
> [    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_page+0x410/0x420
> [    3.246141] Modules linked in:
> [    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-20180928-00001-ge70ae259b853-dirty #62
> [    3.247008] Hardware name: linux,dummy-virt (DT)
> [    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    3.247623] pc : note_page+0x410/0x420
> [    3.247898] lr : note_page+0x410/0x420
> [    3.248071] sp : ffff00000804bcd0
> [    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
> [    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
> [    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
> [    3.249109] x23: 0000000000000004 x22: ffff000000d91000
> [    3.249396] x21: ffff000000d90000 x20: 0000000000000000
> [    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
> [    3.249924] x17: 0000000000000000 x16: 0000000000000000
> [    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
> [    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
> [    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
> [    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
> [    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
> [    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
> [    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
> [    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
> [    3.252664] Call trace:
> [    3.252953]  note_page+0x410/0x420
> [    3.253186]  walk_pgd+0x12c/0x238
> [    3.253417]  ptdump_check_wx+0x68/0xf8
> [    3.253637]  mark_rodata_ro+0x68/0x98
> [    3.253847]  kernel_init+0x38/0x160
> [    3.254103]  ret_from_fork+0x10/0x18
> 
> kprobes allocates a writable executable page with module_alloc() in
> order to store executable code.
> Reworked to that when allocate a page it sets mode RO. Inspired by
> commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()").
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> [catalin.marinas@arm.com: removed unnecessary casts]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 22a5921562c7..0417c929d21a 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -23,7 +23,9 @@
>   #include <linux/slab.h>
>   #include <linux/stop_machine.h>
>   #include <linux/sched/debug.h>
> +#include <linux/set_memory.h>
>   #include <linux/stringify.h>
> +#include <linux/vmalloc.h>
>   #include <asm/traps.h>
>   #include <asm/ptrace.h>
>   #include <asm/cacheflush.h>
> @@ -42,10 +44,21 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>   static void __kprobes
>   post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>   
> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> +{
> +	void *addrs[1];
> +	u32 insns[1];
> +
> +	addrs[0] = addr;
> +	insns[0] = opcode;
> +
> +	return aarch64_insn_patch_text(addrs, insns, 1);
> +}
> +
>   static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>   {
>   	/* prepare insn slot */
> -	p->ainsn.api.insn[0] = cpu_to_le32(p->opcode);
> +	patch_text(p->ainsn.api.insn, p->opcode);
>   
>   	flush_icache_range((uintptr_t) (p->ainsn.api.insn),
>   			   (uintptr_t) (p->ainsn.api.insn) +
> @@ -118,15 +131,15 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>   	return 0;
>   }
>   
> -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> +void *alloc_insn_page(void)
>   {
> -	void *addrs[1];
> -	u32 insns[1];
> +	void *page;
>   
> -	addrs[0] = (void *)addr;
> -	insns[0] = (u32)opcode;
> +	page = vmalloc_exec(PAGE_SIZE);
> +	if (page)
> +		set_memory_ro((unsigned long)page, 1);
>   
> -	return aarch64_insn_patch_text(addrs, insns, 1);
> +	return page;
>   }
>   
>   /* arm kprobe: install breakpoint in text */

