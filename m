Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2419F7C8593
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjJMMUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjJMMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:20:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23694C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40666aa674fso21092565e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199623; x=1697804423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN0ITJHTojInGZA3keypX639mxo/rJNGkS60FWqtiI8=;
        b=bX+LrHAxiGneFB+T3CFoIr2seNA+1MVPcHtaVIZ7evfVdYdp6ygB43DY+gm/kUk/iP
         iUIceqSMmgkhtY4N6sE01JHgEXsCLLv/BfHO1YWtHfJ+TsFOwjsRbRdPaqeLvqQsgX0d
         F1I0Gz9UCLCniz2xReCmqT2m8SVYDXjPt5ErLRq5tOcjR07qZBDPEkdVr4WQgwCPbI5x
         zmcMQT2Z0D/pgLOWrrAWEZsE61jV9bhpBf7UGXS7r6T52bACiGCcNaSQ7cLK/l8ndrUh
         MdHzdzOoncNjnPUinqFU/ZyyTxlCRk+pzGWVMmQ/+e2WFrsk+kP0lMJhkkfBE2+PJu0/
         zeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199623; x=1697804423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oN0ITJHTojInGZA3keypX639mxo/rJNGkS60FWqtiI8=;
        b=Pr9yAtfJ6ZfNxfo41JpCUQuVQuXwXQhobyCqQH63MFuIOjr57L+y12PG9bYV/Ghuyl
         E/gifAhiJRcU1Vng7FpxIo/ujLYW72YkN5eRNQUrydgsm0xfODIN7H0Yoecy7mqe5cFr
         os4+8VIkOv/duUDa9bovQHyTYgddbxjF6Yzvnbw3xcL9ROYnK+caWQ2UOXp31+E/TAFu
         dizmPOWOTxkKQ8hSpu9Nsegk7THskf933oAnhKSuqEYgpdBpAmThdzqG4u8RiDI3sq0V
         lSICHXNi2/J/asIfbob+I6e94w8LuK6vk40PhrVUSOAPzmnfAyn2NimwnIWSHE3l9Tek
         8LBg==
X-Gm-Message-State: AOJu0Yw9u9+uwdJu+hwqpaTxv6l27+OBtKVbmOJLOYcU5sI7TGNE31Ty
        V5MAPxacIMQ2rNLmt8Um5ayksWBiQAZ4qAfquewgRA==
X-Google-Smtp-Source: AGHT+IFX09iqP49ngFgPtjinx51FlFNm1a+U4ttHUJMtFVvH4kjoDPxCLTtK4q4WClIwDlk6jJv/qw==
X-Received: by 2002:a05:600c:2050:b0:405:40c6:2ba4 with SMTP id p16-20020a05600c205000b0040540c62ba4mr22708053wmg.5.1697199623556;
        Fri, 13 Oct 2023 05:20:23 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b0040772934b12sm1806751wms.7.2023.10.13.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:20:22 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] misc: fastrpc: Clean buffers on remote invocation failures
Date:   Fri, 13 Oct 2023 13:20:06 +0100
Message-Id: <20231013122007.174464-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
References: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=2F5oS3hFPDLq3LPK12cuaWAqGv8XXJpvGPqicRayT3g=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTX3TRvZqlRZnYGXiaaARQSCcyfGxjaYymriB mvjrOhZ4I2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk19wAKCRB6of1ZxzRV N1DtCACSfN3vZQSrBgMcNpBV/RJXKnIrZFQUS2CzUmAGt+DnDJcumOxbFuvTmCUlQTHVOgruI36 /rAkxy4t+xFh9XeKwEsDhDhSwqrCkkadEPfBheGxMrO8dpiVvGMZ1uBVYLuE9AlfATFunXn1pUD v8U/d85P2KXOZnFcD0HNuVpfXWiYn0HouAqKUX3Xcuuz2LQ5ULMD9Vn78TsKN+ELVKtI+R+wpb2 48s9nSLxMz8K1LH6PFfQgslYLzf0p6sk+DwqXAXZ1ndN3G/bjDcKa7iD8grLejNlkYFXKISBunN pPM/LcSnrwdQFlkzUNSjmvTpdf6ce0Hs2oHVvQm/AJw0B1B5
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

With current design, buffers and dma handles are not freed in case
of remote invocation failures returned from DSP. This could result
in buffer leakings and dma handle pointing to wrong memory in the
fastrpc kernel. Adding changes to clean buffers and dma handles
even when remote invocation to DSP returns failures.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a52701c1b018..3cdc58488db1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1176,11 +1176,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		err = wait_for_completion_interruptible(&ctx->work);
 	}
 
-	if (err)
-		goto bail;
-
-	/* Check the response from remote dsp */
-	err = ctx->retval;
 	if (err)
 		goto bail;
 
@@ -1191,6 +1186,11 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
+	/* Check the response from remote dsp */
+	err = ctx->retval;
+	if (err)
+		goto bail;
+
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
 		/* We are done with this compute context */
-- 
2.25.1

