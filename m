Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960C476A265
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGaVEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGaVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:04:06 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5419A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:04:05 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34915ceb5eeso5708775ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690837445; x=1691442245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSe1ZOsvUaEUkylcN4Nkaw95kMb4v99DyB9WwxbNQTg=;
        b=JQGDZ+thLT8NjZ1KxDzhK8+y9nhdzcH3k0e/xQipS4AtwE6XSANoW6rpqiS4xc1+lU
         5tWtBrdDkdpiA/ywcRr57xw/8xwZ9vKWCTqwEyVssFxWCPXxtiDhNdy/oj9DpeU/7aLC
         hPdOfgEeazfmOYIOlC4p/gJ+3Qi+1v7a5biTDSpWeQw8F2frggkoO2INo6uniblBrfbA
         BzVnq6xJ4Ty+v+zV/zOCE2s/h1AqbuoLQPJAk/BExhLOjn54zogYXHCQeOug1L1a+ItC
         SLb91TfvAppSlhbZZluh80G9hjRW3ImV8Lfh03SxAqCHu0k0lC6sOoRextFIhLbDwzcb
         hldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837445; x=1691442245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSe1ZOsvUaEUkylcN4Nkaw95kMb4v99DyB9WwxbNQTg=;
        b=hwhGbLj1rUhzbRCj1Ldu0hgYdjUrarovLt3csmxlcvGeXSxZuWZaX2TY0bMCfMvgZq
         BeN6s0tPImfQNMR9nXKOcOeN2L4qv5Q+SRzpuu66WscZ8KfShr3E6xzSp0BT+xy53C2K
         BCs2HgvRTmQ0AysFiWtODU2kohyaewFJKKMgJmKZDkannM/ny2DK6tjsfUZ8GZsr25f4
         c7OMOdIwMfrv65gZb5rOyeTEP4gPhPgTYZyqBBnlbw0cCDlc+DHvhmtUEOO2X8s2VKTx
         HFsIAlUN+vxHuUm4Mg0aucmy7hlVjxY4J3I0x6dUINmCB8q5ReyXe6gWRyhqqXjjzjNZ
         njOg==
X-Gm-Message-State: ABy/qLZfEuGYbjcLs0BAACKUYF5FWhbRuoFX3v/d8nJEJNdtIF6X/ezP
        gtpPuV3HTGBOrWdWa1mdbNg=
X-Google-Smtp-Source: APBJJlFH4EMtsYzgTHD56CE/Wo+BDSYdCN3mjWpmMdz4qMjZ5nMPTLxgxSKdvW5muIxkpb9AXhXfTQ==
X-Received: by 2002:a05:6e02:1aa3:b0:345:66f5:3404 with SMTP id l3-20020a056e021aa300b0034566f53404mr11134182ilv.0.1690837444715;
        Mon, 31 Jul 2023 14:04:04 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id b20-20020a637154000000b005634343cd9esm8588111pgn.44.2023.07.31.14.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:04:04 -0700 (PDT)
Date:   Mon, 31 Jul 2023 14:04:02 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [GIT PULL] bitmap: fixes for v6.5-rc5
Message-ID: <ZMghwgp2/P/WIn5h@yury-ThinkPad>
References: <ZMgg6OhBN4GzrYyA@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgg6OhBN4GzrYyA@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, accidentally dropped CC section.)

On Mon, Jul 31, 2023 at 02:00:27PM -0700, Yury Norov wrote:
> Hi Linus,
> 
> Please pull bitmap fixes for v6.5-rc5.
> 
> The 2nd patch in the series fixes (workarounds) build for CLANG+GCOV+KASAN
> configuration, so I believe it's worth to merge it in current merging cycle.
> 
> The patches spent for ~2 weeks in -next with no issues.
> 
> Thanks,
> Yury
> 
> The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:
> 
>   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com:/norov/linux.git tags/bitmap-6.5-rc5
> 
> for you to fetch changes up to 2356d198d2b4ddec24efea98271cb3be230bc787:
> 
>   lib/bitmap: workaround const_eval test build failure (2023-07-18 13:25:37 -0700)
> 
> ----------------------------------------------------------------
> bitmap fixes for v6.5
> 
>  - Fix for bitmap documentation;
>  - Fix for kernel build under certain configuration.
> 
> ----------------------------------------------------------------
> Randy Dunlap (1):
>       cpumask: eliminate kernel-doc warnings
> 
> Yury Norov (1):
>       lib/bitmap: workaround const_eval test build failure
> 
>  include/linux/cpumask.h | 8 ++++++--
>  lib/Makefile            | 6 ++++++
>  lib/cpumask.c           | 5 ++++-
>  lib/test_bitmap.c       | 8 ++++----
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
