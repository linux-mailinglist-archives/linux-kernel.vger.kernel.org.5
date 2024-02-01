Return-Path: <linux-kernel+bounces-47908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E384547D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1331C1F222E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0524C4DA0E;
	Thu,  1 Feb 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4GFc6xi"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9534D9F3;
	Thu,  1 Feb 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780771; cv=none; b=J19+Z7ZfMlutWLA+XLIEbl+SRpfzkHQ5BbJEfBX4qHkFJCqwiuvhUfA2wkAOgGUL/fVvh8grWeaqciGAHr3tEzHyIwMPgijquov2TsTkAdhabljommLn4IeEo6vgnS6fXvJiTTvrqGYuV8FqrzIcw98S4OWn8AIMxGa/qCfDTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780771; c=relaxed/simple;
	bh=TPXMi1Cd07luB88h99QffwCCm9xYEkN6S84aODXMdyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOAgmrVgD3w1e5G344p5M13iEH+5JzodQKJ6/IWX7/iCH7EbibsA6RpAjPZhLrkO7FzekD3qaKYC/RDbg1LaVUu6w0bxF/hGJLtmiMpP4CNQBMLArN0oTs6oKHxVLazKAsvH/wqDljkgVHWn6dI8fk029xY5O39BgQWTN1ycNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4GFc6xi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b17b89a08so49559f8f.0;
        Thu, 01 Feb 2024 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780768; x=1707385568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GI7k9TIXMsyUsEptHwDW0LSrQzilihr/z0PyebfdxsE=;
        b=E4GFc6xilblQetCUgH+h8Ft+BHBPb52WLF6wEgUtSqchkiu/lxnKE+1vCQk77GgnJO
         FGGz2zfQFPwioMRfkGBWiNog4eIAFVS8dKA3pfmT0P58Fyenjrr1BNDB7+NgVZL8zJzf
         D9JTvT24eGR8q+oG9t9yJi3acZ6ZPWloFBFynaT9Vm2OHwuagsEXZ0kL1qv2IBOzjOwD
         ++i4z/Z49BwoLPXYQ+itM0tYyD+Or15WHNcXjb0q/IxkWB87slVZrqSM8TcKr1hp4zTV
         h0eYb9xsZtE5/fCoFiOGafzIRxjRbUETfpNEIRy93m4YTVgarF1foOLWjr09DCRmObsR
         xi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780768; x=1707385568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI7k9TIXMsyUsEptHwDW0LSrQzilihr/z0PyebfdxsE=;
        b=Qrdy7a8rhIq/BzlnEa1TiSxnMb/b6hP6N8A35syYDrDlUEW+Fxi9qMfljyFO0mhekQ
         lE+jZZ0Z9TkGQmnwYDS3Buud15aJ41WVxgr0B+iXkTe58tAWtyd4MmDYrUQrQwVtE+MT
         +v07nY4DP2KcLTiMKYKwSSf0hb2Sc0T/pHevUOPa2kOWTNLYAWqlz4uhJQB9TPr4g2eY
         0F7tNEN7ntMT942qlcMW8NJioV0HaHmny5uFC3jc3NTt+1Nj2eKb0MpePAfFWt2Ww78F
         YP8YM7icYlFJs5KLig+yYHWqxRox57TFUvY+Isa98Ff6tW2dUGK38gTaxQUmFsHy7+g1
         eL+w==
X-Forwarded-Encrypted: i=0; AJvYcCWbfGusXO17H+o3AREMn2+LkCzWNUrWykvcvMbf0RoYcMaGBBo8HS0jKsZ/5X4sJpr0CWfOIq9EOQNj77pbUmxxua4jBIzPBu4IE/Xy8Z224/yanS8W8IvDOsziLyiN1q3KWhTZRt9zHRQ=
X-Gm-Message-State: AOJu0YwcLuFr/cCWYyBY16H5X418o5Hm4dCWngKYrer1ANX4Uyg15BY0
	W+Uwec87234i3IFryNQDcLfQPlggGUwH2CTPh+QLh8/857HCBz/Y
X-Google-Smtp-Source: AGHT+IE0NSBZ/IDEO2V/oEfZPA4CVRgC8sptmeczL/M6p6HN3fBc4RkXQHR3YxFl1ltdO9xg+sgbfg==
X-Received: by 2002:a05:6000:259:b0:33b:1383:12cd with SMTP id m25-20020a056000025900b0033b138312cdmr950116wrz.7.1706780767726;
        Thu, 01 Feb 2024 01:46:07 -0800 (PST)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:34a8:87bc:414d:acfe])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b0033b06fdb8f9sm3398203wry.37.2024.02.01.01.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:46:07 -0800 (PST)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: core: Fix dependencies for SND_CORE_TEST
Date: Thu,  1 Feb 2024 09:46:04 +0000
Message-Id: <20240201094604.1347793-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the CONFIG_SND_PCM dependency for CONFIG_SND_CORE_TEST config entry
as the test uses symbols from 'pcm_misc.c'.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 664c6ee2b5a1..9a44f259ccca 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -42,6 +42,7 @@ config SND_UMP_LEGACY_RAWMIDI
 config SND_CORE_TEST
 	tristate "Sound core KUnit test"
 	depends on KUNIT
+	depends on SND_PCM
 	default KUNIT_ALL_TESTS
 	help
 	  This options enables the sound core functions KUnit test.
-- 
2.34.1


