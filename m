Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8227C763D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441905AbjJLTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:06:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58D83
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:06:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50337b43ee6so1814134e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697137584; x=1697742384; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRG/Q+khD2cAKTgkqi3DOUxaLzalQQAE2INM+FeGIZY=;
        b=H1PyF7F57ErNf8MJVDuxzLGw3sW0x33XEcPaijVq9HD4kMjhT3NtJSgzJzByDfiYdR
         FJm8c8P+pkvv8XD+j8Vk9+DjgtlnSJuly/OY26VcJ6gB+bHDFTydYW4gDfRRZg1h26jP
         iLn/7MbnekPhLEVyBfw7BlgB0pAd+OFTewCj4ry/pNrdSVbVem+eafKL/o7EQg0ijvxA
         tUas2Toxlx5znVCK9ftvwrkS6Vx3Z2yYQNsVYeEzpIPnsHwa+IMWjsQUQogTrA/FTxyp
         7MTnWZO7dZoeh1EJIESZUG2Jr1XMhON7EjDcV/RGVoJeZImKd+wFFPlFyR4xdWYwpi/N
         z64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697137584; x=1697742384;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRG/Q+khD2cAKTgkqi3DOUxaLzalQQAE2INM+FeGIZY=;
        b=KnCAoBSraF78KAOuxr8GZD1QeAbCDR+Biz3jPxhRACPT0hIONYgrrNi9971f/g82FQ
         KWXO+zG6Htregu3T5sA58yBwoH6ikYbm46WftJ57WtxGttfmNFmAWidYQ+kGRw32L7fJ
         Kg8WnsL2S9gamfIv4re1Fjd5VNzIHyONyHGg+RW3dtusWKTwyH4ekUYbteozhq+7Mha5
         9swBIY3XWnHptRFkwcSCK2Oh4psKp0wZU6Wtsl3U3IP4Lyu35araQDovCelbOZBzCGv7
         bvAY0WmK+BiA/WsaY5XImhTWUabPyMC/V3YGza8bl9M74/de/TMvnzUMpmtgOnrT64mF
         M/5w==
X-Gm-Message-State: AOJu0YzMFxWl6NPAkVlhnosDqKeqCNtrkYFMX2dsqswj347PqvuaAI/Y
        P4yY33qljdbdE2sl1mfTRs+vHQvC1Wn6H4Uu
X-Google-Smtp-Source: AGHT+IHCatDuHoVLOodvZHyWbaPIKuEY1i2ybALWQhnXImPK6VTRXGS0KHVz0W4W3sA03WzDzP18Pg==
X-Received: by 2002:ac2:560c:0:b0:507:9745:8629 with SMTP id v12-20020ac2560c000000b0050797458629mr873868lfd.55.1697137584259;
        Thu, 12 Oct 2023 12:06:24 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906360f00b0099d804da2e9sm11511509ejb.225.2023.10.12.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:06:23 -0700 (PDT)
Date:   Thu, 12 Oct 2023 22:06:21 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Archana <craechal@gmail.com>, Dan Carpenter <error27@gmail.com>,
        Calvince Otieno <calvncce@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: remove strcpy() use in favor of
 strscpy()
Message-ID: <ZShDrTH1wTmTxqlu@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In response to the suggestion by Dan Carpenter on the initial patch,
this patch provides a correct usage of the strscpy() in place of the
current strcpy() implementation.

strscpy() copies characters from the source buffer to the destination
buffer until one of the following conditions is met:
	- null-terminator ('\0') is encountered in the source string.
	- specified maximum length of the destination buffer is reached.
	- source buffer is exhausted.
Example:
	char dest[11];
	const char *PRISM2_USB_FWFILE = "prism2_ru.fw";
	strscpy(dest, PRISM2_USB_FWFILE, sizeof(dest));

	In this case, strscpy copies the first 10 characters of src into dest
	and add a null-terminator. dest will then contain "prism2_ru.f" with
	proper null-termination.

Since the specified length of the dest buffer is not derived from the
dest buffer itself and rather form plug length (s3plug[i].len),
replacing strcpy() with strscpy() is a better option because it will
ensures that the destination string is always properly terminated.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---

Patch version v2 : 
	Correct implementation of the strscpy()

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

Patch version v1: 
	Replacing strcpy() with strscpy()

 drivers/staging/wlan-ng/prism2fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index 5d03b2b9aab4..57a99dd12143 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,

                if (j == -1) {  /* plug the filename */
                        memset(dest, 0, s3plug[i].len);
-                       strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
+                       strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
                } else {        /* plug a PDR */
                        memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
                }
-- 
Calvince Otieno

