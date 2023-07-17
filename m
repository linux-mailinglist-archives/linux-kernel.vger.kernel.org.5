Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F0756284
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGQMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGQMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:10:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C51E5;
        Mon, 17 Jul 2023 05:10:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314417861b9so3991328f8f.0;
        Mon, 17 Jul 2023 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689595829; x=1692187829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZYAcwTgftS0o0m+eRoSjUWN0mmase1AqhjgvtLOyic=;
        b=a9VE9aR+MmdpEn1C+DVD0J3aE2UKl8kqrT3DkhDJqIhBH0Cqvomz1RxRq1RM1BJb3p
         1M+9/q4zsst4YYGJ+41/ZgEA9Y+5zTUepjUigWxoFbgp3HlfL/gcbgeyfHWrMw5Jvq4P
         So+uGMHAQ4zi9JNDBE1EpRgR+4b1SlYh1shcFqzVnTBeqDcb0p3G/WVvIeN4Uwbkpw4m
         TJ7n0W3azO9CfXygLsLBXSMRPwVtPE2YnzpHhw5DSJwJ0xn8EvPhtwoDL0AJUlg2cxIY
         KmH6rQb/0IsiCXw4XeEQcmPlN+CMP4LcN/lapIR9O1gLv1yhDTiwseG+wKB710HbGFli
         9xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689595829; x=1692187829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZYAcwTgftS0o0m+eRoSjUWN0mmase1AqhjgvtLOyic=;
        b=ecmTcTzO/40isD9jxmmFEsjwn7mNWsrhLJ8RdtAQHW9qEiOJBN0QMLcLKi/kJHtm4N
         iZNiAEdef+hs9XadhPm5jtU0ZzRsSCKQRayt1e8QunmM1TACOOlJ6o7gWWUj2AKcYo4X
         mFx+fRNhilIsN5Kw0BkmATb2Vu1WL+Ws6osL8Fx+4gAei9isNiu8BmIVF9w2039CWaE0
         8lMBw+0gJRvrhH0SEZ6ZgNH5FTZDcopoAI8fEsOyS0w2A0ww54xI7w/SlP/LwC2Vpyh5
         c53SMhzMF6yAkxUDBO/4cFpPowazwgW8BXGxim07e/QfO9XStGq7gqpuSGTZAxlV/Qap
         Fzwg==
X-Gm-Message-State: ABy/qLappnHOTZbRB0yRpj1pstrUwWrDgg6NMbdpP2ETviUuIKuaui9i
        WZiWW4zoKgwnYrJ9Ka6grk5AxnXmG3MWcA==
X-Google-Smtp-Source: APBJJlGkx/vrgPNeOTq1dQR8vwfmUNGHYWzOrfh8VZNhGXdk9fnXMixC2SSi1LOFdg/lg+AU/Q4n8Q==
X-Received: by 2002:a05:6000:1c4:b0:314:133a:f04 with SMTP id t4-20020a05600001c400b00314133a0f04mr10084875wrx.49.1689595828671;
        Mon, 17 Jul 2023 05:10:28 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0031416362e23sm19075082wru.3.2023.07.17.05.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:10:28 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     zhang.lyra@gmail.com, baolin.wang@linux.alibaba.com,
        orsonzhai@gmail.com, andy@kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: eic-sprd:  remove unneeded platform_set_drvdata() call
Date:   Mon, 17 Jul 2023 15:10:04 +0300
Message-Id: <20230717121004.5205-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() call was never used, ever since the driver was
originally added.
It looks like this copy+paste left-over. Possibly the author copied from a
driver that had this line, but also had a remove hook.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-eic-sprd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 84352a6f4973..53db88ae2a20 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -653,7 +653,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, sprd_eic);
 	return 0;
 }
 
-- 
2.34.1

