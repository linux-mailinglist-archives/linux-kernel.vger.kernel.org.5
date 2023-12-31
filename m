Return-Path: <linux-kernel+bounces-13641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDB8209E2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 07:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E99FB2187C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 06:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76156187E;
	Sun, 31 Dec 2023 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NrvB6Tb8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416017C3;
	Sun, 31 Dec 2023 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Pdi5ZtHpaZp9Kggr/yaJ0U8/BDWSSZaYMUzC+gCeArI=; b=NrvB6Tb8ns3knSE1FFQWcCpQmA
	TBARokTfNINIlgExGe1w8/dUTRRFP/ErXNL/TONz8XXT9zP/1KGvyCo7F+XVkPt4nXGIabttUdnze
	ln3vUlceKcMCd2Mjrt07AOtKr7WW/E3Yf47VxVOBdg1+HdqZp827wzcU7mnbrDERuCV610OENFD2P
	OC7Hn/dHpFHRIN2/fA1ktDGxEmzAHpXGRFV/PeazBJ1Ldu9LQqKWTvOMPhuxwDWbmZNk9V16Gy+9r
	ZMepz4aSi5NTk7AcQbiCPBpFdzhi/D5AmJfyeV1jxeEDw76guY3fGxrs3W4dzw5d0yODviTdiXTa6
	cc6hxB1w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rJozo-0042hK-2l;
	Sun, 31 Dec 2023 06:08:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] drm/msm/dpu: fix kernel-doc warnings
Date: Sat, 30 Dec 2023 22:08:23 -0800
Message-ID: <20231231060823.1934-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct all kernel-doc warnings in dpu_encoder.c and dpu_rm.c:

dpu_encoder.c:212: warning: Excess struct member 'crtc_kickoff_cb' description in 'dpu_encoder_virt'
dpu_encoder.c:212: warning: Excess struct member 'crtc_kickoff_cb_data' description in 'dpu_encoder_virt'
dpu_encoder.c:212: warning: Excess struct member 'debugfs_root' description in 'dpu_encoder_virt'

dpu_rm.c:35: warning: Excess struct member 'hw_res' description in 'dpu_rm_requirements'
dpu_rm.c:208: warning: No description found for return value of '_dpu_rm_get_lm_peer'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
-- 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |    4 ----
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |    3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff -- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -144,10 +144,6 @@ enum dpu_enc_rc_states {
  *			to track crtc in the disable() hook which is called
  *			_after_ encoder_mask is cleared.
  * @connector:		If a mode is set, cached pointer to the active connector
- * @crtc_kickoff_cb:		Callback into CRTC that will flush & start
- *				all CTL paths
- * @crtc_kickoff_cb_data:	Opaque user data given to crtc_kickoff_cb
- * @debugfs_root:		Debug file system root file node
  * @enc_lock:			Lock around physical encoder
  *				create/destroy/enable/disable
  * @frame_busy_mask:		Bitmask tracking which phys_enc we are still
diff -- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -29,7 +29,6 @@ static inline bool reserved_by_other(uin
 /**
  * struct dpu_rm_requirements - Reservation requirements parameter bundle
  * @topology:  selected topology for the display
- * @hw_res:	   Hardware resources required as reported by the encoders
  */
 struct dpu_rm_requirements {
 	struct msm_display_topology topology;
@@ -204,6 +203,8 @@ static bool _dpu_rm_needs_split_display(
  * _dpu_rm_get_lm_peer - get the id of a mixer which is a peer of the primary
  * @rm: dpu resource manager handle
  * @primary_idx: index of primary mixer in rm->mixer_blks[]
+ *
+ * Returns: lm peer mixed id on success or %-EINVAL on error
  */
 static int _dpu_rm_get_lm_peer(struct dpu_rm *rm, int primary_idx)
 {

