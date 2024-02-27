Return-Path: <linux-kernel+bounces-82661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E58687EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C441C21B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AB4E1C5;
	Tue, 27 Feb 2024 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3qjROJL"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B04D11F;
	Tue, 27 Feb 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005562; cv=none; b=L2JX3Ju0pN8k45/yAIj6mXnH60qsa3I5u5p4lHEtpIE+k3OHUej9M50AP/TKX6OorXFqNBx1QSbpUMSu3fnszl15wjPXi81eKSXGYqm34AYo+BBG2zEBiKyXRpqJIQdSIDUryH7v3L5uqp9+m4lTAHbaRQm1CiSvvgjxXm14hog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005562; c=relaxed/simple;
	bh=X5b3IjGl60IeajeIm28amEMfCeRIG7fmScXSfjrAU4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdxVhCjVBI+O+7i//MqrhDhrVo1OtK0jRyu+7kbxyFAhG886ogIjQNM9eYzp/BElb1ujx+UP+nHSBbfvHLl8ioaBExZNzJnihs2cRJgp2q3YEz4KcT9Y200hWB3dCJLC+e/faqjM5zkHCckAqRyW2vVZlJvXGdNdmW+mqCsA6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3qjROJL; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3657d1d4516so13604835ab.2;
        Mon, 26 Feb 2024 19:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005560; x=1709610360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFyPT0505OQhdGJk2meFYZ2auxbPN2hQffBG52zYkHM=;
        b=m3qjROJL1UeVnRzCK4GcEBi1aS5HZtoSFxC+RQs4hXGPKz8uZkNBfW0HLno8nHNv+q
         v8a+oek01gYo2enZpWA9FV0gFymynse/WEabTVupS9tCPx1s5PY3I2o73sUjs3Y96LKW
         zTOx8/Pidnbr+bhypO8eHDzbxvq8VU3Gdjw2YEv3h2HeFWm1wEEMFVWetXBy50pVMGW9
         AlVR7pFmT3TMnjk8S0H7Jr0W2B1mAjzFn+zWu7Q8gwXL1NONVQ//PCRoukRjniHsX597
         ANRxmr+Joo9LWBmV1FXO6L5oEfwXAcKVFk1l2bLLRiLu71zTQ3FbVKMndmSUQc4m5hIT
         kWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005560; x=1709610360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFyPT0505OQhdGJk2meFYZ2auxbPN2hQffBG52zYkHM=;
        b=vgHYpuck+Mldyld0P3cYGDHCCp9b+nJifkMhhwdGFqVQBP6VNkocacYp0UZesdWsAK
         5pcULsb4Afsx2/wu0Z73v/Egd//yZF51cUfZnNqiYYNjIe9sLcnmmlLx/2R/XPE2c+an
         5d9YhSNKkigk1JuwGeiZngju+UuU8LSN7KIrnwqDLFYKJFq/5GQImOWolKIgGrd2RdUP
         YRY5CrGSG94ta5Nt/AIzqrP78yVdYiCtKpIAOWxRCxqMp9ErSjfHTvOP8xjlJTauJotZ
         RIYYIbC4jrnOcYen49aSv9TQyoLHGmI4y7XqSdUn0qM6DE/X9Vy3TjgmVr40C4nVirnU
         /New==
X-Forwarded-Encrypted: i=1; AJvYcCUPycAypPwjldodCuk70E7wkCXtx3FN7Qv0B6b1jp9vGIT47kiPL2iah1j8aQ3a0U03YTVmHpyIwwxXtjwi7n9C3+HRy+6IMXJhH9zHmm9rVNWIOiQNY6nrYO1cBNZATqc3u0WTDJP+9t6YX5PYoZMos7jbxaItzVsVbI/xHJaMeowy7lsY9q/9Yfin
X-Gm-Message-State: AOJu0YxIS+24JA2T0TJREAQoCsGE/sRpVovsDDSy5/9tUmc/iJ6OG9Eb
	CHNZZRmD4xYDglmYOobSO6Oe42veQHUL2b7iGvlLHXY+6fLsjBO1
X-Google-Smtp-Source: AGHT+IF/j0iIPL7V2P2BUiJXLUpppCmaVzcpbY0QBgp5dSUNNZbLSyTfL1NORWHj1+f4qH0v24U45g==
X-Received: by 2002:a92:dc86:0:b0:365:13af:84ba with SMTP id c6-20020a92dc86000000b0036513af84bamr9402827iln.5.1709005560378;
        Mon, 26 Feb 2024 19:46:00 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:1712:c48b:aaa0:cd8b])
        by smtp.gmail.com with ESMTPSA id w4-20020a92ad04000000b00362b4d251a5sm1891566ilh.25.2024.02.26.19.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:46:00 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: renesas: r8a774a1: Enable GPU
Date: Mon, 26 Feb 2024 21:45:32 -0600
Message-ID: <20240227034539.193573-3-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227034539.193573-1-aford173@gmail.com>
References: <20240227034539.193573-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU on the RZ/G2M is a Rogue GX6250 which uses firmware
rogue_4.45.2.58_v1.fw available from Imagination.

When enumerated, it appears as:
  powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.fw
  powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index a8a44fe5e83b..8923d9624b39 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -2352,6 +2352,16 @@ gic: interrupt-controller@f1010000 {
 			resets = <&cpg 408>;
 		};
 
+		gpu: gpu@fd000000 {
+			compatible = "renesas,r8a774a1-gpu", "img,img-axe";
+			reg = <0 0xfd000000 0 0x20000>;
+			clocks = <&cpg CPG_MOD 112>;
+			clock-names = "core";
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A774A1_PD_3DG_B>;
+			resets = <&cpg 112>;
+		};
+
 		pciec0: pcie@fe000000 {
 			compatible = "renesas,pcie-r8a774a1",
 				     "renesas,pcie-rcar-gen3";
-- 
2.43.0


