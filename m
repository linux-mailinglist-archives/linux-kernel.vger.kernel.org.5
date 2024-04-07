Return-Path: <linux-kernel+bounces-134539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C382089B2BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB7B1C20F7C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541E3A1C7;
	Sun,  7 Apr 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bi0D92Gq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02237149
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712504926; cv=none; b=cfIMx1J3dpiXPUSLFukjqE4HNGvcJzWKh703Q2B3xquuqV9FEtuNLNUKVtgBv83ZFyVh6RJ462ycWRTOkmw/J4Ejm2MDtPzDNZEyZvSIXSRc+FbGOPgV3vDiudDNY11x73Koop55NNpHhfYk/QVW8G4gocwgzoN0MjeVZ78OX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712504926; c=relaxed/simple;
	bh=xsKSQsmD8DRcseofyxU7B62U2HMohStQvAnbKX7H7rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb1NpQCpOkcUsH8DshKZMX0LWb+nbjV0JFaCQ9caiYZOKCHd2t5nNPPghXRGWUHisvEELbVay+pDR03qMNmGEbfks+V7rbEuauRSpxnOw+G9ED+muLJadfcafovJzMSDZP817azoBvpblUQFyL/eIUyiroBGThPpukLiuc53cFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bi0D92Gq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4165caf9b2dso4169715e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712504921; x=1713109721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13Biiq60U+vj/01+PTs+edDKA38Buyqu8R2xZWb4IGE=;
        b=bi0D92GqIxsaH9NAOygxOppSDkSS+A+N5R1udiaavk/8MRqTAtf18qjR6/3ZTiqEkR
         SOHX38RX0z4nxPgFLaPFuPn7/TCnCR3mz80j4IT3Xiq5cZN8LCF4r2mgo86MWCtOLmrr
         Q64TP4OA54BalqCKvkmAmw/AWg8fWQRnA/1rQX6oBaXCg3GJy7G76Xza+LTx1WQGvF7Q
         +SFoiacX63pqmgKY5nWzuTswjl87xd1TQ1lPXrpFRHJNw35KqSQG16ix6ZyYeolSZp5/
         PglgFt+eZCpGuo28Mt0fCCNmWRPd/ABzVpKxWhoWEKOD5UjIySZF+pPxFikdPgiI2qX+
         MopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712504921; x=1713109721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13Biiq60U+vj/01+PTs+edDKA38Buyqu8R2xZWb4IGE=;
        b=qsrldQ6w5W4ej0FR33cF9lQkG+WqyQA7/UYZTJZbLZYncmXBTxpD4XwCXRyAG6Hzm7
         3XfwiGg9HxnZiq5D72i+KUyheacz46iLe2BKIZCva2Dq9S0/Ks0RT7+WI5lvShHnlnyv
         7z6E7RzEXnXP/ULpZszf5hFMzBAsD44YQdG2wT28fOzPhe1PXa8mzb203gdX8BCQhqqn
         8+Td6H9vg3vpNLrUhQH8beTxmldh6UZZ/pftdSlLUchzVG/0Wgxc2ko5Cu+LHx2+ncyO
         x+if9HTfMFzPU3b38mgC7vPSPUfHOwZzzcj9fBRVbxhz7JP9NEPXbu/CPuRNDkr8O5Wg
         Nciw==
X-Forwarded-Encrypted: i=1; AJvYcCVvXpPUr6R0D8EYxh0ML0TdF/pN9gAkCrvEA/WmBcjGy7Cm/QWRU0MXsqhOgvifaxaz7wQV/8x5utu0RYnsJmpnOFym3Nsg68WLKVeu
X-Gm-Message-State: AOJu0Yxd+f7I8LdegTJDUweP60Rg9hNOgh7tifkz7h1xLc6x/2BrpcKI
	RN44dZ8h1+MmrnHpeSxk9/eY7PNUk/wbvr6PolZZCNaq6dqMEJwDa9FvQk1tKkc=
X-Google-Smtp-Source: AGHT+IEFuw+vcCBZWBBs4gGjpg00+lFoFhWEVuClSkf+L68MqdfkP5CyIDTAaTPSaSUfO15R/UeYZQ==
X-Received: by 2002:a05:600c:4510:b0:415:6e23:28b5 with SMTP id t16-20020a05600c451000b004156e2328b5mr6366458wmo.32.1712504920481;
        Sun, 07 Apr 2024 08:48:40 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b004156b689edfsm10332396wmq.33.2024.04.07.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:48:40 -0700 (PDT)
Date: Sun, 7 Apr 2024 17:48:39 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: don't enable transceiver when probing
Message-ID: <zpgew4xinv5bpewthmwpx6igjw5fcajsj55q67k3q35meheywx@ookucxy5wco4>
References: <20240326122640.706041-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326122640.706041-1-martin@geanix.com>

