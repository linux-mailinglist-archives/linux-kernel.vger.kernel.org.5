Return-Path: <linux-kernel+bounces-156762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D898B07D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C9E1C21B37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E615A4A6;
	Wed, 24 Apr 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mw3bahsQ"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD815959D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956242; cv=none; b=EUIgDZIrecjSKAYa/LdXrJ4/Nym1K0IYCO+sCwqFsCnc1nFZJPLswPYIZ4KegvjJqWGp8wnM/nmM17/QeE85gDUao4rKBZeDQRQqYEcH6/4PHbmqnHu3iNzINGOCHc/cOLekA2txEnqvlq4xNE+BCJrbzIeo/o7V98uG6ntFXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956242; c=relaxed/simple;
	bh=PeM+NrtL9hoMBw7MMty0ssnWnFf1zpWwc1ZkuqMUVLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOcdXIRDQmLIVR8/gLMPYAWfKSyd9/jVn8nhe+doqvJ2Y6ZdPEeRe3ENwRaDQJbBtq5waUj9gD3edVibKi4PwifZZbq2URh5Yerlqu4ZY3STxitRMWFEnqJRQHUyF9HtpTjDuqGcjuTytchm41RGvNdtzgSVcLczw23lXh4YdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mw3bahsQ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <adf60fa5-052f-4135-acab-91a02a9aff61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713956237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lW0Os3WrE3ffFTtyiffhIaV15FkSN8s1heo57Xhe2Ww=;
	b=mw3bahsQ11BdRUw0ZcWCIDI/XL708t2hHLsM1rMk0scMJfvfHTPwvZg8DYuPm+wp1ucUkD
	xKspl8b6pwJjnXaHAOCkmrr8ivoY6hZstrc2qIpgHUKERrLPYUaQc28X5yeoie3mCTkgTz
	5UGUmNLD1sfeyazzWwdA3Q6v9fZ/jxo=
Date: Wed, 24 Apr 2024 11:57:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for PTP_PF_EXTTS
 for lan8814
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/04/2024 20:57, Horatiu Vultur wrote:
> Extend the PTP programmable gpios to implement also PTP_PF_EXTTS
> function. The pins can be configured to capture both of rising
> and falling edge. Once the event is seen, then an interrupt is
> generated and the LTC is saved in the registers.
> On lan8814 only GPIO 3 can be configured for this.
> 
> This was tested using:
> ts2phc -m -l 7 -s generic -f ts2phc.cfg
> 
> Where the configuration was the following:
> ---
> [global]
> ts2phc.pin_index  3
> 
> [eth0]
> ---
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

I'm not sure what happened to (fac63186f116 net: phy: micrel: Add
support for PTP_PF_EXTTS for lan8841), looks like this patch is the
rework previous with the limit to GPIO 3 only. In this case comments
below are applicable.

