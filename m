Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F67D2C41
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJWILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJWIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:10:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25750D6B;
        Mon, 23 Oct 2023 01:10:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d9b507b00so2212529f8f.1;
        Mon, 23 Oct 2023 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698048655; x=1698653455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7cqCaedoqoHpQD8+KvfrceThO52+AoPN4P2eMWZ0lk=;
        b=NJ33L3H/QTwpLwqP0Lm6GJvUVM9jH76LiIt0iTIljXBJUwK23+1iO7yINTxHIKv8ow
         6Vmid2unVbPV7jIoMMU4TeduilIlziXa0b8k4zx3M8tHkdCKDQnv1mPQrSkM0+OjaLnG
         MupX44pVFqSYMd2Yz6exZBXIndgjpwMJ1CpbyVw1jVWGEKomK7+cPITfQwUydieUkN0U
         VKKc1v0rWlHvpv1nkGvxZFqwdfUZnv6EagxYx+2PvvscN51i+Fe5v9r01deUpqoNksWd
         /uvyuOTpvlC4FWioJtR1hYcvXNjRZ/JufRrWhwbNka4wOCXAnV2ivByTfhdijKJyR87t
         uBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698048655; x=1698653455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7cqCaedoqoHpQD8+KvfrceThO52+AoPN4P2eMWZ0lk=;
        b=FRHMNP/DtV6pWR732dgZAjEyLG2sWgqUQi45hKW4HCP8YXgpRtj8ogqht0FSUghfUt
         Dlk79WK0jVHa28E4M5n0Mhu3V0deiunb48LdlAJu0kWWbimC5lX2AchD6jhx89rSwPqS
         cj05fY7ku8X4ftkkZk9fzCgswLLi1zUXYIBr0QTBVachSEHhTiCzemAdAwMejCPlc5Tx
         h6fAzhKqhs1of+FsLC82VFAv+vF+vNvC0OFT+GQ/pRjEpjRvoPDx61/sf6vSwUOmO/mJ
         dmIRj8JKQ/ttgzvwsajjy6InsINxVWjOE/DvbWWUxo741FKjk4hXjvwHwe1i3e6STvGm
         zyLA==
X-Gm-Message-State: AOJu0YygwLVZ0SqTQ1ZomJMCr2GEMxHJnkKe2HO5NIAJyHF5Rrwmdh17
        HIwL7YsRXJ3KU6Mez7KGTsCM8ZW14Kk=
X-Google-Smtp-Source: AGHT+IEuu1pCWAMxs1QZIe5QYfyRiSzhhF+pj2KcV9gO4YSBwJ73Q58dPai8HlEnY56JCt10KECh/Q==
X-Received: by 2002:a5d:4a86:0:b0:32d:a2c4:18bf with SMTP id o6-20020a5d4a86000000b0032da2c418bfmr5607012wrq.59.1698048655302;
        Mon, 23 Oct 2023 01:10:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y5-20020adff145000000b0031fd849e797sm7218480wro.105.2023.10.23.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:10:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: imu: Fix spelling mistake "accelrometer" -> "accelerometer"
Date:   Mon, 23 Oct 2023 09:10:54 +0100
Message-Id: <20231023081054.617292-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 0bd5dedd9a63..183af482828f 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -545,7 +545,7 @@ static int bmi323_tap_event_en(struct bmi323_data *data,
 	guard(mutex)(&data->mutex);
 
 	if (data->odrhz[BMI323_ACCEL] < 200) {
-		dev_err(data->dev, "Invalid accelrometer parameter\n");
+		dev_err(data->dev, "Invalid accelerometer parameter\n");
 		return -EINVAL;
 	}
 
@@ -1453,7 +1453,7 @@ static int bmi323_enable_steps(struct bmi323_data *data, int val)
 
 	guard(mutex)(&data->mutex);
 	if (data->odrhz[BMI323_ACCEL] < 200) {
-		dev_err(data->dev, "Invalid accelrometer parameter\n");
+		dev_err(data->dev, "Invalid accelerometer parameter\n");
 		return -EINVAL;
 	}
 
-- 
2.39.2

