Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0D7E61B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 02:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjKIBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 20:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKIBIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 20:08:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B390211F;
        Wed,  8 Nov 2023 17:08:19 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SQkN45Xx2zfb3S;
        Thu,  9 Nov 2023 09:08:04 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 09:07:44 +0800
Subject: Re: [PATCH 02/22] [RESEND^2] jffs2: mark
 __jffs2_dbg_superblock_counts() static
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        <linux-kbuild@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        <linux-alpha@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-bcachefs@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-3-arnd@kernel.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cf3724db-e130-01f2-c41e-f2f1e88fc1a8@huawei.com>
Date:   Thu, 9 Nov 2023 09:07:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231108125843.3806765-3-arnd@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/11/8 20:58, Arnd Bergmann Ð´µÀ:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function is only called locally and does not need to be
> global. Since there is no external prototype, gcc warns about
> the non-static definition:
>
> fs/jffs2/debug.c:160:6: error: no previous prototype for '__jffs2_dbg_superblock_counts' [-Werror=missing-prototypes]
>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/jffs2/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
