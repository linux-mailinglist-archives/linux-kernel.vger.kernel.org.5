Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D86781919
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjHSKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHSKwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:52:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89712A3BF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:49:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99d90ffed68so597870866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692442175; x=1693046975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVWrnLbQ5U+5Jr66RgRooL/nIKRDLYBfzkUePWCJ4D8=;
        b=XqjiBpFKSFeBeSsIdiXipAqJ7ay2pi8G/6kiii0s0wlZwsN95FlkWibYFe7MRMgfBB
         FTjqIK6wvpQZIANJr1PlwTJuVSSeFgKIkvxe0RR5VkthMc7fPt1FpBzTQEymUO7XAJzb
         AaoUz/tkg8rThE/4fq2vIvr5HfwzZGEL97CjZ/ZtENprrKSclnHtOGdounvQcavGXF2D
         VqFFF8AeQtYr9Z6oEyTaUsPEMe2RxwCFDdnVzOTnsy4pIpTfN3fBZXrjh452ibvP779f
         6z3ysxpys2fGxNAjsawgJpKc6ZfUl+xV4jU/I9A0UcswiKImEz3JVFHqFHPeaOlVYCiF
         TNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692442175; x=1693046975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVWrnLbQ5U+5Jr66RgRooL/nIKRDLYBfzkUePWCJ4D8=;
        b=Tngd1qAirR9FmviGGCpDzyJrrjSF9gda1p/SylHKlHg9OTBfpV3aWMtZVK4a1h1Wc5
         E9WL3yZ7nC4IkatoGcy/iesAiw7PlFS/dfobV5KmkL11Petskpi1vFnK02Xv0o5uFIew
         GuXtIiO/HLbFRicyyftbrVmQ0mmkatxJq6Kiapdy/e4wGOgyFKUVxaMrFLe26AyEz9Zf
         3tst34TN/87IZq14v/MexXBENZjOE1r26yxFmYtlwshUC8bGQJK4KzIbDpSAmgnWL8/e
         NPs7qZG0UssLbXOzvcQOHhq14EDtJX3z02VRYmCJJFt9354R3EW1DIHbzyk5n8wQFK3C
         yhpg==
X-Gm-Message-State: AOJu0YwIxYnHTEkgsgtYUd2SjeIEZZjJBQBsF8sLLv1UJXfLCg9PZ953
        GeHwLnQ3rnWJ8qnMK3Qtg7OT+GEB5OHY+d/f+nM=
X-Google-Smtp-Source: AGHT+IHqGgQDEC5R9e2o/qTHplcGjZOtOPwD0SW/aYr8LgECuFitvGay8uFd9jGjC4GxAUH8Pmqc2g==
X-Received: by 2002:a17:906:8a73:b0:99d:e417:d6fb with SMTP id hy19-20020a1709068a7300b0099de417d6fbmr1811743ejc.25.1692442175198;
        Sat, 19 Aug 2023 03:49:35 -0700 (PDT)
Received: from [192.168.69.115] (cnf78-h01-176-184-27-220.dsl.sta.abo.bbox.fr. [176.184.27.220])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709062ecf00b0099cd008c1a4sm2513613eji.136.2023.08.19.03.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 03:49:34 -0700 (PDT)
Message-ID: <d138c76c-72d9-f07e-7db0-1e5e939bee9c@linaro.org>
Date:   Sat, 19 Aug 2023 12:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/4] MIPS: Add identifier names to arguments of die()
 declaration
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <1692434183-2054-5-git-send-email-yangtiezhu@loongson.cn>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1692434183-2054-5-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/8/23 10:36, Tiezhu Yang wrote:
> Add identifier names to arguments of die() declaration in ptrace.h
> to fix the following checkpatch warnings:
> 
>    WARNING: function definition argument 'const char *' should also have an identifier name
>    WARNING: function definition argument 'struct pt_regs *' should also have an identifier name
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/mips/include/asm/ptrace.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


