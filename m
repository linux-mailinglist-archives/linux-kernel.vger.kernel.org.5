Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E33F7C98D2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjJOL2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjJOL2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:28:16 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0F123
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:28:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a82f176860so22219597b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697369291; x=1697974091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E0umn+rEfJvO7Gxt9lQFRe3g330wvteerdClQ7lgaU=;
        b=U9Vcwme61ZEfuz5sj7Dbpx3eHByUPnT0WBxR0z6cycaVS9Us2DgufAPBvXGdViJk9V
         7cX1Cio3mlxTFrVUWZanrFysfMtzhVw3xDiQsZLoAdslxB9n2whn8ILgvUndp1XxAVoL
         ruRiWuTM7zxWxOtv4CnBHM+grBWepuK78cDQK/MhgJY7GLER9OqxkDGL8W5kNp3ZcrrW
         jp0uk2bWie/nDvlm4QLQ7e9xpt5PG0RkaQk5xHfkLtt8fXniLtZ5KZqWvfxQRlUelKtG
         DQZjBXyZPENuZfKosY5D2Qtatcg1fy+Srap3C/N5zrCsD6B6SDu+5BJycFjmUvo+F1EI
         FXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697369291; x=1697974091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E0umn+rEfJvO7Gxt9lQFRe3g330wvteerdClQ7lgaU=;
        b=CgdCqdMR9jbp1/iSN1NMSQJsy36P4eWLA+6yEwnL6MoOMQNx2iDVhyYcU1EiA0Irzu
         mbmu3SZHOaA/d86GJ2WmFONLz38Por8ZbX9uHi90t0eGzmHJ8bwkAX3ZZxVBDIz+Wszx
         OkDf+C+rfSi2D9FboeHVaOWd+D7LQJZo0+fjoXyZkAn3hDSgJsXRJbckKVd443tfKwV8
         I4sbjfbTFw1PIia5Sv0zBx2jmEesRhF+/SKt+svuE4DWBTTW95zlBMLTGDJkfYLkbFb1
         blnlatO7cwr3E0WIi74HrUumnks1jJLtnvE72vgpL9Gb8CCfN8Gsgh5IV5/3NlC0kgoI
         lE6A==
X-Gm-Message-State: AOJu0YwO/KKEwQj6ZqW6MwYF1zdXYhsXZDnfhnnC9wSAhqGUgTkGYv0z
        27bZskTO+xAMKVOTQ8zqcSaERoHEtvKsQr1C
X-Google-Smtp-Source: AGHT+IFm6Pj77L5sMLBRF1FfSD8KVSBA3IDNnxSPg9YAUEFBEIMfHff/VIFYhwaZxpgydUCRpMPBiw==
X-Received: by 2002:a0d:e403:0:b0:589:f445:19e with SMTP id n3-20020a0de403000000b00589f445019emr30273332ywe.27.1697369291133;
        Sun, 15 Oct 2023 04:28:11 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id r128-20020a815d86000000b005837633d9cbsm1300894ywb.64.2023.10.15.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:28:10 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 5/6] staging: rtl8192u: Align descendant arguments
Date:   Sun, 15 Oct 2023 12:24:51 +0100
Message-Id: <0162d0d350aebd6b9d7cec1e7965b6b8ee42f82e.1697367161.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
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

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_firmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/rtl8192u/r819xU_firmware.c
index 4f8629e47e82..c515b4773e37 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -88,8 +88,8 @@ static bool fw_download_code(struct net_device *dev, u8 *code_virtual_address,
 
 		index = tcb_desc->queue_index;
 		if (!priv->ieee80211->check_nic_enough_desc(dev, index) ||
-		       (!skb_queue_empty(&priv->ieee80211->skb_waitQ[index])) ||
-		       (priv->ieee80211->queue_stop)) {
+		    (!skb_queue_empty(&priv->ieee80211->skb_waitQ[index])) ||
+		    (priv->ieee80211->queue_stop)) {
 			RT_TRACE(COMP_FIRMWARE, "=====================================================> tx full!\n");
 			skb_queue_tail(&priv->ieee80211->skb_waitQ[tcb_desc->queue_index], skb);
 		} else {
-- 
2.34.1

