Return-Path: <linux-kernel+bounces-33012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C483632D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6DB28944C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187C3D0C0;
	Mon, 22 Jan 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fjmbiOm2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bI7NJ+GN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fjmbiOm2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bI7NJ+GN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762CE3CF7C;
	Mon, 22 Jan 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926316; cv=none; b=iXfUXN62KV6tDkd6ViOoIhncxZXzyD7QuZQE6K4rQMyjsCc5TBvRPMrefrkdcdqU+G2FCWiUREJs2tfE70Xyku+ixLnSzRllimhbNnoPOsUePmC63QEqR4mnWdTgV2f8+w0zNzCOy6iUjT1HI4xZwgShb1VoyZ6gWdVuFuw/k2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926316; c=relaxed/simple;
	bh=FEBLCBrb4dmxn/kCjlRtmLDnZUrb8JVxGjOp7g3+nck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJZbC5i805i22swP6amSt+kxgV4TnRNGVPs+Xve8zurC13HgXOFuUqSfAFj9/QGuRjwNAbNr3thAn36h4KAMkor8NfPoaSW1rPiubk/eDxCBau7hxR96KvcWaBZKyrVphXPh6lEeP2bujlvCflx7WYpYleRVL9gffR87MaECZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fjmbiOm2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bI7NJ+GN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fjmbiOm2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bI7NJ+GN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9753F1FBB3;
	Mon, 22 Jan 2024 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705926312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6FewvjNoG1xpItb6wa8VF6bLiqNArPKn6IHAuHKh9w=;
	b=fjmbiOm2mC64C43bdd9C3yRJCO6jOZs/atlC9/rXvFdt1+lwGHzXrQY+W+YYjXhO23sz8L
	A7K5MM6NP0hfbf5bYAg4i2iCfUpH4iEOGTcREjU9N2Wxf/mz8ZYeN+QSj0sMuwi201w2+w
	Ke3AmGEPNcfqUeDbTdt3PRWENi88UzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705926312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6FewvjNoG1xpItb6wa8VF6bLiqNArPKn6IHAuHKh9w=;
	b=bI7NJ+GNUIsjtRXkgvPWX1ROulpp+tCwzHwUmYJqfXXdGAyF/h8/91LrUV7qe8Utayc4Lc
	UU3G/Vh3RevQgmBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705926312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6FewvjNoG1xpItb6wa8VF6bLiqNArPKn6IHAuHKh9w=;
	b=fjmbiOm2mC64C43bdd9C3yRJCO6jOZs/atlC9/rXvFdt1+lwGHzXrQY+W+YYjXhO23sz8L
	A7K5MM6NP0hfbf5bYAg4i2iCfUpH4iEOGTcREjU9N2Wxf/mz8ZYeN+QSj0sMuwi201w2+w
	Ke3AmGEPNcfqUeDbTdt3PRWENi88UzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705926312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6FewvjNoG1xpItb6wa8VF6bLiqNArPKn6IHAuHKh9w=;
	b=bI7NJ+GNUIsjtRXkgvPWX1ROulpp+tCwzHwUmYJqfXXdGAyF/h8/91LrUV7qe8Utayc4Lc
	UU3G/Vh3RevQgmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECD65139A2;
	Mon, 22 Jan 2024 12:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BWcbNqdermV2LQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Mon, 22 Jan 2024 12:25:11 +0000
Message-ID: <ce1b41a4-a9bc-4dbc-ae85-5187b3cab10b@suse.de>
Date: Mon, 22 Jan 2024 15:25:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.09



On 1/22/24 15:02, Konrad Dybcio wrote:
> This SoC family was destined for server use, featuring Qualcomm's very
> interesting Kryo cores (before "Kryo" became a marketing term for Arm
> cores with small modifications). It did however not leave the labs of
> Qualcomm and presumably some partners, nor was it ever productized.

You forgot the net-next prefix

> 
> Remove the related drivers, as they seem to be long obsolete.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>



