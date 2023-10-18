Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4DA7CD196
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjJRBDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRBDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:03:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF292
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:03:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso10773614a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697590989; x=1698195789; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiAH34C/kctaaX3077HYkei7HPlkFJr20QXBxwSI6Qc=;
        b=iW2BmfRasYF9s0RmhEPPEWP+TKQWF6EjvQZfl+sRTtvkgyqWQtv+lRiIfqN3NOp3uM
         O16Aw2Nkiq42NjtOen0qRs2jydaG5CaJ2O2iNEWaVvjyv+6cIlc3UWCSwUdgfZu2r2Cx
         A7fmrJiFTQJiJc5Tzhedx6OZsFnNa9hP2s2RRw2cCCOy6avEZQCKe/r5l8jezq8InMUj
         Ugam2utXPjpeYoMiv2lFZVW7D+k/TvQZNDB10misCEKmnHXkpjcwwyyOu7UkRSZKEyma
         I/OAYVLYKMGTF6gHZn48dRiGtdsMBSbmMHl4gpMa7+rfq2iIQ+ht+fJr0xFsj4oJXCdz
         q+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697590989; x=1698195789;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiAH34C/kctaaX3077HYkei7HPlkFJr20QXBxwSI6Qc=;
        b=jW/V8eIoLi5oJcUoIBpBj/nnP8o1jKnLgFFVp/4n68r7YN44vL0kaNQgsy78Q8X9T7
         z83um+tSQW63Vs2m9u+R8spzvHBx4O3DWjC63yywVcOqH47eNlZDPq4v4Ywq4XBkAjS+
         XQtVVo4yXlRCJvrNlXgd4YYmNZGQ3RHloq+vH/ih5bdaV/MDbHSlqyFMFVYfxaI3X7QY
         B92NvUDHeCgk7CqcXj4ihTFwApeexCDmh0l24nV0BAoUXx8PLAqLuePf+Xy2pwkT/DN7
         nuXs3qKTRnqqMJQ6i+Di58bysReJManlSKpRrqvbcZwDb3SnTLEmlJjA7rpQMNWGFKT9
         lQ0w==
X-Gm-Message-State: AOJu0YzOgmpfyy1Wof4d9sk4XyPqLnvz8CS9xRQPjwD3dT54v3QaVsMc
        Iw0DH7OiEuliaicftb3fYRf5aj4thpUbjA==
X-Google-Smtp-Source: AGHT+IEOToHY+FjeZ1+QFC3prDpL+/1h01J16kJ+hEmruNGEAZNL8D/NLPUO3ox3BEM032g/UpDm5Q==
X-Received: by 2002:a17:907:36c3:b0:9bd:9507:ed1c with SMTP id bj3-20020a17090736c300b009bd9507ed1cmr3154408ejc.18.1697590989156;
        Tue, 17 Oct 2023 18:03:09 -0700 (PDT)
Received: from ubuntu ([129.205.113.163])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090673d100b009930c80b87csm616449ejl.142.2023.10.17.18.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 18:03:08 -0700 (PDT)
Date:   Tue, 17 Oct 2023 18:03:05 -0700
From:   kenechukwu maduechesi <maduechesik@gmail.com>
To:     outreachy@lists.linux.dev, shreeya.patel23498@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Replace delay function.
Message-ID: <20231018004300.GA3189@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace udelay() with usleep_range() for more precise delay handling.

Reported by checkpatch:

CHECK: usleep_range is preferred over udelay

Signed-off-by: kenechukwu maduechesi <maduechesik@gmail.com>
---
 drivers/staging/rts5208/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index 74c4f476b3a4..059f99b0a727 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -865,7 +865,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 						     PHASE_CHANGE);
 			if (retval)
 				return retval;
-			udelay(50);
+			usleep_range(50);
 			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
 						     PHASE_CHANGE |
 						     PHASE_NOT_RESET |
@@ -877,14 +877,14 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 						     CHANGE_CLK, CHANGE_CLK);
 			if (retval)
 				return retval;
-			udelay(50);
+			usleep_range(50);
 			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
 						     PHASE_NOT_RESET |
 						     sample_point);
 			if (retval)
 				return retval;
 		}
-		udelay(100);
+		usleep_range(100);
 
 		rtsx_init_cmd(chip);
 		rtsx_add_cmd(chip, WRITE_REG_CMD, SD_DCMPS_CTL, DCMPS_CHANGE,
@@ -918,7 +918,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 				return retval;
 		}
 
-		udelay(50);
+		usleep_range(50);
 	}
 
 	retval = rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
@@ -1416,7 +1416,7 @@ static int sd_wait_data_idle(struct rtsx_chip *chip)
 			retval = STATUS_SUCCESS;
 			break;
 		}
-		udelay(100);
+		usleep_range(100);
 	}
 	dev_dbg(rtsx_dev(chip), "SD_DATA_STATE: 0x%02x\n", val);
 
-- 
2.25.1

