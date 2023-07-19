Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB175911F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGSJFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGSJFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:05:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6917C273A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:04:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so9307037a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689757450; x=1692349450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bn+vII7Mq9WTFdjOXCwY94q8vJsw0A4shIloSRXljbU=;
        b=B7682dZs699xn/7kZzG4ZDU4zJ+nxGKmfVE2JA552bBFer03dODdl44VV+3ud30z47
         mLeCQ5jjDM4ELp7F61XfMT05gVNeiDv3xVfXlqbPhFPX5PvBRcIHcYR1+eqtAINSfVvx
         B7p5yFDR1ynu9vxuek20dKQdX/Xgx0o9qH9M3nIYl99JwQSw0rD39W6bzabIduTB3lri
         wBDXk6X28zqfPoI0Iw8wtrh3kdnqxBqujx/Euuo75m10I6YJPEWeDGLqwIop1UiCS1+T
         msP6txshHmMhHQYYJ83RQGyWDzRPfJgEU1fO8oVWtRl3eTDFA3br5NcyLzWo+a8as2ah
         HNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689757450; x=1692349450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bn+vII7Mq9WTFdjOXCwY94q8vJsw0A4shIloSRXljbU=;
        b=OeUhL1LHivIGWmCyfdC/wn2IR47t74FDKkIqgbrXRsW6UR72lBkXPr45bBiVsV/hh3
         FU5Ojpu1pAFkLWI+l7tCBPzxNOhzzCdcs00KKmlOE6CrR5n7dC4vq1DiA6myvYnjymGd
         XhiDGN79IqfKzQHRoBflxM+ul7oii77m/GGaqS2yPImMZz4JnAoROkVclXVbrRkRateT
         byzhDyguFyZqJ6WKyDIPszi4LI+5Y+ML3bgjKuSoKTD8Sgt9rANZIL4GrCrZDb46LbVI
         7OzHiGhI4mzZJSzRwbSWogyUqnzHieUioJBX7xjGKpyPZvd+ssPoSsj8jTHkeaFUkHr6
         oqPQ==
X-Gm-Message-State: ABy/qLbtxpqmcy1CRUF7E6ifCifdGjBi+7phi1qgoayo9iT5MdIpbWkx
        KgQa/4hRP05RWbNC2dcIUWrIZg==
X-Google-Smtp-Source: APBJJlExbynH/rLeFi9Sd72ZvSh2WkU51sI+jaasmEZNOVkLEizGSnTAJyhSRMFVWYxoIXG6pzWQSg==
X-Received: by 2002:aa7:c3cc:0:b0:51d:9605:28fd with SMTP id l12-20020aa7c3cc000000b0051d960528fdmr1637770edr.26.1689757450483;
        Wed, 19 Jul 2023 02:04:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h13-20020aa7c94d000000b0051bec856cb4sm2411493edt.50.2023.07.19.02.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:04:10 -0700 (PDT)
Message-ID: <e864599b-8ca0-d7f4-7337-806cf2549458@linaro.org>
Date:   Wed, 19 Jul 2023 11:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] ARM: dts: exynos: k3g: Add WiFi card support
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230716220644.22158-1-markuss.broks@gmail.com>
 <20230716220644.22158-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230716220644.22158-2-markuss.broks@gmail.com>
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

On 17/07/2023 00:05, Markuss Broks wrote:
> This device has Broadcom BCM4354 WiFi card installed,
> which uses SDIO interface.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---


>  &pinctrl_0 {
>  	s2mps11_irq: s2mps11-irq-pins {
>  		samsung,pins = "gpx0-7";
> @@ -628,6 +652,11 @@ touch_irq: touch-irq-pins {
>  		samsung,pins = "gpx1-6";
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>  	};
> +
> +	wlan_reset: wlan-reset {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

This is a requirement since few months (half a year?).

Best regards,
Krzysztof

