Return-Path: <linux-kernel+bounces-90441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A4F86FF35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF90E28609D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586637144;
	Mon,  4 Mar 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KANii62M"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766A374C5;
	Mon,  4 Mar 2024 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548786; cv=none; b=NLmqnkH2S6T1j+GInARRej5yky2rB6Ox9dlaafbESp3KnhPrEswxaE84+VET480LWs8ZaHq3fL0bJKlxgGLBIEKv54Mo4oQ3JGRxsQ0UlMIKXrwKuHb9xX/eaY2dC3aCofUWqCTGEWbjqSLHMBQGbSH/1tC8caHFWhY78ezkQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548786; c=relaxed/simple;
	bh=alO/U+Jf4iG9Oroj2wjLRn2JHcgNm638lBIgiXhN9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaSn/aVD+Kp3NWdrcyVYRoEKHCW7Z1gcUNntfa86+oV4kFbSX71FQTRKkckX02FcA+Unob8iO4Iacd7J0imZ4DWaVUXgQzpJIv9dW5Ft2Av5DTr/qaXTvK32tgCQAs5n+cmcrwHj127r9EFpRLpfxLfQxMLCKDfssE8K34PZpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KANii62M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso17582335ad.2;
        Mon, 04 Mar 2024 02:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709548785; x=1710153585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6jXvq2qmm0+17q8SmauhVcVGT6BLcIEeqQPZJ4ozCo=;
        b=KANii62MMM+kT7Xk0ZkeVA7WohutQMKM+gnpwHDxeLxh0hpjdUT0Ru1Qhm6dPHo55t
         rpz97OG9MXRiylScAS6PeOKgzdOse5SXevGGhZ1bxPU6Rn/ssBkKQ60/Qvnqip++xhCx
         aQQ5AYye8vcMfy7iB94/Y/F4xmmUe/NANbj5QyD5AFesGs3D4q9iG6XWwgROPdATG8RO
         FfmCnjrMJ454+mtWJJsIS9jc9uIpjTWw9T2HM34J0jmcG8HVPDR+fLOv37mvPIjnQE5v
         9I/QxG9YnhQuK97sXoazXEqC6zpUtDYNeuUKY0Vhqkyk+m3i7elZUMYQyCU3NQcjRhkc
         uOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548785; x=1710153585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6jXvq2qmm0+17q8SmauhVcVGT6BLcIEeqQPZJ4ozCo=;
        b=O0uT/XOilMh+kQTRSB7BDx1aZQyPhrHnFFkm7YSeghzHbcbfK46Oyqqw+LSlrVj0ve
         mkxDSy7LR72mh47df/ugch86pS4/4OllIEdBAqxVY+Q0oxk6nLp45CgTfWaNQuHULcmY
         Yjh3Z4V+Gu7qhu+KuSVpqalS09kS+foBWVsZ3qClZcGtFUdLZ7CHzheUZq5kHHBZuGwf
         WgXk+Paf7WgocbmaE4MlrWMLO4kYSc+ARHjRHMi80XoIDfJyzKWTUKoVEflmZm7wTU4F
         RNPcSfrqSL2EKLOzIm6Et8d6EsP1p263KGXsfz5ROX14i0UGIBK/H/i46Czx5b5XcJSz
         qLfw==
X-Forwarded-Encrypted: i=1; AJvYcCVN1T2FcL3WXmBMLmY6BfGRw81dVuJUDHAFXVKBjOg0VOV3x6yGhT8aR1dHsWYd/j9u9IUlCcoWarlWMs5vb6BI5g7tJU5LNLi4vBSpWjxKWvILXTeGaZ/WC/Kjyil/ou6aW2txXR1pWLw=
X-Gm-Message-State: AOJu0YxqXYvlISOB3gHAPDSSSYfzboapPSJXh3C15GvPNuxYLNFYaZKg
	/WeOFQyyorQyPtVWWE92+o8Xa1G9YXEqAZyWRHzBA1Sw916u4yr+
X-Google-Smtp-Source: AGHT+IEphhTomhgd7MG4T6Wq2PB7tJCXnPsbBg2jNkJtivGBCIyhb4QbXO0VSm2T34nIBhRMQtl5wQ==
X-Received: by 2002:a17:902:6f17:b0:1d9:6de3:9980 with SMTP id w23-20020a1709026f1700b001d96de39980mr6812671plk.48.1709548784665;
        Mon, 04 Mar 2024 02:39:44 -0800 (PST)
Received: from localhost.localdomain ([103.177.252.48])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001dcb7b28705sm8170330plh.26.2024.03.04.02.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:39:44 -0800 (PST)
From: Al Raj Hassain <alrajhassain@gmail.com>
To: 
Cc: alrajhassain@gmail.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jeremy Soller <jeremy@system76.com>,
	August Wikerfors <git@augustwikerfors.se>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI quirk table
Date: Mon,  4 Mar 2024 16:09:23 +0530
Message-Id: <20240304103924.13673-1-alrajhassain@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP Pavilion Aero Laptop 13-be2xxx(8BD6) requires a quirk entry for its internal microphone to function.

Signed-off-by: Al Raj Hassain <alrajhassain@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index abb9589b8477..90360f8b3e81 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -416,6 +416,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8B2F"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8BD6"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2


