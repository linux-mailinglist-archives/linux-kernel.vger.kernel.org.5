Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42927C88D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJMPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjJMPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:37:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBFCBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:37:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4066692ad35so23400655e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697211428; x=1697816228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5oyTNCPKWdkGABnn1l8QHV8SiFeKXaFhQsDAfS3/jU=;
        b=aym9Nv+PadcwpIrIfwgOZy/3JnjwJl9QdWW8TPf4G1C18L2WdOZOLrFRNGtquy7Mqz
         IoNI4PX0P1WvAX1mCmqQd0N25STgMkpL/5vVrnH8hm12THKmh39MLJ78kYUSo5eNiSpo
         NBKv5R16X4YelqdaompdFyZ+hHZDn2tk/3QHgxXP1pJN6eI5e0XlaR6hGcV1HsatyxWr
         2isteUhGzgBwTg02ciaBtLpDGxiBZDxkoNbS2S5mlpSAU0XJL+3ocghLl3Q8CRPzn71l
         ucOaDVcwWHLdoZsU9Pk5aBdR3zUN7rT1hFeRwtEmkHl0HXtw5gm8ENQiLcbe7eBwpFAF
         C2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211428; x=1697816228;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5oyTNCPKWdkGABnn1l8QHV8SiFeKXaFhQsDAfS3/jU=;
        b=kZwgzCAxhAkBZMW0sy0KoA7/z/ShxYr7rzqDt0SJR+7zBZ/KpsgpnfH0sFRX7KmB3X
         GvUm/qreWjDVVmbW2eUP11vYxEbnAhjXueU40CrOKOwsxjK+CVxMRG797/WExRgx9rru
         jFzi2vuE6DBd1BUs0FnS3zYD3Anx+tral35JEWisdbgW9l2JmhOG3st2TSWsq0OdIDC/
         9EUfncv0cFomqhW5MVBViGP88z8CHbuNnGxhxRlxA3jMiFkArrd40f73SY+q8pkRwsnt
         Z3QyAA8zb5PcOcSd61NoVzRe1+AKT84yal9eQzbKrp00m6Zcn53b5mlzyUv2a3Kj1gjb
         oERg==
X-Gm-Message-State: AOJu0YwiEiL65FEUp7l58l3jqGPLouGuR5m2pJ86IqvvyGKk6cGQo3r+
        nZlU8TNDbtkNUtBfjg5qqiWcXg==
X-Google-Smtp-Source: AGHT+IFI4ILutivv2eLxcQlHbN7zkoPuh7ogi1AL06gLefp4u5sMqFPNWTdX3w2XIt20z9wTmiFJGQ==
X-Received: by 2002:adf:f005:0:b0:321:52fb:5703 with SMTP id j5-20020adff005000000b0032152fb5703mr24943473wro.13.1697211427824;
        Fri, 13 Oct 2023 08:37:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:535e:33c9:c7dd:4940? ([2a01:e0a:982:cbb0:535e:33c9:c7dd:4940])
        by smtp.gmail.com with ESMTPSA id bw14-20020a0560001f8e00b0032d886039easm6912044wrb.14.2023.10.13.08.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:37:07 -0700 (PDT)
Message-ID: <5765a10c-8f75-4bf4-830b-b5fba501d164@linaro.org>
Date:   Fri, 13 Oct 2023 17:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4] tty: serial: meson: fix hard LOCKUP on crtscts mode
Content-Language: en-US, fr
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>,
        Pavel Krasavin <pkrasavin@imaqliq.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <OF55521400.7512350F-ON00258A47.003F7254-00258A47.0040E15C@gdc.ru>
 <20231013141818.adq6eujrx2wueobp@CAB-WSD-L081021>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231013141818.adq6eujrx2wueobp@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 16:18, Dmitry Rokosov wrote:
> I believe it would be necessary to include a 'Fixes' tag for that. Neil,
> what do you think?
> Since a HARDLOCKUP is an undesirable situation, I don't think we want to
> have it in the LTS kernels either.

Yes, and please keep the previous Reviewed-by Dmitry and I added on v3 and send a v5 with the Fixes added.

