Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184057A74C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjITHsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjITHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:47:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFFE4;
        Wed, 20 Sep 2023 00:47:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50305abe5f0so6275407e87.2;
        Wed, 20 Sep 2023 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695196040; x=1695800840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiROdoH/w6RO4T8v4L/D2wMa6DTfaV0sshbNKHl/Sqc=;
        b=DrS2mQoO7JEXK91qMbYdeWSpq0tx6CD3rch0bpk4F00jwj36/7CzTT/EUbp0P0HPxd
         OFFrUyZUA6Irj0HqAbkyEG+ZIyFmx+HpQPwu/MFl23qw05zooGIN+/uhY5o9zfvGEx+L
         v7gTkdgDyWdow0rRvnAhl4Bf30F39pZoTQziKj4xKkfrfxFZWW0sM3xk0H+Ok7ySIKjC
         VmbJjCr0N2Y2eVydPp9nrPcNAyIIHwFt3unIy7Dz0xq7UTAlvTcRfhMI9gcDYCeviouG
         UO9IpKUNzYHBqCzH13kDY4wcIE+vKWpP1U2rSGta0/VwlWnTYaq2mDV8z8Wx80aJ6SHb
         euIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196040; x=1695800840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiROdoH/w6RO4T8v4L/D2wMa6DTfaV0sshbNKHl/Sqc=;
        b=g7zApiXfnKD9uJlqUatf+9cf35j3iReNxrCir2vkiRywEkxePqHRksCxigvK77xt/H
         VRfuZI0x3MrW4xrJDsRkDAcflKY6qrveoPjgOrwmUBKl0jTyDzEQIuOO27pMdxZchzkp
         4gNlpym2ISMLD5nMeHGjstFwuqwVkLVaLzOtGlTun74lvSmacytUPg5mf74d6amYYK0z
         bXeX9O+RiqsSh8zVrM4D9XHtHfBIu5MVvKatCgfW+WRC8d+VAkMaqe2GUwVsz8QXKD4O
         71B6wzXyA70ditzYZKN1SXtymEzghS4vNto/8sJJCq6QFEkJ65SwcnYX7RxrN9g33G3Y
         F/CA==
X-Gm-Message-State: AOJu0YwHU5bhIEXCThN748vvebsYzThouT/OUSgZ7guz34yVqS2TOWNV
        tOA/w+pNJBqskXjHkveLFmGfXCGqgKqggQXo
X-Google-Smtp-Source: AGHT+IEh42GA3m8adzBJpTUtD8Z4DxwCwU2gQBF5a0RFIAgE0gQQya6HjUPx2E0eunpYTGcjxFk04A==
X-Received: by 2002:a05:6512:3a8e:b0:4fe:1681:9377 with SMTP id q14-20020a0565123a8e00b004fe16819377mr1830125lfu.44.1695196039628;
        Wed, 20 Sep 2023 00:47:19 -0700 (PDT)
Received: from emanuele-nb.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id p13-20020a056402074d00b005224d960e66sm8438186edy.96.2023.09.20.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:47:19 -0700 (PDT)
From:   Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joe Hung <joe_hung@ilitek.com>
Subject: [PATCH v2 1/2] Input: ilitek_ts_i2c - avoid wrong input subsystem sync
Date:   Wed, 20 Sep 2023 09:46:49 +0200
Message-Id: <20230920074650.922292-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
References: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

For different reasons i2c transaction may fail or
report id message content may be wrong.
Avoid sync the input subsystem if message cannot be parsed.
An input subsystem sync without points is interpreted as
"nothing is touching the screen" while normally this is not the case.

Fixes: 42370681bd46 ("Input: Add support for ILITEK Lego Series")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 90c4934e750a..0c3491e346f4 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -203,9 +203,9 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		ilitek_touch_down(ts, id, x, y);
 	}
 
-err_sync_frame:
 	input_mt_sync_frame(input);
 	input_sync(input);
+err_sync_frame:
 	return error;
 }
 
-- 
2.34.1

