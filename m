Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373A17B2219
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjI1QTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1QTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:19:02 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110BC199;
        Thu, 28 Sep 2023 09:19:00 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-49a319c9e17so3542190e0c.1;
        Thu, 28 Sep 2023 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695917939; x=1696522739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mQRi8ZNuvLxfOVIX7Pb/xHqZWWctvdJZZK30/RGLwA=;
        b=WTwvY5VpW8WBQ5LmfvMNG6v2Mw60Pa3DohzF63fDMiFBCSS7g+5UjHdiRoQEdHGJk8
         fOS8kKF2SO8IWs+4uMmEyct11CpXKkx4crXUzvUbXnpiQySRzl6fhoUlZRgTZgkvBoIh
         nHthBEGxfaK1VuVjhTORaXHTLbQxTiZc/Ji8iPe2IBi5UhqkDa629IykTfw19yEGQGrv
         z7zzt/1DYj0AhwSBp1ed4dzt2+Np9taPLFtNlgpKLfHq1cMHZIBhBX4E/qv2WewgzyMF
         jVgpBWx/3deOnhn2Tr1PehIJvumZzPcy/vOOXuUp5mcVnIqphsR1RTchFCHscHNEKFgx
         ZvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695917939; x=1696522739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mQRi8ZNuvLxfOVIX7Pb/xHqZWWctvdJZZK30/RGLwA=;
        b=FjZLV5JNfg93O7Y4/Pl6jG4s5orTDmJjnUtuzqc0gylfyK03KypMlsmxDE9zZt9/St
         EPvqFnjj9dcIRHsk5mXw9SDmInXsJn5gY6yYnrdVbwPb4aABcveWckAW3ZKOdoaMYZVG
         MRb7bI++GyBREGm9aPcr98hSSTuKmJI81usLOuM7aqizSw1oRLBHkaVTj0gGkvofUryV
         G2lB9AWTxUgaQi1nLTaovUcXfi6p4yplsfmKd+ldWlDunKHHf8VHaHDXa7xQhd+XI8Yu
         dRYnCr/hj7PhkIIqn6fn0a0Sy7K/0OzeKbyb7grZVVA5pC+TDYRvUgxQVD8tDR92dtK9
         ZKgA==
X-Gm-Message-State: AOJu0YzpAEWNSuKzG/8cNVJAdDorjN9k/9XVoZl9JKoN2UOClFu6gmJQ
        AeZXZ3MHxNnsRBJHasVYO+AFYyGKXSJh6UxF/G4=
X-Google-Smtp-Source: AGHT+IEEQIZo78ZB+LRqd4cG7MAVnesmuoPM3CUNnGVROTnyjl3M5KNHKj7J142QD6g9SdwTyZEoANcgn+R7moVi+/E=
X-Received: by 2002:a1f:49c5:0:b0:496:b3b7:5d4c with SMTP id
 w188-20020a1f49c5000000b00496b3b75d4cmr1343220vka.16.1695917939028; Thu, 28
 Sep 2023 09:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230928104520.24768-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <4e4bf02b-2264-491e-9b71-ae3b5ad7fc39@sifive.com>
In-Reply-To: <4e4bf02b-2264-491e-9b71-ae3b5ad7fc39@sifive.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 28 Sep 2023 17:18:12 +0100
Message-ID: <CA+V-a8sSmy-UNwsB3b_yuETTRGS2fBWvS4sTMaVghTWm6oUb+Q@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock_event rating
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Thu, Sep 28, 2023 at 5:04=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> On 2023-09-28 5:45 AM, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Renesas RZ/Five SoC has OSTM blocks which can be used for clock_event a=
nd
> > clocksource [0]. The clock_event rating for the OSTM is set 300 but
> > whereas the rating for riscv-timer clock_event is set to 100 due to whi=
ch
> > the kernel is choosing OSTM for clock_event.
> >
> > As riscv-timer is much more efficient than MMIO clock_event, increase t=
he
> > rating to 400 so that the kernel prefers riscv-timer over the MMIO base=
d
> > clock_event.
>
> This is only true if you have the Sstc extension and can set stimecmp dir=
ectly.
> Otherwise you have the overhead of an SBI call, which is going to be much=
 higher
> than an MMIO write. So the rating should depend on Sstc, as in this patch=
:
>
> https://lore.kernel.org/linux-riscv/20230710131902.1459180-3-apatel@venta=
namicro.com/
>
Thank you for the pointer. Do you know any tool/util which I can use
to make comparisons?

Cheers,
Prabhakar
