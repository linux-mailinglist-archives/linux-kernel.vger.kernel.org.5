Return-Path: <linux-kernel+bounces-91634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2BE871476
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF782283FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDECD3B193;
	Tue,  5 Mar 2024 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RetoxQ3P"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6E29CF3;
	Tue,  5 Mar 2024 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709611101; cv=none; b=trEPgd9+Im1QcGc4bdXjyGXfh7MRrrcvAyGrk4GGQ1mHI/Dl6AaDn54KPfmw0ZV3/SK1CXV0lfQId4rVGH2VdGZjUqKCKUUQW/wSKPiosIpVoKvm6VOVQ9gVhUdb5A9B48SJOa7wJVPiqfaNUIOU5PNhMXxk5YOekFAkXckZrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709611101; c=relaxed/simple;
	bh=/ewHYUJ3YLGaIZEIYqXd2+CArmnmPZOCHS4dCKsHWxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBMRxa/2nn8xAEJn+XI8NGshEdyEleA9/nOBx9Q6uUFpfFCar79dWE7qifKJd/+UK1jxLd9uBpt2dhpqx0W5eDCTBaILmD6erMb9lRwfjluOXH/B0eTqaPOpy3XY4GOOrn33NOqip3hoCoiAgRCaB9W8hJxx2FFXY/drhD1SnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RetoxQ3P; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8060a8489so230155339f.0;
        Mon, 04 Mar 2024 19:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709611098; x=1710215898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvpUYcfwUzbBslhqAs1XVtkNLO8M/CQ6n2J0d2KVjvM=;
        b=RetoxQ3PibEwyar/La/QnApCxczHP4MD1wgnZoaiIjyG4eLZDdx3tRHLQ0bUMvXfi1
         EUQquD4VGH3rBiafaTLGADej27GJpatDtYm2EPnNkTZYuhJtgZqLt5gkqm60bqeNhJks
         rzM6ZjHp/iU3RfJgmZgbPGeGzCgUoEE16aqTXlDMbi8aj9lnEj5Ogjx/c+fDCwA2ELOs
         jhdyxEdEUlX+z/QfOSLH4ubaomhalwMuIOGJBek7NkIKaYBtJIU33SWBPz9W9gM3whwO
         Unp9ouzgglvjfzq5na+Xn9x+miVMgYds/haRH7X9+G9sRSbL9c5qyv8w7fBNXNMrOrP7
         EofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709611098; x=1710215898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvpUYcfwUzbBslhqAs1XVtkNLO8M/CQ6n2J0d2KVjvM=;
        b=ezyJuagE984mpNcXA6Y3eDFnyg8qWT/xTIaQCVDY6rIYeS5ogmVYDzvx9vy2qTIE8h
         G4CT7uIhEgnPk0SIjnVI+Nk4aMEDk8P4jBDPEm6ijCMQwtSNcsRyfWgXay4YCfF7hWHy
         MgiX/x5Y7xsHpc3MgXRg/87y+kJSN3ZrgEqBWZxBsRZJ/5YH0lNCgtQNAKVzpugxQBGu
         wUNNeM0oflBF8l4beEgM8k4AB7nLb6RHERFea3r3My+ZLGoqNxeRJpXzoXbdE6x2gYZI
         z5LM22xjMhLidfPCyYSUQVGSCKRXPel3/QbqGhEkFxGMHmEwwZevTvJv+FdDySgKinhs
         4NKg==
X-Forwarded-Encrypted: i=1; AJvYcCUH9PPZecHlMc44qYZLxQOTS9ApQCvvQLbyTPUbKa4OMOIu3Yvvi/gX/dgSXfofoaTX52FIWGpMMKrF0WebA2CwOC+FNjifDRUUpcT3
X-Gm-Message-State: AOJu0YyQpooZmPha4UT/+H+HBhaFHyZdgWDczN7hU/F6Eorwz65WDdm+
	uS6UltqOxghMH3EFQ/kR29BQujUxEv7IkZr9FnUFaMcCVCnf/Awgfre8yrtWFLy9wg==
X-Google-Smtp-Source: AGHT+IEJKLF/uQABIS0lxPXhnRg7SYmxuoAzCktXTURapooOv57T1rsw6Y9kbqx9mjd8ZoE5enI2cA==
X-Received: by 2002:a05:6602:97:b0:7c8:30cb:10a4 with SMTP id h23-20020a056602009700b007c830cb10a4mr8789320iob.1.1709611098549;
        Mon, 04 Mar 2024 19:58:18 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:5872:22b6:b680:a683])
        by smtp.gmail.com with ESMTPSA id g10-20020a056638060a00b004748293c1fasm2639496jar.70.2024.03.04.19.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 19:58:18 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: devicetree@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: fsl,irqsteer: Allow Power Domains
Date: Mon,  4 Mar 2024 21:58:13 -0600
Message-ID: <20240305035814.74087-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8MP HDMI irqsteer depends on the HDMI power domain, so add
power-domains to the list of items which may be in the device tree.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 20ad4ad82ad6..7ccbb96434a4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -59,6 +59,9 @@ properties:
       u32 value representing the number of input interrupts of this channel,
       should be multiple of 32 input interrupts and up to 512 interrupts.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.43.0


