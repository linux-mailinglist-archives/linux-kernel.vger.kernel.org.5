Return-Path: <linux-kernel+bounces-145850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1418A5BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E7A1F267D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B1157E73;
	Mon, 15 Apr 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KZq1nnRk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF9157481;
	Mon, 15 Apr 2024 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210843; cv=none; b=VeEGyRBl3yrltryiQQ31k3yHcOtOwicJMTx0fwznmDNkVSvjerC6oFahO2a/l44+FfPF6sxTyGn7xGnQzcX5+Z6h/K04aPK4ZtXwUHpsCdDh2egdAflPeJjVW0z3prtEixmak2cgPF8/RLDgOnclInLHF54/b6w8/kiXqf4j/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210843; c=relaxed/simple;
	bh=TZsE6GWfY01zorNaQX/ghnfDYb6Y9/Zm1jwT89bt3DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQZzhvcps67RdPZBg+5ssEMcOF3Ei4VxSqjhDi+q9xPfdDAOJMoxMGXTxt/KqK/XovILtPoYspvbh8kz94m5yTlD9/h3VOFJ87NQL0EHu2M057LdlJAMC8qn1kJWVdU6Nmle08Qr7L+ZSWWVcAB4A6n0G0eIh9aIIZDtYtUE2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KZq1nnRk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A9226132;
	Mon, 15 Apr 2024 21:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713210791;
	bh=TZsE6GWfY01zorNaQX/ghnfDYb6Y9/Zm1jwT89bt3DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZq1nnRk1nMSeFZnAl5MS6emodiCh+rpXVFwwPi9BtFQ7513ZUuYT23x3ytyND5bW
	 7Rib8zRLM9O5B8E2ghFv8sU8GWXK9KanzSXTig9Mr7BSR9j7iY2GJbaPX98IbhRQHb
	 8/uKvptFAOjXBlbAF0uxKmaLugCqF+wUB7qrc6WU=
Date: Mon, 15 Apr 2024 22:53:48 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Dmitry Osipenko <digetx@gmail.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 00/35] media: Fix coccinelle warning/errors
Message-ID: <20240415195348.GD22954@pendragon.ideasonboard.com>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>

Hi Ricardo,

I'm afraid I won't have time to review any of this for the time being.
Unless you would like me to put uvcvideo reviews on hold ;-)

Jokes aside, my first reaction was that this feels like a bit of a waste
of maintainer's time :-S

