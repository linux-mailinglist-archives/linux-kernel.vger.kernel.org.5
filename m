Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57E809F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573358AbjLHJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLHJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:23:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F06171D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:23:34 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso25210335e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702027413; x=1702632213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sF5azUrnouYTUY2Q8ByvyW/W1CG+UKUpVM173B2tLAY=;
        b=lVp4KS2jwtC92RaW/Pw3mhwR4W6yElFDSiw6awBe+4faQI9D8SQYt/YyEgF7rlda4i
         47IrEblk9TZjYlbml+lpsD5qnUqj3XXtDEAYoON9LF9qJNVom5FYn5h2WviYmoXs4N4T
         xv+Ka/1tTPC/bsCmBjQ05btj2SeofEXkWvEsKax3JZ/iquqV/jXjW17AD2IFs64KbQWs
         Smgr9dVxzARxVIceiMXpzxsAx0kAnJllY3YhBm0kwBckT0Z16GHt936Fj+sAmt9MpFjv
         LJ0Ao3mqFyJNM/2Fid2dlS+odixbj7DqI/NFI3JIqZvaiXt34ffWJynQ2TxiO3YeNFZK
         UQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702027413; x=1702632213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sF5azUrnouYTUY2Q8ByvyW/W1CG+UKUpVM173B2tLAY=;
        b=ezsp7wjzPHoeJ8N+NKsWxviq1NzJDeLzabr6yQPcymsQiPUHkcgI6oHZ1oPJjPMct5
         eXNE2zrXZNa1LNccRZSAXi3VyK3Dol0S5r2dX5D7k6PL0OkwlqqkZR+nu4tqUgyMX89v
         bM407iJMw2jixFk+s/FY2hc4CBVbs5hbytpjBkqppbRCUXYmP+Nf9W3EYMAWeFSTWwG1
         uSUVpanMDmkETa+VzdPOGHFEoBbQws17dqs5P0SVZg72yIVaY9rV0Axo1tucZ8wC5mQh
         Zl5madJCB7Ms01b7j6i8+/qxOAByIJ638qCR0kIhrTw7M04g9km8EW2McNPSUbPsB3OP
         kaDg==
X-Gm-Message-State: AOJu0YxEXGUml7BJZxYCUem8XeuAXKBmbSyzcFYP3Cp7W2643hyoc9FR
        VQbzpI4AsbEERXQy1CQN/BgbgA==
X-Google-Smtp-Source: AGHT+IEvKeHokwVerIBIQ2NqGjJa9qqHzGluDSdDAbP3u6FjHfiIdBV63XLY1yTgGyVKnGHC0iwO0w==
X-Received: by 2002:a05:600c:444a:b0:40b:5e21:dd3c with SMTP id v10-20020a05600c444a00b0040b5e21dd3cmr2527781wmn.106.1702027413258;
        Fri, 08 Dec 2023 01:23:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c3acc00b0040b5377cf03sm4537310wms.1.2023.12.08.01.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:23:32 -0800 (PST)
Date:   Fri, 8 Dec 2023 12:23:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: fotg210-hcd: delete an incorrect bounds test
Message-ID: <87dfa523-1882-417d-97b5-f606ff0099f9@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here "temp" is the number of characters that we have written and "size"
is the size of the buffer.  The intent was clearly to say that if we have
written to the end of the buffer then stop.

However, for that to work the comparison should have been done on the
original "size" value instead of the "size -= temp" value.  Not only
will that not trigger when we want to, but there is a small chance that
it will trigger incorrectly before we want it to and we break from the
loop slightly earlier than intended.

This code was recently changed from using snprintf() to scnprintf().  With
snprintf() we likely would have continued looping and passed a negative
size parameter to snprintf().  This would have triggered an annoying
WARN().  Now that we have converted to scnprintf() "size" will never
drop below 1 and there is no real need for this test.  We could change
the condition to "if (temp <= 1) goto done;" but just deleting the test
is cleanest.

Fixes: 1dd33a9f1b95 ("usb: fotg210: Collect pieces of dual mode controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/fotg210/fotg210-hcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index b2f8b53cc8ef..8c5aaf860635 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -426,8 +426,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 				td->urb);
 		size -= temp;
 		next += temp;
-		if (temp == size)
-			goto done;
 	}
 
 	temp = scnprintf(next, size, "\n");
@@ -435,7 +433,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 	size -= temp;
 	next += temp;
 
-done:
 	*sizep = size;
 	*nextp = next;
 }
-- 
2.42.0

