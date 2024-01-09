Return-Path: <linux-kernel+bounces-20944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC38287AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2AD1C2341D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1B39AE0;
	Tue,  9 Jan 2024 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQy29gvl"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465F39ACF;
	Tue,  9 Jan 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d54b763d15so10476415ad.0;
        Tue, 09 Jan 2024 06:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704809039; x=1705413839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IX5MdgvHzcC45EGoxSUtgBkn4tauaq0JPFZeGgYcY8=;
        b=ZQy29gvlSQ34hakbklkicCv+KDd9oS1RWxc5nutOYFjYyk45+SiwKaAOZoGMPSpex1
         bQzkgMBWtYlPaVAmWUYWSq0qGJv+Dv4hP2WPiis8VZaStcbwx6Eh4dsN/kATjKBYDRgA
         NKgjoNfo+oo+9VZF3KdwfRO/Jb/84MA3XCzfcOcplS4PNafhkP3tl0dackPEjgdFrK7l
         /ERGl3D74YoquoR5b5nkf0wa4YH9g3J6OPMqqYO9ipW8BY82sA67q5qgtYvYFGnMsMGH
         Nk9Tdt7vcfcgFpuWnJzBDEvOQa30nQGg84TWLr308D8SZuNnoD3sFS/I5wxQxBiZ/lBX
         TaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809039; x=1705413839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IX5MdgvHzcC45EGoxSUtgBkn4tauaq0JPFZeGgYcY8=;
        b=rbD0JowrAX2hzE9wnkDLypE2NhEyiHyi9Ea8TvFZPF4yY6PL2vhaAEp+rTxL7szIOT
         +HWBB9TTCukIGUlhhKxopQdHs6NJ72tZ6oM2Pu6UzkDgAGsQYJa4zSsdnJbOhD8ol3YN
         lS6xNKRKVo2KV9zFWZzTSIRssRfmE5Cp6ndVneNDt0mJkdcJLNbrzxo0YakfZ+AWVLGc
         SzA8a/KYgCu7gprfgY87cGOkOMYKBX3IuUrgNf0GkJjwfxvWZLqhnzD9RrO8EdoTMKcd
         i9SlTlLGkVsY8EwYeIONDih5Sjce3X6mrIyO0rAvjBoV0KY+u5Q66yDv7coLbwolV3in
         YO0Q==
X-Gm-Message-State: AOJu0Yz1qoCLKELTrR2DQUguiAcA1eG/kh0t3lx7iD2wxXqKysbyBKXL
	R2k+3NGF+KEPKgTCFsFA4hERmG4PPLWhEA==
X-Google-Smtp-Source: AGHT+IE1B+5E4yXZiHr/7k0nR/SqU7friTO3wviR2qf5qMYoO/dj8rWkZ5REohbVVu8PAXIXDlnmAg==
X-Received: by 2002:a17:902:d389:b0:1d3:2e0e:c889 with SMTP id e9-20020a170902d38900b001d32e0ec889mr3250366pld.62.1704809038948;
        Tue, 09 Jan 2024 06:03:58 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b001d538b6517asm1818362plb.230.2024.01.09.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:03:58 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/5] gpio: uapi: clarify hte references
Date: Tue,  9 Jan 2024 22:02:18 +0800
Message-Id: <20240109140221.77725-3-warthog618@gmail.com>
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

The full name of the HTE subsystem is "hardware timestamping engine",
so correct references and highlight that this refers to the HTE
subsystem.

Extend the description of struct gpio_v2_line_event to clarify that
the timestamp_ns is sourced from the HTE if the
GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE is set.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 include/uapi/linux/gpio.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index 650c1099d1a6..88c2a326940e 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -67,7 +67,7 @@ struct gpiochip_info {
  * @GPIO_V2_LINE_FLAG_BIAS_DISABLED: line has bias disabled
  * @GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME: line events contain REALTIME timestamps
  * @GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE: line events contain timestamps from
- * hardware timestamp engine
+ * the hardware timestamping engine (HTE) subsystem
  */
 enum gpio_v2_line_flag {
 	GPIO_V2_LINE_FLAG_USED			= _BITULL(0),
@@ -288,6 +288,10 @@ enum gpio_v2_line_event_id {
  *
  * If the %GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME flag is set then the
  * @timestamp_ns is read from %CLOCK_REALTIME.
+ *
+ * If the %GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag is set then the
+ * @timestamp_ns is provided by the hardware timestamping engine (HTE)
+ * subsystem.
  */
 struct gpio_v2_line_event {
 	__aligned_u64 timestamp_ns;
-- 
2.39.2


