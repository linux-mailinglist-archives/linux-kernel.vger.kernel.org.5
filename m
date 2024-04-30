Return-Path: <linux-kernel+bounces-163636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2E8B6E05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D491C229D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33104129A7A;
	Tue, 30 Apr 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVGNn3su"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26E12882E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468633; cv=none; b=pqYTMkjLgwli7d1ylfER4JxrIck8gbOfGMfkX+FtL917j1CHfDI+TuYW4oXoYG7Hu0Cjk+VFrGxVK5xlWcTSiMms/EyTjPCnJWAthll8ZsO4l6npF0+RtmqugoCsAJCmywvFQrethrfo55EpP2aJLN8oWKW5EmVE7DHMlZ5bbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468633; c=relaxed/simple;
	bh=xSuqn+fAdV6ZfMgT5I3ml+oWj/Uip126qL5y7BtCzmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3O1QN7faur4lL7nQk0cwAWzGrUUFhUXiv9XDo2CVYYAOO/eiBvvG0brNRp5ov5/t/19dFC6r3sfJU+IKg3jux7IP4d3W77/RPKMJ9EHV6vj36IL2N7PL55qWY8EvzzsY1gJREh1y4TnjMLLw/KOz9bDPJHrXYjS7yCdvp0P0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVGNn3su; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-346359c8785so4554537f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714468630; x=1715073430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY0Co+9vIEATAbwt7lUoR8X2/jsfO0OxFg8e/tDXAxs=;
        b=bVGNn3suMWa1ytSd3KcHecL9qKZh/xJAceMIOoY/nesmU84S/VmKV8oQYXzYPORFvX
         Y7oagoCCsMuttnv0K0p6PJWGdaVO9kZJX5RLCKna1pHlo1rNbGs0CmgRo3Jrpi2Br1rn
         3wjJuOmORwptu/ZK6/cnWaHHICpdP9gKZ1c1CN1h5CGEZug6flVqE1cJTCOmDExE4q48
         USwXCwv/4AbGyAHcaEWJyJEfGpVHuNdLPFq6x0CxYy4Txl+SEVsga6oifAuzxWdiSxbC
         WsiaC2puBtq08mpihyuxDEvyw6spfU+1tSgH3dZ7Udod6GecEbVVbZz4GdNzr7JYtg+F
         X9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468630; x=1715073430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY0Co+9vIEATAbwt7lUoR8X2/jsfO0OxFg8e/tDXAxs=;
        b=VZFY7Y4usmeIvUQNF62M2eeyxSzr+tcG1YGNLQp24flOcO3VXxRDhxtOyZwyH/TZIk
         nlzrhNcOnt9iNa0vMwIvQ7zjj9T1Bnm1uNZIvCpcL9dBh4FuJTyUNCNe7HAcIdmQtaIw
         9s1Bny277HmQ6gcyM3BIWPM27uT70z0R2J3vuMJGhDhDmE4/6jrFM0ObUAucOX9jLJ9d
         shdS8ngWIixHChjRu/KUAqNAG/zvhFPNwDCSG0UDVuVtI5BA0MRqwAMuv8RX96aJGQ0c
         /ik6ff8r7wfHGKgVH6BoV/4SKm5fuFbZf0kPSHvla2BrrfmBTVc+HH1RKj8rhLWjlBH7
         QdoA==
X-Gm-Message-State: AOJu0YwPueLO+yiZ8EyOq+orQ+MKvYaht/9dhphhoh/z8DH+k4uZ+a9y
	2gyrTdkfV+jNikdUsKSIq6pgptVrxrCxTpgI/2VTr6UIeqm0miMgSBZd84UFCl0=
X-Google-Smtp-Source: AGHT+IE2KqW4S2n0zJPxSxytdSJ6xpYs73ekx06LtJCbvR3P+V0z3sLdHifOlDX3VavyMb/BzLkc6A==
X-Received: by 2002:a5d:64c7:0:b0:34d:6ca4:abf9 with SMTP id f7-20020a5d64c7000000b0034d6ca4abf9mr1610520wri.51.1714468630482;
        Tue, 30 Apr 2024 02:17:10 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0034d8b0b5329sm935513wrp.87.2024.04.30.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:17:09 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 3/3] slimbus: qcom-ctrl: fix module autoloading
Date: Tue, 30 Apr 2024 10:16:57 +0100
Message-Id: <20240430091657.35428-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430091657.35428-1-srinivas.kandagatla@linaro.org>
References: <20240430091657.35428-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=rG20qCv5FBNA7GgvWtsI9lSWTsdEuNYA3h/4sPzdDys=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLcFGVsIUw7kTQm0StdqyL/DNqMufxbkLPrZy 5JzCpuJed2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjC3BQAKCRB6of1ZxzRV NwjCB/9FdGhVY5xT29wjinfui8NOT+qRgtgzb5wQ8PCWET38B2iH2X73igAHaFVLhd/N3tyIxtO Bn62ljIdFPUmeu7A3Gdy3cDFrxuQtYBkzMe4Xmp5egvyXGYNNZXSNACMSlwSQ9XHz/aoy8iBgNk Om30a/8+bocnzIAiBGb6wnBTC+Biq8v6VPkuKjiNIIhUennkwJYumjVecE3Rs7v/Rv13raQ0tZV w8G+txcWvM5son+14cC+xXV6syHdPkT5HId1AtTjhedjwciUMPbIQRvseN65rWnce9cPEyfgFIQ IYPbVEi1/EUeUI4g3Ra/iUDwBFBdBnBxWEvrraWZnWVSYTF3
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


