Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6B7D8C24
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbjJZXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344896AbjJZXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:19:22 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B974D1A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:19:19 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-581debabf87so2346749eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698362359; x=1698967159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJUIaaq/oswhFA94o3ND9d9+Iexffy2MpltZ9TbSQQY=;
        b=BC6d5eOUbpZj2EhbDkCtoVPkarvXcccoL04DzKW8pl/jhqx1Q520C4Urca1Sko4OKp
         bavNq0XNv/2izUivQLIGWWR6M3faFCIa7rZ9ZBRM8mi8+aEFeTs5eNZzFR9nCX3wdkjF
         uThlr63OwueeAPgi/UTizMQ3P2jeEdcjoCj1Xo3+na26rAwqxQGfEgC9UtLPv3sarxqq
         v8LoUR9ZKTSAtLv0dBohaGBlqWXihME/P2Y9Mfis07mDh3MfCe8OfXfq2Zk1bk9hrAvQ
         sYWc9AEJeXa16H3UgQvsmPj+ARr2tgzjj9sTZ1AB+P6NQPJxhUWYKAFxA+HRDppn/Px8
         KzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362359; x=1698967159;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJUIaaq/oswhFA94o3ND9d9+Iexffy2MpltZ9TbSQQY=;
        b=HEI55EVpL0SpUGxo1sVcaQOvkCUmrLJHxVrcJIwrrLhP9e4SMAgTD/5lWzhv0aVQrP
         Y1co4lztFGRYSah9zNoIxCzvKWYsafu/sFpna8LflLE49t9mGKJv/V9SMUXwsR7/8eMX
         Gx++0eDc/CdiYwDEQKVoKJ03decS5pVa55kDtnc2m++eiHD2sBlaq+G5ZiutDDGL0Cry
         VVd95BQ4yZg9teEAenbBAEljOfi2z3j8byHjqswyVoY8WDsayruw64c7dbMmTglIlbtW
         vHGe619eZRasM+QjScLXkmsUrC6PBFEw0JyVThJL61p4YXWtVD0IFn932OJOD+JJIZp1
         6rCQ==
X-Gm-Message-State: AOJu0YwpG5kX28/+ZvaYxsSymvVDT8Tyh+kIe18u4J4qg5jxFP+rx13l
        2LnqS8ViZNtru9c6xCFAjl0ehiggO7DCt2kuiQ==
X-Google-Smtp-Source: AGHT+IEn/SLjvxaFs50tSZC9lk6X5MyTWbZRithyR/6U6p23lScjjTmjpQ6xvz1RXCrqGehDHbWGiifwhVwJ4bGNuw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:e658:0:b0:581:dbb1:219b with SMTP
 id q24-20020a4ae658000000b00581dbb1219bmr404827oot.0.1698362359119; Thu, 26
 Oct 2023 16:19:19 -0700 (PDT)
Date:   Thu, 26 Oct 2023 23:19:18 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPXzOmUC/53NQQ6CMBCF4auQrh3TUpHoinsYFtCOMAm2ZIZUC
 eHuVo7g8n+L921KkAlF3YtNMSYSiiFHeSqUG7swIJDPrUpdWqNNDbJwcPMKnikhCwRc4E2ME4q
 AI3EROuIIDry+Oa8rrbsrqvw3Mz7pc1iPNvdIskReDzqZ3/qPkgwYQHvxVW/7Gm3dDDEOE55df Kl23/cvKrGXxOMAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698362358; l=2719;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tC58vKAxLJm5cAdnZ9rYPmKDTa3guBZo7Oh8cfH/AXg=; b=xW/7pk2zSIdbdaANtOGtksyMjVeqD8M30IczBSFi365yP9f/D8GLqCR5vqlPF/2OcBvYQdmMr
 CAYKpl7GFTvD4/4vGd7LbAxPSijXKO8qWqRTUeMAOjbIl15/K3OHB/C
X-Mailer: b4 0.12.3
Message-ID: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
Subject: [PATCH v2] airo: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`extra` is clearly supposed to be NUL-terminated which is evident by the
manual NUL-byte assignment as well as its immediate usage with strlen().

Moreover, let's NUL-pad since there is deliberate effort (48 instances)
made elsewhere to zero-out buffers in these getters and setters:
6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
6130 | memset(local->config.rates, 0, 8);
6139 | memset(local->config.rates, 0, 8);
6414 | memset(key.key, 0, MAX_KEY_SIZE);
6497 | memset(extra, 0, 16);
(to be clear, strncpy also NUL-padded -- we are matching that behavior)

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

We can also replace the hard-coded size of "16" to IW_ESSID_MAX_SIZE
because this function is a wext handler.

In wext-core.c we have:
static const struct iw_ioctl_description standard_ioctl[] = {
...
        [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
                .header_type    = IW_HEADER_TYPE_POINT,
                .token_size     = 1,
                .max_tokens     = IW_ESSID_MAX_SIZE,
        },

So the buffer size is (strangely) IW_ESSID_MAX_SIZE

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use IW_ESSID_MAX_SIZE (thanks Jeff, Kees)
- Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-cisco-airo-c-v1-1-e34d5b3b7e37@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/cisco/airo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index dbd13f7aa3e6..6a099642e854 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6067,8 +6067,7 @@ static int airo_get_nick(struct net_device *dev,
 	struct airo_info *local = dev->ml_priv;
 
 	readConfigRid(local, 1);
-	strncpy(extra, local->config.nodeName, 16);
-	extra[16] = '\0';
+	strscpy_pad(extra, local->config.nodeName, IW_ESSID_MAX_SIZE);
 	dwrq->length = strlen(extra);
 
 	return 0;

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-cisco-airo-c-d09cd0500a6e

Best regards,
--
Justin Stitt <justinstitt@google.com>

