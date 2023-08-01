Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0055276BF8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHAVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjHAVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:53:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9F212D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:53:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so6994600276.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690926824; x=1691531624;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0s9Ij9vBA+8Dxn+A8h2tCJt9Mf1v/5GkMWT8RzF9uak=;
        b=c4Rdjt9h37wWUjU3aTzC1zIQA1StqtAUF+DknKtfESVPoN0s2oyoxUv6TVaFQFNJzZ
         rES9RGuIUJoQ5lvOAUwhANYn/0TFahVdDwikuos4m4wZWQw2e6Vo4y9ODAhiCpQbUI76
         muhMT50oXqA6sN/Z9+iEdcaP6zwUBeKCwap/z2xQmFNlMSgMdO/BGM5ChB9Hu28koRNi
         gRHyb1rPRAp1AdFbIoFcXYsZsenVvQDGDxFIGivsHUe/bGC9wKYSaAxgDB6TspJqbYIh
         yMwZ1Da2drE2SR8eAAi6drYZZ/RjOt5AQ1orl+HWBF22YTPwu1L7enFcbBzXTxJ0UzPY
         cHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690926824; x=1691531624;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0s9Ij9vBA+8Dxn+A8h2tCJt9Mf1v/5GkMWT8RzF9uak=;
        b=cw20wCiGyVrSzfhCAEkE5n00yqrp7L1up4iMCPs3W0FG0cjsyXcq5bnA5gPLRTuAyu
         IuAsbJeGQ+y/SYMInk1bfC10juvnQ+452gp1PKEiIcQWmb5EV9AjMIe5UUT+TenhAnmG
         u/3nDdqRx5xWKgFR+N+sVEUbIlLlj/EZgMuAoQkulejBwCBMj2ULRzORnHpa+5s86MJO
         Vufq3ZEKgW4jddMsrpHVRpKLfKOkweIb1grsS31KcDVk0iG1oEFJroCnSMygbTitm8sJ
         Y4610PAikkmMbIIZ70ATFvrB7AwcdcWkkqjZ7gOCMOUuz8m0aKRUkUSARvIXrrX4mps9
         sM1g==
X-Gm-Message-State: ABy/qLYb3ao6cZ+60CU8UdHzmLpP8GNK2ROKcqy8eeDZgB2Vwx0i5qUz
        IL5Z0kDYnMlXxl811B57Vm3wOHuA7EzVK6uHow==
X-Google-Smtp-Source: APBJJlHjR+QqYsFFxi0BqybEHISyS5oTupXYpcQVQD9NnHionwHqGL30J/BHp2LZvr3lgY/z7d6TefUBLOOV5rckWw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:70b:b0:d0f:15a4:5a50 with
 SMTP id k11-20020a056902070b00b00d0f15a45a50mr121648ybt.9.1690926824002; Tue,
 01 Aug 2023 14:53:44 -0700 (PDT)
Date:   Tue, 01 Aug 2023 21:53:36 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN9+yWQC/x3NQQrCQAxG4auUrA1k0kXFq4gLMb8aKGNJSlsov
 XsHl9/mvZ0S4Ui6dTsFFk//1YZy6ej1fdYP2K2ZVLSXqxS28AWRXDHz6oERmex1xsg+rbqJsA2 AmpVBeqUWmgJv3/6T++M4Tpg2XF10AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690926823; l=1991;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=6A+GJOrwYihb5Nlog/fMcMKwBjFRuYI+dUgwDlopuWg=; b=slqeS/TZUMd+Q0Atno0SF7YjZvgtRWbIWVp/GIfLhcim4px+zeKjRfBmJ9hX8B1cs7iyVJ34l
 9c6U5ai2U4FCmzfbthB8H46kf7IoAksUa+S8WnxZKfFlXvy4rlMAQMU
X-Mailer: b4 0.12.3
Message-ID: <20230801-drivers-net-wireless-intel-ipw2x00-v1-1-ffd185c91292@google.com>
Subject: [PATCH] wifi: ipw2x00: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We can massively simplify the implementation by removing the ternary
check for the smaller of `count` and `sizeof(buffer) - 1` as `strscpy`
guarantees NUL-termination of its destination buffer [2]. This also
means we do not need to explicity set the one past-the-last index to
zero as `strscpy` handles this.

Furthermore, we can also utilize `strscpy`'s return value to populate
`len` and simply pass in `sizeof(buffer)` to the `strscpy` invocation
itself.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index dfe0f74369e6..8f2a834dbe04 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -1462,15 +1462,12 @@ static ssize_t scan_age_store(struct device *d, struct device_attribute *attr,
 	struct ipw_priv *priv = dev_get_drvdata(d);
 	struct net_device *dev = priv->net_dev;
 	char buffer[] = "00000000";
-	unsigned long len =
-	    (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
 	unsigned long val;
 	char *p = buffer;
 
 	IPW_DEBUG_INFO("enter\n");
 
-	strncpy(buffer, buf, len);
-	buffer[len] = 0;
+	ssize_t len = strscpy(buffer, buf, sizeof(buffer));
 
 	if (p[1] == 'x' || p[1] == 'X' || p[0] == 'x' || p[0] == 'X') {
 		p++;

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230801-drivers-net-wireless-intel-ipw2x00-d7ee2dd17032

Best regards,
--
Justin Stitt <justinstitt@google.com>

