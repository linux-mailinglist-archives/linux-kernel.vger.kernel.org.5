Return-Path: <linux-kernel+bounces-3868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168181745B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD481C2498C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C53787D;
	Mon, 18 Dec 2023 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sS0yFIh4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EC1D15F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so31217985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702911431; x=1703516231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejW8mYTHsaSP2x9nTPGi1Vc36flABAG/m92kKNfgtE0=;
        b=sS0yFIh4aMOJF52M1eZFoUnOZ+8uDkKCEnUpBsiNZR8FioNQ+TiCANkpCmwVxgiVvU
         NB+1Tnsii1UwyHtlO6SZzWQMaIEwoeDWSjR94n17YVX7akSV7wHUtpx7lX9QDLS/EDWe
         rhJMFj6iJQlswMozfPuIV8qe82/iT+jn3u8AugmjSLH7RnZn/AdK7GlVmwsP0j+g9Wwp
         nkC65Eexes1OBfha3aBU7Q2+oV5870lREInFH1RTkOHeLxRTUMhpbpNt//LFoZnMgX6H
         dhhRwVi8CGoE/EjrWRNOUwIA7cTts3dO+P2G+PZ32HRbDcX1DM4HhgCtBD64onaTLUU/
         annQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911431; x=1703516231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejW8mYTHsaSP2x9nTPGi1Vc36flABAG/m92kKNfgtE0=;
        b=tssNKseqZG6XoiuIbY2UQ5utNSaEuqKCoUl0ug8r/zGKB2hkokJDTjroy18qnaXdGd
         8DdBqxhGQMDxpd2aeILTNyeOrcjZBtxig68Kxl+NXMK4GqLEoyiIQCJdwUHQQIEpVLHg
         lgQh3xSKD3BpEklAkT77Zx62fTVsyUc82ohjoHV5gxOB5dtslTwuJ75287iw9INqc1cw
         CF8iJeZ8Sqi63MWYoH4y8YS4ba3Vm6ulAhjgpQ7rQC9+SxcH4JG1o3RMkVdRqef9hauk
         MFhA7FC+M4c46KaA0fVAFW648D6xDD4M6sql6uM5Y4sBPLkwhvvlz3yUShMjis6iz8It
         P/Lw==
X-Gm-Message-State: AOJu0Yxil2ssMLq+KC18g8xfN6YACX/nO8SCWvupVEdQsNys0/i1aOjO
	CwdnLeCt4JwifoPG5MkxZaYlPA==
X-Google-Smtp-Source: AGHT+IGMmNT1wjDlCVxKWzxDjNxrJWY/X56rrN+bYXUA9s8NkWBJWZr4tcv3yKeTlvtQ6zaikL0UVQ==
X-Received: by 2002:a05:600c:46cf:b0:40c:3d90:49f1 with SMTP id q15-20020a05600c46cf00b0040c3d9049f1mr7972031wmo.125.1702911431628;
        Mon, 18 Dec 2023 06:57:11 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:29f2:94ce:d35d:aa25])
        by smtp.googlemail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm35465477wmb.15.2023.12.18.06.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:57:11 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
	Hsin-Yi Wang <hsinyi@google.com>
Subject: [PATCH] ASoC: hdmi-codec: fix missing report for jack initial status
Date: Mon, 18 Dec 2023 15:56:52 +0100
Message-ID: <20231218145655.134929-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This fixes a problem introduced while fixing ELD reporting with no jack
set.

Most driver using the hdmi-codec will call the 'plugged_cb' callback
directly when registered to report the initial state of the HDMI connector.

With the commit mentionned, this occurs before jack is ready and the
initial report is lost for platforms actually providing a jack for HDMI.

Fix this by storing the hdmi connector status regardless of jack being set
or not and report the last status when jack gets set.

With this, the initial state is reported correctly even if it is
disconnected. This was not done initially and is also a fix.

Fixes: 15be353d55f9 ("ASoC: hdmi-codec: register hpd callback on component probe")
Reported-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Closes: https://lore.kernel.org/alsa-devel/CADYyEwTNyY+fR9SgfDa-g6iiDwkU3MUdPVCYexs2_3wbcM8_vg@mail.gmail.com/
Cc: Hsin-Yi Wang <hsinyi@google.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 20da1eaa4f1c..0938671700c6 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -850,8 +850,9 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
 				   unsigned int jack_status)
 {
-	if (hcp->jack && jack_status != hcp->jack_status) {
-		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
+	if (jack_status != hcp->jack_status) {
+		if (hcp->jack)
+			snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
 		hcp->jack_status = jack_status;
 	}
 }
@@ -880,6 +881,13 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 
 	if (hcp->hcd.ops->hook_plugged_cb) {
 		hcp->jack = jack;
+
+		/*
+		 * Report the initial jack status which may have been provided
+		 * by the parent hdmi driver while the hpd hook was registered.
+		 */
+		snd_soc_jack_report(jack, hcp->jack_status, SND_JACK_LINEOUT);
+
 		return 0;
 	}
 
-- 
2.42.0


