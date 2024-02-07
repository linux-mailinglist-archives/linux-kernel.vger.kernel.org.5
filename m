Return-Path: <linux-kernel+bounces-57063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E8584D392
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC841F27B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C8129A76;
	Wed,  7 Feb 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoKHhr7n"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F112838C;
	Wed,  7 Feb 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340636; cv=none; b=JMkty4ilNBs05Z8klKzAxxhuCGsmr5StDCLKl6kZHoIHe0f4rKSsH4bsvcBxtiqcq4QD2ciW5KLPPNgbLBBWpOGCyBKg55PWmNrP7mVDxDFUyoiKc22dgOwm6AaarWIrl8NLwE570isJL5V8KfMlpuax5FsNIi9U0LZI26qA7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340636; c=relaxed/simple;
	bh=kR8W6XaSITp6FtKm662SPQ78CZF78Rrgzk4MuYq0O+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoynvQoVdDRX+EqTK8wLdHzyob3IEHjgQ1DYtxCrmDlflvE07pbigMlrfiKyZ8+qyGFuJX1TfarCCtVNnPDaaEJkDRM7Uw1j+V9GWX4gJOYgw3xD1XZPKYgTYi1mO13HbCHFEVpAEE5fz6XLOw4tDVU+9OXunstnKkqceyMgfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoKHhr7n; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso480055a12.1;
        Wed, 07 Feb 2024 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707340633; x=1707945433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgfzTVksahqxWw0KuisYDJC38lg+Vl3GjMkmu7mWaIo=;
        b=hoKHhr7n0Wf76amYpGbMnzjj90asgYO4W5LZWNTdLZWRYW+gfMbdO+kqOJQByR++cr
         mclUkGpfcm+HXMM5bGQXufYDnfx8uiO+auG/GXrCUwfb0i4inHl7CuGetpsJlIOsRffv
         9fcr9sNn3G36eMpbEYZ2pvAq57SL27OdL38e8WMYw63v5+Plct43TK54+NxwFl8itdY7
         GW7d6IH3fi9FY/sP5rTFcRJt113zLfkoea/6BJe7zTPFaE/o+DYjqPHadK31Y44ubgjM
         6sKOj4hzo+Q2GlsVVMoqlIC4GF5NgrYmkF1QSAjepo/aXkzIdARAwgH26vBfkNBi/O90
         b1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340633; x=1707945433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgfzTVksahqxWw0KuisYDJC38lg+Vl3GjMkmu7mWaIo=;
        b=u2dx4fFjYgYxzT2u05LIWBJS8ZRqfN2IUBlNWGcdo+zIzSa7zoTT74vNdcnGVXHcxp
         P9j0d+4/zX4s4iwRseqA7K8jF0hwdGKvnxtdzaYSPQfbMuiXljX0KQrWvD1PSIsOCrGU
         eofeOGVXO22PslmMvz3XM3vf+HRYDIuEYZBunCInYLVO9A0CdUpHaZ0bqEFgims2CFvG
         PwBpSFK8sA3cVbRHaLGXVBdMvKmZtW7WbKBLjZKvzEtsnZ5e1iSIvoGjMqoYcla5BKl9
         f5cWj9PCs5A4Z6Dai64gMd7dlFoeGCAj0UVpeC6PQ0Q0idWCkM/sY4ug5fJywD8DVPoS
         hT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3HezlKXkzI51TdRjcsYvnfkYhukZABygFH5R4sSDynIKEsNyzd0J2FZNKkm0kcb1+9nnePDXVzcCctULbrYlYeVQniwb5ApYK5HvA
X-Gm-Message-State: AOJu0Yyan/ifWlRwhyHrk8qLpDUVqjoFXVP+HeuriA+q97oc6eywUFgC
	Y/zqOqUH5TdLg0rSlxN2cTY91zWh7kOdGIsXo56QOjMX3FQm8W4e
X-Google-Smtp-Source: AGHT+IEOCU1Vxs9K3TvkuHmf4lmBc+VGVFw76bAqBnWbpns97MU1pHcqQMhdcmaMBiPx0duzyMO3IQ==
X-Received: by 2002:a50:9fc3:0:b0:55f:e744:71fa with SMTP id c61-20020a509fc3000000b0055fe74471famr627388edf.18.1707340632686;
        Wed, 07 Feb 2024 13:17:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXey/cH2FlVTD9OzfSIIRtS3+XVuhMv0EUqqeynNVYUNBqwMvjYo/s0VXIZKN/fUM7svy+/Wc4PCjsp0QN7q4oLjrCogQ797zMfF863k89tE6UXI0saUdUCYGZbYw8AXuT+ITH/wGWzZXAb2P1n+W3ef+0X2DMo1XWT3yZj889t5beWd/FiRUoKs/Y1d3YWKPZRiuLJZtXnruSt
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3314-d4ec-5095-daa3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3314:d4ec:5095:daa3])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e8300b00560622cd10fsm98362eda.68.2024.02.07.13.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:17:11 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 07 Feb 2024 22:17:09 +0100
Subject: [PATCH 2/2] hwmon: chipcap2: fix return path in
 cc2_request_alarm_irqs()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-chipcap2_init_vars-v1-2-08cafe43e20e@gmail.com>
References: <20240207-chipcap2_init_vars-v1-0-08cafe43e20e@gmail.com>
In-Reply-To: <20240207-chipcap2_init_vars-v1-0-08cafe43e20e@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707340628; l=2046;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=kR8W6XaSITp6FtKm662SPQ78CZF78Rrgzk4MuYq0O+s=;
 b=J1G74un+07m36ZfbGe9xs4/GVbjkUp9yXyXSWA1BAdd9FiVjUjH8AucF4kEDtDJmEGzyTeP3q
 CBKGRvsPII0DT4bqhnq0XPWVvZSwYvBcFl98kDFb80361d19ny2YjR9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The return path can be improved by returning upon first failure. The
current implementation would try to register the second interrupt even
if the first one failed, which is unnecessary.

Moreover, if no irqs are available, the return value should be zero
(the driver supports the use case with no interrupts). Currently the
initial value is unassigned and that may lead to returning an unknown
value if stack variables are not automatically set to zero and no irqs
were provided.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-hwmon/294e4634-89d4-415e-a723-b208d8770d7c@gmail.com/T/#t
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 3b604fc5d8ae..6ccceae21f70 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -670,7 +670,7 @@ static int cc2_request_ready_irq(struct cc2_data *data, struct device *dev)
 
 static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 {
-	int ret;
+	int ret = 0;
 
 	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
 	if (data->irq_low > 0) {
@@ -679,8 +679,10 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						IRQF_ONESHOT |
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
-		if (!ret)
-			data->rh_alarm.low_alarm_visible = true;
+		if (ret)
+			return ret;
+
+		data->rh_alarm.low_alarm_visible = true;
 	}
 
 	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
@@ -690,8 +692,10 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						IRQF_ONESHOT |
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
-		if (!ret)
-			data->rh_alarm.high_alarm_visible = true;
+		if (ret)
+			return ret;
+
+		data->rh_alarm.high_alarm_visible = true;
 	}
 
 	return ret;

-- 
2.40.1


