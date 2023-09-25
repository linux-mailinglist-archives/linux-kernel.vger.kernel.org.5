Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD137AD723
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjIYLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:43:18 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1793DA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:43:11 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ee18:727e:6235:2ac2])
        by baptiste.telenet-ops.be with bizsmtp
        id qBj82A00H4XpEKH01Bj80h; Mon, 25 Sep 2023 13:43:09 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qkjzY-004Xre-MD;
        Mon, 25 Sep 2023 13:43:08 +0200
Date:   Mon, 25 Sep 2023 13:43:08 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.6-rc3
In-Reply-To: <20230925113220.3627083-1-geert@linux-m68k.org>
Message-ID: <687a5a25-65c4-f571-6626-2fdf9e843415@linux-m68k.org>
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com> <20230925113220.3627083-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.6-rc3[1] to v6.6-rc2[3], the summaries are:
>  - build errors: +11/-4

   + error: modpost: ".L872" [drivers/mtd/nand/raw/nand.ko] undefined!:  => N/A

parisc-gcc13/parisc-allmodconfig (seen before)

   + error: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!:  => N/A

sparc64-gcc{5,11,12,13}/sparc-allmodconfig (seen before)

   + {standard input}: Error: expected comma after name `xpcs_co' in .size directive:  => 1100

sh4-gcc1[12]/sh-all{mod,yes}config (ICE)

   + {standard input}: Error: pcrel too far:  => 932, 940, 939

sh4-gcc1[12]/sh-allyesconfig (ICE)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6465e260f48790807eef06b583b38ca9789b6072/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ce9ecca0238b140b88f43859b211c9fdfd8e5b70/ (237 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
