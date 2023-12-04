Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E520B802C51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjLDHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDHsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:48:37 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF6CC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:48:41 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f143:dd2b:2cfe:eb7c])
        by andre.telenet-ops.be with bizsmtp
        id J7of2B00U5Tnyl2017ofko; Mon, 04 Dec 2023 08:48:40 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1rA3h1-00Atvi-SB;
        Mon, 04 Dec 2023 08:48:39 +0100
Date:   Mon, 4 Dec 2023 08:48:39 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.7-rc4
In-Reply-To: <20231203200454.396428-1-geert@linux-m68k.org>
Message-ID: <beef78b-ca1e-6f3-5bbb-b9e38e3a57b8@linux-m68k.org>
References: <CAHk-=wjsbytYq780PM-Wby_2rPabxg-WT-CRPZZaVYsmLiacHw@mail.gmail.com> <20231203200454.396428-1-geert@linux-m68k.org>
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

On Sun, 3 Dec 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.7-rc4[1] to v6.7-rc3[3], the summaries are:
>  - build errors: +6/-5

   + {standard input}: Error: displacement to undefined symbol .L105 overflows 8-bit field :  => 593
   + {standard input}: Error: displacement to undefined symbol .L140 overflows 8-bit field :  => 606
   + {standard input}: Error: displacement to undefined symbol .L76 overflows 12-bit field:  => 594
   + {standard input}: Error: displacement to undefined symbol .L97 overflows 12-bit field:  => 607
   + {standard input}: Error: pcrel too far: 610, 572, 590, 599, 593, 596, 569 => 596, 569, 593, 598, 610, 604, 572, 590, 599, 577
   + {standard input}: Error: unknown pseudo-op: `.l':  => 609

SH ICE crickets.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/33cc938e65a98f1d29d0a18403dbbee050dcad9a/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2cc14f52aeb78ce3f29677c2de1f06c0e91471ab/ (all 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
