Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413CC799216
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbjIHWRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbjIHWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:17:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F331FC9;
        Fri,  8 Sep 2023 15:17:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C803C433CC;
        Fri,  8 Sep 2023 22:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694211459;
        bh=ZS+mNN5cXqMzb7kw7Nj273kzsWjUis3gy7zjEWHBFiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rNV7Em1N0RwPwuwyP+D56zIMxHNnvcLqnlXgUbj6DZXdVRV2qxKNCBYJ/d9qUOfJE
         tNb6iPUXgZiVYnNeBadhCLMb6336LGyhZxrYK3xie5R1QygS/xuUtJHK6Y0QnYbl2W
         93BE0OiuTJP16VOx3EL3ciPp3Y2EE7WGoDiTDFyBI1lJbRHHNxZkuLDCxHugtMYq7g
         kbUEiuGzA020xG07zfJJ+A1PXkqdoiJa7CsiVGOpIi/HVYrns2bnXfi1KEBd2ezwpW
         rWLD9IXm1XoUIceAdLhm+9VA6/m3Bb0a0Bf/U3ACzRuNOn9Y9gAmI3ylguCqf92wMr
         rBex/dpe4j45A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so4156530e87.1;
        Fri, 08 Sep 2023 15:17:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YyOZAIeAr832XiZ23zdkAy/yu+R5/9a1D3wjGQPV4P0pyhBDDVH
        HwGDwBWf8qPU41Y8fbLmtMIGr+62+QEyvf7McA==
X-Google-Smtp-Source: AGHT+IH7vn1So58Aq1vuOF4o+jPLa7AVZRiANt517FCp958fWfI3EOY9w4caA06oNJjMdcq+x8INKUuLSKz6HjWMEzs=
X-Received: by 2002:ac2:498f:0:b0:500:a7c8:1847 with SMTP id
 f15-20020ac2498f000000b00500a7c81847mr2684836lfl.66.1694211457327; Fri, 08
 Sep 2023 15:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230726065407.378455-1-s-vadapalli@ti.com> <20230726065407.378455-3-s-vadapalli@ti.com>
In-Reply-To: <20230726065407.378455-3-s-vadapalli@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Sep 2023 17:17:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ7zHHMiZiSfM+Du3d-rG9VetkEvbBXHYN5=JUcg2irAA@mail.gmail.com>
Message-ID: <CAL_JsqJ7zHHMiZiSfM+Du3d-rG9VetkEvbBXHYN5=JUcg2irAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-j721s2: Add overlay to enable
 main CPSW2G with GESI
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 1:54=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@ti=
.com> wrote:
>
> From: Kishon Vijay Abraham I <kishon@ti.com>
>
> The MAIN CPSW2G instance of CPSW on J721S2 SoC can be enabled with the GE=
SI
> Expansion Board connected to the J7 Common-Proc-Board. Use the overlay
> to enable this.
>
> Add alias for the MAIN CPSW2G port to enable kernel to fetch MAC address
> directly from U-Boot.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>  .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 85 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.d=
tso
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index 6dd7b6f1d6ab..019a8be19b93 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-sk.dtb
>  # Boards with J721s2 SoC
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am68-sk-base-board.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721s2-common-proc-board.dtb
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-j721s2-evm-gesi-exp-board.dtbo

Overlays need to be applied to something. That's done like this:

foo-dtbs :=3D base.dtb k3-am62x-sk-hdmi-audio.dtbo
dtb-y +=3D foo.dtb

Please send a fix for this.

Rob
