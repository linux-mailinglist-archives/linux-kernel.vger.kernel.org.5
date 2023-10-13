Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4AC7C82EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJMKVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjJMKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:21:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29313CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:21:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b2cee40de8so388433566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697192484; x=1697797284; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrZvb5Q0DoAOQSgSrWjje0teuv1ya0EsyrCeefTKeuE=;
        b=YIdytFzJacEg0BhK2lSXeiXB+KwDXynZqBKr5hTBFFj75bwj/65xJwXBfGYjGHdfWk
         dWREctCNo15PEScpKMtRJMKkJHJoN9TaLrLApVcwDPWsqiMYYDY81sgYJGMZ2YcKShdS
         lxJFVpdbSJwwRzv2/33/veC7wtWnHsqdejqhH9uLgPp5+1jxpvitIM7nEsXVC+TS5UNl
         k3xY66qOw3/XNeEzXViyBSaLNn6qbooMa1DZNchG+9KTNdV1TVlEqfe4wMtsX6xWQQSm
         rbKrgix/rdyHxuypAcOpdoqFAaK4zqkhx/eb0Ccml+oHueZToRX0v7beQ3Lu9ah9j0Vt
         sfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697192484; x=1697797284;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZvb5Q0DoAOQSgSrWjje0teuv1ya0EsyrCeefTKeuE=;
        b=sBUMu0dQ8qACjTreCoc046jmCSNCYRzpDhaLz47q6QtOQYUnUOdFOSpjyv+dkURS6L
         bWqo9i2vgbRbeBLkZf8PnkHajLboO6wyFymwiwmobg02o/vngZFz9rhSGwlleMkYX5AZ
         Wc7SgakD1BUW4Ms6hIBPY8N0Vj9GQAjYoaIVNum2+JJSkgjV2nApXoUIDde16/vEzaw7
         9wTS9V47t7i6zcYgE9Ddy1737kMfyVgOpfVHaKSfkbnpqU5nVDsJFZhuoCsHZlOmaj5k
         RaK7IZnl9dIfqFTUxg0jNhGjFsToo8bIMFR4yXsmMhc7fmDCXlZ3g/e9UphHEXTW9ZQQ
         kobA==
X-Gm-Message-State: AOJu0YxawTOejLMO6SmAZh6t/vLeAC7/SbAzQVGwKnvMsD4mhzCPEVFJ
        xayD/2Im2xHo0RVCxZKyc1wcQAWVVp5IBF5b
X-Google-Smtp-Source: AGHT+IH40FtbB60bhKPE1bOKZwEEmHU9uHks8tyaJZuLZ75QgWbZP6X/jIa188vG6YI/EoS/CBsFlA==
X-Received: by 2002:a17:907:9306:b0:9bd:a66a:a22 with SMTP id bu6-20020a170907930600b009bda66a0a22mr874520ejc.15.1697192484138;
        Fri, 13 Oct 2023 03:21:24 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm12395302ejb.141.2023.10.13.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:21:23 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:21:21 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: wlan-ng: replace strncpy() with strscpy()
Message-ID: <ZSkaIYGqAg5xJakY@lab-ubuntu>
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
Patch version v5:
	Removed v1 patch details from the revsion history

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



-- 
Calvince Otieno

