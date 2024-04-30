Return-Path: <linux-kernel+bounces-163591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7B8B6D66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E72C1C21E10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CD1A0B1D;
	Tue, 30 Apr 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj5PgLDk"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99B1A0AE3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467020; cv=none; b=o07waup+BZXySZHHIowIFuTn3KJ+rHgvc+Ekjp3+18pIcjjVWrrnS+bSBBubHqtOhIKoBSluAqH3OSrLrYwd3exq0BJ54R52YAwBtfv/u2offwvxndaNgOwX30n53yn/a5wjO5ftkaP1rsygK1/ZHiRekxoSSUAblFxSlqUz32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467020; c=relaxed/simple;
	bh=xSuqn+fAdV6ZfMgT5I3ml+oWj/Uip126qL5y7BtCzmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P16hF/0ypEha2KDFc0sZxcpsV0RPPzkKZyjBbVpk8kYpHrYmygpsH+XB5OobxNudC/3/hkua2DVTiyUHJGKWy2dXtoobb79Y0xw/5w+0TKDhPyhU0ImdHgW7Wuv8Q2oE5w6hln4zf6DCD3jOG618CKcfYZunAanr6/XXzgSgAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mj5PgLDk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so36540475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714467017; x=1715071817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY0Co+9vIEATAbwt7lUoR8X2/jsfO0OxFg8e/tDXAxs=;
        b=Mj5PgLDkn8osWr1x2iDaRgIm1SUgTG1fcL+iM9cSCOf9aTUB7FCZehqFyeWqhj5EYZ
         RL1RA+B/FylFvkJQLQZbvYTJEQSTSKm9yWqzC8qQrMPv6RSFY8L4XnzjYpdadWftHVED
         0GgSewqt7jv3K7VTSAY/IVlqtWfeHfycL7PZLMC/uvlZHc2A7zR8O4PADVsD4T9z1fr/
         AWox4x/51xmFIZZ2QpzPggk2y7eLyHHZcyJlUszGi6aT7+DeCCF7DpjNVsURDaH/7Ltb
         PqKtGEiaCfoW7wLVO1HZyKM7C1naXbVfJMaoGOEQMDzY8lzVJEQkrUAUw6SDL5ZzHlX0
         5blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467017; x=1715071817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY0Co+9vIEATAbwt7lUoR8X2/jsfO0OxFg8e/tDXAxs=;
        b=XUkEcyHU4ZpT615f4VVvXxgXRBZzr5qlAB6CiFvKAAJL0D5SKBZcCUX834q3INi6CT
         QY5ffhwmunIs3O/nFus/Tvtbb8uSsByfV77v72ERIVH1OSYgPgG0Dbo9G0QmWeCF3K8Z
         SZBMvanXYsoh5pTwQr66IBSRgFnNck0BI8VLjmYJsIAOc8fADQtaQwiPOd7dzPQNLD/0
         4AQ7xBT2SdP6PIRDssS65OEwb0jO8iXiuaIAYQYFVSD+HDHx5xcDMbil5uaCFFpkmNbl
         4J56I8MNot+fgQ7Dqbnhotc7/hpPgyGxHQf2dDBdEYMB2DEE3KY7o676TO6bPV6+J2pc
         FMJg==
X-Gm-Message-State: AOJu0Yzy0VaA1eS04S2iLN+sH1ZvFkEa/Mhyow+XUN8EJdiogDF5WcGw
	lyvewePXumaM8ZzWCCNwIOaTtn8LoTWI+l4PcwH5/RWcRHiWLSDB5yyjbzQ1zzk=
X-Google-Smtp-Source: AGHT+IGKbGw07S8JaIkgh3KpzXnLH3iJWm2R30gQelbBwPaRgdvxyr5hacnP2l6kyNW17TKlw8V5rA==
X-Received: by 2002:a05:600c:4fc3:b0:418:3ea8:46c0 with SMTP id o3-20020a05600c4fc300b004183ea846c0mr1760114wmq.13.1714467017040;
        Tue, 30 Apr 2024 01:50:17 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c1d9200b0041bab13cd60sm14590670wms.3.2024.04.30.01.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:50:15 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: qcom-ctrl: fix module autoloading
Date: Tue, 30 Apr 2024 09:50:07 +0100
Message-Id: <20240430085007.33607-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
References: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=rG20qCv5FBNA7GgvWtsI9lSWTsdEuNYA3h/4sPzdDys=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLC8GVsIUw7kTQm0StdqyL/DNqMufxbkLPrZy 5JzCpuJed2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwvAAKCRB6of1ZxzRV NwYhB/907Guw0Fn6cOkc0FVEtR6XSRM6D+PdGe4SRP2VXh45aEHaSqxQyo9QkPEakn3IySDLr7e UYd1o3D3FIxaO28YVPs8muZ8bBbiMecMSx7pAEI2CQiAxNQVUNEsxf7gHUfW/GXnjamNySrm9+Q DWDaLHd22+igjvzJcXlMQThQCAW08kIJEzLiC9l7/hDQoc7/mhTHkdpGuCqIK42YmbEf6Bk6VCn DLMSrlDLGmPlRFAzWOLBXJ+0DjZi3F+wbuaMrZXKc5bmCfSwKEc6KseaQanrYxigw5WnGtH7cWC sk5XmyfihhLEYry5tgqlrL3Eb3cxy142bN5SCTVRwRA0DWjX
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.  Pin controllers are
considered core components, so usually they are built-in, however these

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 7d632fad1300..0274bc285b60 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -717,6 +717,7 @@ static const struct of_device_id qcom_slim_dt_match[] = {
 	{ .compatible = "qcom,slim", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, qcom_slim_dt_match);
 
 static struct platform_driver qcom_slim_driver = {
 	.probe = qcom_slim_probe,
-- 
2.25.1


