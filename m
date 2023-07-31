Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E88768B08
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjGaFX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGaFX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:23:58 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855C4E5C;
        Sun, 30 Jul 2023 22:23:57 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so4343655f8f.1;
        Sun, 30 Jul 2023 22:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690781036; x=1691385836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vryNojv3RqjDA3V2jxqovwYCSLoP+ZZsIS+1uL/2TU=;
        b=D+G/sJssXvdXleqyJBK36Iz11j94E4qG9ogg0YCx2njQ+RtlMhdGdtbXmT7r1CQMp1
         uBNcLXMSGzRDUIxhy0HVa4b7HxPmfdvcIEQacL9wo5/e8oCB3vGOyMmwgy/x3LSAWpWv
         wnpROvW2re70lG2GqpAslcX5VyFHQFXeGh6dSD+5Cf+oVhvRsajOl2+nT8PKw2yKThAY
         PPHoXreo7TqIQ32s5pUMizCWIcfXvTOC2ZyktqFppASNDylmJkZi0r7qQl7EqJDGQMfa
         38weOmu5k7KwN02/rkmVY2wpDL5h/voO7dmFEy5WUTg6EfEdjwtwzpVFQUtH6JSr+ASe
         jFwQ==
X-Gm-Message-State: ABy/qLYS1KFMiZmzEq+eH7AgPZ5f1Uml25yUJx7xwNejqFTBBQ7Qe/R4
        ykJWp/zqSylsyIW5kwZdw0E=
X-Google-Smtp-Source: APBJJlGZFto5h5aEn4GUW+22teWY2mjLbDVudBPWDjv23/yptlAKhUCpNS8yPb9HjeH8O6X+1Ml5mQ==
X-Received: by 2002:a5d:500f:0:b0:317:5747:b955 with SMTP id e15-20020a5d500f000000b003175747b955mr5130068wrt.17.1690781035733;
        Sun, 30 Jul 2023 22:23:55 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id k8-20020a056000004800b003141a3c4353sm11889813wrx.30.2023.07.30.22.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 22:23:55 -0700 (PDT)
Message-ID: <51a7f260-59f9-2cd4-9d49-484df00fb3b2@kernel.org>
Date:   Mon, 31 Jul 2023 07:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Clear the error flags by writing
 1 for lpuart32 platforms
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20230731015053.15150-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230731015053.15150-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 07. 23, 3:50, Sherry Sun wrote:
> Do not read the data register to clear the error flags for lpuart32
> platforms, the additional read may cause the receive FIFO underflow
> since the DMA has already read the data register.
> Now all lpuart32 platforms support write 1 to clear those error bits,

What does this "Now" mean? Will this change break some older platforms?

> let's use this method to better clear the error flags.
> 
> Fixes: 42b68768e51b ("serial: fsl_lpuart: DMA support for 32-bit variant")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index f6644c5989d3..f72e1340b47d 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1120,8 +1120,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>   		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
>   
>   		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
> -			/* Read DR to clear the error flags */
> -			lpuart32_read(&sport->port, UARTDATA);
> +			/* Clear the error flags */
> +			lpuart32_write(&sport->port, sr, UARTSTAT);
>   
>   			if (sr & UARTSTAT_PE)
>   				sport->port.icount.parity++;

thanks,
-- 
js
suse labs

