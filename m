Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5331D7677F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjG1Vze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjG1Vzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BA82D5D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2DD6219A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 21:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B60FC433C8;
        Fri, 28 Jul 2023 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690581329;
        bh=Z4SQybceQsh86evN9Y93rfoLnXK8M034LJA2OwLXMsI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e9fVVFf1mmjIcI0txEaSYX8sAnZY8/4SmPWnbLaOya9Pmrv3pIHAsk35k/CLLOzYl
         ZJsGMyr3cMQdraUpP0WafkvUvq3WZP+hzSh75U9CMBfIa5BS/Op+8Sffwr+Vnk4Toq
         B+kG+RGPf4atjGYZ2rXiKEMY5Qiu6za3fBxCyl6HaXZClhY7NdORxwcBkgkYa8qXEH
         ycblSo884G+CO6G+sfSTeD3nGsbFCG22EbjSEJPAcTpNkHecweLc80eQgX/EQGLW0S
         PKk5D03+k5RpvlBFt1N7/d9jYw7mk6vOpyPVEsvStf7SBnGszRQU2s3ReswqIMqo3N
         ZWhmB+6cVWNpg==
Message-ID: <8ec9fc9c-a68e-422b-9b5e-c280652bc5b5@kernel.org>
Date:   Sat, 29 Jul 2023 06:55:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] mfd: max77686: Remove unused extern declarations
To:     Yue Haibing <yuehaibing@huawei.com>, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230728132709.27052-1-yuehaibing@huawei.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20230728132709.27052-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 28. 22:27, Yue Haibing wrote:
> max77686_irq_init() and max77686_irq_exit() are not used since
> commit 6f1c1e71d933 ("mfd: max77686: Convert to use regmap_irq").
> And max77686_irq_resume() never be implemented since introduced in
> commit dae8a969d512 ("mfd: Add Maxim 77686 driver").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/mfd/max77686-private.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/mfd/max77686-private.h b/include/linux/mfd/max77686-private.h
> index 3acceeedbaba..ea635d12a741 100644
> --- a/include/linux/mfd/max77686-private.h
> +++ b/include/linux/mfd/max77686-private.h
> @@ -441,8 +441,4 @@ enum max77686_types {
>  	TYPE_MAX77802,
>  };
>  
> -extern int max77686_irq_init(struct max77686_dev *max77686);
> -extern void max77686_irq_exit(struct max77686_dev *max77686);
> -extern int max77686_irq_resume(struct max77686_dev *max77686);
> -
>  #endif /*  __LINUX_MFD_MAX77686_PRIV_H */

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

