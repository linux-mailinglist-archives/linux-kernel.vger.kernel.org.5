Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484D780B18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376650AbjHRL0v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 07:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376643AbjHRL0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:26:17 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD83ABB;
        Fri, 18 Aug 2023 04:26:16 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso800722276.0;
        Fri, 18 Aug 2023 04:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692357975; x=1692962775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeC3ZxHNnvzMtdmJIeRJx7ZK5zVDXKI5axuQ44iEWnw=;
        b=iNJnc7+q11XjiWZJLeRKusOHyX6srZR30fVCjfBMLMu3SxybUF1nSFzncqA9nha1Zc
         DkK/ES3Efzzu+wkZbkXgPGEzOz6aRiLKCo79O819nf/2F2CGxwtZsvjzFqgYpt9yl/4r
         +bVNbs6Cw8u4iByh+l4fL0kMXTd8e/dQKOomZGQOjUleVQVdyY8VslIsqPTJJ55otvQ8
         7u9ztHHJ004Itpnbdd1xEIqH+lLAffHJ05OD02MAu7+TelLH1DKiTdhaCNr78qBN70fc
         mJkM7rntv18ngOujLKtGb5ehpDvr5Osz1a13OCsT/DqdWJJ90Mjj32THlVNxTpeX0MZN
         loTQ==
X-Gm-Message-State: AOJu0YwH939vio7KiHV2xa+61IUbAWYSBADfnhXV4qgoqU+5wy3ZlpIu
        DWIG/7anp3LnkLWjY3iBZLav0WuOSFA2R1cg
X-Google-Smtp-Source: AGHT+IFSwSNvcdSXIbRr7YwPulfPhNV7X8KnyQdM3GMLGkr+BI5PzooAyAt7Knx7/iAd5P/VKO6eAg==
X-Received: by 2002:a25:2d0d:0:b0:d0e:6c9b:b9f2 with SMTP id t13-20020a252d0d000000b00d0e6c9bb9f2mr2508204ybt.12.1692357975558;
        Fri, 18 Aug 2023 04:26:15 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id z1-20020a25ad81000000b00c5fc63686f1sm377159ybi.16.2023.08.18.04.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 04:26:14 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d682d2d1f0dso791226276.1;
        Fri, 18 Aug 2023 04:26:14 -0700 (PDT)
X-Received: by 2002:a25:8502:0:b0:d4e:3ffe:79d4 with SMTP id
 w2-20020a258502000000b00d4e3ffe79d4mr2025862ybk.61.1692357974442; Fri, 18 Aug
 2023 04:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230818160837.147b1e2e@canb.auug.org.au>
In-Reply-To: <20230818160837.147b1e2e@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 13:26:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQFYZS8qACEsaZvMEuvrVY3Ag0pJBi1SE6Kkj8tTMbrg@mail.gmail.com>
Message-ID: <CAMuHMdWQFYZS8qACEsaZvMEuvrVY3Ag0pJBi1SE6Kkj8tTMbrg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl-renesas tree with the
 pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Aug 18, 2023 at 8:08 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the pinctrl-renesas tree got conflicts in:
>
>   drivers/pinctrl/renesas/pinctrl-rza2.c
>   drivers/pinctrl/renesas/pinctrl-rzg2l.c
>   drivers/pinctrl/renesas/pinctrl-rzv2m.c
>
> between commit:
>
>   060f03e95454 ("pinctrl: Explicitly include correct DT includes")
>
> from the pinctrl tree and commits:
>
>   848f700dabda ("pinctrl: renesas: rzg2l: Fix NULL pointer dereference in rzg2l_dt_subnode_to_map()")
>   ca63f2ef6a16 ("pinctrl: renesas: rzv2m: Fix NULL pointer dereference in rzv2m_dt_subnode_to_map()")
>   1eb1e00e5d99 ("pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}")
>
> from the pinctrl-renesas tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The resolution LGTM. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