> ---
> Compile-tested only
> ---
>  drivers/net/ethernet/qualcomm/emac/Makefile        |   3 +-
>  .../ethernet/qualcomm/emac/emac-sgmii-qdf2400.c    | 215 ---------------------
>  .../ethernet/qualcomm/emac/emac-sgmii-qdf2432.c    | 202 -------------------
>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c    | 120 ++----------
>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.h    |   2 -
>  5 files changed, 21 insertions(+), 521 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/emac/Makefile b/drivers/net/ethernet/qualcomm/emac/Makefile
> index 61d15e091be2..ffc00995acb9 100644
> --- a/drivers/net/ethernet/qualcomm/emac/Makefile
> +++ b/drivers/net/ethernet/qualcomm/emac/Makefile
> @@ -6,5 +6,4 @@
>  obj-$(CONFIG_QCOM_EMAC) += qcom-emac.o
>  
>  qcom-emac-objs := emac.o emac-mac.o emac-phy.o emac-sgmii.o emac-ethtool.o \
> -		  emac-sgmii-fsm9900.o emac-sgmii-qdf2432.o \
> -		  emac-sgmii-qdf2400.o
> +		  emac-sgmii-fsm9900.o
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii-qdf2400.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii-qdf2400.c
> deleted file mode 100644
> index b29148ce7e05..000000000000
> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii-qdf2400.c
> +++ /dev/null
> @@ -1,215 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> - */
> -
> -/* Qualcomm Technologies, Inc. QDF2400 EMAC SGMII Controller driver.
> - */
> -
> -#include <linux/iopoll.h>
> -#include "emac.h"
> -
> -/* EMAC_SGMII register offsets */
> -#define EMAC_SGMII_PHY_TX_PWR_CTRL		0x000C
> -#define EMAC_SGMII_PHY_LANE_CTRL1		0x0018
> -#define EMAC_SGMII_PHY_CDR_CTRL0		0x0058
> -#define EMAC_SGMII_PHY_POW_DWN_CTRL0		0x0080
> -#define EMAC_SGMII_PHY_RESET_CTRL		0x00a8
> -#define EMAC_SGMII_PHY_INTERRUPT_MASK		0x00b4
> -
> -/* SGMII digital lane registers */
> -#define EMAC_SGMII_LN_DRVR_CTRL0		0x000C
> -#define EMAC_SGMII_LN_DRVR_CTRL1		0x0010
> -#define EMAC_SGMII_LN_DRVR_TAP_EN		0x0018
> -#define EMAC_SGMII_LN_TX_MARGINING		0x001C
> -#define EMAC_SGMII_LN_TX_PRE			0x0020
> -#define EMAC_SGMII_LN_TX_POST			0x0024
> -#define EMAC_SGMII_LN_TX_BAND_MODE		0x0060
> -#define EMAC_SGMII_LN_LANE_MODE			0x0064
> -#define EMAC_SGMII_LN_PARALLEL_RATE		0x007C
> -#define EMAC_SGMII_LN_CML_CTRL_MODE0		0x00C0
> -#define EMAC_SGMII_LN_MIXER_CTRL_MODE0		0x00D8
> -#define EMAC_SGMII_LN_VGA_INITVAL		0x013C
> -#define EMAC_SGMII_LN_UCDR_FO_GAIN_MODE0	0x0184
> -#define EMAC_SGMII_LN_UCDR_SO_GAIN_MODE0	0x0190
> -#define EMAC_SGMII_LN_UCDR_SO_CONFIG		0x019C
> -#define EMAC_SGMII_LN_RX_BAND			0x01A4
> -#define EMAC_SGMII_LN_RX_RCVR_PATH1_MODE0	0x01C0
> -#define EMAC_SGMII_LN_RSM_CONFIG		0x01F8
> -#define EMAC_SGMII_LN_SIGDET_ENABLES		0x0230
> -#define EMAC_SGMII_LN_SIGDET_CNTRL		0x0234
> -#define EMAC_SGMII_LN_SIGDET_DEGLITCH_CNTRL	0x0238
> -#define EMAC_SGMII_LN_RX_EN_SIGNAL		0x02AC
> -#define EMAC_SGMII_LN_RX_MISC_CNTRL0		0x02B8
> -#define EMAC_SGMII_LN_DRVR_LOGIC_CLKDIV		0x02C8
> -#define EMAC_SGMII_LN_RX_RESECODE_OFFSET	0x02CC
> -
> -/* SGMII digital lane register values */
> -#define UCDR_STEP_BY_TWO_MODE0			BIT(7)
> -#define UCDR_xO_GAIN_MODE(x)			((x) & 0x7f)
> -#define UCDR_ENABLE				BIT(6)
> -#define UCDR_SO_SATURATION(x)			((x) & 0x3f)
> -
> -#define SIGDET_LP_BYP_PS4			BIT(7)
> -#define SIGDET_EN_PS0_TO_PS2			BIT(6)
> -
> -#define TXVAL_VALID_INIT			BIT(4)
> -#define KR_PCIGEN3_MODE				BIT(0)
> -
> -#define MAIN_EN					BIT(0)
> -
> -#define TX_MARGINING_MUX			BIT(6)
> -#define TX_MARGINING(x)				((x) & 0x3f)
> -
> -#define TX_PRE_MUX				BIT(6)
> -
> -#define TX_POST_MUX				BIT(6)
> -
> -#define CML_GEAR_MODE(x)			(((x) & 7) << 3)
> -#define CML2CMOS_IBOOST_MODE(x)			((x) & 7)
> -
> -#define RESCODE_OFFSET(x)			((x) & 0x1f)
> -
> -#define MIXER_LOADB_MODE(x)			(((x) & 0xf) << 2)
> -#define MIXER_DATARATE_MODE(x)			((x) & 3)
> -
> -#define VGA_THRESH_DFE(x)			((x) & 0x3f)
> -
> -#define SIGDET_LP_BYP_PS0_TO_PS2		BIT(5)
> -#define SIGDET_FLT_BYP				BIT(0)
> -
> -#define SIGDET_LVL(x)				(((x) & 0xf) << 4)
> -
> -#define SIGDET_DEGLITCH_CTRL(x)			(((x) & 0xf) << 1)
> -
> -#define INVERT_PCS_RX_CLK			BIT(7)
> -
> -#define DRVR_LOGIC_CLK_EN			BIT(4)
> -#define DRVR_LOGIC_CLK_DIV(x)			((x) & 0xf)
> -
> -#define PARALLEL_RATE_MODE0(x)			((x) & 0x3)
> -
> -#define BAND_MODE0(x)				((x) & 0x3)
> -
> -#define LANE_MODE(x)				((x) & 0x1f)
> -
> -#define CDR_PD_SEL_MODE0(x)			(((x) & 0x3) << 5)
> -#define EN_DLL_MODE0				BIT(4)
> -#define EN_IQ_DCC_MODE0				BIT(3)
> -#define EN_IQCAL_MODE0				BIT(2)
> -
> -#define BYPASS_RSM_SAMP_CAL			BIT(1)
> -#define BYPASS_RSM_DLL_CAL			BIT(0)
> -
> -#define L0_RX_EQUALIZE_ENABLE			BIT(6)
> -
> -#define PWRDN_B					BIT(0)
> -
> -#define CDR_MAX_CNT(x)				((x) & 0xff)
> -
> -#define SERDES_START_WAIT_TIMES			100
> -
> -struct emac_reg_write {
> -	unsigned int offset;
> -	u32 val;
> -};
> -
> -static void emac_reg_write_all(void __iomem *base,
> -			       const struct emac_reg_write *itr, size_t size)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < size; ++itr, ++i)
> -		writel(itr->val, base + itr->offset);
> -}
> -
> -static const struct emac_reg_write sgmii_laned[] = {
> -	/* CDR Settings */
> -	{EMAC_SGMII_LN_UCDR_FO_GAIN_MODE0,
> -		UCDR_STEP_BY_TWO_MODE0 | UCDR_xO_GAIN_MODE(10)},
> -	{EMAC_SGMII_LN_UCDR_SO_GAIN_MODE0, UCDR_xO_GAIN_MODE(0)},
> -	{EMAC_SGMII_LN_UCDR_SO_CONFIG, UCDR_ENABLE | UCDR_SO_SATURATION(12)},
> -
> -	/* TX/RX Settings */
> -	{EMAC_SGMII_LN_RX_EN_SIGNAL, SIGDET_LP_BYP_PS4 | SIGDET_EN_PS0_TO_PS2},
> -
> -	{EMAC_SGMII_LN_DRVR_CTRL0, TXVAL_VALID_INIT | KR_PCIGEN3_MODE},
> -	{EMAC_SGMII_LN_DRVR_TAP_EN, MAIN_EN},
> -	{EMAC_SGMII_LN_TX_MARGINING, TX_MARGINING_MUX | TX_MARGINING(25)},
> -	{EMAC_SGMII_LN_TX_PRE, TX_PRE_MUX},
> -	{EMAC_SGMII_LN_TX_POST, TX_POST_MUX},
> -
> -	{EMAC_SGMII_LN_CML_CTRL_MODE0,
> -		CML_GEAR_MODE(1) | CML2CMOS_IBOOST_MODE(1)},
> -	{EMAC_SGMII_LN_MIXER_CTRL_MODE0,
> -		MIXER_LOADB_MODE(12) | MIXER_DATARATE_MODE(1)},
> -	{EMAC_SGMII_LN_VGA_INITVAL, VGA_THRESH_DFE(31)},
> -	{EMAC_SGMII_LN_SIGDET_ENABLES,
> -		SIGDET_LP_BYP_PS0_TO_PS2 | SIGDET_FLT_BYP},
> -	{EMAC_SGMII_LN_SIGDET_CNTRL, SIGDET_LVL(8)},
> -
> -	{EMAC_SGMII_LN_SIGDET_DEGLITCH_CNTRL, SIGDET_DEGLITCH_CTRL(4)},
> -	{EMAC_SGMII_LN_RX_MISC_CNTRL0, INVERT_PCS_RX_CLK},
> -	{EMAC_SGMII_LN_DRVR_LOGIC_CLKDIV,
> -		DRVR_LOGIC_CLK_EN | DRVR_LOGIC_CLK_DIV(4)},
> -
> -	{EMAC_SGMII_LN_PARALLEL_RATE, PARALLEL_RATE_MODE0(1)},
> -	{EMAC_SGMII_LN_TX_BAND_MODE, BAND_MODE0(1)},
> -	{EMAC_SGMII_LN_RX_BAND, BAND_MODE0(2)},
> -	{EMAC_SGMII_LN_DRVR_CTRL1, RESCODE_OFFSET(7)},
> -	{EMAC_SGMII_LN_RX_RESECODE_OFFSET, RESCODE_OFFSET(9)},
> -	{EMAC_SGMII_LN_LANE_MODE, LANE_MODE(26)},
> -	{EMAC_SGMII_LN_RX_RCVR_PATH1_MODE0, CDR_PD_SEL_MODE0(2) |
> -		EN_DLL_MODE0 | EN_IQ_DCC_MODE0 | EN_IQCAL_MODE0},
> -	{EMAC_SGMII_LN_RSM_CONFIG, BYPASS_RSM_SAMP_CAL | BYPASS_RSM_DLL_CAL},
> -};
> -
> -static const struct emac_reg_write physical_coding_sublayer_programming[] = {
> -	{EMAC_SGMII_PHY_POW_DWN_CTRL0, PWRDN_B},
> -	{EMAC_SGMII_PHY_CDR_CTRL0, CDR_MAX_CNT(15)},
> -	{EMAC_SGMII_PHY_TX_PWR_CTRL, 0},
> -	{EMAC_SGMII_PHY_LANE_CTRL1, L0_RX_EQUALIZE_ENABLE},
> -};
> -
> -int emac_sgmii_init_qdf2400(struct emac_adapter *adpt)
> -{
> -	struct emac_sgmii *phy = &adpt->phy;
> -	void __iomem *phy_regs = phy->base;
> -	void __iomem *laned = phy->digital;
> -	unsigned int i;
> -	u32 lnstatus;
> -
> -	/* PCS lane-x init */
> -	emac_reg_write_all(phy->base, physical_coding_sublayer_programming,
> -			   ARRAY_SIZE(physical_coding_sublayer_programming));
> -
> -	/* SGMII lane-x init */
> -	emac_reg_write_all(phy->digital, sgmii_laned, ARRAY_SIZE(sgmii_laned));
> -
> -	/* Power up PCS and start reset lane state machine */
> -
> -	writel(0, phy_regs + EMAC_SGMII_PHY_RESET_CTRL);
> -	writel(1, laned + SGMII_LN_RSM_START);
> -
> -	/* Wait for c_ready assertion */
> -	for (i = 0; i < SERDES_START_WAIT_TIMES; i++) {
> -		lnstatus = readl(phy_regs + SGMII_PHY_LN_LANE_STATUS);
> -		if (lnstatus & BIT(1))
> -			break;
> -		usleep_range(100, 200);
> -	}
> -
> -	if (i == SERDES_START_WAIT_TIMES) {
> -		netdev_err(adpt->netdev, "SGMII failed to start\n");
> -		return -EIO;
> -	}
> -
> -	/* Disable digital and SERDES loopback */
> -	writel(0, phy_regs + SGMII_PHY_LN_BIST_GEN0);
> -	writel(0, phy_regs + SGMII_PHY_LN_BIST_GEN2);
> -	writel(0, phy_regs + SGMII_PHY_LN_CDR_CTRL1);
> -
> -	/* Mask out all the SGMII Interrupt */
> -	writel(0, phy_regs + EMAC_SGMII_PHY_INTERRUPT_MASK);
> -
> -	return 0;
> -}
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii-qdf2432.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii-qdf2432.c
> deleted file mode 100644
> index 65519eeebecd..000000000000
> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii-qdf2432.c
> +++ /dev/null
> @@ -1,202 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> - */
> -
> -/* Qualcomm Technologies, Inc. QDF2432 EMAC SGMII Controller driver.
> - */
> -
> -#include <linux/iopoll.h>
> -#include "emac.h"
> -
> -/* EMAC_SGMII register offsets */
> -#define EMAC_SGMII_PHY_TX_PWR_CTRL		0x000C
> -#define EMAC_SGMII_PHY_LANE_CTRL1		0x0018
> -#define EMAC_SGMII_PHY_CDR_CTRL0		0x0058
> -#define EMAC_SGMII_PHY_POW_DWN_CTRL0		0x0080
> -#define EMAC_SGMII_PHY_RESET_CTRL		0x00a8
> -#define EMAC_SGMII_PHY_INTERRUPT_MASK		0x00b4
> -
> -/* SGMII digital lane registers */
> -#define EMAC_SGMII_LN_DRVR_CTRL0		0x000C
> -#define EMAC_SGMII_LN_DRVR_TAP_EN		0x0018
> -#define EMAC_SGMII_LN_TX_MARGINING		0x001C
> -#define EMAC_SGMII_LN_TX_PRE			0x0020
> -#define EMAC_SGMII_LN_TX_POST			0x0024
> -#define EMAC_SGMII_LN_TX_BAND_MODE		0x0060
> -#define EMAC_SGMII_LN_LANE_MODE			0x0064
> -#define EMAC_SGMII_LN_PARALLEL_RATE		0x0078
> -#define EMAC_SGMII_LN_CML_CTRL_MODE0		0x00B8
> -#define EMAC_SGMII_LN_MIXER_CTRL_MODE0		0x00D0
> -#define EMAC_SGMII_LN_VGA_INITVAL		0x0134
> -#define EMAC_SGMII_LN_UCDR_FO_GAIN_MODE0	0x017C
> -#define EMAC_SGMII_LN_UCDR_SO_GAIN_MODE0	0x0188
> -#define EMAC_SGMII_LN_UCDR_SO_CONFIG		0x0194
> -#define EMAC_SGMII_LN_RX_BAND			0x019C
> -#define EMAC_SGMII_LN_RX_RCVR_PATH1_MODE0	0x01B8
> -#define EMAC_SGMII_LN_RSM_CONFIG		0x01F0
> -#define EMAC_SGMII_LN_SIGDET_ENABLES		0x0224
> -#define EMAC_SGMII_LN_SIGDET_CNTRL		0x0228
> -#define EMAC_SGMII_LN_SIGDET_DEGLITCH_CNTRL	0x022C
> -#define EMAC_SGMII_LN_RX_EN_SIGNAL		0x02A0
> -#define EMAC_SGMII_LN_RX_MISC_CNTRL0		0x02AC
> -#define EMAC_SGMII_LN_DRVR_LOGIC_CLKDIV		0x02BC
> -
> -/* SGMII digital lane register values */
> -#define UCDR_STEP_BY_TWO_MODE0			BIT(7)
> -#define UCDR_xO_GAIN_MODE(x)			((x) & 0x7f)
> -#define UCDR_ENABLE				BIT(6)
> -#define UCDR_SO_SATURATION(x)			((x) & 0x3f)
> -
> -#define SIGDET_LP_BYP_PS4			BIT(7)
> -#define SIGDET_EN_PS0_TO_PS2			BIT(6)
> -
> -#define TXVAL_VALID_INIT			BIT(4)
> -#define KR_PCIGEN3_MODE				BIT(0)
> -
> -#define MAIN_EN					BIT(0)
> -
> -#define TX_MARGINING_MUX			BIT(6)
> -#define TX_MARGINING(x)				((x) & 0x3f)
> -
> -#define TX_PRE_MUX				BIT(6)
> -
> -#define TX_POST_MUX				BIT(6)
> -
> -#define CML_GEAR_MODE(x)			(((x) & 7) << 3)
> -#define CML2CMOS_IBOOST_MODE(x)			((x) & 7)
> -
> -#define MIXER_LOADB_MODE(x)			(((x) & 0xf) << 2)
> -#define MIXER_DATARATE_MODE(x)			((x) & 3)
> -
> -#define VGA_THRESH_DFE(x)			((x) & 0x3f)
> -
> -#define SIGDET_LP_BYP_PS0_TO_PS2		BIT(5)
> -#define SIGDET_FLT_BYP				BIT(0)
> -
> -#define SIGDET_LVL(x)				(((x) & 0xf) << 4)
> -
> -#define SIGDET_DEGLITCH_CTRL(x)			(((x) & 0xf) << 1)
> -
> -#define DRVR_LOGIC_CLK_EN			BIT(4)
> -#define DRVR_LOGIC_CLK_DIV(x)			((x) & 0xf)
> -
> -#define PARALLEL_RATE_MODE0(x)			((x) & 0x3)
> -
> -#define BAND_MODE0(x)				((x) & 0x3)
> -
> -#define LANE_MODE(x)				((x) & 0x1f)
> -
> -#define CDR_PD_SEL_MODE0(x)			(((x) & 0x3) << 5)
> -#define BYPASS_RSM_SAMP_CAL			BIT(1)
> -#define BYPASS_RSM_DLL_CAL			BIT(0)
> -
> -#define L0_RX_EQUALIZE_ENABLE			BIT(6)
> -
> -#define PWRDN_B					BIT(0)
> -
> -#define CDR_MAX_CNT(x)				((x) & 0xff)
> -
> -#define SERDES_START_WAIT_TIMES			100
> -
> -struct emac_reg_write {
> -	unsigned int offset;
> -	u32 val;
> -};
> -
> -static void emac_reg_write_all(void __iomem *base,
> -			       const struct emac_reg_write *itr, size_t size)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < size; ++itr, ++i)
> -		writel(itr->val, base + itr->offset);
> -}
> -
> -static const struct emac_reg_write sgmii_laned[] = {
> -	/* CDR Settings */
> -	{EMAC_SGMII_LN_UCDR_FO_GAIN_MODE0,
> -		UCDR_STEP_BY_TWO_MODE0 | UCDR_xO_GAIN_MODE(10)},
> -	{EMAC_SGMII_LN_UCDR_SO_GAIN_MODE0, UCDR_xO_GAIN_MODE(0)},
> -	{EMAC_SGMII_LN_UCDR_SO_CONFIG, UCDR_ENABLE | UCDR_SO_SATURATION(12)},
> -
> -	/* TX/RX Settings */
> -	{EMAC_SGMII_LN_RX_EN_SIGNAL, SIGDET_LP_BYP_PS4 | SIGDET_EN_PS0_TO_PS2},
> -
> -	{EMAC_SGMII_LN_DRVR_CTRL0, TXVAL_VALID_INIT | KR_PCIGEN3_MODE},
> -	{EMAC_SGMII_LN_DRVR_TAP_EN, MAIN_EN},
> -	{EMAC_SGMII_LN_TX_MARGINING, TX_MARGINING_MUX | TX_MARGINING(25)},
> -	{EMAC_SGMII_LN_TX_PRE, TX_PRE_MUX},
> -	{EMAC_SGMII_LN_TX_POST, TX_POST_MUX},
> -
> -	{EMAC_SGMII_LN_CML_CTRL_MODE0,
> -		CML_GEAR_MODE(1) | CML2CMOS_IBOOST_MODE(1)},
> -	{EMAC_SGMII_LN_MIXER_CTRL_MODE0,
> -		MIXER_LOADB_MODE(12) | MIXER_DATARATE_MODE(1)},
> -	{EMAC_SGMII_LN_VGA_INITVAL, VGA_THRESH_DFE(31)},
> -	{EMAC_SGMII_LN_SIGDET_ENABLES,
> -		SIGDET_LP_BYP_PS0_TO_PS2 | SIGDET_FLT_BYP},
> -	{EMAC_SGMII_LN_SIGDET_CNTRL, SIGDET_LVL(8)},
> -
> -	{EMAC_SGMII_LN_SIGDET_DEGLITCH_CNTRL, SIGDET_DEGLITCH_CTRL(4)},
> -	{EMAC_SGMII_LN_RX_MISC_CNTRL0, 0},
> -	{EMAC_SGMII_LN_DRVR_LOGIC_CLKDIV,
> -		DRVR_LOGIC_CLK_EN | DRVR_LOGIC_CLK_DIV(4)},
> -
> -	{EMAC_SGMII_LN_PARALLEL_RATE, PARALLEL_RATE_MODE0(1)},
> -	{EMAC_SGMII_LN_TX_BAND_MODE, BAND_MODE0(2)},
> -	{EMAC_SGMII_LN_RX_BAND, BAND_MODE0(3)},
> -	{EMAC_SGMII_LN_LANE_MODE, LANE_MODE(26)},
> -	{EMAC_SGMII_LN_RX_RCVR_PATH1_MODE0, CDR_PD_SEL_MODE0(3)},
> -	{EMAC_SGMII_LN_RSM_CONFIG, BYPASS_RSM_SAMP_CAL | BYPASS_RSM_DLL_CAL},
> -};
> -
> -static const struct emac_reg_write physical_coding_sublayer_programming[] = {
> -	{EMAC_SGMII_PHY_POW_DWN_CTRL0, PWRDN_B},
> -	{EMAC_SGMII_PHY_CDR_CTRL0, CDR_MAX_CNT(15)},
> -	{EMAC_SGMII_PHY_TX_PWR_CTRL, 0},
> -	{EMAC_SGMII_PHY_LANE_CTRL1, L0_RX_EQUALIZE_ENABLE},
> -};
> -
> -int emac_sgmii_init_qdf2432(struct emac_adapter *adpt)
> -{
> -	struct emac_sgmii *phy = &adpt->phy;
> -	void __iomem *phy_regs = phy->base;
> -	void __iomem *laned = phy->digital;
> -	unsigned int i;
> -	u32 lnstatus;
> -
> -	/* PCS lane-x init */
> -	emac_reg_write_all(phy->base, physical_coding_sublayer_programming,
> -			   ARRAY_SIZE(physical_coding_sublayer_programming));
> -
> -	/* SGMII lane-x init */
> -	emac_reg_write_all(phy->digital, sgmii_laned, ARRAY_SIZE(sgmii_laned));
> -
> -	/* Power up PCS and start reset lane state machine */
> -
> -	writel(0, phy_regs + EMAC_SGMII_PHY_RESET_CTRL);
> -	writel(1, laned + SGMII_LN_RSM_START);
> -
> -	/* Wait for c_ready assertion */
> -	for (i = 0; i < SERDES_START_WAIT_TIMES; i++) {
> -		lnstatus = readl(phy_regs + SGMII_PHY_LN_LANE_STATUS);
> -		if (lnstatus & BIT(1))
> -			break;
> -		usleep_range(100, 200);
> -	}
> -
> -	if (i == SERDES_START_WAIT_TIMES) {
> -		netdev_err(adpt->netdev, "SGMII failed to start\n");
> -		return -EIO;
> -	}
> -
> -	/* Disable digital and SERDES loopback */
> -	writel(0, phy_regs + SGMII_PHY_LN_BIST_GEN0);
> -	writel(0, phy_regs + SGMII_PHY_LN_BIST_GEN2);
> -	writel(0, phy_regs + SGMII_PHY_LN_CDR_CTRL1);
> -
> -	/* Mask out all the SGMII Interrupt */
> -	writel(0, phy_regs + EMAC_SGMII_PHY_INTERRUPT_MASK);
> -
> -	return 0;
> -}
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> index e4bc18009d08..573c82b21de5 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> @@ -7,7 +7,6 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> -#include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> @@ -275,76 +274,11 @@ static struct sgmii_ops fsm9900_ops = {
>  	.reset = emac_sgmii_common_reset,
>  };
>  
> -static struct sgmii_ops qdf2432_ops = {
> -	.init = emac_sgmii_init_qdf2432,
> -	.open = emac_sgmii_common_open,
> -	.close = emac_sgmii_common_close,
> -	.link_change = emac_sgmii_common_link_change,
> -	.reset = emac_sgmii_common_reset,
> -};
> -
> -#ifdef CONFIG_ACPI
> -static struct sgmii_ops qdf2400_ops = {
> -	.init = emac_sgmii_init_qdf2400,
> -	.open = emac_sgmii_common_open,
> -	.close = emac_sgmii_common_close,
> -	.link_change = emac_sgmii_common_link_change,
> -	.reset = emac_sgmii_common_reset,
> -};
> -#endif
> -
> -static int emac_sgmii_acpi_match(struct device *dev, void *data)
> -{
> -#ifdef CONFIG_ACPI
> -	static const struct acpi_device_id match_table[] = {
> -		{
> -			.id = "QCOM8071",
> -		},
> -		{}
> -	};
> -	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
> -	struct sgmii_ops **ops = data;
> -
> -	if (id) {
> -		acpi_handle handle = ACPI_HANDLE(dev);
> -		unsigned long long hrv;
> -		acpi_status status;
> -
> -		status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
> -		if (status) {
> -			if (status == AE_NOT_FOUND)
> -				/* Older versions of the QDF2432 ACPI tables do
> -				 * not have an _HRV property.
> -				 */
> -				hrv = 1;
> -			else
> -				/* Something is wrong with the tables */
> -				return 0;
> -		}
> -
> -		switch (hrv) {
> -		case 1:
> -			*ops = &qdf2432_ops;
> -			return 1;
> -		case 2:
> -			*ops = &qdf2400_ops;
> -			return 1;
> -		}
> -	}
> -#endif
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id emac_sgmii_dt_match[] = {
>  	{
>  		.compatible = "qcom,fsm9900-emac-sgmii",
>  		.data = &fsm9900_ops,
>  	},
> -	{
> -		.compatible = "qcom,qdf2432-emac-sgmii",
> -		.data = &qdf2432_ops,
> -	},
>  	{}
>  };
>  
> @@ -355,45 +289,31 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
>  	struct resource *res;
>  	int ret;
>  
> -	if (has_acpi_companion(&pdev->dev)) {
> -		struct device *dev;
> -
> -		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
> -					emac_sgmii_acpi_match);
> -
> -		if (!dev) {
> -			dev_warn(&pdev->dev, "cannot find internal phy node\n");
> -			return 0;
> -		}
> -
> -		sgmii_pdev = to_platform_device(dev);
> -	} else {
> -		const struct of_device_id *match;
> -		struct device_node *np;
> -
> -		np = of_parse_phandle(pdev->dev.of_node, "internal-phy", 0);
> -		if (!np) {
> -			dev_err(&pdev->dev, "missing internal-phy property\n");
> -			return -ENODEV;
> -		}
> +	const struct of_device_id *match;
> +	struct device_node *np;
>  
> -		sgmii_pdev = of_find_device_by_node(np);
> -		of_node_put(np);
> -		if (!sgmii_pdev) {
> -			dev_err(&pdev->dev, "invalid internal-phy property\n");
> -			return -ENODEV;
> -		}
> +	np = of_parse_phandle(pdev->dev.of_node, "internal-phy", 0);
> +	if (!np) {
> +		dev_err(&pdev->dev, "missing internal-phy property\n");
> +		return -ENODEV;
> +	}
>  
> -		match = of_match_device(emac_sgmii_dt_match, &sgmii_pdev->dev);
> -		if (!match) {
> -			dev_err(&pdev->dev, "unrecognized internal phy node\n");
> -			ret = -ENODEV;
> -			goto error_put_device;
> -		}
> +	sgmii_pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!sgmii_pdev) {
> +		dev_err(&pdev->dev, "invalid internal-phy property\n");
> +		return -ENODEV;
> +	}
>  
> -		phy->sgmii_ops = (struct sgmii_ops *)match->data;
> +	match = of_match_device(emac_sgmii_dt_match, &sgmii_pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "unrecognized internal phy node\n");
> +		ret = -ENODEV;
> +		goto error_put_device;
>  	}
>  
> +	phy->sgmii_ops = (struct sgmii_ops *)match->data;
> +
>  	/* Base address is the first address */
>  	res = platform_get_resource(sgmii_pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h
> index 6daeddacbcfa..7b7b0dc44225 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h
> @@ -40,8 +40,6 @@ struct emac_sgmii {
>  int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt);
>  
>  int emac_sgmii_init_fsm9900(struct emac_adapter *adpt);
> -int emac_sgmii_init_qdf2432(struct emac_adapter *adpt);
> -int emac_sgmii_init_qdf2400(struct emac_adapter *adpt);
>  
>  int emac_sgmii_init(struct emac_adapter *adpt);
>  int emac_sgmii_open(struct emac_adapter *adpt);
> 
> ---
> base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
> change-id: 20240122-topic-qdf_cleanup_net-60fceddde376
> 
> Best regards,

