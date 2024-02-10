Return-Path: <linux-kernel+bounces-60541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81345850655
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B31F21CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF1604AD;
	Sat, 10 Feb 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH0c9Wgt"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3906026A;
	Sat, 10 Feb 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597994; cv=none; b=gzRuAqR0lGp3me1ckS2cyWD1OVD1+1vU6DbY1U9wPogGWX3yc9LxkaAlRSsmwepmd4neeHzq/ZSvs4JE1i4Uia0LI6VdhIf7mgM6Mx7eFSyyWJBKA4JjM+SLI8Ccj13/2PhOaD1Z7MLYL0ZO3Mpgh+rY7QwY0xXUiuvqDWIafhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597994; c=relaxed/simple;
	bh=UaVR5OZa0WGcg5GCJwsdYxJmw+RtjRhaAWwaN3+ScVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVphkeBrRHHExSK2SPWZhje1qHuQeaBPu9xigGADnSOJlENQoObY9HiqirdCw4iLf63ugx2O4E03mkkeCudOAOqRt0JN3U8xnjGo4hNXRR0+8wdTPtRQEty7GrblsvPRNpTtcIP/nEByy7kJ0n36ep7pIHSdtLEe5CRGuqjvnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH0c9Wgt; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1931455276.2;
        Sat, 10 Feb 2024 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597991; x=1708202791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMNqmGpCpYRyGD3lm2gu6alF/32hYvXVEyCc/US0g+U=;
        b=MH0c9WgtSRNr6gYwdO5xklHndJk+iNqm1zc0h7tmEsCbBRYw1JMZ/fWstITdUzXcoz
         Au7x6TjMIO44mGIB6SZ8sswTmbSDmhkaAnFvuT3VbJE0OUlslmg+WH7Jzh/+Ugr/Fs/5
         d6Th9x03MFfmCN8eozkSksCRI4WY7HuOGYsrmUVhEoq3ELuPu6eMPX2XkFtDHqopRg+z
         1Ikk9Hj29S+uUt2gYxfqHsPsxgcEv/W2RZMLkwxahm6IBXGFJn0U2Wuq7HwwnD+jZQ6c
         Pp27214BGdyjguz8Ccqjs/FD5AmYd6ZUAj5iAaCzbS8habHXgEP1y1XGFtP5uQrpUxxg
         ybjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597991; x=1708202791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMNqmGpCpYRyGD3lm2gu6alF/32hYvXVEyCc/US0g+U=;
        b=PXo/Y297iUrdkEs8WYoVV2yzbDNkhANihfxkBNBrfV93bCzj7itzsC69jzyy0dNfds
         FAdqxuUbeHoYotaLDZv7OY3pWyZ1ZpPJgVp8I8qCAfHQ6+XqhasbBfFzWNTJf+CWDqZZ
         D2WW8hMGknazsdqKEEIQcjNRy+s2CXmpwpex8LBZtH7dX1cdf0dAYNiqZulB7fwKHw3t
         Nc8vo+Zoq4CZGDUPlESLtYt7NSiyBHdcIuKfuRI6LP9IBCaxUfxhucSMNNsI1ANwN1j6
         qlMR2Wc+YTC3PlXOIz7PhgxmEHrvEc95vlw6E8mLWLryz39UO4EbOYqoR6UAPl5fXU9F
         lw2Q==
X-Gm-Message-State: AOJu0YzYLXxymT+9qcF8/vtwmTaYsz9CCUSGr7zP6hhpkS3QB/zn4TF2
	QQbeaK55g3aClRRbQ7FjyvU7eitouDu3LgRNA1QOaDYYlwgbzOaJFCqzD+Aq
X-Google-Smtp-Source: AGHT+IHgx712Qt0uPzY3BKOyK91B3LD/rc1vFptzX160m43q2KsKblVYhW7VrPbTHGq3SN6LhllN8g==
X-Received: by 2002:a5b:b0f:0:b0:dc7:49da:5f4 with SMTP id z15-20020a5b0b0f000000b00dc749da05f4mr2754107ybp.11.1707597991484;
        Sat, 10 Feb 2024 12:46:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVR6ncD88zt1yVh3P2jEjcgsr1octwT0Xcboct6HI+KW6uiASuYizor/YMwjA/4YBU7J4v1FeUR88pazimK2bL68tdOTAyYfSb/ds5aUAx6J3lpvN3WYqFOzuEeXHYB/W3ViaxfIuTRqjI2uvi/EBLHTtfOj7ukXeSOYe1Nd6tfJNwG+43UDTCvXyYVRfkTq8BLyrBa4y7J7BXkjqZlYUozI8x3Pn1Fa328zhGAdvkbzCQg6n2atr4pRUM/Bo6q7Z1GvJIbLKbsZsceiuOZwRdXAeKDfpwXlKYkI9ShmjInX45mUX/lvzwd6ZLlSSKsOq4duF7Mv7R6AChrWWH4kc1+DQrVPF8XXaLdwJe5ieaBOhg8CBmluRLRab9eqRpBLPcKu2woU8laW3ZtwQ+kPiYgBjdaqeNIajdZScZFNL97YFE15YmF3+VYdJdWan39AGaKOBxKWqgT+7q/r6Hq4ul8ujbaV7NessyP64Q6NDVjKWYiQJByNU+/3U3FKwgJVt7rOsuA3JbY+VvQc3hub6I6HP2RhG3F2vkTGZmC2z0bn6UsuSW3yw2H1Nfw5hOUnNJaitQv9JhExulkZufn1RP6CfX1xcepclF61Hg4s8OU0g==
Received: from aford-System-Version.lan ([2601:447:d002:5be:27d7:3989:2897:88a7])
        by smtp.gmail.com with ESMTPSA id m20-20020a0cdb94000000b0068c9db26ae1sm2079526qvk.41.2024.02.10.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:46:30 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/6] arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
Date: Sat, 10 Feb 2024 14:46:02 -0600
Message-ID: <20240210204606.11944-7-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210204606.11944-1-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Plus has support for an HDMI transmitter.  The
video is genereated by lcdif3, routed to the hdmi parallel
video interface, then fed to a DW HDMI bridge to support
up to 4K video output.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
No change since V1
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f44b3abf3cef..03ba9e89a0a5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -886,6 +886,7 @@ CONFIG_DRM_ANALOGIX_ANX7625=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_CDNS_MHDP8546=m
+CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_IMX_DCSS=m
-- 
2.43.0


