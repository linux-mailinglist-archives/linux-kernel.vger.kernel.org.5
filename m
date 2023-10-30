Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF447DB979
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjJ3MGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjJ3MGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:06:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681A100
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:55 -0700 (PDT)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 855AF3FD43
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698667551;
        bh=h5yxdWuSdqlkaRjQHxke+23X5/FDQMoqzJ+o1pD1n2g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=rxzMOK4oexsUdphk54Ofr59Pw2d1aV/nY7+R0dl4mjd0HZHSrPzoqoR0Ktc/UTDfm
         Euz8a/xWi6qHDKS4sFPtcIRX0jsBEpwaXg/Gum7Zz5mXEF+euE8Gj3EcqUYbDX2lXu
         9fsb+zRR3gCmZ89iL3pHO2oge5joLRpPYzZYlWb3ZnV6ojE6zEYiaNkIkArdT5JQcM
         LwFMOhOTpcLuGrNB6ad0lRG7EBIVPGpi0Hofi/UCYFvekKvKir25YNJKA1teHmwjMf
         XRkNjg4lHLMYFxWZZDRy7C2sVKixfJpbkBkXmjNpGA1RBSJVbpj3LZ9QnISHgntN3s
         JqBmNvShQuArQ==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507be692ce4so4597179e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667549; x=1699272349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5yxdWuSdqlkaRjQHxke+23X5/FDQMoqzJ+o1pD1n2g=;
        b=NHwffU/1mhoY1lMIq6TFo4kmEkyTSsl0f2UWjMhrb/GakbYkWFkvBTY2KwrtYZmwcN
         OqyMLjO0ysB+zsdlXk/tob3Y94l3rdyDRV2sgqBSfGQRw/dBMrxo8mdXttENZnCQ7lR9
         92OSPbZCtW2Gl0kK0ZAx9LNYLsKWMNCARqw4jhMAsNxCtKctRi2ROmHCRe5BXUnBbF9Z
         QCoIoi9DGmAuPv7HCvC8gmSwIr1rWl5WMr/81s/RRpAq1eDAY8I0D7vhcElgSIp/Cn2H
         Dgd3J7Wp45c/Zo7z776km0cK25Jln+Ms9GjJ0cChkeUzkDcmvv8z0CW21q/djJ74ffGQ
         zOxg==
X-Gm-Message-State: AOJu0YycFtYFgQtCNy6I0CfkN4Whuu8XboATAmBlpSuhaNN0/3NaCJlo
        gYlCzcDZ6qYFNgdvUXmSy412LzBIE/NAJbli4m/QNEOEgmrO54VPIUqlii3j55nz2gVx+Nb19sT
        CfCESjrYluVw0JnnGqozeZZjF1yuzKoU0nyxAokskat31XgSeVBN2c08=
X-Received: by 2002:ac2:521b:0:b0:507:f0f2:57bd with SMTP id a27-20020ac2521b000000b00507f0f257bdmr6364250lfl.66.1698667549186;
        Mon, 30 Oct 2023 05:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzM3QtUi+dspzOERuStp8X/ZdIJwFRluVwj+L9z7NdGcBGQtHPJC6K3zP92shMJUTXtLLeDQ==
X-Received: by 2002:ac2:521b:0:b0:507:f0f2:57bd with SMTP id a27-20020ac2521b000000b00507f0f257bdmr6364236lfl.66.1698667548933;
        Mon, 30 Oct 2023 05:05:48 -0700 (PDT)
Received: from localhost ([159.148.223.140])
        by smtp.gmail.com with ESMTPSA id r27-20020ac25f9b000000b005079a4cf2c1sm1407367lfe.239.2023.10.30.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:05:48 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     smueller@chronox.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] crypto: drbg - ensure drbg hmac sha512 is used in FIPS selftests
Date:   Mon, 30 Oct 2023 14:05:15 +0200
Message-Id: <20231030120517.39424-4-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030120517.39424-1-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <20231030120517.39424-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update code comment, self test & healthcheck to use HMAC SHA512,
instead of HMAC SHA256. These changes are in dead-code, or FIPS
enabled code-paths only and have not effect on usual kernel builds.

On systems booting in FIPS mode that has the effect of switch sanity
selftest to HMAC sha512 based (which has been the default DRBG).

This patch updates code from 9b7b94683a ("crypto: DRBG - switch to
HMAC SHA512 DRBG as default DRBG"), but is not interesting to
cherry-pick for stable updates, because it doesn't affect regular
builds, nor has any tangible effect on FIPS certifcation.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/drbg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index b120e2866b..99666193d9 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -111,9 +111,9 @@
  * as stdrng. Each DRBG receives an increasing cra_priority values the later
  * they are defined in this array (see drbg_fill_array).
  *
- * HMAC DRBGs are favored over Hash DRBGs over CTR DRBGs, and
- * the SHA256 / AES 256 over other ciphers. Thus, the favored
- * DRBGs are the latest entries in this array.
+ * HMAC DRBGs are favored over Hash DRBGs over CTR DRBGs, and the
+ * HMAC-SHA512 / SHA256 / AES 256 over other ciphers. Thus, the
+ * favored DRBGs are the latest entries in this array.
  */
 static const struct drbg_core drbg_cores[] = {
 #ifdef CONFIG_CRYPTO_DRBG_CTR
@@ -1475,8 +1475,8 @@ static int drbg_generate(struct drbg_state *drbg,
 		int err = 0;
 		pr_devel("DRBG: start to perform self test\n");
 		if (drbg->core->flags & DRBG_HMAC)
-			err = alg_test("drbg_pr_hmac_sha256",
-				       "drbg_pr_hmac_sha256", 0, 0);
+			err = alg_test("drbg_pr_hmac_sha512",
+				       "drbg_pr_hmac_sha512", 0, 0);
 		else if (drbg->core->flags & DRBG_CTR)
 			err = alg_test("drbg_pr_ctr_aes256",
 				       "drbg_pr_ctr_aes256", 0, 0);
@@ -2023,7 +2023,7 @@ static inline int __init drbg_healthcheck_sanity(void)
 	drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);
 #endif
 #ifdef CONFIG_CRYPTO_DRBG_HMAC
-	drbg_convert_tfm_core("drbg_nopr_hmac_sha256", &coreref, &pr);
+	drbg_convert_tfm_core("drbg_nopr_hmac_sha512", &coreref, &pr);
 #endif
 
 	drbg = kzalloc(sizeof(struct drbg_state), GFP_KERNEL);
-- 
2.34.1

