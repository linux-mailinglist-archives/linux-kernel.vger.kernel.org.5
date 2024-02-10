Return-Path: <linux-kernel+bounces-60466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B9850550
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6F41C23777
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186355D473;
	Sat, 10 Feb 2024 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="CgxKQ30o"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04785C5E2;
	Sat, 10 Feb 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583152; cv=none; b=OcZVqeEqTRt0r8Ll4J0zPzxSborW6LG6h9+qidpC459ylqR31yn3pQkNbqBXkBffJr4nznoWGkydwKySyFql0jJoPqwUOGYfkVEsoKJi+o9jtNeejQ1/0qcUmYd5P3E6JkJOIhdHjEyMzxqQ2awixcutIps62PIRtr1Ozq2LUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583152; c=relaxed/simple;
	bh=kgvAMPhT8w4j+/gc16d5E4a3wb/jg9/T4SXRJTUDi/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bq9X0pHZF48YLb18pm3J/png4c0E24nqTP7Lg5FBzcs2f4Jc95l1HlcdNgJzkwieXXmHAxk9kgunQ7KJocIYG2uZx93Pu8v3GmM4o0KJA3dNNMVt86BG1gV8j4yxx41rn5gJZcOGdpWIu08E334/gWfRdLGKGbKIzuCsK9skebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=CgxKQ30o; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707583149; bh=kgvAMPhT8w4j+/gc16d5E4a3wb/jg9/T4SXRJTUDi/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CgxKQ30odRg8weEpgShVBLYP2myEEzO0LFQW8np5WbrvsfZPg0LsDVWmhvPjFLIey
	 2FFTyZRsFov5t+Y+qIO0R67gjt+AiweEB2utwcpK2kMvfxWDExKle8uaKsieuBERUg
	 Xnf9QhC+9faQ+p/qylCSXkY/iMoCwxsALMk70TIo=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 17:38:58 +0100
Subject: [PATCH v2 3/3] pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084 power
 domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8974-rpmpd-v2-3-595e2ff80ea1@z3ntu.xyz>
References: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
In-Reply-To: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=kgvAMPhT8w4j+/gc16d5E4a3wb/jg9/T4SXRJTUDi/w=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6aphrHa+N0dggsH13/iZNAuwr08JNoIsdJ0+
 MYyk3kOGuKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcemqQAKCRBy2EO4nU3X
 VsHvEACk8q50ApttO6yx3gj3K6363npqMfi182GoUl1z8hdZcNwDoc/gBRE5IHfFWKcg2eU2RW9
 6pZG9058GoQ6D+sDdmVdMKLV3821H+GrkHSJ4KLxNw0Wxoz51vIpsDNmNzVNgcGQMVVbB+VXp04
 9DMZCSFP5+GbRXWeKu8OsjgLNEe4HuZ+50HJ+7EZRYxzXF1E61h/HeGnd51QNdAGil2ve9GoAoc
 kYyhGsp28NIB1+gOAxIGt8gLlMFxKtHwb0/+wCjU2WbRXfbOrepFr5jK5bbtBckZGMqeMDP8zru
 1Jt/umoD1up6rRIPZRvJuuLTu9WR3A0UKD+61LSfzHVnWgFWidBceC20KwMGvYs8PfVJLV/jAZK
 3iuwkmXmdlybBS5MpEq5d2XxslU971o7FrPF6o8f47xcb8w4Q+I1lyWn0qRtCJ9HYY/2jwJDIeK
 ZhTsVzNsHXdYXfE3i+hcwp8Ku2sHLL5VpKlp4Cl8CXgyT7CEu57LqORHrW/8zjJAJU10N48hGg+
 y07v/WsIO0q4eTwWsb1N+luHYKyW1vvra+/GFsPTPRLKYwNIT+nze6iSiXD3wb9auvi7MXInnnN
 ZxWb0Wf4ZNhoVNfMkN9hx86XFf2jwWnO5EsVTflccQEb2akEJkblePELsqNs3OOiWD2LN040IwX
 gkUXmLj5pt4joVw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the power domains CX & GFX found on MSM8974 devices that use PMA8084
instead of the standard PM8841+PM8941 combo.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pmdomain/qcom/rpmpd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 3fa6a0325fc0..2d47e3357f10 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -252,6 +252,20 @@ static struct rpmpd cx_s2b_vfc = {
 };
 
 /* G(F)X */
+static struct rpmpd gfx_s7a_corner = {
+	.pd = { .name = "gfx", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd gfx_s7a_vfc = {
+	.pd = { .name = "gfx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_FLOOR_CORNER,
+};
+
 static struct rpmpd gfx_s2b_corner = {
 	.pd = { .name = "gfx", },
 	.res_type = RPMPD_SMPB,
@@ -716,6 +730,20 @@ static const struct rpmpd_desc msm8974_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
+static struct rpmpd *msm8974pro_pma8084_rpmpds[] = {
+	[MSM8974_VDDCX] =	&cx_s2a_corner,
+	[MSM8974_VDDCX_AO] =	&cx_s2a_corner_ao,
+	[MSM8974_VDDCX_VFC] =	&cx_s2a_vfc,
+	[MSM8974_VDDGFX] =	&gfx_s7a_corner,
+	[MSM8974_VDDGFX_VFC] =	&gfx_s7a_vfc,
+};
+
+static const struct rpmpd_desc msm8974pro_pma8084_desc = {
+	.rpmpds = msm8974pro_pma8084_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8974pro_pma8084_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&cx_s2a_lvl,
 	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
@@ -910,6 +938,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8953-rpmpd", .data = &msm8953_desc },
 	{ .compatible = "qcom,msm8974-rpmpd", .data = &msm8974_desc },
+	{ .compatible = "qcom,msm8974pro-pma8084-rpmpd", .data = &msm8974pro_pma8084_desc },
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
 	{ .compatible = "qcom,msm8994-rpmpd", .data = &msm8994_desc },
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },

-- 
2.43.0


