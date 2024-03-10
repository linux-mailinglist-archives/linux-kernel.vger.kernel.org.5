Return-Path: <linux-kernel+bounces-98298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAAE87780D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11061C209C8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645139FD0;
	Sun, 10 Mar 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mCdKyQqT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9113A1CD;
	Sun, 10 Mar 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096424; cv=none; b=Mi7VGtBlou7zInVOQiMNq9Y8MujqQvzDzvYgti6fMDbJ5JV8zR8VFJ2VluDU+/tYe/bLXr806IeetTGx5ireqdc7mHMY1+HdHgqjRToHzkWuvrU9yrPduEH315ZRW4Lnk9vWbK2brtFT3g9OOp0hXbvVajrnIA3MqZQFwT0e/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096424; c=relaxed/simple;
	bh=TuDuzTQgSNRExIdxUZGT2D0+oqzQPcRdEDnDZHr851Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7Sjsayg35dLIRcunOgGWhR30OmD/Ykpf1rrb1hqqz8w+I+iCu1KMYL6l07lMq46XkoIy9w3GaiKWArUFmZxjqlar+gA/HquFLqvl9113I1NQTYZd43Wkwv1hjh7cWsBA1qcwYh5HuxiG0BHE2aw9NYafMcsU+o9+vi8BPq0r2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mCdKyQqT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ycj1VndeIQ01IYCJKHgEgW6HSGNRHq/qtTl7RopLFLQ=; b=mCdKyQqTefaIcu8hgQ0YdfHTUs
	rSlUdmzuM+sS6dOJRBA3vDTEwHzyOtJZexS/nFrVj3WQ4iCpak4tSoYXWWjZrAYvgNRhITBVvHQAA
	1e4HcKzeRb/fG0QyaHihVSukMwnNH9h67EOdkOhYpa1G4DqlNLRnBr4gPJg9kqc27JA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rjOCi-009v6b-Le; Sun, 10 Mar 2024 19:47:24 +0100
Date: Sun, 10 Mar 2024 19:47:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for
 rtl8366rb
Message-ID: <d064b1be-1004-487b-9944-b62d91b671c9@lunn.ch>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com>

On Sun, Mar 10, 2024 at 01:52:01AM -0300, Luiz Angelo Daros de Luca wrote:
> This commit introduces LED drivers for rtl8366rb, enabling LEDs to be
> described in the device tree using the same format as qca8k. Each port
> can configure up to 4 LEDs.
> 
> If all LEDs in a group use the default state "keep", they will use the
> default behavior after a reset. Changing the brightness of one LED,
> either manually or by a trigger, will disable the default hardware
> trigger and switch the entire LED group to manually controlled LEDs.


The previous patch said:

  This switch family supports four LEDs for each of its six
  ports. Each LED group is composed of one of these four LEDs from all
  six ports. LED groups can be configured to display hardware
  information, such as link activity, or manually controlled through a
  bitmap in registers RTL8366RB_LED_0_1_CTRL_REG and
  RTL8366RB_LED_2_3_CTRL_REG.

I could be understanding this wrongly, but to me, it sounds like an
LED is either controlled via the group, or you can take an LED out of
the group and software on/off control it? Ah, after looking at the
code. The group can be put into forced mode, and then each LED in the
group controlled in software.

> Once in this mode, there is no way to revert to hardware-controlled LEDs
> (except by resetting the switch).

Just for my understanding.... This is a software limitation. You could
check if all LEDs in a group are using the same trigger, and then set
the group to that trigger?

I do understand how the current offload concept causes problems here.
You need a call into the trigger to ask it to re-evaluate if offload
can be performed for an LED.

What you have here seems like a good first step, offloaded could be
added later if somebody wants to.

> +enum rtl8366_led_mode {
> +	RTL8366RB_LED_OFF		= 0x0,
> +	RTL8366RB_LED_DUP_COL		= 0x1,
> +	RTL8366RB_LED_LINK_ACT		= 0x2,
> +	RTL8366RB_LED_SPD1000		= 0x3,
> +	RTL8366RB_LED_SPD100		= 0x4,
> +	RTL8366RB_LED_SPD10		= 0x5,
> +	RTL8366RB_LED_SPD1000_ACT	= 0x6,
> +	RTL8366RB_LED_SPD100_ACT	= 0x7,
> +	RTL8366RB_LED_SPD10_ACT		= 0x8,
> +	RTL8366RB_LED_SPD100_10_ACT	= 0x9,
> +	RTL8366RB_LED_FIBER		= 0xa,
> +	RTL8366RB_LED_AN_FAULT		= 0xb,
> +	RTL8366RB_LED_LINK_RX		= 0xc,
> +	RTL8366RB_LED_LINK_TX		= 0xd,
> +	RTL8366RB_LED_MASTER		= 0xe,
> +	RTL8366RB_LED_FORCE		= 0xf,

This is what the group shows? Maybe put _GROUP_ into the name? This
concept of a group is pretty unusual, so we should be careful with
naming to make it clear when we are referring to one LED or a group of
LEDs. I would also put _group_ into the enum.

> +
> +	__RTL8366RB_LED_MAX
> +};
> +
> +struct rtl8366rb_led {
> +	u8 port_num;
> +	u8 led_group;
> +	struct realtek_priv *priv;
> +	struct led_classdev cdev;
> +};
> +
>  /**
>   * struct rtl8366rb - RTL8366RB-specific data
>   * @max_mtu: per-port max MTU setting
>   * @pvid_enabled: if PVID is set for respective port
> + * @leds: per-port and per-ledgroup led info
>   */
>  struct rtl8366rb {
>  	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
>  	bool pvid_enabled[RTL8366RB_NUM_PORTS];
> +	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
>  };
>  
>  static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
> @@ -809,6 +829,208 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
>  	return 0;
>  }
>  
> +static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
> +				      u8 led_group,
> +				      enum rtl8366_led_mode mode)
> +{
> +	int ret;
> +	u32 val;
> +
> +	val = mode << RTL8366RB_LED_CTRL_OFFSET(led_group);
> +
> +	ret = regmap_update_bits(priv->map,
> +				 RTL8366RB_LED_CTRL_REG,
> +				 RTL8366RB_LED_CTRL_MASK(led_group),
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
> +{
> +	switch (led_group) {
> +	case 0:
> +		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> +	case 1:
> +		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> +	case 2:
> +		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> +	case 3:
> +		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int rb8366rb_get_port_led(struct rtl8366rb_led *led, bool enable)

enable seems unused here. It also seems an odd parameter to pass to a
_get_ function.

> +{
> +	struct realtek_priv *priv = led->priv;
> +	u8 led_group = led->led_group;
> +	u8 port_num = led->port_num;
> +	int ret;
> +	u32 val;
> +
> +	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
> +		dev_err(priv->dev, "Invalid LED group %d for port %d",
> +			led_group, port_num);
> +		return -EINVAL;
> +	}

This check seems odd. You can validate it once when you create the
struct rtl8366rb_led. After that, just trust it?

       Andrew

