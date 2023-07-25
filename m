Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56B07622EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGYUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGYUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:04:36 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A9128
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:04:35 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 987A7170D81;
        Tue, 25 Jul 2023 22:04:31 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1690315471; bh=v6vWD2JWeY3h5eKwB7YTy6cdcr65Rp6VaKVLa8L8fZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dL1Hx7qxHsXNIE2e6RX3MKuHhRQrhoIa3VT9kXLYwDhCdP2cGAmLymK7i8dQqgFrA
         6p5GIKy1TRvaTtjRRzyMPrIJC8q3/3G3eU2mkRcUGUM4yHLPoPR+Zrii83mZvgX9Gk
         Tcp9/dGDqOhD248XE6iSwINqfHA1zSNW91OnNrqfXqquvz7f/KlRe0ig6K19oxN4hS
         ZpQ5QBqveIcBWX2+Urhu7Bl2UyHTbNMNOeO6YK8VO2PhxT325/gebmdIeUdamTnpoe
         jDJ1QLWVPDWqw5pT4a/8GY5eg7/FCeFDF8IxfBwBnJ8TjTB1TgQt8y0JiW6ySspSWg
         8bQrwATt/+lxQ==
Date:   Tue, 25 Jul 2023 22:04:30 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alyssa Ross <hi@alyssa.is>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v1 3/3] riscv/purgatory: do not link with string.o
Message-ID: <20230725220430.22de806b@meshulam.tesarici.cz>
In-Reply-To: <202307260325.E3Uh9dYf-lkp@intel.com>
References: <a083f38c7c3acd6ac9542228e36947be30b58188.1690274483.git.petr.tesarik.ext@huawei.com>
        <202307260325.E3Uh9dYf-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 03:36:39 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Petr,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on kees/for-next/pstore]
> [also build test ERROR on kees/for-next/kspp linus/master v6.5-rc3 next-20230725]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Tesarik/riscv-kexec-handle-R_RISCV_CALL_PLT-relocation-type/20230725-165116
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
> patch link:    https://lore.kernel.org/r/a083f38c7c3acd6ac9542228e36947be30b58188.1690274483.git.petr.tesarik.ext%40huawei.com
> patch subject: [PATCH v1 3/3] riscv/purgatory: do not link with string.o
> config: riscv-randconfig-r001-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260325.E3Uh9dYf-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260325.E3Uh9dYf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307260325.E3Uh9dYf-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: memcmp  
>    >>> referenced by ctype.c
>    >>>               arch/riscv/purgatory/purgatory.ro:(purgatory)  

Ah, I see... In my build, it was inlined by gcc (GCC-13), but I cannot
rely on that. Too bad...

OTOH I don't think it's worth implementing full support for GOT,
especially for functions that are not needed. I would rather either
write a RISC-V implementation of memcmp(), or split memcmp() from
lib/string.c.

Stay tuned for v2.

Petr T
