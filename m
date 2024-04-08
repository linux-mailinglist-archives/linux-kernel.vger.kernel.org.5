Return-Path: <linux-kernel+bounces-134793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF489B6F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61CD281B39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5225624;
	Mon,  8 Apr 2024 04:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oprSFMRv"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE3749C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550660; cv=none; b=TZ69nQdEnezvBi4NaLFzLF6/EjC46CmVKtyFB/WcBZoAm/ZtAC99eTQZprnN6QzqQCP1FPJlRFc8LmeLKfGS/AgKR4n/3BEhRQH9q7dzAwdzALbCE/9o7X/ohCZAApIabvVE2c7Q/XwMtujcLWu3a2syNoU4SxEKxz/tuAtdjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550660; c=relaxed/simple;
	bh=AiMHop6LtWh5la59tUhjUjvEK/UQiD8uM+1Bb2RGdcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRhe04/qEjdEEALbxcnzwgRRMO2GsMrVsXnsVjSBnYD7B9YOnG22ChzIQopsmBVq4eWbIuFNpvHfGv+yi7ZTfOrLwVZJnCIHPAmrcJN8ORTzA4GprPexri15wSknR9T5cB21wmnRl0xwCYVDZ9M/hwYF33lEjL/XmKr1bV6HOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oprSFMRv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d0162fa1so4637308e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712550655; x=1713155455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWjHFP4FIwQxUWAPVoONDZq/MeuxzTLfwG/YafjPU/Y=;
        b=oprSFMRvTiJHEr15KFMeVH6QzEY8VIK5o6rXJOV9drS8/jr/Gcat7RmxgnQUw0r8f9
         /ZAMr3XUYmuMQT9hkqRvrG0XaLmDchMZq6+d1DwLGF/073mgvM36Fl9lChwudvr7D+yI
         ScKMSgyXvEemCk53MIdRWoAPAobSemwSEW5QMbpxKAV66wIxmxu5wz6fbHzQ1/1KSGtj
         onoBRaExBfQN8PBMRF0oQadN7tmFpvT/ty3cxSxhWMbIqTT/DMGw8lUfiGJKTI5hUB2I
         KgBZVjOuApNDR0nm5GLtNmFKAbI10fakqP/SktnJ7Qzac95mz+2oXsjfQhAz88DUeeIt
         VxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712550655; x=1713155455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWjHFP4FIwQxUWAPVoONDZq/MeuxzTLfwG/YafjPU/Y=;
        b=Ts3te+Nxp91xIiGxtTOyYySFrg6Q/39pe+FztF6k5dNeCLRkkR8x+wYgWQpdD4VAjq
         MilHMhnRfBwdfIoxuSBexblJDjYp794gqMz9OtKzJK3vaZl8hVGkLT5W6KMzXWfpVq72
         my4K1V7nd1DND995aRXWFQBjGXqy9ge52G7HnZVoPAFFuTHxIZtsBZz8n+v6QIOYwRch
         seZdXROJHVDpDR+osbvCDeKIEU154rWb+BQfZ/KzI/HmbXVO+mXhZnHBIU4DTh4+NPp9
         pwQq3glN1WPDT2GXgll/2ZDj4RUDx4WkFRhXgczqjWeqLh51L6k5H/9XnyoyemSFsoUh
         CRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHzUnMLLNpTJiygOiF28XuWwkHvlfYb/QXAJSkAi5A6R6dvnBwKArFPHHgTsljipE7pcx6chGQ3Z/teTy08flb1zZEydYbPADbYVZr
X-Gm-Message-State: AOJu0YyuPJgCyfEUPPh85zeUYFqP0/6CemrQ07s4i9+Flx0GnNlv4Q47
	5j/kD2x3HxE6Au4W/3ixLITw7wxPjHnBxd+ZuRvpCyh+e279LeLiCi+U2AqdLkg=
X-Google-Smtp-Source: AGHT+IFIO6xNYoZfEPFKmXNYH/a6iz/UGLcCNim2Ck9xD7LkNwZBRVFMJ1PDf5p1BbUMWec2ZXfO4A==
X-Received: by 2002:a19:644e:0:b0:513:aef9:7159 with SMTP id b14-20020a19644e000000b00513aef97159mr5407151lfj.39.1712550655691;
        Sun, 07 Apr 2024 21:30:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g13-20020ac2538d000000b005132f12ee7asm1033207lfh.174.2024.04.07.21.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 21:30:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 07:30:52 +0300
Subject: [PATCH 4/5] usb: typec: ucsi: make it orientation-aware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-ucsi-orient-aware-v1-4-95a74a163a10@linaro.org>
References: <20240408-ucsi-orient-aware-v1-0-95a74a163a10@linaro.org>
In-Reply-To: <20240408-ucsi-orient-aware-v1-0-95a74a163a10@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AiMHop6LtWh5la59tUhjUjvEK/UQiD8uM+1Bb2RGdcc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE3L7IPs4Dy2cixnuxh6PbWMygAc34bJSsBTiS
 g87Qu8asz6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNy+wAKCRCLPIo+Aiko
 1Wx+B/wL9D5rVVtyDGr8tJVBflDFYn+l/8QkHU+8lO8IayWT9KG+uOtsC1LnOmRspt6imRaDueZ
 JhbpbaOf6eL12HEDTo1MdSVR17h7wlk2hOaR4eBhVmbHocM50U7svsxLYiQ3GQFIQc7z+fBZJLk
 R7rf5B/Jt3TmYSG/ccUI4k6N8fK3QBLZJNPypICKqxXJmSjiol0fTJV+fH01FioNAA/f+YtFUnW
 mbzFsQid+kMnK7VL3ETL8JrCDzX8BciHnn4feM+b+h+d4bY1RurXYkwXX8lKLz6WV7eyEiydsJg
 Hp6tpehb5SQJcETvzry2zv3gtbe5SA3MGnxwc7QNWKIOQbFr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The UCSI 1.0 is not orientation aware. Only UCSI 2.0 has added
orientation status to GET_CONNECTOR_STATUS data. However the glue code
can be able to detect cable orientation on its own (and report it via
corresponding typec API). Add a flag to let UCSI mark registered ports
as orientation aware.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 ++
 drivers/usb/typec/ucsi/ucsi.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7ad544c968e4..6f5adc335980 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1551,6 +1551,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 	cap->svdm_version = SVDM_VER_2_0;
 	cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
 
+	cap->orientation_aware = !!(ucsi->quirks & UCSI_ORIENTATION_AWARE);
+
 	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_AUDIO_ACCESSORY)
 		*accessory++ = TYPEC_ACCESSORY_AUDIO;
 	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_DEBUG_ACCESSORY)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 6599fbd09bee..e92be45e4c1c 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -410,6 +410,7 @@ struct ucsi {
 	unsigned long quirks;
 #define UCSI_NO_PARTNER_PDOS	BIT(0)	/* Don't read partner's PDOs */
 #define UCSI_DELAY_DEVICE_PDOS	BIT(1)	/* Reading PDOs fails until the parter is in PD mode */
+#define UCSI_ORIENTATION_AWARE	BIT(2)	/* UCSI is orientation aware */
 };
 
 #define UCSI_MAX_SVID		5

-- 
2.39.2


