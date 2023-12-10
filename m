Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5768980BBED
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjLJPZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjLJPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:25:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010AF3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:25:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b36e721fcso7374675e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702221954; x=1702826754; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU3UOTWi/bc8m8mRCi3eOJl1ODr7yK88X76oXpFr/pc=;
        b=TlXIe2xcGE6Tw4Q1xjvvjeMQJvCvbhVNiVxcuwCvzrHRVvT4TwN7P+uCXi3SGCqCZN
         IGlWGe0kxjWFAWj2XVETEOFYfDpAluxWYC1HzRQ8GpOUdKUYcLiVskqQ7uatUmZNoTsu
         z+Bg1wrjzpNO5MW2RStCLoiOhYMLsMnorIRo9NRfaQccdSEpKlvrugFA3yyTlPSuUz4d
         HrBih5S9l6ybE1MF7l4DXk0080ic03I3oz7G8oVLfHQMLXA8J559yiFlP1rKkphvAb8Z
         3MZAFshU8Um/ctSVUTWS/CJDVsmIf6R+4C96CWOOhl0UH0FjPABQ8qNI02oci3qMnKAM
         TtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702221954; x=1702826754;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OU3UOTWi/bc8m8mRCi3eOJl1ODr7yK88X76oXpFr/pc=;
        b=FrVppMvQxxuBOZ6FlEUzVkiLMDgx3Xo+Vxk/Olf11FMBLdXb/W6CYDppnyLEiqg9y5
         LtCdXxsFRV8umXHd6msn/q0BGbIKvF7Ho2qpG8fhIjqGa+3dx3RnGSSYX4le9+bix9H6
         ILvRuauRhPlZiOiReECntkF1Z1ir+kP8Rsh7UAAWokJsrjZ7Xlb64ezMK/gWFBAH6Yy2
         3gw2W5Tcl6rArN6hx0AKONmXNnvHGeVgzU5TEobAyYE4XVlITunDcc7OHIYC98MjXmCG
         qthLO9vs4f0e/qemOQVxxNaMSsnAWf7R157t8Y2EAYplOSSIoaW+hZTLRKftbo1TgG4d
         Lz+Q==
X-Gm-Message-State: AOJu0Yw9+kK8hwqDoeDm9M768yYgtx27UvFhhBwRu1f8SS73ww90Tjh1
        ngJyovW4AVuxUJwwbUev/Vw=
X-Google-Smtp-Source: AGHT+IF8xpX7wWYcaDpuGbCoRU2s7+3c6lI7BAfqTZv24zjpHCv4Xktk4Esu7Gz5utBvvqCohlYvfw==
X-Received: by 2002:a05:600c:2eca:b0:40c:3172:acb2 with SMTP id q10-20020a05600c2eca00b0040c3172acb2mr4015413wmn.4.1702221953810;
        Sun, 10 Dec 2023 07:25:53 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm3867397wmo.41.2023.12.10.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:25:53 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:25:50 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Remove variable reg_bw_40mhz and
 further
Message-ID: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused or unchanged variables.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.
Tested in b,g,n mode and n mode in channels 2, 9, 10, 13

Philipp Hortmann (10):
  staging: rtl8192e: Remove unused struct iw_range_with_scan_capa
  staging: rtl8192e: Remove variable ht_info->reg_bw_40mhz
  staging: rtl8192e: Remove variable ht_info->reg_supp_cck
  staging: rtl8192e: Remove variable ht_info->reg_short_gi_20mhz
  staging: rtl8192e: Remove variable ht_info->reg_short_gi_40mhz
  staging: rtl8192e: Remove variable ForcedAMPDUMode
  staging: rtl8192e: Remove variable ForcedAMSDUMode
  staging: rtl8192e: Remove equation with pPeerHTCap->DssCCk
  staging: rtl8192e: Remove variable ht_info->bCurSuppCCK
  staging: rtl8192e: Remove struct ht_info_ele SelfHTInfo

 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 22 --------------
 drivers/staging/rtl8192e/rtl819x_HT.h      |  8 -----
 drivers/staging/rtl8192e/rtl819x_HTProc.c  | 34 +++-------------------
 drivers/staging/rtl8192e/rtllib_softmac.c  |  5 +---
 drivers/staging/rtl8192e/rtllib_tx.c       | 21 ++-----------
 5 files changed, 7 insertions(+), 83 deletions(-)

-- 
2.43.0

