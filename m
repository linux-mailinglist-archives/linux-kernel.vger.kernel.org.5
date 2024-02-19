Return-Path: <linux-kernel+bounces-71628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9585A802
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7781D1F25E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E73A1DE;
	Mon, 19 Feb 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRZiDo9P"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D53C09F;
	Mon, 19 Feb 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358310; cv=none; b=s/zWtNYzFXhLJm8+4jTsIfJzfJKgAU+jiARm7aQn+07+ZdHJabP/E99+gARGgjwk27dAhKUxcwKjiT91G3vgJr8gBFdkfHyNTHk/0Qc29K5vg324bYwnUvHJR5crYIbwOihZ9NP01weYuJcmEaK6gFNUBROG26NFHSkC2qXg0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358310; c=relaxed/simple;
	bh=icU/jxR0DFDHz5XD9AAV7lcBtUbJa4K2a1BPr/lVQOg=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=rVuECbyUJPwIztrlHLTCB0q5GC56rVmqe2zx8r6Hjv2Q/LA5k/610EitvQYb2fyXo2t0QNiW0hUCyvTQHPDws5DQn4p1apiAgsoNerFd8NEcIUsBxBJanwRPPs0jH5XMM0oQTVcojqzOjDKb+bq32pRHJJDVrIHIZQP88OnzHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRZiDo9P; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3eafbcb1c5so103413366b.0;
        Mon, 19 Feb 2024 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358307; x=1708963107; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiqLc5KdCmtjYQt/eIFsjHHh0iB3V/zgzPhPHivKtAs=;
        b=bRZiDo9PXa9+VKDjKADljVQkf4cPFN6ym9XX5wiIKCHgX6kg/EpiHWUYiwTYKijb54
         LItev2WCuyWWY18OKeyqcjybUqNjU+yp4W4ABb/hfC37Y84i8q4OeLb5lZLi5sU9MSH4
         7cg+ZWqH2dN9ThbqN2+/VD05cUjnzHrHPu3o82Dg/HhVsjG0gsdFrlJJvFr2ctq6/RuL
         lPlDBrypYSRIURvSXHpTjt1er6X0q1HUM+HuC0hljfphEkYOHkn3QU4aPd9SGJgEHKBd
         +XXE3tWBMpTHN9zC2NQKpCzwn8kQRBeUD5SwEJhs0kCPjd7Jj+G3H76L56dK580YF30c
         9bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358307; x=1708963107;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiqLc5KdCmtjYQt/eIFsjHHh0iB3V/zgzPhPHivKtAs=;
        b=Z4EIHk1j/DhSfCAsOqRm95EX1S0ZkZSfWKSsdSHj+fPMFdqvNyjy+W2tkv7tr18iGK
         1mr2DIFPasJAQJ4SUxR8vGUW33R+5oYhHLV0zoHULZqlypGr1NZ3/n26yTRJtaRnm+ce
         u5d5uJKTiRBDS6rPUbZ84YYGxv0a85dt7d2K8BNGGX4evNVgArNRUoVsCJjb0LFglKx/
         T11WgcTEgD1dva9YTXoT5HttctKcG3hL0+MvpnLtiEoOj9l0V5DXUE6vTB3VtpFzC/oA
         hPM7lW+7XtEJDacgVG7JPN11tpqMNcYJY2Qlb2xmR4jqbI+6bFOLv0vXE1HU484DzjJK
         X77g==
X-Forwarded-Encrypted: i=1; AJvYcCX38WLLdJbhz3FOzPkjqIAFVVLKXvIY0TMpNDu1f8Ias4ldEMla6J5WOYXAko8WoaLeBiFD523ZEpEaJMNTNThrJGNC3QWA6xr+OzTRbOF42UFt2WlIQRFez3DpJENx3AzLJQgAU8T2zdinTIYGqgk9pp/JQX8VmCjVTL20Zhv24IjhEC8bc+PnXQ+g8dIGCY/2Xz+GImJpbMcqUwJWlNW5ERQFITaQV5V+ChjcF+hp+nA8suA+q58rLhifmhysVn5ifiIYCuieZ69CexbGWMMGUdtsaY41XXIPDhdCODXZJjBnenrN3MkXyWY6b1RAC4F/L7GlOlexPJEUUGyiNAoMNlc=
X-Gm-Message-State: AOJu0Yz3zkXOK1pYz0UfPEWI69hknu4v9ioIbxNtTaqSR/rxlW6U5E0c
	EYRYtTZPkCnvYap9jB7BB4ZZIYL5IKNGxZ+rH2mSY2aQyHeJO6N3
X-Google-Smtp-Source: AGHT+IFtwqfaW9gJsxLy3j5F49CYy1xFjRlT0RRadI4Z0IOCUNhh1itGGGOPl5tKEJMCv67TBumOMw==
X-Received: by 2002:a17:906:851:b0:a3d:80d7:d1e3 with SMTP id f17-20020a170906085100b00a3d80d7d1e3mr7428154ejd.77.1708358306585;
        Mon, 19 Feb 2024 07:58:26 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id rf23-20020a1709076a1700b00a3da5bf6aa5sm3076542ejc.211.2024.02.19.07.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:58:26 -0800 (PST)
Content-Type: multipart/signed;
 boundary=f0caf17c841197981a0b66a2ac604de0b745306e0ba899959bfe0165d31f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 19 Feb 2024 16:58:25 +0100
Message-Id: <CZ96H72GI4Z0.SZJBZXA1VXJZ@gmail.com>
Subject: Re: [PATCH] phy: constify of_phandle_args in xlate
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Vinod Koul"
 <vkoul@kernel.org>, "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Chun-Kuang Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Jonathan Hunter" <jonathanh@nvidia.com>,
 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, <linux-phy@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-mediatek@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-renesas-soc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <linux-tegra@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>

