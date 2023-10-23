Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C797D2F53
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjJWJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjJWJ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:59:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773EA1722;
        Mon, 23 Oct 2023 02:59:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFCEC433C8;
        Mon, 23 Oct 2023 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698055143;
        bh=U22arOYqMfIQqu6jCSRcueYe91nxdoBeypcQss0QoDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3YJbI7pZYVTAe06UbkqxujhKtqaah2NL9tfHTwTQEZMsSPe5agQXXuqrBJo5BoX/
         uc4A5nbeARkimGw16qLKxy9+LevqaI85NTl0oCwZYwYXgviKEWw3wrqHYG4KXfzK9y
         qRQkd8l20uO3aO+aEktE9dQDPhgRu/g3cGgO+di7Nt5rgJm4l7PBpVvgZDvGr439S9
         GZuLVcUkYP1IYHw8ooUZbxWzJdKAWzJi71e3Pxhzt4yjk3UkDTMFhI0s6RrtgR+EgO
         a8imxQ5Df23y/y57yeG3A64DslPZs8vrayt3jWFCYGXKBWw5ojm+rbCDDN0vtU6FZQ
         PM9SETXIWJ+iw==
Date:   Mon, 23 Oct 2023 10:58:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     Samuel Holland <samuel@sholland.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH v7 2/5] leds: sun50i-a100: New driver for the A100
 LED controller
Message-ID: <20231023095855.GH8909@google.com>
References: <20221231235541.13568-1-samuel@sholland.org>
 <20221231235541.13568-3-samuel@sholland.org>
 <c3ae7d79ab81621c66e939d804ca41e97eab79fb.camel@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3ae7d79ab81621c66e939d804ca41e97eab79fb.camel@apitzsch.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Samuel,
> 
> there are two more things to change, which came up recently. See below.
> 
> Regards,
> André
> 
> Am Samstag, dem 31.12.2022 um 17:55 -0600 schrieb Samuel Holland:
> > Some Allwinner sunxi SoCs, starting with the A100, contain an LED
> > controller designed to drive RGB LED pixels. Add a driver for it
> > using
> > the multicolor LED framework, and with LEDs defined in the device
> > tree.
> > 
> > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > [...]
> > diff --git a/drivers/leds/leds-sun50i-a100.c b/drivers/leds/leds-
> > sun50i-a100.c

[...]

> > +struct sun50i_a100_ledc {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct clk *bus_clk;
> > +	struct clk *mod_clk;
> > +	struct reset_control *reset;
> > +
> > +	u32 *buffer;
> > +	struct dma_chan *dma_chan;
> > +	dma_addr_t dma_handle;
> > +	int pio_length;
> > +	int pio_offset;
> > +
> > +	spinlock_t lock;
> > +	int next_length;
> > +	bool xfer_active;
> > +
> > +	u32 format;
> > +	struct sun50i_a100_ledc_timing timing;
> > +
> > +	int num_leds;
> > +	struct sun50i_a100_ledc_led leds[];
> 
> Annotate struct with  __counted_by(num_leds).

André, please remember to snip your replies.

-- 
Lee Jones [李琼斯]
