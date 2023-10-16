Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81A77CB430
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjJPUMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjJPUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:12:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41F3D42
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:11:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c894e4573bso31522605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487119; x=1698091919; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6LHOYtLClzaa9kbN2vgbPQDO5kRAfn0VOdVTmmzqbk=;
        b=ibkpCq+B5sadP78t7twp4NBQb8xj1jCEVp82M/u9VBXIjCTluM0h4Nf6dRhbABP46Z
         PFG2TzUxQAU1l2LLlBWz+keP3ba+TgDd/mw8fUX+FLRpAEsj2CUlkjU6sFgGQDHMOD5w
         Oih4r2Wf2YL6+sIvh3guIgtYM4nWq//6CvF8bcTEWKVDK+9jz37E0TO2A/rt/EHgVvCj
         FfBFhMHdkcydvxN8sh1nJV9mjLEc0a8acCv3SoZM/hcyhovGGFRw95KPAaDGXzXO1oV0
         L0yMqhe2vLpcbGbraKSx7LrOuKO8/dzaQ4g4yviJ1KRTZ2HWSdwejO6NrO5WMgfdCh4k
         yhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487119; x=1698091919;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6LHOYtLClzaa9kbN2vgbPQDO5kRAfn0VOdVTmmzqbk=;
        b=suKByu40cRU1Y+72pp/lDjLJa/a61oi/1naD55wuD+FiKgL+bDPjsvF0rXj55gyoAv
         ioIEAOUQWJP/l+5Z8Mqgo1NZoxdlULS/vz1ce+7ctdkSTfIfvraoIBSDLZTedzilj5fh
         Yt1ZFb0DpxetFA4E7C+oYHgbKRafURBxXAPJr8UeHn7W+TfOBdbOrqMVNlVBRNQusdgf
         a/prSRQVoy3dw3h+Ys5l3hssyVaOdImB+bR+M5YFxwBkrkGRI4sWPX89CAGGLJ2zy9jX
         b+OS/OP8Gj2+4TmDIc3nsbOu+VzQvk+yHf4jBvTvCHykMx8Z1Wy12f88SFs2/QjJNFTi
         D59A==
X-Gm-Message-State: AOJu0YzadGCnMpYH9L57hGmg+1qqP90AljSdTjLBIa9RRFmjGxJqLnJ7
        eYRqowi97RZgvplyJh86nBg=
X-Google-Smtp-Source: AGHT+IEudiALpXVcT8kKa07mFAeKZkNNDuHZZ2axTlVYlbE4sBJLk+OChhPPIDe5+OXr86F5JtemkA==
X-Received: by 2002:a17:902:d512:b0:1c9:d667:4e4e with SMTP id b18-20020a170902d51200b001c9d6674e4emr410662plg.65.1697487119042;
        Mon, 16 Oct 2023 13:11:59 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001bbb7af4963sm27625plb.68.2023.10.16.13.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:11:58 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:11:54 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Replace the occurrences of (1<<x) by BIT(x)
Message-ID: <20231016201154.GA14625@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch.pl:
CHECK: Prefer using the BIT macro

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/rts5208/rtsx_card.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_card.h b/drivers/staging/rts5208/rtsx_card.h
index 39727371cd7a..9d2504fddb13 100644
--- a/drivers/staging/rts5208/rtsx_card.h
+++ b/drivers/staging/rts5208/rtsx_card.h
@@ -338,7 +338,7 @@
 #define DMA_DIR_FROM_CARD		0x02
 #define DMA_EN				0x01
 #define DMA_128				(0 << 4)
-#define DMA_256				(1 << 4)
+#define DMA_256				BIT(4)
 #define DMA_512				(2 << 4)
 #define DMA_1024			(3 << 4)
 #define DMA_PACK_SIZE_MASK		0x30
@@ -542,7 +542,7 @@
 
 #define BLINK_EN			0x08
 #define LED_GPIO0			(0 << 4)
-#define LED_GPIO1			(1 << 4)
+#define LED_GPIO1			BIT(4)
 #define LED_GPIO2			(2 << 4)
 
 #define SDIO_BUS_CTRL		0x01
-- 
2.25.1

