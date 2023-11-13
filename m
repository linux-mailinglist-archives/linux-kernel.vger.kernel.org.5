Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F204B7E99AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjKMKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjKMKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:02:15 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09418135
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:02:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:e81:b3d6:4f11:ac28])
        by albert.telenet-ops.be with bizsmtp
        id 9m292B0030WpEYl06m29vw; Mon, 13 Nov 2023 11:02:09 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r2Tlh-009BsO-30;
        Mon, 13 Nov 2023 11:02:09 +0100
Date:   Mon, 13 Nov 2023 11:02:09 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.7-rc1
In-Reply-To: <20231113093630.4164101-1-geert@linux-m68k.org>
Message-ID: <60ca157e-6eff-d12c-9dc0-8aeab125edda@linux-m68k.org>
References: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com> <20231113093630.4164101-1-geert@linux-m68k.org>
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

On Mon, 13 Nov 2023, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.7-rc1[1] compared to v6.6[2].
>
> Summarized:
>  - build errors: +20/-7
>  - build warnings: +24/-8
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b85ea95d086471afb4ad062012a4d73cd328fa86/ (238 out of 239 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ffc253263a1375a65fa6c9f62a893e9767fbebfa/ (all 239 configs)
>
>
> *** ERRORS ***
>
> 20 error regressions:
>  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_654' declared with attribute error: FIELD_PREP: value too large for the field:  => 435:38

powerpc-gcc5/powerpc-allyesconfig
drivers/edac/versal_edac.c: In function 'mc_probe':
num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);

>  + {standard input}: Error: displacement to undefined symbol .L100 overflows 8-bit field :  => 588
>  + {standard input}: Error: displacement to undefined symbol .L104 overflows 8-bit field :  => 588
>  + {standard input}: Error: displacement to undefined symbol .L105 overflows 8-bit field :  => 593
>  + {standard input}: Error: displacement to undefined symbol .L134 overflows 8-bit field :  => 598
>  + {standard input}: Error: displacement to undefined symbol .L72 overflows 12-bit field:  => 589
>  + {standard input}: Error: displacement to undefined symbol .L73 overflows 8-bit field :  => 580
>  + {standard input}: Error: displacement to undefined symbol .L75 overflows 12-bit field:  => 586, 589, 606
>  + {standard input}: Error: displacement to undefined symbol .L76 overflows 8-bit field :  => 577, 580
>  + {standard input}: Error: displacement to undefined symbol .L77 overflows 8-bit field : 582 => 607, 585
>  + {standard input}: Error: displacement to undefined symbol .L78 overflows 8-bit field :  => 610
>  + {standard input}: Error: displacement to undefined symbol .L80 overflows 8-bit field :  => 607, 601
>  + {standard input}: Error: displacement to undefined symbol .L81 overflows 8-bit field : 606 => 604, 610
>  + {standard input}: Error: displacement to undefined symbol .L96 overflows 12-bit field:  => 602
>  + {standard input}: Error: displacement to undefined symbol .L97 overflows 12-bit field:  => 607
>  + {standard input}: Error: displacement to undefined symbol .L98 overflows 12-bit field:  => 602
>  + {standard input}: Error: invalid operands for opcode:  => 612
>  + {standard input}: Error: missing operand:  => 612
>  + {standard input}: Error: pcrel too far: 601, 598, 604, 577, 595, 574 => 590, 598, 599, 577, 596, 569, 604, 610, 572, 593
>  + {standard input}: Error: unknown pseudo-op: `.l':  => 609

sh4-gcc1[123]/sh-all{mod,yes}config ICE

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
