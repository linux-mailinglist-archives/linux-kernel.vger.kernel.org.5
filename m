Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A07B7AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbjJDIuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 04:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjJDIuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:50:37 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41098;
        Wed,  4 Oct 2023 01:50:33 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59f1dff5298so22558247b3.3;
        Wed, 04 Oct 2023 01:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696409432; x=1697014232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFuSqJ9+W4ZgbXfB+tqrUVzIf0qDtWz3bUcjRAbmN+0=;
        b=qehOtHxS5w04ZJhzQooxV3EFHeTuycIWCQAiiA3WEuNpNWj+ty8l2m1Vv0o2UxaC4Y
         wx0amcBISS30OzHdQLbl3A2TkxoDwrzfRYwhX/624ns261U8kpel0d29z0WbaO+aL4DM
         Q1+Z98EtA8VA+20DPSqVV+w9wjqMSVEnWvObUc+M5pho0z8VNQvor+Uvn1mRlcdm+6V4
         SHqGZTHTJlciFiDpY3IxTUWqgmNS2i+zwJZNJI2zy+1zY2p5XihyXK3TjZ3r4eAy8aWF
         hg2GPATE0+ZSMxBp2ajb8RKYdOagQfyZuxOX3PYOzM8qwi+oJ5iq2iObpltuRMknpRMQ
         ojzg==
X-Gm-Message-State: AOJu0YzF8p1kOUCHN83GETWyKew6RcPdAofTe00CPmKPQi3dkxUniW4Q
        dfzq1l9RCz0g9dsFDpJkaIdH9rPBEEMQ3g==
X-Google-Smtp-Source: AGHT+IH09ObB6fueO6GOHufTRFzHS7YLBPYlXCOcao4kkF11gPWDm7KFBadpF+cOqmnlDmWV3G9sZA==
X-Received: by 2002:a81:6289:0:b0:59b:eb8:c38a with SMTP id w131-20020a816289000000b0059b0eb8c38amr2006607ywb.30.1696409432367;
        Wed, 04 Oct 2023 01:50:32 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id m12-20020a819e0c000000b0058c4e33b2d6sm991571ywj.90.2023.10.04.01.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 01:50:31 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a2536adaf3so22645547b3.2;
        Wed, 04 Oct 2023 01:50:31 -0700 (PDT)
X-Received: by 2002:a81:5c86:0:b0:59f:4f56:59bc with SMTP id
 q128-20020a815c86000000b0059f4f5659bcmr1915893ywb.42.1696409431412; Wed, 04
 Oct 2023 01:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-10-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-10-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 10:50:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJw8t9QyhFaE38cfP=joLjkQn=jRqYWw-98i9VhCWpdQ@mail.gmail.com>
Message-ID: <CAMuHMdVJw8t9QyhFaE38cfP=joLjkQn=jRqYWw-98i9VhCWpdQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/28] clk: renesas: rzg2l: remove CPG_SDHI_DSEL from
 generic header
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Remove CPG_SDHI_DSEL and its bits from generic header as RZ/G3S has
> different offset register and bits for this, thus avoid mixing them.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v2:
> - s/form/from in commit description
> - removed "G2UL_" prefix from macros' names
> - collected tags

Thanks, will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
