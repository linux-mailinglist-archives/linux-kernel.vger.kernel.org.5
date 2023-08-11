Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1777979D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjHKTQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjHKTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:16:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBB2709;
        Fri, 11 Aug 2023 12:16:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31783d02093so2050284f8f.0;
        Fri, 11 Aug 2023 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691781396; x=1692386196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKEqk+rQUgsDa0MyxwSGJG/hgltrCH/MdLQiHM1K+qI=;
        b=EQdKQ8kuv0BJmnKR6Bzp22lkL/B/gDBln4n2d+ZVCjA3jEPSfSCRz6uvlrtYhndRKZ
         I+xYR311HKybC2Ws9BkzpTB2rITLZEUsE/PBoNVhG4gCOimR92HBTKkv1Ao8ZDNM/KEr
         JdXf1DS4ogSTJtO4lJ11WX779N4utEVHdGkcWksD+3o+PiTP7deXJBzZFqgzuLkfuhCK
         IxBpHraauyiGh3TDpumJHDqP9nd4HLgGHg8zk1euL5zOm2C2kZhWUqDFPCHVmB0EU66s
         xHjl4+Yx4rA8p4F9gGNx25zZf6ROmH2SQ1cEz9MOmZG7zyjOa2giPuMLyAd6ZwpTS/Dc
         8CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691781396; x=1692386196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKEqk+rQUgsDa0MyxwSGJG/hgltrCH/MdLQiHM1K+qI=;
        b=djKe9WRizWxdrY7Ta7WyzzHNWmvYCoEbR5koDh4rQq6VB5PFvPVErg1sdkUwvYlHAh
         AFyY+S+t03GAaKfYKxuMsLAkhB4JWRYxWt9nq2GN9g4dAZsrYZ7/DB57T97Xkqczq4NP
         L8ampNXkGcSXvR5l8c9uMFa590nuD8/OgZ5JkE5OPP4r00xUe9ywN7SqdfpK1mawvDWI
         p9JUZLE+kiruCI9MyoCg7vM8s0hNobd/HNMF6gQDYbYx+FqnCpa+JzpvVIYrZ0pVFIUp
         8fqjKnu2Oxwg9RbvJ1ye/FwMm/qPk6yjnbEs9I0jgd9p7vvH8soDW0Y6ZGeuc1VkDSz8
         Xjew==
X-Gm-Message-State: AOJu0YyVuOGG7iVSsSsKMeCTlbmwhv02aQBIlTbjRQlzKJRKn4JCGgq7
        IDB1EN/e4g4LNtVkI98ZPkMA4y11JZYMLg==
X-Google-Smtp-Source: AGHT+IHy1BP64VVNr5s/sBjbEt2+yIEuIbk9q9z67s8+uMUbcS+3O0vip6aAZflo5/Zqwk8v4fgCbw==
X-Received: by 2002:adf:f6cf:0:b0:317:ca89:f6db with SMTP id y15-20020adff6cf000000b00317ca89f6dbmr2054296wrp.44.1691781396018;
        Fri, 11 Aug 2023 12:16:36 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c044a00b003fbc9d178a8sm8944750wmb.4.2023.08.11.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:16:35 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     alex@shruggie.ro, rui.zhang@intel.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: max77620_thermal: removed unneeded call to platform_set_drvdata()
Date:   Fri, 11 Aug 2023 22:15:48 +0300
Message-Id: <20230811191548.3340-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/thermal/max77620_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 61c7622d9945..919b6ee208d8 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -139,8 +139,6 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, mtherm);
-
 	return 0;
 }
 
-- 
2.34.1

