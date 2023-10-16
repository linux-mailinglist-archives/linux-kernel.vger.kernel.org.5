Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8357C9FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjJPGjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:39:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F818E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:39:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4066692ad35so42649445e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697438377; x=1698043177; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iiy71Ki/o2LF//sd0XBr3ccMYvSR+gE4EltrkOccHOo=;
        b=HMK1elYvLuhXaKksmPbqfuyljkbux9Xo8zIUCcUsYYHblJOi0vZ23MNDLk7bjmyC2P
         SxAcCpc89mjJegfXZ6osG7rce9bwC0T/vtna2SqHA7tNKFxsjcA1/76D555MlMsnN8DY
         0lyfuu44ZJzU0jJICW6fse/ALoHFxvgth4vcIVWzS9cyh6fyAZUKJg+12Bh+d/cm9x2J
         JYFXjSbtT/4sqb8RzJlm6ssB4oCbzYZ/1E2iTdTMunarNwNSLoOQ3uVaz75+6lXkZo//
         Cimc4f89SBbjaGlJOOIXzatmIzbLK4QPskq9skSK3K8Edfer1AxIMIN5sO2em3JhYIFb
         qPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697438377; x=1698043177;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iiy71Ki/o2LF//sd0XBr3ccMYvSR+gE4EltrkOccHOo=;
        b=v4kIrvv+H6sVWIJoVni7sOnA09CGA+XDHMWRNeWt53PgNDTeur5awaDGroxyD6BhQt
         HCblH5qPcrWj8VwjI6HBtpRzI89eySnIDen7Chx4fS333TpZLeZ8Cxsz9EmH3lgxKtSt
         1C92utsrrMotelCFuINxqKXLfh8Lj1Hg64y9t5HHprDuY1Lqdxzwm4FIPcjBRv7zh9+V
         3B77yqBUcAAwNu98o5q9GqHPe1smC/TFc/kFrE2Es46aSfuUJRVMyxFkOSkrEH4OZYw/
         G87/gOcm/pWnHXzL39gqKyqDDBSCO1a9VU3t35hPj1mTxyszTAZPVSQQLqwlXiP9mn3W
         /EMw==
X-Gm-Message-State: AOJu0Yzikw4dZN8Raa+DwfoaeILRBDpwh3cO7ut3hFEM0LbTEf+zD0B9
        gwqX8I1pV69RbR37tQdLbUA=
X-Google-Smtp-Source: AGHT+IGCEsbCWSUVGoDB/k1LuP3lsGqIkCWTYbQ+M/DXl+xwMSZfyOm4NmQNkTpaeB9GknAAmygOcA==
X-Received: by 2002:a05:6000:4e1:b0:31f:ea18:6f6b with SMTP id cr1-20020a05600004e100b0031fea186f6bmr27051651wrb.19.1697438376943;
        Sun, 15 Oct 2023 23:39:36 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4c52000000b003197869bcd7sm2410920wrt.13.2023.10.15.23.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 23:39:36 -0700 (PDT)
Date:   Mon, 16 Oct 2023 09:39:33 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Calvince Otieno <calvncce@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] staging: wlan-ng: replace strncpy() with strscpy()
Message-ID: <ZSzapU+eKWvHVwxi@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch suggests the use of strscpy() instead of strncpy().
The advantages are that it always adds a NUL terminator and it prevents
a read overflow if the src string is not properly terminated. One
potential disadvantage is that it doesn't zero pad the string like
strncpy() does.
In this code, strscpy() and strncpy() are equivalent and it does not
affect runtime behavior. The string is zeroed on the line before
using memset(). The resulting string was always NUL terminated and
PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
terminated.
However, even though using strscpy() does not fix any bugs, it's
still nicer and makes checkpatch happy.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
Previous Patch Versions:
 - Earlier patch versions had issues with whitespace, preventing correct
 application. This is a reroll of those previous versions.

 - Versions v2 through v6 focused on improving the clarity of the commit
 message. There were no code changes in these patch versions.

 drivers/staging/wlan-ng/prism2fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index 5d03b2b9aab4..3ccd11041646 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,
 
 		if (j == -1) {	/* plug the filename */
 			memset(dest, 0, s3plug[i].len);
-			strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
+			strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len);
 		} else {	/* plug a PDR */
 			memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
 		}
-- 
2.34.1

