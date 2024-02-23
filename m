Return-Path: <linux-kernel+bounces-77907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDE860C07
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15DB1F26C67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637418E2E;
	Fri, 23 Feb 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9ZZ35mZ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475710A3C;
	Fri, 23 Feb 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676306; cv=none; b=uoPqQbxjH4joDgiMaQsZuH/HEqvqW4rgykpVc5LtWz/06G9JWS/2uVvm0fkrH0mgBDR4im/iMOg4NhdQg3kvMjdF9qp+wiX1AvWoeE0YrudZyAzm4NA850odbO7UaSkDFab/6oTEeboimqkk8s0yO6zmW5sV0MBiD/TuuDWqp64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676306; c=relaxed/simple;
	bh=JD8F/BCnIHsakP2ESSyZ0gl8qdXzbKla6qIUCeEphSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uv0oUGt6uTgEZ558gMOxV5TP+FpVYRf+DmcV0nyFpN5H/pVawVeOGrmrJ3VY02edchpb2PnuZAqgGoLw3I/l+GueRVQHj9PfD+YJlv/iyU3fSgKDjGKf6csBzQANCJOW4NNIoaKRAMF+QsPl1+cUXRGGeB+2jIlrbA4qbwCzXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9ZZ35mZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564e4df00f3so586343a12.3;
        Fri, 23 Feb 2024 00:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676303; x=1709281103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5IFRZlvOaUD8dHPR2BXVjXNwx5cfEcvdEVy0N9MAVI=;
        b=j9ZZ35mZ2nvsdAqJ4jwn9AliPLtc4iuYpaFE7xhF+eUc55C1FgkaAh4R2xdiRnSD+v
         7L/KPoUdp4gVX67k16oXwbN+BejDA+xb/5NO9L/5+W1Z62KS+zz7v+rQDRfcTdLCAdyc
         t4nsFeP4JlDXQjouujZk7rFFYxJCWzZJ0HlNK4tyJPQnWdo4ypO/IuDHxFD8QqgwoflX
         8Od7R70lklL1/TMY/FJn74+cNnpPM4FLIXUO+Uq8K5HWvzCx+h4uK/Tzozir2y8y0/l3
         C7903mAmIJMnaW2bDiKwyJ0kl50WqM+Zc2ovHUdQLlgWUuVHRMpQrC2P0Qm/k5SusUFf
         hl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676303; x=1709281103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5IFRZlvOaUD8dHPR2BXVjXNwx5cfEcvdEVy0N9MAVI=;
        b=i/c0TVntdj/tKJl99mC+zNRVuMZKjqiAEsQy5Disx1XA0Dk/cFfkxeAnBBg6PkVxO3
         FcYSdygAh17i2oOdsBLskCo6PauUH7p4cA9xipSvi/BAfO2AC2EzzcwatqmL+67ZISLa
         0Gs4jgYUoqhiv63Y6cKKAQE+K0sJnop1DHQFB1k0RTdWnCQE81Fs8DDJKrfpwftE8jg+
         oLmW6oalCN5xEDKz4zPgENfJYRkO7/KLCqOuzaou/pv1xH8Wa5a74W5Vp5FX6FZFaw4L
         TTkY4AUs7hk+fuBXW4fIWXUurhMyunaOAaRplP5jc8pUIcUC+UMM8/Sal9JyPebwogCW
         LC3w==
X-Forwarded-Encrypted: i=1; AJvYcCVQThOF7Sae0bAw4KQtqay1bGtpQ1Lh0r4RjUmD/69WiUy3n66z2IZ7M59QCGbJlycb8/yczig68BrJpEo0Rn3h2TD0Unse81m6u6XHBFd9+FGIE+R7H6Ul6gWwE6Oh30aXZgQIi4O3tA==
X-Gm-Message-State: AOJu0YwylOEz/Hn2FuLyiXSx4g9kgXooJOBpFAe2Wt/NKxsrnwrC+RUn
	hgaMZkg7CJIoO6MLHUPSLjMsIA2DDDcwbWjBX3sXAChm+yuvPmLM
X-Google-Smtp-Source: AGHT+IEh3QzzBrGH3Fkwre2nqmlMWM9lN5HMcBkLhBrfl0TLXOlZm+i+0fHOwVunmv4y9uCu6j6f7A==
X-Received: by 2002:a17:906:6d58:b0:a3f:76e1:174b with SMTP id a24-20020a1709066d5800b00a3f76e1174bmr803527ejt.35.1708676302996;
        Fri, 23 Feb 2024 00:18:22 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n16-20020a170906379000b00a3f6c5bf929sm1633346ejc.18.2024.02.23.00.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:18:22 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 23 Feb 2024 09:17:44 +0100
Subject: [PATCH 1/2] dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-archer-ax55-v1-v1-1-99f8fa2c3858@gmail.com>
References: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
In-Reply-To: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Document the TP-Link Archer AX55 v1 which is a dual-band
WiFi router based on the IPQ5018 SoC.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..ff0a3b64f37a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -351,6 +351,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-rdp432-c2
+              - tplink,archer-ax55-v1
           - const: qcom,ipq5018
 
       - items:

-- 
2.43.0


