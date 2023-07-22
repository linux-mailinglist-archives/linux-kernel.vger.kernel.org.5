Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3D75DEC8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGVV7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGVV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:59:42 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516A2123
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:59:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7835c92c373so97179939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063169; x=1690667969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4tY2GuOM7XF3DCI8b76kqr55OfGzK0tioQlStQn52s=;
        b=ApX7fxDyQFSjWFbkswQ6ONJQ/2B6R3/UfF2kiS4kQSEjPBgoURIyeVVhk0ZNjz3O/q
         kkic6sftOpZF8YydDQQK4oxPm0p7zYliaN64hSqHMh6py6xZhLmt9tXChoRT9PP/O9jU
         a74cxDd74UqISD/VCzSerGY9P/peTnIUpnC1KstK0Mz7v8WQWY+iTQr5+nTrxERcH6DY
         qXDEPSROzETCGQJSpP1eCFHkc2H6Zh+oz4cjPEYfO6bKyC3anzcN5wWfqQGomHALCbZI
         hsHyG8Tzu3i+siD07SeSPSlrrtkBxofZBbDOE1AonoUUZwE/NJwTOXXiJR3T5Ow80AEF
         NN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063169; x=1690667969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4tY2GuOM7XF3DCI8b76kqr55OfGzK0tioQlStQn52s=;
        b=i73MdzdUYEDZyrAbnF7+SXS8AS7PgdiRCFjgiUOXJdYELsT1uKW76zepiIj30uXxNf
         ltoBQzOXtS2AME5dXhS41Ga4aTU48i1oEnQGS+R7zaxD0uwf49l0FhCdr9f6sIWpYCQO
         6gqnnpebh8fq/g+z1Jud/s4DHf/TsCwHYrWWdoCrKszTIYBOsSOMQ1tI9EKqbgrnI7Li
         /GZ9pHrCR62w4zWja/uWefVL5ozbSaVdeb/K8Tz69Qe7oKIRT0leeZ64rXkjxwqSectj
         qSEaVmVWkUMV3vPMsqw05s1bVM2imUKKEcjYOOoAqzhzpSMBdhpVgmFGSKQFBp+fqbAi
         EEuA==
X-Gm-Message-State: ABy/qLZ/82nZKoHSR7cB/jtuiW8JVZdmSeACxECcG4Z/FYfUaHgxYllt
        6aRLmKO5WHQAkvmJiQCtSe6J4JnnB5NvvQ==
X-Google-Smtp-Source: APBJJlGnr1TRBYjUKRbs+sLex/dT9A4Zmt3haniB2O7BLMdIRO2kLi4QWtG8xWGe31MexKYl4QdSSg==
X-Received: by 2002:a05:6e02:1ba5:b0:345:fe2d:56f with SMTP id n5-20020a056e021ba500b00345fe2d056fmr2181422ili.14.1690063169593;
        Sat, 22 Jul 2023 14:59:29 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id f16-20020a02cad0000000b0042b2d9fbbecsm1874673jap.119.2023.07.22.14.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:59:29 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 9/9] staging: rtl8723bs: ioctl_linux: Fix comparison to false
Date:   Sat, 22 Jul 2023 23:59:27 +0200
Message-Id: <20230722215927.4443-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
References: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch issue:
- CHECK: Using comparison to false is error prone

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 2896d64e13be..54a2998e837d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -832,7 +832,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 			psta->htpriv.ht_option = false;
 		}
 
-		if (pmlmepriv->htpriv.ht_option == false)
+		if (!pmlmepriv->htpriv.ht_option)
 			psta->htpriv.ht_option = false;
 
 		update_sta_info_apmode(padapter, psta);
-- 
2.39.2 (Apple Git-143)

