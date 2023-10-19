Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F537CF4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjJSKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjJSKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:15:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFFAB;
        Thu, 19 Oct 2023 03:15:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so77845595e9.0;
        Thu, 19 Oct 2023 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697710517; x=1698315317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cbB8KyCX5JCSADfj+9upLa+4bu4hru1gFdwgH5SKUA=;
        b=b1DM3/uaIm22jgkgm6dXGjyGujA0OhrdzlC+zRWQL2pGC0SOTmE+6ubVPlG4qRml73
         plpBYsyJ0NiLAQIwNlDLFi4lgPMr154857Ao3o2FdCgbOI9+DU191c8oudrH1y7bgSx0
         cGTOJeg+yQJRnkM2nhAwbgAoPLN6z1y3MDWYgoiA9PyiHv35IP4YU8COpe0wHuMQymd5
         fdrKFO5gaKiFmq1bJug8/ih7kiKMQ1F7U4kjcYN5jc9itbucEvpxthgR2MYLeXuqEPTA
         0cVNNwsebBLK/ShU1A6BkVZ5YMB5Ng2nGdGSRWX7BM2R1ibmjeFAI7PTPDVhVPCCV0RN
         gS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710517; x=1698315317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cbB8KyCX5JCSADfj+9upLa+4bu4hru1gFdwgH5SKUA=;
        b=q8vc6ejmFaCP0MpQFcMnBUvGnfc8HoX+bXWW70lb30RMzJVTTCsbwGpwhWKCr9O8/Z
         yEPW9N/wBat4bMlPkSvGguCOIDM20Wb8Rg4tKhIC5EEynzM359tZ7ziiRoxvCm7ZetDV
         f795sftRNN8nOGOi+Djj39NiUkxbZTWv18liZx3fYsJeoa8UrgJcDYOaxTk2chruakoB
         fAHm+pkWaa9S8fLX1+0wI8RZ8UAHxz9eREWOXNbQsA8wOt/BoRgyYCsnA4LrIo+xKy9g
         ywPNFADZED411LPDdmQo4vSfvigGSU6n4Nejbf8mE4ADSI8/wJQj1vnsBWmTNbLt2Pg0
         IJmQ==
X-Gm-Message-State: AOJu0YyqYx4JutFopeoVMZgy/HBhafDHq7Fas+nYLr+eYdVyJPDWsUsd
        jacYRN2GURveUyXW9FCS9PVAvvxGL6YjNOg=
X-Google-Smtp-Source: AGHT+IGiDMFrmb9+RwMtP6BpxH9s/4iB8rEAMTIZXjwiWmRveGAphvfriwoq9wK4V9AK4OIZ4FiN7g==
X-Received: by 2002:a05:600c:4a14:b0:406:4573:81d2 with SMTP id c20-20020a05600c4a1400b00406457381d2mr1364687wmp.39.1697710517493;
        Thu, 19 Oct 2023 03:15:17 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.8])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b00402f713c56esm4109300wms.2.2023.10.19.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:15:17 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: sm750fb: Remove unused return variable in program_mode_registers()
Date:   Thu, 19 Oct 2023 13:13:37 +0300
Message-ID: <20231019101348.22076-3-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <20231019101348.22076-1-anonolitunya@gmail.com>
References: <20231019101348.22076-1-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drops variable ret as it is unused in the code. This therefore modifies
the return type of program_mode_registers() to void from int since the
return value is being ignored in all function calls. This improves code
readability and maintainability.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
Changes in v2:
- Drop variable 'ret' entirely as it is unused.
Suggested-by: Julia Lawall <julia.lawall@inria.fr>, Greg Kroah-Hartman
<gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>

 drivers/staging/sm750fb/ddk750_mode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 83ace6cc9583..4278f9a826ab 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -73,10 +73,9 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
 }
 
 /* only timing related registers will be  programed */
-static int program_mode_registers(struct mode_parameter *mode_param,
-				  struct pll_value *pll)
+static void program_mode_registers(struct mode_parameter *mode_param,
+				   struct pll_value *pll)
 {
-	int ret = 0;
 	int cnt = 0;
 	unsigned int tmp, reg;
 
@@ -199,10 +198,7 @@ static int program_mode_registers(struct mode_parameter *mode_param,
 				break;
 			poke32(PANEL_DISPLAY_CTRL, tmp | reg);
 		}
-	} else {
-		ret = -1;
 	}
-	return ret;
 }
 
 int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
-- 
2.42.0.345.gaab89be2eb

