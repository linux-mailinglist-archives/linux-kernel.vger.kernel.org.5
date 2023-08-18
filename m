Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC50F780416
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357396AbjHRC7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357423AbjHRC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:59:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798443C3C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:59:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68872ca740bso354814b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lcfc-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692327548; x=1692932348;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ekcZ3MN6GD3R4rBzk1MGa8Dg6eqHF3tAW/7JASPmac=;
        b=Nj7zUUT+2lHtKQwZ6jYZWomjyalQutpum5pnhewepfLaz4K14qkbUxfeVvSwkEXyX/
         2oG2fPzZpGpT13LXPL0Md5X2gTyJCmnLIexcE5AGBJvQPbqGswChLBSvmWT88psz3bF9
         W54LxSKB4z2iQfVDzwQlAKt+/zwz+iJW8I/APitXf7k7DnG0za0t7VHyIHBY2oSdo5HD
         tGfm1VrK0LDw7D/I3MEHm3SDhU9/l/oTC6IJ5w4c9rJE0Jd1IXf5xjMKvL1v7L1wAywO
         cN/J3WqvuXOSjA4O3zkqbZp6NVJqAIJ6RMA67WM1EUpuTi/GImV8fW5niJnAI2bg9LYk
         s4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327548; x=1692932348;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ekcZ3MN6GD3R4rBzk1MGa8Dg6eqHF3tAW/7JASPmac=;
        b=FY08MEULUw8rJGrse1TfJDixzS33273YRKYvb/gjncj5ZT/jHPIYPKF2kXvKgn8qJC
         QzdTAparfLpX12uY8vb1a4QCzheAPICnoO2wcBjyOq5pv+jzuPfij/pOVjVUB5erhXw8
         4FZhzWt4xpoOioZ6CueG8JdC+kKpyK38pqbhQu2qCynKYQjo/hkwovVugRgJ7Emsv5I8
         57JeFPGt08dw6MzoWg+7zpQjZrp2qHl553CP80Ckm1mi1yhE+T+CTLwksQOE7MNxfbVl
         Uk8dR2Afyu0l4Zc/vhZJILRCEGYSkA/fRBkgtlTY+yRuU7DISUsTpKZ/Gt3rTZp72E40
         1TZg==
X-Gm-Message-State: AOJu0YzTmMQT9lj/LrfY09IqJFFuCFVVwsyWAQZ+jG1g2/RMnYT8J881
        taWGWCIbGKMRDvtFdg9fw57zpA==
X-Google-Smtp-Source: AGHT+IG9LTbMpURDFy3azENGjKVk9jT2cQQWjAdfrYQI2MM+h7nUaHacg6HxhgbD3pxN07Hj9XWaWA==
X-Received: by 2002:a05:6a20:440a:b0:12f:a373:ba8d with SMTP id ce10-20020a056a20440a00b0012fa373ba8dmr2386272pzb.24.1692327547719;
        Thu, 17 Aug 2023 19:59:07 -0700 (PDT)
Received: from rasheed-i7-P52.LCFutureCenter.com (211-23-25-187.hinet-ip.hinet.net. [211.23.25.187])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001bdc7d88ee3sm497514plg.37.2023.08.17.19.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 19:59:07 -0700 (PDT)
From:   "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
To:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org
Cc:     groeck@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        derekhuang@google.com, rekanorman@chromium.org,
        Rasheed.Hsueh@lcfuturecenter.com, rasheed.yh@gmail.com,
        "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: [PATCH v1 0/1] media: platform: cros-ec: Add Boxy to the match table
Date:   Fri, 18 Aug 2023 10:58:47 +0800
Message-Id: <20230818025848.9531-1-rasheed.hsueh@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Boxy device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

rasheed.hsueh (1):
  media: platform: cros-ec: Add Boxy to the match table

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1

