Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4627AB8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjIVSFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjIVSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F3E173E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fe2470d81so2276343b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405245; x=1696010045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34/nNW3TrNCCiLSv5/UFr3FBjilgfcwTPeGBR7Y+KOg=;
        b=kpy/YxNCeA8VgfZ4q8DplmSWRDgPWdc/dbRPlfnvYTOd58U0CpT++wHqDbBFBBBsY0
         bA/5WfRwlObEKKgoj4mcuYFr0+7xxA3M4swptJMldjxyLI2SWvCGP6GuUujtnLxsxIpK
         Y4CwcMV1qYnqOQm5bLyabypjv3f7oQPI06fNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405245; x=1696010045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34/nNW3TrNCCiLSv5/UFr3FBjilgfcwTPeGBR7Y+KOg=;
        b=EhAXqfQEt8nYiyZaCgowgBR6dcagJnUtBXKiWUsIy3u6MHFFGBuCMcNfp8p4mf4GVi
         vrZ0SBDUo/M6M1jHtYmnG/JxpG4k2X3TKTfCbaw/nOI/1BGCghQLRa84+ZFDG5bPt8xB
         AOKohKr4rqJ9KycIoOcSEPuJAQQdtbNspsfrF7elIq4scB7qAtwlapd1EMVzjXfqXM1b
         YbBPaGBe9Yso8sQWnEf4FzuHrWumWBvEudcEeIZdpGcT5EOhSc6ZDP7MB5yH3Nx2hfA/
         x9m+mPeh7klDNEKyY7Q9z8fpoXGZbZIywAS+HFXoFjI3v22bjYBWvh5pT1KoIqy4wrZL
         X54w==
X-Gm-Message-State: AOJu0YyvwvUdgP5QANy4EvsnbScKIw9T7eW6C+TKPW5e4ReesZJ1h1D1
        EsnY8kMMdB5KIcbfnns0/FZ7iA==
X-Google-Smtp-Source: AGHT+IFu8Si52robeLLrv7QnuV/ngmZ3vweNN3Fajk9liMS4mVgXsR5xejFs2KwwI5VKN4JuZFZUMQ==
X-Received: by 2002:a05:6a00:c8d:b0:68a:5cf8:dac5 with SMTP id a13-20020a056a000c8d00b0068a5cf8dac5mr127580pfv.22.1695405245065;
        Fri, 22 Sep 2023 10:54:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f14-20020aa782ce000000b00688435a9915sm3439900pfn.189.2023.09.22.10.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] regulator: mc13xxx: Annotate struct mc13xxx_regulator_priv with __counted_by
Date:   Fri, 22 Sep 2023 10:54:02 -0700
Message-Id: <20230922175402.work.819-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=keescook@chromium.org;
 h=from:subject:message-id; bh=KsJXBGQGMKJej0OmC0WobZxtXra/Rqrs6lS3YBrQxLg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdS65hlSt0m/5qN8cc1VbhNamI8AY6+v5Gz1j
 6eiEzywV7uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UugAKCRCJcvTf3G3A
 JqyGD/9pxwUKyDCjaZwj9tRB6UH/KF8LOnItZsH2iWppBUJlMgX6c/2nT3syoqOJIqdnjmGOy8x
 f31ZyXzoPfdM0cIB2EPlAcWJsgK0IsUQ7fu2DHguSCWI02jL3IsUBBAAIwcklO1cM3F5qK54bwg
 jpELuZ53P91AHde5cplZD7CVHE61R6v+l1uug5MZTGzVUTnMbOL981zCABasMfkf5ujXIGq4Evs
 YUpeEMGOQWpL+dQkOzzr7DsOQIesMw2QM4enlSAA+7uwiROnq4xsiN/Bf3qRrLJBOYS0bwtA6H1
 S4usjGaAdXG127q9X34O7FFaE8n6rWviCZRREj2/+gbvk5ctM59ivqzGOP68wkG3WmoW8SFhOIq
 AWi6JH4i9QKhPjABYlalaRJ/sKV8uTQ32zP+S9+IZUvFUUse5N1SUV5bwkxDdCjoBSb8wqSN64z
 THOtdT7oDqtbkI7yG6ypfVR/YAl6MqwJhXn9yKSHbsZ07Zwh4V4MNVnrk3n7fzqfgMWH6a6KS1j
 gG4AWZjqfTWRugQGAA8077LwNOtyj8fyitwS2rdInDXYuFypO7/t/ioBfVxFSI2voeaFBirgUnA
 juPDUPRsEmPAzhrHaoGA3SEML+Gc9BX5ec5sEJ/s1OHDpx6JzekOOg3DbrC68Tv08s/56UgL11O
 w0QX184 vDcslfWg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mc13xxx_regulator_priv.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/regulator/mc13xxx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
index e03279dc43f4..057aaef6f086 100644
--- a/drivers/regulator/mc13xxx.h
+++ b/drivers/regulator/mc13xxx.h
@@ -24,7 +24,7 @@ struct mc13xxx_regulator_priv {
 	u32 powermisc_pwgt_state;
 	struct mc13xxx_regulator *mc13xxx_regulators;
 	int num_regulators;
-	struct regulator_dev *regulators[];
+	struct regulator_dev *regulators[] __counted_by(num_regulators);
 };
 
 extern int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev,
-- 
2.34.1

