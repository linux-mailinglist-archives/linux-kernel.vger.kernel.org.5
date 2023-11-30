Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34567FFE82
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377127AbjK3Wd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjK3Wd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:33:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3D10F3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:33:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7C8C433CC;
        Thu, 30 Nov 2023 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701383614;
        bh=Mzz7UyD/BBxVfdWVs++u5WlKznlkI21DI2rHNivCDeU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AB5VgJBE2QS88NdhPNTsYAkRHY0G8gRTfNO/yWyHJe7jPduuhMHRsrcJObNSPiiMY
         qe/OXpu1fy9/QmqNq0YMygnJHi2oCa/9gPZg22PcMMGnf2G6tQDy5OTqPgbFUjKDyz
         DZbLNNMHpYLUrLw++ohz+jlVVP4/cSOsGxX/BjfsEb36MXLythMGvVS+vlMIjDRLxG
         PEkb2tVkOo2PxY3f9Ni8jOmOtw76avrbvARn9vhqc6byXUFhKH9Fo6Ig0sdU7Lhj5I
         iBumhX+B1rmxUnst7GTLGMTu5zEIxU4J4e0BCRjBGaE6wXEpOzv4j9nneEfbgMW8Jd
         KmrXiKIxliaHA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bbb79f97cso1504000e87.0;
        Thu, 30 Nov 2023 14:33:34 -0800 (PST)
X-Gm-Message-State: AOJu0YwjbDYAwt/nwDpxsc7aXsTpD3LzPentFTExwWnDjIR72u8Y2iXl
        VBe/f/kefZdzcYlxUT3PqNa6duHcE/8Xln46bA==
X-Google-Smtp-Source: AGHT+IGmccipeHU8snglPx6DimdrhUBaMNhdl3J4x9yrxb6krnN2M2Zo+SxNeWob4S5jWhHdbyb3Fh5KQATASB7DWsc=
X-Received: by 2002:a05:6512:3e22:b0:50b:c7bd:2352 with SMTP id
 i34-20020a0565123e2200b0050bc7bd2352mr163638lfv.14.1701383612257; Thu, 30 Nov
 2023 14:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20231130191815.2421978-1-robh@kernel.org> <CAOMZO5AZNz1cRg+aYQjDmpZ75ATJQUTWmC5mx+vgaYcBL6M+2w@mail.gmail.com>
In-Reply-To: <CAOMZO5AZNz1cRg+aYQjDmpZ75ATJQUTWmC5mx+vgaYcBL6M+2w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 30 Nov 2023 16:33:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLFpPo8xTh_vgWvDXSY5J8tQJZh9SrkW2EiK5V_ZNeeA@mail.gmail.com>
Message-ID: <CAL_JsqKLFpPo8xTh_vgWvDXSY5J8tQJZh9SrkW2EiK5V_ZNeeA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice: Fix PCI bus nodes
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
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

On Thu, Nov 30, 2023 at 1:28=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Rob,
>
> On Thu, Nov 30, 2023 at 4:18=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > The imx8mm-venice boards PCI bus nodes are a complete mess. The
> > unit-addresses are wrong. The PCI bridge nodes are incomplete missing
> > "device_type" and "ranges" and just wrong for "#address-cells" and
> > "#size-cells" values.
> >
> > All of these issues are reported warnings if anyone bothered to pay
> > attention. Sigh.
>
> The warnings are gone in linux-next:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/arch/arm64/boot/dts/freescale?h=3Dnext-20231130&id=3Dd61c5068729a76a6183a=
897bcad4bf26e8d3d674

Linux-next is wrong. The ethernet device should have a node name of
'ethernet'. The 'pcie' node name and 'device_type =3D "pci"' is for PCI
buses/bridges only.

Rob