--f0caf17c841197981a0b66a2ac604de0b745306e0ba899959bfe0165d31f
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Feb 17, 2024 at 10:39 AM CET, Krzysztof Kozlowski wrote:
> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c              |  2 +-
>  drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |  2 +-
>  drivers/phy/broadcom/phy-bcm-sr-pcie.c             |  2 +-
>  drivers/phy/broadcom/phy-bcm-sr-usb.c              |  2 +-
>  drivers/phy/broadcom/phy-bcm63xx-usbh.c            |  2 +-
>  drivers/phy/broadcom/phy-brcm-usb.c                |  2 +-
>  drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c    |  2 +-
>  drivers/phy/freescale/phy-fsl-lynx-28g.c           |  2 +-
>  drivers/phy/hisilicon/phy-histb-combphy.c          |  2 +-
>  drivers/phy/intel/phy-intel-lgm-combo.c            |  2 +-
>  drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |  2 +-
>  drivers/phy/marvell/phy-armada375-usb2.c           |  2 +-
>  drivers/phy/marvell/phy-armada38x-comphy.c         |  2 +-
>  drivers/phy/marvell/phy-berlin-sata.c              |  2 +-
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |  2 +-
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |  2 +-
>  drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c        |  2 +-
>  drivers/phy/mediatek/phy-mtk-tphy.c                |  2 +-
>  drivers/phy/mediatek/phy-mtk-xsphy.c               |  2 +-
>  drivers/phy/microchip/lan966x_serdes.c             |  2 +-
>  drivers/phy/microchip/sparx5_serdes.c              |  2 +-
>  drivers/phy/mscc/phy-ocelot-serdes.c               |  2 +-
>  drivers/phy/phy-core.c                             |  8 ++++----
>  drivers/phy/phy-xgene.c                            |  2 +-
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  2 +-
>  drivers/phy/ralink/phy-mt7621-pci.c                |  2 +-
>  drivers/phy/renesas/phy-rcar-gen2.c                |  2 +-
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  2 +-
>  drivers/phy/renesas/r8a779f0-ether-serdes.c        |  2 +-
>  drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  2 +-
>  drivers/phy/rockchip/phy-rockchip-pcie.c           |  2 +-
>  drivers/phy/samsung/phy-exynos-mipi-video.c        |  2 +-
>  drivers/phy/samsung/phy-exynos5-usbdrd.c           |  2 +-
>  drivers/phy/samsung/phy-samsung-usb2.c             |  2 +-
>  drivers/phy/socionext/phy-uniphier-usb2.c          |  2 +-
>  drivers/phy/st/phy-miphy28lp.c                     |  2 +-
>  drivers/phy/st/phy-spear1310-miphy.c               |  2 +-
>  drivers/phy/st/phy-spear1340-miphy.c               |  2 +-
>  drivers/phy/st/phy-stm32-usbphyc.c                 |  2 +-
>  drivers/phy/tegra/xusb.c                           |  2 +-
>  drivers/phy/ti/phy-am654-serdes.c                  |  2 +-
>  drivers/phy/ti/phy-da8xx-usb.c                     |  2 +-
>  drivers/phy/ti/phy-gmii-sel.c                      |  2 +-
>  drivers/phy/xilinx/phy-zynqmp.c                    |  2 +-
>  drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |  2 +-
>  include/linux/phy/phy.h                            | 14 +++++++-------
>  46 files changed, 55 insertions(+), 55 deletions(-)

Makes sense:

Acked-by: Thierry Reding <treding@nvidia.com>

--f0caf17c841197981a0b66a2ac604de0b745306e0ba899959bfe0165d31f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXTeqIACgkQ3SOs138+
s6GdEBAAsZtqIRL7k6ZV5nu5N0juG6RO7Sm34o9+isHlbNUAhmDQeIXxdlWIF3qc
ap2W/H4jLtQnrDaCtdFWa5oPx8Ud41AKoeOQRlZq6goHZemt2JbUyB5IzsMIL0KN
FUGwvVEZdDnJbhe2+8YX0fN8WG4qpAYo7vrb1XsgP4RzGwgkwH64LbCOtoAoYtYl
rOc7hn6eNJrIYlW1LaU37BApWV0KgdMiI1YSILAT5YJK24fYst7j//8UxyEQP4aO
S+3uPr8/1K1JifAihpgqu7w5kyDcMW1ncoAamilKe2xDzz7wJ8wxtYcdypnwBSpd
/+rhMybnEj2kgbDrSbY+LVlczSU6Wf/SEtZzB+DOCE4+CZrtFyMVsSgAeVXFT1n0
L5vTh0182skHEAm97GXHwoQOmLND8wJJVZR+Sw1OApxEYI1Y8hTx33NrbA+5hiVq
15m0Jq8NXvpd237p5obNfFNuDmK/BlMhlq3x+3/aWGqT+pRlavF1i0HP/wEV9YoC
6zleWWkx9BAonksD76uhrk/LBnYnc3wb9O5B4KS6dp+tYE3ekIWauHxzhg4tpOcg
FqcY6ObCs+Jjtplo4vtrTBR6A4jdvunJQcp4WqSO/5RkZd/ySVdSbpvCdK1yy/JM
j7SSnUWV03IbkbGoBduin/a8YT84GAn3seVzxO0ik5dpZHGbAPM=
=Z186
-----END PGP SIGNATURE-----

--f0caf17c841197981a0b66a2ac604de0b745306e0ba899959bfe0165d31f--

