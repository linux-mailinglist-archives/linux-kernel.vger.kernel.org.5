Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715DE7CD78E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjJRJJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJRJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:09:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E1F7;
        Wed, 18 Oct 2023 02:09:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a98517f3so4434977e87.0;
        Wed, 18 Oct 2023 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697620147; x=1698224947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpBTf7lcPPrlh5uO65BHtYFE8Nvp9es/xrzqlK/axIY=;
        b=I2qh96WnhJmHG0mwDEv3ZBOW7fgGTz9s2cEEPokSpGG1pdit+CxFgup+PsBLnC+T2p
         ol4Uhod7uOxcaa25JtM/zNgixth6ACescso7dfFjwIJE/qzH+gNwjqqSkedjqZAnn9SY
         B4smPH1d/pnaxVwY1Wr+ht8j7fS7qLI82Y7lzFIRGybn2sJpeSbDNfqxCKJEFBncmj1i
         ZTJKAffUFVD2boWwzcHKTIKdlLEUpJQhgNZiCDeCoYCGVfWoVZHzXtY2165sTIejVk7a
         /ksTyvu5+AocbN1SEdLmek3E29otz7h0qQE16NW6pdLBFP2Plz2pspl6kZ/fLUmHNnY0
         7K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620147; x=1698224947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpBTf7lcPPrlh5uO65BHtYFE8Nvp9es/xrzqlK/axIY=;
        b=P81Ws9UgnohQXorB+8C/L7N64ed2XIpJovzsEwRh7DeINAm5dJh7nVodwNj8XGgXp7
         wWBoSLCS1oyXBkSmInLlLvgYBaFyxufDitZ9quEIcvbLBQc043ZM5//EuJJ/HK/HQ7sF
         nhSyNvjoYXi3WySxbyOQzWK0ll6PIdNxX6FI7GhaBqVsYb06PP8MLM4nwJA133RkD+DQ
         zeK6iXXxRGq2KCCc6c3xLALMdIQH1QnYnOzm7YmqcKzg03gkyF+aoRgZKgTszWbleDD7
         hNC5NAeF31g3huYj5PKi89xHgopy0qfVBdD9Cojjv8ITIyJUD/WAjHPKrZbxT9xKSNFH
         eVJw==
X-Gm-Message-State: AOJu0YyVNwTIbcBCl9gFsLySqzU/I5+Rqs4gs0pWt5tpaG7US34G7/F5
        FsAm2NcWRxVIsi1OzfJBezKP4LfQF73I1E4=
X-Google-Smtp-Source: AGHT+IHexUEVIYWZg4NVhT/6ayuobviO0J5bcJdeY/hfx49NbfI55SMtkLr/hRDsat5UuOjQuWlF5w==
X-Received: by 2002:ac2:5939:0:b0:500:9dd4:2969 with SMTP id v25-20020ac25939000000b005009dd42969mr3415814lfi.59.1697620146853;
        Wed, 18 Oct 2023 02:09:06 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.0.227])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b003fee6e170f9sm1107397wmi.45.2023.10.18.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:09:06 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        andi.shyti@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: sm750fb: Remove unused return value in program_mode_registers()
Date:   Wed, 18 Oct 2023 12:07:38 +0300
Message-ID: <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <cover.1697619623.git.anonolitunya@gmail.com>
References: <cover.1697619623.git.anonolitunya@gmail.com>
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

Modifies the return type of program_mode_registers()
to void from int as the return value is being ignored in
all subsequent function calls.

This improves code readability and maintainability.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 83ace6cc9583..e15039238232 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
 }
 
 /* only timing related registers will be  programed */
-static int program_mode_registers(struct mode_parameter *mode_param,
-				  struct pll_value *pll)
+static void program_mode_registers(struct mode_parameter *mode_param,
+				   struct pll_value *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
 	} else {
 		ret = -1;
 	}
-	return ret;
 }
 
 int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
-- 
2.42.0.345.gaab89be2eb

