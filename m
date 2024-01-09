Return-Path: <linux-kernel+bounces-20943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D98287AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5934DB24DF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D13986C;
	Tue,  9 Jan 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeN794cX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3A39850;
	Tue,  9 Jan 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3e6c86868so26220905ad.1;
        Tue, 09 Jan 2024 06:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704809025; x=1705413825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZBafw6hob01QS01xBkXqkw9nkyhWNI3hsapBEtWecI=;
        b=LeN794cXj9IksPz69EwfZ5FwnWREeDnn/YG7+YOwSbG5znEq1Z8w/G8QD8qpV0mkwg
         iF0+ryKPh+G2PyELN//2Evt9pm9VnydO7V+eW3el0Mc8mldn7eYg9cNzmySuCiBVTOZk
         yiNurOgnJhP/dLQRjoSzUKTqpNFH4z1M4vyrgd/WikKFvXEL3V2XxSGWomygpFU0+tkC
         R6r04zBzZexX3AzZGi0txYN+xhhno/gVohy54J5ayCUEBCd4Z1llOgN0Hai0iUEzRCAN
         FZa/VQeM/iePByYuGqoDnYFNXAZZHYUegDXvNAP8jbvpnLkhS9H7a9icXos7OeYiHiwb
         QZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809025; x=1705413825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZBafw6hob01QS01xBkXqkw9nkyhWNI3hsapBEtWecI=;
        b=EO9fUh6ZuPAeJukN93hW9HX5cKN8GomId9MatL7E3w2x3H6jMNAEYYRE2BhEbPFz5c
         60pDjltvcyko27xAkpIko1Sr9Q9b+uqODl9JbrVpViwRtoCy3p6glVbsCZvSxdSJTeUO
         OxuW6GefebxisMJWmWFxpJdZUVk7OycQuL5syrHt7p0L3naJnAruFEANEHhMYoI2D1aG
         IqKeRNX1MSSkE5JbFeO8/6YFj8SSFvHHqRA1d+n+pURcWwgdLkHIbZojbGk1JnX9OJU/
         CUUSeDd1dFn5PCklIZkkXuch4S1Q2xPs7fG6KDQgMoTtrMuwCXPXKZDtFqiVJFirK0Kk
         75xA==
X-Gm-Message-State: AOJu0YyzY2evTAI7ndgrUh7JHE6wIdhJ1cePWgMkEEuPTQ+El9OngGe+
	yE2foNU15TuSn7uzc/knUV2mi36wjqAXuA==
X-Google-Smtp-Source: AGHT+IE/JEBDO6v7IzoujrJgFdjXIeuiiUlZp7z8i//0M1qW+IdvYG5VRFSKX3C95yYO9bKCEyYqPQ==
X-Received: by 2002:a17:902:a50d:b0:1d4:1327:bd15 with SMTP id s13-20020a170902a50d00b001d41327bd15mr5165391plq.32.1704809025335;
        Tue, 09 Jan 2024 06:03:45 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b001d538b6517asm1818362plb.230.2024.01.09.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:03:45 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 1/5] gpio: uapi: improve description of fd fields
Date: Tue,  9 Jan 2024 22:02:17 +0800
Message-Id: <20240109140221.77725-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109140221.77725-1-warthog618@gmail.com>
References: <20240109140221.77725-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only a successful operation modifies fd fields, but the current
documentation wording could be taken to imply that a positive fd
value after an ioctl() returns indicates a success.

Reword documentation to clarify that the fd is only valid after a
successful operation.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 include/uapi/linux/gpio.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index cb9966d49a16..650c1099d1a6 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -189,9 +189,8 @@ struct gpio_v2_line_config {
  * buffer. If this field is zero then the buffer size defaults to a minimum
  * of @num_lines * 16.
  * @padding: reserved for future use and must be zero filled
- * @fd: if successful this field will contain a valid anonymous file handle
- * after a %GPIO_GET_LINE_IOCTL operation, zero or negative value means
- * error
+ * @fd: after a successful %GPIO_V2_GET_LINE_IOCTL operation, contains
+ * a valid anonymous file descriptor representing the request
  */
 struct gpio_v2_line_request {
 	__u32 offsets[GPIO_V2_LINES_MAX];
@@ -402,9 +401,8 @@ struct gpioline_info_changed {
  * such as "my-bitbanged-relay"
  * @lines: number of lines requested in this request, i.e. the number of
  * valid fields in the above arrays, set to 1 to request a single line
- * @fd: if successful this field will contain a valid anonymous file handle
- * after a %GPIO_GET_LINEHANDLE_IOCTL operation, zero or negative value
- * means error
+ * @fd: after a successful %GPIO_GET_LINEHANDLE_IOCTL operation, contains
+ * a valid anonymous file descriptor representing the request
  *
  * Note: This struct is part of ABI v1 and is deprecated.
  * Use &struct gpio_v2_line_request instead.
@@ -465,9 +463,8 @@ struct gpiohandle_data {
  * %GPIOEVENT_REQUEST_RISING_EDGE or %GPIOEVENT_REQUEST_FALLING_EDGE
  * @consumer_label: a desired consumer label for the selected GPIO line(s)
  * such as "my-listener"
- * @fd: if successful this field will contain a valid anonymous file handle
- * after a %GPIO_GET_LINEEVENT_IOCTL operation, zero or negative value
- * means error
+ * @fd: after a successful %GPIO_GET_LINEEVENT_IOCTL operation, contains a
+ * valid anonymous file descriptor representing the request
  *
  * Note: This struct is part of ABI v1 and is deprecated.
  * Use &struct gpio_v2_line_request instead.
-- 
2.39.2