On Mon, Apr 15, 2024 at 07:34:17PM +0000, Ricardo Ribalda wrote:
> After this set is applied, these are the only warnings left:
> drivers/media/pci/ivtv/ivtv-fileops.c:223:4-10: preceding lock on line 267
> drivers/media/pci/ivtv/ivtv-fileops.c:230:3-9: preceding lock on line 267
> drivers/media/pci/ivtv/ivtv-fileops.c:236:4-10: preceding lock on line 267
> drivers/media/pci/ivtv/ivtv-fileops.c:245:3-9: preceding lock on line 267
> drivers/media/pci/ivtv/ivtv-fileops.c:251:3-9: preceding lock on line 267
> drivers/media/pci/ivtv/ivtv-fileops.c:257:3-9: preceding lock on line 267
> drivers/media/pci/ivtv/ivtv-fileops.c:272:3-9: preceding lock on line 267
> drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 627
> drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 689
> drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 627
> drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 689
> drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 627
> drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 689
> drivers/media/pci/ivtv/ivtv-fileops.c:692:4-10: preceding lock on line 689
> drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2776
> drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2786
> drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2809
> drivers/media/dvb-frontends/stv090x.c:799:1-7: preceding lock on line 768
> drivers/media/usb/go7007/go7007-i2c.c:125:1-7: preceding lock on line 61
> drivers/media/rc/imon.c:1167:1-7: preceding lock on line 1153
> drivers/media/pci/cx18/cx18-scb.h:261:22-29: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:85:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:154:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:171:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:180:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:189:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:201:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:220:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:230:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:764:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1008:43-60: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1014:36-46: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1041:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1088:39-51: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1093:5-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1144:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1239:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1267:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1272:4-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/common/siano/smscoreapi.h:619:5-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/common/siano/smscoreapi.h:669:6-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/common/siano/smscoreapi.h:1049:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/common/siano/smscoreapi.h:1055:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/dvb-frontends/mxl5xx_defs.h:171:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/dvb-frontends/mxl5xx_defs.h:182:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/allegro-dvt/nal-hevc.h:102:14-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/xilinx/xilinx-dma.h:100:19-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/staging/media/atomisp/pci/atomisp_tpg.h:30:18-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> CI tested:
> https://gitlab.freedesktop.org/linux-media/media-staging/-/commit/055b5211c68e721c3a7090be5373cf44859da1a7/pipelines?ref=ribalda%2Ftest-cocci
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Ricardo Ribalda (35):
>       media: pci: mgb4: Refactor struct resources
>       media: stb0899: Remove unreacheable code
>       media: uvcvideo: Refactor iterators
>       media: uvcvideo: Use max() macro
>       media: go7007: Use min and max macros
>       media: stm32-dcmipp: Remove redundant printk
>       media: staging: sun6i-isp: Remove redundant printk
>       media: dvb-frontends: tda18271c2dd: Remove casting during div
>       media: v4l: async: refactor v4l2_async_create_ancillary_links
>       staging: media: tegra-video: Use swap macro
>       media: s2255: Use refcount_t instead of atomic_t for num_channels
>       media: platform: mtk-mdp3: Use refcount_t for job_count
>       media: common: saa7146: Use min macro
>       media: dvb-frontends: drx39xyj: Use min macro
>       media: netup_unidvb: Use min macro
>       media: au0828: Use min macro
>       media: flexcop-usb: Use min macro
>       media: gspca: cpia1: Use min macro
>       media: stk1160: Use min macro
>       media: tegra-vde: Refactor timeout handling
>       media: venus: Use div64_u64
>       media: i2c: st-mipid02: Use the correct div function
>       media: dvb-frontends: tda10048: Use the right div
>       media: tc358746: Use the correct div_ function
>       media: venus: Use the correct div_ function
>       media: venus: Refator return path
>       media: dib0700: Refator return path
>       media: usb: cx231xx: Refator return path
>       media: i2c: rdacm20: Refator return path
>       media: i2c: et8ek8: Refator return path
>       media: cx231xx: Refator return path
>       media: si4713: Refator return path
>       media: ttpci: Refator return path
>       media: hdpvr: Refator return path
>       media: venus: Refator return path
> 
>  drivers/media/common/saa7146/saa7146_hlp.c         |  8 +++----
>  drivers/media/dvb-frontends/drx39xyj/drxj.c        |  9 +++-----
>  drivers/media/dvb-frontends/stb0899_drv.c          |  5 -----
>  drivers/media/dvb-frontends/tda10048.c             |  3 +--
>  drivers/media/dvb-frontends/tda18271c2dd.c         |  4 ++--
>  drivers/media/i2c/et8ek8/et8ek8_driver.c           |  4 +++-
>  drivers/media/i2c/rdacm20.c                        |  5 ++++-
>  drivers/media/i2c/st-mipid02.c                     |  2 +-
>  drivers/media/i2c/tc358746.c                       |  3 +--
>  drivers/media/pci/mgb4/mgb4_core.c                 |  4 ++--
>  drivers/media/pci/mgb4/mgb4_regs.c                 |  2 +-
>  drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c  |  2 +-
>  drivers/media/pci/ttpci/budget-core.c              |  5 ++++-
>  .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   | 10 ++++-----
>  .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  6 ++---
>  .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |  2 +-
>  .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |  6 ++---
>  drivers/media/platform/nvidia/tegra-vde/h264.c     |  6 ++---
>  drivers/media/platform/qcom/venus/vdec.c           | 15 +++++++------
>  drivers/media/platform/qcom/venus/venc.c           | 19 +++++++++-------
>  .../platform/st/stm32/stm32-dcmipp/dcmipp-core.c   |  5 +----
>  drivers/media/radio/si4713/radio-usb-si4713.c      |  8 +++++--
>  drivers/media/usb/au0828/au0828-video.c            |  5 +----
>  drivers/media/usb/b2c2/flexcop-usb.c               |  5 +----
>  drivers/media/usb/cx231xx/cx231xx-i2c.c            | 16 +++++++++----
>  drivers/media/usb/cx231xx/cx231xx-video.c          | 10 +++++++--
>  drivers/media/usb/dvb-usb/dib0700_core.c           |  4 +++-
>  drivers/media/usb/go7007/go7007-fw.c               |  4 ++--
>  drivers/media/usb/gspca/cpia1.c                    |  6 ++---
>  drivers/media/usb/hdpvr/hdpvr-control.c            |  4 +++-
>  drivers/media/usb/s2255/s2255drv.c                 | 20 ++++++++---------
>  drivers/media/usb/stk1160/stk1160-video.c          | 10 ++-------
>  drivers/media/usb/uvc/uvc_ctrl.c                   | 26 ++++++++++++----------
>  drivers/media/v4l2-core/v4l2-async.c               |  8 +++----
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |  1 -
>  drivers/staging/media/tegra-video/tegra20.c        |  9 ++------
>  36 files changed, 132 insertions(+), 129 deletions(-)
> ---
> base-commit: 71b3ed53b08d87212fbbe51bdc3bf44eb8c462f8
> change-id: 20240415-fix-cocci-2df3ef22a6f7
> 
> Best regards,

-- 
Regards,

Laurent Pinchart

