Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FB2753D39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjGNO0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjGNO0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:26:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E181989
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:26:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso3394753e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689344779; x=1691936779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1MktFbHOOv+Kn/FxXrHSBEsV3/kw33vL9amAL3fXC8=;
        b=CgcwxqQ/sADRzMb2kghXATgBzjxErwHL3/rP0GEyaHKS9a2SaTw1z/lzHUhFWg//kx
         ovGtIsIzXIq8QI+7d+tOR8tsXJDp5irssNG3JBYbe7V0UpSflSV9CNWOoaVcaHG0P2/2
         alhMQ4JPVp47GeQnN/T70wbulWefQdrEHyTe4B3fJBH9l7Sh730Tfm1r7fjPWURL4O+y
         YRtg6ckpJKoBgStEE+ViFfAshq6nRkbLMv/HBiunon6lZkZvt7sOpedXpVN70ZjEH6xG
         ueZqkWjH1QQK2QpRYIMXZmV5CJDZ0oPFiebC+VSBwwxeKe+wshtwUAZXKPyxz2Y8oRoc
         bCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344779; x=1691936779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1MktFbHOOv+Kn/FxXrHSBEsV3/kw33vL9amAL3fXC8=;
        b=OuSVkKVpep4opVuCAtIqimcX6TyFtP7mC3vjsmFkMi0KWDrW6MDGkfZlc5NVb7Xm16
         J9n2PUMG8jNEdiTIw/vWXHjg3zXkDyZzxcTc3qjNJUeD3+5NxqZQ/LyiR1Vmx/rqAKVM
         S13SjCblt5jg0qJ4Ci81HY0OmWDXXZpLtXPi0eFKEbvUT5BtD2S3ziWTEz/meoYFIrqW
         H1rLPncKmxE+CJi+ndLcvqVAVSU4/AbUh1Q+b5q6QdGb6oi81dFvii501vbXDXamuXEz
         cTUcusRQGStq5ByuCnseX5y9s5zZWeIpPMUMWC9WKVUAw7vJAPsqxnDKA4rqGGHjhzoV
         ddHA==
X-Gm-Message-State: ABy/qLYHszrLeX61k51vHWdSdOEQYbBraqtUuJ42RXfQeLGaYIYSffj3
        FDV3bXHr5Y5HF9z0Ja5yLRxRlQ==
X-Google-Smtp-Source: APBJJlHDSPIBujDxycbxSwnbbwHAuTOd5PJlJSnYMLtChpucdw9HiE87LhLhD1jRigM5LrXksOdm9A==
X-Received: by 2002:ac2:4e05:0:b0:4f8:7513:8cac with SMTP id e5-20020ac24e05000000b004f875138cacmr4256090lfr.48.1689344778900;
        Fri, 14 Jul 2023 07:26:18 -0700 (PDT)
Received: from [192.168.1.101] (abxj146.neoplus.adsl.tpnet.pl. [83.9.3.146])
        by smtp.gmail.com with ESMTPSA id w18-20020a19c512000000b004fcdea15de2sm186577lfe.309.2023.07.14.07.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:26:18 -0700 (PDT)
Message-ID: <d73d0281-14fc-222f-e28d-cd49aced8768@linaro.org>
Date:   Fri, 14 Jul 2023 16:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] serial: qcom-geni: clean up clock-rate debug printk
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230714130214.14552-1-johan+linaro@kernel.org>
 <20230714130214.14552-3-johan+linaro@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230714130214.14552-3-johan+linaro@kernel.org>
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

On 14.07.2023 15:02, Johan Hovold wrote:
> Make the clock-rate debug printk more readable by using an equal sign
> instead of a dash as separator between names and values and adding some
> spaces:
> 
> 	qcom_geni_serial 988000.serial: desired_rate = 1843200, clk_rate = 7372800, clk_div = 4
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 8be896dbaa88..753ac68d03a6 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1246,7 +1246,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  		goto out_restart_rx;
>  	}
>  
> -	dev_dbg(port->se.dev, "desired_rate-%u, clk_rate-%lu, clk_div-%u\n",
> +	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
>  			baud * sampling_rate, clk_rate, clk_div);
>  
>  	uport->uartclk = clk_rate;