Hi Martin,

On Tue, Mar 26, 2024 at 01:26:38PM +0100, Martin Hundebøll wrote:
> The m_can driver sets and clears the CCCR.INIT bit during probe (both
> when testing the NON-ISO bit, and when configuring the chip). After
> clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
> affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
> the m_can node is only used for monitoring the bus, as one cannot setup
> listen-only mode before the device is probed.
> 
> Rework the probe flow, so that the CCCR.INIT bit is only cleared when
> upping the device. First, the tcan4x5x driver is changed to stay in
> standby mode during/after probe. This in turn requires changes when
> setting bits in the CCCR register, as its CSR and CSA bits are always
> high in standby mode.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>  drivers/net/can/m_can/m_can.c         | 129 ++++++++++++++------------
>  drivers/net/can/m_can/tcan4x5x-core.c |  14 ++-
>  2 files changed, 79 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 14b231c4d7ec..1ca245846fcd 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -379,38 +379,60 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
>  	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
>  }
>  
> -static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
> +static bool m_can_cccr_wait_bits(struct m_can_classdev *cdev, u32 mask, u32 val)

This function with its arguments reminds me of regmap_update_bits.
m_can_cccr_wait_bits() doesn't sound like a write function IMHO. Maybe
m_can_cccr_update_bits() would be more descriptive. I think the wait
part is not important as it's a hardware detail.

