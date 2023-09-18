Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654187A4075
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbjIRFas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbjIRFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:30:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B2120
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:30:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c0eb18f09so29710127b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695015024; x=1695619824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OE+ciIbOkP2gbp6T+0Gt73rrnC9CJepjybcVkk4F57E=;
        b=SpN7mw8PtIDl103YYs8oSKP3kAl88Fc6exiO7BLsAsY/lhqk/GzBINKq3ANjhiMO/O
         P6WDoBy8Zl+cszPWDH+eT1x6nTTE/RipX/tpznLD96JRM8QGkIMwaZY4rdciVjbXcUlM
         2pRyDnoajiz/+jRmtAFGGUVb+3ke/gB9CMj6VeXUzsP+KNWTjksGGXOCdSRyYPW4WaCd
         dYaOOQzTzUnqLC1J1zM0T6H0CqG5QlusY9ltFR8Gn/Coj8WT+1934GBJMaaYg154SklK
         c4T2Y7tPkd93qIGN+1QvPNqi+tjV7PUTVJZLON9HYnNTLc7Bt1b3Z4cPaU5Yui1G5A8T
         fB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695015024; x=1695619824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OE+ciIbOkP2gbp6T+0Gt73rrnC9CJepjybcVkk4F57E=;
        b=HtboiIMVGbrFOVrmD84/gcsn+JDLsRcND50e8nXUdlfF4P6jyc0LJWu8W2a44K0J1u
         DkLeRO/N57j39uAYcvrWIJ3KAiZQRsFN3e24w0R5h09fDf4QpSKQRnl6RusGdxFZGPmP
         NXg1PxxD4V1NqsJIWTU7R+kcgnmAk+VCDqPqT5Bds7DhJ9aokEcteA3HU/lawXlCc3uU
         Kcqjt+CGmpobcYhN6qMzHUrxfQy42wxXzQPrilBDp5YDLWRx8vtxF9hPY7rGt8u/nGM4
         xHqBVvGOA55/OAL4FQl1xHYnuVUyz06uBrBz/0LquSQ3jQEQUQN1LB6N6opTJFzku+cv
         P1Dg==
X-Gm-Message-State: AOJu0Yy7zNCW/1Ge2+ctjWq2Me/y0PNmwsWFAaNIHMs9XivryhY+ckhz
        3hkZj1DdPKoC3vvdhLpAdIL8BzmSdxdpAN/tVA==
X-Google-Smtp-Source: AGHT+IFJNgXq1W9sUxEvFZxM8KaPscNzVC69QUb0G5ux6YHJXL5EoxRGPEba+eN4+1WufJgCtzYHzwVgUY9hITAoJA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b61c:0:b0:59b:edd3:fdab with SMTP
 id u28-20020a81b61c000000b0059bedd3fdabmr201776ywh.4.1695015023902; Sun, 17
 Sep 2023 22:30:23 -0700 (PDT)
Date:   Mon, 18 Sep 2023 05:30:15 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGbgB2UC/6WOQQ6CMBBFr2K6dkxbiIor72FYlDLACNKmUxsJ4
 e5WruDyvcV/fxWMgZDF7bCKgImY3JxBHw/CDmbuEajNLLTUhbzqEjiG2foF2kAJA4OxFpmpoYn
 iAuzRjG8Po2ueaCODhVLKCi9tJ6viLPKsD9jRZ08+6swDcXRh2R8k9bN/xJICBYVR2CmtFVby3 jvXT3iy7iXqbdu+gL2JHfEAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695015023; l=2339;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ZRAevJITjeQ3gig5kuCzdgxw+0nnBqh8Vks2uPOz8VQ=; b=BYbtuoA82mn5rA+ynVQEmlpFtq1oD0knVDz6B12KBhox6dKe5/z1nyregyISK/hk/tpEvtR5/
 eF7t0vp8tMSD54eybkINr+clScIJ2CZP32kGrPV8WDKn1C3F2hocgYS
X-Mailer: b4 0.12.3
Message-ID: <20230918-strncpy-drivers-accessibility-speakup-kobjects-c-v2-1-d5b1976c5dbf@google.com>
Subject: [PATCH v2] accessibility: speakup: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Let's refactor this function to just use synth_write().

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
Changes from v1 -> v2:
- refactor synth_direct_store (thanks Kees)
- rebase onto 3669558bdf354cd352be955ef2764cde6a9bf5ec
- Link to v1: https://lore.kernel.org/all/20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com/
---
 drivers/accessibility/speakup/kobjects.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index a7522d409802..0dfdb6608e02 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -413,27 +413,24 @@ static ssize_t synth_direct_store(struct kobject *kobj,
 				  struct kobj_attribute *attr,
 				  const char *buf, size_t count)
 {
-	u_char tmp[256];
-	int len;
-	int bytes;
-	const char *ptr = buf;
+	char *unescaped;
 	unsigned long flags;
 
 	if (!synth)
 		return -EPERM;
 
-	len = strlen(buf);
+	unescaped = kstrdup(buf, GFP_KERNEL);
+	if (!unescaped)
+		return -ENOMEM;
+
+	string_unescape_any_inplace(unescaped);
+
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
-	while (len > 0) {
-		bytes = min_t(size_t, len, 250);
-		strncpy(tmp, ptr, bytes);
-		tmp[bytes] = '\0';
-		string_unescape_any_inplace(tmp);
-		synth_printf("%s", tmp);
-		ptr += bytes;
-		len -= bytes;
-	}
+	synth_write(unescaped, strlen(unescaped));
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+
+	kfree(unescaped);
+
 	return count;
 }
 

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230824-strncpy-drivers-accessibility-speakup-kobjects-c-4009e7df0936

Best regards,
--
Justin Stitt <justinstitt@google.com>

