Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A5580C241
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjLKHm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjLKHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:42:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA3F4;
        Sun, 10 Dec 2023 23:42:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso576885166b.1;
        Sun, 10 Dec 2023 23:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702280570; x=1702885370; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hmR+YxpV+LKGIsN8CLV3y72wX3HxmskMeyJnPDScB8=;
        b=dX5esvdbuuv+oMKU0vmgCb8LMrMTawK+XjCpdY92+kCK0uny5oCd593HmvHtV28tFm
         qc45Lnyt+m0ghTKM9r9sPNKk346hwuT70OHyP6r+QopbPka/ppMUXqiDy/6loLjXChOu
         u6jsPeG9KZfxQbrmVGT/1utNbDO0Y9cS2dvjlY2BwGMMUyaDGezKM8ghPifL4RdYcbod
         hboS+NiHg6LcTz3sxjERk9RKyOothtE9L8jX1mHgkSGloPvG7MMGEi0+NUxYifnLsjoZ
         KqQ1fDWtGZN70c75QBjGEoMrbyycpCnP4Q+00vR0AZ69Dlg250HrqmKSlTGVaVKJrnS8
         Bb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280570; x=1702885370;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hmR+YxpV+LKGIsN8CLV3y72wX3HxmskMeyJnPDScB8=;
        b=hn13W2Aag9/zMkZ4Z1m+LvtwVRzeL6d1D6IgE1O77HOF6aaefEwar/v4bnpM/dUqyb
         VN6VY8eh+ag4qyS6Jbvq8tG1PRyfcemw/ejoGilabSVgF3/vFiGkmfB44Jwgk4N+jxlo
         bSFjSI4cviPY9qijY4hoLzvRFJJKjU41JeQIz/nmK9WVyVMdtWinFFmqIO1/a2yuH+kX
         qWQyNUQILhnI+QCo8dIuAyLJtjdF7Zw+K8X0w9KLYgcFOLt+jp4Ygkxm5prjt/bi+hzF
         luJ7bRKEfCasxgKTVv/1NO9MZy8sYa8i/ogH5GF7hmP8e/9Ls/kMZhixPjS9vvahg/+S
         OBkw==
X-Gm-Message-State: AOJu0YyJ+9Vu2Tr74/YTT8+6SEn1PuFaktKvvzdQMHzHAzqEKKRjIeLT
        MYgaXCzTy+fKiCGVIR+ReoU=
X-Google-Smtp-Source: AGHT+IFQmQkfGVnNQ0m2JWE3iFtYKdq0VTzVqxVQfJ+aD/wbTSQbv4P3e2JQreA11uU/LfqYWWxIxw==
X-Received: by 2002:a17:906:5345:b0:a1c:b707:cbd1 with SMTP id j5-20020a170906534500b00a1cb707cbd1mr3570285ejo.24.1702280570365;
        Sun, 10 Dec 2023 23:42:50 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:187:91eb:e4d:dd96])
        by smtp.gmail.com with ESMTPSA id tb19-20020a1709078b9300b00a1cd30d06d1sm4490224ejc.14.2023.12.10.23.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:42:49 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alexander Graf <graf@amazon.com>,
        aws-nitro-enclaves-devel@amazon.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] misc: nsm: remove selecting the non-existing config CBOR
Date:   Mon, 11 Dec 2023 08:42:42 +0100
Message-Id: <20231211074242.22999-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9873755a6c8 ("misc: Add Nitro Secure Module driver") adds Nitro
Security Module support, which selects the non-existing config CBOR.

In the development of the commit, there was initially some code for CBOR
independent of the driver, and the driver included this code with the line
'select CBOR'. This code for CBOR was later reduced to its bare minimum of
functionality and included into the driver itself. The select CBOR remained
unnoticed and was left behind without having any further purpose.

Remove selecting the non-existing config CBOR.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 8932b6cf9595..4fb291f0bf7c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -566,7 +566,6 @@ config NSM
 	tristate "Nitro (Enclaves) Security Module support"
 	depends on VIRTIO
 	select HW_RANDOM
-	select CBOR
 	help
 	  This driver provides support for the Nitro Security Module
 	  in AWS EC2 Nitro based Enclaves. The driver exposes a /dev/nsm
-- 
2.17.1

