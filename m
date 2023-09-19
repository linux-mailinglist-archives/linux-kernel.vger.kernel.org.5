Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777B7A6967
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjISRNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjISRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:13:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F3C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:13:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1414692b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695143628; x=1695748428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAKzLNN3omo5G3t3Q3Z+5ZUsB2vHt2IaB13wVcXMzUY=;
        b=Z5TYH5+vtiBfOi+hiPJi6JrMJ2FgpihoET2iRTnJM1MC+IuizspdytaS6CaQ6Prfwe
         iouiDSilvWRUKRMRlwY9W3TwDdezMdIJ+qLgH59zjY8n7Me+qDCThGKXnMqPsQHtfafN
         IB5Z7oT54IWjrE1VfU1o1PbaUVehcKekBPRB/pvSh+gUFAGyjUS89RS504Le+K0Vyruu
         SuqQhohARwqzf6NyPi4MSEfjIpBEX0mTHeRsSAkyWpgUdZJXKCbFWYwqHIfFlVasjhg0
         UboKKTgVZ965iYq0tvq38n1vOwKBlKgCDU15hTI/p50qTJatuBSITlyUJRY/KnVuL+yT
         I9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143628; x=1695748428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAKzLNN3omo5G3t3Q3Z+5ZUsB2vHt2IaB13wVcXMzUY=;
        b=BDc806Z2FQ591WX5h0SmxQNrorbflTD/Ox6nZzigzX5HhVigGvL8tqgh6tcClx3Ev/
         7dGzc3nyrdqrp6GxVQo6TzjT5m8XXTAsv3Yom+q4A1GChjT47tDdwVe/rxfMCmb8VZml
         gi+3051lpYYlANiyfIxJkZT0Uxt7sFDGgxGu01KJTpfjBLfa6TbH00nwwBVUfSlNxs16
         +CYhOgSqK9yHIICP/zo0XBhvQl2lzQVZmuTE3gH1we0xMr4hOMJrHkmBSyH3rEYgKvuC
         25r8nBQF0C3qprJOKX5xDj6EhyF1pre5B9VG02BEws+KVXkITpgJ1Ur2tatT32gWXoz5
         +bKA==
X-Gm-Message-State: AOJu0YxpHol8RiU126rFOgtcEEuQ99LUC2666pGNu8gWzCs7wbT+tzAR
        sTVZTxmwDgENbfKHwmqzwY9tZl8HC4k=
X-Google-Smtp-Source: AGHT+IGHUgpZNkGcerRxIQonBsC68jysMiuSJ4sYngrVhWaMEyYWAr5f46q5AZlWt5045G6dEdB1dA==
X-Received: by 2002:a05:6a00:18a9:b0:68f:cdf3:dd54 with SMTP id x41-20020a056a0018a900b0068fcdf3dd54mr347622pfh.9.1695143627910;
        Tue, 19 Sep 2023 10:13:47 -0700 (PDT)
Received: from [192.168.31.134] ([117.243.68.251])
        by smtp.gmail.com with ESMTPSA id u9-20020a62ed09000000b0068fe39e6a46sm8769599pfh.112.2023.09.19.10.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:13:47 -0700 (PDT)
Message-ID: <7bad2536-087e-9ecd-36a5-b243e0b3e1e9@gmail.com>
Date:   Tue, 19 Sep 2023 22:43:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix codespell-reported spelling
 mistakes
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230917134940.2746-1-bragathemanick0908@gmail.com>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20230917134940.2746-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/09/23 19:19, Bragatheswaran Manickavel wrote:
 >They are appear to be spelling mistakes,
 >Initially identified in a codespell report and never been addressed so 
far.
 >
 >./rtl8723b_phycfg.c:156: Threre ==> There, three
 >./rtl8723b_phycfg.c:283: Condig ==> Config
 >./rtl8723b_phycfg.c:328: Tranceiver ==> Transceiver
 >
 >Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
 >---
 > drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c | 6 +++---
 > 1 file changed, 3 insertions(+), 3 deletions(-)
 >
 >diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c 
b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
 >index a3bff27af523..7764896a04ea 100644
 >--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
 >+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
 >@@ -153,7 +153,7 @@ static u32 phy_RFSerialRead_8723B(
 >  * @Data:    The new register Data in the target bit position
 >  *            of the target to be read
 >  *
 >- * .. Note::    Threre are three types of serial operations:
 >+ * .. Note::    There are three types of serial operations:
 >  *        1. Software serial write
 >  *        2. Hardware LSSI-Low Speed Serial Interface
 >  *        3. Hardware HSSI-High speed
 >@@ -280,7 +280,7 @@ void PHY_SetRFReg_8723B(
 >
 >
 > 
/*-----------------------------------------------------------------------------
 >- * PHY_MACConfig8192C - Condig MAC by header file or parameter file.
 >+ * PHY_MACConfig8192C - Config MAC by header file or parameter file.
 >  *
 >  * Revised History:
 >  *  When        Who        Remark
 >@@ -325,7 +325,7 @@ static void phy_InitBBRFRegisterDefinition(struct 
adapter *Adapter)
 >     pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara2 = 
rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
 >     pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara2 = 
rFPGA0_XB_HSSIParameter2;  /* wire control parameter2 */
 >
 >-    /*  Tranceiver Readback LSSI/HSPI mode */
 >+    /*  Transceiver Readback LSSI/HSPI mode */
 >     pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBack = 
rFPGA0_XA_LSSIReadBack;
 >     pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBack = 
rFPGA0_XB_LSSIReadBack;
 >     pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBackPi = 
TransceiverA_HSPI_Readback;
 >

Gentle remainder

Thanks,
Bragathe
