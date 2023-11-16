Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB567EE248
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbjKPODe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 09:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbjKPODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:03:20 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2F19A7;
        Thu, 16 Nov 2023 06:02:54 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5c516f92759so8731337b3.2;
        Thu, 16 Nov 2023 06:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143373; x=1700748173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+a7AGpCsYFRkwmEKl8t6Ffx64QeS9oLpr5/sPCE906o=;
        b=MyuklPbRlDAZm3224WPemSM+Oz2vtCTtXvAGfZFlcTH/b5sDmFK2x0VlQbdy0ZkdZC
         MZdFTLGEy/gYKzAnvp64u/VtkktKy5AZX8kUeZ9wDN9lVHtFQfcP0HvzQ03z4/W9664/
         FAVRyG16mooYP2ovWfOhjcusdsOzgw0xr1Fn9VidPbuxy7aE5kT2XAA5UXmCkJdE8uB+
         bNSDyfkBfLByf+BWoJOkjkhlwqZyxa1+EyFf3HFHiuc4603rVpyGzT2tFmi5Q2wvwccZ
         c5NrKlsJ4X8e6Ktwf+R8XWeiFEYM66CPCGaJFJwZmpyonIgOZWO4kNrEXx5WIWcpbiGi
         vrQQ==
X-Gm-Message-State: AOJu0Yy+dkKp/GExsPKy0bi2G42VQRmpfhjBUokUUvXm+aUc38XiriYI
        vSpmMheuPfVYYMuI3iHq84U8SHyX8KNUgw==
X-Google-Smtp-Source: AGHT+IHe62PrhOUuPuH9j49jIDt0z04s0jPBlTF5fr9h2BotQ8xmzVHos0MSvzhTk12KarNBeVGxrg==
X-Received: by 2002:a0d:c446:0:b0:5ac:fe2d:5edf with SMTP id g67-20020a0dc446000000b005acfe2d5edfmr16775374ywd.44.1700143372898;
        Thu, 16 Nov 2023 06:02:52 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id e185-20020a8169c2000000b0059bdac3fd08sm1027000ywc.48.2023.11.16.06.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:02:52 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5c516f92759so8730947b3.2;
        Thu, 16 Nov 2023 06:02:51 -0800 (PST)
X-Received: by 2002:a0d:df14:0:b0:5a8:28d6:4d08 with SMTP id
 i20-20020a0ddf14000000b005a828d64d08mr15985817ywe.17.1700143371403; Thu, 16
 Nov 2023 06:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20231115211829.32542-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115211829.32542-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 15:02:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgk53x6MYHZQVUjZ1oz+a=XsLKu98AmOEqayvi913_YA@mail.gmail.com>
Message-ID: <CAMuHMdXgk53x6MYHZQVUjZ1oz+a=XsLKu98AmOEqayvi913_YA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document
 RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
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

On Wed, Nov 15, 2023 at 10:18 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The USBPHY Control Device on the RZ/Five SoC is identical to one found on
> the RZ/G2UL SoC. "renesas,r9a07g043-usbphy-ctrl" compatible string will be
> used on the RZ/Five SoC so to make this clear and to keep this file
> consistent, update the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rzg2l-usbphy-ctrl" will be used as a fallback on RZ/Five SoC.
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
