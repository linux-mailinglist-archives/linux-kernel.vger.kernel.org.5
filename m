Return-Path: <linux-kernel+bounces-29048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142C38307A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF821C21DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03AD2032C;
	Wed, 17 Jan 2024 14:09:22 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF3200DD;
	Wed, 17 Jan 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500562; cv=none; b=t36JQBRbRcC3NxMuYA7heQUi6fRpofukFrg/3ta/KmWqwafJMpzSdu11RfgZidJxV3BhHrSWa0fWK7dEN0jNNuT0CWSYbY0OGuGcJmswRvZ0EV0FmpLE/fFE6jzvwUOggHLNRmVa+Idup1F9UbOpG7WnJqLL3PjTnqx5VD5/5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500562; c=relaxed/simple;
	bh=lM2ydu1mYi/ifYk43KYS+WDGObFA2FXugqlIuWEB+14=;
	h=Received:Date:From:To:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; b=uG3LX2KdZ1jnDf/qEXIh7FQyAjBdNTjgeV/uQwL2flJx6n0pxK0hr2NuK6S++1NbUSJPNOCkpqrOLyZ7qnIUrDfEVkDdFvWIGh3JfuQs4Iu93WlemVbvCs/QPmBAdYhJQ0U6KJFcL8jIVRy88Kji03ywLmTWDIoCoQIHxvuDNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rQ6bH-0003kO-0n;
	Wed, 17 Jan 2024 14:09:04 +0000
Date: Wed, 17 Jan 2024 14:08:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: linux-mediatek@lists.infradead.org, Jean Thomas <jean.thomas@wifirst.fr>,
 sean.wang@kernel.org, linus.walleij@linaro.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pinctrl: mediatek: mt7981: add additional emmc groups
User-Agent: K-9 Mail for Android
In-Reply-To: <20240117124234.3137050-2-jean.thomas@wifirst.fr>
References: <20240117124234.3137050-1-jean.thomas@wifirst.fr> <20240117124234.3137050-2-jean.thomas@wifirst.fr>
Message-ID: <B51A9EE5-1C7A-48C9-A546-61C269AD266F@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17 January 2024 12:42:34 UTC, Jean Thomas <jean=2Ethomas@wifirst=2Efr> =
wrote:
>Add new emmc groups in the pinctrl driver for the
>MediaTek MT7981 SoC:
>* emmc reset, with pin 15=2E
>* emmc 4-bit bus-width, with pins 16 to 19, and 24 to 25=2E
>* emmc 8-bit bus-width, with pins 16 to 25=2E
>
>The existing emmc_45 group is kept for legacy reasons, even
>if this is the union of emmc_reset and emmc_8 groups=2E
>
>Signed-off-by: Jean Thomas <jean=2Ethomas@wifirst=2Efr>

Reviewed-by: Daniel Golle <daniel@makrotopia=2Eorg>

>---
> drivers/pinctrl/mediatek/pinctrl-mt7981=2Ec | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981=2Ec b/drivers/pinctr=
l/mediatek/pinctrl-mt7981=2Ec
>index ca667ed25a4d=2E=2Eef6123765885 100644
>--- a/drivers/pinctrl/mediatek/pinctrl-mt7981=2Ec
>+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981=2Ec
>@@ -700,6 +700,15 @@ static int mt7981_drv_vbus_pins[] =3D { 14, };
> static int mt7981_drv_vbus_funcs[] =3D { 1, };
>=20
> /* EMMC */
>+static int mt7981_emmc_reset_pins[] =3D { 15, };
>+static int mt7981_emmc_reset_funcs[] =3D { 2, };
>+
>+static int mt7981_emmc_4_pins[] =3D { 16, 17, 18, 19, 24, 25, };
>+static int mt7981_emmc_4_funcs[] =3D { 2, 2, 2, 2, 2, 2, };
>+
>+static int mt7981_emmc_8_pins[] =3D { 16, 17, 18, 19, 20, 21, 22, 23, 24=
, 25, };
>+static int mt7981_emmc_8_funcs[] =3D { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, };
>+
> static int mt7981_emmc_45_pins[] =3D { 15, 16, 17, 18, 19, 20, 21, 22, 2=
3, 24, 25, };
> static int mt7981_emmc_45_funcs[] =3D { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,=
 };
>=20
>@@ -854,6 +863,12 @@ static const struct group_desc mt7981_groups[] =3D {
> 	PINCTRL_PIN_GROUP("udi", mt7981_udi),
> 	/* @GPIO(14) DRV_VBUS(1) */
> 	PINCTRL_PIN_GROUP("drv_vbus", mt7981_drv_vbus),
>+	/* @GPIO(15): EMMC_RSTB(2) */
>+	PINCTRL_PIN_GROUP("emmc_reset", mt7981_emmc_reset),
>+	/* @GPIO(16,17,18,19,24,25): EMMC_DATx, EMMC_CLK, EMMC_CMD */
>+	PINCTRL_PIN_GROUP("emmc_4", mt7981_emmc_4),
>+	/* @GPIO(16,17,18,19,20,21,22,23,24,25): EMMC_DATx, EMMC_CLK, EMMC_CMD =
*/
>+	PINCTRL_PIN_GROUP("emmc_8", mt7981_emmc_8),
> 	/* @GPIO(15,25): EMMC(2) */
> 	PINCTRL_PIN_GROUP("emmc_45", mt7981_emmc_45),
> 	/* @GPIO(16,21): SNFI(3) */
>@@ -957,7 +972,7 @@ static const char *mt7981_i2c_groups[] =3D { "i2c0_0"=
, "i2c0_1", "u2_phy_i2c",
> static const char *mt7981_pcm_groups[] =3D { "pcm", };
> static const char *mt7981_udi_groups[] =3D { "udi", };
> static const char *mt7981_usb_groups[] =3D { "drv_vbus", };
>-static const char *mt7981_flash_groups[] =3D { "emmc_45", "snfi", };
>+static const char *mt7981_flash_groups[] =3D { "emmc_reset", "emmc_4", "=
emmc_8", "emmc_45", "snfi", };
> static const char *mt7981_ethernet_groups[] =3D { "smi_mdc_mdio", "gbe_e=
xt_mdc_mdio",
> 	"wf0_mode1", "wf0_mode3", "mt7531_int", };
> static const char *mt7981_ant_groups[] =3D { "ant_sel", };

