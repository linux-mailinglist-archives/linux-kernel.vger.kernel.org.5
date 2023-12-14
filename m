Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6881358A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573954AbjLNQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573950AbjLNQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:01:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B10E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:01:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so10472259a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702569682; x=1703174482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+VFIozAF30zEgKKxFDP3drI06z9zzmO3HV6m4SuiwQ=;
        b=Guk+6gL5FvgbClXZhAqmyYzGq5UH6OfIyUvODkVmFf4vSY3etzuNxe3FtrN7amNL04
         iJbmutKwh+6hUZ7JmeXeaqXqTI8sdd2Bj6lpYFplcA5aJFuSnWQk0ii/jrfMdbifEcnX
         MJMuT8B9XAOKq77C1E6lcI3zFiUh/anFfrNMt6sj7FdMIEvtpdw8zM9w7Cwej01TVWFS
         Et7KTSugVOS4dY8Rwiadpp2X62ezw1yHN9/B1Hp5Ahy2iuMdlah+kQ1BzrZ2OyOZT1Jz
         TKZF2a7uh/FelkBbsieLNB52aPJZdhETqALxPQYlRgUwfsoUkvo1bDNnlomKJ3QeEuXc
         HtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569682; x=1703174482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+VFIozAF30zEgKKxFDP3drI06z9zzmO3HV6m4SuiwQ=;
        b=eQFBDxccJStwRuIwSmFT3h/+jkvrFUta0/35iS0Rg77NQdQ5ykGdh4WcrliZf3U/8W
         ll7WRZ3TZlGC6ap6upZ1jfD9yqQ9gjruQ3GZ4Gh2X0Lbo+LWrZwHglfnT/7YL4gkDC1S
         T7oYMS0bfhfCDsPfgzZ2qwUxZaEdNJSyFX+cdcdUl3BCFdBmPCzoTNqJQmxADj0C6Zmw
         7nBGQRkpmUEXNQG0XmRERxc3NvEfLctJt0KsJDjgK3xxNSDZGQlP/wCDofXFj1aQXIn2
         L+mYV31StdmwfcWp/QkQv8zKmJEYjYlPu7cBtrPSBnYoFyyUyQgvpctGuKLIinKXFgbq
         hsrw==
X-Gm-Message-State: AOJu0YxqGJmPm8rTrLi9617ioNfVWHH/bo0oSY2r+WoJFEOEmlTCbUPu
        Fs2gK2hqT/daU/YBuBkbvCwPAg==
X-Google-Smtp-Source: AGHT+IEMYj7NZTyAlbSayhibN+bIajeem6cYXSSO7+k3rveUzLz3uWXFda+obxiUgnN1c1X2yJymPw==
X-Received: by 2002:a17:907:7ea1:b0:a1e:9d8b:1e7b with SMTP id qb33-20020a1709077ea100b00a1e9d8b1e7bmr6017626ejc.69.1702569682045;
        Thu, 14 Dec 2023 08:01:22 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a1df88cc7c0sm9445638ejc.182.2023.12.14.08.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:01:21 -0800 (PST)
Message-ID: <f3d61c49-1a46-476c-b7a5-6cc6a06a33ed@linaro.org>
Date:   Thu, 14 Dec 2023 16:01:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] clk: samsung: gs101: mark PERIC0 IP TOP gate clock
 as critical
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-8-tudor.ambarus@linaro.org>
 <CAPLW+4mNjCbJ+VbKR66DFSkiXHyxdjgvwjN7azxjJQ6UxQikEw@mail.gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mNjCbJ+VbKR66DFSkiXHyxdjgvwjN7azxjJQ6UxQikEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 15:37, Sam Protsenko wrote:
> On Thu, Dec 14, 2023 at 4:52 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Testing USI8 I2C with an eeprom revealed that when the USI8 leaf clock
>> is disabled it leads to the CMU_TOP PERIC0 IP gate clock disablement,
>> which then makes the system hang. To prevent this, mark
>> CLK_GOUT_CMU_PERIC0_IP as critical. Other clocks will be marked
>> accordingly when tested.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/clk/samsung/clk-gs101.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
>> index 3d194520b05e..08d80fca9cd6 100644
>> --- a/drivers/clk/samsung/clk-gs101.c
>> +++ b/drivers/clk/samsung/clk-gs101.c
>> @@ -1402,7 +1402,7 @@ static const struct samsung_gate_clock cmu_top_gate_clks[] __initconst = {
>>              "mout_cmu_peric0_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC0_BUS,
>>              21, 0, 0),
>>         GATE(CLK_GOUT_CMU_PERIC0_IP, "gout_cmu_peric0_ip", "mout_cmu_peric0_ip",
>> -            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, 0, 0),
>> +            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, CLK_IS_CRITICAL, 0),
> 
> This clock doesn't seem like a leaf clock. It's also not a bus clock.
> Leaving it always running makes the whole PERIC0 CMU clocked, which
> usually should be avoided. Is it possible that the system freezes
> because some other clock (which depends on peric0_ip) gets disabled as
> a consequence of disabling peric0_ip? Maybe it's some leaf clock which
> is not implemented yet in the clock driver? Just looks weird to me
> that the system hangs because of CMU IP clock disablement. It's
> usually something much more specific.

The system hang happened when I tested USI8 in I2C configuration with an
eeprom. After the eeprom is read the leaf gate clock that gets disabled
is the one on PERIC0 (CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK). I assume
this leads to the CMU_TOP gate (CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP)
disablement which makes the system hang. Either marking the CMU_TOP gate
clock as critical (as I did in this patch) or marking the leaf PERIC0
gate clock as critical, gets rid of the system hang. Did I choose wrong?

Thanks,
ta
> 
>>         GATE(CLK_GOUT_CMU_PERIC1_BUS, "gout_cmu_peric1_bus",
>>              "mout_cmu_peric1_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC1_BUS,
>>              21, 0, 0),
>> --
>> 2.43.0.472.g3155946c3a-goog
>>
