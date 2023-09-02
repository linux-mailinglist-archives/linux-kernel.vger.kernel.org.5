Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A56790943
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjIBTAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIBTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:00:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D1219E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:00:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c93638322so32153466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693681214; x=1694286014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJG2v/tBrKXJAeh8f1wAGpImo/b6UiTOWlNfcbJr5Tk=;
        b=NVTMsLY8bARqE1pKckxXL8jyXbsiAiJ2h/Qn95jw2BYWUc7vdx99j+ayD3rsbQyBRF
         k/LrJXxiDc5a0QsExLRbJPlfwTWUXxr49HfP0NdvlwYQuqYF04BO0pdBmnQT9k108zal
         s3uajlsxkSB/F/Tvml0ZV2m+S0Ly9ALTIDHsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693681214; x=1694286014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJG2v/tBrKXJAeh8f1wAGpImo/b6UiTOWlNfcbJr5Tk=;
        b=Oqf6hmoDSKQyS40lNadCAWV1QRLwl9HDVomDSjMzN9T573N3aH8NdpLTYI7RGT0weK
         Z+8Lr7mFxO1ebGYb2fbYxyfKs87d+gZK2zJuJtVCHEUSPn47VHIlo4QNpPW2GsQEgvNV
         Fa8331XTGq4s5lSvbFjjzVyjbCgu7Mp9Jb82MecszWV+aCbHEJ9Ef/RcJ0zEP+RaPdNM
         z8ObjO8UcUZpZXtxEwBqVsaSzOWn9Jd7ZzRNs8pKjBVo4WL7RUGjHfoUsltAn6BHNaTP
         KuacQJ9iEeD48RH4rvycNRQJlZ2lpkdwnIYnHkhbEjg+GKTPUihx7mJbT0JuxZUubJ58
         UzMA==
X-Gm-Message-State: AOJu0YwOfMYgYrn2gQL75pRhWPZlR159SaizBdB41zZKsyYNLZCTkF8h
        21sBhj8nl5jRuqjGowgHsn2vJ9M6aYB6zLOayKX0QYUZ
X-Google-Smtp-Source: AGHT+IHKRIcxsesgLfB+LjFWNp+Erf1/y+2xvJModQVqdphfZ3uB4/4KJOK3A9FmQ6Heto38k8NNUA==
X-Received: by 2002:a17:906:10dc:b0:9a2:143e:a070 with SMTP id v28-20020a17090610dc00b009a2143ea070mr7065131ejv.20.1693681213853;
        Sat, 02 Sep 2023 12:00:13 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id gj17-20020a170906e11100b0098921e1b064sm3720921ejb.181.2023.09.02.12.00.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 12:00:13 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so318681a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:00:12 -0700 (PDT)
X-Received: by 2002:a05:6402:34d0:b0:51d:b184:efd with SMTP id
 w16-20020a05640234d000b0051db1840efdmr10020929edc.20.1693681212581; Sat, 02
 Sep 2023 12:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230901184136.73b2833e@xps-13>
In-Reply-To: <20230901184136.73b2833e@xps-13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Sep 2023 11:59:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
Message-ID: <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Changes for v6.6-rc1
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 09:42, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Core MTD changes:
> * Use refcount to prevent corruption
> * Call external _get and _put in right order
> * Fix use-after-free in mtd release
> * Explicitly include correct DT includes
> * Clean refcounting with MTD_PARTITIONED_MASTER
> * mtdblock: make warning messages ratelimited
> * dt-bindings: Add SEAMA partition bindings

Ok, so the above list isa fairly reasonable, but then:

> MTD device driver changes:
> * spear_smi: Use helper function devm_clk_get_enabled()
> * maps: fix -Wvoid-pointer-to-enum-cast warning
> * docg3: Remove unnecessary (void*) conversions
> * physmap-core, spear_smi, st_spi_fsm, lpddr2_nvm, lantiq-flash, plat-ram:
>   - Use devm_platform_get_and_ioremap_resource()
[...]

This is not a "summary of changes". The above is basically just a
re-organized shortlog.

What I want a merge message to be is to be an _overview_ of what the
merge brings in, and it's why I ask peopel to summarize what they have
worked on in the pull request.

But when the "summary" is just a list of every single detail, it's no
longer a summary. It doesn't give an overview of what has changed.
It's not useful to an outsider as a way to see "this is what the merge
brings in".

End result: I might as well just use "git shortlog", and it would
probably be about as readable as this is. In fact, I get the strong
feeling that this was auto-generated from something very much akin to
"git shortlog", just edited to combine multiple commits that just did
the same thing to several drivers.

Please - this is meant for *humans*. If it is just another form of
"git shortlog", then the automated version is *better*, because I can
use "git shortlog" to look at one particular driver (or a particular
set of drivers), so having a static version of "git shortlog" that has
been slightly munged to another format is actually _inferior_.

No, what the merge message should be is a general overview of "this is
the big picture". Not just a list of every single change, just by
sub-area.

For example, you list "Use devm_platform_get_and_ioremap_resource" not
just for individual drivers (nobody cares!), you do it *twice*,
because you've split up MTD drivers from raw NAND controller drivers.

And then you separately list "Use helper function
devm_clk_get_optional_enabled" from that list too, _and_ you then list
"Use devm_platform_ioremap_resource_byname()" for the brcm nand
driver.

Not to mention individually lising "Fix alignment with open
parenthesis" and "Fix the spacing" and "Fix wrong indentation" and
"Fix a typo" for the Qcom driver.

See why I'm frustrated? This has been going on for some time, but it's
gett9ing *worse*. This is absolutely ridiculous. I could try to make a
summary of it all, but honestly, now it feels like just complete
wasted time.

So I pulled this, looked at the "summary" in the fag, and decided that
it's just not worth it, and unpulled it.

Please give me a *summary* of what has changed. A list of *important&
things. Not a list of pointless typo fixes.

               Linus
