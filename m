Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B567CE7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjJRT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCA1114;
        Wed, 18 Oct 2023 12:26:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73075C433C7;
        Wed, 18 Oct 2023 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697657162;
        bh=KdcsujksQHyrzxhuXt0JsGbIZwYjzMf7Cl5PwnuaNfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCOCwf50YrIZn7X8ONxC2wDPaQeZrid9Q64Vtt/ze5RTK2wOgCFRIGkiaaY6A9hku
         74BM9XqFpJe+GuPYX2peUYrB2zAv+hCbA6ehcAVR1Qw6AAvFEy3SRzr9ap3GvBIVgg
         F9kZpitxS3szsuI7bBWpUSk2k4Dudnf4WUIRvHBNpd8y8vsBJwy2ojZhYVQ/UAHHcE
         JYcncAAMq++oSMsfVX4SyHtGvEGD4G0z23qqu0X/i1G/VCivG+WGkh0ijdNkdoxgjl
         B7+TRt7W6Z8ewrW4Avof17k57353fWS76eMWJvSmiofzfYRiphlNiQJKKFBE0JEFi9
         UWtqBIYcHIP+g==
Date:   Wed, 18 Oct 2023 20:26:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     David Lechner <dlechner@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: resolver: ad2s1210: add reset gpio support
Message-ID: <20231018202622.335331d3@jic23-huawei>
In-Reply-To: <SN7PR03MB7132A5B955A660700220ADA78ED6A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20231016154311.38547-1-dlechner@baylibre.com>
        <SN7PR03MB7132A5B955A660700220ADA78ED6A@SN7PR03MB7132.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 13:46:51 +0000
"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

> > -----Original Message-----
> > From: David Lechner <dlechner@baylibre.com>
> > Sent: Montag, 16. Oktober 2023 17:43
> > To: linux-iio@vger.kernel.org
> > Cc: David Lechner <dlechner@baylibre.com>; Jonathan Cameron
> > <jic23@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > Sa, Nuno <Nuno.Sa@analog.com>; linux-kernel@vger.kernel.org
> > Subject: [PATCH] iio: resolver: ad2s1210: add reset gpio support
> > 
> > 
> > This adds support for the optional reset gpio to the ad2s1210 resolver driver. If
> > the gpio is present in the device tree, it is toggled during driver probe before the
> > reset of the device initialization. As per the devicetree bindings, it is expected for
> > the gpio to configured as active low.
> > 
> > Suggested-by: Michael Hennerich <Michael.Hennerich@analog.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---  
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Applied and pushed out as testing for 0-day to poke at it.

Thanks,

Jonathan

> 
> >  drivers/iio/resolver/ad2s1210.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> > index 8646389ec88d..a414eef12e5e 100644
> > --- a/drivers/iio/resolver/ad2s1210.c
> > +++ b/drivers/iio/resolver/ad2s1210.c
> > @@ -1426,6 +1426,7 @@ static int ad2s1210_setup_gpios(struct
> > ad2s1210_state *st)  {
> >  	struct device *dev = &st->sdev->dev;
> >  	struct gpio_descs *resolution_gpios;
> > +	struct gpio_desc *reset_gpio;
> >  	DECLARE_BITMAP(bitmap, 2);
> >  	int ret;
> > 
> > @@ -1481,6 +1482,17 @@ static int ad2s1210_setup_gpios(struct
> > ad2s1210_state *st)
> >  					     "failed to set resolution gpios\n");
> >  	}
> > 
> > +	/* If the optional reset GPIO is present, toggle it to do a hard reset. */
> > +	reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> > +				     "failed to request reset GPIO\n");
> > +
> > +	if (reset_gpio) {
> > +		udelay(10);
> > +		gpiod_set_value(reset_gpio, 0);
> > +	}
> > +
> >  	return 0;
> >  }
> > 
> > --
> > 2.42.0  
> 

