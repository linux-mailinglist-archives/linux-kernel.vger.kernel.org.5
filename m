Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11157B34A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjI2OPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjI2OOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:14:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EADB198E;
        Fri, 29 Sep 2023 07:14:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC54C433C7;
        Fri, 29 Sep 2023 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996864;
        bh=ssgQ4DcrH/d/Y+jEvzsOmpDXmXsE5fRXbAXnRqgGFOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npMVbxDWkXnJ0AZ/ihiW4E4CWPHnPma+H6SHej/md4QeFTyyQggNcuIOyDV1WNlgz
         csrzjxvpjOpM9/JsOvKMP0xu3u9dxELMt5Ez4gBczCJVYXX/1ZORK/tPa/+AD8n2i+
         TUDS7ebJGzZAQysn6kimS8sJD60t5KRICZppv9vbRLM/Gc5hhJtpccDWe6mCJyCaKb
         k/KgGwSFbSgumJm4sb4PioBzGesH2+4a77bkAUMI3CGv1eDuldkxNNPkdSqpkL6unX
         1KaUj0QfaaNcpOSWU29N6GdQQjdfNsiBxaaHwigXE2HF8LWjXMLGJtNaEZoC4Rmvop
         Nt/LpVSXKNfew==
Date:   Fri, 29 Sep 2023 15:14:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
Subject: Re: [PATCH 5/5] riscv: configs: defconfig: Enable configs required
 for RZ/Five SoC
Message-ID: <20230929-professed-imperfect-4b2ed9073e04@spud>
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230929000704.53217-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZzHljyrsO//eh7DR"
Content-Disposition: inline
In-Reply-To: <20230929000704.53217-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZzHljyrsO//eh7DR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 01:07:04AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Enable the configs required by the below IP blocks which are
> present on RZ/Five SoC:
> * ADC
> * CANFD
> * DMAC
> * eMMC/SDHI
> * OSTM
> * RAVB (+ Micrel PHY)
> * RIIC
> * RSPI
> * SSI (Sound+WM8978 codec)
> * Thermal
> * USB (PHY/RESET/OTG)
>=20
> Along with the above some core configs are enabled too,
> -> CPU frequency scaling as RZ/Five does support this.
> -> MTD is enabled as RSPI can be connected to flash chips
> -> Enabled I2C chardev so that it enables userspace to read/write
>    i2c devices (similar to arm64)
> -> Thermal configs as RZ/Five SoC does have thermal unit
> -> GPIO regulator as we might have IP blocks for which voltage
>    levels are controlled by GPIOs

You might or you do?

