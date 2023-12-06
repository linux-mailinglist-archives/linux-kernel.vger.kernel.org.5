Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E797F80667A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376653AbjLFFY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLFFYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:24:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3918F;
        Tue,  5 Dec 2023 21:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=lZ2UgRJ3Sw4WhX4GoZHj0/NduZqoHx50OdQhr/vE2RU=; b=g016Z3O7sV5wh9rdHujNjwMFg/
        hsPX5bk0FpVx3zDLeKY7ST3i7IqtXbLD1OO4Xlc0YPw/899LffHKP8pPtiK0nclTOv+xn4NnYG1zX
        4HoK7UfwzpQ0qGO73tmtE6BAzTrLUG4izsfrg2eItskVsJYFuZBbYdeU8PQSkL2s/THvbKnJHpHSQ
        T6PvgiEzGkITyb6LjKbLqgkx0GouxWdPmh5PuGKDWWqjjpezkZ/2U+1fGfYusckEnm27vefz6zdUH
        Mr/HI6DPaWcqT4QqCYlPUTU2BrEOBbhHSf+7KbQsYx01GS4fw+Ya5M5SqKN6XMPgN7K/0NGrFgGAc
        hpY8m3hA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAkOP-0095nD-39;
        Wed, 06 Dec 2023 05:24:18 +0000
Message-ID: <5f1caaf8-1edf-444a-b017-c4d08e52213b@infradead.org>
Date:   Tue, 5 Dec 2023 21:24:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pm.c:undefined reference to `i8042_command'
To:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
References: <202312041909.lwhcU35R-lkp@intel.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202312041909.lwhcU35R-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 12/4/23 04:02, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
> commit: 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
> date:   1 year, 6 months ago
> config: mips-randconfig-r001-20211012 (https://download.01.org/0day-ci/archive/20231204/202312041909.lwhcU35R-lkp@intel.com/config)
> compiler: mips64el-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312041909.lwhcU35R-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312041909.lwhcU35R-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mips64el-linux-ld: arch/mips/loongson2ef/lemote-2f/pm.o: in function `setup_wakeup_events':
>>> pm.c:(.text+0x118): undefined reference to `i8042_command'
>>> mips64el-linux-ld: pm.c:(.text+0x154): undefined reference to `i8042_command'


How do we feel about this?
I suppose that an ARCH or mach or board should know what it requires.


---
 arch/mips/loongson2ef/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff -- a/arch/mips/loongson2ef/Kconfig b/arch/mips/loongson2ef/Kconfig
--- a/arch/mips/loongson2ef/Kconfig
+++ b/arch/mips/loongson2ef/Kconfig
@@ -40,6 +40,9 @@ config LEMOTE_MACH2F
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select INPUT
+	select SERIO
+	select SERIO_I8042
 	select BOARD_SCACHE
 	select BOOT_ELF32
 	select CEVT_R4K if ! MIPS_EXTERNAL_TIMER


-- 
~Randy
