Return-Path: <linux-kernel+bounces-108404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A7880A11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB75B21F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29B11182;
	Wed, 20 Mar 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9MrosA2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324D7101EC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904380; cv=none; b=pJB2Q+lcsAZ3FLO3AF/je+rr9meiS9xa0VuazoBwfl+NQ+TxRpA5pFmq1ONQAXgORtEjR+Ta4Q7ntHB2NlJps5wvcWvkMyWlSn7RPCji+hp9pOBU7ojhWvmLxTzt+Y5refPprPJgbqvFr2KgGP6AzBE/3HfwZ493bLiL6LO/SCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904380; c=relaxed/simple;
	bh=MkTo9AgYFtSpar7DGnEwJDDLlqzlsy4tkwWpmW8VVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I41Yi+A/gHA3nY+LellP8XF+rptbKD9nV0A0IbgU26nNdS5cCOtm9yf5B/V8vkGj0hZGFXBmV6fP/tru8v1xkQuOhrH/l3fag1RLNXzZBpDpaipALY1HiM5PaPll+QSuyNugJreUY8Ka+osF63RXwKCMSkWoOIY+ceRgQ88gJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9MrosA2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dca3951ad9so41905495ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710904378; x=1711509178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/dBjb6ZzHDt5IdrLC5Pn/vI9AYnLeEEBZwmmyh0/uJc=;
        b=m9MrosA2gLEmG56Rq3LY0DT0cMT3O/+zaYSagzTW7t964JgI2GFBivV3smVlnplLkB
         MQZeUPd/b/VGgf4pa7V4yrfGfYXta7CNOzhvURD04+Rrui4Z/IWWtg31ngQ7hpXC8IFd
         EKRUeIjzsuBpqWJW8P3f+WHnczgvl2Vr7y4flp3Qk024QUmqYyXNHa4/+AME5F/4JgAd
         3lGbgf3QauyE0e5hflNjf66kRmwif+ODWw+aWSB5imW9OawuLdGAT9Y0ucSNjn+lKffu
         zSeI5TbmfKaDOjjlKnUJsjl04p98ps2uac/z4VbFYq4FXscfrgxtQPj7J/3FcQcTeqe3
         5Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710904378; x=1711509178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dBjb6ZzHDt5IdrLC5Pn/vI9AYnLeEEBZwmmyh0/uJc=;
        b=Jbw79RKifdLtEcFJOF5MvyOGkjKKv0hE3vN+NO8CJ1DC4QeQPtJrouPl2feVTBE6X6
         BS+ZZ1VcqCQjweTQicH8Fp7qmIM7w6qoJP9yfJyJ73jqFym0YIaIby4dGVeiZthCL8Kd
         S169MIMFpOwOjcOiYVVr9oddk4/kPMQdLaAHBYW90CXT5VzmQSDM/cBpoG+LZSVzOQcG
         /TcM8niMIko4OvFt/4yOAaWTKlj+28GQlgBOdnCEYJ7tXASQ+XARltIJQmj9k1Q4Njmu
         s213YHVNGkf8GyQaPXoriA5VfTL9HCCLuMujMelW7Qp6g7w9w+mRjJMhDXu5mbhBaBL4
         mEVg==
X-Forwarded-Encrypted: i=1; AJvYcCXkgD0GChgh0ADLCeuwV9kbchY09eAbaNEjpOUaL/ZJjakjYFwI0dTFOHidP1cbECUaBYmDq3jdwL+x9Yo+27hdysxoDrYjqGuGHjqz
X-Gm-Message-State: AOJu0YyxB9Najq03Nu/Am0W8MUUlU/0bQX9ef9X4xVdocnJjqF+uUrd3
	Vk3z0VEnKdjkl/5T2DM+soYSdGxEASz37LOlRjfi05LO0/hxhllf4ghZzlp/wyI=
X-Google-Smtp-Source: AGHT+IGCIhNUzarpXf/iw4svQe5Q68IZUZa/AEwi23yimLrE9yA4iG8dBuEZUgBYo+cfmBQ6tE12uQ==
X-Received: by 2002:a17:902:e94f:b0:1dc:7bc:d025 with SMTP id b15-20020a170902e94f00b001dc07bcd025mr5783515pll.4.1710904378250;
        Tue, 19 Mar 2024 20:12:58 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b001ddb505d50asm12270883pll.244.2024.03.19.20.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 20:12:57 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:42:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
Message-ID: <20240320031253.eutoon7l7nkjehft@vireshk-i7>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
 <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
 <99afc631-c02b-42da-a8d4-87c65087f390@quicinc.com>
 <5dedcd26-ed59-415f-b978-87a546a0816d@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dedcd26-ed59-415f-b978-87a546a0816d@opensynergy.com>

Hi Harald,

On 19-03-24, 16:05, Harald Mommer wrote:
> On 18.03.24 10:39, Haixu Cui wrote:
> > On 3/4/2024 11:43 PM, Harald Mommer wrote:
> > > +static int virtio_spi_probe(struct virtio_device *vdev)
> > > +{
> > > +    struct device_node *np = vdev->dev.parent->of_node;
> > > +    struct virtio_spi_priv *priv;
> > > +    struct spi_controller *ctrl;
> > > +    int err;
> > > +    u32 bus_num;
> > > +    u16 csi;
> > > +
> > > +    ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> > > +    if (!ctrl)
> > > +        return -ENOMEM;
> > > +
> > > +    priv = spi_controller_get_devdata(ctrl);
> > > +    priv->vdev = vdev;
> > > +    vdev->priv = priv;
> > > +    dev_set_drvdata(&vdev->dev, ctrl);
> > 
> >     ctrl->dev.of_node is not set, so the child node cannot be parsed. I
> > would say, it's necessary to support the virtio spi device node in the
> > format:
> 
> 
> What you most probably want to have here is
> 
>   ctrl->dev.of_node = np;

Looking at how i2c-virtio does it, it should be tied to the device itself
instead of its parent:

ctrl->dev.of_node = vdev->dev.of_node;

> >     virtio-spi@4b013000 {
> >         compatible = "virtio,mmio";
> >         reg = <0x4b013000 0x1000>;
> >         interrupts = <0 497 4>;
> > 
> >         spi {
> >             compatible = "virtio,device2d";
> >             #address-cells = <1>;
> >             #size-cells = <0>;
> > 
> >             spidev {
> >                 compatible = "xxx";
> >                 reg = <0>;
> >                 spi-max-frequency = <100000>;
> >             };
> >         };
> >     };

Right, some work was done in the past to standardize these compatibles:

$ git log -p --stat --reverse 0d8c9e7d4b40..694a1116b405

-- 
viresh

