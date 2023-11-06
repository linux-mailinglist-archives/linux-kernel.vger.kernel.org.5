Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086A37E2A10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKFQkS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 11:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjKFQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:40:17 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68BA1BF;
        Mon,  6 Nov 2023 08:40:13 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-da2b9211dc0so4530203276.3;
        Mon, 06 Nov 2023 08:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699288813; x=1699893613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lozX/5uE8E9wTSAQJ6cDeuHkVJrKETQfNxx1vpXTbcc=;
        b=FwjMj56ZDm2zYD/FP9o+gDNAglANLcsFFB9f5/acmTEQVFTduS5qq208K1Vf66z8p5
         t2HZU0yYDLzNWEYsfTC/DMymJ5J0XFQgFV2xhjDySzx0U3Hmp2A/N+pEHrvzRG2Qb2G+
         loJxp+oCumy8vrKJqiksE61rN4YFsN9t8Ns7QzwXYYvilROn/YsGShr2M6vpk5fuwTDM
         XeqRztIilUxXlIk1ycjQRCQqvPa/fPhoK+zfXAvPK7GbYWS9FcAi2k6ByU6lBdOALJML
         tbKi6VSaQL+dph2n90jzw9sFovWYR8JT7Z6efa1F43S7ifHRNIOuOYRXXpcoD1U7X/qr
         Foqw==
X-Gm-Message-State: AOJu0YwdSvH6dnwMvDOEF/hklzXy2q/hwuxBeJ5s/av1igs48LKg50DG
        oRHmUomEr1kqH0AjZCf2Z0Hlxb1T1FVAqA==
X-Google-Smtp-Source: AGHT+IH3Qg60XJ775OcT8sue3DFeb8fUBDnpU7Jul0u1NlKFqYAi/hK6VEsMYBpBMwVwIpSKATL2fg==
X-Received: by 2002:a25:ce8c:0:b0:da0:37c8:9f00 with SMTP id x134-20020a25ce8c000000b00da037c89f00mr28255123ybe.36.1699288812915;
        Mon, 06 Nov 2023 08:40:12 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id z11-20020a25ad8b000000b00da06fc45421sm4128278ybi.54.2023.11.06.08.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 08:40:12 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7b3d33663so56593867b3.3;
        Mon, 06 Nov 2023 08:40:12 -0800 (PST)
X-Received: by 2002:a81:a04e:0:b0:5a7:b560:12df with SMTP id
 x75-20020a81a04e000000b005a7b56012dfmr11125598ywg.8.1699288811909; Mon, 06
 Nov 2023 08:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20231106-of_overlay_fdt_apply-kerneldoc-v1-1-9a2d132bc6c1@bootlin.com>
In-Reply-To: <20231106-of_overlay_fdt_apply-kerneldoc-v1-1-9a2d132bc6c1@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Nov 2023 17:40:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWdEg0m=D6aVW+R=9TSR7BsQWQfPdtORVH-HcgUsQ0oxQ@mail.gmail.com>
Message-ID: <CAMuHMdWdEg0m=D6aVW+R=9TSR7BsQWQfPdtORVH-HcgUsQ0oxQ@mail.gmail.com>
Subject: Re: [PATCH] of: overlay: enable of_overlay_fdt_apply() kerneldoc
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 2:03 PM Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> of_overlay_fdt_apply() already has a kerneldoc-formatted documentation,
> except it is nor marked as such. Adding the second asterisk is enough for
> the documentation to take it into account correctly.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
