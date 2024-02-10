Return-Path: <linux-kernel+bounces-60458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFCB850531
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9036D1C21EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCF5C903;
	Sat, 10 Feb 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="XO7mgdhG"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8465BADF;
	Sat, 10 Feb 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582598; cv=none; b=Ewf4fU6J4kfStLzNROTSTxYozJf9bWTwun6ZyfTZDqJYkpA38+mcstmJpprhnoxcVnd9A67Syqr9xl+uEyGAlomH01GjEOebFXgkqkNexkkvYnzqfugzkk9wDyo15M6gx8/QRISA6tevb7NGjM7iz2Q8t7il2qM+JtugHoZM+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582598; c=relaxed/simple;
	bh=CWuSxu3BNt4rhvvLuYo5Pl5HYkk8Bc941D4GLJ2ONTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVScCGzQ5AKws767bY2KQVunKdnaqwJmVuar12Jfun2zh3h2tF2pBLJZKStiEaYHH1NtppKCZvQ/C6l2nqHZfC7uBnQZpOnvL9zK457xmdjIb7cNUEqA9fXXv7Z6zkEo1soQ/dmtfBS/JizmpG6iP7zRU4QQrXwqBLz/FMXJVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=XO7mgdhG; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707582593; bh=CWuSxu3BNt4rhvvLuYo5Pl5HYkk8Bc941D4GLJ2ONTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XO7mgdhG0Z22rmOzW0rZ9F3Ag7WgvbieaJAd/8VODO8yeD8zjOInEvfhDD3yQzNwa
	 gUgHdqXato7QlpReQlqOeaTxyJTTrCQB4t8LjVx3hT8I9knIuAI/h6eyv2P4HWtYXO
	 0ny2ECGH7G3tnHeXEcKvdyFAHpjXT8V5MCDcKVVQ=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 17:28:52 +0100
Subject: [PATCH v2 1/3] dt-bindings: soc: qcom: qcom,saw2: add msm8226 l2
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8226-cpu-v2-1-5d9cb4c35204@z3ntu.xyz>
References: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
In-Reply-To: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=CWuSxu3BNt4rhvvLuYo5Pl5HYkk8Bc941D4GLJ2ONTI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6R+NNryrCojanAnRaA2VvCJ9Qn4W5qNNnpaN
 Y04yRvxVhWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcekfgAKCRBy2EO4nU3X
 Vp39D/0VgywKB5gelCM+T9Lfro8pM2rWFaqNAoB5jEGQoSfe1D4oqMAQduEzN64BPUjIeF8pYSe
 ysIjDVFpExdYZw8HLtXtauqWZHdyltV4IHuqNooXurXM9eQiIJqPvPtbicNEVmQZYrWEWaDUjWM
 R73o7fGvxNuNDe7H6SXOVEVO6hFA5KZRyw/cjHzngZtGdFvgcMjYSelsMxqTBH7l6Pbzzx3hVbv
 9Y/gNifw+a8nszLsK+1zsTDbIu01pdQJUqZA9LIPpLUO9Mt89CyOupk4tQWnLe38p40oz3+0hwd
 /fNMub+e7g+UJaNs52GN/mnRAM4mOgZomXTsUrbqbmWVtAOOjRg5EWfyJ9H4ePzQj23bOW0Ro+B
 xT8SExqftJzQijf/k6daoSOriHcgMXFL8AHPIxzMEzCxJ3Q9lH4xjNnZ+nrFxoHkdnKItd/GR5E
 RAkPpAULobtGlPFfq2TKPLJP9LwruYZYU0alOA1JfnWGKZnKfan5AUG7sOhZEcaBlA3XNxNAWHx
 2YcOifey8Aurf7QbQSYN/Q+ghkThK1ppn4xRANldWZ1mgJExPx5I14u7Gp41hwtSqa60OAxOIQv
 N+qScAVOX8E3X8+bTwyQo9ohQmvdTj+DuQUf2ghwbrNoCo+Wwhf5nUH1LDbauaa0oy1ndDxaimD
 lezoPITw7p5mCQg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the compatible for the SAW2 for L2 cache found on MSM8226.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
index f9306f2a6e99..ca4bce817273 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
@@ -36,6 +36,7 @@ properties:
           - qcom,msm8916-saw2-v3.0-cpu
           - qcom,msm8939-saw2-v3.0-cpu
           - qcom,msm8226-saw2-v2.1-cpu
+          - qcom,msm8226-saw2-v2.1-l2
           - qcom,msm8960-saw2-cpu
           - qcom,msm8974-saw2-v2.1-cpu
           - qcom,msm8974-saw2-v2.1-l2

-- 
2.43.0