It should be:
Fixes: ff7693d079e5 ("ARM: meson: serial: add MesonX SoC on-chip uart driver")

Hopefully it will be the last iteration.

Thanks,
Neil
> 
> On Fri, Oct 13, 2023 at 11:48:39AM +0000, Pavel Krasavin wrote:
>> From: Pavel Krasavin <pkrasavin@imaqliq.com>
>>
>> There might be hard lockup if we set crtscts mode on port without RTS/CTS configured:
>>
>> # stty -F /dev/ttyAML6 crtscts; echo 1 > /dev/ttyAML6; echo 2 > /dev/ttyAML6
>> [   95.890386] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [   95.890857] rcu:     3-...0: (201 ticks this GP) idle=e33c/1/0x4000000000000000 softirq=5844/5846 fqs=4984
>> [   95.900212] rcu:     (detected by 2, t=21016 jiffies, g=7753, q=296 ncpus=4)
>> [   95.906972] Task dump for CPU 3:
>> [   95.910178] task:bash            state:R  running task     stack:0     pid:205   ppid:1      flags:0x00000202
>> [   95.920059] Call trace:
>> [   95.922485]  __switch_to+0xe4/0x168
>> [   95.925951]  0xffffff8003477508
>> [   95.974379] watchdog: Watchdog detected hard LOCKUP on cpu 3
>> [   95.974424] Modules linked in: 88x2cs(O) rtc_meson_vrtc
>>
>> Possible solution would be to not allow to setup crtscts on such port.
>>
>> Tested on S905X3 based board.
>>
>> Signed-off-by: Pavel Krasavin <pkrasavin@imaqliq.com>
>> ---
>> v4: More correct patch subject according to Jiri's note
>> v3: https://lore.kernel.org/lkml/OF6CF5FFA0.CCFD0E8E-ON00258A46.00549EDF-00258A46.0054BB62@gdc.ru/
>> "From:" line added to the mail
>> v2: https://lore.kernel.org/lkml/OF950BEF72.7F425944-ON00258A46.00488A76-00258A46.00497D44@gdc.ru/
>> braces for single statement removed according to Dmitry's note
>> v1: https://lore.kernel.org/lkml/OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru/
>> ---
>>
>> --- a/drivers/tty/serial/meson_uart.c	2023-10-12 15:44:02.410538523 +0300
>> +++ b/drivers/tty/serial/meson_uart.c	2023-10-12 15:58:06.242395253 +0300
>> @@ -380,10 +380,14 @@ static void meson_uart_set_termios(struc
>>   	else
>>   		val |= AML_UART_STOP_BIT_1SB;
>>   
>> -	if (cflags & CRTSCTS)
>> -		val &= ~AML_UART_TWO_WIRE_EN;
>> -	else
>> +	if (cflags & CRTSCTS) {
>> +		if (port->flags & UPF_HARD_FLOW)
>> +			val &= ~AML_UART_TWO_WIRE_EN;
>> +		else
>> +			termios->c_cflag &= ~CRTSCTS;
>> +	} else {
>>   		val |= AML_UART_TWO_WIRE_EN;
>> +	}
>>   
>>   	writel(val, port->membase + AML_UART_CONTROL);
>>   
>> @@ -705,6 +709,7 @@ static int meson_uart_probe(struct platf
>>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>>   	int ret = 0;
>>   	int irq;
>> +	bool has_rtscts;
>>   
>>   	if (pdev->dev.of_node)
>>   		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
>> @@ -732,6 +737,7 @@ static int meson_uart_probe(struct platf
>>   		return irq;
>>   
>>   	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
>> +	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
>>   
>>   	if (meson_ports[pdev->id]) {
>>   		return dev_err_probe(&pdev->dev, -EBUSY,
>> @@ -762,6 +768,8 @@ static int meson_uart_probe(struct platf
>>   	port->mapsize = resource_size(res_mem);
>>   	port->irq = irq;
>>   	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
>> +	if (has_rtscts)
>> +		port->flags |= UPF_HARD_FLOW;
>>   	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
>>   	port->dev = &pdev->dev;
>>   	port->line = pdev->id;
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

