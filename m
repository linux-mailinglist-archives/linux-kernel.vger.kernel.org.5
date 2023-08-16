Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF177E7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbjHPRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345304AbjHPRdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:33:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369A410FF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:33:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso106234791fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692207196; x=1692811996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlJlE+pLzohqehJhGlKehccYlE2SfB36KPQVu33mNpA=;
        b=IT7+QY425Z6hPqSdKlPUHX+BgJhLtUz6CFYhT0PlTQtFlEQp3u4BUH9ezBHaIx96Bz
         ui88ZdlkKUT7is+qkZbkjMyDcdJH6GbV7MnC6VEckQZsUHMfOvbLqKGWyijgBg9ChGT6
         9f3R+hd+zrXbeSiiNxnJHjdmBpKhYFNiB37oDDRW3A2yoR2RcBPfTnstsqsfefInvuM+
         aoSYRGYGFQnicmMDeIhiFiSxjDEreLpCyU24/Cj490L5pq+Hxugq8udc+fyqZtdpvX1V
         HYYaieabRVjIrZQb2H4Lpg7um+m4lXLayUDF5buetlGWJa1t6/z93ZJwjekdXvyHNZwr
         49VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207196; x=1692811996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlJlE+pLzohqehJhGlKehccYlE2SfB36KPQVu33mNpA=;
        b=ecqqIu7NcW9Z0pvq7MSfAX23vQgnn1lNEm0Xz9L6dyI2JsjOew5C4IHDGqCDzfuzG8
         2msbcVvBuCpPW/eILVOZ1fcJZQ+PyspzcEW2QWGEO9omM9P6IgQgKjImJy+g192rIcNb
         K8RpTeo+PAYzaCD8uhuc14lp0MqjJpzRDjVM3ARZuMTmDi8LFc9PCoX1sTHeBlRvUKIg
         vL4rWkZM/PqeyBqkx4vUbMXZiCMm1tQQAJI5jQH8LfLoVNJBbpDA+7jUyS7VXbycRSYi
         kpwCMvWQ+qydqJNbcvBfh5AP92ipDqp61ZblnNgdhXWdaWQ6NU8OqERZwq2M1HSqDunC
         E7HQ==
X-Gm-Message-State: AOJu0Ywunc00WXZR1oN4mWeIwx7ZL3ti+mvy+kH30RXE5yck+HTd61Td
        xESYlIW93kkgIKyxHPNv4XGqCQ==
X-Google-Smtp-Source: AGHT+IF2+esa9Q6gVnEqpMdQ6jiaFvZ66jD02ePRHhMaBTrMMqQR+eMYM/3bkmvze/MjJtR0+3h2AQ==
X-Received: by 2002:a2e:8604:0:b0:2b9:ea17:5590 with SMTP id a4-20020a2e8604000000b002b9ea175590mr1867712lji.16.1692207196484;
        Wed, 16 Aug 2023 10:33:16 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id p17-20020a2ea411000000b002b9f9cb8e08sm3588267ljn.21.2023.08.16.10.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:33:16 -0700 (PDT)
Message-ID: <e89b4a5a-e634-45b5-a8dc-cf7d1a968ccc@linaro.org>
Date:   Wed, 16 Aug 2023 19:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mojha@quicinc.com
Cc:     computersforpeace@gmail.com
References: <20230816164641.3371878-1-robimarko@gmail.com>
 <20230816164641.3371878-2-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230816164641.3371878-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2023 18:45, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> Luckily, SDI can be disabled via an SCM call.
> 
> So, lets use the boolean DT property to identify boards that have SDI
> enabled by default and use the SCM call to disable SDI during SCM probe.
> It is important to disable it as soon as possible as we might have a WDT
> assertion at any time which would then leave the board in debug mode,
> thus disabling it during SCM removal is not enough.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
[...]


> +	/*
> +	 * Disable SDI if indicated by DT that it is enabled by default.
> +	 */
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
> +		qcom_scm_disable_sdi();
Should we care about the return value?

Konrad
