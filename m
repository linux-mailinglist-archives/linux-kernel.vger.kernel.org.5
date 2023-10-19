Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483197CF2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbjJSIhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjJSIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:37:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D9130;
        Thu, 19 Oct 2023 01:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB51DC433C9;
        Thu, 19 Oct 2023 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697704635;
        bh=JiPNNgrjBECZwV7Y41hs/uNTObKyCCpK7ADnbCSAHfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g99AoHz9se+ybdS2uYK5ZWykPZwQohb/GpZDuoK+jIlKB3dO0wkfmdUsruQ9uxfa6
         fjj0XUJNLdXJFDUicOxeO6VPK0cH7AUEUiCPgdKAgFag1DrQY7oEzDtd6wXKD9z3Cg
         uHdWE75C9/T90lRKVXmOUnABClbQ0I8SedCExHjljJCOKAxRG+bsufa004kCKIBwg4
         ZCw54hIw2dgveVOSrQ7UPkyIxRrhp919AnJ2dq7+mgYU8PcBkfklqxsb97Xo7RuFFi
         Ra1s6R9z7rMdV36KtVeFVwcK2+k5rqZIRdfaxdmFjn9S8T00oZ0YS0XyrlK0+S9MIC
         Y0rfmrNsYNytw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so1104387a12.1;
        Thu, 19 Oct 2023 01:37:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YwAA+W7w1I5tg/0zSrYH+TFDZg8/PEymgkv2SqOsUrR8xJS30xe
        XgcpJCYGVl7zNx0X60x6elb22Lu+7Ssrywk/fMU=
X-Google-Smtp-Source: AGHT+IFE8SPujeMGxsN/7/AxLK5l9xARaEwY/dEF9MzBT6K6SFkjre6r11SbkHuEdtS3YOTy5xs38AL4+I6A7H3C5jc=
X-Received: by 2002:a17:907:d312:b0:9a9:9d19:b250 with SMTP id
 vg18-20020a170907d31200b009a99d19b250mr899792ejc.17.1697704633410; Thu, 19
 Oct 2023 01:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com> <20231017-th1520-mmc-v2-4-4678c8cc4048@baylibre.com>
In-Reply-To: <20231017-th1520-mmc-v2-4-4678c8cc4048@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 19 Oct 2023 16:37:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ_sa8pu9G1chP-ZbsCAba_a5yriuEu-0rKR==b24KUnQ@mail.gmail.com>
Message-ID: <CAJF2gTQ_sa8pu9G1chP-ZbsCAba_a5yriuEu-0rKR==b24KUnQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 4:45=E2=80=AFAM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
> Enable the mmc controller driver and dma controller driver needed for
> T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
> boot from eMMC storage.
Yes, it's necessary to add this config for th1520.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ab86ec3b9eab..c5a8583236d0 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -168,12 +168,14 @@ CONFIG_MMC=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_PLTFM=3Dy
>  CONFIG_MMC_SDHCI_CADENCE=3Dy
> +CONFIG_MMC_SDHCI_OF_DWCMSHC=3Dy
>  CONFIG_MMC_SPI=3Dy
>  CONFIG_MMC_SUNXI=3Dy
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_SUN6I=3Dy
>  CONFIG_DMADEVICES=3Dy
>  CONFIG_DMA_SUN6I=3Dm
> +CONFIG_DW_AXI_DMAC=3Dy
>  CONFIG_VIRTIO_PCI=3Dy
>  CONFIG_VIRTIO_BALLOON=3Dy
>  CONFIG_VIRTIO_INPUT=3Dy
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
