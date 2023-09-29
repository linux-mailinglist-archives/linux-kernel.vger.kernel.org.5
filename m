Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305EA7B3C85
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjI2WF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjI2WF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:05:56 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06731B5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:05:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c4f1f0774dso4852596a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696025154; x=1696629954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naHj0xuXcByQMM+TdtCohvVCq+osNBK01cxTTEKKxyw=;
        b=EMu61RC9E0ws5MSlrG2oGhY1AnPg/IGdr04eGFJ3BsNxIEOKmnxqTy9B8MNlvN7b3n
         S63AA34zWXuXcY0mR8qFLGNJCBXQEsZW+kwFqwl331FDfQXaEUMvkMNM5EeAaQKoWivB
         65S+Ztu5IvAGRoOM09th3MPCD/oAAN7C+FBnELRuCA3BV94svnENd0nNgHoSRtPWPkMW
         4Kuk7MmMXNthr5O1wJsSbcfqauVEDNUzI96KAQYZzE7FIORehlmuZ0eboHekUpVDQC71
         nbth5Gi600YW39RapUI4yVvTgZZ+XWmoJ78eOtzOGdoyqzOx8bGBQ70vRBPXI3VWTnG2
         KMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696025154; x=1696629954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naHj0xuXcByQMM+TdtCohvVCq+osNBK01cxTTEKKxyw=;
        b=C207bG/z+Tk9JrhR0nMxW/iOhsRxBM5MDFZbFo5omxNzLvJf9c7vHIRClKfwMy0lPs
         5c7FtpkIKDCXcYGwNdAC0or0OPVd51CyFJpvv/OKF++EpJVaj8HDPWxlGCc17opu7oLn
         4y39E0KAqdThmg5EPKrKxevnLD4DhAjU2tbmnPHfkiKmgcAjMCQ3HTNd6iTu6NEgZ9Dn
         UtdJC9a7jZjDY4LVZvSmva+/qp/ilSA2Oow+HgTf2aBdOOX9gsRHPygc0/Uuy2ECp3kt
         ovjT9y8klPrgGxQXYPlkNVxE2M9+tfc1DJRmMTwtA5riRzYu2FbphC32WNtCUuVU1vpl
         31mg==
X-Gm-Message-State: AOJu0YwVZYTY2ZHH5aGNHFj2rTke9nvFCgsj7ttDLmnLObbp0gqfV0qG
        /mTLtvOtaZ2iYtCCMllZFPb8c5ijTO9fCJCJmvVJOE+OYmvQa2mKULw=
X-Google-Smtp-Source: AGHT+IHyE4YQUm7vQs1QcqQjr5b1q+oQmKp3WntnD5jmb4mEWI4W6j13UW4F5G4vJnz8UfQSlOEZzp7+UN0w1kzOeHs=
X-Received: by 2002:a05:6358:e49c:b0:143:8aa4:30bc with SMTP id
 by28-20020a056358e49c00b001438aa430bcmr5947074rwb.8.1696025154053; Fri, 29
 Sep 2023 15:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr> <20230929-pxa1908-lkml-v5-7-5aa5a1109c5f@skole.hr>
In-Reply-To: <20230929-pxa1908-lkml-v5-7-5aa5a1109c5f@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 30 Sep 2023 00:05:41 +0200
Message-ID: <CACRpkdb=8LU9Mkkn_VDcTGoH1pWn=hp9ZhN5dLm5pykif8cp-w@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 7/8] arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de, balejk@matfyz.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 5:42=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Add DTS for Marvell PXA1908 SoC and Samsung Galaxy Core Prime Value
> Edition LTE, a smartphone based on said SoC.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
(...)

> +&pmx {
> +       pinctrl-single,gpio-range =3D <&range 55 55 0>,
> +                                   <&range 110 32 0>,
> +                                   <&range 52 1 0>;
> +
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&board_pins_1 &board_pins_2 &board_pins_3>;
> +
> +       board_pins_1: pinmux-board-1 {
> +               pinctrl-single,pins =3D <
> +                       0x160 0
> +                       0x164 0
> +                       0x168 0
> +                       0x16c 0
> +               >;
> +               pinctrl-single,drive-strength =3D <0x1000 0x1800>;
> +               pinctrl-single,bias-pullup =3D <0x8000 0x8000 0 0xc000>;
> +               pinctrl-single,bias-pulldown =3D <0x8000 0x8000 0 0xa000>=
;
> +               pinctrl-single,input-schmitt =3D <0 0x30>;
> +               pinctrl-single,input-schmitt-enable =3D <0x40 0 0x40 0x40=
>;
> +               pinctrl-single,low-power-mode =3D <0x288 0x388>;
> +       };
(...)
> +                       pmx: pinmux@1e000 {
> +                               compatible =3D "pinconf-single";

At least add a new binding for "marvell,pxa1908-padconf"
and use that like this:

compatible =3D "marvell,pxa1908-padconf", "pinconf-single";

When you use pinctrl-single you get the slightly opaque device
trees as seen above, so it's not something I'd recommend, I'd
rather write my own pin controller.

But it exists, so I can't say you can't use it. Not my choice.
I understand it is convenient.

It is possible to switch later, but only if you have a unique
pin controller compatible so please add that.

Yours,
Linus Walleij
