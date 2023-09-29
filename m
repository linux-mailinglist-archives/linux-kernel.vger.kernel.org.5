Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F302F7B35F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjI2Oqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Oqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:46:43 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4ED6;
        Fri, 29 Sep 2023 07:46:42 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48feedb90d2so5189787e0c.1;
        Fri, 29 Sep 2023 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695998801; x=1696603601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icHrBBDQRTeyt50Y1yLJwIMCK4gLih/YGVhUvYswbzQ=;
        b=cpLXa4ZV8GHaZMHX4XaM3iSOzfZGvWK84GyuVZN7mc4qMKZiJ+pD1t78NJaS/gjRcE
         PqKc3QaQ5qq2QpZGDO5VWcRK0RwTG42PIf2IaWEi6CSpz8ecR5Mgj7pxqS4YIZbL2+Y0
         jZKMPQrnuQC6Xo8uaR+uVRv4TZbZrlwTykufKR+U9eB5LZM4BkFqVPWpJKYA1zjL5BCg
         aaHnaBmxDiLBS7oSaTbLZRfd+KHXCGX7yj1ecMQjOleARrQuO/B/31oFqoqBqAA009gH
         GfLPa5D1MW/awoXyGtrliZ/zFi8ClSrfObLtbylJ98p94jsTg1AnpoiBcY/zu+ewRYud
         f1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695998801; x=1696603601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icHrBBDQRTeyt50Y1yLJwIMCK4gLih/YGVhUvYswbzQ=;
        b=aQr5FuxDTYCQdM7SmMeNwk/x5aXQxwVBF1terWhcjGkdWyxCwsSlpb0zcPyJwpI0WJ
         PRz+b6FTwrMoRrXFUyssYnLI/4eh+2VvXgeg7vqRZoMuSTPpQ11a5PrfFHMF6F1JbqZ7
         RTl+bKcxXaJlfXyUlA9ZUo2PwyVrjrz28klMYThtO4nH5JErWnId3PlNUCPCHLAsxwAg
         cI9iA4zvVNolgR7XtrJVhoSJRW6iX7ARbBXc1v+7t8FZyRja16xtqasRsrL9tUXHAOAX
         OAyn4DcbzNto/31DZoaIFLV46WW9e9eMdptSHItVYlOcZ8g2V4N/swwPeiajij2GZ1Gv
         9pdQ==
X-Gm-Message-State: AOJu0Yzntm7yDDKnyWbfuFWSIhyB/XR2oN+kgGCnHdMIyEGdOV+SejY9
        ueXBD0z+VryUQRG+wQAj67EBv4Jgs2zrTiv4HSM=
X-Google-Smtp-Source: AGHT+IGl4VBrxQ+OTUhg9OTarf1b8pDfiWJf2T72xV+dm5qW9La2mo3E4I94FnnRzmaI3CV+sty2yxhSjGASAlAxU3U=
X-Received: by 2002:a1f:d605:0:b0:49a:3537:881c with SMTP id
 n5-20020a1fd605000000b0049a3537881cmr4276555vkg.14.1695998800851; Fri, 29 Sep
 2023 07:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230929000704.53217-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230929-professed-imperfect-4b2ed9073e04@spud>
In-Reply-To: <20230929-professed-imperfect-4b2ed9073e04@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 29 Sep 2023 15:45:53 +0100
Message-ID: <CA+V-a8sXxzUPmV5LqGtYm2SYLHS+-VNo_jRsLNP4mUSAKxuoFw@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv: configs: defconfig: Enable configs required
 for RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
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

Hi Conor,

Thank  you for review.

On Fri, Sep 29, 2023 at 3:14=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Sep 29, 2023 at 01:07:04AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable the configs required by the below IP blocks which are
> > present on RZ/Five SoC:
> > * ADC
> > * CANFD
> > * DMAC
> > * eMMC/SDHI
> > * OSTM
> > * RAVB (+ Micrel PHY)
> > * RIIC
> > * RSPI
> > * SSI (Sound+WM8978 codec)
> > * Thermal
> > * USB (PHY/RESET/OTG)
> >
> > Along with the above some core configs are enabled too,
> > -> CPU frequency scaling as RZ/Five does support this.
> > -> MTD is enabled as RSPI can be connected to flash chips
> > -> Enabled I2C chardev so that it enables userspace to read/write
> >    i2c devices (similar to arm64)
> > -> Thermal configs as RZ/Five SoC does have thermal unit
> > -> GPIO regulator as we might have IP blocks for which voltage
> >    levels are controlled by GPIOs
>
> You might or you do?
>
Yes we do use the gpio regulator for SDHI.

Cheers,
Prabhakar
