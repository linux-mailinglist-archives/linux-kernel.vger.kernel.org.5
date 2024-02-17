Return-Path: <linux-kernel+bounces-70061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E548685928B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CAB1F2226E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D081ABE;
	Sat, 17 Feb 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="TXoBVl24"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139377EEE0;
	Sat, 17 Feb 2024 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200809; cv=none; b=Hj8LtsZMd67fLQYwFXKNX7e8iuVxk0vZIZH+nuxTnyYf1itlvBiuNQmW2/i/RpKdD/mlVwD+KSVQgST2hEf9FauCMqNme0Opkgw0d2vKo4+LrNNCz7U1/wrH3kZdmHR3CYCHDwKBUamfBS+yf3n2en7UKMEkyyNjO8Uk5FN5CNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200809; c=relaxed/simple;
	bh=7JK8021NFcn7x/A9YmsBl2kwgr4grPXAYQc8nQUqfUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FnBNSSdXsDoiFZi4srm0U7LdQmMgcYcc4OBLU4efIkwKpqXBdX+1IiEoT8hWWNHcget84qsgX09abFbP+IUtAcdwpA9uh39G2v5Lb93w1NZM9fe+h11YJk232SVFiFW22xGFUrUuofia/TrgYo7t6yFNO6sD61e1LmhznWSZmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=TXoBVl24; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d780a392fdso18279185ad.3;
        Sat, 17 Feb 2024 12:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200807; x=1708805607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZT106h+HbFoSOyeUsPjhLLk33QTW+0Hf6eB5MZmNJg=;
        b=t/mttPdeX9ReWTHvQQa1zQdxaYyUVqDxoF1JpmHx+gUcO1rcPpKVTqpfF6H/dfwANo
         NRaVKiV++iqPvMZ/PYwBmGh1RugRb2rmhUqjVeMyjH9uEyousYD9DCXDZlXo5LesO2H/
         xU5eKoKlmgq9djXKD5ZBRKOwp5IOSQA4uWlcI/5zfxwUbYxYftSyy8lDmdQugx7jzp8C
         7akBZE5b9Sg+qCsYe3MLJRPRqQJH2kDhq6yn7qQYiA1ZY+vz3javrmKZVWCl//Les0IK
         ghlFOgWcDk7ZDKDat8vSxVtW3i4fzpFM1FT8uQ2ZoAjbVM3RUGI9Jhv0QFinbvdd30z5
         i/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXubZnsDv1ceGJPa9DO0iZQO/beY8Sp2V6xg7ucyctxi4pMJzbcEYRHHB/UgdNCVNq1uIqbdPAg6RmtsVj9YH4lGnjMJ2Xlvdts9TiqKcVzuUxeVwTtz+/vrcM2QlS9aXJjuvqRNUcPsJBDmUtm8uZgvSXlOvwtdJuWin0NMpc8+awF
X-Gm-Message-State: AOJu0YyCAw6vK+9eriAaVr9R6+tTpNKN0oc9vQ+gjQJ7sddAR9mfXIri
	wPR764LfkcfvZfT4m1bkAMwE83/kzjlVYH2JM0XkVEB7154CB76V
X-Google-Smtp-Source: AGHT+IFvYmltYPzSRDov3MAi/6kQwTMhhkBwf7enDquag6qlGhiZuAbJVCD2YWlFru5GZj7aFXoPIw==
X-Received: by 2002:a17:902:6b4b:b0:1da:933:fb15 with SMTP id g11-20020a1709026b4b00b001da0933fb15mr8658770plt.0.1708200807322;
        Sat, 17 Feb 2024 12:13:27 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b001db5753e8b8sm1793294pla.218.2024.02.17.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:26 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZT106h+HbFoSOyeUsPjhLLk33QTW+0Hf6eB5MZmNJg=;
	b=TXoBVl246Dfzf3FAHyT7Y62k+DG1hxFI7ZTixZHUx/7f1oE1QIaTH22722mv98oiS4amFB
	Pq/B8EcRJOW8SDvzLi/O49soMg4gvaXfELNkDiqJnQJRsZE0vUeE0L/5B5gxwOb/7jxHuH
	EBOcV8gwiYBW4VwxTpBIY6XyIa6UB5rhY7h9169dQCFVucnYwBJu0WFqDStvQfJPx5Xkc7
	MzRa8hpXMH4Wro5/sKAQUM9aLEXgTaHtvs5/LjAIJWPqTmwisOkejSk9ZYPnSLQJP/Lupu
	xMd8DpS5Hmt87Es51xt3AyHuRu4Gu3r5aQ9Ug85mXvHV7lJ2UYX0Tt11C7cLVg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:32 -0300
Subject: [PATCH 10/12] net: netdevsim: constify the struct device_type
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-10-1eb31fb689f7@marliere.net>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=7JK8021NFcn7x/A9YmsBl2kwgr4grPXAYQc8nQUqfUw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNtX5ra8kUh1Gz6cnS3au61vDBZZs5DEya2u
 Ot/UI9JBlqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbQAKCRDJC4p8Y4ZY
 puyZEACUj0qXPyNUoJgWO4PQw/6OQKeuHMPxJiEqCHR7FBusoaw9HyTc5elN7xY2vmkewPzGyYi
 GbnUjqXHRQIT+kRIoqc/sm10IHOI44K73eQosTD4XgmojUSxeFHSA9ePKxNdbjQ2vf6hnubUvKL
 n60/YHGR7lA/Y6M5uKF0q1kEUV1FC9576qVx7TG/ge+286EEjHBdCvSuPKoRhhSmY8jPjLUhv5a
 V8ZEMDD4Wx5nfcQBzLpfoCBCS9VQndN+p1UH3uQNZyYqp+eOrr03xF/EGKE9/PwtI9rPiDmMBUw
 AgbY0RBG3LGPfOeI2gr62rnWRIGeaO3FfpmBdKTZ9nJdujfl4AfX9NlQR9O8NuTlBKtbmyYVwek
 lrHHIQV/lW3HHYqpn5pWqCBbm055GjWDk1SXNe3FChipDYriecNeT7ryuYkYi0D4MOjEsWVFoaj
 DZVOXQTzgkxZoVAxfmPhi5LH2jtAwIPNp6rfmPKs1jVNQmrTmYUhr9PrYaFpFzryXApr/nia9kF
 fOSe1eoJQezsqfq46ysOezTJhrYhWx+H3HLPwl7EhZno6URbPlDoqBKtB9lcFyQbw4EdoDQvlMR
 CIX7wVNuSk+meGgvrtgtc31MoejYTufJzPSQtPNBbym6u4eixApErLTfcZUITop7RVu+8fZpiUr
 qBAkM9EZmOJJ4fQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
nsim_bus_dev_type variable to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/netdevsim/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index aedab1d9623a..0c5aff63d242 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -129,7 +129,7 @@ static void nsim_bus_dev_release(struct device *dev)
 		complete(&nsim_bus_devs_released);
 }
 
-static struct device_type nsim_bus_dev_type = {
+static const struct device_type nsim_bus_dev_type = {
 	.groups = nsim_bus_dev_attr_groups,
 	.release = nsim_bus_dev_release,
 };

-- 
2.43.0


