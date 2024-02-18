Return-Path: <linux-kernel+bounces-70577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7C859966
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF7FB20C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E739745CB;
	Sun, 18 Feb 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="oJDybTuh"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1F8C1A;
	Sun, 18 Feb 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289870; cv=none; b=kp8LQSxUWt1Ywz/TnwNwi2wCGhAfZQESqQmgm5fcsrrEDusfjRJLfbQ/NGd4z5G+Z8SR4sdmG0Ubf+8SovNix6L+KO04Jaak9xgQx5btMiZMfrtoeRtWqT5vMltVFTrzhRPn5ashkDgYZYmbEGtsFJZwznkov8hOPPUX8xpQLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289870; c=relaxed/simple;
	bh=gg9lJWHASR44HHvXtQri1Pkt7A1AFAQRzHCWHX4bYgM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hNy5pVgciaZark2ZBLsvdvwRw1rLt9tBKP0E7GOo7CIHOzW1Ie/neXsYRQlLdXchHbhjMKDTR8zLxRCPFWe3rbPd+s9ybKSXk5piw4jH4KSEcoJJ8krn4a/sHmImksUzhubpT/jVKfm3W2ux/Q4NKHkNUU7EBdQSHZzdT15dbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=oJDybTuh; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708289860; bh=gg9lJWHASR44HHvXtQri1Pkt7A1AFAQRzHCWHX4bYgM=;
	h=From:Subject:Date:To:Cc;
	b=oJDybTuhhVGhyT5XClQluwcmUDL/FF/xXG3lQOSlSai9GiaS+IEC1EfF23sufacO2
	 78ZBmbuolQxwKsgLj1OYTYwvfW1+Hr1X3bsetTcPEziHyBpZRNOLT0YbmlFU8ZrVdb
	 IDIr19zkxmEfHwJl/TdknQyfVql2QF7c/ae2SHEw=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/3] Convert qcom,hfpll documentation to yaml + related
 changes
Date: Sun, 18 Feb 2024 21:57:24 +0100
Message-Id: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADRv0mUC/22MTQrDIBgFrxK+dS3+RbCr3iNkIYlWwZqgqcQE7
 16bdeFtZuDNCUlHpxM8uhOizi65JTSgtw4mq8JLIzc3BoopI23ImtV7VNTbI0mFMLhZ0U/QDmv
 Uxu1XbBgbW5e2JZarncnP/s1kgjBivZw5V1wTyZ8HC9vnvpcDxlrrF4Ink7WkAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=gg9lJWHASR44HHvXtQri1Pkt7A1AFAQRzHCWHX4bYgM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl0m82P7odzZSC4lkYhivSeToHEzGiYMYFMiwXf
 H6x0ie5UNiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZdJvNgAKCRBy2EO4nU3X
 Vn1DD/91y0Ipz7kusToi71Np3xBNR2T9HpsJdQpRkPTYRNO5ROlnaepifh4m2UH0IQQXDgcoFXA
 A7M5zCMSiofbRjE1nITZjMl6WQPyiPVEXoa8IOphLZhMjUYrxaNlz3JVWb7bKZAeOTRD/ZUPjhc
 Btn+pqHthOyl3QIUn17Uro7fNovfQbkM2rn59qaYaD8gGbLOf2cqip74ojB/Kp38rIdstvYul/9
 dDNzTevs47Nvzf3ye2aWiytXicjMiCO51M44ccqxGUxGG9LZSfAZh65I0eOCf12ds+8RTmAcpBs
 SoQPgZkWEQqFT/IOG3H/IpYmNzTpnbPJcZVdvy7+SvNsHb1zCngu/XIy0HOI+QYSQAoAvww5PUo
 ly8SVUYxdlAx2DiIAjLEKALJrZhoG+JG+olKX8BnrsaB0SMb3KOqOEh767QlTY/vX7hvCmPk7KH
 YR3MLQFUcOV5KN2JZ4RlS4Rhy04S3XlzR1+qez05fRTtneKTnTx4RZnZlTPWn/MPj8yAYq/TrJT
 H/43jhMQF4kbx/Pf04rdSzrCqjXlw09dyST8nXKomyn0wpKRb4qIy2f9wyuzn+FYnzosBQKuay0
 lx4iqmT/yHpIajq7CzyoMS1gGDTrXQCfsxdsq+ajGea+CdRlt8s0BDZj+HkS0zVPqslhpp3FgSX
 HoOC/jWDlJdoIPA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Finally touch the hfpll doc and convert it to yaml, and do some related
changes along the way.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Drop APQ8064/IPQ8064/MSM8960 compatibles (Dmitry)
- Update example to MSM8974 since IPQ8064 is dropped
- Clean up dt binding description (Krzysztof)
- Remove second example in docs (Krzysztof)
- Try to clear up the text and content around deprecating qcom,hfpll
- Link to v1: https://lore.kernel.org/r/20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz

---
Luca Weiss (3):
      dt-bindings: clock: qcom,hfpll: Convert to YAML
      clk: qcom: hfpll: Add QCS404-specific compatible
      arm64: dts: qcom: qcs404: Use qcs404-hfpll compatible for hfpll

 .../devicetree/bindings/clock/qcom,hfpll.txt       | 63 --------------------
 .../devicetree/bindings/clock/qcom,hfpll.yaml      | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  2 +-
 drivers/clk/qcom/hfpll.c                           |  6 +-
 4 files changed, 74 insertions(+), 66 deletions(-)
---
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
change-id: 20231231-hfpll-yaml-9266f012365c

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


