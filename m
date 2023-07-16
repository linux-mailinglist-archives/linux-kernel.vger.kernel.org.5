Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B3754F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGPPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjGPPpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:45:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC094E5D;
        Sun, 16 Jul 2023 08:45:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262e5e71978so2190290a91.1;
        Sun, 16 Jul 2023 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689522300; x=1692114300;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvKLyYGop2dMHaRt6lb3hw8V7SqDURLCw/b6W7tR2ZQ=;
        b=rij7/W128RMSEHRjPkvt2CSFG40Sv7oKrGqKjz6K6bq9S/PM+IchTptN3BawFLhJ/r
         ym4Ih+Qj1qsriFIa/Puu6Tmz9/vqoq4oZXOGfmuYL4jxvXeK/E0Y1w+bggUP8FEiEOzs
         tgMRyEi9rAUgNWr+tF8/la+/kblt3PSWYZ7dinO7J1usDeZ9LZqi7UQ8Ot/XzV0wbzKq
         bY/Byn+4wu4jCZRnC5VvQTi8V7NMCF61Z3jszJFIdCqHVtPCzb2tSefH6Raw9ju5qd8B
         QeE3Lu+ZuvSmV8hXrkHadkluWwPDvoOgURv6J3vtmbkpM7RDrAZs/RKUtnminlv37ag3
         Ce8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689522300; x=1692114300;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WvKLyYGop2dMHaRt6lb3hw8V7SqDURLCw/b6W7tR2ZQ=;
        b=THbnkYRDv2SXQyFQMKrGStjpbOXsOZStgWOIiKm84LixjsVz9socvPTrm6RImmh5iW
         7qqWH64/z+/QKO8wykfYuQhhv1yZ6HCS8/V/lxd7mfb6Sgoe5rcA0pbEmUzCMfO50exz
         Vobx1dTtfLjxuX7YEawi7z6zMlbSOgYYxMR75A/5h4z3EUXdaP/FUwSmF+ccOoWcufie
         2LIXuvF10StKY/YcnpTQv6JyUC26qmhfL55b71WKKhDI/Mcp6qHkZOwjldQUhXdm8DSS
         mCZSaeHQiPc9idQ9qfbxARvSK3xffEMuDQJ2I0K8anvVoDwG8nOAOCwWpMDeorvEueXR
         BxkQ==
X-Gm-Message-State: ABy/qLaI6PWhCnZn68u9lnfPD1CA66EyNiHZRu6Lq5m6xbgXF0Gm4wQw
        PaOiMNPP+A/RJ4+xKH3mkbKR/sKlY5sSU+Ox
X-Google-Smtp-Source: APBJJlFFuuZv23TJkkzP/61j9KUMip1D69gCdXdZz9eTEN+hWwdErmMNiT9ipAQ/A7/wIMXeZV0kjQ==
X-Received: by 2002:a17:90a:e594:b0:262:ec12:7c40 with SMTP id g20-20020a17090ae59400b00262ec127c40mr10127878pjz.11.1689522299885;
        Sun, 16 Jul 2023 08:44:59 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a031a00b002609cadc56esm4086575pje.11.2023.07.16.08.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 08:44:59 -0700 (PDT)
Message-ID: <d4080db5-1825-2848-079a-8bb674d8ee44@gmail.com>
Date:   Sun, 16 Jul 2023 22:44:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     william.gray@linaro.org, rongtao@cestc.cn, ricardo@pardini.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
Subject: [PATCH v2] tools/counter: Makefile: Replace rmdir by rm to avoid
 make,clean failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rm -df instead of rmdir -p since rmdir requires the directory exist
so it causes "make -C tools clean" failed if someone only builds other
tools but not counter.

Fixes: 228354ed692f ("tools/counter: Makefile: Remove lingering
'include' directories on make clean")
Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
Changes from v1:
- Use rm -df instead of checking the directory exists
- Add Fixes tag
- Update the patch title
Reference:
- v1:
https://lore.kernel.org/all/362e127d-6018-5fc6-247b-3c729b99d946@gmail.com/
---
 tools/counter/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/counter/Makefile b/tools/counter/Makefile
index a0f4cab71fe5..b2c2946f44c9 100644
--- a/tools/counter/Makefile
+++ b/tools/counter/Makefile
@@ -40,7 +40,8 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/linux/counter.h
-	rmdir -p $(OUTPUT)include/linux
+	rm -df $(OUTPUT)include/linux
+	rm -df $(OUTPUT)include
 	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete

 install: $(ALL_PROGRAMS)
-- 
2.34.1
