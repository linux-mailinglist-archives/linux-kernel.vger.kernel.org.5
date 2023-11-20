Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617A47F1C66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjKTS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTS3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:29:20 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087B92
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:29:16 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6bd9:a79:1d00:5285])
        by laurent.telenet-ops.be with bizsmtp
        id CiVE2B00u0Wid3g01iVEGM; Mon, 20 Nov 2023 19:29:14 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r591G-009smt-DO;
        Mon, 20 Nov 2023 19:29:14 +0100
Date:   Mon, 20 Nov 2023 19:29:14 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.7-rc2
In-Reply-To: <20231120163923.3778033-1-geert@linux-m68k.org>
Message-ID: <29ec93f8-c23d-7a35-fbb2-40f9755da917@linux-m68k.org>
References: <CAHk-=wj6j3U5r8ixVf_RQXwRYD03DuEqnX2ZsfYwvB-9YxQNLA@mail.gmail.com> <20231120163923.3778033-1-geert@linux-m68k.org>
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

On Mon, 20 Nov 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.7-rc2[1] to v6.7-rc1[3], the summaries are:
>  - build errors: +11/-0

   + {standard input}: Error: displacement to undefined symbol .L101 overflows 8-bit field :  => 593
   + {standard input}: Error: displacement to undefined symbol .L105 overflows 8-bit field : 593 => 593, 590
   + {standard input}: Error: displacement to undefined symbol .L135 overflows 8-bit field :  => 603
   + {standard input}: Error: displacement to undefined symbol .L139 overflows 8-bit field :  => 606
   + {standard input}: Error: displacement to undefined symbol .L73 overflows 12-bit field:  => 594
   + {standard input}: Error: displacement to undefined symbol .L74 overflows 8-bit field :  => 585
   + {standard input}: Error: displacement to undefined symbol .L76 overflows 12-bit field: 594 => 594, 591
   + {standard input}: Error: displacement to undefined symbol .L77 overflows 8-bit field : 607, 585 => 607, 585, 582
   + {standard input}: Error: displacement to undefined symbol .L81 overflows 8-bit field : 610, 604 => 606, 610, 604
   + {standard input}: Error: displacement to undefined symbol .L99 overflows 12-bit field:  => 607
   + {standard input}: Error: pcrel too far: 577, 569, 598, 596, 599, 590, 604, 593, 610, 572 => 596, 569, 577, 601, 610, 572, 604, 590, 599, 598, 593, 595, 574

More sh4 ICE casualties.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98b1cc82c4affc16f5598d4fa14b1858671b2263/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b85ea95d086471afb4ad062012a4d73cd328fa86/ (238 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
