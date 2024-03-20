Return-Path: <linux-kernel+bounces-108420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B05880A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4584E284061
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE137182AF;
	Wed, 20 Mar 2024 04:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b="OdIRwc+B"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FA1799B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710908433; cv=none; b=GF/0AJBjlwoJncoa2sLTqaN/TNxSTmGw7InB+wpfylse2q6Zg0V21RgEMKQ/lsY/2rjswsHuMd2il/j+oMGPC0qtIK6z1ODrPpNxfSEQKy2NPu3G9aGHZZKjhhwErEXWIWtc3Mw7C5Qc3Gxn3yJanC3d39nDd3M0mPzdtRJcymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710908433; c=relaxed/simple;
	bh=BxX5FQpfU7ryyCmToAmFws1m7NS1nntuj2W5QNchcRU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jOUE3k41UXgkOjdE3RMs5xcRQjxNuPV6TwspFGsZ0cGN9Ys0UWV8Mjy4iSl5Ezhna3oHOBCG+g+wZbrYH9l2SjC9bmVQBG2XjR0ZCV01LWsHah0mGje34QFKEwQtm+q2gGrCGyDmu8OfNqpKMIr015cpnI3b9QMpiCTSPKWx6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com; spf=pass smtp.mailfrom=turingpi.com; dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b=OdIRwc+B; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turingpi.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a0932aa9ecso2423323eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=turingpi.com; s=google; t=1710908431; x=1711513231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3fWtKmJ3MfVCnV+E74sqM2ekSX6lKZRkdLbepWZrZ6o=;
        b=OdIRwc+Bk+tmrHdwVRQsldrFZiiNe52dTJr09D+2xhTl6UBXcJJi7TBKjw+49X/1j9
         1miYGaNMMp2FZahv3wKQRx/KvBwDEPMipgwL0CNawEPfE64E6PDMwfZqJfkdasJdO+L3
         w+XjbcSq5IKPs54OTeZstNEhCp12bBa3xlhKquLwavVykFnnA4wTpFtznpejEQTR/Ozy
         B08DophkjBunpuKmOCNEGkIvpUmtlpe/jo3witFzVyncJPGZady4OnotM98TglIJ0uQG
         tnrP74EBxe50MyXDH5rx5O7DrFzAHD6gQACa7zh2tBh0EaoAikw3Eww9tpl+uQh9UFTZ
         B5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710908431; x=1711513231;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fWtKmJ3MfVCnV+E74sqM2ekSX6lKZRkdLbepWZrZ6o=;
        b=e+rARLkYUQq5XAVWWrR84VvrG4XNPZSBph05afbROvj3gKt2ijNfP2wgxeGaTdO+VB
         Ki3qngBmSQnH32UgTy8TT1AzhDJkFGYfZlITc5RhwguCes+A1prKy2WZNJs+qHPFq8Ou
         n31sOCkHtHXy+Eo8Yvi6frEsKAQgIJHystLdyOWFUFmTbEASiiEFOJNTM2hUeztp+cMJ
         zTSCe1106YiQKQBDWl+UkhOMedyVATwjBppBpbel2OKh5Zm/3nRsKpe2pT+sLwj8hIUe
         yTyAFqIpSZ+J4QN3eJs4Y1fxM1/JTEnPRMqyTCVEFKV7eBoBr4BQf3+PzEQckhmfSq83
         bYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWASGWFbB7X7YhCn+vtvKwCIVyx1s59WYaYlt6/2A6SD50PFoHQScXzpiVdlfRDHAFus4RJd+T6WjSmNXqBbU3kXXOTWl0an9pDJ9VS
X-Gm-Message-State: AOJu0Yxttrid4ofU+m9KS6jTrl2zCXBZUjLNDuSFWbgwEagf7FrhxG+S
	VG0pMz/ZDR2HZuYUUUY/5MmDiboSamGIErOvusnOdAONtGVKX3TUk7VFkszxYPHVd9HbEwlv6hq
	72OqtaBccMCIvELy/9QLL40VMQj2wtNDrKGoObw==
X-Google-Smtp-Source: AGHT+IFN6M8w1apocywAYQoQVW8GClTgKjY7u+bmQrz7JBQVn0gQDUfr8+LYrMWU5Bh08mcydgynecAP9NjVEwOKlto=
X-Received: by 2002:a05:6358:938f:b0:17e:69cf:2105 with SMTP id
 h15-20020a056358938f00b0017e69cf2105mr16163747rwb.29.1710908430736; Tue, 19
 Mar 2024 21:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Edwards <sam@turingpi.com>
Date: Tue, 19 Mar 2024 22:20:20 -0600
Message-ID: <CAF8uH3uAFh5wFSb+mfJn9LBNyMQZ_j+6sr+smmOeqF=tvUe0cQ@mail.gmail.com>
Subject: [RESEND RFC PATCH 2/5] i2c: mv64xxx: Clean up the private data struct
To: Gregory CLEMENT <gregory.clement@bootlin.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There are many fields in `struct mv64xxx_i2c_data` with `u32` type
despite this not being the correct type for those fields.

Change the types to accurately reflect what is being kept in each field.

Signed-off-by: Sam Edwards <sam@turingpi.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index cfc16909fba3..bb048e655be7 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -83,7 +83,7 @@
 #define        MV64XXX_I2C_BRIDGE_STATUS_ERROR                 BIT(0)

 /* Driver states */
-enum {
+enum mv64xxx_i2c_state {
        MV64XXX_I2C_STATE_INVALID,
        MV64XXX_I2C_STATE_IDLE,
        MV64XXX_I2C_STATE_WAITING_FOR_START_COND,
@@ -95,7 +95,7 @@ enum {
 };

 /* Driver actions */
-enum {
+enum mv64xxx_i2c_action {
        MV64XXX_I2C_ACTION_INVALID,
        MV64XXX_I2C_ACTION_CONTINUE,
        MV64XXX_I2C_ACTION_SEND_RESTART,
@@ -121,21 +121,21 @@ struct mv64xxx_i2c_data {
        struct i2c_msg          *msgs;
        int                     num_msgs;
        int                     irq;
-       u32                     state;
-       u32                     action;
-       u32                     aborting;
+       enum mv64xxx_i2c_state  state;
+       enum mv64xxx_i2c_action action;
+       bool                    aborting;
        u32                     cntl_bits;
        void __iomem            *reg_base;
        struct mv64xxx_i2c_regs reg_offsets;
-       u32                     addr1;
-       u32                     addr2;
-       u32                     bytes_left;
-       u32                     byte_posn;
-       u32                     send_stop;
-       u32                     block;
+       u8                      addr1;
+       u8                      addr2;
+       size_t                  bytes_left;
+       size_t                  byte_posn;
+       bool                    send_stop;
+       bool                    block;
        int                     rc;
-       u32                     freq_m;
-       u32                     freq_n;
+       u8                      freq_m;
+       u8                      freq_n;
        struct clk              *clk;
        struct clk              *reg_clk;
        wait_queue_head_t       waitq;
--
2.43.2

