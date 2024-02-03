Return-Path: <linux-kernel+bounces-51265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEBE848875
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36856B24C79
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B660258;
	Sat,  3 Feb 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="KRbdvwMG"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231A5FF1C;
	Sat,  3 Feb 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987681; cv=none; b=kLJFGGD1ZSrMeIGDrC+iCEou+D4ufPS/3wL41+ntcntRw5ZE+j3smxiyjQm6Xo3y47v/wMWxnGjj9TD3lW2yfuYNlwZ7Axrk1a1vO+1hVohD2mGfD2gELs4GH3tH0fNQKdqozKc+SUq0yCHR5oYZyvRw9zGTkXpL7Xx5L0HcWgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987681; c=relaxed/simple;
	bh=M2yMvEd7apf6euaEi/MHIC/Ic/qD4VKhS5jPAVrikwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2ZL6njkAA6NDScvZZzLiXNvaFrtYv56UzphJcxuyg+TvVG3ySdsbgVxXNDN2iPpiwg7wleN7gAaVbes30lHWMA5thh6q7fg7liGd+v493aPfv9beSrnE6CvqRyop6oF8ruNf77nkuNqIaESGZ3Buv0k924zvjq2eOXymCjfldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=KRbdvwMG reason="key not found in DNS"; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd72353d9fso2374901b6e.3;
        Sat, 03 Feb 2024 11:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706987679; x=1707592479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0me723O1wv9PKFRXBwhR3oYK5VM7+JumecBNWaeJjo=;
        b=KsBD71UJ0gbuMCJruuVoadzDiRmFt/onGRiwMGYd1/4Va/d+Etvrqd7HYZHuyqdXZ7
         NSX8i2ta46yOO2K7eqQwwBAGRX3RxzTvuaAKgauNHiFXVWB7AKiElWnAADdJzVu0nUBA
         8PcVW+wOE558zyBUOHFtPR4Ufp8hQGStrUY0i8twUtBhSHQ8EU6LF3ihDXbBa4xROaqI
         B5MWmMKNT7h56NE+VVtCvFkiOq00UWL6r693z5+6M5+I3ygxkZgLQfFpFugvCCTtKigh
         QaGlN9rEuaFiBMRQpNhuaaYWuZV2x+df03Er4PJ61xC3eNR3mOB2nYac33hVcA0tzEj6
         QZ6g==
X-Gm-Message-State: AOJu0YxgJ+vi6sOWaV8pmuLg0LMU5Zr+ixFpK+ronSh8AwClEqMW1VMW
	1axBahVnHs+dobkcH34Q2u7sxfaIFb5Xp4ZMNRC6b16Fk+uKIPqR
X-Google-Smtp-Source: AGHT+IEJFYCQti3eyMzzs5AGetGOTDq0SqvyNM4rKsZVo2SRoSrwJzHykUyCBHnFe41ctOjC93NNSQ==
X-Received: by 2002:a05:6358:d389:b0:176:b16a:f392 with SMTP id mp9-20020a056358d38900b00176b16af392mr13876718rwb.10.1706987679138;
        Sat, 03 Feb 2024 11:14:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGfKh5KmVF2ecxFgkGgZOOqDmQ0Xb8eDXW61jQi6uCGlMTi+IGgM0e8nXjeigDrGIx1pET62pvg02rmm3KAQR1s6RqdFsroLgwN6eNmB96OXAox9LnLBzBBcp28DAFKR1AkMyALZ4eSgpEhxUnCU87r5ubrz5vJ5CSw0JiDS8=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h26-20020aa79f5a000000b006e0350189f0sm481692pfr.91.2024.02.03.11.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:14:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706987677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0me723O1wv9PKFRXBwhR3oYK5VM7+JumecBNWaeJjo=;
	b=KRbdvwMGjFmLzkKWvOBSiZx4/a5iSc8qLp7e4xzLuiy/ltEaPZMi6TPWRREL4O1nBQSlWP
	8RX5J0hZt9s3ieEeoluGQZ2FjEsg3kqQIp5LP7JGzrTDSYqKjnT447jJIEPrbR06WMwzvx
	DmDwbAgAL8PRHOl6KiO7nciQ0ZkACt/V/sqz6xJbFStuiLWUbL6XVBKe9jmV+4G2VlN2kl
	9gEtJ4iUk9qq7weLyqqRvA4B3QxgAGu3KtezI733s67jrRZVZD2OoQuyAmOr9Hb5F4EDKA
	BCtvwrcsNpOachD9g+u9bb9Y2kLTI26BsfqPUnUQk5qmwjdaFUxQx/8/MNXXDQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 16:14:51 -0300
Subject: [PATCH 2/2] serial: core: make serial_base_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-tty-v1-2-86b698c82efe@marliere.net>
References: <20240203-bus_cleanup-tty-v1-0-86b698c82efe@marliere.net>
In-Reply-To: <20240203-bus_cleanup-tty-v1-0-86b698c82efe@marliere.net>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=M2yMvEd7apf6euaEi/MHIC/Ic/qD4VKhS5jPAVrikwA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvpCztwVltvFpD3TUgSJStNwrCcetxPEJ5vyt+
 ad3PmhHO0WJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6QswAKCRDJC4p8Y4ZY
 pknYEACESQ6oYokCzwH0ujTwvXPm5TBYLTI0n0aFskJmL4ZV261rrh9o9E/9k6fW/oeCmi9kevW
 /VHTFX44Qq9xKmOGI7DXxm5cOhZ/DVt/ZosJH697v81rZZXrr+ii7kBrs5jxL3NlOD7vtfvP+OG
 /5qndp1NqOmqf5WdRxHAy/libJfez95bXoCaCGSkRG+xZH7xuGaFuUFbO/bEKz9kB0Msdwg8lCG
 cgcjFLIc2MQnADTDBWgMDyU0T7nZtkCFb6JhKYnrKVqpZnHkJgh/8k6lgwMKV63WSjnQsLuW4Wl
 VI5CiIGt5Me2rtjOrByQ/r5cP4Sqno12EV6gAJkbYs3LDg/uIZHoXKc4xWaVhBLjsy1EYtchday
 a371/fjan8CSuD8gMGBew7X+zPI/JXQy4mYTKuNa8tG0StTXRSUgQ17d/WBfkKCQN+qeRHWDv67
 Wz31uXFe7LU/QoMeBV9GKheOqlRUpwzflbElWQ8FrOQm6FG5A0/yvuaUVkq2V4KyOdhadUx3nYs
 l6TWf32+tJ4y54GpN4iH522Q+Z5sMFp7jDdl/yb5woBldnbp3cZNUcxFekb0nOnu+bCEoX26IPf
 7uXzoa7Gh0F/OhLxTyXFJ1c/NLlRc4gvdXi1s/+cdjXhZSVZGSxToXbGkW6TyhmQE0+Hd9Xsp6l
 HUqmrFTr9XYn4MQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the serial_base_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/tty/serial/serial_base_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 3dfcf20c4eb6..4df2a4b10445 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -41,7 +41,7 @@ static int serial_base_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static struct bus_type serial_base_bus_type = {
+static const struct bus_type serial_base_bus_type = {
 	.name = "serial-base",
 	.match = serial_base_match,
 };

-- 
2.43.0


