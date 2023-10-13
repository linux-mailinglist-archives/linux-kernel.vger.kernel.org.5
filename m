Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66047C7D60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjJMGCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJMGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:02:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26572B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:02:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso139111a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697176937; x=1697781737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkm4IcvDcpDNyn/dmP3dcHytJ9yQBVbR6NWIK3pDrZM=;
        b=gnCHWA74Pr2uS8EPGVtaBw6AHpE9BVLldQlq0sGAWmGBh08fItYmVU5qnCGd0lvzAw
         g741E8yHF1+yI4KqmHdX92EYPfDfr+yJlBhUBwq1+vf71Tib+Kx9g+YPtWZdVVZtAaxf
         pomktdEXLdFiMs6e9UprGsVnDwok/DBFjhEQzXom/0O2bwQ6IE5pQyeDR2d/6sjZUI+A
         55pKH6tMGghB6CTsrdpG3eYXBoBHqMEt/oRBNTcpUcn24+CM9+lNRJdnV8fZ3xJdNh8Y
         3yTdjMzU1H5fVNs/82ct4E7W2CvTimnO4Hzw/uzvPcs8jqeQeOwrt2o/cRhvhL2eP7AZ
         7weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697176937; x=1697781737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkm4IcvDcpDNyn/dmP3dcHytJ9yQBVbR6NWIK3pDrZM=;
        b=H7EN9YlfXEO1hmVRnLLBe+2UdjBSubtLQizatD3t+p9CoH16nCbKLoa5hr08+U0A2I
         VbDMAqWO5nEvJBn97AaB+2xuFkr3oVA9SxJbkNAx9YDYkuxTw8vLxK1VCYBVctKKhdQw
         H57ObBROIRcQx5l+r501X6YKmP86HwuEYqfVOB9FBFwvQFVIm9CeeU69wbo2T40GWylz
         qnBv0fzaT2wIwFdLI39CTW6dotkwcyPZ6d6vHdG/Uaz6Waf92CHGBeWWI6eFPudn8P1C
         SNAo6Y+qohI5X8/s4UJSR8/UH0v4+t8DBdG1zZkD2dlpDpSFLJLqWiW+GTb/WEhWMJZM
         xHgg==
X-Gm-Message-State: AOJu0YzrVW7sA1mykpfNXjJTk6VnoffScSUGeZOAvDA50OUbrusSiO6X
        g6mZwrvCj/rqxw2mrFe9NbS7biktRsiSXA==
X-Google-Smtp-Source: AGHT+IGMG45OPEZAKO4OiwlMTwMN4sWA/GNOyRt65f1AGaPCWMqVq5McHbllL0c5DdU1PWITro7GIg==
X-Received: by 2002:a05:6a20:1584:b0:155:2359:e28c with SMTP id h4-20020a056a20158400b001552359e28cmr27705663pzj.9.1697176937436;
        Thu, 12 Oct 2023 23:02:17 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001c74df14e6esm3002930plk.51.2023.10.12.23.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:02:17 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: gdm724x: Add blank line after declaration
Date:   Thu, 12 Oct 2023 23:01:57 -0700
Message-ID: <20231013060202.13419-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix WARNING: Missing a blank line after declarations
Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 4e5cac76db58..0c61eaff6122 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 
 	while (remain) {
 		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
+
 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
 					(void *)(buf + sent_len),
 					sending_len,
-- 
2.42.0

