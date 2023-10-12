Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04757C6F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378907AbjJLNf4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 09:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378866AbjJLNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:35:54 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9794;
        Thu, 12 Oct 2023 06:35:53 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7e5dc8573so12242857b3.0;
        Thu, 12 Oct 2023 06:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697117752; x=1697722552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brww31FAFpeZAlQBoUfvBmzuk13bTgN/DvXkygTHa8U=;
        b=kUcxNElkzNlqlgTjFgPTuod7+222lkC5CxrTvN0cWxGPWLrbhz+k8JP5OrlMigDg3I
         aFmmQeq/SdDsMYv73/JuFejvY5tAlu/xxz6MLEc7RZwjmgG2KG3OpARzFyZ0Q+mh+eMJ
         svke/FJCw2IOAJpjInaqxvxgoXMVvcO2QK62yhSFILyTx/t95UTFMTGbXKGVx/ldYNAa
         aprWkZxSszQukRp82PBPKMSb8QwSOc/gdXHiDVNPEFL58g493WOhmJW3bXjqAiOpkO3G
         x7ovXpRxjU9yiivVSP/zNpaVGDICwhnAWVPGTkMpyxoVUqFYah2jmmIN1J/Zslpx30CG
         F+kg==
X-Gm-Message-State: AOJu0YwhzRZGuGjKP1Fyz/gM2oVcZnnO022RzUD5kQDayHwLaooCp1Qq
        Hrb7q28IflFlB3TrhoahKZtUd/CAsTuk5A==
X-Google-Smtp-Source: AGHT+IGkO3iC/p9GikkcuJ3RDpek8DhzgZ1YYEG7n6XEMlMowXipSYr+yimaNCFmCgSLem5SVyMmYw==
X-Received: by 2002:a81:48ce:0:b0:5a7:c640:7003 with SMTP id v197-20020a8148ce000000b005a7c6407003mr7859906ywa.23.1697117752301;
        Thu, 12 Oct 2023 06:35:52 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id y129-20020a0def87000000b00582fae92aa7sm5873220ywe.93.2023.10.12.06.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 06:35:51 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a7a77e736dso12051917b3.1;
        Thu, 12 Oct 2023 06:35:51 -0700 (PDT)
X-Received: by 2002:a0d:d748:0:b0:5a3:dc2b:6f44 with SMTP id
 z69-20020a0dd748000000b005a3dc2b6f44mr25699738ywd.18.1697117751495; Thu, 12
 Oct 2023 06:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231010132701.1658737-1-claudiu.beznea.uj@bp.renesas.com> <20231010132701.1658737-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231010132701.1658737-4-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 15:35:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=s6fRq3_fBDS=nsQO0R5Xm7R9Cp0UHcHpvGaxCO64Ag@mail.gmail.com>
Message-ID: <CAMuHMdV=s6fRq3_fBDS=nsQO0R5Xm7R9Cp0UHcHpvGaxCO64Ag@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: renesas: r9a08g045: Add nodes for SDHI1
 and SDHI2
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 3:27 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add DT nodes for SDHI1 and SDHI2 available on RZ/G3S (R9A08G045).
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
