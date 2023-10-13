Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0797C842E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjJMLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMLPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:15:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EBDC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:15:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d885e97e2so1929317f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697195746; x=1697800546; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Y7uEVqUrEURc3ZtGGE61OjpL8fZ0dLhHQyaODvbtbs=;
        b=FsrgwtX5df95YjjEWeiYIVqMfMZCD8Ob+w7m/Ax2qM+r3tJyNTWoOuNjOGwNkxMnD4
         ed2gd1kTgx5+Un4/gi59zWyEnbqCZKKfKxLJS5ufkBLFQMVwsM4J0EPzuXGzFiXHc/k5
         DQlCXaMptXlW5MT51AIdlPV0dA4ANRiOCPc1l1+NWY1MLJxipJAtkbCr787zI5OtZZ+C
         P4gfL5FRYzkfs2zN9l4bbILsxIMY2GUNKmpUsoqfad7QOydInm/nFSUXr7tIhHbPAR9q
         dHf3KpR9oCBAlBBuVMJq8sxWd6O4yR5g0UsQ9noZ1t8ZDVa1XhMqGKYHD9d5BeKeK0wg
         lF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697195746; x=1697800546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y7uEVqUrEURc3ZtGGE61OjpL8fZ0dLhHQyaODvbtbs=;
        b=JCMJP9AMVK5LyOPOAeF/zi/rytLWL+sHNbrASf/+F3hyQYGqZwngepoIhOSiJL0E0q
         HQhfzUTPzxXaU9rE3oRrjqe+zZvh2KE/YvhI0aNKp+wkAuPwVLKRwM2HDGUvS73uGsKp
         bnQ35PLJn3zYB7FvnhmX9p+2l+kntLf/g2QaypYH2ZpRyX5LMjyobCmWzQEo5d7RW/OH
         V+n4yZYhudwWgWK7YdojYNnDsgWYKOkH5ARgNHqoJaMarbUMOpPXltuD9nhUa2ffhcYu
         mUrEHKA7KjAxjyfzL+C9vGfBYn1UCHdS1r66ub0fmFa08Fb29V3tDcDMcW7ZedaQDoXb
         kTCA==
X-Gm-Message-State: AOJu0Yz1THV2Sot/XrZ2Dy2yirgWANIpzCTDEvrfo2DVHI0jr+zr/V6V
        2x8Ezc9wOlKQJ0IJFe/eArv6uJ8ziEjjdQ==
X-Google-Smtp-Source: AGHT+IH/E2wWroQcSwavcN+ZGUhQhN3/JMVXVSG3V+tPq8XNrcMOgQENxa9lj0uOmFV+ihvRnQRhpA==
X-Received: by 2002:adf:dd82:0:b0:324:84bc:d59e with SMTP id x2-20020adfdd82000000b0032484bcd59emr21494976wrl.22.1697195746279;
        Fri, 13 Oct 2023 04:15:46 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d4749000000b0032d9523de65sm3282882wrs.48.2023.10.13.04.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:15:45 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:15:43 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6] staging: wlan-ng: replace strncpy() with strscpy()
Message-ID: <ZSkm34Sy/n2yxBqi@lab-ubuntu>
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

Patch version v6:
	Remove extra whitespaces on the patch description text

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
                } else {	/* plug a PDR */
                        memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
                }

--
Calvince Otieno

