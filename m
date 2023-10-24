Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB57D50F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjJXNG2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 09:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjJXNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:06:05 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E514EDA;
        Tue, 24 Oct 2023 06:04:21 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so4199341276.3;
        Tue, 24 Oct 2023 06:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152660; x=1698757460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHvmrlYR3ANScM/PMUCYI43KI777+90NRiRHddhNy8c=;
        b=dhxyYXGjmxqb95MATT7xFpJj9ZUpaLDT+31GfHQJWtL/WBvRb6RwYHiXFpoPW4Q/TE
         RNKaY7PhAXEkr2WfUqt5PgrquMFwKzdBhzFrxf3eo1ET++dv2bCeb7ajp2lnCZxeZcOn
         BRnFZpHiMm5Vn4X7fKsE5HFOTxBX6yOSrQaWaF5LtSo1p/KzVrC8qtiae8XxfZPx5z7X
         UJ1XajsLse3dq8fb8sHDyG4gwuZMHop48gH7BP+KJs4XonDVA6e8NWq0EFUTMG7gN5Q6
         eD/u6EZ+mlY/bYC3JeYzfW03D4NrC6DSZzivbGnFOMjX9iVR6B1CqZX4WqePbOM9uuLP
         ndgw==
X-Gm-Message-State: AOJu0YyifiggVM44HL5yExeB+B3IrGX1ytTgnka7Liwtu7qdtHQZDlPh
        Wk2gPUQY1Hfdw6g8fgXgPbObgM0p4kHNYQ==
X-Google-Smtp-Source: AGHT+IFzctphmQ+Icxvoha1yYfi0pSUEcyxJPpaHFA2U+5N9GW+155l7YRUMWI17noliF3frKKaCGw==
X-Received: by 2002:a25:aac8:0:b0:d9b:e043:96f5 with SMTP id t66-20020a25aac8000000b00d9be04396f5mr12501179ybi.0.1698152659786;
        Tue, 24 Oct 2023 06:04:19 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id w31-20020a25ac1f000000b00d9ab86bdaffsm3543021ybi.12.2023.10.24.06.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 06:04:19 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso4198045276.2;
        Tue, 24 Oct 2023 06:04:18 -0700 (PDT)
X-Received: by 2002:a25:b097:0:b0:da0:3c34:2bf5 with SMTP id
 f23-20020a25b097000000b00da03c342bf5mr2005654ybj.2.1698152658170; Tue, 24 Oct
 2023 06:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
 <20231022205316.3209-3-wsa+renesas@sang-engineering.com> <b0b4054adcb5250ad49e19d8f90c89de802f0125.camel@redhat.com>
In-Reply-To: <b0b4054adcb5250ad49e19d8f90c89de802f0125.camel@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Oct 2023 15:04:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdViDiR+rfzH8VeHxOx0cZHaw27CUE5PRwxaQuaWmbWu=w@mail.gmail.com>
Message-ID: <CAMuHMdViDiR+rfzH8VeHxOx0cZHaw27CUE5PRwxaQuaWmbWu=w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: ethernet: renesas: drop SoC names in Kconfig
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Paolo,

On Tue, Oct 24, 2023 at 12:54 PM Paolo Abeni <pabeni@redhat.com> wrote:
> On Sun, 2023-10-22 at 22:53 +0200, Wolfram Sang wrote:
> > Mentioning SoCs in Kconfig descriptions tends to get stale (e.g. RAVB is
> > missing RZV2M) or imprecise (e.g. SH_ETH is not available on all
> > R8A779x). Drop them instead of providing vague information. Improve the
> > file description a tad while here.
>
> It's not a big deal, but assuming that keeping the SoC list up2date
> requires too much effort, I would still keep it, with some additional
> wording specifying it's partial and potentially inaccurate.

Apparently it was too much effort...

> Such list could be an useful starting point for an integrator looking
> for the correct driver for his/her SoC.

For modern DT-based systems, it's much easier to look up compatible
values.

See also scripts/dtc/dt_to_config.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
