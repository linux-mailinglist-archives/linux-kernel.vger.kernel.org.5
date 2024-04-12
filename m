Return-Path: <linux-kernel+bounces-143076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C831F8A33C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E4D281735
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87291494C7;
	Fri, 12 Apr 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgEaykqD"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96A1474D2;
	Fri, 12 Apr 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939117; cv=none; b=NV48gfQe0WWJwp+jrksRw8PfQljsUfTAddiRs62CRagWpny5qDb2rTpJ4tRvqnHqgGLkAWtfH65s6YpyG1qzXylssy+LsNphMMJ63T9zjiaKZdd0Fd++fADdpfzfotpS3TdH3P2Ydaw4/5mLYcr400qCSwv4f7qQTZGZa92+qJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939117; c=relaxed/simple;
	bh=IOBMceW+zAzriiimOV4JYDNFwggkdO0bj8MIHegPP4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juABtv1dWE6P8eCtsu/AfmF7U9z3J7a8vf6dxUAW+Jyueu+RwrmgONNYJl0rhPZoNX6cWV60zzVwV/jX9TQKuN+UecEfFdW2sDuxPgV3X3EkaReCj7F6Y4PL/x21wWVf4jhca2WhWqFqpH1NdzdC1IEi1OYdbZl5wxo5JvbRXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgEaykqD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518872fcb89so836965e87.3;
        Fri, 12 Apr 2024 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712939113; x=1713543913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caQTinMj4HV+puo76LX890/vq6ddN+KcGH/X/bwBRlw=;
        b=TgEaykqD9of5s+HZgpZ+sOQOKxFbjki9tZO8R5x26rW2YOB3sY6W0ZgCI1Rwzt4gji
         NsKcxbOg2DyPkIny8FPWRr3WA5GYaASP9TVHZMDPr6GxWlmIBmwc3JDH/cX6zi0gMPYU
         8By+I7CEbArQmGoDWwlIIGCRaG5nzWab6413+DOKDy5AfoFY5n4ri7XU83npFo9/2K0e
         wHU3TZL8mSo1IL17DEqjJCXRGo36jFhMtyBYeRFpPnu45t8MOT9SlZMnq2SoCMXJCgHZ
         N2SxZgC6cMxz0x5PI86E0eFaTxc38A8Gp4abLHB5452NeeWDJLKvaKZDuvy9JgY/BKoT
         Iwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712939113; x=1713543913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caQTinMj4HV+puo76LX890/vq6ddN+KcGH/X/bwBRlw=;
        b=euLlGO2j50n4eXBoQma6wkDkrL3wIMQtMaH4wP2s942mM4irKDUwV9uAdBSqIPF5do
         ilRzsWKIM3egxwxXyMTsVIxsm3s2pyElqEU/GmK+nlqHD4IS+7L+8xreU+QQyFdFkH81
         Os1aCkTX49h/oI9XifoYeM7/E5SGxI0r9yzA0Qmk5DRSBtkuOQHe3hAOgTwZwMak7YQe
         Cs0RUCy9ZR8iftsICBlCUT51e+06ku2PEIANctTbBUav73V6775aiPrRW6wPrDEfiqqN
         MvdbvozX+H0dKx6c05S+krKxDA7KGAY7sbJvX0yCt3QALRJY5eMXm7eV2VB5bA6gAaE2
         uGZg==
X-Forwarded-Encrypted: i=1; AJvYcCWHkysRmQbT/Upq88ClgTZ6o3QsieeNhqepsaA06upVY0lH3BkjjI+iMGTD5SmcucTxbCRcXL0GlE6OV5h+0rKlbbCBwArcRPers9hBvxduk5Mhx3QodCoe/JOLqLcvy6C3MeTaIPrEDhCn7oRNy+rLRzopjzKMhWa91iJKzdYO+N/U5tn0ONDlIm85qxEf7RMqSoF7ABxTdjxMLehtlSaz
X-Gm-Message-State: AOJu0Yw25hbt3AGkZcaAsx5i/vuh6rALaMZEgjUtbtxZPOso7WPLpCYu
	eN0Slqw8vzzean8KPWWMxKW8XDO+EvyalpbCWnciw1XtQWQRuoJC
X-Google-Smtp-Source: AGHT+IFSMXcf/XnY1RW70gVLOV7EXutIJ9X7L4Sz2vOg6Nlj4vKSBVkxS1dxMXOgsnqrl1AAn7dn/w==
X-Received: by 2002:a05:6512:499:b0:517:855e:2e3e with SMTP id v25-20020a056512049900b00517855e2e3emr2064344lfq.6.1712939113253;
        Fri, 12 Apr 2024 09:25:13 -0700 (PDT)
Received: from fedora.. (d-zg2-064.globalnet.hr. [213.149.37.64])
        by smtp.googlemail.com with ESMTPSA id q4-20020adff504000000b0034635bd6ba5sm4576554wro.92.2024.04.12.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:25:12 -0700 (PDT)
From: Robert Marko <robimarko@gmail.com>
To: kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] dt-bindings: net: wireless: ath11k: add ieee80211-freq-limit property
Date: Fri, 12 Apr 2024 18:24:08 +0200
Message-ID: <20240412162510.29483-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an existing optional property that ieee80211.yaml/cfg80211
provides. It's useful to further restrict supported frequencies
for a specified device through device-tree.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 672282cdfc2f..907bbb646614 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -55,6 +55,8 @@ properties:
       phandle to a node describing reserved memory (System RAM memory)
       used by ath11k firmware (see bindings/reserved-memory/reserved-memory.txt)
 
+  ieee80211-freq-limit: true
+
   iommus:
     minItems: 1
     maxItems: 2
@@ -88,6 +90,7 @@ required:
 additionalProperties: false
 
 allOf:
+  - $ref: ieee80211.yaml#
   - if:
       properties:
         compatible:
-- 
2.44.0


