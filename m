Return-Path: <linux-kernel+bounces-11028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182381E03E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169BB1F2214E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BF524AB;
	Mon, 25 Dec 2023 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brTYMzPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95CE51028;
	Mon, 25 Dec 2023 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso45429875e9.0;
        Mon, 25 Dec 2023 04:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505816; x=1704110616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQg4W7YaJR5MOUu16q2YCIWylXtF8jz1Cnec2z7KjH4=;
        b=brTYMzPo8YOyazC8kPZ/3xRdfNiJYmpH3zL8fcVtHtMd8/nBtZYXcAECzT07n5e3td
         GvBXXVxEdUVTOZ8haDGdBTO1+h5XfZ1c/xge6xKxfnRIEOHBj8b0rpXGZjE96ShExiKA
         yoc4PgStnZ6EGrYBzFnJFjVkftWGHz6Jvmqz2D6xPTXAn9wWnw3zefndSYOw6coXqiFW
         rFiUoPSc6FsyWqMJURuRVAwJSKvuOXCzVj2ACl68y/TG+ZQ7H5WEUKekugWYAieful5o
         /XKE1UNDZOVWyUAVeGGv9grwAB0ZkMEWVXW5OmCcTbAkgkchYe4VnOuZ1fClvbbo5ebd
         n2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505816; x=1704110616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQg4W7YaJR5MOUu16q2YCIWylXtF8jz1Cnec2z7KjH4=;
        b=mJeoaK3hHug6zR9VVdaTSBWcQXH0z8bsLANPljtJ+vLXVoVUXRaEPyfPJMxHlLCoyy
         fD8R1+P8vd0jJ4q32IYrUrujueISnQEEfgA7f+ktXIXhBNzL6ufNc/SAISWABbsThkhb
         RPff/sKVnVtwEbfCUo3UukMfHncx/vMyQS76yKa+d0DWQN2CEmJlarmnGvsHPkTzEVBA
         PP2IVdtJ/IBaoGOkVb97orYP7djkAhl5K6QmTSESI9JSxdngFAJ7L+8Tb8gUnDQVCO9n
         xUaYbByi/nf9ehg55xpzZv6fInRFpS1ZMFR9wzRUY4cYNnvuL5Bq39mpWYV1PUW3GZXj
         N4Ww==
X-Gm-Message-State: AOJu0YzmTxvaA9elLKo4QZg4t/zPjqoNN4V4hxIkArLj6bm8uf1hXjRq
	V7KwYRUoam7aecf5HO0dzFQ=
X-Google-Smtp-Source: AGHT+IGdIHy+N9mc4C/Pdv90hxLzQqMz187MznyGJUQp6KhF3wP1/1LQv3CKc5ED32Wn+5sFhsuXKQ==
X-Received: by 2002:a05:600c:2201:b0:40c:2d7e:6f72 with SMTP id z1-20020a05600c220100b0040c2d7e6f72mr2996362wml.118.1703505815980;
        Mon, 25 Dec 2023 04:03:35 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:35 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/8] dt-bindings: crypto: ice: Document SC7180 inline crypto engine
Date: Mon, 25 Dec 2023 12:59:54 +0100
Message-ID: <20231225120327.166160-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225120327.166160-1-davidwronek@gmail.com>
References: <20231225120327.166160-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible used for the inline crypto engine found on
SC7180.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 .../devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 09e43157cc71..e91bc7dc6ad3 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - qcom,sa8775p-inline-crypto-engine
+          - qcom,sc7180-inline-crypto-engine
           - qcom,sm8450-inline-crypto-engine
           - qcom,sm8550-inline-crypto-engine
           - qcom,sm8650-inline-crypto-engine
-- 
2.43.0


