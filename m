Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7518039F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbjLDQS7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 11:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:18:57 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE5CCB;
        Mon,  4 Dec 2023 08:19:03 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso3051801276.3;
        Mon, 04 Dec 2023 08:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706743; x=1702311543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7w+3vK1cdmy3dgE8i5YLvNj03CSI+W7QHOKK1BsUDk=;
        b=Yd2/xKa+HXY8quN6KqHD4odBxQHNcYG71LvKD71RZgiOXB7CEjXCp58SCuJLJKKxnM
         y6YAdi9VRxb9yvJ2NohFzcRnbSjbrvn9aqcC7pjxuCN2o0MG3PexNpzfFLSoWB35E4TY
         yA8ok86YR5gC3CrY/1PEN7aQYbu0jiP4PVcAei9Yd/4sgK1iqfbO2uthQB4xWn+GUCh9
         e9s459ZRCJLLR49NZKLr22/IOLY/qsAI/+ZU3NGXaotwwkRI12S50BvM4CQ6yg52zwrE
         g69QbdfDrTbS7YPMl+qM81sOt46WI4aei6bZfaKMnklY8NpM4eXfep3LdMGFL9pSq1qo
         aurA==
X-Gm-Message-State: AOJu0Yy19Nsgoh+V0+8aw0FRfrbI56EChKB5Wp4elUV/aRyyprPQpmTT
        cizJ+YmyAELYoQHRDNUbHb99T56XLOwQYg==
X-Google-Smtp-Source: AGHT+IGiV1NdBNdmG+XCdpSpHlBoKkLvNa8BpKiX4YQW400Yhduo9FygSvUQvfZlI6LMeImPb/kpNg==
X-Received: by 2002:a0d:dbd5:0:b0:5d7:1941:aad with SMTP id d204-20020a0ddbd5000000b005d719410aadmr3154455ywe.72.1701706742991;
        Mon, 04 Dec 2023 08:19:02 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u189-20020a8179c6000000b005d34a381f59sm3368108ywc.102.2023.12.04.08.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:19:01 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5d3d5b10197so37164417b3.2;
        Mon, 04 Dec 2023 08:19:01 -0800 (PST)
X-Received: by 2002:a81:9808:0:b0:5d3:464d:18d4 with SMTP id
 p8-20020a819808000000b005d3464d18d4mr3058167ywg.21.1701706740819; Mon, 04 Dec
 2023 08:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com> <20231204160033.1872569-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231204160033.1872569-2-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Dec 2023 17:18:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU58NjjdOOLA_T1jr1u=H+2eVN69f1FDc6GhiXEenaxLw@mail.gmail.com>
Message-ID: <CAMuHMdU58NjjdOOLA_T1jr1u=H+2eVN69f1FDc6GhiXEenaxLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] pinctrl: renesas: Mark local variable with const
 in ->set_mux()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 5:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> We are not going to change pins in the ->set_mux() callback. Mark
> the local variable with a const qualifier. While at it, make it
> also unsigned.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
