Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B918C7CA090
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJPH0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjJPH0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:26:48 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43167E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:26:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:441e:d899:20f9:b692])
        by baptiste.telenet-ops.be with bizsmtp
        id yXSj2A00K0qPBYQ01XSjS7; Mon, 16 Oct 2023 09:26:43 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsHzv-006iJW-HK;
        Mon, 16 Oct 2023 09:26:43 +0200
Date:   Mon, 16 Oct 2023 09:26:43 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.6-rc6
In-Reply-To: <20231016070610.677494-1-geert@linux-m68k.org>
Message-ID: <f895f03-9661-9bd0-c112-84bc73df5057@linux-m68k.org>
References: <CAHk-=whRt+O3rYh+0CxR7AbZVrEFgfTLubR9fLVxRpe9GGvB8g@mail.gmail.com> <20231016070610.677494-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.6-rc6[1] to v6.6-rc5[3], the summaries are:
>  - build errors: +14/-0

   + {standard input}: Error: displacement to undefined symbol .L100 overflows 12-bit field:  => 602
   + {standard input}: Error: displacement to undefined symbol .L101 overflows 12-bit field:  => 607
   + {standard input}: Error: displacement to undefined symbol .L102 overflows 8-bit field :  => 588
   + {standard input}: Error: displacement to undefined symbol .L103 overflows 8-bit field :  => 593
   + {standard input}: Error: displacement to undefined symbol .L149 overflows 8-bit field :  => 606
   + {standard input}: Error: displacement to undefined symbol .L72 overflows 12-bit field:  => 589
   + {standard input}: Error: displacement to undefined symbol .L73 overflows 12-bit field:  => 594
   + {standard input}: Error: displacement to undefined symbol .L73 overflows 8-bit field :  => 580
   + {standard input}: Error: displacement to undefined symbol .L74 overflows 8-bit field :  => 585
   + {standard input}: Error: displacement to undefined symbol .L77 overflows 8-bit field :  => 607
   + {standard input}: Error: displacement to undefined symbol .L78 overflows 8-bit field :  => 610

sh4-gcc11/sh-all{mod,yes}config

   + {standard input}: Error: missing operand:  => 612

   sh4-gcc11/sh-allyesconfig

   + {standard input}: Error: pcrel too far: 933, 934 => 598, 572, 593, 936, 604, 937, 577, 599

sh4-gcc12/sh-allmodconfig
sh4-gcc11/sh-all{mod,yes}config

   + {standard input}: Error: unknown pseudo-op: `.':  => 609

sh4-gcc11/sh-allmodconfig

All of the above are caused by ICEs, so nihil novum sub sole.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/58720809f52779dc0f08e53e54b014209d13eebb/ (237 out of 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94f6f0550c625fab1f373bb86a6669b45e9748b3/ (all 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
