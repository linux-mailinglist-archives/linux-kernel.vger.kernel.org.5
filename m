Return-Path: <linux-kernel+bounces-137012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F289DB19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F151C211DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5613A87A;
	Tue,  9 Apr 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MJFhNu3G"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88434132809
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670160; cv=none; b=OZjJAtZfZQacymaekiN0/v6Xq0m+TVPNeqQ5fxsvOG4lJkOmA6FSnjxYeAcL6On9t5/rLIvV+hzOY74ZTWX0qnXDIcVd2SONU4PKFt96MSei+eu3GtMdlpkD331SXsfUKuqZ/jlfQ9+VC3ehBYxZCp3Xp230xHknW8Z0KNsJ8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670160; c=relaxed/simple;
	bh=xiXcG5GEfrvSIF0BlBGjwdfWPuvXXb+gIEE1G1bDPqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPrz0GyBQB9BT5FtNcmh4/eW+jD05lw3gf+JGHQ6r93EG3/RYWaKq1OogngPdh5kOevhJqQb3yFiSB8ONxM6IlXH6Ehg3piRsAmbzwcweumlTYfgF7Rfg9b33rIEG7COgb7LTpByaEfFCMuc/1/i52d059q78E6WcY6o+dLIvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MJFhNu3G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343f8fc5c69so2331870f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712670156; x=1713274956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFrY1D6xCh71cm7XNWVZx8QqBmaav+xzWA830Kc6M7k=;
        b=MJFhNu3GnJtBKaAFSQQ8DWu/oG5SoNbHdukgSJLl7rqBOSCJB0OW+PBywkzhqn9eaW
         IVlmpgu6hInU0Wjh/OCDP9HX12eG3sXmiC9TBJ5KBgaVmo0DhMI9Ri1ZwvWdaMHNZLLp
         WRE2dL5oWC/3w1eNPDNZMYOAr0mUGYw9WxYwB+IujHSn3rf5CFCspktRGe5MmObIjgiv
         U015dixcp5fuO7z15EOHuVxF+DCzh+G7NJXZhDKf6kzUZ3yhviHLywNTTCI6dl+HBmi/
         w9vWu7wZfFrNdDzuvr/Zk4eq1v9DcgUhRnu3IsDLgTNJIihO7IJX0m5778IMaMig/c63
         7EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670156; x=1713274956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFrY1D6xCh71cm7XNWVZx8QqBmaav+xzWA830Kc6M7k=;
        b=ojsXL0GQJUMS2drIMvNAwZh0P/WXtyJ4DHPp5mIQFyMLDJMQNoTPEN7w5yjJTv4cpu
         z3kqGn6FT9FE96sDBZUOMWsbMZ0o1aCRxmjBvqbF2ynimsV3sdtVm3LYBhWb7P2lp/bz
         cKeENm060y/bgLWY6R6WPVTvMf1GLKlJ6hM83gyykrHdfF57ZNSqVmqaLRJtgbkpOn7C
         KEbfUHlqk3FFoUMUOl/0ZqqZDz890W6rB4qc4zvJdLVq3lLUCq3aJc/QDGX4Y9+aXcne
         VB3DI4rm7c5r6KsFHXX1W8NlI6Ik1GmUyYqX6GAO0kWUXWMZ3MGx9grhOczlMGf8t5uV
         QrlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPEJJhGOruckFbOPDm1u7NH919jbxWbykb+i9Hrh2jHjgKd8h2QiBzwXoWH1lPSnB8p1FtUWTi4ADpGX2CuAnmADriPNaut5ynX1PO
X-Gm-Message-State: AOJu0Yx9RaHXS6xgqljHTwPFU/3Xco6xYUpNhDKgRX9BKB6O+tJSJWjH
	KxYaw2G1h9KMkyBln1WFbYlZ3wFAWzsZb60mTkzDUgGvR0u6R8rmLabpcfvSiNI=
X-Google-Smtp-Source: AGHT+IHj2KGRa8/FHqb3X3d1flud0m14cnSJPVGjumh3UATf9uWX2V64Sp05U15umnBOnk/RK7GA+g==
X-Received: by 2002:a5d:428f:0:b0:343:c35d:1403 with SMTP id k15-20020a5d428f000000b00343c35d1403mr8127793wrq.15.1712670156127;
        Tue, 09 Apr 2024 06:42:36 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j11-20020adff54b000000b003433bf6651dsm10753579wrp.75.2024.04.09.06.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:42:35 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 15:42:13 +0200
Subject: [PATCH v3 15/18] arm64: defconfig: enable mt8365 sound
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v3-15-16bb2c974c55@baylibre.com>
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
In-Reply-To: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=777; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=xiXcG5GEfrvSIF0BlBGjwdfWPuvXXb+gIEE1G1bDPqE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFUWs3Zqql51wyaQYaVEla9pO166FW8c4GSi1EXZw
 HVQdi/2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhVFrAAKCRArRkmdfjHURaRqD/
 9BMo7u8uBfMhLvLsRFqPFrsi1oGghMUEtZsUmvmC1j/VPhAxVlNDWN0SFRvXGuDe0HKWwS3Nuy2rzI
 VTdiTFiqV+ns4FhEejQwAXDcP8bHeD+IRiy0LoLTITiKplgFD1lpSEuOGp8KNAAz6kPYoxYJsQ812h
 An/T2WPsET3il5n3b3/sZydmc7aXyPAfM0UtIkCPD8ENumQ7sMdmj4HN7ntPLPPUO20Pb3oDXhLWr5
 qgUaYp0VRGjHiEVlFgDDehdElEa99iTY9Q6Euh1VP8+SuL10g8rTJUThQfRDpgMLXjcBWnwnJQg5Fq
 40xK3XxzQ/25AXW5uVPbGALHK1alsyOyHo1k/Oy336TUmF7sl1K9HV23kIGKFFiDB6GvBRCSopFf9C
 oOwsX55g3gNVK8PoShntQwhVNqvuE8TCHWJfbrGdEm9mPg3sUII/kom/OiPii3ZRSMhd60D+U6IJxL
 +HNv4F9oMTQWUMmSqVB+RQ/Z92SkVUrN36O5wvyeuR0EZAD/srdjqggcQwXtX2fHodMBlBvvRWvAa5
 ODlyeQ+TPUtrPxnrog16ZpRngInwRIHa+LW3p6KT9capUp8LKc6rcW60TCYxWo3KIr+d4KnHcNdN/V
 E/KqthEezr+ZpkzPOzSQ0n+QORuRsSBCLMDBjYygTWHtbfWsvDKcOKmb/HGA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable the MediaTek MT8365-EVK sound support.

The audio feature is handled by the MT8365 SoC and
the MT6357 PMIC codec audio.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..40e88cdafa3a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -939,6 +939,8 @@ CONFIG_SND_SOC_MT8192=m
 CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
 CONFIG_SND_SOC_MT8195=m
 CONFIG_SND_SOC_MT8195_MT6359=m
+CONFIG_SND_SOC_MT8365=m
+CONFIG_SND_SOC_MT8365_MT6357=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m

-- 
2.25.1


