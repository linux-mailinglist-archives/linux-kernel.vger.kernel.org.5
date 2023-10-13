Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CCE7C7E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjJMH2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJMH2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:28:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B8B7;
        Fri, 13 Oct 2023 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697182092; x=1728718092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+TKsRjxrX6tB1ZMIkNFNS1tku+Zy3RG3lIVtHGUk82U=;
  b=XF8FeLe88nH8Uu0Xd/MpMAA70qpdDrk7LZcJ8sQARJcFUDNtpnOzK9gc
   Ix/LuR35LML7nay6yFpH+HesWvX/F+rJxfrDfzVrhJmHDlYiwIhJVnKp8
   R3N6ivVaJg/yRk7tn6QaEDucD50+jqOTxetjlZUhjLsQgLFHcJJEjOAGQ
   wnWd328mMKwpVcx6HYPvquxetdtYGdvqB+ylIxGWbc6m3oA5M9Vvj7kcq
   /5P+8YqvWAPtl8vIfQyUhbfPP2FwyLCMvUktbD/DCD9IMeYYqdrBZ5zBr
   SoFxPQx7/rtpMZYbXSe8OBnexfCCbk2F+KA6LIsOCGPksmXXH4xNssU84
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,221,1694728800"; 
   d="scan'208";a="33446454"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2023 09:28:10 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2A520280082;
        Fri, 13 Oct 2023 09:28:10 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Sandor Yu <Sandor.yu@nxp.com>,
        Sandor.yu@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com,
        sam@ravnborg.org
Subject: Re: [PATCH v10 4/7] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Date:   Fri, 13 Oct 2023 09:28:10 +0200
Message-ID: <5605026.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <037c61d582df78a3309a5672ac66b9e74b396ddd.1697162990.git.Sandor.yu@nxp.com>
References: <cover.1697162990.git.Sandor.yu@nxp.com> <037c61d582df78a3309a5672ac66b9e74b396ddd.1697162990.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandor,

thanks for the updated series.

