Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4689B7BBF8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjJFTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjJFTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:08:08 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0CAB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:08:06 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45274236ef6so1193984137.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696619285; x=1697224085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxlLhkoj1Kmhin2Qlx3Q+WrvoF0R0Cb9Ja4Y1YVu+4c=;
        b=TLDxoEpd1VVzP2mVNHKHE5dptEcJRqLnM8p/qOjD0CgPHt51KMoCLmd5kw1nzxcSWY
         yJNamVcOdDvcSGyjnliAn82Ky8Y63Z7IabIObEorEe9cIogWLZ5e8bP74QFLqjkg4zip
         FWFgfyWxf7PcJNAMeDQYPxhUyVWyF3a1+5qlbHHghJK1W0r6kuLePkF6M8lrdzk5exmd
         aJYstLDJ8Qew+l0SINgLx4F5p+FbNjYLrp8WZ8UWXpiDr3wyd1fbvCjXICu7wQ4yx+mW
         wGy0ug/gFbcSwavz4gXMQlt8USDnpXJGytFLgsbM1rnu62QUaby5f8/hTqK9NTnA+o8j
         4gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619285; x=1697224085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxlLhkoj1Kmhin2Qlx3Q+WrvoF0R0Cb9Ja4Y1YVu+4c=;
        b=wKukhDmytubN4H/LoUey8C9ellS7qlW2fE3hGw1toU4sNp2D8xnoKaC49ioDpwV7cA
         isCTQYtxIg8wvJoomsKHxeYU5Vqn+uVE+7JHQ+1f8DyZBnk0f0A8KOHFGR1fb2tDDenE
         YVtLjnm7oPwDeIqMb00bwjf42NJr9EEEj3hBqecxcNhkDdarzsXRtd02LV7IJ8OGB5X0
         ZtJlTLfmRhYFCwo4E1Qr92v1bv3yiFhqykhxhfAVaoCwEAV4xzqUfjDJ/wKEqvkIO9vu
         u95qZhxlV1SsAFOpgV0LfWJAghgnZrpAI+p08IkuZ9fnzCfAp5lOOhyafVHSLN6fZNlw
         1uZw==
X-Gm-Message-State: AOJu0YxiubQ86vwn3ukPhZtjprMMAyIZkp958LOn7Yo4wCcWLaymUB+U
        qBJh89VS7GTkPRcnAGcXMXWhbgUnnL1yF4KKIzwRLpGBMgt8BGDF
X-Google-Smtp-Source: AGHT+IG4YWnlNuzYQ3D7QfQ85iW7UB8nypued/rD9Y1v+Txs/czpFfkdZpjjbAeS2dURl24tCbNVSIcLGC9D4KBQ7Mo=
X-Received: by 2002:a67:fdd0:0:b0:454:2d1e:6ced with SMTP id
 l16-20020a67fdd0000000b004542d1e6cedmr9726691vsq.27.1696619285327; Fri, 06
 Oct 2023 12:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231006115147.18559-1-brgl@bgdev.pl> <ZSAIUVAQ6ifi8LTL@smile.fi.intel.com>
In-Reply-To: <ZSAIUVAQ6ifi8LTL@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Oct 2023 21:07:54 +0200
Message-ID: <CAMRc=MdrLSPCEsQ6OEgRX-7Wh7ka+Rczja=QjY-srozj3cz68w@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct gpio_chip
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 3:15=E2=80=AFPM Andy Shevchenko <andy@kernel.org> wr=
ote:
>
> On Fri, Oct 06, 2023 at 01:51:47PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > struct gpio_chip is not only used to carry the information needed to
> > set-up a GPIO device but is also used in all GPIOLIB callbacks and is
> > passed to the matching functions of lookup helpers.
> >
> > In that last case, it is currently impossible to match a GPIO device by
> > fwnode unless it was explicitly assigned to the chip in the provider
> > code.
>
> That's expected behaviour.
>

Is it though? We now have a GPIO device that represents a piece of
physical hardware that has an fwnode assigned and the associated GPIO
chip (tied to that device) that has none. How is that logical? It's
not coherent. I'm not surprised users of that code will be confused -
like Dipen in this case.

Bart

> > If the fwnode is taken from the parent device, the pointer in
> > struct gpio_chip will remain NULL.
>
> > If we have a parent device but gc->fwnode was not assigned by the
> > provider, let's assign it ourselves so that lookup by fwnode can work i=
n
> > all cases.
>
> I don't think this is a good change. We paper over the real issue where
> we and callers need to understand what they are looking for.
>
> ...
>
> > This is something that Dipen reported with one of the tegra drivers whe=
re
> > a GPIO lookup by fwnode does not work because the fwnode pointer in str=
uct
> > gpio_chip is NULL. This patch addresses this use-case.
>
> I am not sure I understand the problem here. All these should have been
> addressed already, no?
>
> So, the GPIOLIB should use dev_fwnode(&gdev->dev) inside it, outside it
> the GPIO drivers are free to use gc->fwnode as long as they understand
> the lifetime of the respective object.
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
