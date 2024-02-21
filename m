Return-Path: <linux-kernel+bounces-74483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2BD85D509
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBBF1C23C33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03BB4CB20;
	Wed, 21 Feb 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CmKjDyny"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F34C61B;
	Wed, 21 Feb 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509272; cv=none; b=lys0VGLjXYoj47V6Q8zCjWv48rIbVUVHrylavSTxj194fBIGBktE908AcPZPKX1fShlo7sN75EWaptGKFatnBZWQMktBEzH+VicoeHVnQNBokK0EVz0psWDetruN9DizNtCbTybahwPowIjy1ugCVxNpIrb174J2+m2L5GlUS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509272; c=relaxed/simple;
	bh=D4a6qDhm/r1zitj6K4QT5PaTygu+/3cz0YZaNV8v6hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZCwPbDh2mQLCd/rJfkDWS56niQxqsp/JzjgHZSc0fxaAycD79SBfmi4VkGSD/o3sfqTpi1qNBFh06ohb7frcCTpq3puTNaMDXyufjoosgDnqdKKYhivzNhyTFJ2RSkMq1jPuEBuQy3BZhkrQBircvstgO+sd7AZZLP6wt0Jxdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CmKjDyny; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L7H87L021527;
	Wed, 21 Feb 2024 10:54:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=tGWKi3XRrYtmuARfCajUNkylogiWFbJvSMiv0BOvGE0=; b=Cm
	KjDyny3E82jh462D50nD6iH3WH8IaDkECoKy3+F033mPxLSmyHaUAygGk1paftxf
	MdF55AHvDGSZCeDkJW/NX1eyDd7G60FM75zwN9VQH4FtsyP1Np+yGhRaOCRrH3k2
	Mo9dw/mXq3vDQ8AvOC8s1PkuL+No2LCrlfX+dY8fJL9zQ4qxywJ+oLKNkA1lKiXe
	9bQX1nPAeNNote3eo1xc2jvtmV9FnPg+0FhXwiUL1CjPIREecsoC4koOcKLcubwY
	k/GZM3Azom3PgBwKH2L0+7c2tGXM9oHcQhtAIvVFuLRWITnPFx63KBf1eSJrSSC7
	ygbIBPzWT4bfebdCkVsg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wd202tjj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:54:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 801B540051;
	Wed, 21 Feb 2024 10:53:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5ADB232FEA;
	Wed, 21 Feb 2024 10:53:13 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 21 Feb
 2024 10:53:13 +0100
Message-ID: <b381cb72-943d-473f-b2f2-eb288132aaac@foss.st.com>
Date: Wed, 21 Feb 2024 10:53:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: st-asc: don't get/put GPIOs in atomic context
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij
	<linus.walleij@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240220113410.16613-1-brgl@bgdev.pl>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240220113410.16613-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02



On 2/20/24 12:34, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Since commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with
> SRCU") gpiod_set_consumer_name() calls synchronize_srcu() which led to
> a "sleeping in atomic context" smatch warning.
> 
> This function (along with gpiod_get/put() and all other GPIO APIs apart
> from gpiod_get/set_value() and gpiod_direction_input/output()) should
> have never been called with a spinlock taken. We're only fixing this now
> as GPIOLIB has been rebuilt to use SRCU for access serialization which
> uncovered this problem.
> 
> Move the calls to gpiod_get/put() outside the spinlock critical section.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-gpio/deee1438-efc1-47c4-8d80-0ab2cf01d60a@moroto.mountain/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v2 -> v3:
> - we only need to change the GPIO configuration for RTS in certain situations
>   so use a separate variable for storing that information; if we don't then we
>   may end up putting the descriptor when setting a different option
> - I dropped Linus tag as the code change significantly
> 
> v1 -> v2:
> - initialize the 'manual_rts' variable to false as we don't always get to
>   the place where it's set
> 
>  drivers/tty/serial/st-asc.c | 40 ++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index bbb5595d7e24..a23e59551848 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -465,6 +465,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
>  			    const struct ktermios *old)
>  {
>  	struct asc_port *ascport = to_asc_port(port);
> +	bool manual_rts, toggle_rts = false;
>  	struct gpio_desc *gpiod;
>  	unsigned int baud;
>  	u32 ctrl_val;
> @@ -518,25 +519,13 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  		/* If flow-control selected, stop handling RTS manually */
>  		if (ascport->rts) {
> -			devm_gpiod_put(port->dev, ascport->rts);
> -			ascport->rts = NULL;
> -
> -			pinctrl_select_state(ascport->pinctrl,
> -					     ascport->states[DEFAULT]);
> +			toggle_rts = true;
> +			manual_rts = false;
>  		}
>  	} else {
>  		/* If flow-control disabled, it's safe to handle RTS manually */
> -		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL]) {
> -			pinctrl_select_state(ascport->pinctrl,
> -					     ascport->states[NO_HW_FLOWCTRL]);
> -
> -			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
> -			if (!IS_ERR(gpiod)) {
> -				gpiod_set_consumer_name(gpiod,
> -						port->dev->of_node->name);
> -				ascport->rts = gpiod;
> -			}
> -		}
> +		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
> +			manual_rts = toggle_rts = true;
>  	}
>  
>  	if ((baud < 19200) && !ascport->force_m1) {
> @@ -595,6 +584,25 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
>  	asc_out(port, ASC_CTL, (ctrl_val | ASC_CTL_RUN));
>  
>  	uart_port_unlock_irqrestore(port, flags);
> +
> +	if (toggle_rts) {
> +		if (manual_rts) {
> +			pinctrl_select_state(ascport->pinctrl,
> +					     ascport->states[NO_HW_FLOWCTRL]);
> +
> +			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
> +			if (!IS_ERR(gpiod)) {
> +				gpiod_set_consumer_name(gpiod,
> +							port->dev->of_node->name);
> +				ascport->rts = gpiod;
> +			}
> +		} else {
> +				devm_gpiod_put(port->dev, ascport->rts);
> +				ascport->rts = NULL;
> +				pinctrl_select_state(ascport->pinctrl,
> +						     ascport->states[DEFAULT]);
> +		}
> +	}
>  }
>  
>  static const char *asc_type(struct uart_port *port)

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

