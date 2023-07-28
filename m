Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0605C766E73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjG1NbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjG1NbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:31:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106F3C33
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:30:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso21387095e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690550922; x=1691155722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6QH8KF1BtvHTx8dmcWx8rNHskQ91YwJ5Crb/wcFLYg=;
        b=aRGa5kFEjVr8wt3vHDXKlMzszHXE9bDb03PsFsXOOKHT7ZHYR9RKB7MasIgqJKZPdm
         X94P7hqOmRlBSWYTZ+p6x3GCmv0xQ+11mP08OhmOndtr64Mv4aGahoT57VD2HJmjWujO
         hfLjMiCPuZ9b1eo7Dr6i7et3EQRHvBZO6vvbdT826K5VHv9XTi8NBsFc1TqL4cD5I+q/
         FM8IkyXoSEiNEi+cKzg5DjT/ZzHBSmUdfzsQ5MPYGB+9MXQ2H2XL5EXfluQ7DHeYSiwm
         qD6nUHZSfnzVcK6dtAucZ175tp/YFznWk8naaD9WINkadqGxtc/XvhokenG1yXJk45NS
         kr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550922; x=1691155722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6QH8KF1BtvHTx8dmcWx8rNHskQ91YwJ5Crb/wcFLYg=;
        b=cl4d0Q8c5GnbGRPqRy4K5SFTHg+Bb9SXfOFm6NfV9vw+4vYHxvI1zP3HAOxdaG29KE
         EaWDo/1FOiqUBphiOI352bAtkH/yp1XqmvjoXv3Cc5F0/mBbtjT7DwRDn6ysyBWnAEfh
         kK1Ov3vxKrrU7YMxDBFD3FBkWgMTvSBQHtsAfU5RgCBKKXEHkTk1zQqqcohgc5US7rfr
         buBEFt/YO838wufG6sZ2E/PqNFi0VQHw7c294aLRePoOmWqbG+Q9x2W8F+8BpjDsEKK2
         nkVtijFe0flqcJLSuk7/XXIzakBhpHGLl9y88cYz2gZkSJCQmHHQY1OWLm0lT+dAfcdX
         QrWg==
X-Gm-Message-State: ABy/qLYwz5rY+Pymtxm4x+KQ8/M065bX092ykCd7LjSJBO73UtBV56Ij
        BTl2dXDQLkCjD22Vanf5601azstAYS8pBHEhxHdk5g==
X-Google-Smtp-Source: APBJJlFXCUyhcQ8rdwohIGr69OK9OZUB+TLTByFp+OCixU/khDmngmEa4XIT6aM70HAICjl4QnEkGA==
X-Received: by 2002:a7b:c3ce:0:b0:3fe:f7a:2787 with SMTP id t14-20020a7bc3ce000000b003fe0f7a2787mr1124919wmj.41.1690550922008;
        Fri, 28 Jul 2023 06:28:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b003fc00789d5bsm4268885wmg.1.2023.07.28.06.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:28:41 -0700 (PDT)
Message-ID: <04ccf829-c1cf-4b60-3af1-25d92e2e09ef@linaro.org>
Date:   Fri, 28 Jul 2023 15:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] mfd: max77686: Remove unused extern declarations
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, cw00.choi@samsung.com,
        lee@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230728132709.27052-1-yuehaibing@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728132709.27052-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 15:27, Yue Haibing wrote:
> max77686_irq_init() and max77686_irq_exit() are not used since
> commit 6f1c1e71d933 ("mfd: max77686: Convert to use regmap_irq").
> And max77686_irq_resume() never be implemented since introduced in
> commit dae8a969d512 ("mfd: Add Maxim 77686 driver").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

