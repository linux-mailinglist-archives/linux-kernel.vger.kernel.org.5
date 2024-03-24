Return-Path: <linux-kernel+bounces-113299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F11888337
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF631C234AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C10190674;
	Sun, 24 Mar 2024 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJJ26Oix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57713CD46;
	Sun, 24 Mar 2024 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320099; cv=none; b=Q5Ot2sd/o89x3Ixt8f+PWVKxDIbw4WMlHcK8rXrji/N61QMCwHgzRf9h21GJ2G/eHuO1EMNsCJ0DvAMfHYq+f8InGvmVVpMxoah++P704z+Q+dcYNL5OxSvLnQrKbLBlXt5/uY8qI/HvI+QZxdyRTLI4ETu3/JEib9YD/KJWgnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320099; c=relaxed/simple;
	bh=9JjK2PeRONgGDalNPKjTIIzQS2I0VNpFKGvX2wf6ss4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL8+/fw8SO48EgeMmpGWrR1VtniNk/Mr0/AiaRZPqXcuQm/v+2sif0kzHN6q0t+x0lSkFMmLuIG+G7IADw9NBm12yjTzhD1HoiFp/23Eu7Ckmdu4+YqsTUj3Gx3m/Ecy2/+xgrcc4ZzOPEPd/6bT5+CBF1wRHope0lgEFy21soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJJ26Oix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E87EC43394;
	Sun, 24 Mar 2024 22:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320099;
	bh=9JjK2PeRONgGDalNPKjTIIzQS2I0VNpFKGvX2wf6ss4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJJ26OixraH+sjTvMnzy8iTRsFxTDksYHc+SxyVS6l+K1zpYi9718ALmUY/LacTTF
	 akicBgfs39wPljsfbri5coDlBBJQezDjWHL97hDW1ztf+9gt2Jr9GewhvCicx0CeDW
	 RWAxG7ysv6VsoKG2w5uebAl4BxmOPCYOHoqxI417toKIB5aAF+PQcg5JY/Wcxl67Cf
	 f2/Sb5LxV4RfJeUjk/u3nB6Gw+ySzPTmWar90hfG8cVM86lajJ81Y6wjoIoErNwf+f
	 JRFzNPA32rHfqiiY/sxb5rBC/Te1QvxpRHmKpdxEcbbrBdD9MoAEHmh5+PwxJJELT7
	 SE41VXjyisU7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 408/715] ASoC: Intel: ssp-common: Add stub for sof_ssp_get_codec_name
Date: Sun, 24 Mar 2024 18:29:47 -0400
Message-ID: <20240324223455.1342824-409-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit c1469c3a8a306e5f1eab1ae9585640d08e183f87 ]

As this function is now used in sof_board_helpers it requires a build
stub for the case SSP_COMMON is not built in.

Fixes: ba0c7c328762 ("ASoC: Intel: board_helpers: support amp link initialization")
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240208165545.93811-21-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_ssp_common.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_ssp_common.h b/sound/soc/intel/boards/sof_ssp_common.h
index 6d827103479b5..d24888bc99fde 100644
--- a/sound/soc/intel/boards/sof_ssp_common.h
+++ b/sound/soc/intel/boards/sof_ssp_common.h
@@ -67,6 +67,14 @@ enum sof_ssp_codec {
 
 enum sof_ssp_codec sof_ssp_detect_codec_type(struct device *dev);
 enum sof_ssp_codec sof_ssp_detect_amp_type(struct device *dev);
+
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SOF_SSP_COMMON)
 const char *sof_ssp_get_codec_name(enum sof_ssp_codec codec_type);
+#else
+static inline const char *sof_ssp_get_codec_name(enum sof_ssp_codec codec_type)
+{
+	return NULL;
+}
+#endif
 
 #endif /* __SOF_SSP_COMMON_H */
-- 
2.43.0


