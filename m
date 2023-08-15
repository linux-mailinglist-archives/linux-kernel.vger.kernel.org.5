Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60F777D4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbjHOUuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbjHOUui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:50:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF91FF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:50:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d63e5f828a0so6630237276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692132614; x=1692737414;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ci189aHPBFBjtm/RN/hzTJMe0+KKoH+4CClRyv2s6dg=;
        b=SAeIcykjeO3O4waBr9JKtx/sxluuhH/9cEcIo8KaE0eyK1VF08SzRAJKh6p+FmA1JM
         69OTv8TvYkczMG0mhmrq9GTsueFg0IlEsypYeECDD2vH2l6576G5pEuCEzFlDoCMLvWT
         fn362CQrZE/tm0v5rMp0CN01qzTPzCv6QJCv7l/IHGeLYxWRcXVES5g5p9/31INLZcoa
         Rvnz18b/2PQNIiKNRAYs2uT62njO7WMkocibzanwhe1+v4vEpbghNK/2MHile54eDFs5
         uM8NETVzrBbLkfr44/H893S5AScQPRBPXeWc34kmCmUx4lVV+Kfwz5e0JGWHAb4m+tw5
         X+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132614; x=1692737414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ci189aHPBFBjtm/RN/hzTJMe0+KKoH+4CClRyv2s6dg=;
        b=i+8L3Vj0E7nmXOhBgZm3XC7VgULD0MMFAB4FhtK3qVpOg9o4k0DQIG13qpOPPLc9Bi
         cmIryEOLnsAULbJFodSqoxFMU8lvYJGqG0NNaXPwbdxL1Xn1K1YkuVYGEarT4sKtC35U
         s3xYyCUx5u0wGbI9bSgCHyUVCKgZzPp68Qi9hSZqS4EbZhq7olYl5QwhUFTTlR+647vq
         HvaBq0pUZ4kZuRjxAX92px8XEXtmKiVO/eTfxPvB4YAfg4OcaW80BurAJomtq9vlKagK
         d3fCl3I6rimHnfKnQunUuTQw1obdhG1lK5z3sG2fd8+lHbTrBidmLTZLgLT409gdf9Kb
         XAOg==
X-Gm-Message-State: AOJu0YzFSOYCPgT+N4A9Qk5ky02T3e+92j9hu/s71+Gq6gC0iWCO/G78
        ARvSTUUpIYqC36tLP72opiiA+JxRyREiPAPmzA==
X-Google-Smtp-Source: AGHT+IE0S8U2GnJZpujIzqMD7YILSF8i9bPnwtVZEQv8bw7cAjHxPN+IBbiHTBhY+Q8tDhl8X7qu4g/1kHaZi/Xotw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3482:0:b0:d51:577e:425d with SMTP
 id b124-20020a253482000000b00d51577e425dmr172964yba.12.1692132614147; Tue, 15
 Aug 2023 13:50:14 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:50:13 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAATl22QC/x2NwQqDMBBEf0X23IXEaBV/pfRgm1H3EmUjQRD/v
 WthDvMOb+akDBVkGqqTFEWyrMnAPyr6LmOawRKNqXZ1cL1vuawSOaoUaOaEnbEv0LsksRxmhO7 TPNs++HFyZEObYpLjf/J6X9cPHh5EAXQAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692132613; l=1704;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=koKe9TiNY9BHLtNN6bXZhZ0oxr/kaYIOgBRphxRQ9R4=; b=4zK7hYBEqziHv0W5/Pz/2k3HinI9eYV7eo3A7IjcFaIx8ueNhiyyhTdLIyTZ827+goMPHHYVm
 LXiqIzRSRwND2YO1dk2khOrUhZ9LI5EX+oXcD11QKowi4+yD62y5ymC
X-Mailer: b4 0.12.3
Message-ID: <20230815-void-drivers-net-ethernet-ni-nixge-v1-1-f096a6e43038@google.com>
Subject: [PATCH] net: nixge: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang 18 I see the following warning:
|       drivers/net/ethernet/ni/nixge.c:1273:12: warning: cast to smaller integer
|               type 'enum nixge_version' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|        1273 |         version = (enum nixge_version)of_id->data;

This is due to the fact that `of_id->data` is a void* while `enum nixge_version`
has the size of an int. This leads to truncation and possible data loss.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: There is likely no data loss occurring here since `enum nixge_version`
has only a few fields which aren't nearly large enough to cause data
loss. However, this patch still works towards the goal of enabling this
warning for more builds by reducing noise.
---
 drivers/net/ethernet/ni/nixge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 0fd156286d4d..105977804e6a 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1270,7 +1270,7 @@ static int nixge_of_get_resources(struct platform_device *pdev)
 	if (!of_id)
 		return -ENODEV;
 
-	version = (enum nixge_version)of_id->data;
+	version = (uintptr_t)of_id->data;
 	if (version <= NIXGE_V2)
 		priv->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	else

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230815-void-drivers-net-ethernet-ni-nixge-37b465831af0

Best regards,
--
Justin Stitt <justinstitt@google.com>

