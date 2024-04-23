Return-Path: <linux-kernel+bounces-155340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559878AE91C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D52864FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079913793D;
	Tue, 23 Apr 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLyjOYu1"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031BA80040
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881291; cv=none; b=X68o8oYbR0OZAX4JmaepzhzWphrjKwUW3jQecVNGAEYq+vdATuFu3LHL0bLPZGQAh+V2SBjCoQagEFFH7q3vInzy4f3Rr23tCFuqHtDF2qCkbWWDBJBXpBjOhesVswoTCqx5sdjFkDXLGZ3xm5XSF+88VatWBSJI/XEUYTgBf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881291; c=relaxed/simple;
	bh=t/aqj9l6D4oGdOYYNfNJF28vDO2u61VylE1o53rL9Hk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tOrMrE5hSWpVsKs8htSCJjU7CMKsZAS4Lj/i1R5HcPbAMbrKUqrpxMg4DBjYhJZbfoh0m4I9p4lj0roJ/wmRNGqGubkk+XjbLS5e2xZLAgQ3uVEUpGYJBEeyP2dVeJUJyfW0pKZRgpLWFJvZ3aJJGrZCFaRX04F+Wb22s3NOoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kLyjOYu1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a5b68eceeso16252005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713881286; x=1714486086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqvuTZM7igFDZlQNb4hdaTtUbESqUIooaQ5Bj01QpVg=;
        b=kLyjOYu1R6de4TYaFHPdnc2+tlb1Qi6bYSiQwUb8uvEz1GiUJ8LYXBGSXWDO4nrENp
         GGsnxAfV4RTYM0OqmAk8sM0SQP8RiL0v3x/6oYtXkkxO3g0ncsT1AzMQ/rToSEhniDNo
         /L9E1AhiugVakqvI9ZgVb9vg3qtLKClOurxi5W809v0nlwe9TmjHeiHtnRY2aVOeiS5u
         RgtE/MfpGnvHDbw6Bcg0ZQfP3gBzGp7aNnB5IkKRebF3iSokMJILQoeIOdeWVo/YXg29
         5THsE0VqcGe2SGXiFWxN3Xh7voY8+K7AUw6VJ7UX5WHRFWjEhB1jhdgTqLHDSCGscYHc
         Xn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881286; x=1714486086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eqvuTZM7igFDZlQNb4hdaTtUbESqUIooaQ5Bj01QpVg=;
        b=B9BQmER/Az8gCI8EW3zPSP+dEKzb4+J30ePXk+A9AHWNfhzm/UdIpE5pyYrCRkZIx6
         EvkaYxN9vhvyEbMZY8WiVr54qJ/MzNEGqgvWuH1Bshmhs+OwxnDOPwFYapbotuZwBdCC
         Kjus6AwVyo3jybp4H9/Glv0wfknjc6nfEuxhMtcsQ+UiUkLuh3+KL0upYfkkUzjJ754Z
         2xb70jEIW7JyXeuQ9f+Nwqc8kSSRM4Y2sHL8ise1ld2HJzI97HnrLsggwYiSl9A5VJYx
         UZIDLvYf6wbkrC06vAB9APjQFLl5PzvEsNT2Lc13p2NkldWj9d+fQixoYlQ+FVoJw/sv
         RI7A==
X-Forwarded-Encrypted: i=1; AJvYcCW4KXiSLZjwqcqJFr+h4C5lSacAHiBYEtxfXJiMm4QjqHEYg98XK2TqPFaL3fnbqigGLV0Ye1M45hUHNWk8uvx49SO6+r8BdgBcgQ0t
X-Gm-Message-State: AOJu0YwjhDqtS+IZrf1+Z04DyE662mwPB2CSpStMnNCl4c8R58k5Q/cw
	yCIS3Jku0Ud+02D2QtokEmCEhL1Uqc236ToF4uquNj3MrafXlq6sys8IlzlXizQ=
X-Google-Smtp-Source: AGHT+IHKw6RqMukBMqPG6mxvhHjmXnorsMevPNOybd8lQo/Ht1W5X9vcVuYF9b9ElWkxkVWnfVIlMg==
X-Received: by 2002:a05:600c:1da3:b0:41a:3b4f:822a with SMTP id p35-20020a05600c1da300b0041a3b4f822amr4820579wms.29.1713881285939;
        Tue, 23 Apr 2024 07:08:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:dfee:1061:7e39:bfff? ([2a01:e0a:982:cbb0:dfee:1061:7e39:bfff])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00418244d459esm20453876wmo.4.2024.04.23.07.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 07:08:05 -0700 (PDT)
Message-ID: <4813aa76-6ce7-403d-8bff-1fb6e1d3f0a2@linaro.org>
Date: Tue, 23 Apr 2024 16:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] serial: msm: Unify TX and RX DMA paths
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <CGME20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457@eucas1p2.samsung.com>
 <20240423120809.2678030-1-m.szyprowski@samsung.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20240423120809.2678030-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marek,

