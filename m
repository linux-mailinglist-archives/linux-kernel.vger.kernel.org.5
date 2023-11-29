Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E37FDC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjK2QNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2QNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:13:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3EBF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:13:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D893C433C7;
        Wed, 29 Nov 2023 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701274399;
        bh=jdTBorBBot5lL3IsYWjyvq498U+h2ggo4orYIKLG/nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j1qJSTi+/yeMWfCkGmzj4lqCWKx/VQCAS6tnFcNcRfRdue/AKJp05jNKUfzo0zby0
         4UzMzr+0eA5VjFC52MFcLL5qu2DhjwvJvqH+EX171xoNHG0sCp/XmhfAA2Ta38ML1c
         TEEBI9UHceqGwdaWS1Hgon8Hd3oGL6krBFqX5xuHsc7G58YBE3zPhuyubUdO0G4GDu
         I2wPSc378vZoLFfJmEHQLcEeNv4E9U+XgEB/TE0cGxqEMJ05ejLvWvEn9Uy2E7ULx5
         Lt/TRZWj0Qg6BTlAPGy0HDGfQcv8S/EHpJfmWdvfA0233rHmho3nflRYuu/y966yyQ
         wgV8EAh5w6KxQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bbb4de875so2804996e87.0;
        Wed, 29 Nov 2023 08:13:19 -0800 (PST)
X-Gm-Message-State: AOJu0Yz8mBbyrQzFdXFxXQS1fzvgJ2VwF9DnY+uxDvrRo8TXGpHivqwI
        vN2d1b6HzZDN0GVWiea8rVLSCaAufx/j13X7qw==
X-Google-Smtp-Source: AGHT+IGeBNr+tTj/pFV18KMOueOkRDfFIrBsKw8oRzZnFGLrLA3OdrhePzkU5rB97jigHmMDRKzirr8e1s/kLD2lcB4=
X-Received: by 2002:ac2:483b:0:b0:50b:c730:207f with SMTP id
 27-20020ac2483b000000b0050bc730207fmr1050276lft.16.1701274397656; Wed, 29 Nov
 2023 08:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20230911214751.2202913-1-robh@kernel.org> <2eaa2e1d-b6cf-4032-af28-5e8f6428e95f@amd.com>
In-Reply-To: <2eaa2e1d-b6cf-4032-af28-5e8f6428e95f@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Nov 2023 10:13:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLUKyNU7vrYhVzdTKKExXN8-Dyy8cEFd6PNW=b03VDOvg@mail.gmail.com>
Message-ID: <CAL_JsqLUKyNU7vrYhVzdTKKExXN8-Dyy8cEFd6PNW=b03VDOvg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: xilinx: Apply overlays to base dtbs
To:     Michal Simek <michal.simek@amd.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 5:56=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 9/11/23 23:47, Rob Herring wrote:
> > DT overlays in tree need to be applied to a base DTB to validate they
> > apply, to run schema checks on them, and to catch any errors at compile
> > time. Defining the "-dtbs" variable is not enough as the combined DT mu=
st
> > be added to dtbs-y.
> >
> > zynqmp-sck-kr-g-revA.dtso and zynqmp-sck-kr-g-revB.dtso don't exist, so=
 drop
> > them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   arch/arm64/boot/dts/xilinx/Makefile | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/=
xilinx/Makefile
> > index 5e40c0b4fa0a..1068b0fa8e98 100644
> > --- a/arch/arm64/boot/dts/xilinx/Makefile
> > +++ b/arch/arm64/boot/dts/xilinx/Makefile
> > @@ -22,11 +22,10 @@ dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k26-revA.d=
tb
> >   dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA.dtb
> >
> >   zynqmp-sm-k26-revA-sck-kv-g-revA-dtbs :=3D zynqmp-sm-k26-revA.dtb zyn=
qmp-sck-kv-g-revA.dtbo
> > +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k26-revA-sck-kv-g-revA.dtb
> >   zynqmp-sm-k26-revA-sck-kv-g-revB-dtbs :=3D zynqmp-sm-k26-revA.dtb zyn=
qmp-sck-kv-g-revB.dtbo
> > +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k26-revA-sck-kv-g-revB.dtb
> >   zynqmp-smk-k26-revA-sck-kv-g-revA-dtbs :=3D zynqmp-smk-k26-revA.dtb z=
ynqmp-sck-kv-g-revA.dtbo
> > +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA-sck-kv-g-revA.dtb
> >   zynqmp-smk-k26-revA-sck-kv-g-revB-dtbs :=3D zynqmp-smk-k26-revA.dtb z=
ynqmp-sck-kv-g-revB.dtbo
> > -
> > -zynqmp-sm-k26-revA-sck-kr-g-revA-dtbs :=3D zynqmp-sm-k26-revA.dtb zynq=
mp-sck-kr-g-revA.dtbo
> > -zynqmp-sm-k26-revA-sck-kr-g-revB-dtbs :=3D zynqmp-sm-k26-revA.dtb zynq=
mp-sck-kr-g-revB.dtbo
> > -zynqmp-smk-k26-revA-sck-kr-g-revA-dtbs :=3D zynqmp-smk-k26-revA.dtb zy=
nqmp-sck-kr-g-revA.dtbo
> > -zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs :=3D zynqmp-smk-k26-revA.dtb zy=
nqmp-sck-kr-g-revB.dtbo
> > +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA-sck-kv-g-revB.dtb
>
> Applied.

Why is this in next still, but not in Linus' tree?

Rob
