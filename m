Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9B7CC6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjJQPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344239AbjJQPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:04:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E427766
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:56:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d1aee5aa1so4299240a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1697554586; x=1698159386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3gd0Gezxir5QATSsJeNa9WRo2ZrSawXsEvPQ5V+cdyA=;
        b=LJxN4FX1zZkJqhMtBTs0UbsuIVgZ4EBpPUeth+mFjzvUvKadEUUXBsNEDxYfamysmj
         VMf238lpii/CigCKwPpDxxvhsGtLr2xRmJ5wajZKJ1Sxd30ZMhBXQ+2Ytw9mxFUobuAd
         HwxvtgnYD5m8uRyeMLbCIqsKp8UBVoOCn9eCsu1XbPJVuBuWfXvZcE1y5crbRcFj6ocS
         Q7XyQNSRindyoYDTTJV4sT6jjvgBTDssBFHjZ9dN5Lqx1uMdVvU28jzETbQmFT6cQaJq
         j9tBm7D7jZcMdG23wEPseHovJNruJqvMFzWipARo7tiEL4hSJVF9Z+msd5SrVhqQFW/X
         bEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554586; x=1698159386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gd0Gezxir5QATSsJeNa9WRo2ZrSawXsEvPQ5V+cdyA=;
        b=PKyGw8JWOXLxLSdAQBowT4tK9woHmgGlcyDsR+nuZxxFWpErO3YS7/gONbW+hy0ShU
         TRgcM2zOJJwXoW/ebVfF2jR3vOOo73f1K4dHRl4yMaAq/dIAH402JmB+o8ipr6+mXB91
         wpxqcrZTOv1doR1DABB9IS1JF0rXHXP//bsw8m9a/Qd3GnuXVq1MgMwDNLF1gYZjgmS1
         X1iAMKWINDzisqmCCoqRXbPzuE+n+n2g9Oymf5dgeke+PddvQ5wztsVdISmsKpNs+W8J
         GPE9J7d1qPHEjedtBb5ZN6CaqS62pHkmgJGnqM5BwFaDQbv0WS9mxCSmsgQLUrsFHj5A
         xxWg==
X-Gm-Message-State: AOJu0YzTfgt0mu7i7anw0HFxEf+PPnQSVixqQoEtS1jludSXVG8XASHC
        DzMq5mN02yMvfUG8rFQYRgSv5moRbNe4viLU55WVzg==
X-Google-Smtp-Source: AGHT+IFkPdIp9SqODT7PVHNkBCadz9jJx+BVHFYHmQo/8sTxpsV7ScWPFIs0eApSjk4znFY/ydzqpHVN5DH0w9+oOdw=
X-Received: by 2002:a17:90a:e393:b0:27d:63f1:2d24 with SMTP id
 b19-20020a17090ae39300b0027d63f12d24mr3166962pjz.0.1697554586521; Tue, 17 Oct
 2023 07:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231005134541.947727-1-naresh.solanki@9elements.com>
 <20231005134541.947727-2-naresh.solanki@9elements.com> <20231005230008.kw3u76gmudpia4cq@zenone.zhora.eu>
In-Reply-To: <20231005230008.kw3u76gmudpia4cq@zenone.zhora.eu>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 17 Oct 2023 20:26:17 +0530
Message-ID: <CABqG17gUKwE-wM=Qc5MV2N6NqdjXqmvbALgVvn8HTY+P7KRBWQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: muxes: pca954x: Enable features on MAX7357
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,


On Fri, 6 Oct 2023 at 04:30, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> Hi Patrick,
>
> On Thu, Oct 05, 2023 at 03:45:40PM +0200, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Enable additional features based on DT settings and unconditionally
> > release the shared interrupt pin after 1.6 seconds and allow to use
> > it as reset.
> >
> > These features aren't enabled by default & its up to board designer
>
> /&/and/
> /its/it's/
Ack
>
> > to enable the same as it may have unexpected side effects.
>
> which side effects?
>
> > These should be validated for proper functioning & detection of devices
>
> /&/and/
>
> it ain't WhatsApp :-)
Ack
>
> > in secondary bus as sometimes it can cause secondary bus being disabled.
>
> Is this latest sentence a related to this patch or is it a free
> information?
Its related to the potential side effect of the feature if enabled.
>
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>
> [...]
>
> >       else
> >               data->last_chan = 0; /* Disconnect multiplexer */
> >
> > -     ret = i2c_smbus_write_byte(client, data->last_chan);
> > +     if (device_is_compatible(&client->dev, "maxim,max7357")) {
> > +             if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
> > +                     u8 conf = MAX7357_POR_DEFAULT_CONF;
> > +                     /*
> > +                      * The interrupt signal is shared with the reset pin. Release the
> > +                      * interrupt after 1.6 seconds to allow using the pin as reset.
> > +                      * The interrupt isn't serviced yet.
> > +                      */
> > +                     conf |= MAX7357_CONF_RELEASE_INT;
>
> This setting comes as default, what about the dedicated reset
> gpio pin? How is the driver going to understand whether from the
> irq pin is coming a reset or an interrupt?
As per datasheet,
 RELEASE_INT bit in conf is cleared at poweron.
 The RST/INT is dual function pin.
>
> > +                     if (device_property_read_bool(&client->dev, "maxim,isolate-stuck-channel"))
> > +                             conf |= MAX7357_CONF_DISCON_SINGLE_CHAN;
> > +                     if (device_property_read_bool(&client->dev,
> > +                                                   "maxim,send-flush-out-sequence"))
> > +                             conf |= MAX7357_CONF_FLUSH_OUT;
> > +                     if (device_property_read_bool(&client->dev,
> > +                                                   "maxim,preconnection-wiggle-test-enable"))
> > +                             conf |= MAX7357_CONF_PRECONNECT_TEST;
>
> How are these properties affecting the economy of the driver? Can
> we have a brief description?
Not sure what you mean.
Are you asking for impact on the driver or feature description ?
Note: These are chip features & this patch is intended to enable them
based on DT settings.

Regards,
Naresh
>
> Andi
