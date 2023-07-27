Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6707651F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjG0LHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjG0LHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:07:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9EFE2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:07:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso9102815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690456045; x=1691060845;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSv1P/O0y/iTncVOKp4LRUTrZxi5LvDPIUCnf56db70=;
        b=DxDBxiNWTRbncvRzsmaNCRmGF52Vhya5e4o4Lpvk2fNozmjKYmB7sznsaolQZfN3gl
         glckPTO6SdYTSH9ydQeQ/Dc8R7neLbDCYEQ8w+raiF5w9RxMSbYRwDEsHI8+4E2Cblih
         +Og4gUc4fEkH3i4doFGYl1H7KpwGRpbvmYmIUtxRpSJBvnCjefWBo5StV0yig+gzqfTa
         WvCw1jpvCpEdxMOWI9IWPUlTBujfh2oNp0q/toD8iH5L7w98yAdyUe0KOd+T0vg1NSdU
         n44qRxxjsQLpBRLpJez/3R5sTyYN2wI5UpYA1RG118LER5LfqTJfqbUCGkuW1SmkIlfc
         DwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456045; x=1691060845;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSv1P/O0y/iTncVOKp4LRUTrZxi5LvDPIUCnf56db70=;
        b=LYt4sIEYaVMMsP5NFg5f6t3hYdvwyLxCjm6yiMw7lB4rRrjQBx7TQEQffh4GNKywvS
         /xeXpKl8eKbTa+70PMmzOjFtNgQqRTyxfh9egp9D8mG+J02Sf90UAJq9kUmoteIzyMA5
         xw6BeaYOWxG7ZagwfYk8MM10pwxEonwc/7rCVbizXJQ1D9JyiS5vBiWJCerf1xQFOXo6
         eQSkxWv1ARJhTqWi8b0BiDG807jlF3AFht8SRNZPg51AkPzVNAcve24xnYnjDnDANiCp
         9JF3cvY7tqxZLKp+B9K6i27W0hu6IvEeM1zCDya0uDZIJRF7sS+c++SjVvaiFx+6PbyJ
         loqg==
X-Gm-Message-State: ABy/qLYrPMR5B0He5KPeZzIwh/A3Ysuw3UpedW4FWg8dVRAhuUtIgzR5
        vz53kHYhFRjQm+TlIxgMu6A44w==
X-Google-Smtp-Source: APBJJlHSW1y2jpIg3DmfOcgPNep89mi+9RAqmGSRoEV6Nt541nF6FdYSNXqmm0o2TO7rA22uTBfSqw==
X-Received: by 2002:a7b:cb58:0:b0:3fc:80a:cf63 with SMTP id v24-20020a7bcb58000000b003fc080acf63mr1589465wmj.38.1690456044908;
        Thu, 27 Jul 2023 04:07:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id p12-20020a7bcc8c000000b003fc00702f65sm4298661wma.46.2023.07.27.04.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:07:24 -0700 (PDT)
Message-ID: <5660c1a5-21ce-ad0a-2488-c3429ea7e995@linaro.org>
Date:   Thu, 27 Jul 2023 13:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] drivers:iio:admv1013: add vcc regulators
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727110121.93546-1-antoniu.miclaus@analog.com>
 <20230727110121.93546-2-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727110121.93546-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 13:01, Antoniu Miclaus wrote:
> Add regulators for the VCC supplies of the admv1013.
> 
> The patch aims to align the implementation with the current admv1014

...

>  	const char *str;
>  	struct spi_device *spi = st->spi;
>  
> @@ -554,6 +567,17 @@ static int admv1013_properties_parse(struct admv1013_state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
>  				     "failed to get the common-mode voltage\n");
>  
> +	for (i = 0; i < ADMV1013_VCC_NUM_REGULATORS; ++i)
> +		st->vcc_regs[i].supply = admv1013_reg_name[i];
> +
> +	ret = devm_regulator_bulk_get(&st->spi->dev,
> +				      ADMV1013_VCC_NUM_REGULATORS,
> +				      st->vcc_regs);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to request VCC regulators");
> +		return ret;

This should be return dev_err_probe, unless this is not called from
probe path.

Best regards,
Krzysztof

