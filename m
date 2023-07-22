Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB90B75DEC0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGVV6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjGVV6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:58:04 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE3171F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:00 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-785d738d3feso77617739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063080; x=1690667880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NwbewUwtQOX42wr9LwdKvivKXFOaLGQh9L6giyMZRg=;
        b=HEp/1maRsFLWMNQhtS2UwRdOszuhv+sqOFeVsCUn7Ofs9yGRMzSw6v8kdd447LsBed
         ZgEk1WR7oKw0l2Rmbf0bWGusM3JQFMsOgXnJG8dWKCHjBa378DdBf2DXhxXBvZwb1mcT
         Q6EmAnwywYZhJ7kJp/jdDlpz9Dl25l+pPx9TqJAkcR1I73kLduUmlVYI6HsppG5HZ23o
         98xXPrFjsE1N+gGSAtYfsmla/1cykphCieTiXHP7rMTeZxQADaxMJZ/JU1h7/w9SvFUe
         DdYBu3fV6RGYWwvWiq+B02N9YBHfNE7hZN7BS9dHxo/fm+MnJVoLLJPbbVxNkvdZ3G9d
         yGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063080; x=1690667880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NwbewUwtQOX42wr9LwdKvivKXFOaLGQh9L6giyMZRg=;
        b=Fi93laTKslj+30kqq3kea9FR6M/9Kez8lO+zBt8IwJ6oQAX/Q3XIsHecMtoHAMcdQn
         4WEJei/hcK0b5/MGe7fTz/ILMW63udZeNOzBlQ4dnY3i8qalWCgp8jzPBWOtvqjBuFk+
         SYMkz82j9k76tGGYsN8oPxccOAHR64gC7bOhJ7wvWvHtmM+xGRpBWThE7LSt5PP1Rrv1
         kz7qMyCvPs1jlyCpKZSl+50Qnf8lHxqTwCfVmp0rAZ9Get039n14xTrFKn443SFkDxpA
         sDd84cPuL++sYUUjeUNpB57b+Bl2ULh92Cz/jELIMjcQDRa+uoSFACnbLaYxZeV/VA5+
         iDFA==
X-Gm-Message-State: ABy/qLZW7sZpr4gBe0+Xplj236/QaeNQnjggnt3EzToDusuX9fSBRat5
        JG7y6Z3JHIpiQdpoTlp5eZo=
X-Google-Smtp-Source: APBJJlFjqqOWMP2pfQkY9d8/m0nxsrzn9e9tCzjf9GN1nqn6HNu0IYM3J3IRyzRBdreEsnet4wRqPA==
X-Received: by 2002:a05:6602:3404:b0:783:6aa0:9816 with SMTP id n4-20020a056602340400b007836aa09816mr2716255ioz.7.1690063079959;
        Sat, 22 Jul 2023 14:57:59 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id j17-20020a02a691000000b0042b4b1246cbsm1921783jam.148.2023.07.22.14.57.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:57:59 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 2/9] staging: rtl8723bs: ioctl_linux: Fix code indent
Date:   Sat, 22 Jul 2023 23:57:57 +0200
Message-Id: <20230722215757.4214-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
References: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch issue:
- WARNING: suspect code indent for conditional statements

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index b8595b28bceb..20c296d88c8d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -640,7 +640,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
-- 
2.39.2 (Apple Git-143)

