Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4484E7776BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjHJLTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjHJLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:19:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C72683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:19:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99cce6f7de2so119312866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666360; x=1692271160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2AtDbYJCv6Fp6V9IdD5M0xb5BTawYb8CTVjGQDQLkE=;
        b=ozw/HEDYnwcJoQU304AnZ85OATmGmS7XcEcvVpFr/5gg6X7KmdR4Fw7h2bOYu0inGt
         2DZypujkASOfiyv54MuDjoPFXR48ZLFntHl7P6SX0iAPVu3zTChzUJWKRAy8rRkZnDCp
         sNXmx3mnwM65JcyrHIggYR62t9D6OJDo8x8QuD2FyVMdTOFNpzqm59NkE87/GmlI55wT
         gWUcGkM8kqx3uNm5vbi6/3r48Fir5A1E/gLtPTcwaQeN5K6lImVeo7lcqNxcrUurahz6
         GcPhD2BLUy/h2pvLCjkKf/eB/Ly/IBP97trEeEBLsoLJkbDb+tzhvdPi01p/8u/9kBto
         6FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666360; x=1692271160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2AtDbYJCv6Fp6V9IdD5M0xb5BTawYb8CTVjGQDQLkE=;
        b=ZDNgPHcRZ1ELcTIC2Ph/AqqA/3gSg/5wPom9WwjQ668Ec3o4hJsQbS2c4hChb0erxN
         a8NyQJt0FJLE+kz/dcyJE8izhcHSCRUCZS6wSao0L8aVZDDuebZSsQq8ow9Ou/FAWgSu
         FoNYElwSfIvyNGE5Jr6fegc89poNe9gpzzDYD8c2IOjdfK0/8IKlBnK+MwJb3JNzByPy
         bEjTs2Gu2tfreeIxKJMsUBYukSObDJys5KukOrz3NQvKwpT9LZtFOwvZaylMIlsoaZKz
         8OPMiyHKSqoPBiaKO6tlJno4NHOvX+Af/IeSyy4N+6ec9V0fP1+AUChLSa+l7GS4AuQ9
         ZqBg==
X-Gm-Message-State: AOJu0Ywrsh4re/pgCEmIRccKrrpdIuhm0c7akmZcoOPuF0nDJHJlXf/c
        O0t9Y7WZqetmvnTRJmnjuDMPxw==
X-Google-Smtp-Source: AGHT+IGBCNA2vFA3XXMpI/sz4g5S7qO0xmg/n0Tmbn8dZ3LTxrd4t4+lIQfdX5uHPOydV938TL3J4Q==
X-Received: by 2002:a17:906:11:b0:99b:65fa:e30f with SMTP id 17-20020a170906001100b0099b65fae30fmr1860292eja.1.1691666360039;
        Thu, 10 Aug 2023 04:19:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b00992b510089asm797018ejb.84.2023.08.10.04.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:19:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] regulator: lp872x: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 13:19:14 +0200
Message-Id: <20230810111914.204847-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810111914.204847-1-krzysztof.kozlowski@linaro.org>
References: <20230810111914.204847-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  lp872x.c:867:5: error: cast to smaller integer type 'enum lp872x_regulator_id' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/lp872x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 63aa227b1813..942f37082cb1 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -864,7 +864,7 @@ static struct lp872x_platform_data
 
 	for (i = 0; i < num_matches; i++) {
 		pdata->regulator_data[i].id =
-				(enum lp872x_regulator_id)match[i].driver_data;
+				(uintptr_t)match[i].driver_data;
 		pdata->regulator_data[i].init_data = match[i].init_data;
 	}
 out:
-- 
2.34.1

