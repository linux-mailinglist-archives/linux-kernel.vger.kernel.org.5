Return-Path: <linux-kernel+bounces-71908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3304F85AC5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28E2B228CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115C54BFB;
	Mon, 19 Feb 2024 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="OdT28Q8r"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB095464A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372064; cv=none; b=Q6ujoXsJQdaYeIZ6Meb1v7gTCgBRM26v/8n0NGD9dL/VCxGmQJ8S5ryweuJjtAMtwLPytXtnjHzr/IQ0dRQL9uHCos/uRuRn+yACyGg7iNO0fF4qo1WBmfYglQPVi7ukdMY2cMnYgdpZ2V0xG7Up6+ovWJ5GyP0dboAVOyfuhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372064; c=relaxed/simple;
	bh=E0gu0dftav8MaXjX+7OAo3ktmwiz3PI/6cLVfZ9kBDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JbrgARKjmScr3KEPYhyIf7TLqXpUmoou5IlgVAWiNBeQAu5he7miEl4qhpUhQ3GVyM+cz6TRl+7sbCkisls4pRIXCju0OnnwG/QtSCyRwa4o23eQiPbDj4C550PCyh/R7SGSkQhAwCuop3lAzZgmQmAfNogH0KLdqYnBRg3i/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=OdT28Q8r; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d934c8f8f7so44745115ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372062; x=1708976862;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+1K1rDAoLT3yvvcU1xTbjvAZD33p95do2MZR1pqzhU=;
        b=UEx8CSDe9JKCD2hXElr0271tMOclwvQ3mM897Zhu9YEcCxZCeMdPOlEs+pslkKOdda
         Ta+UFA9uUrqmSldTBbL2Vb4Cx1pQR0Q2YOLJwkJX2GmYJq4nIy1xqgK5gfypb9IZ0Sk8
         xhDvFTZ1JuKVeRpbIWmwwm0bMIIyYs6r/CR9dNj9EBRqOs/vYOICbiFLi1VNT86pO8mL
         /zk6i8GBIHT1RqdrglTA/135i+O7gQVufUa4iYkZIBISpzUO/OBPanDifeIj4//cr/Dk
         qaWp7nEMDcLbt4JKE05jEJIWEenMNrzbP3e2wagxBdVVd2JOykqQK7H2CfzjnHpTiBQr
         Aj6g==
X-Forwarded-Encrypted: i=1; AJvYcCWVnRUOwZpS2OJA2PnscoQF5hBD3OMc4vhXUigU4yThdxU0y/JKMuYymEXWuCFvRmiEQ8tvmVCPKeS30CwEIrm/4Bgwkre27YBC58y9
X-Gm-Message-State: AOJu0YxHtOFZq6pMEiGt6z/SxL6f7lxXsFSyqJRSgGg6Hvgw8i2qVqSS
	/7DF7b+bJCs0Q3kyXvM5lHU9YWzfWchAnSmh65p+t/FbGang2mwZ
X-Google-Smtp-Source: AGHT+IFLdoebQIS/JcbaR+WTW0StOHvz1lg/dtXrJusjwcgDG/iiyXXo8Mi0KYUwCxIZnHDolT/HyA==
X-Received: by 2002:a17:902:c246:b0:1db:d256:932d with SMTP id 6-20020a170902c24600b001dbd256932dmr5196936plg.10.1708372062528;
        Mon, 19 Feb 2024 11:47:42 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090331d000b001d9773a1993sm4772917ple.213.2024.02.19.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:47:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708372061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+1K1rDAoLT3yvvcU1xTbjvAZD33p95do2MZR1pqzhU=;
	b=OdT28Q8rBK4R7VC1plQYbox3WZs33fwXo+7EeigrLboYI08hmVA/URzu0izOoSnjtPWxbD
	xGcaHv36+cCtT+fSpMLvGA5i7vnW4QHy7By+GrlhIZreP3TRFxnn4LcisGZnUvtW/jRC1x
	xAORX9gyynsmvqK/0Xi3DU+m9W/W0mNA9fZOKwoevXkabVQa4iaJ2kX/9LmGtgOoEC64U0
	Buq5kDil4WWppoQ6KO4qZ3//q3l/v4XrAQaoKlnA4MWz2XEP88g2zC2fezrd+d84syh1G1
	Lkqvh0FbzwXRY7yh1BSDwJ9UNmS+sbfEc0dRmo0jfCgj+0O/gqhae1CBm8zGlQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 16:48:28 -0300
Subject: [PATCH] accel: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-accel-v1-1-5031e5046cff@marliere.net>
X-B4-Tracking: v=1; b=H4sIAIuw02UC/x2MQQqAIBAAvxJ7TlDrYl+JCFvXWhATpQjCvycdB
 2bmhUKZqcDUvZDp5sJnbKD6DvCwcSfBrjFoqUeplRGuSUgrBrLxSsIiUhDWGOlw2PyGClqaMnl
 +/u281PoBgY4uiWYAAAA=
To: Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=E0gu0dftav8MaXjX+7OAo3ktmwiz3PI/6cLVfZ9kBDM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl07CMzkpkFXTFG76NJv+ATsU02RkTl3tfEbF2q
 nEqfBlPSjOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdOwjAAKCRDJC4p8Y4ZY
 ph33D/9ue3+Q6/AEYZ8oe7dOzJSV9lsxOuLRgBPtR22qxrIICYQHPY8LGmiQCsURaP4Eqce30P8
 GOyP9QkMkvJpdi1liki9/kNAJDSal5cH8ZhjSzl3o88ZWPROoKDR0Qa4r88qQMPF52EPoTfW1RZ
 pRRnh4leiPk5APBIw52MKjDsH1g9A5ZY95WieSUhA9gsxJ7XuVvdE2kW4SwyyFHhLEZ6SZVLtXN
 p5WjubxnK8qHoHvYtY/2tMZCOz2A4Ku5jRoeYOSuIEhS3i79HN16Jsf/6nf/i2OGi6F/ehp4DoU
 ePE7ja2Pmm/OmzQlHJd5uKqDuo/nwvtL/LXLsdu4s/NVP9gvIZkWgFhl+UND7M9hsD3VNNtJkj0
 p77aDr2p82Ey7ITJd8F9ZxrkhdATf1hger/00R55IcOQ3Had8PkSIrdkkdud7mJdaupkzhTR2Ti
 VQSBuVDmIdzzlBGovKzZAuODskhmlkS1t5fjuJDp3WyAvSV65J3sIoGiiHM+9B1fqMP90fxtbGB
 Wp+bTfWX28zeizLGfBcRlT9UFs8R1VnVJTcDGUWKmmQUuHIq/BaqzxoMMNDi7uJ3KHrXVoOqmsx
 P8Ob/mkZDKVzVVsP2lLNXG8MKj8pnvna2g7HvjhQVeJ+zYKFIE+P/dGfJRdKnGB7tlp0RMWzOa9
 VabkXivaMdt4Ehg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
accel_sysfs_device_minor variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/accel/drm_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index 24cac4c0274b..16c3edb8c46e 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -23,7 +23,7 @@ static struct idr accel_minors_idr;
 
 static struct dentry *accel_debugfs_root;
 
-static struct device_type accel_sysfs_device_minor = {
+static const struct device_type accel_sysfs_device_minor = {
 	.name = "accel_minor"
 };
 

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-accel-a990dc3bfbc1

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


