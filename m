Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9C7929E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354332AbjIEQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbjIEDrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:47:45 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04484CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 20:47:42 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76ef653af2eso130827285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693885660; x=1694490460; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3kqOBQ4SWwtmqJaVKiTK8RTKEn/bkc8/7Nm3cWOW8M=;
        b=KocYGqBnZFT+mzfNLlCBVZa2LwDOlsKxiAyCDNp+Tb2LJ9/XILq85nib37wx1NORB2
         0XPAFbcnNEHpsRjocv/Ym7yH2EDf6Myz17q6VSoAL8E2pb9pnCoM6qW6QhAuz6YelJfy
         x61uiVOxNlS3Zl9mt8vuzAFk3l+WkqFlLR4GnID/CeBp+2LYfiAe0RacJPzNXsHBVn6T
         WKC6LIgxnIG+TrU80YnB4eYuGnrx6+L0CPU+s5RPP1O4rA/P200LEyxKdRAbYlW7mZqB
         bMXWAMJuu8o+hNP8xZ9XHCoYvNIq8cNciJb1dhdoTJpxDsqfNDwy8sSUMuSvTz2cpKC1
         PKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693885660; x=1694490460;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3kqOBQ4SWwtmqJaVKiTK8RTKEn/bkc8/7Nm3cWOW8M=;
        b=O87ziOzwwNEb57elaLUJ5SLyzomt7dBsRjrbu+sj6NYTS0RXXvhAgk9zHE69GY4K0L
         lN1i/6/sIsG9JaU8L537GRAGqKUbPyOkyoHKc4s33F+2RZ8QzMj/5lg1XGAAYvEyBMdq
         DzQ1QHmYM8Tnc2VTijlS3IVpM5st6FXMq9iPLkvo6+vwZzI2Ev6oIjtu6WDGF03j3a8+
         K/9wqJ289rnGEnf+ebSYhUqoMCYjAeljzziNABMygDnPPTUyEHWaNNhIm96Mwhhgrs9d
         9enl5P9hYVK5+CJCpGwPqXuciH61oBgKpxJwSFzwfb9C7GvXj3h0PePY6HhbWpl5tDiy
         TRhA==
X-Gm-Message-State: AOJu0Yx0YLmEBFFAnIIJRF2xSVEQOA+hExEtU3FUPj0fVpRVaCOCQ2O3
        p4Ac/k1tm7udjbhpRVRTVGFAg4JOBa+WiQ==
X-Google-Smtp-Source: AGHT+IGDY1gvVPRRgh0SuAQ7QVmCzNsri1r/n/759svhqiET99omlzUAbIV+g5tu9e9ZCWDFMBq4Hw==
X-Received: by 2002:a05:620a:4509:b0:76f:272f:46ad with SMTP id t9-20020a05620a450900b0076f272f46admr14964942qkp.49.1693885660224;
        Mon, 04 Sep 2023 20:47:40 -0700 (PDT)
Received: from midnight ([2001:8003:6434:b000:c30f:d88d:412c:6e9a])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78696000000b00686bf824b3bsm8022513pfo.136.2023.09.04.20.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 20:47:39 -0700 (PDT)
Date:   Tue, 5 Sep 2023 13:47:36 +1000
From:   Angus Gardner <angusg778@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng
Message-ID: <ZPak2AD8lKfcqEXG@midnight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unnecessary parentheses identified by checkpatch.pl removed.

Signed-off-by: Angus Gardner <angusg778@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 471bb310176f..948db2433463 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -351,7 +351,7 @@ static int prism2_scan(struct wiphy *wiphy,
 		msg2->bssindex.data = i;
 
 		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
-		if ((result != 0) ||
+		if (result != 0 ||
 		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
 			break;
 		}
-- 
2.40.1

