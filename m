Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC57C98CD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJOL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:27:35 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C38C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:27:31 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a84204e7aeso13911127b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697369251; x=1697974051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFbOF3573uN2XsjzuWMYl1qqk639YGQ/7wnYm7Gey2M=;
        b=H7ID7ZRRsZnAl9r2t1CN/EvigLJfCjVQbh+xzBM94OUhLx9m929CX/rOODJSr4ZH8W
         MhWY4a2HfUOw356tESihUsk8p2WRCC3Uur5oi3wX3ljxFDjNMd+hLtXVrtCDyyVsE62h
         OSiIWdcQN+lrjWnigrcomHpX96279yx8RmjM3xIV1jESEXCUte6l9vFJ0tsQ+5Hvf0d9
         XYwqu7va/iP8+tvdZ8qDpUglmT4rJV1GH0HDRRKg6FNnOfeQIg5KYTEN02nVZLIw2P70
         FlEB7LBDcX/5eFSypnemEuQOTIYf4tBFkn/lkfiPugk1xcwRTsqk3DIxs1fAO1aK3cai
         JAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697369251; x=1697974051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFbOF3573uN2XsjzuWMYl1qqk639YGQ/7wnYm7Gey2M=;
        b=kt4ncS9mDAAXU2yPtvf91mx26djIUkO7RON5PBciyECQjXax9n7aDfvWmc0PC2lHZl
         Oe+m3YLS5Nk8CQQ9i8hWiKAS5SjtnwcaD67EPuL4uXZKYLEHtCe2v1SgzbQB8BzxjFUV
         WiCTm0LV8DaYLVzd0NFtFpWhfwVNz4NdRPl7F+H/lH7DzbLvHj3s96+lo3hA58d3p7K1
         1YKwWOP/nqZ0ZlWjKFz1y5kZSwrKc1Bw94Xy2WswWZh56m36bmA4iSLBlTTITbZeTkUd
         0jZzXNZ4SXM2Wk7RNcK3SeYAdw8ILhtIxs6jgcniHgaSMgHGKvJpQxDbTeU7P91NrFq9
         bo+w==
X-Gm-Message-State: AOJu0YzkmN7dn/LT0aYunSYF1JOL1ZeMQoUUY7mvS2ekJkI0Jko6MQPl
        rNBGgsn8wZzzs8RkfUBeQwXDm5NvOmRe/lp+
X-Google-Smtp-Source: AGHT+IEu83VeLmbxItdzge1PebvjhtesvuPRtx1ed6805HLV2vCqvUhityKO7eDYLDM8/B5u0VkurA==
X-Received: by 2002:a81:9a09:0:b0:5a7:aaac:2bce with SMTP id r9-20020a819a09000000b005a7aaac2bcemr18011138ywg.35.1697369250916;
        Sun, 15 Oct 2023 04:27:30 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id j189-20020a8192c6000000b005a23ab90366sm1326598ywg.11.2023.10.15.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:27:29 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 0/6] staging: rtl8192u: Mute checkpatch error
Date:   Sun, 15 Oct 2023 12:24:46 +0100
Message-Id: <cover.1697367161.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align descendant arguments to the open parenthesis as per the "Linux
Kernel coding style" in Documentation/process/coding-style.rst

Mute the following checkpatch error:

CHECK: Alignment should match open parenthesis

Gilbert Adikankwu (6):
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments

 drivers/staging/rtl8192u/r8180_93cx6.c     |  4 ++--
 drivers/staging/rtl8192u/r8190_rtl8256.c   | 16 +++++++--------
 drivers/staging/rtl8192u/r8192U_core.c     | 20 +++++++++---------
 drivers/staging/rtl8192u/r8192U_dm.c       | 24 +++++++++++-----------
 drivers/staging/rtl8192u/r819xU_firmware.c |  4 ++--
 drivers/staging/rtl8192u/r819xU_phy.c      |  2 +-
 6 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.34.1

