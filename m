Return-Path: <linux-kernel+bounces-137499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F889E2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FAE1F22681
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9B157475;
	Tue,  9 Apr 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzFWE3te"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAB15623E;
	Tue,  9 Apr 2024 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689722; cv=none; b=fV1Z9qr0wf1as18hJJ1d6y3p2779EQLkOdeSFgKoQkcSoDZyI5z/ewBrp4sBZz/1ADdILd0ZZFr20KVpPQLEswM53bOFfwuaD4SRwrvPYzwBhY7K+EAcis3HNFCv0PX5ADh7QHZgvUnxh27QmnKPE9en3hEmfrg5h9+hpbTk37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689722; c=relaxed/simple;
	bh=/LW5UP24d3M9gnDJHKsZY3AjzrEnrgPIA21IZxGWV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMLNv3WVgqa4wVvq7RRdLbZSsUz2DVBNQABxsWeIXjRxZvOh7ooFKlsMnMFOKQcO1D7MTq74W2GDzhaBXnV9fSGQzTKpXByMCgh6xKqel1z1qSLpJJ+BMCKL4KUiuS0+vY1gugSWfamtM41A4Ey02xvIZKuBdGfF9/+NgFEGq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzFWE3te; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ea1f98f3b9so901707a34.1;
        Tue, 09 Apr 2024 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689720; x=1713294520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=jzFWE3teKpUJ5wl862mddPBr8HyYqumW7+TUQUfqgfnxAk0FERYfRgUpEAWQHmvX/Z
         b7hpQ/I8JQXrv15s7jgABYJRxwc2Sd+WEt/j2LYf3AJcywE/27N7Ny15ZdMHRN7ZS+TP
         HWquuz1a71ZoYYr5ZOvUrB0dT64q8mcypTeOEIU/eBE+SSr5o1qU5AmnSgT2r1mSFUqU
         zXVhtnEPoNCyDamZUWsf4Lt3IsHXmLYPMhlPk+vM3E4gMNaUM+3YOyCkypC3HY2jv/QW
         3/tqQbea23nROABQX92mWZxcf8B5YZUgupXE6dG/B/NK1eONJB8GMq6jMBqNbA9w8jPp
         3PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689720; x=1713294520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=HVbsvJ2B6kp75tPCHe/4wbT3Vep3RgZBjb7w7lrXhpNG9OHEFUIdCGsSoOifbrxhsp
         H9KQm/y2yiWF4Xpi0G82a/gTjFIfY5lzh1j7ui44AUwWh+vk7aVFzkCqeds07fFwPtdK
         M+MymysjHrW2q2qk8UrUnncWtlpcmm6DCBnbmui20PeMx6HtCTsjJRi4UZWVU7QtqHTK
         Pgc3T/tRwjO48TRG5coYiN+nzzLXKwobBqRclElAZhqhPUD2lgvEvSkxrdHFL/0CfeyI
         5760zsPTse+I85xjT666DrAndRyJlTIBDWTOKGYcu9ug30eeLFqnAQ7HLBDzK1o2FSFX
         Eo4w==
X-Forwarded-Encrypted: i=1; AJvYcCXA6GcEZgJRq+8kri3Q7enlv3Vf6XBm30u2g5vibfywuGHzxN77XjBldnz6wUjwjPCIC2SURhHr2MpZM1CZK7/XgQWlhYePz4R+01mz05ATviKKej9mBSktlrXUGmUphuBm9SEkCXo3v/rQYtTU2reDTLw4C2m0jfkuEXgtJEdHNw4mZFjukeAcz77MOFJtxaQ5ssn4/g9Ob4GC6/PsahlsuTo=
X-Gm-Message-State: AOJu0YzIppBYf8lImc4XE3JA78uNYmgIJu9YAeBAp5DzFbWNOMFA4Fhq
	mFwo32o+HGILauMCjsbAzQ/pRvjEfMayQzYVvWct72zGJxcP42vI
X-Google-Smtp-Source: AGHT+IHnHq4Yzw2dp8mXx3ucVbabpjqSL5KTYckari/WPAcfuM42DCdJWg9oNA/1AS81eRtwKhtJBQ==
X-Received: by 2002:a9d:748f:0:b0:6ea:109f:ea50 with SMTP id t15-20020a9d748f000000b006ea109fea50mr601491otk.15.1712689719902;
        Tue, 09 Apr 2024 12:08:39 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006ea1cf91a8dsm674920oto.40.2024.04.09.12.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:08:39 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
Date: Tue,  9 Apr 2024 14:08:27 -0500
Message-Id: <20240409190833.3485824-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
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


