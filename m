Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325677901F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350524AbjIASKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbjIASKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:10:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F6E19C;
        Fri,  1 Sep 2023 11:10:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso294640366b.2;
        Fri, 01 Sep 2023 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693591845; x=1694196645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxWwqJu6zd1x4UXrAe321NeYBqI8ed/gpuuiA6ARJ4U=;
        b=ph859srzdrb3JdJszo4Mg9gyW+WMjXui6BaH/6B4tIs5NKyQb03iqcQFTEWL1gyind
         KLpabg1cx3TG7Nv9C61whqjUwabQDxsAVK6vpK1tvVC+OiJZDr+tFKaO+nH7vuVzYw4j
         NwvuGuhdtra9F3ZX/KscvfmcR00oDXk2Fc4m/WvyGsWjoGPCk19eCVlqZ05VkoNbpkUr
         YB0oA2Vr0vDT4ZYG6zXYVMsfPCbAWQnVaOgDvwWhRBQuYNrC395/ph2U3nBGVT8rbCZ7
         lWdYWte859qUS4+/AKyQsG5DDfhOIUhJYfVf2ZYJvuaiybPw9eOU3c/5KsmMQ2pk/wFJ
         DXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693591845; x=1694196645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxWwqJu6zd1x4UXrAe321NeYBqI8ed/gpuuiA6ARJ4U=;
        b=PpYQoHTB5Z7tXRfdJvu/x0PJxKkCj71vArgbmArwJSF/WGmqSHcFlZwSASJPxJQxFW
         nohJk1X/Rrm2fD8wMGJMrPzSgOZUPN0XLDddDrX+Rux5iWRrtR6Ltlvu8K2ZXyxmVj6b
         g/0DGeWA1JqTe7RoQ+Oeh42b3/aHzKhkMppUIqFIVTaem/Qo8tDo/yQRutLKgPA3Sv/n
         ezyPSaEp25v62RaZQDdleToo/dzga6x7OJELFphVOfQ6g+9idbECeXKNGxeH329jVsGa
         GZA8QFhJI9lSkR2esNeT7PshXDWRIVqH9c4pPwq2qngdOCqSCT2z3O5X9Xr6G2stzLYh
         XzNA==
X-Gm-Message-State: AOJu0YwrwRVZDPiqugWf5eJmZdGKoneJYrMOvfIk1P541zNDOTbY7j4L
        5b5dYxY0Dudq+bdWpcluOho=
X-Google-Smtp-Source: AGHT+IFVYLNs2VBY6jrYIC97D3941yh4hyQRLWEZpvcFzpC4AOdibDnMFWZ0u1FxneSr/LTchcZEVQ==
X-Received: by 2002:a17:906:f252:b0:9a2:40e:2cad with SMTP id gy18-20020a170906f25200b009a2040e2cadmr2351811ejb.48.1693591845094;
        Fri, 01 Sep 2023 11:10:45 -0700 (PDT)
Received: from fedora.. (dh207-99-49.xnet.hr. [88.207.99.49])
        by smtp.googlemail.com with ESMTPSA id j9-20020a170906410900b0099bd5b72d93sm2278999ejk.43.2023.09.01.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 11:10:44 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add IDs for IPQ8174 family
Date:   Fri,  1 Sep 2023 20:10:05 +0200
Message-ID: <20230901181041.1538999-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901181041.1538999-1-robimarko@gmail.com>
References: <20230901181041.1538999-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
are missing so lets add them.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/soc/qcom/socinfo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 497cfb720fcb..345f0b002eb5 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -359,6 +359,9 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SM6125) },
 	{ qcom_board_id(IPQ8070A) },
 	{ qcom_board_id(IPQ8071A) },
+	{ qcom_board_id(IPQ8172) },
+	{ qcom_board_id(IPQ8173) },
+	{ qcom_board_id(IPQ8174) },
 	{ qcom_board_id(IPQ6018) },
 	{ qcom_board_id(IPQ6028) },
 	{ qcom_board_id(SDM429W) },
-- 
2.41.0

