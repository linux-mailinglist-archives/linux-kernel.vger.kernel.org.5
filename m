Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4484B81132B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378888AbjLMNnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjLMNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:43:13 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1D9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:43:19 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F5A63F285
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702474997;
        bh=i0Esn9+nyWOVkq+Y2H+yWu8DGPZPCcolJEjwYdbl1Tg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s3Wgs4aMkj0jKO4Lrlsy09wGAr77iAf1TN984PgjKAB8kdUfYSAf+EUiO0Mzxcryu
         jd5Ri/IMGOOYwOUcq1As3K/GgZgz+l1LYxUsPo3zgNGt6hDp6mgYSgU9iWeZx4oqe6
         y1y5FIAdYgQFXjCKna3JJsqhNRYcmdHS7YZSBV6RtnNzC49W/zjonQ89/10jO+byO1
         Dq2eSTjKSUhJV9WjOQ9muEUxAoHXexmPPb3pd+1J9YNz6xuUwRDWsISyUqroaqN6xK
         A4tSmh12mQ+xLr3ESSELF52v0BPrGWj+y5m5CryP285GA97KhJQkKhxkL24e/8zBpc
         ijL6Us2dnWDtw==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c2c568108so45062155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474997; x=1703079797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0Esn9+nyWOVkq+Y2H+yWu8DGPZPCcolJEjwYdbl1Tg=;
        b=aVEBFeND236MtR8MbpnytR0jDJ0KgCTHLXSMjEDDmhti4QBVos3lk82iyRy6+LXh1f
         voj2kLzO3n1jXH0kKWxuGl7dHxRioBSxppYiMwcvQcFeqNpcZr8pLyAGx/wtoB74fqy4
         mixkjEFkUGfGWS5F2Qa7xJ3x1MilAnHaIstUBoCZc2RfnFbQKEX0sIstY0vzZor/wt0N
         Z16q6Ntjwf29YLVP69ClRkNxqwhLSAR3nG3qJM/IGNbypSMkLracnNWf+NMiil+2IIGt
         ffYMuGQKy0Vsn46XXU/dapH5XKNuW0BuyHUAMA/ZG0v20WMH10Y4u88gPiMIJxfSctzy
         HKWQ==
X-Gm-Message-State: AOJu0YwQ3Gk/haNkydIr+NYOp6tj2fmaQy4CIIuRLIcLy2uOr7JqYkhu
        sHBpMoDzKP5I5BlW5d6GlH3UDHFn3hIIaBXASJGxIkZsi9XmlGe3/VkMUPJxAyAYl+n/NAc95kn
        A/YcyCSm0oEVqCVqh+znmX8vehKeVTAl0NBcvavWWQQ==
X-Received: by 2002:a05:600c:2a8d:b0:40c:3308:3afd with SMTP id x13-20020a05600c2a8d00b0040c33083afdmr3802894wmd.12.1702474997275;
        Wed, 13 Dec 2023 05:43:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/9TM/Hq+FVkFAXTJAPA99V+ZtvOOyFOyCc9tFhEykcjTyjindnV7n4NDXtHqSMkMwzrjYPg==
X-Received: by 2002:a05:600c:2a8d:b0:40c:3308:3afd with SMTP id x13-20020a05600c2a8d00b0040c33083afdmr3802888wmd.12.1702474997036;
        Wed, 13 Dec 2023 05:43:17 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id jb4-20020a05600c54e400b0040c5cf930e6sm1982346wmb.19.2023.12.13.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:43:16 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] objtool: make objtool SLS validation fatal when building with CONFIG_SLS=y
Date:   Wed, 13 Dec 2023 13:43:01 +0000
Message-Id: <20231213134303.2302285-3-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make objtool SLS validation fatal when building with CONFIG_SLS=y,
currently it is a build.log warning only.

This is a standalone patch, such that if regressions are identified
(with any config or toolchain configuration) it can be reverted until
relevant identified code is fixed up or otherwise
ignored/silecned/marked as safe.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 tools/objtool/check.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 15df4afae2..9709f037f1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4500,7 +4500,9 @@ static int validate_sls(struct objtool_file *file)
 		}
 	}
 
-	return warnings;
+	/* SLS is an optional security safety feature, make it fatal
+	 * to ensure no new code is introduced that fails SLS */
+	return -warnings;
 }
 
 static bool ignore_noreturn_call(struct instruction *insn)
-- 
2.34.1

