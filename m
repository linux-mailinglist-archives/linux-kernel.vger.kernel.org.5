Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA77B62DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjJCH4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJCH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:56:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9193590;
        Tue,  3 Oct 2023 00:55:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c3f97f2239so4869835ad.0;
        Tue, 03 Oct 2023 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696319757; x=1696924557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sG3es9LOJNepHfcbLIqaZEQhm2bx01GFyqQ4WaVdb2o=;
        b=AzzwuUwdt/S5aYIUoGTNW8de342rxLkF4Dy3eeO9vsoGP0iz0oKaESEBJT1d1qYwVo
         CFuxxoNUn3/GzOhBYDGgGSpWjXcabpfUEcHrTdOI4M/EdaUh2lGSb6vOdIEmooV5PG+x
         Ll+Jko9RABzlIW8VmHbvMlVzafMnCh2qYOKHBo5grND8VzP7mSLkpCoJuvqZ6224Z/4W
         anulHA+eRfBCe8YVR4uqDgPR/48l2FuNYBoVkeT6T6tPwrsH32UVazmezrPiv49t/P9O
         zpRAnO7JrBWR1aXMCrJQ5TmEK+B8uaqTuUcLrOb3McPTYB26SZnCLufw+Oq/me/eQ2EW
         zQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696319757; x=1696924557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG3es9LOJNepHfcbLIqaZEQhm2bx01GFyqQ4WaVdb2o=;
        b=UArfUsnyhNpSIf9CjhsSu6fxjLH4bCglESB1jtw0FGla/YpvdRiuiGASt8lYDYIVpi
         pH2xW3tsQM558PvmmNkklM/168mSmtaZT/woXFt+KljfqE6NAKh55xW5QJkvDdXO4YE0
         T4vFVXJBBOU1GQfm3qDeqToOLHgysVtFA34erJeOyl6tEw5Up8fLKNnwetwPev7PguQl
         EI+Jmq6AQp8GQEzPSnDTdAaGy37LnPc5bBX8dpRbADEHVVAhP+bDyY36GPPR7u3HLsE5
         O74fMwyvg9lOFzokB00DYPwUL4nTIeTqDhcs5ebD1233DZeEji0HEO7TYsgMe5DurQOC
         grvA==
X-Gm-Message-State: AOJu0YyPL1fkwmuYX24cVNLVVuVI2tN6v4hp8l6SyZ8X2QqVJ+YbpW3H
        jd81pxJSEUiO8+8hi0LhgVA=
X-Google-Smtp-Source: AGHT+IHhmZBOFn6Hs3oxgHYi5uC5mu3CgaLNKzsBGSmH19XKhhnKWblUyoME4YnWdi7174VdRHyNzA==
X-Received: by 2002:a17:902:9b8e:b0:1c0:cbaf:6930 with SMTP id y14-20020a1709029b8e00b001c0cbaf6930mr12697266plp.54.1696319756505;
        Tue, 03 Oct 2023 00:55:56 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001c75d7f2597sm786442plx.141.2023.10.03.00.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:55:56 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     dan.carpenter@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH] media: nuvoton: npcm-video: Fix sleeping in atomic context
Date:   Tue,  3 Oct 2023 15:55:12 +0800
Message-Id: <20231003075512.2081141-1-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix sleeping in atomic context warnings reported by the Smatch static
analysis tool. Use GFP_ATOMIC instead of GFP_KERNEL in atomic context.

Fixes: 70721089985c ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 drivers/media/platform/nuvoton/npcm-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index ac8d73b794d3..5d160978f7b3 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -412,7 +412,7 @@ static unsigned int npcm_video_add_rect(struct npcm_video *video,
 	struct rect_list *list = NULL;
 	struct v4l2_rect *r;
 
-	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	list = kzalloc(sizeof(*list), GFP_ATOMIC);
 	if (!list)
 		return 0;
 
@@ -467,7 +467,7 @@ static struct rect_list *npcm_video_new_rect(struct npcm_video *video,
 	struct rect_list *list = NULL;
 	struct v4l2_rect *r;
 
-	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	list = kzalloc(sizeof(*list), GFP_ATOMIC);
 	if (!list)
 		return NULL;
 
-- 
2.34.1

