Return-Path: <linux-kernel+bounces-118851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51388C040
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2B1C38982
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE19A548F5;
	Tue, 26 Mar 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DVQR3/2g"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150D50A98
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451435; cv=none; b=YpmTLPdTi+yBEqa1nY8IoT3yVWkcX3hT4co1w2FCVDzUk1OLCGKa44Dd8rHxX3FtrbjZmZywAbiJAtCeRdU1+2KOQK/Dlf48ARCdYjBUE4fDUeMlCmNg1+ZALlL9ozlt73Om4EVTW7M/blkuwx6OLR3QC51mqqNT9+oEfHAtLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451435; c=relaxed/simple;
	bh=xsEx6ikjhrfddChpCiaRIQ8pNztjK3Yv2zPNz89fQtU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=AlKLWaff79lRXFYoxeiPublNBXN1vAznaIQLMDmARVl4PO8oaTzIHIPDqWhuphQ4qC1Tb9w6bsHKy8N1J+Tp7B95Ordj1KH2dJLfMlHAVDc6/yZ0aZG7Mw5HGdMDXxvlGZoAr2O6lDJkEP3xlZTo1aCi4KqEPdfOkU9az5SP8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DVQR3/2g; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B630E497;
	Tue, 26 Mar 2024 12:09:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711451397;
	bh=xsEx6ikjhrfddChpCiaRIQ8pNztjK3Yv2zPNz89fQtU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DVQR3/2gdPXSKNUuDWQPNl2NUd3QsQZUMCNz4KkDvEGOrQ/pyf9mVLlK4bqbsgsl3
	 cFMGY9u5jeWDegGfjY5637nl+odgUMmc7IEGRxpoCI95JhJgLnWXTdE2RwosB/vRiH
	 LONp6B6elPpu4IqNvgTVn08tDLM/q7MY5BtcsZjU=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240319072712.133449-5-umang.jain@ideasonboard.com>
References: <20240319072712.133449-1-umang.jain@ideasonboard.com> <20240319072712.133449-5-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v3 4/6] media: imx335: Use integer values for size registers
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, Tommaso Merciai <tomm.merciai@gmail.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Umang Jain <umang.jain@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>
Date: Tue, 26 Mar 2024 11:10:26 +0000
Message-ID: <171145142670.1011926.13962568934811871543@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Umang Jain (2024-03-19 07:27:10)
> Consider integer values for registers that are related to various
> sizes in the register map. This helps in improving the overall
> readability.
>=20
> No functional changes intended in this patch.

Thanks, I think this definitely helps readability here for these units.

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/imx335.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index ae4341644a84..7609dbc537b1 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -251,12 +251,12 @@ static const struct cci_reg_sequence mode_2592x1940=
_regs[] =3D {
>         {IMX335_REG_MODE_SELECT, 0x01},
>         {IMX335_REG_MASTER_MODE, 0x00},
>         {IMX335_REG_WINMODE, 0x04},
> -       {IMX335_REG_HTRIMMING_START, 0x0180},
> -       {IMX335_REG_HNUM, 0x0a20},
> -       {IMX335_REG_Y_OUT_SIZE, 0x0794},
> -       {IMX335_REG_AREA3_ST_ADR_1, 0x00b0},
> -       {IMX335_REG_AREA3_WIDTH_1, 0x0f58},
> -       {IMX335_REG_OPB_SIZE_V, 0x00},
> +       {IMX335_REG_HTRIMMING_START, 384},
> +       {IMX335_REG_HNUM, 2592},
> +       {IMX335_REG_Y_OUT_SIZE, 1940},
> +       {IMX335_REG_AREA3_ST_ADR_1, 176},
> +       {IMX335_REG_AREA3_WIDTH_1, 3928},
> +       {IMX335_REG_OPB_SIZE_V, 0},
>         {IMX335_REG_XVS_XHS_DRV, 0x00},
>         {CCI_REG8(0x3288), 0x21}, /* undocumented */
>         {CCI_REG8(0x328a), 0x02}, /* undocumented */
> --=20
> 2.43.0
>

