Return-Path: <linux-kernel+bounces-70063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F36859296
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113CE286A38
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3278287C;
	Sat, 17 Feb 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="CoZRJa6w"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C919823CA;
	Sat, 17 Feb 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200815; cv=none; b=KtP8y4UxWE+RSTfXLP76wShFE9NgrUwqpWF5By8834XAXzxZyRteZeSmPTd5bfArm2s5hXYM8jguMJTCw6xnkl2d9ZmmiTayCW/jcoFg3p4W+z3fHBnvAC7xWfH+x643fEsj2g7K9xO9xGpDzd6URPJKLJvL5ri21B+M7S46ujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200815; c=relaxed/simple;
	bh=w71Wbcz7FmwZv+zc0blwnBWeOoYM4g6wH5JSNctbpo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjWxOzkpUECAcdBbhciwFfhb83FjSJbIp6lxEZ8RyG/pawWjinjxvUDT4ef/DNWLVXw09FCw/gMaNwCZyONNvdo2perp1MALbmaW+EiuYKww1s589lizmcadqPV59yUUW8dZClDHnOaMc0iqHN0hbVPnWbTBOOEKvkrkMZs1PuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=CoZRJa6w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e104a8e3f7so2623723b3a.1;
        Sat, 17 Feb 2024 12:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200814; x=1708805614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLlN75gM6cSLXL0namU4YIlalW5Vi0mlHQZ3MHBhLI4=;
        b=fPyALyfMFb2vJBpQaOQGTAuxDXSDm3XBnWZIPQpCbUWhVRFv/Ij2tfRneFALI/MrMa
         LJV30g4l2VcrVrQ8uNOI1pLWZmNR/HYW4gJsTfOgXl4NsV9uTh3kJj4usnCEKgwsigLS
         wOD+xTELHoe6e6tVZR8TrJzXFZRUQYyCRRyi/Y8QqJzGQfvWNUatJYBsU0xynyl/Vaw0
         K00SXCkeJnUvArvnGeVAkq+NmbapiMQ7Cv2kvstlWOPBFb/uooCe7vJfXiuxzK/bettt
         GGGA98aqD6pwlaL/e9Qa3WA8UCmP7Rnu+LIQIrINYsvpNpwb57wAZLMkXK7KkNholjhz
         vgYA==
X-Forwarded-Encrypted: i=1; AJvYcCXiHlpQktA9ngw85tOFRtTFFo14fRQiqEUSAqPlzufRxQu1UJ57ydpZhSWs7JFdxNbWQ+RjxL/cfpAeIpGklE3fOWNoQq4EC5TwZI0K/pK9ltIevE9MZ002yH+zshC0ludkTiRvJ2uukQVt3D31Oe+Gd2LHMRaArSwUMdoQnvv1FdPG
X-Gm-Message-State: AOJu0YwqL3B9quDFeWcXIzV8JEpI0G9nhb8lKDgJ2bTDJ9zlbQ0OOZ3i
	94i8kI/ExUc+CBYFMpR9F7AiymIjRTibDuMzZ5UhLm8weblivuLH
X-Google-Smtp-Source: AGHT+IETR8osEA01neyaUCatTxOdrg5wlbF2nxUD8OZZ8J5MVq8bPdspXda+OFm9Wsq/uoC1CkXsTQ==
X-Received: by 2002:aa7:8703:0:b0:6e3:84cb:3d51 with SMTP id b3-20020aa78703000000b006e384cb3d51mr1500974pfo.33.1708200813620;
        Sat, 17 Feb 2024 12:13:33 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v9-20020aa78089000000b006e13a88d52esm2024077pff.61.2024.02.17.12.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:33 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLlN75gM6cSLXL0namU4YIlalW5Vi0mlHQZ3MHBhLI4=;
	b=CoZRJa6wPSrOMvSIpcKXRjMZvP8gNtwSvdc0gg5MRcDWy68yiY2a+GaHOh4MbVa/8prsRc
	2ywLRY5zMey7LTXsfG7Dfrg0PuY4+BGFZtil2N7S561byE0ZLUHLI5DwZS7/xxeTtVxG8e
	OiG6kIi1hMAf2iPrjJ+zUgAXP78Fjtffq+8eVm4JZ6aTsW3bZXoO0FrguQxbX7mcOy7aSf
	J5BSr7EK++BMpAI7rDwO3fsBkF4WjjAdN6hjdauBvJ8BOv0txhmCCbJlLlG64vBt5r42uG
	Lmk/7rcUa/XRx1Tfs5WI4Us4LcZLxKdZb8JND0cFtwATOnHzlisxm/cB//LFEw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:34 -0300
Subject: [PATCH 12/12] net: hso: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-12-1eb31fb689f7@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=w71Wbcz7FmwZv+zc0blwnBWeOoYM4g6wH5JSNctbpo8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNuu2dyMd0Dn82mZJ0uYEioT0ekZ6c+ZBXf0
 tJ9Asq8mHeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbgAKCRDJC4p8Y4ZY
 pkD4D/41UqCiVB/yP7feFrZ2WeO+O//tY1R6qezrJnX86aj43FGYbFyljHIpvyNHnnbMW2EX+wj
 dCy+bKz4luNffXMSQHX4ddVDqjpd6/VzlEC8O9/3PaijK5gbyjs6oM1bSSKD5TAA19f6k89+OA3
 mSFgkjwJRGSAH5tbn+zBjX0xRF/gaJn/rZ7+0ZTnW59ELApDiCdDBWxN1yG1RF9TB5E5uBykiok
 YmMvVC04WSuxJspHCWaZt1PZ4U2jFjg+Nw9+00ZmrnzYppqu7BCtmzB7PFeBThDK7lImtGB/8AQ
 OVjGXzCJXO3J/XRODHoAiEU0rhpx6InOgEG2o+o5OSt3TNDySGshVGqzMd8Yn7D4HWn/2KIlhwB
 bX3TFOKsD77AR5aexms8wG/Fs4sNE8JkDPrkVwx91DHFlDTefZAdmL5ck3XSlRWQE5H/DcpHWZw
 IWlocKvOMvNX3o8EZ0A+0YR44Eak9DcCrRhtjsmNEciBvAQAYW/8iB6ZJ7Pa1Yg/YgfkZVvqKE6
 +rPTvMSWmt4bZROlHkSWJdAH0xzHC4UBmz+8jSE0MxukTx8qXfEIaOInczSJ2+InLSYLNi5YfmN
 Yh4g4ZzIA4y7GI0LDHH948xVVCD2SI6se+4PCuTjPee2BCSR87K7JADdBMqmunFEnUCmZMfn+ZK
 BMODrTGSqLQ8R0A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the hso_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/usb/hso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index f088ea2ba6f3..1aeb36119d3f 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2465,7 +2465,7 @@ static void hso_create_rfkill(struct hso_device *hso_dev,
 	}
 }
 
-static struct device_type hso_type = {
+static const struct device_type hso_type = {
 	.name	= "wwan",
 };
 

-- 
2.43.0


