Return-Path: <linux-kernel+bounces-164893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F88B8496
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3061F23E25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA33D97D;
	Wed,  1 May 2024 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocd66zqi"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8F29405;
	Wed,  1 May 2024 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536486; cv=none; b=Fc69fDF2ber33a2aoSDDQv6oIouvyeFsEFcxapE3A0+PPF4d/5lNTGmvqqE2+YPbNASSw5S6OBbjd8yzMyyVhSz257ZtbNUHvExYEzJldyMaEk95FIBi9OUCzY7pjB6lxdE6hEGUlBKmoAYwN4i/4VE2pC7Jfe6CvEwOwI9MPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536486; c=relaxed/simple;
	bh=/LW5UP24d3M9gnDJHKsZY3AjzrEnrgPIA21IZxGWV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hg85xoN8iUbfK/ZAvhqDzawEq3FNpfo3tP1Vf8ZTovQHsEjH1RfL86G9tpxOLfZEq5VhnNIV4vAuqoVkxBuu1TiIT21jKyq/I1uLaP+DfaZGJkGe3khTu0jomldc6YnP1A+W6/k3+ZvqERMPsOruGtFU+n4TquvDXLGzhiW1WMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocd66zqi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c7513a991cso4345129b6e.1;
        Tue, 30 Apr 2024 21:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536484; x=1715141284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=Ocd66zqifgVp9HxefgdAMCefTDJd9e2cCw8L27JdontZ8JktuR5FfT0u3wsuw+PP8J
         N9bnhh4HMxEf+Epep8aQ4tQhKsE2yHvVtuU3jY3OOFhn5YHTHDhpa2GXxeywVgiTdtZA
         xRFF/JXxZZ40/wpRobARQssej4QT6UIT2OdGFROfdnAE0PBhJu67LRt2pRKMAbVcpt42
         u3o+LyCkogNknSjjMXpvFiCezF+hi0iiUeBrD9NJwNKU+mNHEqUKV8q09fjPHg1nR4FJ
         3JY5+KySHMchLtQPtZmFQzAA+rT2C2mOz5CGn1hlF1v+MAFyp6or6zxp01VxNl21bbUo
         rubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536484; x=1715141284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=gCsVJ3Pfq2sWfG9qcPejQFpBsM46lQvsKmutOt3/pWKwGDn+WR9NiYvUo/j41k76Fm
         ugue+GcuP5t4OFXWgBaAWKEywrPEA+rfzpi32KcXjqsnXyiNGaqbEnPcPOo+SRoV0RJR
         MVSKMAxi5YMABFUStSTx5bvNb9Qzir82NUI3dzN59cz7pMcZrAM0rMw1kl31JOCXIlag
         bwMuaWdfJFKTDnc58wpdlicDZUGJ7yIxseDAjfFsH39sLmDHcBqrmFMF3rN9kwZc8BI9
         HkE97ef5dTRpkjT2hHiV2uclLVH80P7rYpCDh07Ii/PKWMUqMTgXTs0RSqR/SBXYIUXK
         kMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqSxe2e3eYKO58oz79LyPdIlr8oRQqr9X7A0cZ4C73J7Tdn+PX7AB9IFrCirywPMe162S3fbXfAc7ecaz8veFDEauYapA1KazKuQnCGKWIE3iw/uLPsPij8MNieV5iF/QYVJGmwjdJyxcv2NQlaUHOud4MNiItC+RrRuQjhwd9syMMViE=
X-Gm-Message-State: AOJu0Yyeuvj8UuKce++CjVFebV9OoOithA/+5EORgAyM2xldtImmZ7Dj
	teGRS7Ulz3H3A4LCHpVhmjIipJf1BwJi3W/iprNpM8YHbiFKCx3mJffonEi+7kk=
X-Google-Smtp-Source: AGHT+IHhxTl5k/+evzZ/7myhhtGs4Q+NGdUipnNMPy+mJqCCxGveYPCkAbK/AwpAGhGYlE5UDRtZ1Q==
X-Received: by 2002:a05:6808:15a2:b0:3c7:3af6:1cb5 with SMTP id t34-20020a05680815a200b003c73af61cb5mr1916976oiw.46.1714536483873;
        Tue, 30 Apr 2024 21:08:03 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:03 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/8] dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
Date: Tue, 30 Apr 2024 23:07:43 -0500
Message-Id: <20240501040800.1542805-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the missing PCIe PIPE clocks.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 08fd3a37acaa..52123c5a09fa 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -216,4 +216,8 @@
 #define GCC_CRYPTO_AHB_CLK				207
 #define GCC_USB0_PIPE_CLK				208
 #define GCC_USB0_SLEEP_CLK				209
+#define GCC_PCIE0_PIPE_CLK				210
+#define GCC_PCIE1_PIPE_CLK				211
+#define GCC_PCIE2_PIPE_CLK				212
+#define GCC_PCIE3_PIPE_CLK				213
 #endif
-- 
2.40.1


