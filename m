Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0157C76C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442135AbjJLT2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441868AbjJLT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:28:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2049B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:28:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so1761644e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697138916; x=1697743716; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9gOrgWsv2J6btDunJZLLHwFNG8Aa1HIXtQ4lvtTYx8=;
        b=FayJEcrd8I116WZ+WFFcwwY2DH+8IA2As7yLMYjf7TaQzuYfmtP2jEkFA4Dmgz/sg3
         ZsYF5jyrfqLvqDH/KRfkUC6PTk1xgZcE1p2tD81+Lu1tzovOShOeQMFS85AhK3HlEdh/
         VqahK6U2eJWD40Ibixvr77F5wcwXmaLdnxVgJporge5M+Et3GEXX4ggwS1wZI9H4B1ed
         R34KU/Ul1eSjecADdZ6hnPJXD0s0Bonb5F+QAtBTquD415GhcB0GUBDxy2sYduMqEh3X
         L4KZ1NA7+z8oivDYDRwgWhzgW5nXgWWn/xes2dqIcuK5GkczHi+R9oVKrR2qbJHsACam
         6eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697138916; x=1697743716;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9gOrgWsv2J6btDunJZLLHwFNG8Aa1HIXtQ4lvtTYx8=;
        b=d74AoXvk4sKRwGBx1Oc+x5bqD48fSpZ02NVPn2bX/B9dmZk+8qLcxn3Ddl2kLUBc9T
         NNpKGBUnCWLmWetX/Cyb3HNIuvOCmCJbPBRVNAnm/KuGkk9rulKiI8v0o5F1BIvSchsK
         64lunOgoRs/Ar23BIbgAafx9p03q6SpK8U9hGO9/ckJWkkWwL/7e+pxtghZSzVdSX8sn
         pemlfsy0DrvlRYIEHHj07MZOhezlEbABY9hAGQdJwXaw5gG5sVQfrHFK5IgZnAsmqXKG
         r49POOHLZvqPjnmuxEKIGDsAy5c4LjOZn+htavGD28hIua/MpsVv/thaqUE2P37GJWW1
         aNDw==
X-Gm-Message-State: AOJu0YwJ8dS/S8jD14ylPuQl9mTpHJwZ0yfzwFFYxtDhzUaU1hHWgw5w
        nAadIrpk/zaHuQhTezR4T3OzDh7etERwXQlD
X-Google-Smtp-Source: AGHT+IH8kFm6q6/3YL1bP7fre04tBPI6ULTnfUTe9BdmPd7wPxPHpyyYaD6OoWfgPqoqMIRu4L3gkQ==
X-Received: by 2002:a19:4355:0:b0:505:7014:8c6b with SMTP id m21-20020a194355000000b0050570148c6bmr18569313lfj.50.1697138916275;
        Thu, 12 Oct 2023 12:28:36 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009a168ab6ee2sm11380536eji.164.2023.10.12.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:28:35 -0700 (PDT)
Date:   Thu, 12 Oct 2023 22:28:33 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Archana <craechal@gmail.com>, Dan Carpenter <error27@gmail.com>,
        Calvince Otieno <calvncce@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: wlan-ng: remove strncpy() use in favor of
 strscpy()
Message-ID: <ZShI4amWv7sdqfse@lab-ubuntu>
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
current strncpy() implementation.

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

Patch version v3:
	Correct the patch subject headline.
	staging: wlan-ng: remove strncpy() use in favor of strscpy()

Patch version v2 :
        Correct implementation of the strscpy()

drivers/staging/wlan-ng/prism2fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index 5d03b2b9aab4..3ccd11041646 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,

                if (j == -1) {  /* plug the filename */
                        memset(dest, 0, s3plug[i].len);
-                       strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
+                       strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len);
                } else {        /* plug a PDR */
                        memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
                }

Patch version v1:
        Replacing strncpy() with strscpy()

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

