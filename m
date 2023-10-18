Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E77CD2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJREgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjJREgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:36:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57453FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:36:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso3891526b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697603797; x=1698208597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=czJuvzpZ9+G+JcIdKCv4XoL9kYRQrLLnwV3w5sOQ/X0=;
        b=Brn4P3bX9OsSgIm6+g74fGbKFdnv088NwjjGpTIDh8Vv+hxQIike95y1F8DFbcrGEz
         CScgCEQHrYfkxThlhyxBsPecoeQ+lQmG/2N1Dafxsf09c8BTo3WAATlp9eUzsLQiMAxj
         jx9FJBRcmC17mBjqqPc7pvDUcwSWK22pjLOVdT3oCA9cxHWuGGNChtZhG/sZmYqC8Rmf
         D8FfGRX3ewHyB2rW0uG1WfbPegzh/tWRoWoItEOiUTJQnspfJkEz2tt3B42ryqlygDc7
         N19sCe9CtfEvdFqAZhlqIFoa9BWhpcRSkE0D2zXBn8BBc5aU9zHwa1lpegue4fWmEU3R
         ChBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697603797; x=1698208597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czJuvzpZ9+G+JcIdKCv4XoL9kYRQrLLnwV3w5sOQ/X0=;
        b=UvlZglLWGDvk60zKqwsRbHs45n6Mg/okCZYt9nmDp+ZzeWF8a/H88i7TRq2w0o6mHX
         Ees+8V9K247xWitqJctmdQst1EjH43wnD6NZ4BR2/XqJ8temF/T6pl+2cnK0AuUAW80W
         WR897aeBhosYJbbts+BAhQItKTmXXvlWm/LS9zZDBTflRQSxWnvSmPOIQ1Rj/sQwGVev
         RcepOpyqAN+082m2WV3ftRywR0glaUTcmikpelhicDakly0m8iLR+Fge1HPWYApsbton
         QHyYYCm8NMeXO4lJOpfdQRfB2AXDQJz57NVhtQe0Lq0etOYUMBXQFeHogu4mkDS7ccwv
         GauQ==
X-Gm-Message-State: AOJu0Yz+HNY73ttoXVxHFUL65gLDCb+VaUecD9KdFA3dd8NQdkmROBBx
        XCOyFutsVdYf2pvASfZgBraBBHsQHcm2ZQ==
X-Google-Smtp-Source: AGHT+IF4N/l3CnVfI7YkZfd8KnsjTquzB4kK5ve45u34ccR1+T1p22QjOLzpfwSQWYj+liHH2P/uEA==
X-Received: by 2002:a05:6a20:8628:b0:14c:4dfc:9766 with SMTP id l40-20020a056a20862800b0014c4dfc9766mr3194642pze.46.1697603796723;
        Tue, 17 Oct 2023 21:36:36 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id ja9-20020a170902efc900b001c3267ae317sm2450863plb.165.2023.10.17.21.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 21:36:36 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 0/2] staging: vme_user: Replace printk's & cleanup log messages
Date:   Tue, 17 Oct 2023 21:36:31 -0700
Message-ID: <cover.1697601942.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Staging driver vme_user has a bunch of printk() calls in vme.c which
triggers checkpatch warnings. Remove all printk's and change them to
the appropriate logging mechanism i.e pr_err()/pr_warn(), or 
dev_err()/dev_warn().

Also, cleanup the messages further by using __func__ in the string 
instead of function names.

This patchset fixes all checkpatch warnings like:
 
    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
             dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
&
    WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
             this function's name, in a string

Patches must be applied in order.

Soumya Negi (2):
  staging: vme_user: Replace printk() with pr_*(),dev_*()
  staging: vme_user: Use __func__ instead of function name

 drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
 1 file changed, 94 insertions(+), 81 deletions(-)

-- 
2.42.0

