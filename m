Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4C7B40E3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjI3O1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjI3O1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:27:30 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5FC2;
        Sat, 30 Sep 2023 07:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696084044; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gIwwlm1+Rusy92TdYGeJTtdOVkw2QzsTy3OkTn+dEcxiorsyVIh/Xfpc7/8bOqRHTf
    Ss62UXgPyQQXkAjK9SroXnRkzGtVFjw0targ3aAOQccKOXO2qZmALBUVASxStWbD1Mi9
    TEs57b5XFY8kRnF+isCHjPYPBRHkTnJTOviXR5pJQDat/nSst6WtL8lsfSWQHs9/Ah7A
    Ap29W76UnnuqAP/cZvn/Ee5whNJU+ISx9AELfp0WTsEcmjdXNjjfYMVLADNwGy3X+Vx+
    /nNEOx8/LCA19MHmuj7WCVQaWuhbYnzAEhn73ZGses/u2AKwts8G9XfOc6uzg3Y5J/NI
    tOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696084044;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AxtyPLGRhQTS8BpvKTA8jX8YlndiVDqwSlUJLb0qHkE=;
    b=Ht2nRr1ZKlKmQJxAvxBdNzA+hT8xRR2zbmx6IP1TGzaYADVJUKWid1RZIEAfkfV4GX
    doPElfUJ3RjM10/jT09+ya0f8Pl+kJCmDRvTOzoZfigixONvCpvW/nrzjA2UkZ9c2+pj
    T7+MzNS8f3yoWDHq6ooRMk0Jb+vnHN+gmp6hCnQmvcS9x8nZu1thouoI818R2xOgGvvv
    SQmOyKzmxITYbqPDZUTwg+YY6HDNYaKq3lQzxWyLF5rb7QgwYMYgSVQgqsbFQPzNPWit
    bZAB0avLdmtNFvdCsJh4Q0Utq3o3kb+Hgq1/pODQlIxabt308poTvprxtIh8ZDQClq0z
    6nvg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696084044;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AxtyPLGRhQTS8BpvKTA8jX8YlndiVDqwSlUJLb0qHkE=;
    b=T3Iky+q56W8678CSwVDZWotWi7wYuaeR8VGvpcmAKPwIcV501ja1rtbPP8i646eI5N
    +jsHyZ2AcvhfNuWWsgTuJClWy9LSrQNgn5LYQvtYH5F2eI5LvJnUVrquVBErwQqM9idL
    LerEIdhWbJ9I7k5DLxYbsQ6b8e+w4vsK9NJKlkCQJ9MVnlzkp+uv53uYbtSVI8roCYrZ
    eP7YyV4DLvqt+W4i683v4cdM3EXYLvMgikP5mCbm8SFxvV1978qCoVbDcKqWODcLyij8
    4u7wiAprHPZga8fEg1tQ+uYlGMCVHKA8ndhHzba/9vTGOAbg2Wv47zR9EZ/hibkQPKXM
    itxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696084044;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AxtyPLGRhQTS8BpvKTA8jX8YlndiVDqwSlUJLb0qHkE=;
    b=ohybLTvLrCb/veQvjxLSg7l6yet9xWL4aQSCwu5MtQL8VNGBTPNkUSu1jBEJGMyHiB
    +IF3V+3td81YoWJ90ADQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8UEROtSZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 30 Sep 2023 16:27:24 +0200 (CEST)
Date:   Sat, 30 Sep 2023 16:27:17 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZRgwRfr7aW_Ww0oL@gerhold.net>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
 <ZQYUe46/rj8jqNvg@nixie71>
 <ZQcx7oQyL6RM06Jt@gerhold.net>
 <ZROaqRiWa6ReVH/D@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZROaqRiWa6ReVH/D@nixie71>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Tue, Sep 26, 2023 at 09:59:53PM -0500, Jeff LaBundy wrote:
> On Sun, Sep 17, 2023 at 07:05:50PM +0200, Stephan Gerhold wrote:
> > On Sat, Sep 16, 2023 at 03:47:55PM -0500, Jeff LaBundy wrote:
> > > On Wed, Sep 13, 2023 at 03:25:30PM +0200, Stephan Gerhold wrote:
> > > > From: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> [...]
> > > > +static int hx852x_probe(struct i2c_client *client)
> > > > +{
> > > > +	struct device *dev = &client->dev;
> > > > +	struct hx852x *hx;
> > > > +	int error, i;
> > > > +
> > > > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> > > > +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> > > > +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> > > > +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> > > > +		dev_err(dev, "not all i2c functionality supported\n");
> > > > +		return -ENXIO;
> > > > +	}
> > > > +
> > > > +	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
> > > > +	if (!hx)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	hx->client = client;
> > > > +	hx->input_dev = devm_input_allocate_device(dev);
> > > > +	if (!hx->input_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	hx->input_dev->name = "Himax HX852x";
> > > > +	hx->input_dev->id.bustype = BUS_I2C;
> > > > +	hx->input_dev->open = hx852x_input_open;
> > > > +	hx->input_dev->close = hx852x_input_close;
> > > > +
> > > > +	i2c_set_clientdata(client, hx);
> > > > +	input_set_drvdata(hx->input_dev, hx);
> > > > +
> > > > +	hx->supplies[0].supply = "vcca";
> > > > +	hx->supplies[1].supply = "vccd";
> > > > +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
> > > > +	if (error < 0)
> > > > +		return dev_err_probe(dev, error, "failed to get regulators");
> > > > +
> > > > +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > > > +	if (IS_ERR(hx->reset_gpiod))
> > > > +		return dev_err_probe(dev, error, "failed to get reset gpio");
> > > 
> > > Can the reset GPIO be optional?
> > > 
> > 
> > I'm afraid I have no idea if the controller needs this or not. Would it
> > be better to keep it required until someone confirms otherwise or have
> > it optional for the other way around?
> 
> If you have a datasheet handy, or your hardware provides a means for you to
> test and confirm whether reset can be left out, I would make the reset GPIO
> optional. Often times, these controllers are part of a module and reset may
> be tied high locally as opposed to adding another signal to a flex cable.
> 
> If you have no way to confirm, I would keep it as required for now; it is not
> too cumbersome to be changed later if the need arises on different hardware.
> 

I don't have a datasheet unfortunately. :(

However, I tried to simulate this case on my board by keeping the reset
GPIO permanently de-asserted (i.e. high because of active-low). The
results are not entirely conclusive: The controller seems to respond to
commands and the initial configuration is read correctly. However, it
does not report any touch events. As soon as I add the temporary
assertion of the reset signal back it works fine again.

I suspect toggling the reset signal might be required to make the
controller come properly out of reset. I'll keep it required to be sure.

Thanks,
Stephan