Either way, this stuff seems fine to me /shrug

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> -> OTG configs as RZ/Five USB can support host/function
> -> Gadget configs so that we can test USB function (as done in arm64
>    all the gadget configs are enabled)
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/riscv/configs/defconfig | 52 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ab86ec3b9eab..1e81c865a271 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -36,6 +36,13 @@ CONFIG_SMP=3Dy
>  CONFIG_HOTPLUG_CPU=3Dy
>  CONFIG_PM=3Dy
>  CONFIG_CPU_IDLE=3Dy
> +CONFIG_CPU_FREQ=3Dy
> +CONFIG_CPU_FREQ_STAT=3Dy
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
> +CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
> +CONFIG_CPUFREQ_DT=3Dy
>  CONFIG_VIRTUALIZATION=3Dy
>  CONFIG_KVM=3Dm
>  CONFIG_ACPI=3Dy
> @@ -94,6 +101,7 @@ CONFIG_NETLINK_DIAG=3Dy
>  CONFIG_CGROUP_NET_PRIO=3Dy
>  CONFIG_NET_9P=3Dy
>  CONFIG_NET_9P_VIRTIO=3Dy
> +CONFIG_CAN=3Dm
>  CONFIG_PCI=3Dy
>  CONFIG_PCIEPORTBUS=3Dy
>  CONFIG_PCI_HOST_GENERIC=3Dy
> @@ -101,6 +109,11 @@ CONFIG_PCIE_XILINX=3Dy
>  CONFIG_PCIE_FU740=3Dy
>  CONFIG_DEVTMPFS=3Dy
>  CONFIG_DEVTMPFS_MOUNT=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_MTD_BLOCK=3Dy
> +CONFIG_MTD_CFI=3Dy
> +CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
> +CONFIG_MTD_SPI_NOR=3Dy
>  CONFIG_BLK_DEV_LOOP=3Dy
>  CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_BLK_DEV_NVME=3Dm
> @@ -123,8 +136,11 @@ CONFIG_VIRTIO_NET=3Dy
>  CONFIG_MACB=3Dy
>  CONFIG_E1000E=3Dy
>  CONFIG_R8169=3Dy
> +CONFIG_RAVB=3Dy
>  CONFIG_STMMAC_ETH=3Dm
> +CONFIG_MICREL_PHY=3Dy
>  CONFIG_MICROSEMI_PHY=3Dy
> +CONFIG_CAN_RCAR_CANFD=3Dm
>  CONFIG_INPUT_MOUSEDEV=3Dy
>  CONFIG_KEYBOARD_SUN4I_LRADC=3Dm
>  CONFIG_SERIAL_8250=3Dy
> @@ -135,16 +151,24 @@ CONFIG_SERIAL_SH_SCI=3Dy
>  CONFIG_VIRTIO_CONSOLE=3Dy
>  CONFIG_HW_RANDOM=3Dy
>  CONFIG_HW_RANDOM_VIRTIO=3Dy
> +CONFIG_I2C_CHARDEV=3Dm
>  CONFIG_I2C_MV64XXX=3Dm
> +CONFIG_I2C_RIIC=3Dy
>  CONFIG_SPI=3Dy
> +CONFIG_SPI_RSPI=3Dm
>  CONFIG_SPI_SIFIVE=3Dy
>  CONFIG_SPI_SUN6I=3Dy
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_GPIO_SIFIVE=3Dy
> +CONFIG_CPU_THERMAL=3Dy
> +CONFIG_DEVFREQ_THERMAL=3Dy
> +CONFIG_RZG2L_THERMAL=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_SUNXI_WATCHDOG=3Dy
> +CONFIG_RENESAS_RZG2LWDT=3Dy
>  CONFIG_REGULATOR=3Dy
>  CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> +CONFIG_REGULATOR_GPIO=3Dy
>  CONFIG_DRM=3Dm
>  CONFIG_DRM_RADEON=3Dm
>  CONFIG_DRM_NOUVEAU=3Dm
> @@ -152,39 +176,67 @@ CONFIG_DRM_SUN4I=3Dm
>  CONFIG_DRM_VIRTIO_GPU=3Dm
>  CONFIG_FB=3Dy
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> +CONFIG_SOUND=3Dy
> +CONFIG_SND=3Dy
> +CONFIG_SND_SOC=3Dy
> +CONFIG_SND_SOC_RZ=3Dm
> +CONFIG_SND_SOC_WM8978=3Dm
> +CONFIG_SND_SIMPLE_CARD=3Dm
>  CONFIG_USB=3Dy
> +CONFIG_USB_OTG=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
>  CONFIG_USB_XHCI_PLATFORM=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> +CONFIG_USB_RENESAS_USBHS=3Dm
>  CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_UAS=3Dy
>  CONFIG_USB_MUSB_HDRC=3Dm
>  CONFIG_USB_MUSB_SUNXI=3Dm
>  CONFIG_NOP_USB_XCEIV=3Dm
> +CONFIG_USB_GADGET=3Dy
> +CONFIG_USB_RENESAS_USBHS_UDC=3Dm
> +CONFIG_USB_CONFIGFS=3Dm
> +CONFIG_USB_CONFIGFS_SERIAL=3Dy
> +CONFIG_USB_CONFIGFS_ACM=3Dy
> +CONFIG_USB_CONFIGFS_OBEX=3Dy
> +CONFIG_USB_CONFIGFS_NCM=3Dy
> +CONFIG_USB_CONFIGFS_ECM=3Dy
> +CONFIG_USB_CONFIGFS_ECM_SUBSET=3Dy
> +CONFIG_USB_CONFIGFS_RNDIS=3Dy
> +CONFIG_USB_CONFIGFS_EEM=3Dy
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
> +CONFIG_USB_CONFIGFS_F_FS=3Dy
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_PLTFM=3Dy
>  CONFIG_MMC_SDHCI_CADENCE=3Dy
>  CONFIG_MMC_SPI=3Dy
> +CONFIG_MMC_SDHI=3Dy
>  CONFIG_MMC_SUNXI=3Dy
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_SUN6I=3Dy
>  CONFIG_DMADEVICES=3Dy
>  CONFIG_DMA_SUN6I=3Dm
> +CONFIG_RZ_DMAC=3Dy
>  CONFIG_VIRTIO_PCI=3Dy
>  CONFIG_VIRTIO_BALLOON=3Dy
>  CONFIG_VIRTIO_INPUT=3Dy
>  CONFIG_VIRTIO_MMIO=3Dy
> +CONFIG_RENESAS_OSTM=3Dy
>  CONFIG_SUN8I_DE2_CCU=3Dm
>  CONFIG_SUN50I_IOMMU=3Dy
>  CONFIG_RPMSG_CHAR=3Dy
>  CONFIG_RPMSG_CTRL=3Dy
>  CONFIG_RPMSG_VIRTIO=3Dy
>  CONFIG_ARCH_R9A07G043=3Dy
> +CONFIG_IIO=3Dy
> +CONFIG_RZG2L_ADC=3Dm
> +CONFIG_RESET_RZG2L_USBPHY_CTRL=3Dy
>  CONFIG_PHY_SUN4I_USB=3Dm
> +CONFIG_PHY_RCAR_GEN3_USB2=3Dy
>  CONFIG_LIBNVDIMM=3Dy
>  CONFIG_NVMEM_SUNXI_SID=3Dy
>  CONFIG_EXT4_FS=3Dy
> --=20
> 2.34.1
>=20

--ZzHljyrsO//eh7DR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbbuwAKCRB4tDGHoIJi
0oUWAQDEFgrLqWHwmNtRPP3fdgf0qPAGTqG2pKoks0K/CtjkIAD/RGWbDhSN0ofN
oXGkFKzf1k0ZLIum+eG+buAIwWjeTwc=
=p1UH
-----END PGP SIGNATURE-----

--ZzHljyrsO//eh7DR--
