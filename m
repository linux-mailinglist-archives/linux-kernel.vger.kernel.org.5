Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21676EE10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbjHCP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbjHCP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:27:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24243359E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:27:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb84194bf3so7748525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691076455; x=1691681255;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3PEClLdiiliH1dtsL2h+XTbEz6roLIfQbCqPY68CHc=;
        b=Z7rfNE2VzdzatxG1UFZAvohhYF+7QA2YhD0ixakQKhmwy1YuZgGFDvNVsh3hR66hGo
         rrC55Ff9+EKEJ5HbWV9LXQxIzgqfQGh61A+K+ryrxJVWQNvEJPUev/n/Ood4rP5XZDSl
         f2ukN7GwwDtJhqUYZC/xMZourAP/XaNjVTQ0KKVlSgH9EcTOCRZDObF3M2T/6Of7Py/j
         KTeuYNWJQhagoT3lERILi7nsuzCfZe7Rfx+HoRoBszjsSE0VHxwbdkrf1qgQHEILvXLx
         0xTOeHsMch3bSnFP6b9sA/zAzGNB2OODAAJ8iv4onMwB4Muz38I/BS6NEeJZ8WNK+tBM
         4/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076455; x=1691681255;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3PEClLdiiliH1dtsL2h+XTbEz6roLIfQbCqPY68CHc=;
        b=M4fqVcM8AqZjX7CZLAG0e7TaAy46aeOmWEV5XMTUsWy6dPJ4OkZZqbHrGxS7K1HBg8
         rFwerqf0PP6Y/FXgtz25GAIeiD9HFjHta/F5+2X7mz0P/TLp3wPStyXuB499m408bdBV
         pD33GV8TuZMZVMaEsRHLrMal3r3G76nll0/dW+tbnCAjGkNpTArAN6Cnt82IcbLV7rmI
         CMVaebmDpt6svh15C7UGuId39qx4DPR3d9fw4BLQI+IaOW450u8/s5urFxieHVaulviG
         QrkWyEausxFRcJzb9F4ruNyONm5FT5NLpOMqD+pn8xMKAC3jB3uUM6Kqp8ypRmWsstDO
         LzHQ==
X-Gm-Message-State: ABy/qLb0pabFfoV4xXgE4oNkNc/WF+6w7faSLtPLxP1MqcXyJ20HwMV4
        ctqHNmGf88/0CRO+Ihb7tjNRUoFpzkZ4Xg==
X-Google-Smtp-Source: APBJJlEu4wiaio+GPI4TFImQcwQYkHYBU/0TAwL9+yWKK8YhLErTBo6r3L3T5vRw3K07E0xp6NIxDg==
X-Received: by 2002:a17:902:ecd2:b0:1bb:141c:3034 with SMTP id a18-20020a170902ecd200b001bb141c3034mr21319157plh.12.1691076455462;
        Thu, 03 Aug 2023 08:27:35 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([223.178.255.173])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001bc16bc9f5fsm7582494pls.284.2023.08.03.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:27:35 -0700 (PDT)
Date:   Thu, 3 Aug 2023 20:57:31 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     inux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <ZMvHVLVCQakLyWUa@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace array name of camel case by snake case. Issue found
by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 0e135af8316b..8b913c64845c 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
 };
 
 #define CB_VT3253B0_INIT_FOR_RFMD 256
-static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
+static const unsigned char byvt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -2005,8 +2005,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_RFMD[ii][0],
-					byVT3253B0_RFMD[ii][1]);
+					byvt3253b0_rfmd[ii][0],
+					byvt3253b0_rfmd[ii][1]);
 
 			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
 				result &= bb_write_embedded(priv,
-- 
2.34.1

