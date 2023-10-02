Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39C07B4BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjJBGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJBGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:51:12 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCE6B0;
        Sun,  1 Oct 2023 23:51:07 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3231df68584so11961668f8f.1;
        Sun, 01 Oct 2023 23:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229465; x=1696834265;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nFZqfI+jWcS8cIk/mrBHo5IV/zNF8lxEsZdaUKQ5us=;
        b=IEGQRxHMew4dpBcP9N4rQxp5YQrjB202Du1lSjkXFUDSuUYYjJsYS8CB+yftQ0M5M8
         sBgXgXRjy8HqkCz3/o6gcnWEXnkKCT3O0tvV3jglXvNH+85cKkQNUXzqqFR8nYnNdVKm
         cpXM7oVLjADWo6wP4B5AYPyojkyjk/z5eLLKl3TP8mYPbt4js3NvCOQD0rE0sOaREe6E
         ucO8+qE3Sowa4LOaKZfEmxw1x+fE0CzOG6vWW0BFto/CZTfbAXngdWRTx0G8aqtnp8Gb
         P/WsRju22ng52GDTIy9XKH/1IlBjc40ActQOyesCVx7G7SUwHtWtv+dE0Y2zK++KfvN5
         Kv1w==
X-Gm-Message-State: AOJu0YxKoqX7KTsXTEtThL7KI5JYW9JuVc0h2GzHClAtuVfGkldQY1u+
        xv2xjNYOnDjCxW1lmK9oS1I=
X-Google-Smtp-Source: AGHT+IG11VJpKH5mFxtCie9vQEshUDrxu/+4DOaLLMSzOcZ4jXSOTxkmewQCZ1Sssa3iaByTZvkomA==
X-Received: by 2002:a5d:628a:0:b0:323:1d8a:3d87 with SMTP id k10-20020a5d628a000000b003231d8a3d87mr10471013wru.4.1696229465165;
        Sun, 01 Oct 2023 23:51:05 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm27066285wrr.45.2023.10.01.23.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 23:51:04 -0700 (PDT)
Message-ID: <68d533d5-dbc8-4be3-a1fc-b3dd28b8f9df@kernel.org>
Date:   Mon, 2 Oct 2023 08:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tty: serial: 8250: Cleanup MOXA configurations in
 8250_pci.c
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-2-crescentcy.hsieh@moxa.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231002015702.30509-2-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02. 10. 23, 3:56, Crescent CY Hsieh wrote:
> To enhance the maintainability of MOXA configurations in 8250_pci.c,
> clean up the code to achieve simplicity, clarity and consistency.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 73 +++++++++++-------------------
>   1 file changed, 26 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 62a9bd30b4db..a010790ccfcd 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1887,10 +1887,10 @@ pci_sunix_setup(struct serial_private *priv,
>   	return setup_port(priv, port, bar, offset, 0);
>   }
>   
> -static int
> -pci_moxa_setup(struct serial_private *priv,
> -		const struct pciserial_board *board,
> -		struct uart_8250_port *port, int idx)
> +static int pci_moxa_setup(struct serial_private *priv,
> +			  const struct pciserial_board *board,
> +			  struct uart_8250_port *port,
> +			  int idx)

You should either change all or none.

>   {
>   	unsigned int bar = FL_GET_BASE(board->flags);
>   	int offset;
> @@ -1958,6 +1958,9 @@ pci_moxa_setup(struct serial_private *priv,
>   #define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
>   #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
>   
> +/* MOXA */
> +#define PCI_VENDOR_ID_MOXA	0x1393

Isn't this a redefinition of the pci-ids.h one?

> +/* MOXA PCIe */
>   #define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
>   #define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
>   #define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
> @@ -2854,9 +2857,9 @@ enum pci_board_num_t {
>   	pbn_titan_2_4000000,
>   	pbn_titan_4_4000000,
>   	pbn_titan_8_4000000,
> -	pbn_moxa8250_2p,
> -	pbn_moxa8250_4p,
> -	pbn_moxa8250_8p,
> +	pbn_moxa_2,
> +	pbn_moxa_4,
> +	pbn_moxa_8,

This should be in a separate patch.

>   };
>   
>   /*
> @@ -3628,19 +3631,19 @@ static struct pciserial_board pci_boards[] = {
>   		.uart_offset	= 0x200,
>   		.first_offset	= 0x1000,
>   	},
> -	[pbn_moxa8250_2p] = {
> +	[pbn_moxa_2] = {
>   		.flags		= FL_BASE1,
>   		.num_ports      = 2,
>   		.base_baud      = 921600,
>   		.uart_offset	= 0x200,
>   	},
> -	[pbn_moxa8250_4p] = {
> +	[pbn_moxa_4] = {
>   		.flags		= FL_BASE1,
>   		.num_ports      = 4,
>   		.base_baud      = 921600,
>   		.uart_offset	= 0x200,
>   	},
> -	[pbn_moxa8250_8p] = {
> +	[pbn_moxa_8] = {
>   		.flags		= FL_BASE1,
>   		.num_ports      = 8,
>   		.base_baud      = 921600,
> @@ -5347,44 +5350,20 @@ static const struct pci_device_id serial_pci_tbl[] = {
>   		pbn_ni8430_4 },
>   
>   	/*
> -	 * MOXA
> +	 * MOXA PCIe
>   	 */
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_2p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_2p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_4p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_4p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_8p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_8p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_8p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_8p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_2p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_4p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_8p },
> -	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_moxa8250_8p },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E),	 0, 0, pbn_moxa_2 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL),	 0, 0, pbn_moxa_2 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),	 0, 0, pbn_moxa_4 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL),	 0, 0, pbn_moxa_4 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), 0, 0, pbn_moxa_8 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), 0, 0, pbn_moxa_8 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),	 0, 0, pbn_moxa_8 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), 0, 0, pbn_moxa_8 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL),	 0, 0, pbn_moxa_2 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),	 0, 0, pbn_moxa_4 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),	 0, 0, pbn_moxa_8 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),	 0, 0, pbn_moxa_8 },

Use PCI_VDEVICE()?


thanks,
-- 
js
suse labs

