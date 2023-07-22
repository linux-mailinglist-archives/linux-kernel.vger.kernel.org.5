Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9B75DEBF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjGVV5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGVV5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:57:48 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F51737
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:57:47 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-348c62db335so3080975ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063067; x=1690667867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiYt7Tw0QK7f0nlz4SKEHhaEGnGqAWTc0j4eEPb3kRI=;
        b=ZJmJmCWE6gO0q9V9V7FLGpi9A4sxOAgfALRUjFO1sPEb0pIScMYl62jlC6Pn9DLgCW
         lh8vILEeXCl1UJGK+2mB/w/LPHM9XBX979nhfs3fTb02+J69Gu+SDKdFSnt24EJ5eE3G
         XhUlBC6wvB7Kd8NeiBh5szHXZgPJMko0q1bt+84LLMMLcZuh33lg9bqJWhLHAkE/aVT1
         T9G+LJcn6Ey3U8dDNr6jcNjklx73XESyrjmfRSFNjOBkU8oj/wtq+17sxR8gyoIPSAD5
         vNYvuxEZh/5PIJqoUViaPdihnIEYn+Df+rz4QuubdqxvFKYgjNzk36UXP+4nz834jw0F
         Gtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063067; x=1690667867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiYt7Tw0QK7f0nlz4SKEHhaEGnGqAWTc0j4eEPb3kRI=;
        b=kQa7fqFF3wCNzdgu3amSOQiOCCpN1BQAv/Q1sEV9TeVY9+/vBi/ayYMvkBlbCkqvRK
         R20O94y4oKvjpxQ5U6OkTx3+xZmUvgrDOwwNvlm+k5kXnCmLrCPoxUwUL0jfZKniOB56
         q6hQRejCS7mODUX7TtAPXzM/3mxgugQINI8Pk6BGvlQRu3U1nL+/6gDMRntRQLZmmUw5
         kmdlcLWOa8AdTUEsVI3SQI388KpvzIDAG/xUmIUChRjJYo7YB/l10qoFb+9qd7ab1jpq
         QZ2MzW13ugufG+1Ya0PFjrjucs/agyG3OIN0nyi1uZmJQkDbqhCWIlSfCZytHJGCEM3v
         yolA==
X-Gm-Message-State: ABy/qLZZ5KU61b7w9q/ql8EkrGBUhzzBBr/MMr4Lg+v06pFJpP1P/yIk
        D/OVAd5NCOqiRPFM3V4RRCc=
X-Google-Smtp-Source: APBJJlHn9jzE35Il7Hl7iVud49hHzAOTyod5n63H74V9XLwnE7acIsYFtMK2mdecTsPOx2PVVYZ71w==
X-Received: by 2002:a92:d943:0:b0:348:8050:d7a with SMTP id l3-20020a92d943000000b0034880500d7amr3536447ilq.30.1690063066913;
        Sat, 22 Jul 2023 14:57:46 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id dp21-20020a0566381c9500b0042b1061c6a8sm1966166jab.84.2023.07.22.14.57.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:57:46 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 1/9] staging: rtl8723bs: ioctl_linux: Fix else on next line
Date:   Sat, 22 Jul 2023 23:57:36 +0200
Message-Id: <20230722215736.4183-1-franziska.naepelt@googlemail.com>
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
- ERROR: else should follow close brace '}'

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 40a3157fb735..b8595b28bceb 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -654,8 +654,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				psecuritypriv->busetkipkey = true;
 
-			}
-			else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
+			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
 				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-- 
2.39.2 (Apple Git-143)