> ---
>   drivers/net/phy/micrel.c | 182 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 181 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 0e310a5e2bff0..2d11f38cbc243 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -167,6 +167,9 @@
>   #define PTP_CMD_CTL_PTP_LTC_STEP_SEC_		BIT(5)
>   #define PTP_CMD_CTL_PTP_LTC_STEP_NSEC_		BIT(6)
>   
> +#define PTP_COMMON_INT_ENA			0x0204
> +#define PTP_COMMON_INT_ENA_GPIO_CAP_EN		BIT(2)
> +
>   #define PTP_CLOCK_SET_SEC_HI			0x0205
>   #define PTP_CLOCK_SET_SEC_MID			0x0206
>   #define PTP_CLOCK_SET_SEC_LO			0x0207
> @@ -179,6 +182,27 @@
>   #define PTP_CLOCK_READ_NS_HI			0x022C
>   #define PTP_CLOCK_READ_NS_LO			0x022D
>   
> +#define PTP_GPIO_SEL				0x0230
> +#define PTP_GPIO_SEL_GPIO_SEL(pin)		((pin) << 8)
> +#define PTP_GPIO_CAP_MAP_LO			0x0232
> +
> +#define PTP_GPIO_CAP_EN				0x0233
> +#define PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(gpio)	BIT(gpio)
> +#define PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(gpio)	(BIT(gpio) << 8)
> +
> +#define PTP_GPIO_RE_LTC_SEC_HI_CAP		0x0235
> +#define PTP_GPIO_RE_LTC_SEC_LO_CAP		0x0236
> +#define PTP_GPIO_RE_LTC_NS_HI_CAP		0x0237
> +#define PTP_GPIO_RE_LTC_NS_LO_CAP		0x0238
> +#define PTP_GPIO_FE_LTC_SEC_HI_CAP		0x0239
> +#define PTP_GPIO_FE_LTC_SEC_LO_CAP		0x023A
> +#define PTP_GPIO_FE_LTC_NS_HI_CAP		0x023B
> +#define PTP_GPIO_FE_LTC_NS_LO_CAP		0x023C
> +
> +#define PTP_GPIO_CAP_STS			0x023D
> +#define PTP_GPIO_CAP_STS_PTP_GPIO_RE_STS(gpio)	BIT(gpio)
> +#define PTP_GPIO_CAP_STS_PTP_GPIO_FE_STS(gpio)	(BIT(gpio) << 8)
> +
>   #define PTP_OPERATING_MODE			0x0241
>   #define PTP_OPERATING_MODE_STANDALONE_		BIT(0)
>   
> @@ -274,6 +298,7 @@
>   
>   #define LAN8814_PTP_GPIO_NUM			24
>   #define LAN8814_PTP_PEROUT_NUM			2
> +#define LAN8814_PTP_EXTTS_NUM			3
>   
>   #define LAN8814_BUFFER_TIME			2
>   
> @@ -3124,12 +3149,102 @@ static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
>   	return 0;
>   }
>   
> +static void lan8814_ptp_extts_on(struct phy_device *phydev, int pin, u32 flags)
> +{
> +	u16 tmp;
> +
> +	/* Set as gpio input */
> +	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
> +	tmp &= ~LAN8814_GPIO_DIR_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), tmp);
> +
> +	/* Map the pin to ltc pin 0 of the capture map registers */
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO);
> +	tmp |= pin;
> +	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO, tmp);
> +
> +	/* Enable capture on the edges of the ltc pin */
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_EN);
> +	if (flags & PTP_RISING_EDGE)
> +		tmp |= PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(0);
> +	if (flags & PTP_FALLING_EDGE)
> +		tmp |= PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(0);
> +	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_EN, tmp);
> +
> +	/* Enable interrupt top interrupt */
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_COMMON_INT_ENA);
> +	tmp |= PTP_COMMON_INT_ENA_GPIO_CAP_EN;
> +	lanphy_write_page_reg(phydev, 4, PTP_COMMON_INT_ENA, tmp);
> +}
> +
> +static void lan8814_ptp_extts_off(struct phy_device *phydev, int pin)
> +{
> +	u16 tmp;
> +
> +	/* Set as gpio out */
> +	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
> +	tmp |= LAN8814_GPIO_DIR_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), tmp);
> +
> +	/* Enable alternate, 0:for alternate function, 1:gpio */
> +	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin));
> +	tmp &= ~LAN8814_GPIO_EN_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin), tmp);
> +
> +	/* Clear the mapping of pin to registers 0 of the capture registers */
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO);
> +	tmp &= ~GENMASK(3, 0);
> +	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO, tmp);
> +
> +	/* Disable capture on both of the edges */
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_EN);
> +	tmp &= ~PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(pin);
> +	tmp &= ~PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(pin);
> +	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_EN, tmp);
> +
> +	/* Disable interrupt top interrupt */
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_COMMON_INT_ENA);
> +	tmp &= ~PTP_COMMON_INT_ENA_GPIO_CAP_EN;
> +	lanphy_write_page_reg(phydev, 4, PTP_COMMON_INT_ENA, tmp);
> +}
> +
> +static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
> +			     struct ptp_clock_request *rq, int on)
> +{
> +	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
> +							  ptp_clock_info);
> +	struct phy_device *phydev = shared->phydev;
> +	int pin;
> +
> +	if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> +				PTP_EXTTS_EDGES |
> +				PTP_STRICT_FLAGS))
> +		return -EOPNOTSUPP;
> +
> +	pin = ptp_find_pin(shared->ptp_clock, PTP_PF_EXTTS,
> +			   rq->extts.index);
> +	if (pin == -1 || pin != LAN8814_PTP_EXTTS_NUM)
> +		return -EINVAL;

I'm not sure how will enable request pass this check?
In lan8814_ptp_probe_once pins are initialized with PTP_PF_NONE,
and ptp_find_pin will always return -1, which will end up with
-EINVAL here and never hit lan8814_ptp_extts_on/lan8814_ptp_extts_off

