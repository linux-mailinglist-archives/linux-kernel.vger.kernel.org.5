Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42267DC7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjJaH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJaH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:58:40 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D05A6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:58:33 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7082:5ab3:115b:c8d0])
        by andre.telenet-ops.be with bizsmtp
        id 4XyX2B00B1qcjVs01XyXnu; Tue, 31 Oct 2023 08:58:31 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qxjdv-007uIy-J3
        for linux-kernel@vger.kernel.org;
        Tue, 31 Oct 2023 08:58:31 +0100
Date:   Tue, 31 Oct 2023 08:58:31 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.6
In-Reply-To: <20231031074617.1637720-1-geert@linux-m68k.org>
Message-ID: <9ab0d979-dfa4-cea-a081-f1e74836daac@linux-m68k.org>
References: <CAHk-=wiZuU984NWVgP4snp8sEt4Ux5Mp_pxAN5MNV9VpcGUo+A@mail.gmail.com> <20231031074617.1637720-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.6[1] to v6.6-rc7[3], the summaries are:
>  - build errors: +12/-0

   + {standard input}: Error: displacement to undefined symbol .L101 overflows 12-bit field:  => 607
   + {standard input}: Error: displacement to undefined symbol .L103 overflows 8-bit field :  => 593
   + {standard input}: Error: displacement to undefined symbol .L107 overflows 8-bit field :  => 590
   + {standard input}: Error: displacement to undefined symbol .L140 overflows 8-bit field :  => 603
   + {standard input}: Error: displacement to undefined symbol .L149 overflows 8-bit field :  => 606
   + {standard input}: Error: displacement to undefined symbol .L73 overflows 12-bit field:  => 594
   + {standard input}: Error: displacement to undefined symbol .L74 overflows 8-bit field :  => 585
   + {standard input}: Error: displacement to undefined symbol .L76 overflows 12-bit field:  => 591
   + {standard input}: Error: displacement to undefined symbol .L77 overflows 8-bit field :  => 582
   + {standard input}: Error: displacement to undefined symbol .L81 overflows 8-bit field :  => 606
   + {standard input}: Error: pcrel too far: 932, 939, 940 => 595, 574, 577, 604, 598, 601

sh4-gcc1[13]/sh-allmodconfig (ICE, seen before)

   + {standard input}: Error: unknown pseudo-op: `.':  => 609

sh4-gcc11/sh-allmodconfig (ICE, seen before)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ffc253263a1375a65fa6c9f62a893e9767fbebfa/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1/ (238 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
