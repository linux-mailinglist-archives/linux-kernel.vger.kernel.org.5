Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7377001F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjHDMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHDMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:22:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEDA46A6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:22:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so14198825ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691151755; x=1691756555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3PEClLdiiliH1dtsL2h+XTbEz6roLIfQbCqPY68CHc=;
        b=OFwVFmRsJuV6UUqxTdx++WeXscIG9wz3qJqRrDuAXHg7p82x3VGU2mwIUaxTx6orxM
         dUqfrQE64FTMZxaB4Fm9qEk8aswDQ8xR11o1GRizBmyTaX78xDUuy9UFrqFUankR3mlv
         SkA/DRSfyuydkQ9bpZDlXgcFxTrsR1ZstGwieEGBIZej4WUgYPT4xRuFrXfDa5IeO3So
         wA+0+7pj+nIkGdNlhlchKSVBKl07QYHhSUN0zeZ8WQxZRaR3SsMOsVftI6Q98/4LemJS
         GmHRP5ZpS9el+YQ7EjTn8vcnFc5DX4CgPJVTPs14zmKsoGTMq/6yt44ltY+yxqD57Sku
         iXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691151755; x=1691756555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3PEClLdiiliH1dtsL2h+XTbEz6roLIfQbCqPY68CHc=;
        b=f9dKJUgY7GKxbT8HHhFW1o4fWChf+OmHv4BTZarQJpKHFRbYRFMukh70XqrXH6YCAM
         lWTxmTZg7pZSnk/Oq0FSCosWvHLzV3s7eBDx3F249N66GQS3est5vRGjCZC03exK9zCv
         XCrYTSZiqgwrY1DWOhr2ifHfgLaT5iISy8X87ryDeMmJVTcKcqHcGMNT2rjlvDfj/2Mc
         G1C3cYrfJlb3fh++Ks+9K2Dkfnx7iMfZWWsKF+LDmXC9Yu8C8V04mw2LglOlMFMcttNY
         WJ2KqQe7HqyUNQ9wRQztjbRWOoqfiVjV1W/jEnUbK7Xxm+0oREaCWiJXRUWxuVEe/Tw+
         JcCg==
X-Gm-Message-State: AOJu0YxurGgx+a7ca5XxknDUBaVoj8Iv8MnUvr7OuPCv87yiyI+W2mBt
        wlt4iJ5/1aB/mUuURbk//hE=
X-Google-Smtp-Source: AGHT+IHpYA7orGRpAw8gM8JsOK9s+I3bvjORcwLq4xVjARLrP7QPuxGl5Oo/M4efK1MNCgDs7GIjRg==
X-Received: by 2002:a17:903:32d0:b0:1bb:14e7:4fd0 with SMTP id i16-20020a17090332d000b001bb14e74fd0mr1598438plr.7.1691151755615;
        Fri, 04 Aug 2023 05:22:35 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.173.209.14])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090a6c9600b00267b7c5d232sm4364965pjj.48.2023.08.04.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:22:35 -0700 (PDT)
Date:   Fri, 4 Aug 2023 17:52:25 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: replace camel case by snake case
Message-ID: <ZMztgcr3GYqSF9sW@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

