Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893EE80BBF9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjLJP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjLJP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:27:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FC123
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:27:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c192f488cso5992245e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702222025; x=1702826825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geLw7oiaKYTuY2XiNNlgp2W+j2j+NV9E7iJ/5OuM2YA=;
        b=kkJfJYzTp0Q2ZrYqeRvHVOb2kcOzfwKUAuoOCEMfLpVdHOaFfBBAcNxhNdOFN5jYgu
         v8RGVvbneAyQ27PzGbKnlWYJClHwSI84ekvzvYwwJURfVOYRgA5Jye5cDbWQOEAx4TLf
         SZhjJxW64VhH67AUAdnLwTijoOFaxrVH45oGR06D5r8/8qa0fBczvkE6atSd7c63JPcf
         KWBqpxqpULzqb2ARVcp0rN0wRTlLYr7iP6/E23Pek4rFDW3AkSxS6OP9ToA/Wf12c8oL
         YJDF0SD5rDAKb/hKBXX0Fb+voC/K/Kzwiq7Udrn8ouZooTJUtKp4/gsIqC+09BOGogYN
         e21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702222025; x=1702826825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geLw7oiaKYTuY2XiNNlgp2W+j2j+NV9E7iJ/5OuM2YA=;
        b=qd/go+ku5pn5WeDZdmnYZP1CaqC2GcDC7PvVByr5XUUUAV43f+MHPvmXGUWdHE961r
         G3F5gn0hrzGJQZUzjWop4tcU3G07e0cfEfck/4RQ/92bndDcx9gvi1MKJZpJ1rDYjePd
         l8FfwGorAFL6dnb7kKfTcsIiG5eqw591aWFYIWuaWlsoWQBScWhJz/yEUchtGltrn8vx
         mQoar++KnHqmeZrXfG+DzRZMhRtbU8EP5azCWSZkv/pf4lwrAcqugSreDyr3jn45zLQt
         LSGYhbLvXnmC67O6+wEjgRIZZLxVkqCTcbdKmvoqrU9UIUET+vvBIlDxiSBpj3bxUYzf
         Y8wg==
X-Gm-Message-State: AOJu0YzyrrMfxVWkUI/XUii/r7cR4t/ITd4KrFlYVXS9brbYW/1vzonb
        Sjym2Rg+wgx5a9rtvxjzzLI=
X-Google-Smtp-Source: AGHT+IF9WyWBDNKFv8tAvjn1xZzkvUYPZW8FYaBnWJF2y8KqdJlSpf/oidoYYUZxpb6PudMK7ZeuPg==
X-Received: by 2002:a05:600c:524e:b0:40b:2708:2a52 with SMTP id fc14-20020a05600c524e00b0040b27082a52mr4018653wmb.1.1702222025086;
        Sun, 10 Dec 2023 07:27:05 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0040b538047b4sm12250228wmq.3.2023.12.10.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:27:04 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:27:03 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove struct ht_info_ele SelfHTInfo
Message-ID: <e8692d40b3cba3de1b4ceb8e72186e8d40afec73.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct ht_info_ele SelfHTInfo as it is unused.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 416633b88446..0f27c820ffc5 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -99,7 +99,6 @@ struct rt_hi_throughput {
 	u8 cur_short_gi_20mhz;
 	enum ht_spec_ver ePeerHTSpecVer;
 	struct ht_capab_ele SelfHTCap;
-	struct ht_info_ele SelfHTInfo;
 	u8 PeerHTCapBuf[32];
 	u8 PeerHTInfoBuf[32];
 	u8 amsdu_support;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 439b43faa2bb..0474594a4b96 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -554,8 +554,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 	memset((void *)(&ht_info->SelfHTCap), 0,
 	       sizeof(ht_info->SelfHTCap));
-	memset((void *)(&ht_info->SelfHTInfo), 0,
-	       sizeof(ht_info->SelfHTInfo));
 	memset((void *)(&ht_info->PeerHTCapBuf), 0,
 	       sizeof(ht_info->PeerHTCapBuf));
 	memset((void *)(&ht_info->PeerHTInfoBuf), 0,
-- 
2.43.0