> +
> +	mutex_lock(&shared->shared_lock);
> +	if (on)
> +		lan8814_ptp_extts_on(phydev, pin, rq->extts.flags);
> +	else
> +		lan8814_ptp_extts_off(phydev, pin);
> +
> +	mutex_unlock(&shared->shared_lock);
> +
> +	return 0;
> +}
> +
>   static int lan8814_ptpci_enable(struct ptp_clock_info *ptpci,
>   				struct ptp_clock_request *rq, int on)
>   {
>   	switch (rq->type) {
>   	case PTP_CLK_REQ_PEROUT:
>   		return lan8814_ptp_perout(ptpci, rq, on);
> +	case PTP_CLK_REQ_EXTTS:
> +		return lan8814_ptp_extts(ptpci, rq, on);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -3148,6 +3263,10 @@ static int lan8814_ptpci_verify(struct ptp_clock_info *ptp, unsigned int pin,
>   		if (pin >= LAN8814_PTP_PEROUT_NUM || pin != chan)
>   			return -1;
>   		break;
> +	case PTP_PF_EXTTS:
> +		if (pin != LAN8814_PTP_EXTTS_NUM)

Here the check states that exactly GPIO 3 can have EXTTS function, but
later in the config...

> +			return -1;
> +		break;
>   	default:
>   		return -1;
>   	}
> @@ -3320,6 +3439,64 @@ static void lan8814_handle_ptp_interrupt(struct phy_device *phydev, u16 status)
>   	}
>   }
>   
> +static int lan8814_gpio_process_cap(struct lan8814_shared_priv *shared)
> +{
> +	struct phy_device *phydev = shared->phydev;
> +	struct ptp_clock_event ptp_event = {0};
> +	unsigned long nsec;
> +	s64 sec;
> +	u16 tmp;
> +
> +	/* This is 0 because whatever was the input pin it was mapped it to
> +	 * ltc gpio pin 0
> +	 */
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_SEL);
> +	tmp |= PTP_GPIO_SEL_GPIO_SEL(0);
> +	lanphy_write_page_reg(phydev, 4, PTP_GPIO_SEL, tmp);
> +
> +	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_STS);
> +	if (!(tmp & PTP_GPIO_CAP_STS_PTP_GPIO_RE_STS(0)) &&
> +	    !(tmp & PTP_GPIO_CAP_STS_PTP_GPIO_FE_STS(0)))
> +		return -1;
> +
> +	if (tmp & BIT(0)) {
> +		sec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_SEC_HI_CAP);
> +		sec <<= 16;
> +		sec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_SEC_LO_CAP);
> +
> +		nsec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_HI_CAP) & 0x3fff;
> +		nsec <<= 16;
> +		nsec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_LO_CAP);
> +	} else {
> +		sec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_SEC_HI_CAP);
> +		sec <<= 16;
> +		sec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_SEC_LO_CAP);
> +
> +		nsec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_NS_HI_CAP) & 0x3fff;
> +		nsec <<= 16;
> +		nsec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_LO_CAP);
> +	}
> +
> +	ptp_event.index = 0;
> +	ptp_event.timestamp = ktime_set(sec, nsec);
> +	ptp_event.type = PTP_CLOCK_EXTTS;
> +	ptp_clock_event(shared->ptp_clock, &ptp_event);
> +
> +	return 0;
> +}
> +
> +static int lan8814_handle_gpio_interrupt(struct phy_device *phydev, u16 status)
> +{
> +	struct lan8814_shared_priv *shared = phydev->shared->priv;
> +	int ret;
> +
> +	mutex_lock(&shared->shared_lock);
> +	ret = lan8814_gpio_process_cap(shared);
> +	mutex_unlock(&shared->shared_lock);
> +
> +	return ret;
> +}
> +
>   static int lan8804_config_init(struct phy_device *phydev)
>   {
>   	int val;
> @@ -3424,6 +3601,9 @@ static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
>   		ret = IRQ_HANDLED;
>   	}
>   
> +	if (!lan8814_handle_gpio_interrupt(phydev, irq_status))
> +		ret = IRQ_HANDLED;
> +
>   	return ret;
>   }
>   
> @@ -3541,7 +3721,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
>   	snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
>   	shared->ptp_clock_info.max_adj = 31249999;
>   	shared->ptp_clock_info.n_alarm = 0;
> -	shared->ptp_clock_info.n_ext_ts = 0;
> +	shared->ptp_clock_info.n_ext_ts = LAN8814_PTP_EXTTS_NUM;

Here ptp_clock is configured to have 3 pins supporting EXTTS.
Looks like it should be n_ext_ts = 1;

>   	shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
>   	shared->ptp_clock_info.pps = 0;
>   	shared->ptp_clock_info.pin_config = shared->pin_config;


