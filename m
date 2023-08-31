Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264CE78F129
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346485AbjHaQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjHaQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:22:50 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCF193
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:22:34 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31adc3ca07aso545818f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693498953; x=1694103753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5e1f1jwIr39xnfoPu0/5wZ+z+ZWuODpVrtDXgqFCd/Y=;
        b=IrD/JDRB6Mu0Drc3X5EsrSMo33Z3oI3lEx+ZBV1D/gDnGSh+reM6W1H+a8+cUHkR/Z
         SjqUMJSHgg5/IQRKiP/cwNKAs6AIZwoaU9sgEdKumCokSKPGH+SIXMLGSgfNHyFJpIMR
         Kh2teckhsSSHCxj10xOwFOGHEDUc6QqCz0wr9MVP2syLqEZwKzb2pw4Y7eptx3gjQ2gv
         5FdbBnWnzFCQBfDaNdW5HIneSqMTVUx/JBDRYjMDJ/sldHwFGoWS/eYsUGWfSslkbuvp
         mon5ZffkuccaXScMj0CZwOcRKzTJ0k6nmTF0/XbaWIQSl8Zb6f4bboYhQWoOZAjTMQmA
         y8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693498953; x=1694103753;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5e1f1jwIr39xnfoPu0/5wZ+z+ZWuODpVrtDXgqFCd/Y=;
        b=kdL/BoqD0WrccGTYD0W0/GqaMHwEaiJNZbBcBwIAbb5AtoKdIXDSEIA0ZfDRVwlhVT
         /vqhgj1uhqLQftE5i6sY7D8yIsszohB66TnMYnfIWIMiLM8/xFzPohBgnr+asL7tsea2
         qHyZ9NokBTGsgVVX3q/Yc1yoCk4OGgS9DNtKjuo8xK66MXbyij4gZdgsWU3GG8VnfdCm
         coYQ2X191xevnbOejBHqnwMsK15RsxQ+Gs6ToY8HeVEMNU6n9hPpbNRyt87iQsoQZcT/
         NmNXDWsZ6DJmvjQ0iVkNE12BB0tBq3L2mIIzfbdVP1Pn71Z93YUUZRtwy1oCR70hFp2r
         VWbg==
X-Gm-Message-State: AOJu0Yzfxj85MgDccUP6k42R8O3S79ubj7kxTRFYGaESdDr/4VD1UbfM
        GRJ5DGAZZbO/UJq+gqYwJBAYzXk3HltH7A==
X-Google-Smtp-Source: AGHT+IEQ6/d4vxUA+8GYooqvM7bVUjnFltIXaDlryCLf8phmepAtkTSn+zOcKuwc2JiGI5yx+H5W0tXYse/6Rg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:adf:e706:0:b0:31c:6629:a583 with SMTP id
 c6-20020adfe706000000b0031c6629a583mr87287wrm.13.1693498952747; Thu, 31 Aug
 2023 09:22:32 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:22:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831162227.2307863-1-smostafa@google.com>
Subject: [PATCH] Revert "arm64/sysreg: refactor deprecated strncpy"
From:   Mostafa Saleh <smostafa@google.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Cc:     maz@kernel.org, oliver.upton@linux.dev, kristina.martsenko@arm.com,
        broonie@kernel.org, quic_pkondeti@quicinc.com, smostafa@google.com,
        justinstitt@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d232606773a0b09ec7f1ffc25f63abe801d011fd.

Using strscpy is not correct in this context and the commit
assumption is not right "strncpy is deprecated for use on
NUL-terminated destination strings".

strncpy is used here to copy parts of the string(cmdline) separated
by spaces into the buffer and not a NULL terminated string.

This breaks the arm options "kvm-arm.mode=protected, arm64.nobti ..."

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kernel/idreg-override.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index aee12c75b738..2fe2491b692c 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -262,9 +262,9 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 		if (!len)
 			return;
 
-		len = strscpy(buf, cmdline, ARRAY_SIZE(buf));
-		if (len == -E2BIG)
-			len = ARRAY_SIZE(buf) - 1;
+		len = min(len, ARRAY_SIZE(buf) - 1);
+		strncpy(buf, cmdline, len);
+		buf[len] = 0;
 
 		if (strcmp(buf, "--") == 0)
 			return;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

