Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2237BF49D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442562AbjJJHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442419AbjJJHmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:42:04 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1C9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:42:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8cb2:eea1:154:22ce])
        by baptiste.telenet-ops.be with bizsmtp
        id w7i02A0011pyQdZ017i01X; Tue, 10 Oct 2023 09:42:00 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qq7NP-005pWA-V2
        for linux-kernel@vger.kernel.org;
        Tue, 10 Oct 2023 09:41:59 +0200
Date:   Tue, 10 Oct 2023 09:41:59 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.6-rc5
In-Reply-To: <20231010073857.3517727-1-geert@linux-m68k.org>
Message-ID: <e4ecb44-5d7e-4774-1657-dc846e618d60@linux-m68k.org>
References: <CAHk-=wh7awamHE3ujoxZFcGMg3wvLTk8UZYSm3m7vUDhpmP2+A@mail.gmail.com> <20231010073857.3517727-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.6-rc5[1] to v6.6-rc4[3], the summaries are:
>  - build errors: +0/-1
>  - build warnings: +1/-0

>  + {standard input}: Warning: end of file not at end of a line; newline inserted:  => 943, 1094

In case anyone wonders: that's due to an ICE when building
sh4-gcc1[123]/sh-all{mod,yes}config.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94f6f0550c625fab1f373bb86a6669b45e9748b3/ (all 239 configs)

> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8a749fd1a8720d4619c91c8b6e7528c0a355c0aa/ (all 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
