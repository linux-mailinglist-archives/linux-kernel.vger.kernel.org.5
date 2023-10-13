Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB07C828D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjJMJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJMJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:54:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945C95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:54:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5056059e0so8661561fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697190869; x=1697795669; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R4NoCUDvuhISs5zePSgTjBOD4p4v9fCoCqCDFPnEEaM=;
        b=Rhz0IU0L2XHIjU6aNNUMX/yUxHX6xTD63CWHdzvY5GEgLfPfveeoQk0mapfDnDo/4n
         dptyINKR/DfBfwTjl/CaWLFn6coogMfgJ3AluD5C4crzFIqB5dxLXMz/65L6qVrhtDgX
         f9V7qNhV9lNRD4sAMDyLJ+XpuDK5mBG/3PBNFlC7sc9oq2QlkUuVTs96t/6A1LUJLo0c
         RGj2Vd9eeKhNoCjmdfHHEUpRJZM1/7oBc///E0wwardj9iqq+abazBdMNXm8dZsJeqrQ
         myEQHyIoEnyniZ/uZbdVVCbW7m9CR3y0J3P3EjeHU8dmP6/uQnLcooTHdywz5fIbWyXi
         /ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190869; x=1697795669;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4NoCUDvuhISs5zePSgTjBOD4p4v9fCoCqCDFPnEEaM=;
        b=bjVwEtRx8ka8hvD4h6NuzPtCMQbATmocUhVHg+Ki3Ohd57KZuZRLhtemLD3SdDpPWO
         TTAVarAZZSNDFCYgS3RqymIaww9E6CL4hvv5s1gpsQudh2+YSJi/g1vAP8XWs30gL3bC
         3i7uHB+BfHS42wJdfC8csA9Hb6KFTIcS8aIAKcxFL8RbsijLF1k1ZXheGn9TifhJfqkW
         gtEgVDuCWrHhHRKmgDCAYmh7fF4/Z9mihKMk/zNlNbCpx7V165itNNVNk4qzG+WsE5Ex
         ouslWAYpIU3VK4KY8vrTISSFG7hEjbOyHX1T/F2oT+yquwMZCAd98nX8uPCXEYxvtgp+
         fBFA==
X-Gm-Message-State: AOJu0Yx3Tlcg53LBrJiBXdTQCPmAaYGhOyyK1xFo0BYMwbVRq7D4qS/3
        bLMoieUgsVVcutReqmuLI3BEtEX+YetqXChS
X-Google-Smtp-Source: AGHT+IFOp0mYWBcby+0X1+1TnDZ3eh8Vgokk7MzTSK966IoDpUt2Y+x3Pc3p+wADEw2n1N6PjEjzlA==
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id t13-20020a19910d000000b00501ba04f34bmr19743563lfd.44.1697190869138;
        Fri, 13 Oct 2023 02:54:29 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402101a00b00533e915923asm11199706edu.49.2023.10.13.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:54:28 -0700 (PDT)
Date:   Fri, 13 Oct 2023 12:54:26 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: wlan-ng: replace  strncpy() with strscpy()
Message-ID: <ZSkT0pFu0VClVc1V@lab-ubuntu>
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

Checkpatch suggests the use of  strscpy() instead of strncpy().
The advantages are that it always adds a NUL terminator and it prevents
a read overflow if the src string is not properly terminated.  One
potential disadvantage is that it doesn't zero pad the string like
strncpy() does.

In this code, strscpy() and strncpy() are equivalent and it does not
affect runtime behavior.  The string is zeroed on the line before
using memset().  The resulting string was always NUL terminated and
PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
terminated.

However, even though using strscpy() does not fix any bugs, it's
still nicer and makes checkpatch happy.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
Patch version v4:
	Provide a valid description of the patch

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

