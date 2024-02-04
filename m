Return-Path: <linux-kernel+bounces-51830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A90848FC4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95030284413
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8F2C69A;
	Sun,  4 Feb 2024 17:32:08 +0000 (UTC)
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CB2C691
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067928; cv=none; b=OyZmiFCvLdSHaGiAn55pxgJ9e7KAJkOO9SEjj3/YFwNCikdhuuVIl84uYugikVm1eWFX31nGl5M3WOvFc4aZjRdUInp+Wf3oDOrwFy7ffXUZfseBM3sTODEaxiq5vdPcXwnDNhhnxf65tmInCDDVfRrAUPYyldW54bkkC1/STJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067928; c=relaxed/simple;
	bh=bcNFXOXgVZBEkNCwZd1X9XvtwNPnxgf0ip+0KH9NcyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ARC+aa8hwNZb+Uw5SDNCLkBB3TKMoSMu81kTwvBtunIMrNLql8XVe5y2/XmeYTrO7oiogMJsSrmlOGExShDyMGlEFZUBjojBvggMxE8NpE6e/DLS+jfgAPoj+B12nENl0X7CKQpuHsBlGuy0cccV6a4UGG7mztgNPWolMCNzUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-Book.localdomain (2a02-a420-67-c93f-164f-8aff-fee4-5930.mobile6.kpn.net [IPv6:2a02:a420:67:c93f:164f:8aff:fee4:5930])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D639D3E74E;
	Sun,  4 Feb 2024 18:24:31 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Sun, 04 Feb 2024 18:24:20 +0100
Subject: [PATCH v5] leds: qcom-lpg: Add PM660L configuration and compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-pm660l-lpg-v5-1-2f54d1a0894b@somainline.org>
X-B4-Tracking: v=1; b=H4sIAEPIv2UC/zXMTQ6CMBBA4auQWVsy/QELK+9hXFQdYAhtSYvGh
 HB3GxOX3+K9HTIlpgx9tUOiN2eOoaA5VfCYXBhJ8LMYFCqDCo1YfdviIpZ1FINu7tZpp61BKMG
 aaODPb3a9FQ8perFNidx/ofAsOyWlNbaWbaM7hUIK7xLPoc4vnjcKlxy947BwoDqmEY7jC0BOA
 K6lAAAA
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.12.4

Inherit PM660L PMIC LPG/triled block configuration from downstream
drivers and DT sources, consisting of a triled block with automatic
trickle charge control and source selection, three colored led channels
belonging to the synchronized triled block and one loose PWM channel.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v4:

- Rebased on -next and resolve conflict with removed lpg_remove();
- v4: https://lore.kernel.org/linux-leds/20220719211848.1653920-2-marijn.suijten@somainline.org/
---
 drivers/leds/rgb/leds-qcom-lpg.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 156b73d1f4a2..ab298391f9e0 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1360,6 +1360,23 @@ static int lpg_probe(struct platform_device *pdev)
 	return lpg_add_pwm(lpg);
 }
 
+static const struct lpg_data pm660l_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 49,
+
+	.triled_base = 0xd000,
+	.triled_has_atc_ctl = true,
+	.triled_has_src_sel = true,
+
+	.num_channels = 4,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb100, .triled_mask = BIT(5) },
+		{ .base = 0xb200, .triled_mask = BIT(6) },
+		{ .base = 0xb300, .triled_mask = BIT(7) },
+		{ .base = 0xb400 },
+	},
+};
+
 static const struct lpg_data pm8916_pwm_data = {
 	.num_channels = 1,
 	.channels = (const struct lpg_channel_data[]) {
@@ -1502,6 +1519,7 @@ static const struct lpg_data pmk8550_pwm_data = {
 };
 
 static const struct of_device_id lpg_of_table[] = {
+	{ .compatible = "qcom,pm660l-lpg", .data = &pm660l_lpg_data },
 	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
 	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
 	{ .compatible = "qcom,pm8350c-pwm", .data = &pm8350c_pwm_data },

---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240204-pm660l-lpg-f35b8a3a3840

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>