On 23/04/2024 14:08, Marek Szyprowski wrote:
> Use scatterlist-based API also for RX mode to unify TX and RX DMA paths
> as well as simplify the whole driver code a bit.

Thanks for the patch, I have no idea if this is right or wrong.

Greg, I think we should wait until this change is fully tested on multiple
platforms including DMA usage (bluetooth) before aplying it.

Thanks,
Neil

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/tty/serial/msm_serial.c | 86 +++++++++++++--------------------
>   1 file changed, 34 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 0a9c5219df88..d5e00e613f73 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -161,14 +161,8 @@ enum {
>   struct msm_dma {
>   	struct dma_chan		*chan;
>   	enum dma_data_direction dir;
> -	union {
> -		struct {
> -			dma_addr_t		phys;
> -			unsigned char		*virt;
> -			unsigned int		count;
> -		} rx;
> -		struct scatterlist tx_sg;
> -	};
> +	unsigned char		*virt;
> +	struct scatterlist	sg;
>   	dma_cookie_t		cookie;
>   	u32			enable_bit;
>   	struct dma_async_tx_descriptor	*desc;
> @@ -254,13 +248,7 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
>   	unsigned int mapped;
>   	u32 val;
>   
> -	if (dma->dir == DMA_TO_DEVICE) {
> -		mapped = sg_dma_len(&dma->tx_sg);
> -	} else {
> -		mapped = dma->rx.count;
> -		dma->rx.count = 0;
> -	}
> -
> +	mapped = sg_dma_len(&dma->sg);
>   	dmaengine_terminate_all(dma->chan);
>   
>   	/*
> @@ -275,11 +263,8 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
>   	msm_write(port, val, UARTDM_DMEN);
>   
>   	if (mapped) {
> -		if (dma->dir == DMA_TO_DEVICE) {
> -			dma_unmap_sg(dev, &dma->tx_sg, 1, dma->dir);
> -			sg_init_table(&dma->tx_sg, 1);
> -		} else
> -			dma_unmap_single(dev, dma->rx.phys, mapped, dma->dir);
> +		dma_unmap_sg(dev, &dma->sg, 1, dma->dir);
> +		sg_init_table(&dma->sg, 1);
>   	}
>   }
>   
> @@ -299,7 +284,7 @@ static void msm_release_dma(struct msm_port *msm_port)
>   	if (dma->chan) {
>   		msm_stop_dma(&msm_port->uart, dma);
>   		dma_release_channel(dma->chan);
> -		kfree(dma->rx.virt);
> +		kfree(dma->virt);
>   	}
>   
>   	memset(dma, 0, sizeof(*dma));
> @@ -371,8 +356,8 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
>   
>   	of_property_read_u32(dev->of_node, "qcom,rx-crci", &crci);
>   
> -	dma->rx.virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
> -	if (!dma->rx.virt)
> +	dma->virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
> +	if (!dma->virt)
>   		goto rel_rx;
>   
>   	memset(&conf, 0, sizeof(conf));
> @@ -399,7 +384,7 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
>   
>   	return;
>   err:
> -	kfree(dma->rx.virt);
> +	kfree(dma->virt);
>   rel_rx:
>   	dma_release_channel(dma->chan);
>   no_rx:
> @@ -434,7 +419,7 @@ static void msm_start_tx(struct uart_port *port)
>   	struct msm_dma *dma = &msm_port->tx_dma;
>   
>   	/* Already started in DMA mode */
> -	if (sg_dma_len(&dma->tx_sg))
> +	if (sg_dma_len(&dma->sg))
>   		return;
>   
>   	msm_port->imr |= MSM_UART_IMR_TXLEV;
> @@ -462,12 +447,12 @@ static void msm_complete_tx_dma(void *args)
>   	uart_port_lock_irqsave(port, &flags);
>   
>   	/* Already stopped */
> -	if (!sg_dma_len(&dma->tx_sg))
> +	if (!sg_dma_len(&dma->sg))
>   		goto done;
>   
>   	dmaengine_tx_status(dma->chan, dma->cookie, &state);
>   
> -	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> +	dma_unmap_sg(port->dev, &dma->sg, 1, dma->dir);
>   
>   	val = msm_read(port, UARTDM_DMEN);
>   	val &= ~dma->enable_bit;
> @@ -478,9 +463,9 @@ static void msm_complete_tx_dma(void *args)
>   		msm_write(port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
>   	}
>   
> -	count = sg_dma_len(&dma->tx_sg) - state.residue;
> +	count = sg_dma_len(&dma->sg) - state.residue;
>   	uart_xmit_advance(port, count);
> -	sg_init_table(&dma->tx_sg, 1);
> +	sg_init_table(&dma->sg, 1);
>   
>   	/* Restore "Tx FIFO below watermark" interrupt */
>   	msm_port->imr |= MSM_UART_IMR_TXLEV;
> @@ -503,16 +488,16 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>   	int ret;
>   	u32 val;
>   
> -	sg_init_table(&dma->tx_sg, 1);
> -	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, count);
> +	sg_init_table(&dma->sg, 1);
> +	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->sg, 1, count);
>   
> -	mapped = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> +	mapped = dma_map_sg(port->dev, &dma->sg, 1, dma->dir);
>   	if (!mapped) {
>   		ret = -EIO;
>   		goto zero_sg;
>   	}
>   
> -	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
> +	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->sg, 1,
>   						DMA_MEM_TO_DEV,
>   						DMA_PREP_INTERRUPT |
>   						DMA_PREP_FENCE);
> @@ -550,9 +535,9 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>   	dma_async_issue_pending(dma->chan);
>   	return 0;
>   unmap:
> -	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> +	dma_unmap_sg(port->dev, &dma->sg, 1, dma->dir);
>   zero_sg:
> -	sg_init_table(&dma->tx_sg, 1);
> +	sg_init_table(&dma->sg, 1);
>   	return ret;
>   }
>   
> @@ -569,7 +554,7 @@ static void msm_complete_rx_dma(void *args)
>   	uart_port_lock_irqsave(port, &flags);
>   
>   	/* Already stopped */
> -	if (!dma->rx.count)
> +	if (!sg_dma_len(&dma->sg))
>   		goto done;
>   
>   	val = msm_read(port, UARTDM_DMEN);
> @@ -586,14 +571,13 @@ static void msm_complete_rx_dma(void *args)
>   
>   	port->icount.rx += count;
>   
> -	dma->rx.count = 0;
> -
> -	dma_unmap_single(port->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
> +	dma_unmap_sg(port->dev, &dma->sg, 1, dma->dir);
> +	sg_init_table(&dma->sg, 1);
>   
>   	for (i = 0; i < count; i++) {
>   		char flag = TTY_NORMAL;
>   
> -		if (msm_port->break_detected && dma->rx.virt[i] == 0) {
> +		if (msm_port->break_detected && dma->virt[i] == 0) {
>   			port->icount.brk++;
>   			flag = TTY_BREAK;
>   			msm_port->break_detected = false;
> @@ -604,9 +588,9 @@ static void msm_complete_rx_dma(void *args)
>   		if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
>   			flag = TTY_NORMAL;
>   
> -		sysrq = uart_prepare_sysrq_char(port, dma->rx.virt[i]);
> +		sysrq = uart_prepare_sysrq_char(port, dma->virt[i]);
>   		if (!sysrq)
> -			tty_insert_flip_char(tport, dma->rx.virt[i], flag);
> +			tty_insert_flip_char(tport, dma->virt[i], flag);
>   	}
>   
>   	msm_start_rx_dma(msm_port);
> @@ -630,14 +614,13 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
>   	if (!dma->chan)
>   		return;
>   
> -	dma->rx.phys = dma_map_single(uart->dev, dma->rx.virt,
> -				   UARTDM_RX_SIZE, dma->dir);
> -	ret = dma_mapping_error(uart->dev, dma->rx.phys);
> -	if (ret)
> +	sg_init_one(&dma->sg, dma->virt, UARTDM_RX_SIZE);
> +	ret = dma_map_sg(uart->dev, &dma->sg, 1, dma->dir);
> +	if (!ret)
>   		goto sw_mode;
>   
> -	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->rx.phys,
> -						UARTDM_RX_SIZE, DMA_DEV_TO_MEM,
> +	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->sg, 1,
> +						DMA_DEV_TO_MEM,
>   						DMA_PREP_INTERRUPT);
>   	if (!dma->desc)
>   		goto unmap;
> @@ -664,8 +647,6 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
>   
>   	msm_write(uart, msm_port->imr, MSM_UART_IMR);
>   
> -	dma->rx.count = UARTDM_RX_SIZE;
> -
>   	dma_async_issue_pending(dma->chan);
>   
>   	msm_write(uart, MSM_UART_CR_CMD_RESET_STALE_INT, MSM_UART_CR);
> @@ -684,7 +665,8 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
>   
>   	return;
>   unmap:
> -	dma_unmap_single(uart->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
> +	dma_unmap_sg(uart->dev, &dma->sg, 1, dma->dir);
> +	sg_init_table(&dma->sg, 1);
>   
>   sw_mode:
>   	/*
> @@ -967,7 +949,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
>   	}
>   
>   	if (misr & (MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE)) {
> -		if (dma->rx.count) {
> +		if (sg_dma_len(&dma->sg)) {
>   			val = MSM_UART_CR_CMD_STALE_EVENT_DISABLE;
>   			msm_write(port, val, MSM_UART_CR);
>   			val = MSM_UART_CR_CMD_RESET_STALE_INT;


