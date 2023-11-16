Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34307ED9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbjKPCrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKPCry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:47:54 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EBB197;
        Wed, 15 Nov 2023 18:47:51 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bdc185c449so274938a12.0;
        Wed, 15 Nov 2023 18:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700102870; x=1700707670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svtH6nB/hE04ntCGkIVPHKITT9cDPQUxSxeC2R+EmoI=;
        b=kIh1xXnJbWix4RGbQVRKwwq2iz02fC6SEvodv8Hx/ymwzOOGI/ggR2n8V+xJelmJjK
         jl1XptWF0iilqntedC+5IjBsFUIUcNgDuulBe1n+k5XBwqgI/0pebEroQP53vLkx8Q97
         +YDO4MWUOiSsTOyUbjE6UPypDvnnUjVFsjw2N9EniQfwRjqhTWDuDbOmmxUweonkxcjO
         PZg4cITk5xyb/lNLA7D8eMXsRPLsdYlc0mQV8x3+62jTdtJdpc3PU1iOqkEZlHShv+S6
         MFvLy0J0mwnGatZU0TPgBEJEYXCdeOkmWchM3wuM9qO2F3nZlAuOew2wPGsAPLHXLdch
         INcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700102870; x=1700707670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svtH6nB/hE04ntCGkIVPHKITT9cDPQUxSxeC2R+EmoI=;
        b=m1qcJMgzVR5YZwMWzU7WjSZO7Hd08PRwxSuXE+Yp01xzv76CGH7wwdpKtaS1fVeina
         dUzhJXsNFjE41WzfwBPCsr1lUrIYYWO47AMc3jKP7kZjamQ224rLSvZhnVewZYryxGM2
         rjdTGgEqvfqvdY2zxkgH2dhURW2uE6IYsg/mUTKFh+jbbhzIe/CQvwozsbJ1yaCz50w4
         RXW/KjlZW6NLTBx2UipFP8sbcZ7/N94d6tBJX7yqplx8Mo/zSlyiV5hwey00BMgk4v4m
         3nzUnRgdeaUdUX6GcV/oJOH1OnOaG52/MX/04iW4eskAxq1ozN/5eeWP3FRjnZ6uAQoN
         iwoA==
X-Gm-Message-State: AOJu0YzAzBaOh3e1A1T3ZRS5XWnbbbFUhMsHKxUyTC11TCSg9V4f1eDb
        0IRRGkaSfLyYeijqKvVe9O4O+qtVPSLJ
X-Google-Smtp-Source: AGHT+IEssF56ALfrxIW+LldFPLXmzOUjVkBq6g/rv6UutDoRD7Ok3nF5TdlACFBBJkX1ZxxnUmzhUg==
X-Received: by 2002:a05:6a20:160d:b0:15d:624c:6e43 with SMTP id l13-20020a056a20160d00b0015d624c6e43mr15017621pzj.3.1700102870009;
        Wed, 15 Nov 2023 18:47:50 -0800 (PST)
Received: from localhost.localdomain (111-243-26-65.dynamic-ip.hinet.net. [111.243.26.65])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001cc2bc10510sm7962604plg.128.2023.11.15.18.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:47:49 -0800 (PST)
From:   Stanley Jhu <chu.stanley@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        peter.wang@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        chu.stanley@gmail.com
Subject: [PATCH v2] scsi: ufs: mediatek: Change the maintainer for MediaTek UFS hooks
Date:   Thu, 16 Nov 2023 10:47:44 +0800
Message-Id: <20231116024744.10795-1-chu.stanley@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the maintainer of MediaTek UFS hooks to Peter Wang.
In the meantime, Stanley has been assigned as the reviewer.

The original maintainer, Stanley Chu, who can be reached at
stanley.chu@mediatek.com, has left MediaTek,
so please update the email address accordingly.

Signed-off-by: Stanley Jhu <chu.stanley@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be1cbc6c2059..4f6fb3357947 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22102,7 +22102,8 @@ S:	Maintained
 F:	drivers/ufs/host/ufs-exynos*
 
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER MEDIATEK HOOKS
-M:	Stanley Chu <stanley.chu@mediatek.com>
+M:	Peter Wang <peter.wang@mediatek.com>
+R:	Stanley Jhu <chu.stanley@gmail.com>
 L:	linux-scsi@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.34.1

