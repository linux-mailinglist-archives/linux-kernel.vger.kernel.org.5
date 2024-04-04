Return-Path: <linux-kernel+bounces-131217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D78984B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656301F2826A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453A76413;
	Thu,  4 Apr 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEhjYnRO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D951757FD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225293; cv=none; b=sx2O9N1A5QEDAcN/P8pQkm6Mg9jbzXgX3CUccotzb5sr9uvf3Hz2I0vTMYiqJmyNKz4QLsIGEThyv5GaqcOoCS7WgJzGMF/zXh/uqTZtfRlYZMHo/O0fYaRJL+nCv7mVKDwHVmHlubb1EnQb2WgvkepsAt1wzfs0rctHf8SFmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225293; c=relaxed/simple;
	bh=KIPxE7WAFkz5qGRN5hVp/Vx45cUpVvzgjI6wREzKChI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twOuS9BJtyvpDV6s7Snt/vmF9cBuNMooVn88S0qYEYTcLJieQg/PKCNZnp6694NrX/H1BiCvtNrYyGdHV4aXFi/9ZkCYytkAcGvWSgkTf+vxWmCGLSG8DmugShCNXWBqnnsPRgL1z6pzwuiCV5LEhBAlVN59RTlEpu+VFuQ2ahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NEhjYnRO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4e79d7d21dso52456266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712225290; x=1712830090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOrh7Irjq4f+bzjvRmtdFPtj9HsVRJ5Kf8V2j16C7zQ=;
        b=NEhjYnROciz/IepXDfxlz/A23LWh14iXuHfhrwib3ovC8SglvN3HkQx+cFa3596rYD
         rITiJf46wWCfmBEtj3rMWEHEUVAmfR50/JAtc5DQn2L9cKy3yPsF/WRVXLjVGuNpjCQp
         IPW/7RQUP+KptOMfUTSLOCLmSAwZXliNRXkiRKJCR44crfhQGZITCJ+zRdI1uFU/l4mf
         gbNHvMBPU94b8Hb9nqtRNBNHJ6GeSv3uZjaGfKo8+lwneJJigwaSwivigNi021IXmRfs
         kjdzBF3TKZzUzMJYreujJfKwHArQC54XW1hPcAoRzEUTGQPVECs2A+oSJskGCz83/cVT
         kzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225290; x=1712830090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOrh7Irjq4f+bzjvRmtdFPtj9HsVRJ5Kf8V2j16C7zQ=;
        b=O5xxapu6pLqr2/1aYtMelrMfnBeJAxX/guhQTHRuIXk9QYqn382WJqYv66/BCRR3Dc
         qeMlGW5BGbe2sMepmOqHKuoJBimDg5MCggIR0l7HxRzu29O6VTKVi3A+LipdcyQ6qpMB
         XXGL7WblPwalV6tgwcmyyIrZ980Jatwhv9J7+WcpjuqB9b3MmfrtUm3ZGuZRN6tRMoWN
         AzQwnfw3eXn4c+LIi38nTnIL3rDI6Hs2QsvI9Ah87NazXEYuwWZEbHjEQ6tLYFT7DEOI
         jdoNl9LmW7M6mMHBlTOR2AVT6bQ345SlGfyQ2iEgKxmcxsoSBGGOZhFE22B7FjV/MkqT
         cFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSZpEgsX+c+jYn7hj4erL6jKLW46o/QggHtMH9hUDe9riM5cLlEm92BCU2PO+FY3mV39gpLQGCOxqE9Pld8ir58Fel60KyTMiQSieJ
X-Gm-Message-State: AOJu0YxokIQVfwYujPmjeVlHzuVkK0Gr6CBbp08z8bmxNzSrmK+UmiK3
	xEPPPnVQfPutvnkIKIKnds7D1O5UTzPydwe+T0laulIlEmIB/5KzjCeog5gT3ZY=
X-Google-Smtp-Source: AGHT+IFFx0jNeXxS8p/PVfSfopzv8XenHyOICPv85lhOjQmeM3QgrFtbE28snmGj70mzNCw3CZotQw==
X-Received: by 2002:a50:d596:0:b0:56e:a2f:34ef with SMTP id v22-20020a50d596000000b0056e0a2f34efmr1734540edi.11.1712225289818;
        Thu, 04 Apr 2024 03:08:09 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm1984219edb.3.2024.04.04.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:08:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 04 Apr 2024 13:08:00 +0300
Subject: [PATCH 2/6] drm/panel: novatek-nt36682e: don't unregister DSI
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-drop-panel-unregister-v1-2-9f56953c5fb9@linaro.org>
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
In-Reply-To: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Matthias Kaehlcke <mka@chromium.org>, 
 Harigovindan P <harigovi@codeaurora.org>, 
 Ritesh Kumar <quic_riteshk@quicinc.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=947;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=KIPxE7WAFkz5qGRN5hVp/Vx45cUpVvzgjI6wREzKChI=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxpfDSv7hI3TUjp563fNvq67k9crjWPPPcY5oismPevXW
 RaeJfuvk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATyWNk/x9rm9pqXJBosO34
 jqepk9az65ZM2LRfYa1kTVNiU8W7L1HNBzW/LgzWmLGnjj9pT2qX7c5gy28JfsKTpuzbt2iX6fE
 ziszrD9ybVLOTK6HEPl/JIndJSFbX/0Jpy0U/7zD9yVG0Ojv7VWNr6GZZHXOV1BeZs/8IOTbU3C
 +2EJrkLJ0q5Cha23P75ZErlv0+mlZZ9gL2v7fNnfy72UEmx7D23auIedxlIcz/d19X01FsmP03g
 51JwLvQzf9LSWfLnMb9rjOSFlhL7TqUzNVTPkVHXuDXV8v+5JfK7YlJUWGtrZ2Z7TEy1cJHxRRs
 kler227qOfFAuEN3of7uTXOP8xYqtVX937MrZYLLhAIA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The DSI device for the panel was registered by the DSI host, so it is an
error to unregister it from the panel driver. Drop the call to
mipi_dsi_device_unregister().

Fixes: ea4f9975625a ("drm/panel: Add support for Novatek NT36672E panel driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index cb7406d74466..c39fe0fc5d69 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -614,8 +614,6 @@ static void nt36672e_panel_remove(struct mipi_dsi_device *dsi)
 	struct nt36672e_panel *ctx = mipi_dsi_get_drvdata(dsi);
 
 	mipi_dsi_detach(ctx->dsi);
-	mipi_dsi_device_unregister(ctx->dsi);
-
 	drm_panel_remove(&ctx->panel);
 }
 

-- 
2.39.2


