Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE977CD046
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbjJQXMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQXMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:12:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02657F5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:12:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a824ef7a83so69737467b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697584369; x=1698189169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qJPL6XQWTu91QMPy+qd0o+1YjlCp6zhTXPWOlC7y3Hk=;
        b=PXOEaHY92YXHkMvzlTiFsTgUrOrNK3mMmB/H3/fsEf7rHaom1eDW7UzhtVDL0S4zqH
         ISj5Wv+0YlDZjlAc8mkGnUV3b6al6FRGdEkP9YmnJUVrJR0PbEIBNXGZ8SRzqXYI2Mp+
         zasQZeaCF6qv0JL0iHra5uPblmqUpCnJrRymWByIIRj17mQFHmVP201UMeeJ/YWKNbYS
         Y9swA1ZnlthbydwA7Jlg6scn0eTFGRjFnZ4UyLR9nUnhP5U+VVMoejHKTGm8KGYEcCth
         p0DJGpiTYUcdA+/D4/HY6t5gPIstjY0//oxkxW89gf3mtvXAZ4P15XUMK9L6fU/eUgRo
         v81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697584369; x=1698189169;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJPL6XQWTu91QMPy+qd0o+1YjlCp6zhTXPWOlC7y3Hk=;
        b=jwOgoaIpvtsiFpvDwokEChNwfjWnXEOe6HpXPxV7in8dwxnl5FnRn+eVDU2LrtictZ
         CAqP9Ui+0FAcDlq0Yoi+JVXTQcBLFAvD9gKx81IxukK2Jx7koZZjuzNgqPzTNHyLtMfx
         ckNXv5RV8+e930M6DOb0oWHKBQhKM1CmcBrdI+lNpsFfZMFDCGZdRIKLPil71d0wfbWo
         Rtzd05GXe/HsUYr//c74VuA4frV9SNRexSZDSJMCA3ZJF2Xq0twK1ibWYPtV9jGAqdI0
         YZXMfNUOxmr1ikHjuhBxj1Mc03WGNCPPs4BoRf0csMIHhnUdNa6cYLgU2tBixeH62219
         LmgQ==
X-Gm-Message-State: AOJu0YyMgWP4CoVQSJ74twRIou0fP7P6/9L+Eabme01Lw/gRnjY6CWmR
        2scfpmdyLwlDpaK3WpgMqtaWL2pg0x8vHNivgg==
X-Google-Smtp-Source: AGHT+IF1RAxru2SV0JiTclifKFGV06p9lUAVjlXNjuX16xCj2mB+4VrqyxgTeao1uihdEdu2eAtySY8gBxdPfI0QMg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b09:0:b0:d9a:6855:6d31 with SMTP
 id 9-20020a250b09000000b00d9a68556d31mr73485ybl.3.1697584369270; Tue, 17 Oct
 2023 16:12:49 -0700 (PDT)
Date:   Tue, 17 Oct 2023 23:12:48 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO8UL2UC/x3NTQqDMBBA4avIrDvgxKjQq5Qu0mTaDkiUmeAP4
 t0buvw2751grMIG9+YE5VVM5lxBtwbiN+QPo6RqcK3rqKURrWiOy4FJZWU1zFxwE+WJzbAIbhO 5njDEHSP6kV9xCMn7roeaXJTfsv93j+d1/QBnMkHwfgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697584368; l=2538;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=5D83orUb3gyhDUlDeVDVW1PaTTVcafALjffwJNnrV0I=; b=Zoa1dQfYP30omS9KZsLyHDYiXZj1atVVZDTjnUxa+sFDfk1rhxQUTD2gr/YxwotX/S6ojeeIz
 0NdGav3EIN5AGD+/Ha1lrhBT/HzBatDdLilGTbXA40x8NeuySGmwCYK
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-ti-wl1251-acx-c-v1-1-a99584e82f65@google.com>
Subject: [PATCH] wl1251: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

There was a lot of effort done here to ensure buf is NUL-terminated. We
now have access to better string apis -- `buf` should be NUL-terminated
and doesn't seem to require NUL-padding as its only use is with format
strings in wl1251/main.c
403 | wl1251_info("firmware booted (%s)", wl->fw_ver);

Therefore, a suitable replacement is `strscpy` [2] due to the fact that
it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Do note that there is only one caller of wl1251_acx_fw_version() in
drivers/net/wireless/ti/wl1251/boot.c:
264 | wl1251_acx_fw_version(wl, wl->fw_ver, sizeof(wl->fw_ver));
... which passes wl->fw_ver and sizeof(wl->fw_ver) wherein fw_ver is
defined as having size 21 in wl1251.h:
383 | char fw_ver[21];
... and since fw_version has a size of 20 in acx.h:
66 | char fw_version[20];
... there is no overflow or truncation because sizeof(dest) > sizeof(src).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wl1251/acx.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/acx.c b/drivers/net/wireless/ti/wl1251/acx.c
index f78fc3880423..ed5733e0dd5e 100644
--- a/drivers/net/wireless/ti/wl1251/acx.c
+++ b/drivers/net/wireless/ti/wl1251/acx.c
@@ -149,15 +149,7 @@ int wl1251_acx_fw_version(struct wl1251 *wl, char *buf, size_t len)
 		goto out;
 	}
 
-	/* be careful with the buffer sizes */
-	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
-
-	/*
-	 * if the firmware version string is exactly
-	 * sizeof(rev->fw_version) long or fw_len is less than
-	 * sizeof(rev->fw_version) it won't be null terminated
-	 */
-	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
+	strscpy(buf, rev->fw_version, len);
 
 out:
 	kfree(rev);

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-ti-wl1251-acx-c-47ebc6ad4435

Best regards,
--
Justin Stitt <justinstitt@google.com>

