Return-Path: <linux-kernel+bounces-70545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEA859909
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848021F21344
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8047317C;
	Sun, 18 Feb 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="D14yr+n3"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F973162;
	Sun, 18 Feb 2024 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283861; cv=none; b=LXqPdfcgUW79aHIp8IX9EJU6GboSNODDIDgKQVwAtq6OnthiBe3PFhNmjbyu8Jlvr9tIBsAKian3ao7pSXNruRFw7NWWIklGf3auKUU8sQjyqtn92QvmsrjI+w5elkE+Oype2Dte+Bz2cb4ayFuMHCBrr2jlJGWndfo5wmAVqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283861; c=relaxed/simple;
	bh=z8aNWQu8hQNB/xEjSr/J7RjvO/XXeZxQtn0qbu3Z94w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ob9ruPfaM+k5yu7oP/QQRK+WVGeORS3Z9wv2K3WSt2E0ibFiwSRhb2GebVTesCsjtpbR3Rq51Eztrn7yqWB2m9S+zI0P/3PH2a8Up2FLZNG9rqHecrr2fFaKxurkWwpuz78H42SA1UBcAyyEyb2vWP6kCYmE4s4/P9AQJkAZj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=D14yr+n3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7393de183so28834305ad.3;
        Sun, 18 Feb 2024 11:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283859; x=1708888659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G04fZygIx/SdPXAIehBNQN19QyJJQNeUl7uwq2q3igg=;
        b=IRdQaTL4mDjAFKDWWjVycYxEOtTeiCFnY1SkUTjSUHiaIL0bRZuijDR2+/T+QA7uLH
         wQa1v57eZhXskOP1vl4AZ/F8TDetHBiZiEOvYP6/UtTMpM6+fKtA0hzMqq1QCkJ2HBjD
         Hlh8IFxYN83lv3q6h75uRjyqly8o9d7g0RqIha36nWuEhU3svSsz4XqKgoHmRj0ZaWl1
         ujwxR1P99hA1hZ64wY8TcjBEYPo6zJ5JCsqsCfThNeBj/1yx3ZRvTf8yoybct8EUwKyV
         u6EwlpsxGPdSApRPmlo690lrzMfChcAD6zsMLBlnretnAklKj0YytETARvhJzgz67Zhz
         lgqw==
X-Forwarded-Encrypted: i=1; AJvYcCW3c/UcuKzjI7OHAIG3/2IsnL+iktjjjMPZCoUQqyHWPVVUT3OPSnDBvJBrwYdaqGL6skeyhRUZhZayXwbX234n1P3dfdsfsDD4Y9Hz
X-Gm-Message-State: AOJu0YzI4bREPH+CkphOI+VvBMcr16pZRgjdQKgPYVFhVNOsdCdm3kXX
	DVOtaeXy92YF4zFTXA1owUbZIZ30ccC5g3RCsg1uwxgSvMQSurn6PWw0HaA9kd1wlg==
X-Google-Smtp-Source: AGHT+IGmCZu1YV/MIz0OgOZ4Oh1uyQ0JaYCobAL8+iHQOkd+PW65zJZk8SLMRqBd8qMxTwdHPkLZoQ==
X-Received: by 2002:a17:902:cecf:b0:1db:cf64:732e with SMTP id d15-20020a170902cecf00b001dbcf64732emr3766776plg.36.1708283859136;
        Sun, 18 Feb 2024 11:17:39 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001d9eef9892asm2969048plz.174.2024.02.18.11.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:17:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708283857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G04fZygIx/SdPXAIehBNQN19QyJJQNeUl7uwq2q3igg=;
	b=D14yr+n3hGmYxsTMJCL5+tqWz9cAYiTF/zy7MdqTJ5XOyJohFUhVpNYf0La5fIRVceozaJ
	MlxJqZkJlzEwmV8ZTXqsXAy4NXOnyUZSXtmCyX0Eglvz6n9rMVGaJJYIUtJkqrJ22O/R17
	ztxyf0BVmzDlV+1Zuu0Bum4Pu+CkjYpcoWXVEvxLSjaH/fhmZroxLArVTYlUdWKu/4udlI
	kUcYumUId9f8XNuQfMc3J6tyXi0LmvsyruwRfJzY/Fub7VQCPOcU+5BaohAoUkpNCqpZS/
	ZTwzQsOVhOb5MaaXqc7AZziaoCYRT2cAyglDIaPHstaSjVWlTcMsDKjBeo3q6g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 18 Feb 2024 16:18:10 -0300
Subject: [PATCH 2/4] usb: phy: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-device_cleanup-usb-v1-2-77423c4da262@marliere.net>
References: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
In-Reply-To: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=z8aNWQu8hQNB/xEjSr/J7RjvO/XXeZxQtn0qbu3Z94w=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0lf1aoR4z9JgnoODANxcn3uJcn/IsUFZX2pmw
 xERE+oX2oaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdJX9QAKCRDJC4p8Y4ZY
 pobdD/9zyyd+b+J4vGJ4Bgu+1JFMALBKx+U6DY1+O4kpl45N5NLo9qzuWVgdZFA6nAR+oZ98o2I
 EoT82bbKd8fBe7NZcsi0L2kY3oDWek9huqUon+kEYEqcjOlHG6g5OMdT4W4TCQM1+UIPVsjiagG
 pMa2dAkBUnNHD17WiBsipoK0sLQAfjE6Zv/JVgIgJB3TwlZu7SiOu3tBJx1OkGY/UcPaa6a7UYG
 +gJKjgEt4wISQsAVZV1AeKkFXPzG8x9w1s0bimumv/X8jZU+2fkpzgdy7TYVhv5HFRmnNfWgxpH
 yoQVmZf1OisPRCHNAMWOQHdSTgYiLGVTj5DXpYG3wOshWXpqT0x09Vv65/qA0v8TSegcQXpavZL
 vwACDk0BQugjARmL0MiD56cGu92zqApLZpcfyh6eYcj29jI1kZpkt53vCJPliM9C2Tm2OkvMHNQ
 Py9oHdULDeXl9csLWMVHlSNNbIJKa1lIomFxMyKq6laiFw+S3/ltD0ya7/a8hGby504iz6e2snp
 frLv+h4MScewT0EqpjsD8boGGSt/xZMT9PkSQBlC3rRqb/y8/mqBRJNeweaRyHhDSZ7WyEtM3yQ
 50prr+wXWt+ZeZ8HGm8XqzANoJ1PJDYRMjYHOg+tj6O/spLxcGq8msW8XuQ/pozFEFI+RFmVulb
 INyTL0LOfDeVALg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
usb_phy_dev_type variable to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/usb/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 4b468bde19cf..06e0fb23566c 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -699,7 +699,7 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
 }
 EXPORT_SYMBOL_GPL(usb_add_phy);
 
-static struct device_type usb_phy_dev_type = {
+static const struct device_type usb_phy_dev_type = {
 	.name = "usb_phy",
 	.uevent = usb_phy_uevent,
 };

-- 
2.43.0


