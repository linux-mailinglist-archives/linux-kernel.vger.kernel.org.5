Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9981322F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573266AbjLNNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573072AbjLNNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:52:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE1114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:52:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3364a657564so423497f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561959; x=1703166759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZG094W4dIVF1EKcUo638joyg5PWzf0NNJBExtH6MdeE=;
        b=VdUHvjAYm17GgQFNbWiT9C3kGtSC9fO2fbnkgcUk0T5RTlCsREE0jyzWULmLPqhgU+
         fh39Hl9h6gPHDiVJamBiga32l69U8+tFnhOyMP8+i6J2BwBpbdUFZpc7Bj8ZhhlqZRAy
         ktzFT928Kc5GeINswMSOySga6WjiGa8en+pQpY2y7VvfA+ArANGXOQdtDsjHlV6C5xIA
         ANHp5brvSSFkCEoAWHCKMq0wT2CUbeNOTOFgG1sW8l1tziYGx/O3J5gApIvi6w5gIZqZ
         +qPWIE8a7xP3EhE9zJYtnUAWJIp8zDkm4q9zA39D2jwtVlgvCIZzdrNBfQMobhPk4spB
         TQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561959; x=1703166759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG094W4dIVF1EKcUo638joyg5PWzf0NNJBExtH6MdeE=;
        b=GaXJMRn728X6Q1VdmQNPIi2BSs6FFVg6F4p3/gH8KVX9AXbkugKgvqIDQnGTtffg93
         gPu/C2qvih1vhcd2PTNlMcHgG/aA/iNqnNYqxjO2zrBRa1OjwMzn7HNS4gvAm/7EwLLF
         sR3Zr9703VyOtuzErh5NqHSZJTJ+6TzNbUunffrV5mplozAPaLL8GjN5KDNnqHWHudv5
         ejuM2ak9aOf9LhlmIP2/Qjf5+wOy7C+/FnF1RXp22BCqXvODozPTaqV5tb4tzEH3NNFt
         Y7CGAwUPe02nedtAYUH2YMuF2eDzXHzd5ZEYiWBxoQi+/Ge2ux/Uus/YsyyPtKHytY+7
         Mdzw==
X-Gm-Message-State: AOJu0YyXhq9pF47MzJIoC6BtQo6lboTxXVVDhBFuwHEYL2ZWq0fkiWyB
        pRSmRhAXuLslu5vqFqLhURjXmQ==
X-Google-Smtp-Source: AGHT+IHZrLMTXyNjcexxbVAiORtydhgsD0STmbd6hhxBV7J4JR7cRSScr8gTPzn4kfe/zjbQxtcR5g==
X-Received: by 2002:a05:600c:4591:b0:40c:325a:545c with SMTP id r17-20020a05600c459100b0040c325a545cmr4356398wmo.221.1702561959544;
        Thu, 14 Dec 2023 05:52:39 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm9483197ejc.130.2023.12.14.05.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:52:38 -0800 (PST)
Message-ID: <8808ceeb-35dc-4094-aec4-f43c7acd6174@linaro.org>
Date:   Thu, 14 Dec 2023 13:52:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] tty: serial: samsung: add gs101 earlycon support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Peter Griffin <peter.griffin@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, andi.shyti@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        saravanak@google.com, William McVicker <willmcvicker@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-6-tudor.ambarus@linaro.org>
 <1938fcf1-eb5d-4723-a6c6-d2fe2c6dd1c0@app.fastmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1938fcf1-eb5d-4723-a6c6-d2fe2c6dd1c0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 12:01, Arnd Bergmann wrote:

Hi, Arnd,

Thanks for the review!

> On Thu, Dec 14, 2023, at 11:52, Tudor Ambarus wrote:
>> +static int __init gs101_early_console_setup(struct earlycon_device *device,
>> +					    const char *opt)
>> +{
>> +	/* gs101 always expects MMIO32 register accesses. */
>> +	device->port.iotype = UPIO_MEM32;
>> +
>> +	return s5pv210_early_console_setup(device, opt);
>> +}
>> +
>> +OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);
> 
> It looks like this is already done by of_setup_earlycon() based on
> the reg-io-width property. Any idea why it doesn't work with the
> normal s5pv210_early_console_setup() function?
> 

It works if in device tree one specifies the reg-io-width property and
sets it to 4. If the reg-io-width is not specified, the iotype defaults
to UPIO_MEM causing the SError interrupt on gs101 which makes the system
unusable.

Also, if the earlycon comes specified from the kernel params, the
of_setup_earlycon() is no longer called and the earlycon will be set
solely based on the kernel params buffer, thus allowing users to crash
the kernel on wrong earlycon definitions.

If you think the change is fine, I can amend the commit message with the
description from above.

Cheers,
ta