>  {
> -	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
> -	u32 timeout = 10;
> -	u32 val = 0;
> -
> -	/* Clear the Clock stop request if it was set */
> -	if (cccr & CCCR_CSR)
> -		cccr &= ~CCCR_CSR;
> -
> -	if (enable) {
> -		/* enable m_can configuration */
> -		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
> -		udelay(5);
> -		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
> -		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);

This old code is explicitly setting CCCR_INIT first and then continues
to set CCE. Maybe it would be good to do the same thing in the new
m_can_config_enable()? As far as I can see CCCR_INIT is never set
explicitly before starting/stopping the device.

> -	} else {
> -		m_can_write(cdev, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
> -	}
> +	u32 val_before = m_can_read(cdev, M_CAN_CCCR);
> +	u32 val_after = (val_before & ~mask) | val;
> +	size_t tries = 5;

Why are you reducing the timeout/tries from 10 to 5 here?

> +
> +	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT))
> +		dev_warn(cdev->dev,
> +			 "trying to configure device when in normal mode. Expect failures\n");
> +
> +	/* The chip should be in standby mode when changing the CCCR register,
> +	 * and some chips set the CSR and CSA bits when in standby. Furthermore,
> +	 * the CSR and CSA bits should be written as zeros, even when they read
> +	 * ones.
> +	 */
> +	val_after &= ~(CCCR_CSR | CCCR_CSA);
> +
> +	while (tries--) {
> +		u32 val_read;
> +
> +		/* Write the desired value in each try, as setting some bits in
> +		 * the CCCR register require other bits to be set first. E.g.
> +		 * setting the NISO bit requires setting the CCE bit first.
> +		 */

As you state in this comment, CCE has to be set before NISO. Why don't
you do m_can_config_enable() test set NISO and then do
m_can_config_disable()?

> +		m_can_write(cdev, M_CAN_CCCR, val_after);
> +
> +		val_read = m_can_read(cdev, M_CAN_CCCR) & ~(CCCR_CSR | CCCR_CSA);
>  
> -	/* there's a delay for module initialization */
> -	if (enable)
> -		val = CCCR_INIT | CCCR_CCE;
> -
> -	while ((m_can_read(cdev, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
> -		if (timeout == 0) {
> -			netdev_warn(cdev->net, "Failed to init module\n");
> -			return;
> -		}
> -		timeout--;
> -		udelay(1);
> +		if (val_read == val_after)
> +			return true;
> +
> +		usleep_range(1, 5);
>  	}
> +
> +	return false;
> +}
> +
> +static void m_can_config_enable(struct m_can_classdev *cdev)
> +{
> +	/* CCCR_INIT must be set in order to set CCCR_CCE, but access to
> +	 * configuration registers should only be enabled when in standby mode,
> +	 * where CCCR_INIT is always set.
> +	 */
> +	if (!m_can_cccr_wait_bits(cdev, CCCR_CCE, CCCR_CCE))
> +		netdev_err(cdev->net, "failed to enable configuration mode\n");
> +}
> +
> +static void m_can_config_disable(struct m_can_classdev *cdev)
> +{
> +	/* Only clear CCCR_CCE, since CCCR_INIT cannot be cleared while in
> +	 * standby mode
> +	 */
> +	if (!m_can_cccr_wait_bits(cdev, CCCR_CCE, 0))
> +		netdev_err(cdev->net, "failed to disable configuration registers\n");
>  }
>  
>  static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
> @@ -1403,7 +1425,7 @@ static int m_can_chip_config(struct net_device *dev)
>  	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
>  			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
>  
> -	m_can_config_endisable(cdev, true);
> +	m_can_config_enable(cdev);
>  
>  	/* RX Buffer/FIFO Element Size 64 bytes data field */
>  	m_can_write(cdev, M_CAN_RXESC,
> @@ -1521,7 +1543,7 @@ static int m_can_chip_config(struct net_device *dev)
>  		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
>  		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
>  
> -	m_can_config_endisable(cdev, false);
> +	m_can_config_disable(cdev);
>  
>  	if (cdev->ops->init)
>  		cdev->ops->init(cdev);
> @@ -1544,12 +1566,15 @@ static int m_can_start(struct net_device *dev)
>  
>  	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
>  
> -	m_can_enable_all_interrupts(cdev);
> -
>  	if (cdev->version > 30)
>  		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
>  						 m_can_read(cdev, M_CAN_TXFQS));
>  
> +	m_can_enable_all_interrupts(cdev);

Why do you move m_can_enable_all_interrupts() down?

> +
> +	if (!m_can_cccr_wait_bits(cdev, CCCR_INIT, 0))
> +		netdev_err(dev, "failed to enter normal mode\n");

Is this a hard error? Should the start be aborted here?

> +
>  	return 0;
>  }
>  
> @@ -1603,33 +1628,17 @@ static int m_can_check_core_release(struct m_can_classdev *cdev)
>   */
>  static bool m_can_niso_supported(struct m_can_classdev *cdev)
>  {
> -	u32 cccr_reg, cccr_poll = 0;
> -	int niso_timeout = -ETIMEDOUT;
> -	int i;
> +	bool niso_supported;
>  
> -	m_can_config_endisable(cdev, true);
> -	cccr_reg = m_can_read(cdev, M_CAN_CCCR);
> -	cccr_reg |= CCCR_NISO;
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	/* First try to set the NISO bit (which requires the CCE bit too. */
> +	niso_supported = m_can_cccr_wait_bits(cdev, CCCR_NISO | CCCR_CCE,
> +					      CCCR_NISO | CCCR_CCE);
>  
> -	for (i = 0; i <= 10; i++) {
> -		cccr_poll = m_can_read(cdev, M_CAN_CCCR);
> -		if (cccr_poll == cccr_reg) {
> -			niso_timeout = 0;
> -			break;
> -		}
> +	/* Then clear the two bits again. */
> +	if (!m_can_cccr_wait_bits(cdev, CCCR_NISO | CCCR_CCE, 0))
> +		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
>  
> -		usleep_range(1, 5);
> -	}
> -
> -	/* Clear NISO */
> -	cccr_reg &= ~(CCCR_NISO);
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> -
> -	m_can_config_endisable(cdev, false);
> -
> -	/* return false if time out (-ETIMEDOUT), else return true */
> -	return !niso_timeout;
> +	return niso_supported;
>  }
>  
>  static int m_can_dev_setup(struct m_can_classdev *cdev)
> @@ -1694,9 +1703,6 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> -	if (cdev->ops->init)
> -		cdev->ops->init(cdev);
> -
>  	return 0;
>  }
>  
> @@ -1708,7 +1714,8 @@ static void m_can_stop(struct net_device *dev)
>  	m_can_disable_all_interrupts(cdev);
>  
>  	/* Set init mode to disengage from the network */
> -	m_can_config_endisable(cdev, true);
> +	if (!m_can_cccr_wait_bits(cdev, CCCR_INIT, CCCR_INIT))
> +		netdev_err(dev, "failed to enter standby mode\n");
>  
>  	/* set the state as STOPPED */
>  	cdev->can.state = CAN_STATE_STOPPED;
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index a42600dac70d..c9937dc0d700 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -453,10 +453,18 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  		goto out_power;
>  	}
>  
> -	ret = tcan4x5x_init(mcan_class);
> +	tcan4x5x_check_wake(priv);
> +
> +	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
>  	if (ret) {
> -		dev_err(&spi->dev, "tcan initialization failed %pe\n",
> -			ERR_PTR(ret));
> +		dev_err(&spi->dev, "Disabling interrupts failed %pe\n", ERR_PTR(ret));
> +		goto out_power;
> +	}
> +
> +	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_FLAGS,
> +				      TCAN4X5X_CLEAR_ALL_INT);

Why don't you use tcan4x5x_clear_interrupts() here?

Best,
Markus

> +	if (ret) {
> +		dev_err(&spi->dev, "Clearing interrupts failed %pe\n", ERR_PTR(ret));
>  		goto out_power;
>  	}
>  
> -- 
> 2.44.0
> 

