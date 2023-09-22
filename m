Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E77AB856
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjIVRw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjIVRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:52:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303A1F05
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0ecb9a075so20925315ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405099; x=1696009899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=twFznqPJAzdntzHByi/iGsaxmBX3ZQhIhF3BInh8ZW4=;
        b=az1oUIyRSw9Grl5S1D2v/+ryG62KGBmdLb2hgDUoXb4gwJ1xMy44YlEEY9TAUW5Faj
         sh298Mb54ZKiX9UTNPGb5O5E0t5H3XLnsjPb6hWr177wNQ3Xz5Q1pAVgiLJh1+oIhsru
         ydQQIjXZdpQS0xhEiie1do0iAEFBtj/i0oAgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405099; x=1696009899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twFznqPJAzdntzHByi/iGsaxmBX3ZQhIhF3BInh8ZW4=;
        b=oHYmHlGmInzyI/fVf7eNDVLTMRl9RK9hMKVSaKOGtSMU3WRzryxTgdF3T8yPlpar6o
         XrozTz0MEWajUxq+UBvMUCx8QeHljdQ7RJqBlQds2c8GlvFbB+ZKy2LcPVswfEaXoiwJ
         WnDhupwG3RpHDf7/BPCNFenEZTpI70jteAaOe6odXIBCrcNR5XXNBokM3RpdhZF3/cfO
         zy0PTI1vC28Eihyfqe+ebxV90s6DM4s8rDxCH02528HGESIrwxEkn4vqZJt5hU3Enxwb
         23Fx8lbrg3wQ7yrYorCjH0rfL2CGQLeE9tEEXExJvo196PMUTWKyBky9RXVnTnACQpxe
         sv/Q==
X-Gm-Message-State: AOJu0Yw5nnW02YnDKxvQIskWMbHpcGn+jOFr42oQqf3NAOtSYydNYY48
        qf8jY317JwiltxdSMWrOX3Hd4Q==
X-Google-Smtp-Source: AGHT+IHB34HabKxPxhlVK2seBKatLPFUq6kU/+85gP5fTKuuek7ZguwnwQJ5Z9ew9kyzRDNm5r1Vvw==
X-Received: by 2002:a17:902:c409:b0:1c3:ed30:cdf4 with SMTP id k9-20020a170902c40900b001c3ed30cdf4mr268638plk.4.1695405099157;
        Fri, 22 Sep 2023 10:51:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709027c9800b001c3267ae31bsm3752412pll.301.2023.09.22.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] video: fbdev: mmp: Annotate struct mmphw_ctrl with __counted_by
Date:   Fri, 22 Sep 2023 10:51:37 -0700
Message-Id: <20230922175137.work.062-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=keescook@chromium.org;
 h=from:subject:message-id; bh=n796F6gX1K105GWhE1qUnocaNksGRQXNbRMxIxep6mI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQpfO6l85dcFKBvYH3iqyyXKMRFw4FsqlSgo
 l0M82mlouCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UKQAKCRCJcvTf3G3A
 JmosEACKrvk+R5bxR/JWhJvcODkoIL4vvUwiWD0CFpi5Eymp+XCYI6ln5AmRkbBljl2C+DOn9lP
 /xGwXy7Cldh8FdZeGkKIveevk2iaNkfiRfUYIe8FtSoT3+Ot2WLc7oOVp/w6rRDhnM4XFwfvawe
 ZpJLfH5kaiJOjyeBi82kQMkZ7UI2C8mT8OuPyWgNnsOFn6zsREp4WT6n2vsY8er/KNCNVlz2Z7A
 X5E2TU039VS17sTVtcJPPHE+RR0Uhrtk4dIE8LVq0gQ4e4xcpZbQ4uebgTfEkfmdyZ99ifS0bFf
 Eg41SJykV3lWoJAoubku8CFdF8gJTaAf6Cu3WuSCRdnYBJLieTTvidvMeFxZNvikF0n61qp1N0r
 4NuEuRqdYuoV+2yADJzRVU/jGEop6VKrfo4D5WSyeCZgXU/R7O+sUlKUyhqUY1RJWm64VCosD8/
 3fg8BzxzcGNhSCXl6rOP9eLOW4uybKcDn73YoWnLbebH7U2uljs3qa082E7FLcVFByIvFKVH77Q
 g6KXVDWHGrsiJlrNJHDoFHlFAR9Ew7cD/GI6uNA9bWm+ggsZCUhTcRXT1peqy0nWTznTL+3Gav3
 ocDpFhl3eFcdHGCnBW42PofiKK0C/IhdUL2mYalkf1nGk3IzI0GfA4F0/rvJvBjQoCW/FDOHvZM
 5TiuKMR MK5e3B+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mmphw_ctrl.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
index 167585a889d3..719b99a9bc77 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
@@ -1406,7 +1406,7 @@ struct mmphw_ctrl {
 
 	/*pathes*/
 	int path_num;
-	struct mmphw_path_plat path_plats[];
+	struct mmphw_path_plat path_plats[] __counted_by(path_num);
 };
 
 static inline int overlay_is_vid(struct mmp_overlay *overlay)
-- 
2.34.1

