Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56131806FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378314AbjLFMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:36:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD411F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:36:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1ca24776c3so153567466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701866175; x=1702470975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhP0y3lO/PweF1RfHhFSQDOkyteb+oLvHY0gryFPYWI=;
        b=dztOIm3qEwyrrlAhjghjt/2y0izUrCL3bWee5fMCH5Jbh3nOlDQ3nmYK9hZNMvd2OU
         7iVX4G+DJzm32VKHHUjxWBMlWpff0xVywx8ynP0fGw5jFhYKAKv3/Gce5gvLf1PeYHZx
         ZALYejgBHTLQnPEyQzPYwRCuvPHBCiqhSqvq8iaXuzrKh9H/nAW+IX7r/BdjgRLxVIpy
         No1hc7hrVb8KBZhoEUkH2rExdBkweEDJ6kOdkeOH8yDjx+nw7JOOVWapMdbhy3ef0qLO
         VP7Z3tLvkgipTyj/8wpBusqHVqIBIDGWYbfjtok0rHxaXM408fcxuOo1raBIS2bkho5+
         usCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701866175; x=1702470975;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhP0y3lO/PweF1RfHhFSQDOkyteb+oLvHY0gryFPYWI=;
        b=DPM0gcPFEgU864E1k74SRe+kW0l6CQ12gaP8YNGvR0jso2GCKlQXhJNc+m/9XHJCij
         utNuoNm/W17DyOQ+EX9zdwGuKqY3KmVolOSjhdPYCpFs8xU2QqHnL2BIzlmEyvpxXHBu
         RdEzTrzRIXchPXm61eJmIIBpDEJ+Cuji1b2fEENxCAr071DvUUMraAf7IPIURZL5xYP6
         HNO9PvpzZqEiWEjf43izJ0veYDexytUATR3bXTfrEOabEofZk41tDZ1UZomDhVPrGxtC
         gX+hZl39XZWZD8XfnhQCbTgjRNoFnW9cXpoGm6+T4A0GJ6vcqyHpgGfjNsdkJ9Honc0P
         TxzA==
X-Gm-Message-State: AOJu0YwunqUnGFwlguc6EpIZ1EIl6PFyqYVXZftC4wnImlK/380C27hC
        dsiBbQVAtuLUnnyPW/1rMfr26A==
X-Google-Smtp-Source: AGHT+IEjEppnEL2GoHQL+oSSs+kXp+IGJw6L0InNoVjYIKYoc18xPZI23Uhq0UOlHEKfZ3JBehNE+w==
X-Received: by 2002:a17:906:2201:b0:a1b:6f31:11d8 with SMTP id s1-20020a170906220100b00a1b6f3111d8mr3162054ejs.25.1701866174962;
        Wed, 06 Dec 2023 04:36:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709063c0e00b00a1b7747e3c0sm3944175ejg.151.2023.12.06.04.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:36:13 -0800 (PST)
Message-ID: <701278db-2ea3-49eb-a292-67294d3fdfa5@linaro.org>
Date:   Wed, 6 Dec 2023 13:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        andy@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        KWLIU@nuvoton.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20231206014530.1600151-1-jim.t90615@gmail.com>
 <20231206014530.1600151-4-jim.t90615@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231206014530.1600151-4-jim.t90615@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 02:45, Jim Liu wrote:
> Add Nuvoton BMC NPCM7xx/NPCM8xx sgpio driver support.
> Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
> and parallel to serial IC (HC165), and use APB3 clock to control it.
> This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
> BMC can use this driver to increase 64 GPI pins and 64 GPO pins to use.
> 
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> ---

...

> +	switch (reg) {
> +	case READ_DATA:
> +		return gpio->base + bank->rdata_reg;
> +	case WRITE_DATA:
> +		return gpio->base + bank->wdata_reg;
> +	case EVENT_CFG:
> +		return gpio->base + bank->event_config;
> +	case EVENT_STS:
> +		return gpio->base + bank->event_status;
> +	default:
> +		/* actually if code runs to here, it's an error case */
> +		dev_WARN(true, "Getting here is an error condition");

So you did not even compile your code. v8 and still not built :(

> +	}
> +	return 0;
> +}



Best regards,
Krzysztof

