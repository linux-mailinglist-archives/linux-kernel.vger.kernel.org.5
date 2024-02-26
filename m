Return-Path: <linux-kernel+bounces-82271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA3868184
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203CF288824
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A887130AF1;
	Mon, 26 Feb 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxbsFE44"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810C12FF9E;
	Mon, 26 Feb 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977367; cv=none; b=NA0cavUC/Lw0q1Mxqfk5dawTRGuABZm3z39hl69tsmRw07hpOmTA1BK8NlfpYR6Vm3pgby5/p3E7e4GYlhu8mrfFPmn+pxRquiXYgWQBd4oZWlIQgY/6mpvV6XGrG1c4ytwkA1HGvG8CYbgPAfvAIpgzV/LfILPutXwrNhaUZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977367; c=relaxed/simple;
	bh=6Zl7pRrMwE9dGNrCDqkWNA3304G2EaRtfiPFgXD6Pog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsxNtpNakkB53EXcyYaJS2P0ajcNOFoSWfgU4yzRrQsYoy4usmzTKZ5JSU34QnH8l9HSHaIS0HtNvQv1kjZQl0tYwqniHjrl2E1/hod0/OajRVmN2Rp85TlUXx+v9beEikJeMUSp9oJgqLlF9eYNtOE8gqsouKABdgESaf9kxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxbsFE44; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4f45d4369so1047167b3a.0;
        Mon, 26 Feb 2024 11:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708977365; x=1709582165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJVioeNisc4dy/+Rk70H6D/CcaCXrKsjxQfBoFKY1rM=;
        b=IxbsFE44+h3EGs1rnmzsmcAJHk0OyAZtf6n2Lh0FgAjWqy1+PEJB9EYGMmFAPQ9gEq
         fqdtuC8TkxmYDpq9UClUhHc78GBrgXdzxC3jDz0nc/7oA16vDISoYD5qmOy6sZX0ALMw
         mSvENgzK/n9a1acPZSPIxd21k61eUVbKrb65uSYW6qF5DXB/hiKPN4f8NwonezYy4KKD
         9jzFkOT6T2H+RzrlrDcjs5Do/WVunq/0zCYpttZVP2SgibCcEVvXYZsY6RHU5epvaI47
         p9AU+9+Y92bgulRLuUhCfo6lA0ScPdI5jc5Cydb8lffHKkEjV6QjQ40U9GilRPnCdmJN
         tDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977365; x=1709582165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJVioeNisc4dy/+Rk70H6D/CcaCXrKsjxQfBoFKY1rM=;
        b=ScGCEixwvZbikANxGTewEoCCx9o3cjB0Gj5Uftf3Q6lpL7BlTv08SoY7RWfeNGNGca
         ZAcDDIJty242siHtmh75QWam+xsHoAurujhOKmEov0plWInQ3MJw6vrt43/MO65hIM4W
         iHEC8wI+jDzLJhI6FtU8LjgdeECikOnWQXhwv4jcH7htjHqpRDHKeVklhmkEuQpi2I6a
         vhYCD/J/fUU+WCmVh9dWB892L59/O8YU4yDOkytq+77AZwsNtgjCRAD5/1R0ppjEZwYm
         WUcVxeZHLUmTnlo1VdiJ7lxyOA+EpCHTHPo8xndIYD+GqJ6XOcpDH2Cg/OW/njew18x1
         LZng==
X-Forwarded-Encrypted: i=1; AJvYcCUKn2+VcIuTfG1vjB1wdjZPMT3YDSmbp/BKwYVXGonAlUOoEHDpQKlHH1cGH14f0NEkPQOwAbVWYHbRTw9ON+UxJj2GcjO22+OHWdYrYo2u9V4RAGsL0GLIMsVo7BrEMK7P0jxv0M5D3cEPLpULe6Bb686cCLtf1SXPr6XE6DYebc0N7A6jr02SvFuIw7dgII0rO7ZjEuma+dn+coLfg/slZ4O6cCE6hEI=
X-Gm-Message-State: AOJu0Yz+McaKtFgbXZWaGlrCzAjreaLHlscujjL8NvXcki1WpVq9Og4Y
	UhdF8Z7jwtLBVU3oJxUAKy+tSLUsIyOL1zHjhd2dztHitHhRqG6T
X-Google-Smtp-Source: AGHT+IE0vdy4nq3mjSDWbLvfK/nPZRJvq7XrZHmv1/yQFVMoH09Wq0qFtlEesXmEaNamvmG6Vn7uqw==
X-Received: by 2002:a05:6a00:2d96:b0:6e5:3e08:cbf1 with SMTP id fb22-20020a056a002d9600b006e53e08cbf1mr2371390pfb.23.1708977365278;
        Mon, 26 Feb 2024 11:56:05 -0800 (PST)
Received: from localhost.localdomain ([115.187.42.119])
        by smtp.gmail.com with ESMTPSA id ls25-20020a056a00741900b006e532495091sm1902252pfb.73.2024.02.26.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:56:04 -0800 (PST)
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
To: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org
Cc: raihan1999ahamed@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Lenovo P2
Date: Tue, 27 Feb 2024 01:24:41 +0530
Message-ID: <20240226195516.174737-1-raihan1999ahamed@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the MSM8953-based Lenovo P2 smartphone released in 2016.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..6cc19c8d116d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -263,6 +263,7 @@ properties:
 
       - items:
           - enum:
+              - lenovo,kuntao
               - motorola,potter
               - xiaomi,daisy
               - xiaomi,mido
-- 
2.44.0


