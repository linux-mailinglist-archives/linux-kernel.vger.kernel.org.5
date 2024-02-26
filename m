Return-Path: <linux-kernel+bounces-81234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD386725F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086571C262BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421061CFA0;
	Mon, 26 Feb 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb2rg0g4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DC1CD0C;
	Mon, 26 Feb 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945093; cv=none; b=iVU0ExR2VuZbfHqI0o/GiYEAIdALk+8L8FgyKzMS1P6Dy/QoPFG+WV9+SgzkmMbRAZyVIkfPnUce/muyf93rhDs8dyCnS7ff6CKfXu3WtEs3D55J1YG4GRTDfVtqkWwk0o+Za3A3Mb726cVRVvEX28Fd7XDu6XQRwLJdHkdI8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945093; c=relaxed/simple;
	bh=+M/IcrkC4KiqVSgKEfF4MEPWWH07B+P/vlCcnh7YeNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcnWxYICDM4YTAbS0S7JvIjkPo1+fKegRixFEo5WqxVzv/Sj+3c7bWJKjvXPy//NVK7iMNtfkfCqE6v1+iGAyc6SfNX7luSFZ2nS2tKVH+WDyhc+CpVxBHQoMRehcPYHXXEcfCfqynGxsX1DS8rFsf96U8MpFIMw37+zI8OR3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb2rg0g4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2823397a12.3;
        Mon, 26 Feb 2024 02:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708945090; x=1709549890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpglvbug8B6rz9FHKHRWvwGpjAjoa19+rytvw+mL+G8=;
        b=Nb2rg0g47TxtWTRp+xwiGcZChBALbmlu6u9bSrhXbkb7gAVW2ZlL5O/3V0IOJm8OHR
         4dvi3cxrO6v2wPdkFODBd2VOBqS1++JsMyKHApeBCD5628dsIdxEalZSclEwiIlj0pIk
         vZDM9AKmLM9YKSJFrTdrwZGSNTzXwV04yAjQaXEq9ALE2CdquiNZs/Fgvl/nOP0QR22p
         EtVKIpYowHzpYhKhZtZoySh8sT4Xnxy3d72sAE+Il+FTXa0vnYmblPsN2D+OxNKfSeel
         AfYYeVPbl7XuSzygDNYdd4Lh3YjWOaeYmgPKia/B5jnvSvrNF7Z4lWbPp/5dtdII5PuO
         VDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945090; x=1709549890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpglvbug8B6rz9FHKHRWvwGpjAjoa19+rytvw+mL+G8=;
        b=u72Uv+C7NRW1/R+dzdQbW3sEiivOOm5HirzSgdJ7AizKXhXwGD6DfcPxoiTQMMD1Y3
         kjLl79HpP6sqr8945cw9Bt+XdZnmE+ahFFMy01KF4lddseNv2iYLayUFSVFYi4oIrkV5
         h5r0v6SZ/CabwbpUCkFmk40Xt1jThfDGAVekpi6910dagpNC9TfvTsys2goc+o2jb7q6
         4RqUA6aFF428I5b1+fnmVLAoeuTk0hAO4P3DBMIMAnQRrvEkTVED5os0Gj/vvc3MnHwM
         bY6Z7lFz2XgPSFf+YLHuotdQn8RGk85UEvrmmuHTZGLOM7q2DtW3zC18f7mzxK0J3HmD
         i0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiA+ovq2zxcSlUGNGxYZY8Ho715VdxmIC++EpIoxZPStUr03X2ABAgm9nALBG8AIlAeoq102kzo9XEgxU8Wo2RwdlaRzmlGByZzWXYju8oy6/TzYALFLX/3WOgct4nonX21s6hSQioTIURlsJ3zBPIouVUSsZcTuqQ2qLKfnhc1AyRjX90aMAkWP8NyLV8pF3kOO8GUXeozlUK1tK/61SO1r2p
X-Gm-Message-State: AOJu0Yx1pl7mfuWk0It7jMJw/yLfPU78evgV1T0pzb6xCi4nGlWxwoC+
	kbtU3+Hrn78cbMClOU25p8LPsoJEkiDq3z3aXoA9C7OF8szRFpLOPH5WW69CaW0=
X-Google-Smtp-Source: AGHT+IHlLHZm/lD5o0ODr2jph5YVCXmo4l+6pEuWoFbGcmWuhZ7+htWa73xP6x7O+DkYRUE1lW866g==
X-Received: by 2002:a17:906:ce5b:b0:a3e:cb18:d4f with SMTP id se27-20020a170906ce5b00b00a3ecb180d4fmr3911722ejb.30.1708945090018;
        Mon, 26 Feb 2024 02:58:10 -0800 (PST)
Received: from unknown.netbird.cloud (net-93-65-126-20.cust.vodafonedsl.it. [93.65.126.20])
        by smtp.googlemail.com with ESMTPSA id f19-20020a170906085300b00a3fce8c0f99sm2315769ejd.191.2024.02.26.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:58:09 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 1/3] leds: qcom-lpg: Add support for PMI8950 PWM
Date: Mon, 26 Feb 2024 11:57:45 +0100
Message-ID: <20240226105747.3547856-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
References: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMI8950 PMIC contains 1 PWM channel

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 6bdc5b923f98..9467c796bd04 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1693,6 +1693,13 @@ static const struct lpg_data pm8941_lpg_data = {
 	},
 };
 
+static const struct lpg_data pmi8950_pwm_data = {
+	.num_channels = 1,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb000 },
+	},
+};
+
 static const struct lpg_data pm8994_lpg_data = {
 	.lut_base = 0xb000,
 	.lut_size = 64,
@@ -1819,6 +1826,7 @@ static const struct of_device_id lpg_of_table[] = {
 	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
 	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
 	{ .compatible = "qcom,pmi632-lpg", .data = &pmi632_lpg_data },
+	{ .compatible = "qcom,pmi8950-pwm", .data = &pmi8950_pwm_data },
 	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
 	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
 	{ .compatible = "qcom,pmc8180c-lpg", .data = &pm8150l_lpg_data },
-- 
2.44.0


