Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87D7BB304
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJFIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjJFIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:24:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C58FD;
        Fri,  6 Oct 2023 01:24:51 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qog8g-0002lZ-00; Fri, 06 Oct 2023 10:24:50 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2F811C01D1; Fri,  6 Oct 2023 10:21:15 +0200 (CEST)
Date:   Fri, 6 Oct 2023 10:21:15 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3] MIPS: loongson32: Remove dma.h and nand.h
Message-ID: <ZR/De/IBKIlhoiwM@alpha.franken.de>
References: <20230830133505.505597-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830133505.505597-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:35:05PM +0800, Keguang Zhang wrote:
> Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
> unused platform devices"), struct plat_ls1x_dma and plat_ls1x_nand
> are unused. Then, dma.h and nand.h are useless.
> Therefore, remove these useless header files.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> V2 -> V3: Fix the build error
>           Add Reviewed-by tag from Philippe Mathieu-Daudé
> V1 -> V2: Remove include of dma.h and nand.h
>           Update the commit message
> ---
>  arch/mips/include/asm/mach-loongson32/dma.h   | 21 ---------------
>  arch/mips/include/asm/mach-loongson32/nand.h  | 26 -------------------
>  .../include/asm/mach-loongson32/platform.h    |  3 ---
>  arch/mips/loongson32/common/platform.c        |  2 --
>  arch/mips/loongson32/ls1b/board.c             |  2 --
>  5 files changed, 54 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
