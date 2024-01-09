Return-Path: <linux-kernel+bounces-20948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7848287B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C22875FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAE39ADB;
	Tue,  9 Jan 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQN/zGMe"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5139FFD;
	Tue,  9 Jan 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4a980fdedso27293485ad.1;
        Tue, 09 Jan 2024 06:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704809074; x=1705413874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijQhkKPrA5WhMt4QQQ7nm21kPG9bAnEvYYwAYTNVVhY=;
        b=OQN/zGMeZdEI8mo0ztyTz71FJ5fu97unzzNllilfsBaIk7lPUN9f+QjHayxIEvcONQ
         Yv311s6LT2eYh10GmwWrCTilfxpp3Xql6m7KoW28qai09S3gURkbvXMyY9OuEMz5vorv
         udXarLE9nD4oH5fvBWZzM0nifNz9c8hNK9CXLW26kDZ/kiG30qWI60vjvYPoCdQcbLXs
         3xC/dHvuspRLgLY0El9+B2+OM64AJJongJycsmaUk6PONZ9cSfy0mhUM1TlFpcoKK2bh
         O9QqpU7J7X+U0DZrSBzGHJH1Fk5OT10/XYq+Krjq2vjW3dkp0WAcQyvj8RPwuMXE1Sa8
         P1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809074; x=1705413874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijQhkKPrA5WhMt4QQQ7nm21kPG9bAnEvYYwAYTNVVhY=;
        b=gvn1ScW8nCCqDCZcW2NWie5zTDIAcFdOYVVhh46tIOhRsgNDYT03qI7WsT5fzqb4gS
         CycCk98LPqsn77h8b1M4cSrhaz2dPorMwr46zF9ZLkl0zqGPAoMhM6k0TMF8QNflCQ0g
         NMgHDWg95MXd9OXfmUPGpT36LjJzmoYZRbTxTHK7koDlEToaTJi+GxcMD1QHW4+sYs3h
         URn0v1f6vUFpAKC+3AsZN1Q+/6uDG2AeOCz52oztj4GacD+4k78mY/qOSWiXridvCENc
         Xn0w3Vj3d65EV8lXV+TLFopMYcR6vg7hEH+Kij783z/efbzLfqAjT9glgL2OabSMEfHv
         rrSA==
X-Gm-Message-State: AOJu0Yz08ZDmP8xTm39hQAmjkOFlbgpjwLEdl5R6tE1AECzcOofsrc5j
	zbPetuRCZu3v/V16EnPWDkchwbXIDAy60w==
X-Google-Smtp-Source: AGHT+IF9acRiBuXtnmdP/L/n9HR/N/T4L5LgnpFxlih/9JoSewFxrm6a2SEWXR9hKKXD5TJ31tIzlA==
X-Received: by 2002:a17:902:7804:b0:1d4:e308:d70b with SMTP id p4-20020a170902780400b001d4e308d70bmr5104104pll.92.1704809073967;
        Tue, 09 Jan 2024 06:04:33 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b001d538b6517asm1818362plb.230.2024.01.09.06.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:04:33 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 5/5] gpio: uapi: clarify using v2 rather than v1
Date: Tue,  9 Jan 2024 22:02:21 +0800
Message-Id: <20240109140221.77725-6-warthog618@gmail.com>
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

The documentation contains notes like
 This struct is part of ABI v1 and is deprecated.
 Use struct gpio_v2_line_info instead.

This could be interpreted to mean the structs can be directly
substituted in v1 calls.  Clarify that the user should use the
corresponding v2 ioctl() and structs.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 include/uapi/linux/gpio.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index e68a56969f36..103cd3c6c81e 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -333,7 +333,7 @@ struct gpio_v2_line_event {
  * also be empty if the consumer doesn't set this up
  *
  * Note: This struct is part of ABI v1 and is deprecated.
- * Use &struct gpio_v2_line_info instead.
+ * Use ABI v2 and &struct gpio_v2_line_info instead.
  */
 struct gpioline_info {
 	__u32 line_offset;
@@ -368,7 +368,7 @@ enum {
  * at the end of the structure on 64-bit architectures.
  *
  * Note: This struct is part of ABI v1 and is deprecated.
- * Use &struct gpio_v2_line_info_changed instead.
+ * Use ABI v2 and &struct gpio_v2_line_info_changed instead.
  */
 struct gpioline_info_changed {
 	struct gpioline_info info;
@@ -409,7 +409,7 @@ struct gpioline_info_changed {
  * a valid anonymous file descriptor representing the request
  *
  * Note: This struct is part of ABI v1 and is deprecated.
- * Use &struct gpio_v2_line_request instead.
+ * Use ABI v2 and &struct gpio_v2_line_request instead.
  */
 struct gpiohandle_request {
 	__u32 lineoffsets[GPIOHANDLES_MAX];
@@ -431,7 +431,7 @@ struct gpiohandle_request {
  * @padding: reserved for future use and should be zero filled
  *
  * Note: This struct is part of ABI v1 and is deprecated.
- * Use &struct gpio_v2_line_config instead.
+ * Use ABI v2 and &struct gpio_v2_line_config instead.
  */
 struct gpiohandle_config {
 	__u32 flags;
@@ -446,7 +446,7 @@ struct gpiohandle_config {
  * the desired target state
  *
  * Note: This struct is part of ABI v1 and is deprecated.
- * Use &struct gpio_v2_line_values instead.
+ * Use ABI v2 and &struct gpio_v2_line_values instead.
  */
 struct gpiohandle_data {
 	__u8 values[GPIOHANDLES_MAX];
@@ -471,7 +471,7 @@ struct gpiohandle_data {
  * valid anonymous file descriptor representing the request
  *
  * Note: This struct is part of ABI v1 and is deprecated.
- * Use &struct gpio_v2_line_request instead.
+ * Use ABI v2 and &struct gpio_v2_line_request instead.
  */
 struct gpioevent_request {
 	__u32 lineoffset;
@@ -494,7 +494,7 @@ struct gpioevent_request {
  *  %GPIOEVENT_EVENT_FALLING_EDGE
  *
  * Note: This struct is part of ABI v1 and is deprecated.
- * Use &struct gpio_v2_line_event instead.
+ * Use ABI v2 and &struct gpio_v2_line_event instead.
  */
 struct gpioevent_data {
 	__u64 timestamp;
-- 
2.39.2


