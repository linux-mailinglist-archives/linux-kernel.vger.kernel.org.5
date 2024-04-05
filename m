Return-Path: <linux-kernel+bounces-133112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1EE899F00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC951F22931
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328916EBF4;
	Fri,  5 Apr 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="MfETN8eb"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E60516D9D5;
	Fri,  5 Apr 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326018; cv=none; b=ODdM24iyG2lrlEDfa/WFbImZkPDHe6BjICSMbp1BlSbSXtaGt66Vj6PmVTorz9XU9Xhw49qjV1NlP07U2LhGSkUJxYpAiXCOlBwRa0NFSew0XqIZQlJJVdqKnOsbRa77LoGmswNPPLD3nv4nB/uyec0f3vv7FdJR4lAxQKVNL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326018; c=relaxed/simple;
	bh=3fob+Z0dnkN1sC01UfIVQnDIKoZPCEYw5nkU8O/lkew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6C1kO2CuONiNASg5K/oyPQRj3o628TjfHBSevjnnWXD7l5Dbz4SAn4rd0n17UAkeWPHKOUIswfycxZ9t3WLPnevEMrzUPEmm5tK+CwS+7Uq1e9x0pcOh+LBTIDFz27KcVpg3ak8jdpuMY87cQWhdMyfsS9B2OtNVMVlYZvkpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=MfETN8eb; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id E729A41984;
	Fri,  5 Apr 2024 19:06:45 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1712326006; bh=3fob+Z0dnkN1sC01UfIVQnDIKoZPCEYw5nkU8O/lkew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MfETN8ebDdefmeErUHwP10ldK8IqQRN5+C6FbPC07kG8Edul2DUO9LuUz3K5IQwkz
	 KuMcSYFHNVE4K525pq7p1Vzi8tdn3ojjx9PAQZ0dlYLMheVK1UOQ7xRs4f7xJ6GDZg
	 Kctxi2jMA1M6BH5GIBgdpIwxlQ04ayphwXF7d2VehTXXLPO87Div6/5qlp4cFBctsP
	 2y7kAIL99vyGoJkyRNLJhVuh82sB6VYAADUt1n7AcIKAIClTLgyo7AnLqtsU9oPh2C
	 J9qJEGs6Cct5kiGAIs12UV08p3x4wW9actG8DCa/QL+JGF97W3+U4e+UZHGvH1QTIE
	 efkQJof+/7vSA==
From: Nikita Travkin <nikita@trvn.ru>
Date: Fri, 05 Apr 2024 19:06:10 +0500
Subject: [PATCH 1/4] dt-bindings: arm: qcom: Add msm8916 based Motorola
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-msm8916-moto-init-v1-1-502b58176d34@trvn.ru>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
In-Reply-To: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=3fob+Z0dnkN1sC01UfIVQnDIKoZPCEYw5nkU8O/lkew=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmEAVzlEKbLSRWHSbaVwks1LvpvwzU+eqTVHtas
 86BjfU2l/OJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZhAFcwAKCRBDHOzuKBm/
 dRIPD/0RhTKtWcXGi5ofuqNVafPzcak7zzl9p+UpgjtZm/6YmKQ0+vnOAnSLHeqonbpjSZc/+95
 OXKZweQVI4H37Zm1mxSrp3Ed4Hc8AFkNjT0RGbtLs1QWd/yoXCtQJeppjvXzxi2rAC1cURT9WlH
 Z0vf/jSkUJdzZ/ZT1P5GYnnRjBh/Dk9z+y/hGf/hH8xOcuuXHGQE0jfHX75PiKxKzneIEWf2kAG
 XQ/+ZCWsC0FiZWYQS4isdSi1FVr6kvJWL+u0psRpr8ChoAJD4Mc9IGuOw/JdfuQNUkfsp0eKHWs
 ByeYfRpQ123lEIQg01hL4YRWkpni/lf2qYRwsL6zQjG9xuySebZ6CTbYHqzXSUxOGJw+htTjDd3
 aV1RO3cMc15YMvYr401uuW68uimhMh8Bi9W1HF8yN+7V1EuPltYUCqy6sKmANwiIQxc94i+7pH/
 L71Q04vZsI4+uyk4BN6r2dPaydfmKyLVCVKxI/BIwfnsyijBb+IxoloyD+FYsgW7mmghycAOIS0
 lg40liEW92W/USbsMN1JEU+L84HfMGCcs3kkNkQDKYG0T7F0IMwxaJyasSijVpTwF1EtvWu0hbG
 7jWoxozkRdQnmvJHc+LXqzIpmiE40yY9XlU0SfAcHSE9KuFPGvYvXNfNI5nu8P065RZ98kkZLlx
 fr6IwjuuZ9S93qA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Add compatible values for the msm8916 based Motorola smartphones.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1646e5bd23d8..29ff7c833909 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -197,6 +197,9 @@ properties:
               - huawei,g7
               - longcheer,l8910
               - longcheer,l8150
+              - motorola,harpia
+              - motorola,osprey
+              - motorola,surnia
               - qcom,msm8916-mtp
               - samsung,a3u-eur
               - samsung,a5u-eur

-- 
2.44.0


