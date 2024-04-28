Return-Path: <linux-kernel+bounces-161559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C38B4DB0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464021C20972
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F274C07;
	Sun, 28 Apr 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="wYuP1pvI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6976029
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714333464; cv=none; b=R+PoUDQT2VUDpzos+InJrxlG0gN6+aMijmC5azzRKlh5V2hkTwsPGwI8BHJ7vsu4E1ZXwLN6Q1s5y/q7IBsxL7qRQm+Jr693Z9gfqOtuggoZylni9l/6YrsDeUmC+VRf6WPa90cU0rYvixLTrrXwm+EsIAgWu+TyxcMZZftvFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714333464; c=relaxed/simple;
	bh=zS4AnXDB56TofFf+N5bD9jOi5VXP4GDvHtyvSbjX1cE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+kLegPYY2AI0DweH+5aiu0W3ALGPWt2HG2tQyRhePKR2bpn5/L0cHbBXcL4FzjqVEGL4e4UvRp+U34+Kkc4CVJlfH19YmufrqY0wMTlK1Vmpmf0i5AWWEvl8JsqbyxxzWk08YAKjdDIw0v7htvpEi1H5il8To+47CsMAXDKwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=wYuP1pvI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3ff14f249so28401705ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714333461; x=1714938261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ABjwBx02udN5kYF+DG5k19J/UsOSoScqfXThrVpOhI=;
        b=wYuP1pvIj4PQUuoddb1BiVK5jKf60pUY5xQv35eZbateorfTCTdPbEwchiONnAjbuP
         DlHrLOeqGxlbioKQ8tVP6WtQNl61aztk5dfB6VrFBe9HR79d4ed/OT7wBo2YX4kVfnmP
         YgUQveDgf4dWFCQs0bsh1Zoj+iplG0jDZQwixTUWBpZHVaLoY0n4IATaVNqkNnNHVEFd
         X81AiW7nq0VE6SHa5xMn6PmV09aaDp4/CjEibVglUszM8LT3rsN3UgalupFoKiEeec6n
         bV6BKl8A1uppsuz+ikAHI8dKIqVnxVfpmucvylziLlQI+qRVvHLWIuNPUlTNAV1JgZE6
         x7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714333461; x=1714938261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ABjwBx02udN5kYF+DG5k19J/UsOSoScqfXThrVpOhI=;
        b=s5jDfd+v/HdIOgKa40S8BvcknJoqz/MBO9IBUrL0OT8UErYtTnvwejIMcMamqBT360
         7+oL0Ggj+0juuM0nCWX/uno9+B8Tip3al9rcsw3r3+PKwLVoOumBXY/3IsjPKqX5Fl1+
         KYjORTrKjL3Hhq//6bgIlpp0slZZEez2q83eEXFACUmsk73XC4U7CI+8LmKWu10RSQqA
         HC18vY9aQ3EAN02opbxLZhRy4WDjd8kYVUF65dURrD8j9K0eT2i0ZHCBl1YxHC+cEs3U
         f63+mWCDtheUia/+M8BZuZeFjj1vlsa0FPMS7IkpbjuuqJBXp74bxf+n690KqsVQLVPR
         IkRg==
X-Forwarded-Encrypted: i=1; AJvYcCUPn0kP5IJEyB88K0iSZ9rUPs/6vFKG0C9jb3LB8JMSAirtRxc4Ny9bGq0GJYVxv1kkoK+PBu6gJfeqe4i39J676QAwubVfL/ESfSi+
X-Gm-Message-State: AOJu0YyKlA24yRR2sRi0m2z0H5D6BKFezghVyVneU0LWdN848uX3ghMt
	B/KWuTxWY+XRMgti9hLgNNCew0jpoEyDWhCPNPqDlq+zNsBnKP9SBma6BlnHTZI=
X-Google-Smtp-Source: AGHT+IHN7fVBjs1dCCI0J5AyCaBYr3UpWc7xNEBjnoK+wy0S2i1lnqBxYpDA2nrlp1Vrr7RgpoRaHw==
X-Received: by 2002:a17:903:32c7:b0:1e8:682b:7f67 with SMTP id i7-20020a17090332c700b001e8682b7f67mr11057040plr.29.1714333461475;
        Sun, 28 Apr 2024 12:44:21 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:a3f3:f05c:11d1:1d76])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b001e45b3539dbsm18826374plh.41.2024.04.28.12.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:44:20 -0700 (PDT)
From: ogustavo@usp.br
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo Rodrigues <ogustavo@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bruna Lopes <brunaafl@usp.br>
Subject: [PATCH 3/3] iio: adc: ad799x: Prefer to use octal permission 
Date: Sun, 28 Apr 2024 16:43:26 -0300
Message-Id: <20240428194326.2836387-4-ogustavo@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428194326.2836387-1-ogustavo@usp.br>
References: <20240428194326.2836387-1-ogustavo@usp.br>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Rodrigues <ogustavo@usp.br>

Octal permissions are preferred over the symbolics ones
for readbility. This ceases warning message pointed by checkpatch.

Co-developed-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Gustavo Rodrigues <ogustavo@usp.br>
---
 drivers/iio/adc/ad799x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 9a12e562c259..0f0dcd9ca6b6 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -524,7 +524,7 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAMP_FREQ(0644,
 			      ad799x_read_frequency,
 			      ad799x_write_frequency);
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488 244 0");
-- 
2.34.1


