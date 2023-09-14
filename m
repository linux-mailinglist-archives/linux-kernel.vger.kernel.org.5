Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6279FE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjINImR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjINImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:42:16 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291091;
        Thu, 14 Sep 2023 01:42:12 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59bbdb435bfso7884857b3.3;
        Thu, 14 Sep 2023 01:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680931; x=1695285731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt1d7x2jEDiyKRRaW6VzepfhDR5PRb6XJnF6WiN9Kfg=;
        b=Y2EKMkwYRkbJVBSnL7eMtOebjKyx1nVensbYz4yzG08bUUvC9haDKGo9/9hSzH/TzX
         FbPVyZzUGBqIZwfiWY8bZFOC8jLlYKXAhDu88bgdICTE8VgAhn+qaT4FrJCLGGyMC/lM
         sSPorCvk1kSPzIU2/r4kU+7aprodAT350VxgfitjaLQYFrbna5n4lU6CyXxCDzpwaxuK
         S8FGavfVXSRUmbOPKCXqrJklt2UdDn64m2SjcUPvpMVqB3KP4uAAMMyKpWroe6G3Ieyc
         urm2S2lssVyEGNAOepw7b/AF7fO9GzdrFCUGRHEbATbSVqoOJXxWw/vUkJbMVoi8ahet
         uKNg==
X-Gm-Message-State: AOJu0YzEse9ynEBSgnn9+6E/KQ0teXe+/KyWG2+kp9bbthbFDE7gXsUC
        etuuZsxPBssqauedHUAz+O0FcaqGr5GF+Q==
X-Google-Smtp-Source: AGHT+IHy8EAG/YRAmgKeD3zoebtRhIrODs0H7KWcN//8lYUqY9YSl7tWPEO1edaRItsSeDda1vQzsA==
X-Received: by 2002:a25:9885:0:b0:d80:a9d:aeae with SMTP id l5-20020a259885000000b00d800a9daeaemr4781019ybo.44.1694680931412;
        Thu, 14 Sep 2023 01:42:11 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id m196-20020a25d4cd000000b00d814d8dfd69sm245845ybf.27.2023.09.14.01.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:42:10 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso18132276.1;
        Thu, 14 Sep 2023 01:42:10 -0700 (PDT)
X-Received: by 2002:a25:9707:0:b0:d80:4c9b:bf72 with SMTP id
 d7-20020a259707000000b00d804c9bbf72mr4457953ybo.21.1694680930741; Thu, 14 Sep
 2023 01:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230913203805.465780-1-ralph.siemsen@linaro.org>
In-Reply-To: <20230913203805.465780-1-ralph.siemsen@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 10:41:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1ccpveV+vxJrkmVCH-SJXhAHCiyp75CfXUQjz6bwcwQ@mail.gmail.com>
Message-ID: <CAMuHMdX1ccpveV+vxJrkmVCH-SJXhAHCiyp75CfXUQjz6bwcwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: renesas: r9a06g032: fix kerneldoc warning
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:38 PM Ralph Siemsen <ralph.siemsen@linaro.org> wrote:
> Mention the 'dual' structure in the kdoc. This fixes the following
> W=1 warning during build:
>
> > drivers/clk/renesas/r9a06g032-clocks.c:119: warning: Function parameter or member 'dual' not described in 'r9a06g032_clkdesc'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309101314.kTRoxND5-lkp@intel.com/
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
> Changes in v2:
> - split the warning fix into separate commit

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
