Return-Path: <linux-kernel+bounces-20945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F5A8287B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AC71F22971
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B843986E;
	Tue,  9 Jan 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHxNVk/m"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910233985A;
	Tue,  9 Jan 2024 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3aa0321b5so27301535ad.2;
        Tue, 09 Jan 2024 06:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704809050; x=1705413850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC+N5XwBd3tXbkTJGYgV0uatnb4qRHovhLZ5WiV8jxM=;
        b=QHxNVk/mNx5Cyoby76CnG+HXM7hLPW1G6S8nsbmFDn1NfcLWHu91CC1cjaiS3nO+rB
         hYsy0HCfFKY5gZfzoibnMIoFbnoiYOuFE1zWA9SvQzTfBFRxHZWSLV8agCiErScMsd4o
         anztkRNAMCNAubeD0Fz/TXdSJ3rzU3mdw/7w+Whg9QAh32+IyqlXslE6Ije4vnCKwn0H
         KJ0CeUL9E48Z68tQ2RYcjsSSkAQnAD8GBvHqvAjpUTK7XqXjd3Skv9e1C+Kr2rdmseDi
         zxscMy+yIMOxMTiMJQF/CrLBbqZuwzeAD9kH39AUgeKXtcwh9SF2oEJL1SmbE5drmz1u
         tLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809050; x=1705413850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC+N5XwBd3tXbkTJGYgV0uatnb4qRHovhLZ5WiV8jxM=;
        b=Iw7b5AYOjU96KvxsvxPcLk6qwVi8k0bKVX8mWSUhqcpxoYe54VPyaosElLngfBizhI
         4fHOhXaZPtsXt1H+ld5CemAVKfKfGRIgCQPKdaIXOS6bl7ISuL5kt1K6dVcJz0sHza16
         GqvZ1cy/Q6qqUQEL6iHxJ+2aOago7Ov5d5p92qeTZp5BVbn1ouqeUvMmIykBVXZGa3Xz
         KLHRPSKUTPRG/6UekRaLAcFTX2JeWtYp4NPQb3A6ks6mwk3XjP+/9FWGUM6bsEurfbvg
         h3bocd5tpJ024H1DBgpN3L3IwXXcB3XHaOHUR9xbyNG/T8o3OogarIgFfiQKlhbDCg6d
         2PjA==
X-Gm-Message-State: AOJu0YwZzoTjyJzdZkWNzYylCsDiu7Mx9nzf7i0VI0x/yE03M4m5JgkG
	u1O5jSWxyRUDSXxkomvFsI32GNx5E4ZYAQ==
X-Google-Smtp-Source: AGHT+IFunOXy/18QOlHd6n8yIlKRJVXr3+0qvuGKu3d6jsiu7GiD1jkF+UFbwnkBMSUArZUiifGtXA==
X-Received: by 2002:a17:902:8a88:b0:1d0:6ffd:e2ef with SMTP id p8-20020a1709028a8800b001d06ffde2efmr5582875plo.137.1704809050470;
        Tue, 09 Jan 2024 06:04:10 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b001d538b6517asm1818362plb.230.2024.01.09.06.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:04:10 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 3/5] gpio: uapi: drop trailing period from one sentence descriptions
Date: Tue,  9 Jan 2024 22:02:19 +0800
Message-Id: <20240109140221.77725-4-warthog618@gmail.com>
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

Make documentation more consistent by using trailing periods only for
multi-sentence field descriptions, not single sentence descriptions.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 include/uapi/linux/gpio.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index 88c2a326940e..3ba8996e496c 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -88,10 +88,10 @@ enum gpio_v2_line_flag {
 /**
  * struct gpio_v2_line_values - Values of GPIO lines
  * @bits: a bitmap containing the value of the lines, set to 1 for active
- * and 0 for inactive.
+ * and 0 for inactive
  * @mask: a bitmap identifying the lines to get or set, with each bit
  * number corresponding to the index into &struct
- * gpio_v2_line_request.offsets.
+ * gpio_v2_line_request.offsets
  */
 struct gpio_v2_line_values {
 	__aligned_u64 bits;
@@ -123,7 +123,7 @@ enum gpio_v2_line_attr_id {
  * @values: if id is %GPIO_V2_LINE_ATTR_ID_OUTPUT_VALUES, a bitmap
  * containing the values to which the lines will be set, with each bit
  * number corresponding to the index into &struct
- * gpio_v2_line_request.offsets.
+ * gpio_v2_line_request.offsets
  * @debounce_period_us: if id is %GPIO_V2_LINE_ATTR_ID_DEBOUNCE, the
  * desired debounce period, in microseconds
  */
@@ -143,7 +143,7 @@ struct gpio_v2_line_attribute {
  * @attr: the configurable attribute
  * @mask: a bitmap identifying the lines to which the attribute applies,
  * with each bit number corresponding to the index into &struct
- * gpio_v2_line_request.offsets.
+ * gpio_v2_line_request.offsets
  */
 struct gpio_v2_line_config_attribute {
 	struct gpio_v2_line_attribute attr;
@@ -178,7 +178,7 @@ struct gpio_v2_line_config {
  * associated GPIO chip
  * @consumer: a desired consumer label for the selected GPIO lines such as
  * "my-bitbanged-relay"
- * @config: requested configuration for the lines.
+ * @config: requested configuration for the lines
  * @num_lines: number of lines requested in this request, i.e. the number
  * of valid fields in the %GPIO_V2_LINES_MAX sized arrays, set to 1 to
  * request a single line
@@ -216,7 +216,7 @@ struct gpio_v2_line_request {
  * @num_attrs: the number of attributes in @attrs
  * @flags: flags for this GPIO line, with values from &enum
  * gpio_v2_line_flag, such as %GPIO_V2_LINE_FLAG_ACTIVE_LOW,
- * %GPIO_V2_LINE_FLAG_OUTPUT etc, added together.
+ * %GPIO_V2_LINE_FLAG_OUTPUT etc, added together
  * @attrs: the configuration attributes associated with the line
  * @padding: reserved for future use
  */
@@ -273,7 +273,7 @@ enum gpio_v2_line_event_id {
 
 /**
  * struct gpio_v2_line_event - The actual event being pushed to userspace
- * @timestamp_ns: best estimate of time of event occurrence, in nanoseconds.
+ * @timestamp_ns: best estimate of time of event occurrence, in nanoseconds
  * @id: event identifier with value from &enum gpio_v2_line_event_id
  * @offset: the offset of the line that triggered the event
  * @seqno: the sequence number for this event in the sequence of events for
-- 
2.39.2


