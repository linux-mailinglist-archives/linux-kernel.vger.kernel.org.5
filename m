Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4978120B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379107AbjHRRfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379158AbjHRRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:35:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C69D35BB;
        Fri, 18 Aug 2023 10:35:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so1731236e87.1;
        Fri, 18 Aug 2023 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692380117; x=1692984917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiMknwWiI/v3kIC+b+3OynYfcyNkWmEQwlCsvT+Xs7Q=;
        b=CoSiPPXHdRikO+8Fl1GgLfBuikUcbtod2WpPXlxrDoJhj7WD2DDSDT2pQwr8Puptim
         EM/y7Pw4NiT5AUdT0OdAh+YBPAhwf5bjRKfAZK+mo6h1piJaTfeAuTkgPeMTEulQ21cu
         feEIKqHgIYILZZwsJFkveQZf2xfHwVXyxUUzi99q0iCNYpnjWMRG1ViL3ePHbO63oPLp
         EdSq7sVWQI8bhNZ/csVUAJxUyNuQQqtj/2z6cTNqyjAV9GPGrsTxPqc/9eB+G9w0Eehd
         blupITOpWl1nawtyvVZ8aV7PwMsD8msPZ549owmJh9h48SF/qjHKRar2v8U0EqMXvcw1
         1bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380117; x=1692984917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiMknwWiI/v3kIC+b+3OynYfcyNkWmEQwlCsvT+Xs7Q=;
        b=J32/KRlJbhGfpHPbKl+2gdCDtyasuvkKlKRU1OP2X4QHn9Lp+euv7gVvMyZIPwOtiN
         QoP7E6Kaw/vZj4my6+n5Z6VSETZkMhafgtvgj26bk4VSzVJKiXDcW6GZSVfpEGH71C/F
         S5WroXSbNKFh7+p3VixKxNXReuTLt7FpEXlRFsx9tYSG1KmRLwKtJLhQKwATisT5dQOj
         OY8dDqbxyyc7SRb1OGJ9K/rYzWszT3VuVZFixvOTdm0JHTLmjYnLGePQNJXGlitqTk3E
         dywHLMXV/aiSEct/wGEYpbPEj8yC5jxdRgIdY4Ox+UCSnOugMA/WTnuccmhalCZjjqGE
         MS3A==
X-Gm-Message-State: AOJu0YxWr2W4Jl8xR528dre/rb/jQx0K7fSdSrUAWUpsGcCTov7mw336
        4+pxBzFOv3zWzF+dZjRRk0w=
X-Google-Smtp-Source: AGHT+IFQoJilVwLY4JS7e1gJd/c86pU8tIYv6vFIi5J2UB85lgHT+P1feOEgk15vsgdHMhZVgpS7ug==
X-Received: by 2002:a05:6512:2804:b0:4fe:7df0:41ab with SMTP id cf4-20020a056512280400b004fe7df041abmr2124147lfb.17.1692380117114;
        Fri, 18 Aug 2023 10:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id s12-20020ac25fac000000b004f9c44b3e6dsm420898lfe.127.2023.08.18.10.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:35:16 -0700 (PDT)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] media: ov5640: use pm_runtime_force_suspend/resume for system suspend
Date:   Fri, 18 Aug 2023 20:34:16 +0300
Message-Id: <20230818173416.2467832-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.40.1
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

If system was suspended while camera sensor was used, data and
interrupts were still coming from sensor and that caused unstable
system. Sometimes system hanged during a resume. Use
pm_runtime_force_* helpers in order to support system suspend.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/media/i2c/ov5640.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 5fe85aa2d2ec..8130471caaa6 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3970,6 +3970,8 @@ static void ov5640_remove(struct i2c_client *client)
 }
 
 static const struct dev_pm_ops ov5640_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(ov5640_sensor_suspend, ov5640_sensor_resume, NULL)
 };
 
-- 
2.40.1

