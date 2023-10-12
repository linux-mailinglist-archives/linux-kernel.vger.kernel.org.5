Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD18A7C649F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbjJLF14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJLF1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:27:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269E90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 22:27:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so83954266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697088472; x=1697693272; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozg712u+fkxOtQ1gw/5043+BQ9WtYWW1ZFVe71DFuYA=;
        b=j2Zs2x6qMC8G7CFej5vKHTfLjko/yi36Jtjz37v5eAZJX2Fa7rk10oS5EWpuhiDYME
         usquzsXrBR4wRi1jbTmF9wngv7XgMieY2tvRg31+wLIr/bHp9Rui9Cfpkl+2n/C9ICCF
         rbpYiAI5aOqvmsqu31W8curZZk2iie3OCjw69NBxBUn84uqkndV55gIsBjbCnjd+Xeex
         wL9UtVsh4r1Xf8Ngh7doxlGZ+at/vrWer/ARPjccTaxl07EuQawhYoRuW+hoWojwza0y
         fP7LJmcf7vWrdcfHPBOyYVR4LAlGhiLvJSoJws8fwaUfpHwlRiWQZq3lRkx+uYL4MuR2
         R8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697088472; x=1697693272;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozg712u+fkxOtQ1gw/5043+BQ9WtYWW1ZFVe71DFuYA=;
        b=GGuiI5KJRKWBOZAmqJQacaHrrhHdZ8mJbbvUI3WfIYeAWj9l0bPy/yyUKXvfZhd6t1
         sGFtKSDTG8c0jUKOjEKRlK1QlMdmtep2j04F8JMqe9MJHHzh84hdU6nzSau2gxF/VPTA
         d5yWQqcV0/Wqh1lfC+OtHOIqRDEnYGsaHIbxav+S7SsexZ7tIUYn8is5IlpIGQ20vLj1
         AptvX6FfLiyQPb3JAzkOK5x/prAHVCuYRqXnzvzDqcRyL4fjAQMtdC0SQpX3huf/qXPl
         S+549zGbVdcXUEhkv4/38HUG44zivhRwcclzWttva8QygTYsJIaS0ZjW82wlidaBiAMv
         sEDQ==
X-Gm-Message-State: AOJu0YwSfLNc12rq+Zqf+9WbHygRgLpS+tSpQ5f5JfZ+9PFC7MsjS5MD
        6YSPUwgUlnKAX4rx7TK5W/Ql4HdEoZmhtt42
X-Google-Smtp-Source: AGHT+IF5tYUPLGypOey9huLbPekHSPE+pf00HCsiwFtXUpe7IaMbQweFfXQemW7Ol5j6nK+4EEqVqw==
X-Received: by 2002:a17:906:328c:b0:9ae:4776:5a3a with SMTP id 12-20020a170906328c00b009ae47765a3amr20714283ejw.39.1697088471826;
        Wed, 11 Oct 2023 22:27:51 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906379100b009b957d5237asm10516169ejc.80.2023.10.11.22.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:27:51 -0700 (PDT)
Date:   Thu, 12 Oct 2023 08:27:49 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Archana <craechal@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging/wlan-ng: remove strcpy() use in favor of strscpy()
Message-ID: <ZSeD1UojAgrsOh16@lab-ubuntu>
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

strncpy() function is actively dangerous to use since it may not
NUL-terminate the destination string, resulting in potential memory
content exposures, unbounded reads, or crashes. strcpy() performs
no bounds checking on the destination buffer. The safe replacement
is strscpy() which is specific to the Linux kernel.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/prism2fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index 5d03b2b9aab4..57a99dd12143 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,
 
 		if (j == -1) {	/* plug the filename */
 			memset(dest, 0, s3plug[i].len);
-			strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
+			strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
 		} else {	/* plug a PDR */
 			memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
 		}

