Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8879B0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbjIKV6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjIKJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:02:14 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B5CD1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:02:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a989:d413:f41f:af52])
        by michel.telenet-ops.be with bizsmtp
        id kZ232A00443UkUk06Z23Pa; Mon, 11 Sep 2023 11:02:03 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qfcnz-002zLZ-1W;
        Mon, 11 Sep 2023 11:02:03 +0200
Date:   Mon, 11 Sep 2023 11:02:03 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: stats (Was: Linux 6.6-rc1)
In-Reply-To: <20230911123839.7ab72f81@canb.auug.org.au>
Message-ID: <2b3f3296-5263-1746-1f4-d0ad95a52922@linux-m68k.org>
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com> <20230911123839.7ab72f81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Stephen,

On Mon, 11 Sep 2023, Stephen Rothwell wrote:
> There are also 275 commits in next-20230828 that didn't make it into
> v6.6-rc1.

> Top ten commiters:
>
>     11 geert+renesas@glider.be

Thanks for your report!

I had a look, and this was caused due to me rebasing
renesas-dts-for-v6.6 on top of renesas-fixes-for-v6.5, but forgetting to
recreate renesas/next afterwards (there were no conflicts).  So all
eleven commits did make it upstream.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
