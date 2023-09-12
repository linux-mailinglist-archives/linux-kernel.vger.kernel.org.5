Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3581579CB10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjILJGL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjILJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:05:48 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DC649C6;
        Tue, 12 Sep 2023 02:03:46 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59b8f5b6c0aso16846927b3.0;
        Tue, 12 Sep 2023 02:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509425; x=1695114225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QCrggxRs2k8gYsstbTSvbfC449twGThC1mGYDtsvMg=;
        b=hGgIpjMB6RGhD0Xd2HOarb/j2TPVzGzhE0VAh8T44f7Fp0O+qDLg9Cu4KX39FcXSTV
         /pRxIYe1sBpnjH8qR4uzeVCQxbIumjFS5lP4txjUSYHSv94B2AcssKA+3p12IuTi/Im/
         pVBwzOiP1rnWP5s6MzHO9XrB/gK7M0aqsfZtzysnwybvMfV1eAahLQnGPcV8yODFZ1Et
         AcD5X4ZmUkp46r1I5Gcc69KOOgcPcnHD9239MQrB9vAJl6ajDmOlkrzilKm4Ki+50moq
         zca8tw77y7DRgO6CIddzd6EJE9rPjLWSXbdVEgO9U9QuteI/lvldxDgFkdvIVUIRpC70
         JACg==
X-Gm-Message-State: AOJu0YzQhoacG8pu4mPHOgAt1w3cKH+1SwSzya3Q3wrA0s1J3fwDZetl
        eDNWG+S6W32fNDzrY2jijhEhGr1s35CwGA==
X-Google-Smtp-Source: AGHT+IEN0zim4DIVvwsr4rW9NDzuGgVrFDpNiuwJi5T5TlEHnNbD5hhzzZacDUqH+GnubuJBzWJhrg==
X-Received: by 2002:a81:94c4:0:b0:595:2094:f87 with SMTP id l187-20020a8194c4000000b0059520940f87mr13680920ywg.47.1694509425129;
        Tue, 12 Sep 2023 02:03:45 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id l63-20020a0dfb42000000b0058038e6609csm2441096ywf.74.2023.09.12.02.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 02:03:43 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d78328bc2abso5043682276.2;
        Tue, 12 Sep 2023 02:03:43 -0700 (PDT)
X-Received: by 2002:a25:aa69:0:b0:d7a:e0f6:54cc with SMTP id
 s96-20020a25aa69000000b00d7ae0f654ccmr11235241ybi.26.1694509423233; Tue, 12
 Sep 2023 02:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <CACRpkdYL46wY_4dm2w45kdPqOJ8zU9X=SSAXv_K=9wfBZFqyDQ@mail.gmail.com>
In-Reply-To: <CACRpkdYL46wY_4dm2w45kdPqOJ8zU9X=SSAXv_K=9wfBZFqyDQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 11:03:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXi6PPFqgjvr6tBXQnXqNb3YL=87JeSiGN0+QqkAvziAA@mail.gmail.com>
Message-ID: <CAMuHMdXi6PPFqgjvr6tBXQnXqNb3YL=87JeSiGN0+QqkAvziAA@mail.gmail.com>
Subject: Re: [PATCH 00/37] Add new Renesas RZ/G3S SoC and RZ/G3S SMARC EVK
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Claudiu <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Ulrich Hecht <uli@fpond.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Sep 12, 2023 at 10:55 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> For new code try to use <linux/cleanup.h>.
> Or if you prefer take a sweep and introduce scoped guards
> everywhere (for spinlocks, mutexes..).

Hmmm, <linux/cleanup.h> is only available in v6.5 and later.
I don't know whether the CiP machinery is planning to backport
<linux/cleanup.h> to e.g. v6.1 LTS...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
