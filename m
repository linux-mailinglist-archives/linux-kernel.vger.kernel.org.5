Return-Path: <linux-kernel+bounces-155843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3F8AF7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0876B1F23DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A957142E96;
	Tue, 23 Apr 2024 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKZsi91W"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B6142658
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903590; cv=none; b=UBRxQDEed4m7274JgkliQAGX5bzRACYM5CwLHym7nY1t44F1NO24tkW4fsNcvj8erUny8no5MjZd2VTkC7aLIIt6i4Bm8TVa3KMAbvQls6gOV3rZ7dJbzX2Ch/W1M0jmaHLFXOuFxnEpsl21gneQrRrPogiYDLDSwOG1DSat3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903590; c=relaxed/simple;
	bh=O9JbCQMTsEdc3RpE8YdCk//UJvo94xhIq8ZtAtz4OjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KysDJJZ5h+xe1UvYzfvgIfa6BLdrob3ne0STu1R+gkwBqg6BNdb0t5MELTWM0JJ+2E/XFGgfsP+D54D+5oYd8xemV5RqjdNjms6EEQZ0RVM+I3YToZ6Jl2jxc0Ol8UnrFX7dnTDcUGw0woY+ryQFkNz4HvZmqfoukR0J+DW53wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pKZsi91W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a5b68eceeso19776855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713903587; x=1714508387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4vOKvRCallk5kGR2Wbh/Tn3Hl0el0YNKiGA9haFVMA=;
        b=pKZsi91WahOATcShIiLRcHGwCci1BbOrkGYAufPHUTR7oNzmUOFKcKticDQ+nh4fds
         h+6G0FcdyFAeBWUQXhkx6+U4B5sEV2JueVpkTHtDYpFDmkTepdmAVglEShWb5K2Q/wFc
         VNwmwXHoy+/wXZ1ezD4Myq/sdo6TUaQGpo46JKoLqo+CSxZHRiMYEIGZp5Mevtgw1CH1
         DOa4QP1rzoODvjg8O0o0nxEDuLROF6hh1GIXoO4IZrrgreN9e7KD1TkTfc4m45FHEZuP
         rb5l7ZpG59kuEwLh5ngUjLpgaCKfhEyAzML1pqa30JQ7aCqdryLFmQHDNu7OrSDKGW4H
         j0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903587; x=1714508387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4vOKvRCallk5kGR2Wbh/Tn3Hl0el0YNKiGA9haFVMA=;
        b=sPwzbj6clHcG36MmvKv4VfG5GY/zUVtW413SQGc41rqJTqjRKE9Xufii2xrwbGkMUK
         fffpeyJYsyxwtF2hhxef/TIVDcgr9F2Dwh6lUJPhl4mzaZKKwIr+SFsBKQ6IBV9pVlu9
         mpmRTI9Z4VZbhO+jpouTRWyB6WHynizKVfTd5YLHdnoZHjXNZ5eZGjzGKYYA6BhH8xrg
         KDbjlzPA1OiHbhc9b68qP4L8ORAUC2PJxik76L8MxQpvsvHvbm0T8r7psIF0nXMGv/Ho
         ytLjvqd+TRthf3+Wh0Qf8zlsv0B1rkC/MEc8YA6EDUnnUBQm35Lgis9u2PPAGM9CwpfG
         bGoA==
X-Forwarded-Encrypted: i=1; AJvYcCWEHIpQwyesptezo668scL5n5EMIl3tR2SSSBkyp2W/IN9NGFSw9UTT/ull2hIzy1DGEb9ChoRamHCehf4dR6cZ1Xpy8XRej9+wXZyi
X-Gm-Message-State: AOJu0YxCy0q5ydT1NBQiJHd1VILUGY52pY0t2OuEqpiN0m6F6k04BL83
	BFlnldzPIJ1vl7onme3SX/WtvHxUYRU/TrWX2Q5R1iIN8QDGmN+JlnvHgxbOt8g=
X-Google-Smtp-Source: AGHT+IFY+ITgeee3a+C5KSYNk4HM3XF4Psq3axU8IwvLxAQYs6W6bvgmAlGVlqcAphnYYBlae8wbfQ==
X-Received: by 2002:adf:cc85:0:b0:34a:75f1:c36c with SMTP id p5-20020adfcc85000000b0034a75f1c36cmr179194wrj.61.1713903587154;
        Tue, 23 Apr 2024 13:19:47 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709061e4700b00a52244ab819sm7552431ejj.170.2024.04.23.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:19:46 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 21:19:46 +0100
Subject: [PATCH 2/2] usb: dwc3: exynos: add support for Google Tensor gs101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-usb-dwc3-gs101-v1-2-2f331f88203f@linaro.org>
References: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org>
In-Reply-To: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

The Exynos-based Google Tensor gs101 SoC has a DWC3 compatible USB
controller and can reuse the existing Exynos glue. Add the
google,gs101-dwusb3 compatible and associated driver data. Four clocks
are required for USB for this SoC:
    * bus clock
    * suspend clock
    * Link interface AXI clock
    * Link interface APB clock

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/dwc3/dwc3-exynos.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 3427522a7c6a..9a6e988d165a 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -169,6 +169,12 @@ static const struct dwc3_exynos_driverdata exynos850_drvdata = {
 	.suspend_clk_idx = -1,
 };
 
+static const struct dwc3_exynos_driverdata gs101_drvdata = {
+	.clk_names = { "bus_early", "susp_clk", "link_aclk", "link_pclk" },
+	.num_clks = 4,
+	.suspend_clk_idx = 1,
+};
+
 static const struct of_device_id exynos_dwc3_match[] = {
 	{
 		.compatible = "samsung,exynos5250-dwusb3",
@@ -182,6 +188,9 @@ static const struct of_device_id exynos_dwc3_match[] = {
 	}, {
 		.compatible = "samsung,exynos850-dwusb3",
 		.data = &exynos850_drvdata,
+	}, {
+		.compatible = "google,gs101-dwusb3",
+		.data = &gs101_drvdata,
 	}, {
 	}
 };

-- 
2.44.0.769.g3c40516874-goog


