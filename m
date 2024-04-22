Return-Path: <linux-kernel+bounces-154099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833258AD762
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A7D28512D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BED2942F;
	Mon, 22 Apr 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5muHwzf"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7511401C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825707; cv=none; b=ZDgsaoAqEeH2l4Seyag0I6xl9WOfBOXNmSgIWZialw6//BgSWwo+qv3HIWPYbULHUAiOVmL6fZrBQt0Jfdl/VmH9IcItcUUitRr6jHGz2b1/I/dNcZOj6oLv3P0cSKGOBZNv3PybLtDxhca1G6MVdF+ia7BSNCY4clvQFogdKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825707; c=relaxed/simple;
	bh=7z4pmgTnG4Cx/qyy0oovGayPE7RrU7efK6HlRo3qrMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=YpssxDv0oTOX0ft1cy0cJs2Yt65XWJg2kkILt90M1idd2RyQJ7Ed5zawLfHpeX6ICo42ToUvkH/ga6Dp81RL69cHHwXqzjtGkDwusbMa4GbgrwU05m10tQaXkprx1qk2lEdVycMXyA04a7IpTHma3JPCzanWMLNn5vAnRv3tU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X5muHwzf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d264d0e4so5374400e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713825704; x=1714430504; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPnsn2OSysGpv5TKW78M5Tg/2Wa67GE3qYBn3t9cqAM=;
        b=X5muHwzfCoP7HH/w58q7JS04cNfxHmS+Ac3ydIQ+HmbQxTLB5NZHFmcbeQBEDHT7Nt
         rQOE907iEPc/7sa0Bg0sz5joAtMpoN1od5AsS/LoNw95/sFMq21ihzgXy4NjGQ2WHpaG
         EONGK5bMq+aFKPR1SpTBdvgrtDSX7dJ3hG4UCipSCt1cAioArB86Jc8jXtl7i9h2L22y
         RBkLxqnR/hAZRSm0Mt8vCvObGBrtiFp/ZbKZAXEP/AdpA+nVe1I4ui1BoO0fIoRzF9wp
         tM1BCL7L0C13k01s9yulwEqXtP6YIMTPa5nV0Wn1OGUTIdppnrg97jbFACgltvq0FA/A
         zvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713825704; x=1714430504;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPnsn2OSysGpv5TKW78M5Tg/2Wa67GE3qYBn3t9cqAM=;
        b=JH+jv67zawjm8u0udTS6nsHp0HtCHSJKI17pTnCL90WneqVAv3+boK1faP1JRoRojZ
         /vLwDGxr31lQcvygBOPqc/jJ1eOy7sVNM9oT3SgRN6LmbgmMZggfSceiSA4QgYpvDghM
         IQaua39ifLB/XWk9wFnkL19no/BI1X3TCHt+ECuZYEJK4KIfey8Wk1eeAPFSuV0OpnL7
         84m6G83kqNKyXk6atRnFDxnigTJdfSPMnoSaxcooljmWdHP1A2TwXlOaYTHnrMxX8mdX
         9K3neI6k+1czCQp7LaL2eq7fUNR+Vb9WmyVqBdtI3HR0Z0UEXdg0y+k22/m6idD0pzkd
         M+jQ==
X-Gm-Message-State: AOJu0YzkrOcnPbzIZOZz1HlxfspL0Ulqcsn7PVVjAZYjSn0uopMAI50J
	qu1qOFQswbDUmhg70DQA5N1GfCO5hCcwsKkbdKXZeKQ5R2HVi7tfIBsKasVvki/z81qVLDK+QdH
	D
X-Google-Smtp-Source: AGHT+IGVz65oiA/xKj5qJuJZctLNHRNRS04mqZZfK14cmbAzH5e3Njw4oEmfMIDzunAEVyA/qZZz1A==
X-Received: by 2002:ac2:4184:0:b0:51a:c4fe:3397 with SMTP id z4-20020ac24184000000b0051ac4fe3397mr258938lfh.23.1713825703846;
        Mon, 22 Apr 2024 15:41:43 -0700 (PDT)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q24-20020ac246f8000000b005130ece9099sm1829517lfo.277.2024.04.22.15.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:41:43 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 23 Apr 2024 00:41:31 +0200
Subject: [PATCH 1/2] MAINTAINERS: Add a separate entry for Qualcomm Adreno
 GPU drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-topic-adreno_maintainers-v1-1-21e1adac2c13@linaro.org>
References: <20240423-topic-adreno_maintainers-v1-0-21e1adac2c13@linaro.org>
In-Reply-To: <20240423-topic-adreno_maintainers-v1-0-21e1adac2c13@linaro.org>
To: linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

The msm driver is.. gigantic and covers display hardware (incl. things
concerning (e)DP, DSI, HDMI), as well as the entire lineup of Adreno
GPUs (with hw bringup, memory mappings, userspace interaction etc.).

Because of that, people listed as M:/R: receive patches concerning
drivers for any part of the display block OR the GPU. Separate the
latter, as it's both a functionally separate block and is of
interest to different folks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index de49e2d24770..179f989a1e4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6885,7 +6885,24 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
 F:	drivers/gpu/drm/tiny/panel-mipi-dbi.c
 
-DRM DRIVER FOR MSM ADRENO GPU
+DRM DRIVER for Qualcomm Adreno GPUs
+M:	Rob Clark <robdclark@gmail.com>
+R:	Sean Paul <sean@poorly.run>
+L:	linux-arm-msm@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+L:	freedreno@lists.freedesktop.org
+S:	Maintained
+B:	https://gitlab.freedesktop.org/drm/msm/-/issues
+T:	git https://gitlab.freedesktop.org/drm/msm.git
+F:	Documentation/devicetree/bindings/display/msm/gpu.yaml
+F:	drivers/gpu/drm/msm/adreno/
+F:	drivers/gpu/drm/msm/msm_gpu.*
+F:	drivers/gpu/drm/msm/msm_gpu_devfreq.*
+F:	drivers/gpu/drm/msm/msm_ringbuffer.*
+F:	drivers/gpu/drm/msm/registers/adreno/
+F:	include/uapi/drm/msm_drm.h
+
+DRM DRIVER for Qualcomm display hardware
 M:	Rob Clark <robdclark@gmail.com>
 M:	Abhinav Kumar <quic_abhinavk@quicinc.com>
 M:	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
2.40.1


