Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F47C7EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjJMHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjJMHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:51:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF40B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:51:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso18433075e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183484; x=1697788284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGLLNmMEIoHetPjQdGeJ01Fu1b8ChkbYllNK8qDfC4A=;
        b=loMoCZhhMObEiOI3kkUu1WaCtSld/JgLIS8554/9FAgZ1oM3LHJV91dqNcJKNRuyVr
         l2XP5dH0g46uQQjsWs3MDuKu59L7advxIREkxNXsidDPfJndDE3AjXJdjQH0TWrqXjzv
         Z+k4hKEPjUd0cZrfvV8eCcxBPejQs0zdSMHxIhieTCA+69SbhJWuELaR3qAA8F8Q2ceJ
         Tt2Ne6KUjOpIyaAGs/Oq3NzW2+WiP2Mp6cb1C7zMYkyemvPEf+2thVMo+99UgF3HpTL4
         gBrbpxT4UY1/EUZ5GqtEvwQLHBiiacoF+7L/yuW9EsKzoC767Jl5wGVuDwLh47OkLolv
         CB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183484; x=1697788284;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QGLLNmMEIoHetPjQdGeJ01Fu1b8ChkbYllNK8qDfC4A=;
        b=QlMzX4wGs+smiEEJ+HTIiat+l7dgHeilYRkPUgzNPya7aJI0ElhqltsPVLOeuTMe06
         ltyho3lgZaxcJVRztfe2V/C4zysIxqSzXgiPle/04qKU0aE3+mIh4ygmt0e4DmF/4Igw
         xCTx7p8kJI0B2gkmHvnOML0zB4ZIR24bjr+p78YhNyOnWOHgc3YpnNEwYN+TWvBm8pQ/
         PBvllP+Dr9t7EV7uHx3/cxdQUK6N26DojJwG8zcwcbBARJen/fm1MZ4NESk8vdpL4QM8
         j9o8cy1rXDB4vRboGDjCHmpXwkZ6xqcbO4Fg2yh78pfUV1VtxPS4bRJrSePzoTp/JR5V
         PL7g==
X-Gm-Message-State: AOJu0Yyn+mrC+ECY4dRwWPUEGXVNujuGlj4PFYMZWHPlbKj25zDqVBiz
        t5ZWqxqv/65M8tb5yPPcLwtn3A==
X-Google-Smtp-Source: AGHT+IELG391V1Ud7elbQt4QWMSF5GEdV2anomcs+s+Wryke+mq9djUBHEODiUiryn2RFZg18FUapQ==
X-Received: by 2002:a05:600c:ac1:b0:405:39b4:3145 with SMTP id c1-20020a05600c0ac100b0040539b43145mr23450412wmr.2.1697183484112;
        Fri, 13 Oct 2023 00:51:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:535e:33c9:c7dd:4940? ([2a01:e0a:982:cbb0:535e:33c9:c7dd:4940])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b00401b242e2e6sm1783318wmj.47.2023.10.13.00.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 00:51:23 -0700 (PDT)
Message-ID: <39193720-d105-47c0-8475-3e321f7095b5@linaro.org>
Date:   Fri, 13 Oct 2023 09:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] tty: serial: meson: hard LOCKUP on crtscts mode
Content-Language: en-US, fr
To:     Pavel Krasavin <pkrasavin@imaqliq.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <OF6CF5FFA0.CCFD0E8E-ON00258A46.00549EDF-00258A46.0054BB62@gdc.ru>
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
In-Reply-To: <OF6CF5FFA0.CCFD0E8E-ON00258A46.00549EDF-00258A46.0054BB62@gdc.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 17:25, Pavel Krasavin wrote:
> From: Pavel Krasavin <pkrasavin@imaqliq.com>
> 
> There might be hard lockup if we set crtscts mode on port without RTS/CTS configured:
> 
> # stty -F /dev/ttyAML6 crtscts; echo 1 > /dev/ttyAML6; echo 2 > /dev/ttyAML6
> [   95.890386] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   95.890857] rcu:     3-...0: (201 ticks this GP) idle=e33c/1/0x4000000000000000 softirq=5844/5846 fqs=4984
> [   95.900212] rcu:     (detected by 2, t=21016 jiffies, g=7753, q=296 ncpus=4)
> [   95.906972] Task dump for CPU 3:
> [   95.910178] task:bash            state:R  running task     stack:0     pid:205   ppid:1      flags:0x00000202
> [   95.920059] Call trace:
> [   95.922485]  __switch_to+0xe4/0x168
> [   95.925951]  0xffffff8003477508
> [   95.974379] watchdog: Watchdog detected hard LOCKUP on cpu 3
> [   95.974424] Modules linked in: 88x2cs(O) rtc_meson_vrtc
> 
> Possible solution would be to not allow to setup crtscts on such port.
> 
> Tested on S905X3 based board.
> 
> Signed-off-by: Pavel Krasavin <pkrasavin@imaqliq.com>
> ---
> v3: "From:" line added to the mail
> v2: https://lore.kernel.org/lkml/OF950BEF72.7F425944-ON00258A46.00488A76-00258A46.00497D44@gdc.ru/
> braces for single statement removed according to Dmitry's note
> v1: https://lore.kernel.org/lkml/OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru/
> ---
> 
> --- a/drivers/tty/serial/meson_uart.c	2023-10-12 15:44:02.410538523 +0300
> +++ b/drivers/tty/serial/meson_uart.c	2023-10-12 15:58:06.242395253 +0300
> @@ -380,10 +380,14 @@ static void meson_uart_set_termios(struc
>   	else
>   		val |= AML_UART_STOP_BIT_1SB;
>   
> -	if (cflags & CRTSCTS)
> -		val &= ~AML_UART_TWO_WIRE_EN;
> -	else
> +	if (cflags & CRTSCTS) {
> +		if (port->flags & UPF_HARD_FLOW)
> +			val &= ~AML_UART_TWO_WIRE_EN;
> +		else
> +			termios->c_cflag &= ~CRTSCTS;
> +	} else {
>   		val |= AML_UART_TWO_WIRE_EN;
> +	}
>   
>   	writel(val, port->membase + AML_UART_CONTROL);
>   
> @@ -705,6 +709,7 @@ static int meson_uart_probe(struct platf
>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>   	int ret = 0;
>   	int irq;
> +	bool has_rtscts;
>   
>   	if (pdev->dev.of_node)
>   		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> @@ -732,6 +737,7 @@ static int meson_uart_probe(struct platf
>   		return irq;
>   
>   	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
> +	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
>   
>   	if (meson_ports[pdev->id]) {
>   		return dev_err_probe(&pdev->dev, -EBUSY,
> @@ -762,6 +768,8 @@ static int meson_uart_probe(struct platf
>   	port->mapsize = resource_size(res_mem);
>   	port->irq = irq;
>   	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
> +	if (has_rtscts)
> +		port->flags |= UPF_HARD_FLOW;
>   	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
>   	port->dev = &pdev->dev;
>   	port->line = pdev->id;

Looks fine, I expected the tty core to check uart-has-rtscts or UPF_HARD_FLOW, but seems I was naive.

LGTM
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
