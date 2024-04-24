Return-Path: <linux-kernel+bounces-156785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24E8B081D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B911F22452
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79115A497;
	Wed, 24 Apr 2024 11:12:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601D1598E7;
	Wed, 24 Apr 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957123; cv=none; b=fBs6nP95GvETS/0bAapa1B2JXcpv/1kzzeqV1+k0ozU/i2Zs7Z7FZjgyem/EncCiXhFZIkbDOot4aTDGR6ht6klVTW/MxGHjlgrOEIH3HxzlD7KXamlAOHA6YSUUUOABPik5z+bPXPCl55X7uZscFIMJUq/CsrMDK8QJWmx9vyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957123; c=relaxed/simple;
	bh=7j+bqzwwRnpE1+l6HyrvmBZeRb2GhcdwQavkB7KSqDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAcZKL04eO5e/ciftRbb5Xbqs8+j5Xm2Rsk/giTMzLu0gHyoagnwB0wp6HfjYwFIHtWT3y4he2P9QflNq+NOILRrTPsJs+qMtav+JAAMD+SK3nPQE/u9KguzVDPvkSSXWfTqzOjY0cprrcnlnFHSmthBGn2arbZ7nhcbx8ft4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2480C113CE;
	Wed, 24 Apr 2024 11:11:53 +0000 (UTC)
Message-ID: <3f834858-628b-4f21-bd85-1833cd8ccc98@xs4all.nl>
Date: Wed, 24 Apr 2024 13:11:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/26] media: Fix coccinelle warning/errors
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Dmitry Osipenko <digetx@gmail.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 11:47, Ricardo Ribalda wrote:
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

Other than what others already reported, plus my own two comments, this series
looks good. So likely I can pick up v3 once it is posted.

Regards,

	Hans

> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v2:
> - Remove all the min() retval, and send a patch for cocci:  https://lore.kernel.org/lkml/20240415-minimax-v1-1-5feb20d66a79@chromium.org/T/#u
> - platform_get_irq() cannot return 0, fix that (Thanks Dan).
> - Fix stb0800 patch. chip_id can be 0 (Thanks Dan).
> - Use runtime (IS_ENABLED), code looks nicer. (Thanks Dan).
> - Do not replace do_div for venus (Thanks Dan).
> - Do not replace do_div for tda10048 (Thanks Dan).
> - Link to v1: https://lore.kernel.org/r/20240415-fix-cocci-v1-0-477afb23728b@chromium.org
> 
> ---
> Ricardo Ribalda (26):
>       media: pci: mgb4: Refactor struct resources
>       media: stb0899: Simplify check
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
>       media: i2c: st-mipid02: Use the correct div function
>       media: tc358746: Use the correct div_ function
>       media: venus: vdec: Make explicit the range of us_per_frame
>       media: venus: venc: Make explicit the range of us_per_frame
>       media: dvb-frontends: tda10048: Fix integer overflow
>       media: dvb-frontends: tda10048: Make explicit the range of z.
> 
>  drivers/media/common/saa7146/saa7146_hlp.c         |  8 +++----
>  drivers/media/dvb-frontends/drx39xyj/drxj.c        |  9 +++-----
>  drivers/media/dvb-frontends/stb0899_drv.c          |  2 +-
>  drivers/media/dvb-frontends/tda10048.c             | 13 +++++++----
>  drivers/media/dvb-frontends/tda18271c2dd.c         |  4 ++--
>  drivers/media/i2c/st-mipid02.c                     |  2 +-
>  drivers/media/i2c/tc358746.c                       |  3 +--
>  drivers/media/pci/mgb4/mgb4_core.c                 |  4 ++--
>  drivers/media/pci/mgb4/mgb4_regs.c                 |  2 +-
>  drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c  |  2 +-
>  .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   | 10 ++++-----
>  .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  6 ++---
>  .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |  2 +-
>  .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |  6 ++---
>  drivers/media/platform/nvidia/tegra-vde/h264.c     |  6 ++---
>  drivers/media/platform/qcom/venus/vdec.c           |  7 ++----
>  drivers/media/platform/qcom/venus/venc.c           |  7 ++----
>  .../platform/st/stm32/stm32-dcmipp/dcmipp-core.c   |  7 ++----
>  drivers/media/usb/au0828/au0828-video.c            |  5 +----
>  drivers/media/usb/b2c2/flexcop-usb.c               |  5 +----
>  drivers/media/usb/go7007/go7007-fw.c               |  4 ++--
>  drivers/media/usb/gspca/cpia1.c                    |  6 ++---
>  drivers/media/usb/s2255/s2255drv.c                 | 20 ++++++++---------
>  drivers/media/usb/stk1160/stk1160-video.c          | 10 ++-------
>  drivers/media/usb/uvc/uvc_ctrl.c                   | 26 ++++++++++++----------
>  drivers/media/v4l2-core/v4l2-async.c               |  7 +++---
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |  3 +--
>  drivers/staging/media/tegra-video/tegra20.c        |  9 ++------
>  28 files changed, 84 insertions(+), 111 deletions(-)
> ---
> base-commit: 836e2548524d2dfcb5acaf3be78f203b6b4bde6f
> change-id: 20240415-fix-cocci-2df3ef22a6f7
> 
> Best regards,


