Return-Path: <linux-kernel+bounces-157196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A98B0E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2327828974E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154CD16D4E2;
	Wed, 24 Apr 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Owue89"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB6160794;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972571; cv=none; b=p55FRpzux6Np9OhuCOV8ds0dUXS5zJnDiKCoNuvpnbpJrjLWnvHWAQaRa0zz6xRTkeDh3TGaSa1SkKnbE1XDKMnU51C5wnKFU5HAOxFKgs3XZDWJuSs0ZXlFf5XXIgxR/cuWx/Xu5w9ZjxN4tQ3uT++qN+qe5Z/Uu8ARMrkWvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972571; c=relaxed/simple;
	bh=yEMPHPb5KT56qG3FEfeX2B81pUggQh92gGbKUtwoO+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ho5VtSlQQO8RKumo8hlQRwZIuNvA/A37+8gVyAtCS+qROPXXv0EOVYlGzi7Ft2LDQLaEnr38hMQznh9Uug7e8iCQ3JCCPJUIL3oa7NivTzQk/1ypWjmUdZRXNGV/4MpuWbFH9nbKxaAqE0ezIsYJE24JKPo33rbG4b/nHH5+cLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Owue89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B3DDC4AF5F;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972570;
	bh=yEMPHPb5KT56qG3FEfeX2B81pUggQh92gGbKUtwoO+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H8Owue89rIC4XgiTm+89NmIa3Klpma3gkWTa9Uj0pXpFitHwc8stLZ1bOyq8vfWtL
	 djGcz4ImtWEHEEef9nka31C/fwxbww2KVQOY+MDoeFA/nHm0zfg9rpYIyuu4hRS4dw
	 Xs+3WdE0MF73P/lUgnH5sSNSZ3qGGSvS4u9EPc/pt21EQrA44H74eJrAgvPQhTqxjj
	 O+7hoZbrM0he2Girs8TL1N5248M0tLXuygpVWeY4wbbVblnttM9NZiP7pKo+2pFPsQ
	 qaLWXtBrSi8OkEN/VkJ5CLR2XVSB//9PpzYlPXAfXgOJLtn1viMYFDQjSsG4n1YhLf
	 lkRk0iqu+5MBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E60C19F4F;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
From: Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date: Wed, 24 Apr 2024 23:29:13 +0800
Subject: [PATCH 08/10] dt-bindings: vendor-prefixes: Add AYN Technologies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ayn-odin2-initial-v1-8-e0aa05c991fd@gmail.com>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
In-Reply-To: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Molly Sophia <mollysophia379@gmail.com>, Junhao Xie <bigfoot@classfun.cn>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713972563; l=793;
 i=wuxilin123@gmail.com; s=20240424; h=from:subject:message-id;
 bh=Cm/VLCSCBA/wJ9+LOf+qf8btflRrlxYoe2807MqhRCQ=;
 b=yUgbXGvI3Ipr+IOpp0cr2Plxv3RuqFD9A60qsyDt6n2ukUILRwQAZjBJPAaIjhv4eJPpAoMyc
 W9vvOzXzZq6AVyqP9CiftwtVCfjavCdVlkMpLK+HR5iJ1T3VaEDyns3
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20240424 with
 auth_id=157
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: wuxilin123@gmail.com

From: Xilin Wu <wuxilin123@gmail.com>

Add an entry for AYN Technologies (https://www.ayntec.com/)

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e4aeeb5fe4d1..c2365b0f4184 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -194,6 +194,8 @@ patternProperties:
     description: Axentia Technologies AB
   "^axis,.*":
     description: Axis Communications AB
+  "^ayn,.*":
+    description: AYN Technologies Co., Ltd.
   "^azoteq,.*":
     description: Azoteq (Pty) Ltd
   "^azw,.*":

-- 
2.44.0



