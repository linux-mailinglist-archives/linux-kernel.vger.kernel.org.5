Return-Path: <linux-kernel+bounces-134314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351389B03D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9CE28379E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38F1DA24;
	Sun,  7 Apr 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="BT1El5WM"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31801802E;
	Sun,  7 Apr 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483945; cv=none; b=tAxmGRaY5y4rqNI6gc4twfhTIpjVEQPrVI0ZyXVla4yoQ8JeXklMgGCOmdfLimpbGQrAETkkvVzd8fv+4yVvrdu4M69v1/qwlB7GGCjKAa7DVPcyXgTEpkOszwRlMPYaJAPyexqMuOgbg1txIFNkWNm9wz/oabEbyqveZsFQlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483945; c=relaxed/simple;
	bh=91pHJf0RjCkHKMBVz3YAIolmXXmzxfQ9oX5Mm7y5tiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=by9jCYuqpkrjHC6ztl2HgeQT6SxuNcTjC38Wvoto4sW4UosZh1VYLnpuSXaJWDPw8XXb0HMygJ0OZ/KowOlS1QwTt3lKPyt2jkFkMXyPaXzsTsdDzXoKTlIqb6lYiXnDBIGib+cuadPsQxgqH03RBNwhlXvMcHTwdfP+VcNBOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=BT1El5WM; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712483941; bh=91pHJf0RjCkHKMBVz3YAIolmXXmzxfQ9oX5Mm7y5tiU=;
	h=From:Subject:Date:To:Cc;
	b=BT1El5WMzxFAds+jZoUwFt1Qna+WUkaJANQ0c/DLLmWUuBKRS2QFPdegkRTAUYj+K
	 Ryfme+fx8ro/s+MoZuNkhCRks2U4OoIEuLk1MGII6/nD3nHGSmSu6Lu5w9yoMPbjKl
	 ijH0vCTfGhDVCuVxX1n0GJuAq3ReA/Do5Plig4RM=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Fix up qcom,halt-regs definition in various schemas
Date: Sun, 07 Apr 2024 11:58:29 +0200
Message-Id: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVuEmYC/x2MSQqAMAwAvyI5G6i1KPoV8VBitAHXVkUo/t3ic
 RhmIgT2wgHaLILnW4Jsa4Iiz4CcXSdGGRKDVtooo2o8aFvQ2flEz1PAUZ5rR00VETd1adhASnf
 PSfzbrn/fD0F4UyVmAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=91pHJf0RjCkHKMBVz3YAIolmXXmzxfQ9oX5Mm7y5tiU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmEm5KWzBpEFmmDaHOtSoOvyOwel19M/hzCGx1C
 KXvs99RsImJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhJuSgAKCRBy2EO4nU3X
 VsqnD/0eH8nSV0JYqywzV18+4RZ9P0ckv6ZFQ5tNh0cQ8304FZSvUVqrEAeHci1yXifW0r7zrI0
 hyDbDBZVy2C1dMYjRcGaP0PQQ5OK/+iskD7nBL+VHPP/nGaZyB6g6u5LegglIR9HYQcOhwBlha/
 zazyeKr0HJOf2mRmaXS5dOl1PRB+6ndF7zLtukThMWvHnpdd0iy+MCUaY2gDnyfV70kyqaJE98M
 yWUxGzaM81wDsAx1A2ZwXIVwhL16e343YZq3bFrOwzAcheFt93uUZhJo5F+5SxS9uCV/iPwxnXU
 notK+9rqotPIegHyuWh4TPTkZrcpJJErrV9MDcesqsvpopLRxEHmew/Lz/glvFlNQy3yE5T+VwQ
 ZnfarhnlcDAsAFvkTG9O6HOLGtfX2XTk8AryX6lZ08tMV1Hm837kwgTDzDx9Fb0kXBzOfpBxlxH
 P4Hmt0c5DNq1GePVXJcnNIOBdmRzuSimKh53GJGlDVe21zegf7I9dP9kt5uW7SN2rHV+IAZnD3w
 GIZ9mmdh23UpWQW5CrQyRua+D0yjyaT5BVAMs0UK8ADtGf51RTlB2qRRtWsecB0bEj0Qx22lDuz
 bQy4l+O3LCflz98NW+PaEf2woKMWYkvjEjxeEpnzJ6B9lmrrrjZtXO2GO2t57768QalB2cBjdy5
 QHV2duTTmR9eK5g==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

The original motivation is that a bunch of other schemas fail to
validate qcom,halt-regs, for example like in the following examples:

arch/arm64/boot/dts/qcom/apq8016-sbc.dtb: remoteproc@4080000: qcom,halt-regs:0: [20] is too short
        from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8916-mss-pil.yaml#
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb: remoteproc@2080000: qcom,halt-regs:0: [82] is too short
        from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8996-mss-pil.yaml#
arch/arm64/boot/dts/qcom/apq8039-t2.dtb: remoteproc@4080000: qcom,halt-regs:0: [32] is too short
        from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8916-mss-pil.yaml#

While I'm actually not quite sure why these patches fix this in
the other schemas - feels like a bug/limitation in dt-schema maybe? -
the patches should be correct anyways to validate qcom,halt-regs in the
schemas I'm touching.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      dt-bindings: remoteproc: qcom,qcs404-cdsp-pil: Fix qcom,halt-regs definition
      dt-bindings: remoteproc: qcom,sc7280-wpss-pil: Fix qcom,halt-regs definition
      dt-bindings: remoteproc: qcom,sdm845-adsp-pil: Fix qcom,halt-regs definition

 .../devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml        | 6 +++++-
 .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml        | 6 +++++-
 .../devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml        | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)
---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240407-qcom-halt-regs-fixup-2c6cce9734e4

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


