Return-Path: <linux-kernel+bounces-150284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE38A9CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05741F216E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE97171E54;
	Thu, 18 Apr 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lqZPH6Zt"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A416F902
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449858; cv=none; b=PJd7t236s4rniyptyu/kgEVWtVF70EjAI5ZmwjYXILbwd8INTGzkkiehGVzGc405s95oCfh/sQ//JF+a8h6H5BF/3XNL5EE6IsFrskTSouN4i7OCCoqqZCMrxkg8FOqMY6nxNDTwbtU0AI7oL0ziO4d8sAdUiIuVx/5HN2HH+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449858; c=relaxed/simple;
	bh=woF6NgCy9sWp4jU9xhCym7WDVQPI/tzmO1lBDEzOVXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itdYTo0nMVO2HczYtknB8go9jww6BZn3E5ZZZ5fz8Px6HtbWt9NiHCIyDb7zuipcamyb+LkhYa5LqtXSwd7rzPBe9ZcCSdRWdQZiQAfcpL7vQj4hkUr+HR0aaC821LG8kJkOV4gjM5rGOpwaOzZBhsUl+SJyVNpUC42n4jwahIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lqZPH6Zt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-418c0d83e61so9983355e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449854; x=1714054654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ngpZb20B2h9Qc9IbX5I/ZiczUNGoVVnils8jWsBLdA=;
        b=lqZPH6Zt0V7UtpZI96qZ9P+1Ts1ZcrSUa6t06K4Bo6TPDdGfQHnE1Z182f47P2riSm
         MjnDhs7nkuycOailAu64J1dHiQOhvqKWZS9UAXyCHQ4cmOC+RctW1ek51LMtnbNWNqYS
         rg7IxKXDBAUWcGr5N33PHV1P9MuPumurbuy8OQOts33dXzF0Do2pVonnDVIJe57eb2F7
         DvTZ+6tjQGviUlY+9AeiNMkpbwx76Ne6Rj/svkJzKs8T6Y/yzS9hrSlbZytAJZ6Xd/1M
         DBVPoE/HoFjGUuMc3BLHPT2OouWaaUIN8l5h6zeB5vs5xvT7IuDUwavWG9YwvsblaFol
         0h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449854; x=1714054654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ngpZb20B2h9Qc9IbX5I/ZiczUNGoVVnils8jWsBLdA=;
        b=QFSEwmsO6KGJAaGPjQgIMjNnyp7uYIUdd4vPaqsvBbhWK9MMz8zWcrgc3xjCkkrmOo
         PGWXsHNxrC5siBl6JKvsGOTrUq571+VgKc9PeRMCUFiNFqmdRGsenyvPTDpKVUJ9IASn
         tgx7NS1eBaF+ptjTRtyVlI60W6JA5xwBi5JGjvf1gpTKcFb0MJ4Qf7VXlHI5S91nkJ94
         bvtQzzwtk11eklvmWwJknVKkKrb6cVDIgdafb5L7x/p3XFY9sEBkearo88b1OTjutbct
         OG4GFiOj/ETI05vIc3wKOlSwqY/a0mlGCIVOIO9SRm3dE34+d6fyM9Oq84U0Lz7srtDm
         sxXA==
X-Forwarded-Encrypted: i=1; AJvYcCVgE+bkArGrWXBalxK1Ee6lPN3kQm56wlkEjmG+83UQMo13rqV6G63RqVtOQDpELOUl0E4FuGZUYf+x5/Bv6esGcu7/EwlTlzF2Nmeg
X-Gm-Message-State: AOJu0Yy5ELvcsz7C2CifnpkB5BCWfUI/SkFQgc5GA+szlS5KX5LHOC6m
	fZrgnqAbGu/8pHE4AIrrTnag2LV8CpvFwirvHFIEuBaif4n1av/5R0JGHaTN5+o=
X-Google-Smtp-Source: AGHT+IGNk7+q98Dt50c94htj2Yax4/KnYeuA1Mwztlc7Yw/kKE9BWFSk6X7OkJkTV8uxkSAExv++dg==
X-Received: by 2002:a05:600c:5254:b0:418:fb6f:5f3d with SMTP id fc20-20020a05600c525400b00418fb6f5f3dmr290856wmb.17.1713449854525;
        Thu, 18 Apr 2024 07:17:34 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:34 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:17:03 +0200
Subject: [PATCH v3 15/17] arm64: defconfig: enable display connector
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-15-53388f3ed34b@baylibre.com>
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
In-Reply-To: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Fabien Parent <fparent@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=693; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=woF6NgCy9sWp4jU9xhCym7WDVQPI/tzmO1lBDEzOVXQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStjXZeg5Jh2Is/gAHWoRmg5aIyMiEXbGdEHozO1
 0cFGgByJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYwAKCRArRkmdfjHUReAhD/
 9Yax8im2q4PngGvAwi5mmyFvPkrrQweqeFZGttybB7sZdfiirXSiQhiPajWkHJ5qYP3CaLIdpsBbwO
 Rly04rqoR9UjnSnssubHEZRNV8FDtUpWG2kx2KI8YtrPQXLedyoviZ5yXRMhrIo4YQKztKVAM1anaN
 +4z/FdycM/OVy+qFYOtxIBm5OZVvmTBFcaobZ7N/b8dnOVarjKVjWcJMqc5DvBg82J9pfb7i5a32+j
 qkq7SMbQJPWRhsJJ1p+PmDZc34BROzx6SdrqIaQTJnDjE3jg9ejPrn72qGRpeCHd5u+WRMmbRlWe34
 QjAIUX44315fL/fLIduyc01lfQV48zhoOFVjpUGN219Rl/nbxQdtQizyG9s3C52+sBnHtBtCKGtM5p
 KeRTXx1RnMx3zK5gkElzJRvnWP3BpiS7jkdcymFux9TZriFYx9saLHrclsMJIMoAgdDwNvi+2YDgbv
 ZFd1zRXXRB3wFltaeIYmv61ET5XbsgRNVlB3erg09SjegSD5W4C+dUv8X7DTr/JNQYk5xB8c0r5kLA
 S1ZmTU+T7QLg2br8fX3i9CU7FZDBm4vI+C/FubNpkg75I5aXe2dOy+RetsN0udQ96a/LBJPDmKFksS
 ZnLWgsJyU/bn4dG+J0ziy4jI04KodR1dokrbqRImv1aZvrEx8euPdeTU6aiQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable this feature for the i350-evk HDMI connector support.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fce98a150014..1df337882835 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -872,6 +872,7 @@ CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_FSL_LDB=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.25.1


