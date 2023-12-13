Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941418112BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378931AbjLMNWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:22:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE983FE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:22:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c4846847eso31659355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702473767; x=1703078567; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jY13RsvR2p7nAVWn/STfQAiQyGaFoi3utwqqvjImNyk=;
        b=Oq6YiaXYzOaamZEp7gALMU85D8UlkkbjER2evO96CvFXabDs7pnBOtC4HMvZK7JnKp
         Ok4KU4DDUffyyGaRepYKa+gAz8W0F4WJAuH5EGKxhgFrQKKi1a3CjqENOjAAf1+J7XlP
         MvnQG6FQgwwTXU/+YPaOVI78XfrMcmsAP5WI4WkIE5yhIa0udduEEikW7NiflFe8+sGi
         3h5JsJApeit2VNth/gMlSUQXyuT6Q5+ugNXZe1AagCvnTFVlRC0jyCLwf/NhtqHrvcoe
         qvUdPOesNmJlCjBn834dDD7vnjp+MIWYUJ3Aa5wAepn6lMVfy/ei2rnx2jks92FzHxXh
         h7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473767; x=1703078567;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY13RsvR2p7nAVWn/STfQAiQyGaFoi3utwqqvjImNyk=;
        b=BnttK0SXJJ2sFRveRs9NpegQNHfMhHTDfG/cxl28mMbcuXJDV1PTvHj/4Gx/a3+Hqn
         8YVSGssFI+KleJ2aYMp4tSF1MesBzPEoa4lwBPjEyEr3gSgnCYl5iB2syMk8ITNBRHMz
         QaK0gh+VdhM7A78gN3aPY6Fw40Dnw4A2fUBJ9Qr7otEg/VcUm0UVHREzOes0E9xB/k4V
         7LNTahWwQQi22PtT64YRN5KOYuIqzuzd5IOrUYDJpAX+23kebu7KQV0uRGtRfTs/o01B
         vlF0sPzG696NnnZX+kTpKdXbj2tu1Ag9XIWAHCR80I8ap8Y2j/cbVBBqdz1TsjnvEO/O
         DO4w==
X-Gm-Message-State: AOJu0Yxpj1JovamxNa9PPBMazXnovAlr+e4koccYYoNUzWYhOSFPWvwy
        Sja6SYz6x1ERe4ynHbHvXveLLw==
X-Google-Smtp-Source: AGHT+IFNIB8ZVVFyMT1ctnUHjs97JWr+gn9ZrulTqN7ITxPsUO3rpI/TAHzPGq9CbL5OwD8wPmSpAw==
X-Received: by 2002:a05:600c:3556:b0:40b:4c54:3d78 with SMTP id i22-20020a05600c355600b0040b4c543d78mr3882194wmq.28.1702473767093;
        Wed, 13 Dec 2023 05:22:47 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id s5-20020a05600c384500b0040b632f31d2sm20693616wmr.5.2023.12.13.05.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:22:46 -0800 (PST)
Date:   Wed, 13 Dec 2023 16:22:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] usb: fotg210-hcd: delete an incorrect bounds test
Message-ID: <ZXmwIwHe35wGfgzu@suswa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Lee Jones <lee@kernel.org>
---
v2: Use the correct Fixes tag.  Add Reviewed-by tags.

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
