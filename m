Return-Path: <linux-kernel+bounces-88609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10CF86E419
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73157285E72
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719E6E2BD;
	Fri,  1 Mar 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cFr943yl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F11C33;
	Fri,  1 Mar 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306028; cv=none; b=LUlP7HmGxd0uwIqs0mdYHfkInLEIDlhOUKnwzmseCCw9w1qsSCjmV4jj35RzTGwxzy5vdzxTNUJ92XW5osNnlAjNyO9X7ePoShRxyBa+bMj2FTrEH/pQ1DCrStAvBwUJaoLb9JvzC7a3+iCOQfXYrRcTRFmjiVCVYrs/jUJFu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306028; c=relaxed/simple;
	bh=4rZ9IbsP+jzXlyf93oCqikrl4goIvycpLqfPlaupifE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inMTS4ubitbJCqb9QNCPn8aypX80f36JWaWgU7aRylFQUoaidhlwCLr6YozTjRj1RfBXRzAu/EuFu+k8qP5xkk0EZBmcQkXEM2HjHNdi9mWY+d3fZdyBtWy8GCUdxWJHD/X13Tyxbeixdg3vjnBKOH02hIfqK7evkxOcuSztyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cFr943yl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709306025;
	bh=4rZ9IbsP+jzXlyf93oCqikrl4goIvycpLqfPlaupifE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFr943yljX1l29kjUPcrBU5FIpLB198EJMjLvS/ryE6Ezqbx+OR9RUYD7cFXVaTsy
	 eKe5Undn9T2NKbYG4IyGD5kPHTNaJx+DjzDYPcJZzmYYyi2SrK0b9xPkU41enEk5Jz
	 Qtezyhl+v/PPqcKZez9sNs/GCjZ4QW6qhH4t5OUZxQgTilW00/9uUsa73MIgfAD3jB
	 HGgsE+kt8PlKqC9YeYh1QUJvSJAo0b3vzP/ZYmL+VStaMcL9NqZPkWFjhusC7w/BCJ
	 uyPf/p9mYObaazGC1OdSdU2vo6N1qn+sNFYUMqRG+HWtBTZfqYbHqaWbIBHZD0LaGI
	 imZWsQW0Jag9w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1253437803EE;
	Fri,  1 Mar 2024 15:13:45 +0000 (UTC)
Date: Fri, 1 Mar 2024 16:13:44 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Irui Wang <irui.wang@mediatek.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	angelogioacchino.delregno@collabora.com,
	nicolas.dufresne@collabora.com,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Longfei Wang <longfei.wang@mediatek.com>,
	Maoguang Meng <maoguang.meng@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] media: mediatek: vcodec: Handle VP9 superframe
 bitstream with 8 sub-frames
Message-ID: <20240301151344.o7khwhbasnncw2cc@basti-XPS-13-9310>
References: <20240229030249.3404-1-irui.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240229030249.3404-1-irui.wang@mediatek.com>

Hey Irui,

On 29.02.2024 11:02, Irui Wang wrote:
>The VP9 bitstream has 8 sub-frames into one superframe, the superframe
>index validate failed when reach 8, modify the index checking so that the
>last sub-frame can be decoded normally with stateful vp9 decoder.

I find this commit message a bit confusing, you say that you couldn't
index the last superframe, but then you say that you modify the index
checking so that you can access the last sub-frame.

I would reword this section, here is my suggestion:

The VP9 bitstream uses superframes, which each contain 8 sub-frames,
enable accessing the last superframe by increasing the range of the
index validation as the maximum number of superframes is 8 and not 7.

The rest looks good as already mentioned by Nicolas.

Greetings,
Sebastian

>
>Signed-off-by: Irui Wang <irui.wang@mediatek.com>
>---
>changed with v1:
> - add a new define 'VP9_MAX_SUPER_FRAMES_NUM' for superframes.
>---
> .../mediatek/vcodec/decoder/vdec/vdec_vp9_if.c        | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
>index 55355fa70090..039082f600c8 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
>@@ -16,6 +16,7 @@
> #include "../vdec_drv_base.h"
> #include "../vdec_vpu_if.h"
>
>+#define VP9_MAX_SUPER_FRAMES_NUM 8
> #define VP9_SUPER_FRAME_BS_SZ 64
> #define MAX_VP9_DPB_SIZE	9
>
>@@ -133,11 +134,11 @@ struct vp9_sf_ref_fb {
>  */
> struct vdec_vp9_vsi {
> 	unsigned char sf_bs_buf[VP9_SUPER_FRAME_BS_SZ];
>-	struct vp9_sf_ref_fb sf_ref_fb[VP9_MAX_FRM_BUF_NUM-1];
>+	struct vp9_sf_ref_fb sf_ref_fb[VP9_MAX_SUPER_FRAMES_NUM];
> 	int sf_next_ref_fb_idx;
> 	unsigned int sf_frm_cnt;
>-	unsigned int sf_frm_offset[VP9_MAX_FRM_BUF_NUM-1];
>-	unsigned int sf_frm_sz[VP9_MAX_FRM_BUF_NUM-1];
>+	unsigned int sf_frm_offset[VP9_MAX_SUPER_FRAMES_NUM];
>+	unsigned int sf_frm_sz[VP9_MAX_SUPER_FRAMES_NUM];
> 	unsigned int sf_frm_idx;
> 	unsigned int sf_init;
> 	struct vdec_fb fb;
>@@ -526,7 +527,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
> 	/* if this super frame and it is not last sub-frame, get next fb for
> 	 * sub-frame decode
> 	 */
>-	if (vsi->sf_frm_cnt > 0 && vsi->sf_frm_idx != vsi->sf_frm_cnt - 1)
>+	if (vsi->sf_frm_cnt > 0 && vsi->sf_frm_idx != vsi->sf_frm_cnt)
> 		vsi->sf_next_ref_fb_idx = vp9_get_sf_ref_fb(inst);
> }
>
>@@ -735,7 +736,7 @@ static void get_free_fb(struct vdec_vp9_inst *inst, struct vdec_fb **out_fb)
>
> static int validate_vsi_array_indexes(struct vdec_vp9_inst *inst,
> 		struct vdec_vp9_vsi *vsi) {
>-	if (vsi->sf_frm_idx >= VP9_MAX_FRM_BUF_NUM - 1) {
>+	if (vsi->sf_frm_idx > VP9_MAX_SUPER_FRAMES_NUM) {
> 		mtk_vdec_err(inst->ctx, "Invalid vsi->sf_frm_idx=%u.", vsi->sf_frm_idx);
> 		return -EIO;
> 	}
>-- 
>2.18.0
>
>

