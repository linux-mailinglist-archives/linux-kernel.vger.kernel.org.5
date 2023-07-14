Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23207753D63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjGNO3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjGNO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:29:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FE03AB8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:29:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fba86f069bso3364727e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689344949; x=1691936949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7XSLJw52T0/1qLiEhQ2mFyEX8hNR7J0cXAXpzjTkNY=;
        b=Ho4ZjRdLf3WGzWiRolCzfv9gXW/0Psx3vukeJjTNb5OOqvI4xEX5FjRQlTlH0VrjpJ
         5wjUqnQb6BBfGcQgbH2jWkwjmE+jqezpHa3fGY/MyyF49vWlXwIBwJnolKVlDtgT4ofQ
         c8Py9ac1aIzpvUIZQPtCmO7g5IhXcGvq1wOimgli2ibG7uUS60HIgoXFwPVaZspW2Rwq
         kVJUzpAmtRdXbAfMQygzchEnDXSb73F9W+EnelAfBcQkxC6QNfpmiT/95RK27xlhzzhS
         c1LRyhqN/BBobG0bldsWkzljxPCSpFmL9ar1uyYmdtOCz73tJBp46cMikqLPIcHbv9uk
         od0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344949; x=1691936949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7XSLJw52T0/1qLiEhQ2mFyEX8hNR7J0cXAXpzjTkNY=;
        b=Eve3W3Id1czFHLvs5r/Afa0lwV/KwAA4tqgwEQjASJyGDdeLw1IoUjHC62CJVR4dHm
         +HJ2cGJrKJqD6yNsCsKiIGzGEyodvkcNFi6bl8UV+p3nScgLMtfdBLkrZGCUAeOf22D5
         pNv4kPjwpwMbFlPoueU88xD7vqnDTWaoAlLf7cc6pDZzWwdea4UefHssN2t+++0755Zv
         2i+JfMymZGbulhIe5wnKSY9Uc/3g9IP27jP8Td98bh9feppEx6zZnyGVRf/5ticginBY
         HfUZabH2tL1fG45jx+Bp3EpaJWVDJWnZYs/UhWKjsICDzbNNmteBWXc8yXneWctsVNFa
         IIGw==
X-Gm-Message-State: ABy/qLYoXnYMnhNBP8PHeWIfuQuZ58EPRx7pKlS2eIqshZUxJaddUiKt
        Jcy50blITroooPqAEsaHpU17Ow==
X-Google-Smtp-Source: APBJJlFwywm3zM4vbYjAAFhEZVa6kL+w6/fFOY0Ro2l1QhI0tt+F5E2zDMKtpVWsnOkrYMuuTZtsKA==
X-Received: by 2002:a05:6512:3ca5:b0:4f9:6c44:1bf3 with SMTP id h37-20020a0565123ca500b004f96c441bf3mr4529346lfv.62.1689344949598;
        Fri, 14 Jul 2023 07:29:09 -0700 (PDT)
Received: from [192.168.1.101] (abxj146.neoplus.adsl.tpnet.pl. [83.9.3.146])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1506768lfn.168.2023.07.14.07.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:29:09 -0700 (PDT)
Message-ID: <e99b5975-b770-5460-1ce4-cd4eb1a50291@linaro.org>
Date:   Fri, 14 Jul 2023 16:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] serial: qcom-geni: fix opp vote on shutdown
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20230714130214.14552-1-johan+linaro@kernel.org>
 <20230714130214.14552-2-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230714130214.14552-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2023 15:02, Johan Hovold wrote:
> The operating-performance-point vote needs to be dropped when shutting
> down the port to avoid wasting power by keeping resources like power
> domains in an unnecessarily high performance state (e.g. when a UART
> connected Bluetooth controller is not in use).
> 
> Fixes: a5819b548af0 ("tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state")
> Cc: stable@vger.kernel.org      # 5.9
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
I don't know a whole lot about this subsystem, but the PM call has
a pointer to uport which already contains this clock rate.. Is it
zeroed out by the core before we reach it, which would prevent us
from reusing it?

Konrad
>  drivers/tty/serial/qcom_geni_serial.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index b825b05e6137..8be896dbaa88 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -126,6 +126,7 @@ struct qcom_geni_serial_port {
>  	dma_addr_t rx_dma_addr;
>  	bool setup;
>  	unsigned int baud;
> +	unsigned long clk_rate;
>  	void *rx_buf;
>  	u32 loopback;
>  	bool brk;
> @@ -1249,6 +1250,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  			baud * sampling_rate, clk_rate, clk_div);
>  
>  	uport->uartclk = clk_rate;
> +	port->clk_rate = clk_rate;
>  	dev_pm_opp_set_rate(uport->dev, clk_rate);
>  	ser_clk_cfg = SER_CLK_EN;
>  	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
> @@ -1513,10 +1515,13 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  
>  	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
>  		geni_icc_enable(&port->se);
> +		if (port->clk_rate)
> +			dev_pm_opp_set_rate(uport->dev, port->clk_rate);
>  		geni_se_resources_on(&port->se);
>  	} else if (new_state == UART_PM_STATE_OFF &&
>  			old_state == UART_PM_STATE_ON) {
>  		geni_se_resources_off(&port->se);
> +		dev_pm_opp_set_rate(uport->dev, 0);
>  		geni_icc_disable(&port->se);
>  	}
>  }
