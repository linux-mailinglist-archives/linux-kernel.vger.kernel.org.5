Return-Path: <linux-kernel+bounces-116865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F488A487
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4D1F626E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F95B1BFC2D;
	Mon, 25 Mar 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kra8W9Pz"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF817C6B6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363223; cv=none; b=QNO1XC7U+brH2lNzhwJyn31loBqL/MvCH1A/RODB5zVqWcpTLlkwWWD7taf65rCYkbprGc9SLQ/oJQrVX4JAyc/zWGECQqbwUrB4Q49yWbV4muZNGLlIuuKtBOMYz7L7NhdQamnvq5RTO2+AOm3Yk08EGaqKXpdxxbWA5xkyYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363223; c=relaxed/simple;
	bh=ynX9ZBYzxPzMAYr25ThDiwQecIKhEVVmHEJQoxv6r3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcnJeNVHh40WOikzOtUZQhB6LVNCK0fT0vT8ZIgnguMBTZj9YgDp6SaKirqT2lzYo/vJrHIATTlPkfMb4NVMNpN5oLR3KIjXMfr99go2JwdubGJTHFMnV0XEjxe0OpeMpU1EEpjbP63JI56hsgJyRCxe7+HLObPD9nkQrpC5pS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kra8W9Pz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466a27d30aso514199666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363220; x=1711968020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w9z13j4V31H459FQRJgVfq835l0rWDyktrTi95xkzU=;
        b=Kra8W9PzasMsWdffxtGFMAucoE9RlN0thpQWTGKzi5b5ecl3koIx3/g9V9TyICNVXU
         5UsPG/npsXguAo3hO7Czd3A5oPeI4nQuSZFjARlX+I7lCmeysAzQXskWM6Fxtozxiep5
         TPVBExUu8E3qaylWFFL8xZtFJp/4CW8XcpiXmD3qp5ZRea+8NP/UTd7pWJEIlUNex3uj
         E0gRxmpQiz6gIlnK5BaugSlrNimpx49bWstPotnjBlVrFVfHlFDcRJTO3/zHXHj5qUFF
         7vjOB7nsODL9YhW+L3v5L5OrEIZl57BHYE2lzuVeHDcwnY3ML7wzQpm/N2h8UVUARVuZ
         98ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363220; x=1711968020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w9z13j4V31H459FQRJgVfq835l0rWDyktrTi95xkzU=;
        b=Mq2o2N5cHdt6GtS/A7mCbveQ5rWI4dW5P/SyiCB+C0C8AHQOZ8As+g4IfiX504FMBX
         BrU5OFUhV6H/xiGtgZUhfQ98Tc4htaxPiLzRW6AkthS5te2Cxeyg6Znogo5BpniiUQmd
         ekFuOwV5sTgxCFqbzziTn5D+pYl0sIcKQULeoC1PFvNiXhWRz2bfNKi6ldNipsjEskjH
         GiENHh+pQs1SVH2tKH6TcFC8pXzj093412Yit2eZawDqsDimpgabsmoI6QnVJxsM1jjz
         CRSQLF48GNYyNJSLiZSymAje+Z9lCUv+irn17eTet+i6sPdfmPdu52yCp9QY8fjaIX5L
         /n4w==
X-Forwarded-Encrypted: i=1; AJvYcCX22ODeIvKvyZwLFEbnNijSylIIoh8/BeUShxEPbS5cuxjBEKCJG6mxxSzxS0PuE0y9bHXBJAf88j1l7aIVCCUtWK6K7WvOWyvOA9zM
X-Gm-Message-State: AOJu0Yw49wVGPC17oWuQQVNt3oFi0oL/zrN9cE4MAIyifB6uYNxqX8Og
	RGapIvNN/I/SbHuWL4CyutOuPS9kdhlYXGE+ryp/VzUnPKIthKRGAGE/RByQK5QIH0dqfeTU+n1
	2
X-Google-Smtp-Source: AGHT+IHVHcuVJTziRqTwQUkni4jFoHLNs1JJYOw3AeX7YO15AbpNa+dcU723xmHfJLlJiDQMTO3R+w==
X-Received: by 2002:a17:906:2a10:b0:a46:e8c1:11ac with SMTP id j16-20020a1709062a1000b00a46e8c111acmr4102670eje.18.1711363219739;
        Mon, 25 Mar 2024 03:40:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709060e4200b00a4674ad8ab9sm2876653eji.211.2024.03.25.03.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:40:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 2/2] dt-bindings: arm: qcom,coresight-tpda: fix indentation in the example
Date: Mon, 25 Mar 2024 11:40:07 +0100
Message-Id: <20240325104007.30723-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325104007.30723-1-krzysztof.kozlowski@linaro.org>
References: <20240325104007.30723-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix triple-space indentation to double-space in the example DTS.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/qcom,coresight-tpda.yaml     | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index 7fbd855a66a0..76163abed655 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -95,33 +95,31 @@ examples:
   # minimum tpda definition.
   - |
     tpda@6004000 {
-       compatible = "qcom,coresight-tpda", "arm,primecell";
-       reg = <0x6004000 0x1000>;
+      compatible = "qcom,coresight-tpda", "arm,primecell";
+      reg = <0x6004000 0x1000>;
 
-       clocks = <&aoss_qmp>;
-       clock-names = "apb_pclk";
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
 
-       in-ports {
-         #address-cells = <1>;
-         #size-cells = <0>;
+      in-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
         port@0 {
           reg = <0>;
           tpda_qdss_0_in_tpdm_dcc: endpoint {
-            remote-endpoint =
-              <&tpdm_dcc_out_tpda_qdss_0>;
-            };
+            remote-endpoint = <&tpdm_dcc_out_tpda_qdss_0>;
+          };
         };
       };
 
-       out-ports {
-         port {
-                 tpda_qdss_out_funnel_in0: endpoint {
-                    remote-endpoint =
-                    <&funnel_in0_in_tpda_qdss>;
-                  };
+      out-ports {
+        port {
+          tpda_qdss_out_funnel_in0: endpoint {
+            remote-endpoint = <&funnel_in0_in_tpda_qdss>;
           };
-       };
+        };
+      };
     };
 
 ...
-- 
2.34.1