Am Freitag, 13. Oktober 2023, 05:24:23 CEST schrieb Sandor Yu:
> Add a new DRM DisplayPort and HDMI bridge driver for Candence MHDP8501
> used in i.MX8MQ SOC. MHDP8501 could support HDMI or DisplayPort
> standards according embedded Firmware running in the uCPU.
>=20
> For iMX8MQ SOC, the DisplayPort/HDMI FW was loaded and activated by
> SOC's ROM code. Bootload binary included respective specific firmware
> is required.
>=20
> Driver will check display connector type and
> then load the corresponding driver.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> v9->v10:
>  - struct cdns_mhdp_device is renamed to cdns_mhdp8501_device.
>  - update for mhdp helper driver is introduced.
> Remove head file cdns-mhdp-mailbox.h and add cdns-mhdp-helper.h
> Add struct cdns_mhdp_base base to struct cdns_mhdp8501_device.
> Init struct cdns_mhdp_base base when driver probe.
>=20
>  drivers/gpu/drm/bridge/cadence/Kconfig        |  16 +
>  drivers/gpu/drm/bridge/cadence/Makefile       |   2 +
>  .../drm/bridge/cadence/cdns-mhdp8501-core.c   | 316 ++++++++
>  .../drm/bridge/cadence/cdns-mhdp8501-core.h   | 365 +++++++++
>  .../gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c | 708 ++++++++++++++++++
>  .../drm/bridge/cadence/cdns-mhdp8501-hdmi.c   | 673 +++++++++++++++++
>  6 files changed, 2080 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-core.c
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-core.h
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
>=20
> [...]
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c new file mode 100644
> index 0000000000000..73d1c35a74599
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
> @@ -0,0 +1,673 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Cadence MHDP8501 HDMI bridge driver
> + *
> + * Copyright (C) 2019-2023 NXP Semiconductor, Inc.
> + *
> + */
> +#include <drm/display/drm_hdmi_helper.h>
> +#include <drm/display/drm_scdc_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_print.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/phy-hdmi.h>
> +
> +#include "cdns-mhdp8501-core.h"
> +
> +/**
> + * cdns_hdmi_infoframe_set() - fill the HDMI AVI infoframe
> + * @mhdp: phandle to mhdp device.
> + * @entry_id: The packet memory address in which the data is written.
> + * @packet_len: 32, only 32 bytes now.
> + * @packet: point to InfoFrame Packet.
> + *          packet[0] =3D 0
> + *          packet[1-3] =3D HB[0-2]  InfoFrame Packet Header
> + *          packet[4-31 =3D PB[0-27] InfoFrame Packet Contents
> + * @packet_type: Packet Type of InfoFrame in HDMI Specification.
> + *
> + */
> +static void cdns_hdmi_infoframe_set(struct cdns_mhdp8501_device *mhdp,
> +				    u8 entry_id, u8 packet_len,
> +				    u8 *packet, u8 packet_type)
> +{
> +	u32 packet32, len32;
> +	u32 val, i;
> +
> +	/* only support 32 bytes now */
> +	if (packet_len !=3D 32)
> +		return;
> +
> +	/* invalidate entry */
> +	val =3D F_ACTIVE_IDLE_TYPE(1) | F_PKT_ALLOC_ADDRESS(entry_id);
> +	writel(val, mhdp->regs + SOURCE_PIF_PKT_ALLOC_REG);
> +	writel(F_PKT_ALLOC_WR_EN(1), mhdp->regs +=20
SOURCE_PIF_PKT_ALLOC_WR_EN);
> +
> +	/* flush fifo 1 */
> +	writel(F_FIFO1_FLUSH(1), mhdp->regs + SOURCE_PIF_FIFO1_FLUSH);
> +
> +	/* write packet into memory */
> +	len32 =3D packet_len / 4;
> +	for (i =3D 0; i < len32; i++) {
> +		packet32 =3D get_unaligned_le32(packet + 4 * i);
> +		writel(F_DATA_WR(packet32), mhdp->regs +=20
SOURCE_PIF_DATA_WR);
> +	}
> +
> +	/* write entry id */
> +	writel(F_WR_ADDR(entry_id), mhdp->regs + SOURCE_PIF_WR_ADDR);
> +
> +	/* write request */
> +	writel(F_HOST_WR(1), mhdp->regs + SOURCE_PIF_WR_REQ);
> +
> +	/* update entry */
> +	val =3D F_ACTIVE_IDLE_TYPE(1) | F_TYPE_VALID(1) |
> +		F_PACKET_TYPE(packet_type) |=20
=46_PKT_ALLOC_ADDRESS(entry_id);
> +	writel(val, mhdp->regs + SOURCE_PIF_PKT_ALLOC_REG);
> +
> +	writel(F_PKT_ALLOC_WR_EN(1), mhdp->regs +=20
SOURCE_PIF_PKT_ALLOC_WR_EN);
> +}
> +
> +static int cdns_hdmi_get_edid_block(void *data, u8 *edid,
> +				    u32 block, size_t length)
> +{
> +	struct cdns_mhdp8501_device *mhdp =3D data;
> +	u8 msg[2], reg[5], i;
> +	int ret;
> +
> +	mutex_lock(&mhdp->mbox_mutex);
> +
> +	for (i =3D 0; i < 4; i++) {
> +		msg[0] =3D block / 2;
> +		msg[1] =3D block % 2;
> +
> +		ret =3D cdns_mhdp_mailbox_send(&mhdp->base,=20
MB_MODULE_ID_HDMI_TX,
> HDMI_TX_EDID, +					     sizeof(msg),=20
msg);
> +		if (ret)
> +			continue;
> +
> +		ret =3D cdns_mhdp_mailbox_recv_header(&mhdp->base,=20
MB_MODULE_ID_HDMI_TX,
> +						    HDMI_TX_EDID,=20
sizeof(reg) + length);
> +		if (ret)
> +			continue;
> +
> +		ret =3D cdns_mhdp_mailbox_recv_data(&mhdp->base, reg,=20
sizeof(reg));
> +		if (ret)
> +			continue;
> +
> +		ret =3D cdns_mhdp_mailbox_recv_data(&mhdp->base, edid,=20
length);
> +		if (ret)
> +			continue;
> +
> +		if ((reg[3] << 8 | reg[4]) =3D=3D length)
> +			break;
> +	}
> +
> +	mutex_unlock(&mhdp->mbox_mutex);
> +
> +	if (ret)
> +		DRM_ERROR("get block[%d] edid failed: %d\n", block, ret);
> +	return ret;
> +}
> +
> +static int cdns_hdmi_scdc_write(struct cdns_mhdp8501_device *mhdp, u8 ad=
dr,
> u8 value) +{
> +	u8 msg[5], reg[5];
> +	int ret;
> +
> +	msg[0] =3D 0x54;
> +	msg[1] =3D addr;
> +	msg[2] =3D 0;
> +	msg[3] =3D 1;
> +	msg[4] =3D value;
> +
> +	mutex_lock(&mhdp->mbox_mutex);

I don't like that locking. Sometimes the mutex is locked by HDMI driver,=20
sometimes within the helper.
What is this mutex actually protecting? Concurrent access to the mailbox or=
 a=20
programming sequence which must not be interrupted aka critical section? Wh=
en=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider


