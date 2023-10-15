Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4E7C98C7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJOLND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOLNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:13:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D24C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:12:58 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7c93507d5so41876427b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697368377; x=1697973177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7ir7MAeCxuydH35Tr35csIS6YonhaPinnnXnjQUiNE=;
        b=IoTVARl9d1oBO7qG1xVKmIOHFAl8MYeXzrjwcPeRyXxiDBrwGW+/UrUZvaGgjsWb9X
         1u9a3X9LQmzj/771ZT64pGud5ywt28R8r+k28OPBeb4H/WO5dqgt0nxsiAY5zNm3UOvJ
         yMv2YlSOtbgq8J6Ynp7CANtYFCV2Z1gcTeHaXkCdnNQG4CZD0vr1k6Eusif32p6T/jdl
         MNakndvRa8kW2kz0cj3WSBBiBG2UacOAEr88Td3Mq0EwDl9qx8Gs7zTiYRxAnT8XG4gi
         N0QB4QghiVCCVw3nR1zgRkWY2EADQeQlFCkN4F/1RZB//gbXZCs6fw0LpUFMdo8gF3mi
         di+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697368377; x=1697973177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7ir7MAeCxuydH35Tr35csIS6YonhaPinnnXnjQUiNE=;
        b=lSD2X3Li52YFvT1a/efFYUjGATtNrc+Rb9pdGa8HMj/u6NzXj7J8TpN8RvGQQTKYB+
         yNJc88eXpNj13FvmWfNvqV6J+4LYsYnHzs2b6v4TLILbBXenshpJLcDaqiaGod9tsPlS
         3sYhgk1w8Ld7WK2oRpcoXg42BZCyCTYbH4OJXzYWhf6v++o5SCRdvFtFiU2y/+3osE5l
         pcKaXmiDoqDtYBwjhT1kZXyEkcFVsJGeswbP7QTsLHI49RMqrOOTA9APxfAPYATciyhM
         efeUbLRv/s5giqYtE5snJLR8WVu+Ps0JE9zeWoXAdE0rZkHQ8+yBeL01gadks3TjRseD
         QmtA==
X-Gm-Message-State: AOJu0YxsHR1iky+FbqhxANPwIn4fgp3JH2wiiV3JB496wguKAkthQe4R
        R0pHXO13XxZMb/3twdA6TQw=
X-Google-Smtp-Source: AGHT+IGPd1SufP0ah5tP0oxTseMq4tDZvddQSm/jkyrrprmM9EFrcudWI45v1KLqyHVRiI6LARKzig==
X-Received: by 2002:a81:d24f:0:b0:5a1:d398:2e with SMTP id m15-20020a81d24f000000b005a1d398002emr37982331ywl.37.1697368377331;
        Sun, 15 Oct 2023 04:12:57 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id m132-20020a0dca8a000000b0059bd8447721sm1306262ywd.21.2023.10.15.04.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:12:55 -0700 (PDT)
Date:   Sun, 15 Oct 2023 12:12:44 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8192u: Align descendant arguments
Message-ID: <76218d7a14d7f70c4a1b2f1140a69ac7364f1aef.1697367161.git.gilbertadikankwu@gmail.com>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
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

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/rtl8192u/r8180_93cx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8180_93cx6.c b/drivers/staging/rtl8192u/r8180_93cx6.c
index 2527cea60e3e..1453a0307eb4 100644
--- a/drivers/staging/rtl8192u/r8180_93cx6.c
+++ b/drivers/staging/rtl8192u/r8180_93cx6.c
@@ -114,7 +114,7 @@ int eprom_read(struct net_device *dev, u32 addr)
 	ret = 0;
 	/* enable EPROM programming */
 	write_nic_byte_E(dev, EPROM_CMD,
-		       (EPROM_CMD_PROGRAM << EPROM_CMD_OPERATING_MODE_SHIFT));
+			 (EPROM_CMD_PROGRAM << EPROM_CMD_OPERATING_MODE_SHIFT));
 	force_pci_posting(dev);
 	udelay(EPROM_DELAY);
 
@@ -165,6 +165,6 @@ int eprom_read(struct net_device *dev, u32 addr)
 
 	/* disable EPROM programming */
 	write_nic_byte_E(dev, EPROM_CMD,
-		       (EPROM_CMD_NORMAL << EPROM_CMD_OPERATING_MODE_SHIFT));
+			 (EPROM_CMD_NORMAL << EPROM_CMD_OPERATING_MODE_SHIFT));
 	return ret;
 }
-- 
2.34.1

