Return-Path: <linux-kernel+bounces-48919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A756D84632C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533291F2603A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946AE3FB2E;
	Thu,  1 Feb 2024 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSIdDW6G"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F263405CF;
	Thu,  1 Feb 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825488; cv=none; b=lwqNNDJUWh9BA0nt9L4WeNFPI2DdtUStHFb1GuCEgmdII9/tLb0ZfgrcXvydn1flPCvsVSuTzKFxFZRGo9aKBoDIkqgHoaD6NlPhq/9X5yaCLQZrUMOLYdz4pURsQA1ScEyVfwlyOoNhnf1ap6LN9nYZ5f/OaVHEXBekEjj3m00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825488; c=relaxed/simple;
	bh=Ssyx/JAS2CDbyhyG3dsAH7vxQvDIszH2q5ay8Zxn33M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szX8U0BRF76RCKsAEdA7ywCpPMXEdGYq4VuNvT9Xm7ctF95je8yWVyTpI4jpjAWf30OWQj8nNyK8QgbD1AEzbc70ggEVzQtwAvtwOY2sYmGFvOIe0ykA4qCoxwQoF0MJxj0duyxruiAUIZlGuPlCPp84utXzvrErumNCm65l4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSIdDW6G; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b17b89a08so147802f8f.0;
        Thu, 01 Feb 2024 14:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706825485; x=1707430285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgCLkBwgH/Cdp07/Ys8kcbbnDNfGaAeuAJIUl3VFESA=;
        b=jSIdDW6GQfMOcpBqpW2GPJaXOOiZuccYFcB0fL7EHAmzXreMYyNbdfpBAmnnIy2wWR
         mHWlfdJ+nIzA2o3S2HiFGQow4n1Mvn9ADqPBDnEDfR60XHTKOI+fvSYAyWVTUb0Ytssj
         Ki3W49cHzujGhJfRGgvXuk5T7N8EmSIXk1xiT7OcWVJOnb1YDMqHyHiEMxPX2gFdgbLR
         p9kuyd5w1Fz/ofj7M/86hcDNBA2QcmrXZHhePMWwsJHSYSG/vXMfmZN/A+cztFbgCeJj
         NBVdbe75t9Ft7h3v/nvqEQFPqQuNmct02tZp/z7VNhCJWjuMifLqZ8ect6lobpezdROv
         Ow0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706825485; x=1707430285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgCLkBwgH/Cdp07/Ys8kcbbnDNfGaAeuAJIUl3VFESA=;
        b=fkEK3dK0YSMYfwY7AQULqsxUhw00MdX7u5nHn6iXRNvcLvcRpwCwsq6npFhOnAeRut
         tRO3u1e5XrCjjP18J7U9k4UuyhbJ8Sy3YizzvB7u17dNid8g1dDmtx82c5hCZ1KLuIPZ
         YuB2QE7zGCpBYSnscumKct5XQMm6eTBOYZTYSjtiUlH/qfE9rC7A68DqIbKAurDHN/wH
         ftNUqK77j4AO4hRHONA+3JQDJxBfaOeLaeBGea2DfNzL95kGd8tzcH/CFsusgR3ZX27h
         L6ZDCu7Th4RoHf5AKtdgwMjvrVc9NixE6PIESEviv7JFJfgVuKxCpc1/wMMU/rz0bpmv
         Gkrw==
X-Forwarded-Encrypted: i=0; AJvYcCV03MaNNi2MZbncRng6FHfuRyGxE7MYlDiByM963s6OJfIGEgtayxORlaoXKtEbraDOQCANVmETQn3P7XqEPhlr2zQx/QYnhb77T6bvtU/Zm/HDWCMu8BLOClQoo6+kGSpmztW3zJQAEE4=
X-Gm-Message-State: AOJu0YwOJw2NaHARb61XX+EEGjashGzvGxNB61ImNtDZHMGP/buMTjB/
	D9HvSF/7Vo0mBjpaSwcEj2Hm7NWf+KOz266OOsmXAj5mstxV0Zed
X-Google-Smtp-Source: AGHT+IFHVDFGSXBvDSGM8Hul600Eny5NU2xBrFgwFVYeV2jHJeUbSKbE68xYPrPxNccVDuoCxBd5nw==
X-Received: by 2002:a05:600c:5022:b0:40f:c400:eb00 with SMTP id n34-20020a05600c502200b0040fc400eb00mr584716wmr.3.1706825485272;
        Thu, 01 Feb 2024 14:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXyIYYjp5c3Fdm01++kIIWDKmuFK2MD3iy9KOaEW0glaOf71MTGWhOf9Lt8odzF6+kT0B0bo47fWx3pDbU/m7SYJR7JhqrhmD+LoxvSf5Wwqy/wYfYRWKYfqbruGWDG4wrr1y1v+xp9aU4=
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:6518:5489:98df:7ab6])
        by smtp.gmail.com with ESMTPSA id az39-20020a05600c602700b0040e596320bfsm119021wmb.0.2024.02.01.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:11:24 -0800 (PST)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: core: Fix dependencies for SND_CORE_TEST
Date: Thu,  1 Feb 2024 22:11:22 +0000
Message-Id: <20240201221122.16627-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select CONFIG_SND_PCM when enabling CONFIG_SND_CORE_TEST, as the test
uses symbols from 'pcm_misc.c'.

Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Change 'depends' with 'select', as the user can't enable SND_PCM
  explicitly.
- Add 'Fixes' tag since it is a regression fix.

 sound/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 664c6ee2b5a1..8077f481d84f 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -42,6 +42,7 @@ config SND_UMP_LEGACY_RAWMIDI
 config SND_CORE_TEST
 	tristate "Sound core KUnit test"
 	depends on KUNIT
+	select SND_PCM
 	default KUNIT_ALL_TESTS
 	help
 	  This options enables the sound core functions KUnit test.
-- 
2.34.1


