Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB87DB962
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjJ3MAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:00:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCB19D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:00:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40838915cecso34701815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698667207; x=1699272007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aybSsE5M6yYzp+XWhdtnqDXvKHs19lnGyTCpqKxYFzM=;
        b=WnPW4u/x1Kv3xJi2I+0K0WuAK0tGvf7nZfFCfqqpNkUgzxbWlOK/qeFEhtCUF8Cyuf
         I9zxSoAwixRV+XiChuXf28c4L7wK7dffy5OfbEpRm8GkqBZ96XSiFaWgQd+ek4jFzBIL
         4wGiFcCyoSqKn79TazkBdBa3tMTmTwLRQC3ZJHHtpUjsjgFCNPVWt11vRsRYztOUxw9H
         u8PQSSSAajdwoh2Mi1W/pjORp/ZrDlCbV9KomULXpyFSvwChtuR8HtjT/2qPa+2t17LJ
         PCeBKDDHPezYQXD9irofQKqHfEa/G3UerLt+xkVhEvRy+CwvPvqK/WAFLqRm4201iuiQ
         jU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667207; x=1699272007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aybSsE5M6yYzp+XWhdtnqDXvKHs19lnGyTCpqKxYFzM=;
        b=FRXX3qHdst7aj827qu9hO+h6QXqsi7D0CoNnGLVnoXTAoPmdqYNCMhdfKdTB7vUzuK
         zUUKRBTThdMRSfj4hT0kGQnoogWgI+KBGyt7XxyHyLsfKCL/ljX1Gn7wBWu0b3aUzx+F
         WaeqSOvAIr2Qhv5e+R52bxq3i+e4TxvlGl8BKQHY/P+Qdt54LLYYI67fWC0kBDveqLVo
         BcM/EOMexOblajuHpI3FE8TciR45o8ZHOVjDdFdcmr2xNiZuDUud7UpK2DmCbBf6ESbB
         DsgtGAISpRpmjE9cJZo1cumzIu2/OlpySHTLIPuvgvwKPVs2lpGw+ADjogboA5jPQv36
         mRSA==
X-Gm-Message-State: AOJu0Yzcqk7T/VxKBKw/ZmvQFt4O0lospIXgJho2JPIrT8QOHkS1YOzU
        96cgi/pHJcgGtKe1LcgJx/seWiSFWyPt6B5W
X-Google-Smtp-Source: AGHT+IEzrqtVLIOkEcuNzpug5Nxyx+/pmvVtkUHYEvcEDOg+sIqSMBOa3ZVG9wsBVSQVwrfL+xFIsw==
X-Received: by 2002:a05:600c:4f55:b0:408:3707:b199 with SMTP id m21-20020a05600c4f5500b004083707b199mr7803003wmq.3.1698667206988;
        Mon, 30 Oct 2023 05:00:06 -0700 (PDT)
Received: from nancy-1-2.. ([105.163.156.232])
        by smtp.googlemail.com with ESMTPSA id s10-20020a05600c45ca00b0040772138bb7sm12572236wmo.2.2023.10.30.05.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:00:06 -0700 (PDT)
From:   Nancy Nyambura <nicymimz@gmail.com>
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Nancy Nyambura <nicymimz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Staging: rts5208: Replace strncpy() with strscpy()
Date:   Mon, 30 Oct 2023 14:59:34 +0300
Message-Id: <20231030115939.48985-1-nicymimz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

warning found by checkpatch.pl script.I replaced the usage of strncpy()
with strscpy() in the code(line 524) for the buf buffer to improve
string copying.This is appropriate since strscpy() is used when you want
to copy a NUL-terminated string and the destination buffer requires
trailing NUL-padding.

Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
---
Changes in v2:
  - Make the commit message more clearer.
 
drivers/staging/rts5208/rtsx_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index 08bd768ad34d..52324b8ebbc7 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (sendbytes > 8) {
 		memcpy(buf, inquiry_buf, 8);
-		strncpy(buf + 8, inquiry_string, sendbytes - 8);
+		strscpy(buf + 8, inquiry_string, sendbytes - 8);
 		if (pro_formatter_flag) {
 			/* Additional Length */
 			buf[4] = 0x33;
-- 
2.40.1

