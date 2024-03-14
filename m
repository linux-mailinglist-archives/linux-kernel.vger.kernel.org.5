Return-Path: <linux-kernel+bounces-103709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B3387C33F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CCD28899B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F475812;
	Thu, 14 Mar 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="QjhZ/zdg"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C97757F9;
	Thu, 14 Mar 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442836; cv=none; b=iiOCUR7K6Sbs3+WsTdOdO2fWYEhXjp91CQmVM6Pam+tkUOF+Cd4FGdZX/z2x65wJk5Sp1ZQI6U7Jj7HtvbTYXd6Hl0yG0+yEH4ZEptUekmZ3seUEw72fb8RG8RtqSlzyvhcmqnOVv/B0WWy0fa3d0ZV5xXaMn/7WP5gJ8gVMaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442836; c=relaxed/simple;
	bh=iinsNu1rmwkJxWfJoTSdWNaQLvreJbqMu8I5ThOn9VA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W8YRnHc+e0XoSf9or8L9SNnI6G6pd3cbTlJ+sogDo0ibZPICosqIU4nZO4o83xo+7mQOUV2VvngjGBMtcJOxdMcTsQGNT4yaS+3ra7vIorMy+vUlUa77oAlXEpNpx92VrPRBhwCXJY4zg1XvcMVbL7tCwVOfZHfg/qj1yMzYlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=QjhZ/zdg; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710442824; bh=iinsNu1rmwkJxWfJoTSdWNaQLvreJbqMu8I5ThOn9VA=;
	h=From:Subject:Date:To:Cc;
	b=QjhZ/zdgiYQKxAtEFj/aNaF/JELzIPp5J6/bOM/ALavW278c+HAUO+z3j+8Nut8C5
	 ritZljBl413D9Y6Q4sk8lwJThrpRKgz0+OIaBCPdpHJC1nc24LnoJOWgHPCCSTd1lY
	 YeEb5pBx8xBZtC8od0PYCrMklTw0C3C85RN5SYH8=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/2] Add Samsung Galaxy Note 3 support
Date: Thu, 14 Mar 2024 20:00:13 +0100
Message-Id: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1J82UC/3XMSw6DIBSF4a2YOy4NoEbsqPtoHGC9CkmLDReJj
 7D3Uucd/ic53wGE3iLBrTjAY7RkZ5dDXgp4Gu0mZHbIDZLLipeCM9JvWtzEzCsga9QgtFRNz7W
 CfPl4HO16co8ut7EUZr+dehS/9Q8UBeMM276u+7FVulL3vXRhua7bDl1K6QupWrLvqAAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=iinsNu1rmwkJxWfJoTSdWNaQLvreJbqMu8I5ThOn9VA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl80lCUdULQ+jAGaFwXj39u3312iwU6N2MXcruc
 96N9HVsaRmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfNJQgAKCRBy2EO4nU3X
 Vsi0D/42krfEAiXcU5/XzDjPDeu4A/VHxZWy11NwoeVaxQccZK2AsmdHOWbo0YlMpGol3rgQpNU
 BSgLNT2fGoeMA253zDoMF9WQnv5hLojyIDx3dJzmZEXER9zpSNbF7s76VXM5asQOJIODeraaGW2
 znIrw+rAqDOzGUzs3jI1+0CnUb2YlsTQTdYNdoaRGVu77tKY1/A7sLyFpufyu8zIY4/aS8Uo4wW
 crcCihHkQzj2Ms4nKCZf1i/TEGFiNTvAP305ycMGIl30zZ6PHBc6k4fyap7iU1EoonDnAv+/75G
 sgm7dcdjUH/8mUw70CcMltscs8+c8LyIniKo1DeyoT2JNBAdBSDGB88jVcDS6HJsSsg3Ge2l5fR
 E+AjAcycByeItrX86IhDmt5954vI7+w6RsikRrhdfennSXX4kXU7Dq16xO6RKMnmevZU9VNPXNN
 EhRjf/2xFNaqR+dJx8lFE1iMVzItjgr+8a3bgZe6BF6VFxB95KILI0sVBWv75v8FULNCyCG17qb
 Tk2RMgyATpJGcjXFGoGetAHpd0uPawjBs94wE/qQbRoW4wJBf4oStRk7J3x5sZ8QisJmdgauV+f
 Ah4iBtVAltCeXRe3xV+Pk/mbG1ZbVbCb8Aa1qdnIpLAmB7yHVagdgJevz8x0BCzds/sjvk0tH/w
 qunD9FgtcWM7tdQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the dts for "hlte" which is a phablet from 2013.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Correct property order (Konrad)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz

---
Adam Honse (1):
      ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3

Luca Weiss (1):
      dt-bindings: arm: qcom: Add Samsung Galaxy Note 3

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 .../boot/dts/qcom/qcom-msm8974-samsung-hlte.dts    | 401 +++++++++++++++++++++
 3 files changed, 403 insertions(+)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240310-samsung-hlte-78d1a287b0a8

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


