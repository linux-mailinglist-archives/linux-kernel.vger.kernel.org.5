Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E39758DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGSGXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGSGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:23:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BA1BFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:23:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso8838050a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689747806; x=1692339806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIa0Hkz4zg5vgRvGLwOuJtJFIr5nGFfRCpnkZR03fTc=;
        b=voWti/7atLoFZWFQegJqLCU9w61gHPdnyLVig2A/dgRT3tR02XF6g7s5rvo8miv864
         aR6P4vqeytQXWziZhuF8+mH1GP3xBugbEVed1Ih8yrBBiMS4CWkn933gWgmzGlYVeVJY
         bRttEMDb68diMN6ReN0iD+XYLCcuKFVnoGTfa4YoEmikhgyGRK4eBnikIZILkL+RRemy
         NlD7ZL9kh1hCK8U3IDxO2hXEzXtEsMsswLg0dh5+v327OZt6jmTTlOmBRXzjjj0Pw7W7
         fzkmao4Yxs6UDkjpQNfBbb/DMTzcg0pqTpWj3b4uMwFfgDX5Fava5XmS9E0fOjd1XMSq
         MbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689747806; x=1692339806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIa0Hkz4zg5vgRvGLwOuJtJFIr5nGFfRCpnkZR03fTc=;
        b=JCJN1qBzenMF5PW19AJ0qMw6QaFO0CkiERLP/xJ8AaP5b9OS10wNYF4XT3y7wndhZz
         ViKVvgF5Y2dx/XOK2NY4B+rwBTkYqKGMI4zRvSo9Qi4HJDMRcycG51OhX5L1QiDghGe9
         I9NJW+5vzCAjcfyD6aJf5rVVM5XWy+t4nQlRSA4wcOTM08OZBDAyTx9jFikCHCFk+6Vr
         JQ5la2fczcN3jK2JHeHWVAxuzTBQZFzT2pDFRuJuypNvTKdl6X12GKAjDQLSqMj7tQbD
         asI3GqrFj3TERSUTFaKycn7R/JCUgvq3T9GFZNakxqIh1YRvN3GdeuSp2NDIAzIACtCL
         bc2w==
X-Gm-Message-State: ABy/qLZpruO1eL3FhXT+GAdyORfbkADhRQk4yeJCOzs1BTjK7TxQnMAo
        n/+jKkgxh2Zqn8mHSdDNymLEGg==
X-Google-Smtp-Source: APBJJlG7cCiluAgY4jExllMOrTl4i8ynGNChlKio+c2e78qOjAQfmMHRg70ShDHjrVGM4r+Y/yAHlw==
X-Received: by 2002:a17:906:d9dc:b0:969:f433:9b54 with SMTP id qk28-20020a170906d9dc00b00969f4339b54mr1488849ejb.39.1689747806501;
        Tue, 18 Jul 2023 23:23:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906351600b00992f8110a2bsm1851382eja.150.2023.07.18.23.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:23:26 -0700 (PDT)
Message-ID: <0ffec87a-976d-5a7e-bdce-418dbe817ed9@linaro.org>
Date:   Wed, 19 Jul 2023 08:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 3/5] ASoC: codecs: ACF bin parsing and check library
 file for aw88261
Content-Language: en-US
To:     wangweidong.a@awinic.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        doug@schmorgal.com, fido_max@inbox.ru, flatmax@flatmax.com,
        herve.codina@bootlin.com, kiseok.jo@irondevice.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, rf@opensource.cirrus.com,
        robh+dt@kernel.org, shumingf@realtek.com, tiwai@suse.com,
        trix@redhat.com, yijiangtao@awinic.com, zhangjianming@awinic.com
References: <98292541-8435-53cb-22d9-716ed6541485@linaro.org>
 <20230719031237.41530-1-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719031237.41530-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 05:12, wangweidong.a@awinic.com wrote:
> ...
> 
>>> +EXPORT_SYMBOL_GPL(aw88261_dev_load_acf_check);
> 
>> Why?
> 
> This function is also called in the aw88261.c file

Is aw88261.c a different module? If yes, then why?

Best regards,
Krzysztof

