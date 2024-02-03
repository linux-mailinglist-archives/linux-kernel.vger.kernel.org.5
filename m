Return-Path: <linux-kernel+bounces-51264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC71848873
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CC41F2345C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66615FEF5;
	Sat,  3 Feb 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="WpUvm5OD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9905FBB0;
	Sat,  3 Feb 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987678; cv=none; b=P9ODdhE9CRFiTSTZb/BgGU1Z+GYN763WlkWXObD4iVGPanNPaUuIkO0eSjRgxHkO12VZD/hhq5QYhHbX2v2a99w/9mNmYoTbak/KVAGP0e9ATky0/sRI7IFE+HbeXmqw1yrz636DL8NNLnwVYbtcWJIK8qsFK1JZ3facIaRYYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987678; c=relaxed/simple;
	bh=YJgAF4TThke/vMQrMJy8V92C3oDBIvbtDIV3XI4K9Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoknppJOw8RTZ4Y9kdDpX0EGGgOMDHp5agUOoMc4WijKd1Je7pS4DgjDh5/XnWlQqDGCM0wyc7mreDX7desnn6TSZvPPgIXu/FGYbWoAZVz+36Wo+pc3c69EiIzyX0rMSbZaW4Jkv0cbP099QVnI+2LWUsydpg0PeQh4bpByZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=WpUvm5OD reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d95d67ff45so19917415ad.2;
        Sat, 03 Feb 2024 11:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706987676; x=1707592476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJET0TJH1U65NigEFEtlflIn1ibg/vn9cYHzNhQWszQ=;
        b=IykI8DhhXA3+grI8vBgxVU/+xk6uO7ihonwjUE9P4iQNZMlycLjEbCqNzPqmhYrEtW
         2BkskKkpipw2eimxHbHM8KNDh7RaU9q4z5GzDO4pn8Pcep7o+L//l14v5fYA0yBsH9g5
         vQN7eje/C99wiyIZBLC00WFiiCoW7pULLD90FV/Rasuud4Zx6/Hpw4IV8QCofYwM2OpK
         Vtsm8lQFO/nbVxZAC5nCMFRvoXAs+rEbxynddYBrBmJPr9IHKKyGTaklwc/80GhnubN7
         Phohm+KMeF/dYUR1Z8jD6W11325/Y4qco5Qz4WBlx3JivDYMH60c2qDctcKbjdBOME6n
         DGwQ==
X-Gm-Message-State: AOJu0YyFpanqJVI/4tV2pvMSkwL/Cmxg3m17KFKYfXQh3XFFaoS4jlZo
	gk0MFRkf+JfFvgxAkaNFVFPAr0VleFkh6magJQSaUxX8fnwNm6pcNhqzNUHHmL9IiQ==
X-Google-Smtp-Source: AGHT+IHirfs/yqzXIccDgInmt+ywLkE3NLBFyJnWw056MjUUnGTp6h7t/lXngX1Hrgu/Ztbrgglahw==
X-Received: by 2002:a17:903:94d:b0:1d8:b6c8:d9e0 with SMTP id ma13-20020a170903094d00b001d8b6c8d9e0mr6296162plb.68.1706987675889;
        Sat, 03 Feb 2024 11:14:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVe5Riw6nr/e/D4wQcwZT+XkvPffOZQR5FrR9jAUcXg2HBHjniBzX73skIE0njlRrJ4iwU601xHl6DQ48DyH56lIGQpdDxayCB/INvxlBgyXPjgsW7LHQ+/+StbJvf9aXIQGT7iUqr9sNSNOU7LcMIVF62q9XQGEAAsH6P8x6g=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001d94871ba92sm3547187plb.239.2024.02.03.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:14:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706987674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJET0TJH1U65NigEFEtlflIn1ibg/vn9cYHzNhQWszQ=;
	b=WpUvm5ODeKQ184FHczRUdAoK5W4vWELK+4J/2DKWO9zIwcu3f1wGYXsVq+6XKQec8rPulU
	YO7OKrSVRLnn/W3ykO01XUHhFQlOUR37eI55n0zch9Y8+qWkHhwVlT13aZSSliMTRoQsbc
	5/2BrzM64x01MrbEkAsyx73zpoeSKQ4OkzoKuCuEaZhfJYsoFxiIrEoCGA26ZjHParzDBV
	26MdH1GhBejDVNEUSJHTf25azF3fN69QBnm1cV3Bo/E7dNJa2U9FmMVTkf+9BUeO7JgM+j
	X4Dwwy2d5Nq/DbKXgfJ9FKuwxRLre55BWMya0+Hl1N/CRY94KqIFtgNTARfo8w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 16:14:50 -0300
Subject: [PATCH 1/2] serdev: make serdev_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-tty-v1-1-86b698c82efe@marliere.net>
References: <20240203-bus_cleanup-tty-v1-0-86b698c82efe@marliere.net>
In-Reply-To: <20240203-bus_cleanup-tty-v1-0-86b698c82efe@marliere.net>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=YJgAF4TThke/vMQrMJy8V92C3oDBIvbtDIV3XI4K9Fw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvpCzAPRaxZq1wR9wnA9A7wR1tx4JGhSOm1ThK
 W1p/hqZIOCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6QswAKCRDJC4p8Y4ZY
 piGhEACsCq/odfPalxovqRLgpSHql9eQe9yrxXoUeuZ+7hpUU0kDjLWhF+Ig0gknh5YdAbXZR8M
 0soGGusjWuR1QnJ1gMN3N4dOOhmewcaa/WHuFJtz+wkrTUzrRn/G9JRuZg/FdgL/TO7pu21PU0w
 OTDgsAHH5b4cynQeuIUhK0gf8LCucwjQkYsrvsEn53rh+qjb47WG3erA0N1upYLjyyKI7asm2Ah
 YKcfdp76x6hDy36RT8nNpdmkhigg1pqVk2XIlOhAV0aSTGwhXDLNo0+2ixobpnnc9K8Sn9eszaV
 4TQ7DqyRDkQOX8bHDh6imbhOH/d+TYQK4x+s0IgIQ1R65i3mcHaxHvTCoRoupVsYPJDHRNNUwVy
 7+HV6D59xa/m3jnvchVBJYD+GasD0AQ2ZCPzyW8A4j1AI3q/6xCM4UDlcZcq6RJWP8zeLA7vDne
 CseH+hAFU1+IHwQrrdWmaJVXPylTXfjLX97oZjIK3ho6/ae2aUlcQ7sqCPm9afNL/i9n5A07fw5
 0q+dWqlqiTqjEjHQImMJpmUGnkG/HzbnO+SQfKsujtOCejI2KxJ6sVueEz8n7o1CiIxFaTwQrAc
 Sm+Yp3pCa367fwUU88WLqg7XABJ5OGf8t9uFS+Z8Q7z3tqREHkqCANfuT0APTO/HVu+9s1rAbFp
 E6ceLWIFSSscuTw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the serdev_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 822a5cd05566..613cb356b918 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -431,7 +431,7 @@ static void serdev_drv_remove(struct device *dev)
 	dev_pm_domain_detach(dev, true);
 }
 
-static struct bus_type serdev_bus_type = {
+static const struct bus_type serdev_bus_type = {
 	.name		= "serial",
 	.match		= serdev_device_match,
 	.probe		= serdev_drv_probe,

-- 
2.43.0


