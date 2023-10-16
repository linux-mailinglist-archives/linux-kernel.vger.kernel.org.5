Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF447CA8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjJPNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjJPNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:00:59 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1EF2;
        Mon, 16 Oct 2023 06:00:57 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57be3d8e738so2598155eaf.1;
        Mon, 16 Oct 2023 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697461257; x=1698066057; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRSNHwdO/tIPJtA5wXwUSgkVx6Nppqe1ZqNrcskxaoE=;
        b=MgLhzfIaSEpBy6bFa38ReELtg2y8DNL8TWK3TuiRkH9EZHD3dccLZybxKA4njiHI4W
         mxUrdNF9lra9Txs5j7shDhZlpLe2+wjnoplJF3bl858IplSsmsmKKZYsNqdxABZ6kHLx
         5WylQRZ27JOl2Sz1tRgDpZYoVMGH76W59yd0LLewIKk4puPwnkRegE7+TKqv3guC7kwk
         bOfp9DTGMO/hrwgNVcmF40RighYVoQWm+pr4KpS+5eqJqOpg/pwj04ybK/uNRRaHywfl
         aD2gxNr1V0VMnUhj4jUexHUWsL3CI6iCkUCXvfSfm46iCmPq+jrm413eOwDMwW+DcY0N
         cGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461257; x=1698066057;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRSNHwdO/tIPJtA5wXwUSgkVx6Nppqe1ZqNrcskxaoE=;
        b=CvxcuShxBP/8PMVs8QOBR/N9KufwtWf2J/7aFUjAv6TS1CQeWu/eBgsPOireiq34PK
         RMFJf0WaOkj1ffrrWwb/jE0nM9u1v+kESskcKlMyVVFyH5uvSp7VqpNWO2Z/tAOsc+0C
         ndpGI4tYC7q1kYrINFfqvb0+VNRBk20HVQ+M1hDk3fR6ypAzKvSXgL155tms1kgCh16U
         QqK1W75hNmcxqg8gaTSVsPrQnz1+1qa0np2c8+quMHxSuxgPrRLw6XA+RPD9/8oEW8ax
         9JTJCibfZyGMxcXtrGUCEVe/Pazu20Eos03IzIHIuQ5JyxQv0VJJ7/IAUjNEAuKRFyyL
         4++Q==
X-Gm-Message-State: AOJu0YyZjg7ISLHF1q/Tg4gjMCTdDQvkJ99uv4iPxoJSHO0XfrctMJ27
        E+PxfOY8Chci97ZRIUeU6jM=
X-Google-Smtp-Source: AGHT+IHkqaGRFiSDzIC8/PY+WcmLdafEJPlOVfqU/vUx0GF0CaZ4cYipr6e7qW1L1NjWOrO9T9Ck8Q==
X-Received: by 2002:a05:6358:7e92:b0:143:5383:af8b with SMTP id o18-20020a0563587e9200b001435383af8bmr35449974rwn.11.1697461256761;
        Mon, 16 Oct 2023 06:00:56 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b0068883728c16sm18783070pfn.144.2023.10.16.06.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:00:56 -0700 (PDT)
Date:   Mon, 16 Oct 2023 06:00:53 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: remove unnecessary parentheses
Message-ID: <20231016130053.GA9696@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch:
CHECK: Unnecessary parentheses

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
 drivers/staging/sm750fb/sm750_accel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..50e51d730d86 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -393,7 +393,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
 	 * Return 0 if the GPIO pins to be used is out of range. The
 	 * range is only from [0..63]
 	 */
-	if ((clk_gpio > 31) || (data_gpio > 31))
+	if (clk_gpio > 31 || data_gpio > 31)
 		return -1;
 
 	if (sm750_get_chip_type() == SM750LE)
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 44b9e3fe3a41..bbef19a39f81 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -215,7 +215,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		}
 	}
 
-	if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT)) {
+	if (nDirection == BOTTOM_TO_TOP || nDirection == RIGHT_TO_LEFT) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
-- 
2.25.1

