Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5277E9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbjHPTiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbjHPTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:37:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74D21FE1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:37:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589f986ab8aso3736987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692214673; x=1692819473;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/+LjxTcw3v2yMw5zpUVuw9q5BXCTvUMFQpgpNYN1QVg=;
        b=1RfasmD5jzy0I/e7fuP4O4msfCkc4u2H08gbfAC3qAftXA19agDf4QuMpKi7mcsQzz
         7A8usSg1wizAqPFu8bw91CUEJoYIW+aa8Lu60tYXwAZJtdJgOG1t6jZi2d1CyZ+AQVsR
         6NlE51G1wSnE5Iqd82c4OXO+WwZIq5rVrGSkuPo/VweY6XLbkWi83BrvP8FwYcQATKAY
         F2LrJax10hZWS/YPww0yQbFbomashQmlx003/LCfvl6BAx9+AusKYSN6U8+vJfOc8LSn
         iePayOwC+1s+oBAVaKDuJTf/W950iu8gnYBZO4q6zUhfgEBxA5uxr97nKKzbmRm2NXK8
         34QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692214673; x=1692819473;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+LjxTcw3v2yMw5zpUVuw9q5BXCTvUMFQpgpNYN1QVg=;
        b=UJj38XWmK8Kqe4n6OtaOrlgLkEIBjOLHQGLhCgjw42EbtP+HNnl6iIo6hATYMPbpnc
         UkPY2Ro1dtr/DyLIg9plo2iivHHooLzN16QEGXYtM37tRWkuR3f8I2dyCvea2O68Unpw
         FEET1inOh2vvryvWb8pt4JlyIPX50S2lNcXbdyUe+xMZPf8l1M7qxcz63eFh685NExzC
         sAmU2eeG8HahJcLoVH17OPhrfAircnkkNcYEDOKisCrskio2SkRGlp3c2xqRqQsSJJ1B
         C9dOfRhNXZ+t6xJtcYY6578Yn/Wnb1tw0Oo3o3vsx3wRam4m3quk341ZoBqW1shnXFHn
         b9UQ==
X-Gm-Message-State: AOJu0Yw7lOEgPUE926VrBdcsgaRRhQHnoE2AwuDoCpJ+ZCEeUDkzfF9F
        /bfcl/S0GcjGEQzNPUdkJumrKTOQFp4SCQFYcw==
X-Google-Smtp-Source: AGHT+IFSPI1nblCHVMtOyfqUjsfaIPN4xVKpcpnHV1rjUFdjIsIGvbSQUjHcmsRPBah8JEyGwYVPR1Ff456AHTz/bg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b623:0:b0:589:a3d6:2e02 with SMTP
 id u35-20020a81b623000000b00589a3d62e02mr11481ywh.3.1692214673138; Wed, 16
 Aug 2023 12:37:53 -0700 (PDT)
Date:   Wed, 16 Aug 2023 19:37:52 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI8l3WQC/y2NQQqAIBAAvxJ7bkGNsvpKdBDdaiEsVpAg+nsSX
 QbmMnNDImFKMFY3CGVOfMQiuq7Aby6uhByKg1GmUb3uMB8cMAhnkoQ7hR+nd0PbXmiVMt531pl BQ4mcQgtf32Can+cF6SNRInAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692214672; l=1884;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DImqGSc3DxMYYtM+y3nWIyr7RKQ7ZF8igdoNKRIjvLQ=; b=oZtCzrNRhX+BmRVUVvDSMSHtFevQke6DkQXuUAFvKDDJ1JsC/SVF5cWpFkKp1YFqFV2ZBkibS
 Xr8bPbEJ4bVDVADcU3GcnzqSWeXBFKsF6nxpOmdDkzqD7eO6tjNDrAm
X-Mailer: b4 0.12.3
Message-ID: <20230816-void-drivers-leds-leds-pca955x-v1-1-2967e4c1bdcc@google.com>
Subject: [PATCH] leds: pca955x: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang 18 I see the following warning:
|      drivers/leds/leds-pca955x.c:487:15: warning: cast to smaller integer
|      type 'enum pca955x_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|        487 |                 chip_type = (enum pca955x_type)md;

This is due to the fact that `md` is a void* while `enum pca995x_type` has the
size of an int.

Add uintptr_t cast to silence clang warning while also keeping enum cast
for readability and consistency with other `chip_type` assignment just a
few lines below:
|	chip_type = (enum pca955x_type)id->driver_data;

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---


leds: pca955x: fix -Wvoid-pointer-to-enum-cast warning
---
Note: I've opted to keep the initial `enum pca955x_type` cast and just
place the uintptr_t cast first to silence the warning. It seemed weird
to me to see the same variable being assigned to two different casted
values within just a few lines.
---
 drivers/leds/leds-pca955x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index b10e1ef38db0..1d7fa0cd97bf 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -484,7 +484,7 @@ static int pca955x_probe(struct i2c_client *client)
 	const void *md = device_get_match_data(&client->dev);
 
 	if (md) {
-		chip_type = (enum pca955x_type)md;
+		chip_type = (enum pca955x_type)(uintptr_t)md;
 	} else {
 		const struct i2c_device_id *id = i2c_match_id(pca955x_id,
 							      client);

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230816-void-drivers-leds-leds-pca955x-7002cc67a291

Best regards,
--
Justin Stitt <justinstitt@google.com>

