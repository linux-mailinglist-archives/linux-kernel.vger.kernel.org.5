Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60427EE1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbjKPNyH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 08:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjKPNyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:54:04 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B8AF;
        Thu, 16 Nov 2023 05:53:59 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ac376d311aso8735157b3.1;
        Thu, 16 Nov 2023 05:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700142838; x=1700747638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQiXjFb8mLsAzVBa/SxrYgXwNAfH0nGzkpIfmd6LGak=;
        b=VTXsglY9hBBiRegaLu2q4LIbryv0hbcu9NXMRESl4JiWEufSUN36q7xRIu+wQRwTyx
         /MKZCSVn6R56u6z5Q+6T0MK48Nt1DeVBKU/5GGHKWCdYDS+XbiSgkzbc5vl3shrk7lfd
         Jip56Wrquih0lhfRjzb8Fo1jSIs18Q4r74L3ps8YPJGWbt28TmhrDpw+owkwEH6qTWWK
         YZLrdgoDqoyGZyYqPyphq10BVSkYREY13WFWLrk6dDleiEp606lFsAoQUcIjGqxGrW4x
         7DmpXkC0qidH1ufiyIMIcTl8q5SI2o4NngG0ujE0YiNiaCIfgfEQ5CUCt/+hu5sSDVxg
         4Sxg==
X-Gm-Message-State: AOJu0Yws8/FUvv5o9n700b8kLa4HCtOYi3aSAzV294umhNlZIYC4KGRN
        Kh5As0MxCAsUN1xgIk5p0+q5ptI60BkidQ==
X-Google-Smtp-Source: AGHT+IHO3537yTRNgloa1+w+sg3qnjzvj8hH/PFIuxxF24p/L0EnKktZ7Q5FUGdzXdKx9GAZZ684Ig==
X-Received: by 2002:a0d:e810:0:b0:586:a684:e7ba with SMTP id r16-20020a0de810000000b00586a684e7bamr17434808ywe.39.1700142838384;
        Thu, 16 Nov 2023 05:53:58 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id u128-20020a0deb86000000b005a7bf2aff15sm1001567ywe.95.2023.11.16.05.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:53:57 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso829475276.3;
        Thu, 16 Nov 2023 05:53:57 -0800 (PST)
X-Received: by 2002:a25:b317:0:b0:da0:c49a:5fe4 with SMTP id
 l23-20020a25b317000000b00da0c49a5fe4mr15561255ybj.24.1700142837775; Thu, 16
 Nov 2023 05:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20231115205333.31076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115205333.31076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 14:53:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUd_zmkY4JS1TgG_MvMSrm6ihA0cTPmVzjGFXw7qtP0OA@mail.gmail.com>
Message-ID: <CAMuHMdUd_zmkY4JS1TgG_MvMSrm6ihA0cTPmVzjGFXw7qtP0OA@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Nov 15, 2023 at 9:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RSPI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-rspi" compatible string will be used on the
> RZ/Five SoC so to make this clear and to keep this file consistent, update
> the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rspi-rz" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
