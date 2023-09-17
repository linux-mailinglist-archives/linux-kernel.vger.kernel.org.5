Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8827A36D4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjIQRQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjIQRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:15:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B6129;
        Sun, 17 Sep 2023 10:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694970941; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nS5WmAhO5Gpoo8+Y6T/j0s+4Syd4tr3P6YDCQm0Qq0J/Kq2oaayknjkpphbFyGTqtY
    ZzB6/URaZdyk7p5eRdJp9E78Z4IneXoYBIJFuIaKY1LdUAZ/NH8gRgEzoQ9T8Fi9ns8p
    Nf4iKEp1reYIZKJZxGerFauDj4FiDIqElOPUdX6pLJGj0wI0RUFxhBPWLnFXqxyc2nIr
    5trmeQ0weKj+IRU+PAUq1DBEbbkttdl4iRHz6/wkqRIociY0xFrLypJo+KV4YbnldsyR
    9esv88jiT27t3NTxG6aaCC/w/izkyCXBRlbwiHgXioJu12LjFC47QbWjcrz4LF3y82sf
    V5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694970941;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1MThI3vKkUph9hycT41DCqB1ZfMYSk7rjJlNGn1zuIg=;
    b=BY+qk0nnK/xjJ4WN6aW3dPPkZrLuYqBAFn4w6xa9ZI16abGix8OitGWvlqz1DX4Buk
    UB8YOrYw9sdxZmtj9npkSQhS3cnEeVkGrylsu2JuPIsKmRUhR4plNAp7E7vBHn0fmdri
    OSjQTtuOLZC/cZKAU8XPJpjQkSTQzGft+3HUDwSIUBhiwHlmdWkrWs1k+NDVhH5YIRT0
    Ah+0O7gD1VxbMugs+AmyOOjJ3Zc9GGchgHl1welFoY3BSkuaMuHRJm9zme2tupx9H1IV
    K8OH7+khqPwx6ZJajE8o3UWmHB3ueFQcVlG3+Xnyq8HuNqwyRUtoYnwLgoL7TJpHKvlE
    uCiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694970941;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1MThI3vKkUph9hycT41DCqB1ZfMYSk7rjJlNGn1zuIg=;
    b=NDww7PQQnoFzPcYAU/AeG4NZff/jFHuDJaV+BOhqN7q+xH6f2TmKC7iQaJztCfE5iq
    2KKn/2oE08rcfecJ68NKbr1wpXXSbyJt+LwE8EUgheePDdm5rEDe0Dwgd3qkWXFNNJIV
    woGirairvucNlgmPeGme3ZnuM7wy9J+Z5eoSPluL0DLDyFickrb5Ta9IltrQI8kmUclb
    v5ZSgpxKE4sguKXFHGE/GUmLuttUdTlkGtBKKtA1k+OhuiXsyQyvdCu+xpk6TkPfOz0w
    FwS6OGfG5m66I8VFna37QyGR+PCehcnTKXiXsqqlisJddx9eTXy5a3vHC6ugGqhsGX3T
    ueRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694970941;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1MThI3vKkUph9hycT41DCqB1ZfMYSk7rjJlNGn1zuIg=;
    b=huq3uLqdXVk328kunwL+Lcy1DZxYq1ifSVhoSz6IwA9yw6mt5w78LcC96nh9fSD7mb
    E+YBXZIHLzLj3GEr5xAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8HHFfB9Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 17 Sep 2023 19:15:41 +0200 (CEST)
Date:   Sun, 17 Sep 2023 19:15:40 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, jonathan.albrieux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rydberg@bitmath.org
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZQc0PKfAZe5HNdHg@gerhold.net>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
 <abf36591-3b3c-dc47-b1aa-e574325499f4@wanadoo.fr>
 <ZQcrQIfXYCv5aMK7@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQcrQIfXYCv5aMK7@nixie71>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe and Jeff,

Thanks for your comments!

