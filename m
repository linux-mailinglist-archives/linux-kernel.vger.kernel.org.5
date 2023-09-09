Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416C57999D9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjIIQ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346306AbjIIONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:13:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7DDCCA;
        Sat,  9 Sep 2023 07:13:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4217532008FD;
        Sat,  9 Sep 2023 10:13:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 09 Sep 2023 10:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694268807; x=1694355207; bh=nbOp7enOV3UefizK0seUV09PDl3g1xgVtOM
        4dP2WEA0=; b=YHv+kCaKh+wWZ/Y2/qhZkJBLYkbrsXUkscQJnUIDy/TAAd7AvB1
        3Wuyxw3z11/LeWAUWXCqwQ6lAX+ziNXMpbLnLHsvbjDd9zd8J13G8EiFpbQ49o+v
        VI5xsLPCnyFx17savFhk7LhmT97GN6mMx19V6eBJBCZgCTlwMbDSEbz1uC185xlZ
        oiufYMzFPvbN+/s6xckc0o2jFpaDMklvHiTEBl+d9nwqrBG2taTr2zLy0t1eqTPx
        /POKw1QNQo++a6uWF5y6hs735yd0vsg9N98YoMsRGlCn4z0VoDHIZZxGEZlRF7v3
        fdofrMrLVkQQ+wFnD5VPnBxcIU2ZFRPNoxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694268807; x=1694355207; bh=nbOp7enOV3UefizK0seUV09PDl3g1xgVtOM
        4dP2WEA0=; b=q1YSKHpK1FVP33uiOek4PJX+L3XjjfUMOSGg6HjMM4+9J9IX41y
        EsKS+NUvJEH08bQ/mKV02ZU34E7XGLc8AqQv41xVdf4NxcsltlVZeLdHdvjAoF1b
        oK5inPFoRiZQWoWZlDFYPeeLNJO11Z4tyuWJiqV63fsd4uMQ0koOKT/Xtm6bha46
        wsBkHWuQNbo6OptXxjUOFeu6Qd6VGgA+znzn2yoPdEUFAA75rlNKmBFEwf9KvoyR
        LxSEhjGwwVitud/MPvuf2L/+eU2gWHNXNk/7QddSn+ORYhe6csTZEcJV0ZQ+hcqO
        NT4BlJyfLEXhNzlpu3scn90kqY+pjWYg5pw==
X-ME-Sender: <xms:h338ZHhwDVGrKf9f_hroAaYucF07sPPn6u3L4F03KYVwrvTYQ4SlIg>
    <xme:h338ZEDPWpxc1u6I97qNU3Fipxu3LEUUteez4cr-DSXVePK_iuEwGm83c6yRn4t9X
    _-BqU9tCP29qlH73A>
X-ME-Received: <xmr:h338ZHEWPq9LW8EJaz1L38HentIWBlFd6GV-mJ778sc1zalncz4NFAWV9C8yQyJNIzX6e39XFnT-xGIn2wMkMLgduLZVPYocIAeL3gskcebgAVol9H5vdvIW_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduhffffefhffduudetvdffkeetveeiueegfeelleffiedtuddt
    ffduhefgtdefgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:h338ZESAqFizQBY1AXNc8PCLrn5pKBFvybU-9g7pXKikURJgHQE8tg>
    <xmx:h338ZEx575UiyHPImvVYDcH6BA0hemUZv6NKAOGKKvyKexHdrrYRag>
    <xmx:h338ZK6J5zj-A97KCNM1L_MMqa5vAtHtV9gbc37rgk2dkOuVJYa8fQ>
    <xmx:h338ZHypFkRg7uxvQBPMRMFk9d82SL5xb0_y8Tbqtx3QKGjzenhS0Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 10:13:26 -0400 (EDT)
Message-ID: <a16e8863-7b8c-9a73-b93f-c55f1bf6c792@sholland.org>
Date:   Sat, 9 Sep 2023 09:13:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] pinctrl: sunxi: h616: add extra gpio banks
Content-Language: en-US
To:     Mikhail Kalashnikov <iuncuim@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20230909094529.6083-1-iuncuim@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230909094529.6083-1-iuncuim@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/23 04:45, Mikhail Kalashnikov wrote:
> From: iuncuim <iuncuim@gmail.com>
> 
> Some SoCs from the H616 family (such as the T507) have the same die but
> more output pins that are used for additional peripherals. The T507 SoC
> don't have a built-in multiphy like the AC200 or AC300 connected ti the

typo: to

> bank A. With the T507 these pins can be freely used for any other application.
> This patch adds the missing muxes on banks A, D and E.
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c | 380 +++++++++++++++++++-
>  1 file changed, 366 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> index d6ca720ee..10d4e1ef1 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> @@ -16,33 +16,81 @@
>  #include "pinctrl-sunxi.h"
>  
>  static const struct sunxi_desc_pin h616_pins[] = {
> -	/* Internal connection to the AC200 part */
> +	/* Internally connected to the AC200 part in the H616 SoC */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD1 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD1 */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PA_EINT0 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD0 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD0 */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PA_EINT1 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ECRS_DV */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ECRS_DV */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PA_EINT2 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXERR */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXERR */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PA_EINT3 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD1 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PA_EINT4 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD0 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD0 */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* DOUT0 */

For H616 we chose[1] to remove the "h_" prefix from the I2S function
names, even though the interfaces are part of the audio hub and not
discrete devices. Please remove it here as well for consistency.

Regards,
Samuel

[1]:
https://lore.kernel.org/linux-arm-kernel/20201214094430.m6h3pzhkm3kjl2cl@gilmour/

