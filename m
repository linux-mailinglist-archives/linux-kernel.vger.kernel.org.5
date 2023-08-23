Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6356B78566E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjHWLIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjHWLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:08:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ABC10C7;
        Wed, 23 Aug 2023 04:08:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317716a4622so4850665f8f.1;
        Wed, 23 Aug 2023 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692788889; x=1693393689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umv4AuAG3bVQsHLVJR21Xr732gEzM/i84SmQ/8lFvbs=;
        b=jn3X8XVR0zll0GXEDWuEmfLw9HCNQ9cUWno72c+XRD8kJJ0GPkblFCv8zzlxIXPcMl
         8S960EcpVXQFtDVAxrj2JlXfMaRzDFE3TkLH/2f6OVadoHWew5IhMmxbVV9NoKIjDvSv
         +zGD6ZTH/o2r9S8RutvDGyCCQPBeE4TP7nt24FECuxRm/GvxycsbOOeI/TsaB9ZuDKXN
         YLgmFcODv51olRRrB30V9gw48LHe2Osz/0B1wazBZAvo9Ib0CClGb/5aFBqJKYoeahkB
         bBgSxKd49/+02o9dzbI0JfdDM7PgJt3JBGSxqlHijPNjGfsKACaUepmqrzlb98cL22cI
         wJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692788889; x=1693393689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umv4AuAG3bVQsHLVJR21Xr732gEzM/i84SmQ/8lFvbs=;
        b=SGQRHUL34mlZ/+KHuyabWBDehszcDC/Icb9/CjhtfkRlgJ+/q2zGASPfmHE4aksHuE
         QfgSVu9EW6RcOwtprckynm6W4W5ad47GBBAt6w4yehn5vfYIhQ2LdX7t75qOgrg0F/xk
         HpAuiRrhiS125C35pILtiblBJd1MVndsV7reWPDvL46tA2lmQ6DxSGm7k9mjmxLdjVEw
         0WoCVzeHJYKfV7aX18MCWoBtayH+BJXb3V3bi/yQqHNIjZcB6YYPH7/tfIWQyxvBhiZq
         CoVnVk5qHx5fSoxnCxOPou+3ThLz8QM2VufEHhUU7vUj65Qdfkh7fcl4LFSGg8VYqdf0
         JDkA==
X-Gm-Message-State: AOJu0YytCaL3gkq+2Iqq3OIBco9l65wjN5P34fVRbJ3cK0dyiqShm+fl
        8P30rEdej1OPJ5o59OwGvGFExJqKERQ=
X-Google-Smtp-Source: AGHT+IGQtncKca/Nd75Qx8eaP1JiSmQ95Z73vSLMuyWe3lLG/NoNpgEO6RF3brGK6GHLqcncg4pYKw==
X-Received: by 2002:adf:e946:0:b0:31a:d8be:d6f4 with SMTP id m6-20020adfe946000000b0031ad8bed6f4mr8870159wrn.10.1692788888666;
        Wed, 23 Aug 2023 04:08:08 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d62c1000000b0031ad2663ed0sm18426155wrv.66.2023.08.23.04.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:08:08 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     alex@shruggie.ro, herbert@gondor.apana.org.au, olivia@selenic.com,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] char: hw_random: ba431-rng: removed unneeded call to platform_set_drvdata()
Date:   Wed, 23 Aug 2023 14:07:58 +0300
Message-Id: <20230823110758.3462-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/char/hw_random/ba431-rng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/hw_random/ba431-rng.c b/drivers/char/hw_random/ba431-rng.c
index 5b7ca0416490..b1518dd52a24 100644
--- a/drivers/char/hw_random/ba431-rng.c
+++ b/drivers/char/hw_random/ba431-rng.c
@@ -189,8 +189,6 @@ static int ba431_trng_probe(struct platform_device *pdev)
 	ba431->rng.cleanup = ba431_trng_cleanup;
 	ba431->rng.read = ba431_trng_read;
 
-	platform_set_drvdata(pdev, ba431);
-
 	ret = devm_hwrng_register(&pdev->dev, &ba431->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "BA431 registration failed (%d)\n", ret);
-- 
2.34.1

