Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC07A1728
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjIOHUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjIOHUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:20:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D1E0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:20:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so19634985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694762438; x=1695367238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJaQO2Osvw63vkpc+hRyCtg96PFW7ippMuIjtGVzXRg=;
        b=TmwMcB9ZDYvPpo1Msjcjc9/6yzZldkOS2xwAUdJZXNrBTfJw29WOT6oLZq0RzaT0UW
         kdwHO7HJXRxldj0gPVYXJE+jmZhQAZh0L5Xoh1zYWYE0+FVEArQse9bLdIYLuTaGZC3u
         JR0UkGSFwT4GFMa3UyGHTC87G61NHBR8LnN4yA5u/ozsMTOdDE/JxFdadwl8UAiFDGo+
         r0KwTNoV/QcOT/z28EV7dPLnFSvvQh98gRv8/0h0173uJR2jWzOdu3dfFVYAi+QIZNyg
         5eViWUzk/cIdA0a7tHhqfQDKwhjdZBMxf667zosHVsCRshRR2JkuBMCSQ+1NVdO5fABy
         +fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762438; x=1695367238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJaQO2Osvw63vkpc+hRyCtg96PFW7ippMuIjtGVzXRg=;
        b=dtppunkWz1KySQsFsfWq53ib4XOMgXY54DHQA1/ljXNuCjgPFgPyhgf1jvv79OWYS6
         vCe2w/KH/UCsYt23YqWKFMWCP9r+0gsBCcGcCwPY/A6Bbu+5rCyCzqn13Papve8tWsZ4
         K+EaWA5QHvueiRdr4yZrCMeu1WDDnsKIlYfDU1X9cnEEHRKf6pFP3c9o+fWn46wc/bxK
         1ITeRMl2Kduf8TVabse2CjTDT7DuGfvFwKJoyVF7Jt3HatJNQU7Pe29p2nMJ765mwJJy
         hgMnkSHrMRnNtYARDdOz++HeYE1VHFOXRBUCZXAcG9LK6vNMeFTmpP6vYmHgbscexzGL
         tw5g==
X-Gm-Message-State: AOJu0YyxfmCa1cm4A/sRIBtC+7UJ8vVWfuvx/nSDnmY+oI72vPxIJorL
        GHxcYjx1Y5vveLbQZwLJgnnaCA==
X-Google-Smtp-Source: AGHT+IHn1pzRnqERbj4JktaivR/54B/ax+k9/9EVN0v/fkF7vEk1NBnAMBcbA4gBaXUMXzS102iogg==
X-Received: by 2002:adf:f5ce:0:b0:31d:c3d2:4300 with SMTP id k14-20020adff5ce000000b0031dc3d24300mr506300wrp.71.1694762438014;
        Fri, 15 Sep 2023 00:20:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id m6-20020adfe946000000b0031980783d78sm3666315wrn.54.2023.09.15.00.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:20:37 -0700 (PDT)
Message-ID: <85264977-69f1-3e14-03c6-bdadb4246c23@linaro.org>
Date:   Fri, 15 Sep 2023 09:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 01/12] riscv: Add SOPHGO SOC family Kconfig support
Content-Language: en-US
To:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        conor@kernel.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
References: <20230915071005.117575-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915071005.117575-1-wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:10, Wang Chen wrote:
> From: "xiaoguang.xing" <xiaoguang.xing@sophgo.com>
> 
> The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
> cores.
> 
> Signed-off-by: xiaoguang.xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>

Your patch threading is completely broken/missing, so this makes review
unnecessary difficult. Fix your process (e.g. use b4).

Best regards,
Krzysztof

