Return-Path: <linux-kernel+bounces-51886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A1849069
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A91F2261E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209828688;
	Sun,  4 Feb 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="o9tAHW6B"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01825565
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079093; cv=none; b=GcrbOg57xsydtFW83yVGU5ivxTr0dGCGbjwTdIueu/InUv0alV0jiehycMBRO8M/7F5E6wFeSmTcoPHiZNY80p8SZXDXBEwLo8q1zBXuc4mv9H91SoJYAZLhXj3YcwsUmxyNeVLzd8QCAQUPWkyqdjQoe8uQhB095U6ALTK7RbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079093; c=relaxed/simple;
	bh=crzzemKhKFyKEZG1/v9apAb5yG6nsda4zTmCoC48RIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pih0prjiGKvNQUcAxKYxDA8UeQ13TnwXvm7PAtKliOpVCe3kG21g51IHnLVQsW5EmtcwAWFOSV/aS+CQv9luwsgznUZo1erPW8jolJ9Db+L6yW+atPoGqRhHVxeoiUMAo0QgkPaPVccLyZgT69tQQCGP/fEFyhZha3uTK/6dgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=o9tAHW6B reason="key not found in DNS"; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a7a6a24b1so1696463eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079090; x=1707683890;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4kmeZPj47a/98kBgJHVi456QZSx8c5mPDnBerE2N2w=;
        b=h7gqLzATLiuyttkVp/cPW3RHttKjbeAKccxpmeHInt/gQsaPUxP5fq7TwJwKudyejj
         AHj4l25iC5LaPvf5S7CzqwvGyLpsZ9+kPkiYxR5+oj1H17wBrIWmRq1KYhEgnCLb25PT
         FWpFmUFeeXUNNej7DP3k8ebsADdkqqZmungVy951MMA27/MDR5o8BEHviGHqPL9YJUXP
         PdjYpujxxS2RHwaBiwXaoAmVVqQ6ek2J06WXErDyumHp7qTvBsS/SM+2YxO73VNo+Zqf
         04n+u9RmIVJheBY6Y0IvbU5GidUeSpyW86kjMjuYIff3Xm1PWNV4sk5dzBB+ttv0F7aT
         lLaw==
X-Gm-Message-State: AOJu0Yz7dNCThBjfuau5Sm/RShpafXVx43i0+hYfb4TaI8LCo8m1AzRV
	La7B3K9Hx8sNnS1xFnuRcQXZaPKFMUtEHKyqJ153UtA5hbRr0h65
X-Google-Smtp-Source: AGHT+IFTujHUzgxsx8LP/RvtLFmSKBc8twTqLTqW3InSQLDFnB2wBiU609Q/koRfN6Vj5rBgqf+EQw==
X-Received: by 2002:a05:6358:2489:b0:176:805c:60a3 with SMTP id m9-20020a056358248900b00176805c60a3mr14633882rwc.11.1707079089307;
        Sun, 04 Feb 2024 12:38:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdF8H9KTPHflV4EQOBItn+3DUWrLR3Ts1em04p9K1Of0g1iHLNbxw+OEEmhN2LicsdR9uFpwr8qaOOugsv8sisX3m7JZQMUQtdMg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q26-20020a631f5a000000b005b7dd356f75sm5540911pgm.32.2024.02.04.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:38:08 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707079087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/4kmeZPj47a/98kBgJHVi456QZSx8c5mPDnBerE2N2w=;
	b=o9tAHW6B+KAz2z+eapEocaTWILLyu8eAyWUt2cbtsHOk5Jh2k+1leEoC1E7WdjGqScZX1e
	2R/52J+U+1OKaA1p78yeR3mOKZAyYWRKOwkMVxalvfEDJvXHBmg/o0Lk4p77Q3sbMMOXx0
	QoYfx9YKfK0uBjkpjf67Q4T3yuxsbeGWKitmHzEWLFNnlG3enu6RTsGWc9wx/LMirQp7qm
	CKYA2XcmAR8CxWc3dTizTWxQsEPH6jKTJhMpdINvpSpJJHAJ9NzJ1o5vmz9tjfFXLWX6YB
	W8BkGjhHoC7I6yOif+Z+Wm7UavumLyIY89vclNfX/tiRXcQNSgMKjakoIoMpig==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:38:38 -0300
Subject: [PATCH] spmi: make spmi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-spmi-v1-1-ef7f278f1987@marliere.net>
X-B4-Tracking: v=1; b=H4sIAM31v2UC/x3MQQqAIBBA0avErBPMRKGrRITZWANl4lAE0d2Tl
 m/x/wOMmZChqx7IeBHTEQuaugK/urigoLkYlFRaKqnFdPLoN3TxTILTTsKjC9Ya3RrTQslSxkD
 3v+yH9/0AaQXtC2IAAAA=
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=crzzemKhKFyKEZG1/v9apAb5yG6nsda4zTmCoC48RIA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/XOqRfAldrt5kSjNRVTxJIw/Oi87sYUyRLX9
 2QuIqLNv/eJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/1zgAKCRDJC4p8Y4ZY
 pi2lEACgVXq9QqdHXr6N9ezq3+snhkDRFC0/DMR+4PZO1IsHyFdIaCiQs+dDsZPHOQu3Nl/uX9f
 mcPMWQDO66v0qJLz0UdpFm8YIilLq3Z/vVM0DaqoG4ZN8e2BEB2eYLl8FXlCJTzwMiPSxS320rK
 hZq0Tay4XkJ70Q4BmppY0sxoV8C2Nv0WRTWqA0xe72Czrq50IepKl0Fnv5HI+Z6Mbk3Qr4nn8MJ
 EKEORuppPXQQ8K4pU3oZIVLPch/hmCWinXJ6si6jBc8G4+NRPsfgEDm2dspmAKKNi+qsPRhmv+u
 7+T0SXm0tK97KRCzn2IZmZS7eYiQnWxooe+AGTXG7JvmSHNCBUqbxBm48kudbvIvT1GhOQ3ToRk
 XCMsV0UwrNgnUN7vA8FBEripUgnQR7/6WGaFdKXDK+nIDJjcc0kKTdC7qVOQiPGlcX+B+z9BrVl
 82gD8uEg3mvRzLKt7l9qwGnxF6XA5OuqA68F5+p+Me3xTJDqf71Rm9+riYGQpRTxpccq5s9XNHE
 sy/fyDlongBlE8BnhCW3rk9EhLViAK0Jvs+y2EWrZgwf/bovUaNInr1/xSjoSpdiMdiGPcJ1xEC
 9RgO0xMDy7oaHy0h5lw5L6SgIQbksa9UM+FCBcaD2gZony4OdpE5Kqa7ZHXvkHqDegNerfPKH0g
 fj1dia2D2zewOrw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the spmi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/spmi/spmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 93cd4a34debc..401712726383 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -378,7 +378,7 @@ static int spmi_drv_uevent(const struct device *dev, struct kobj_uevent_env *env
 	return 0;
 }
 
-static struct bus_type spmi_bus_type = {
+static const struct bus_type spmi_bus_type = {
 	.name		= "spmi",
 	.match		= spmi_device_match,
 	.probe		= spmi_drv_probe,

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20240204-bus_cleanup-spmi-ceaf77643663

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


