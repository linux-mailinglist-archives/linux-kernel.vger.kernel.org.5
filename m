Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8877BE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjHNQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjHNQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DCEC5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11560838a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031984; x=1692636784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ9qlAUbePlsiqKNAw2XCXfpwKOzQlpZ5FRE6WrsgJU=;
        b=DIxrTeVJIiXlK4hzIcgaGQShzeDAwohEoTNSPZRr+fSRm7E2aWLGzKtc3offXJJsR5
         +1XntcBTIPkYLa8UNJxhfWlJykViTaJGeUadHj75cg5+x7HxR8H3cpmGHNPvK8+zYJiR
         0eQSe1ut8ZXXNWM+hweQKO1zEIy3obRFAjSeMg91VTEr0aPWwkmSUK8MJFLOKLZhp7IB
         vHE3r2Ly9Ua9j5UJC9+303ovCazAuZP9q4y0Cnu1DNw87X34Hw/XbosGqRX/uN+0x8yW
         Xg0THVYMvESsum3yKqkD7JJqdnUsBjj3WGsONNlw8rWg7VeU5ytewzYXB4ZDpFqTYdDk
         r/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031984; x=1692636784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ9qlAUbePlsiqKNAw2XCXfpwKOzQlpZ5FRE6WrsgJU=;
        b=L8EKJm/hs0X61TYDvLva0TJBI0P7J+jdPJv6HRMSEoiaQHuHmEuSSPm6eHLAvoM95Q
         Yy3M7e0Wgw//RLAumbFSUsC7EtNQdSM0R4yc3pZbpNm20qQMT97JIgOTwR426WGilM2b
         WVxSVH9BJ7u8ZdhURGSxUybxIr59JwDYEVdcOHeKxpCkiHgmLbQVI+dqT61MpR+l9TeD
         ILvlHIEgg1EPai0G7Z4gJrGLCpXghU1ug8zIaHQKYggVZEg+ntiINiBnjZ3TJ/quCoAz
         rN5PV6MdweC/2/lY6ewo9O967/yapxWwNv9qYxgIGT/hEb2tS29mGUlcsCNrTP4PQ4Eb
         DFng==
X-Gm-Message-State: AOJu0YzGAu+FFnqyyZJqVITaFABOo0K2/q/aD4rvrBeDfj2fQr0vjAME
        Kwgu04ZQfSB3/vf3c7mfn8DcJw==
X-Google-Smtp-Source: AGHT+IHmYNd8vo5VfvOKKzbqTiKVmUFG1diLnOlxRf7oG9FTuNLDAgQ3apmahewG4F9luvjz2csDkw==
X-Received: by 2002:aa7:c2d1:0:b0:523:37f0:2d12 with SMTP id m17-20020aa7c2d1000000b0052337f02d12mr10465936edp.17.1692031984531;
        Mon, 14 Aug 2023 09:53:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/22] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
Date:   Mon, 14 Aug 2023 17:52:35 +0100
Message-Id: <20230814165252.93422-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-mx-efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 13eb14316f46..461e3ad87bcd 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -194,7 +194,6 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 {
 	const struct meson_mx_efuse_platform_data *drvdata;
 	struct meson_mx_efuse *efuse;
-	struct resource *res;
 
 	drvdata = of_device_get_match_data(&pdev->dev);
 	if (!drvdata)
@@ -204,8 +203,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	if (!efuse)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(&pdev->dev, res);
+	efuse->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-- 
2.25.1