On Sun, Sep 17, 2023 at 11:37:20AM -0500, Jeff LaBundy wrote:
> On Sun, Sep 17, 2023 at 08:03:48AM +0200, Christophe JAILLET wrote:
> > Le 13/09/2023 à 15:25, Stephan Gerhold a écrit :
> > > From: Jonathan Albrieux <jonathan.albrieux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > 
> > > Add a simple driver for the Himax HX852x(ES) touch panel controller,
> > > with support for multi-touch and capacitive touch keys.
> > > 
> > > The driver is somewhat based on sample code from Himax. However, that
> > > code was so extremely confusing that we spent a significant amount of
> > > time just trying to understand the packet format and register commands.
> > > In this driver they are described with clean structs and defines rather
> > > than lots of magic numbers and offset calculations.
> > > 
> > > Signed-off-by: Jonathan Albrieux <jonathan.albrieux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Co-developed-by: Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>
> > > Signed-off-by: Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>
> > > ---
> > 
> > ...
> > 
> > > +static irqreturn_t hx852x_interrupt(int irq, void *ptr)
> > > +{
> > > +	struct hx852x *hx = ptr;
> > > +	int error;
> > > +
> > > +	error = hx852x_handle_events(hx);
> > > +	if (error) {
> > > +		dev_err(&hx->client->dev, "failed to handle events: %d\n", error);
> > 
> > Should dev_err_ratelimited() be preferred?
> > 

I haven't ever seen this but I guess you're right. It could spam
potentially. :-) I will change it in v2.

> > > +		return IRQ_NONE;
> > > +	}
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > 
> > ...
> > 
> > > +static int hx852x_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct hx852x *hx;
> > > +	int error, i;
> > 
> > Nit: err or ret is shorter and maybe more "standard".
> 
> For what it's worth, 'error' tends to be more common in input.
> 

Yep, this is the only reason why we used it. I usually use "ret" but got
the feeling "error" is preferred for the input subsystem.

> > 
> > > +
> > > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> > > +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> > > +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> > > +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> > > +		dev_err(dev, "not all i2c functionality supported\n");
> > > +		return -ENXIO;
> > > +	}
> > > +
> > > +	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
> > > +	if (!hx)
> > > +		return -ENOMEM;
> > > +
> > > +	hx->client = client;
> > > +	hx->input_dev = devm_input_allocate_device(dev);
> > > +	if (!hx->input_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	hx->input_dev->name = "Himax HX852x";
> > > +	hx->input_dev->id.bustype = BUS_I2C;
> > > +	hx->input_dev->open = hx852x_input_open;
> > > +	hx->input_dev->close = hx852x_input_close;
> > > +
> > > +	i2c_set_clientdata(client, hx);
> > > +	input_set_drvdata(hx->input_dev, hx);
> > > +
> > > +	hx->supplies[0].supply = "vcca";
> > > +	hx->supplies[1].supply = "vccd";
> > > +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
> > > +	if (error < 0)
> > > +		return dev_err_probe(dev, error, "failed to get regulators");
> > > +
> > > +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(hx->reset_gpiod))
> > > +		return dev_err_probe(dev, error, "failed to get reset gpio");
> > > +
> > > +	error = devm_request_threaded_irq(dev, client->irq, NULL, hx852x_interrupt,
> > > +					  IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, hx);
> > > +	if (error) {
> > > +		dev_err(dev, "failed to request irq %d: %d\n", client->irq, error);
> > 
> > dev_err_probe() could be used to be consistent with above code.
> > Same for below dev_err() calls.
> > 

Right, will change it!

> > > +		return error;
> > > +	}
> > > +
> > > +	error = hx852x_read_config(hx);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_X);
> > > +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> > > +	input_set_abs_params(hx->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> > > +
> > > +	touchscreen_parse_properties(hx->input_dev, true, &hx->props);
> > > +	error = hx852x_parse_properties(hx);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	hx->input_dev->keycode = hx->keycodes;
> > > +	hx->input_dev->keycodemax = hx->keycount;
> > > +	hx->input_dev->keycodesize = sizeof(hx->keycodes[0]);
> > > +	for (i = 0; i < hx->keycount; i++)
> > > +		input_set_capability(hx->input_dev, EV_KEY, hx->keycodes[i]);
> > > +
> > > +	error = input_mt_init_slots(hx->input_dev, hx->max_fingers,
> > > +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> > > +	if (error) {
> > > +		dev_err(dev, "failed to init MT slots: %d\n", error);
> > > +		return error;
> > > +	}
> > > +
> > > +	error = input_register_device(hx->input_dev);
> > > +	if (error) {
> > 
> > input_mt_destroy_slots() should be called here, or in an error handling path
> > below, or via a devm_add_action_or_reset().
> 
> This seems like a memory leak in every touchscreen driver; maybe it is more
> practical to have the input core handle this clean-up.
> 
> Other drivers can and do insert other return paths between input_mt_init_slots()
> and input_register_device(), so it seems that we cannot solve this by calling
> input_mt_destroy_slots() from the error path within input_register_device().
> 
> Maybe a better option is to update input_mt_init_slots() to use device-managed
> allocation instead?
> 

Hmm, it would be fairly easy to add the input_mt_destroy_slots() call as
part of the single if statement I have here, but yeah, someone would
need to make a patch for literally all of the other touchscreen drivers.
Both options (add call or some devm magic) would be fine for me. :-)

> > 
> > It should also be called in a .remove function (unless
> > devm_add_action_or_reset is prefered)
> 
> I think the remove path is OK, as input_dev_release() handles this for us. In
> case I have misunderstood, please let me know.
> 

Yep, I think so too!

Thanks,
Stephan
