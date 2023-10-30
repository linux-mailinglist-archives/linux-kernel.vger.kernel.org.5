Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869CD7DBBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjJ3O2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3O2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:28:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B8B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:28:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d834ec222so2866500f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676079; x=1699280879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bh30D821O7pisqZqTkIBA0xZHpQPYVy9p5w5SCB02E=;
        b=GjlSjuRXPQ98phgFdg/9m6Hz/PbHIIy5OPcIdiVJQ4t4UFyDL3fKOttVTh87jYe7V4
         Zsd36EQF0merQf/Zcs0hoauva1PVVSr1MM1cFLHuPPGPHJwz1r4pVHJHCsE1m0tKYqEo
         DteU1KjCaW0D4tmc8BzsLwbNeZAHigNH0AKXL4imaSBgWpuw6537XtBGuN08wz5cTzdc
         08o44V43C6WfP2iTAYDMA4Rj0v/MV/ItD5aOyonsqlPHu8eEcf5RgmWwxSwov14SzLN3
         gIVhiD2YHC1SZtWF9/1EBoL0xzHOmoOKo0fx5oy4HG/XwrXMM9mnUpFfAClmIXuiPsT0
         ArkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676079; x=1699280879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bh30D821O7pisqZqTkIBA0xZHpQPYVy9p5w5SCB02E=;
        b=xVJXxEblU/AraTLz4L5Ac1cEXoyHsTiv+DJospf6nnSi+68+FZD2MSm1nJJqTgH1km
         DGKK3O+P4SKwLaFmKjrvGi4psv04UucQdSCgRpwCZcDNFAKCxRF8M/t0xI6wOWTbCGRr
         UCMtcr+kg3I/NB5KeVDcQdJqspT/rruKfI6CC3z/3C9WvU97VAMSivNBPeBQL9HGWpGi
         x/Bf7Nkex8kHITkWuVwzqp+BZgsgxImU2W0e0GZ8huynHHMoZLRwgfad+nIKQIz2UapF
         Qu5h8OH/I3xfxG/hCJmsaJiQtO0BRNnDVLy3oK9g4TH4qt8ONXCvAk5Fz1ilvSipLdoz
         MjHQ==
X-Gm-Message-State: AOJu0YyGJutVcSH11dkJEEvuArBZ+NRaMurm4Cuh/e5cZduKTUMvAnjx
        YBHR/yEC0BMoGgqLhJZr9Qp5LCEip9tX0GvZ
X-Google-Smtp-Source: AGHT+IE3SQg91TEitYFJnQaQAgiOXMoUSTQs8i2qySEtTVeVUoQXBmjsnkqttxIyG/Sf9l0B1dk1Iw==
X-Received: by 2002:a5d:64eb:0:b0:32f:79e5:5ea9 with SMTP id g11-20020a5d64eb000000b0032f79e55ea9mr4382841wri.10.1698676078663;
        Mon, 30 Oct 2023 07:27:58 -0700 (PDT)
Received: from nancy-1-2.. ([105.163.156.232])
        by smtp.googlemail.com with ESMTPSA id d14-20020a5d4f8e000000b0032d96dd703bsm8276569wru.70.2023.10.30.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:27:58 -0700 (PDT)
From:   Nancy Nyambura <nicymimz@gmail.com>
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Nancy Nyambura <nicymimz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Staging: rts5208: Replace strncpy() with strscpy()
Date:   Mon, 30 Oct 2023 17:27:47 +0300
Message-Id: <20231030142751.49913-1-nicymimz@gmail.com>
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

Warning found by checkpath.pl
I replaced strncpy with strscpy because strscpy is suitable when the destination buffer is NUL-terminated, which is often the case when copying strings. Strscpy ensures that the destination buffer is properly NUL-terminated without padding. In the code, the objective is to copy a string (inquiry_string) to the buf buffer, and it's likely that the buf buffer is NUL-terminated since it is handling a string. Strscpy_pad is used when you have afixed-size buffer, and you want to copy a string into it while ensuring the remaining space is padded with a specific character (like '\0') hence not appropriate for this context.

Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
---
Changes in v2:
  - Explain why strscpy and not strscpy_pad

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

