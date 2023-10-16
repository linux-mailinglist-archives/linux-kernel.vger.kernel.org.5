Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353257CA891
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjJPMyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:54:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07396A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:54:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59e88a28b98so37729497b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697460877; x=1698065677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/f+7YFh/6osBiwAV+h/Emo8XmTTY549abIctApwupw=;
        b=ixExQdjICwf7Hh80IFNCXjM+ha1PVKOk1BJr7t2CTgdNzENilrtNFWYsGW2hWk/OjM
         DcjD0IP0y1Q9iY99KVt4PcvWC+2HWxtiExhaFKG9nTqUZuDlUjl/aDb95DU8w8emE46B
         wi0WfcdqH5xe8XB7yr6wlQ0fiwP4JaA8Co0guWaBNX4QGdShkLDbmnNisax+3NBoY92U
         tNXl826VSCPYQktPFvWXO1zpm6eO8K9jmRMrJN8/R4IWdhpNuEPiA4pievALaltcpxnl
         JASEWtDdNuSE/+MuIvbEJv1FF1/vf0A6NZapmgACHn8jdLDZ6b5mcQ+HH1vQPwaPTGdZ
         pivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460877; x=1698065677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/f+7YFh/6osBiwAV+h/Emo8XmTTY549abIctApwupw=;
        b=X+ZGBbytiYgxtijvj+6zg9aF5tQ8Bfjrleh9yFp+igMWQ5MfoeEZDJgamyukIC58SA
         TTzH4P52V0di1yU6hoQZMcVV3NwpfmoqXaovyAc0oelmGjWT+C7fGU/+/c2EobFOiofw
         Rf/gid/O0E7FJfxqILKWb8hhvj3D2DtcwPPYxDZIx27t9bUFDvlNjrZwbRTf06hMQC0v
         tx088kdfeB1IMkc0Wdh09q/BhtyfuggGvk8F1qkYlFYb558J1HbpIFJWEa+ZO4nK3KhR
         22d4seKhN2cfgMNKPedLBFE/HKCinUVizWs9a5dxFF/nmcU8BjqRv8fVN29jTZIWNIJh
         RgCQ==
X-Gm-Message-State: AOJu0YxDWybEdj3egLAZKuWoSDhdDtBS4gIsnp9cPU4A8fIacGM54hax
        ZfRiHU4bo908Tt3z8qMUjFEyRezlXTDw9JAFU1m4Zg==
X-Google-Smtp-Source: AGHT+IEIO9ua7hyWa8fA/t5JFZ6FfnNcKJ/jZvoD622EiDhisoWGG+6/Eq/ikTva7/Wckm9tAOVlDvR8nXdSjObadzM=
X-Received: by 2002:a81:520a:0:b0:5a5:575:e944 with SMTP id
 g10-20020a81520a000000b005a50575e944mr4339145ywb.4.1697460877194; Mon, 16 Oct
 2023 05:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
 <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se> <CACRpkdaMj2XFcwqaSiRSA2A41zYsW=AG_Fi7v7AjbuLBByxVaQ@mail.gmail.com>
 <948548a0-d132-4f5c-819e-40bacb367be4@axentia.se>
In-Reply-To: <948548a0-d132-4f5c-819e-40bacb367be4@axentia.se>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 14:54:24 +0200
Message-ID: <CACRpkdb=a-QVdMpzBHLDrFrK-rmkQD9ddueL=yuXe2ScL33zEw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:05=E2=80=AFPM Peter Rosin <peda@axentia.se> wrot=
e:


> > Just raw (with neither offset or rescale) doesn't make sense, since
>
> And I don't see why not. That's the crux.

OK I can implement that, but then we need to define the priority of
"just raw" vs "processed". It is quite common that ADC drivers
provide raw and processed. Which one goes first?

Right now the priority is:

1. Raw + scale, if scale exists else
2. Processed

After this patch the priority would be:

1. Raw+scale OR Raw+offset if either scale or offset exists else
2. Processed

How do you expect a raw channel to be prioritized?

I can only put it last, as putting it second would break existing users
that provide both raw and processed. Is this how you imagine this
to work?

Further, that could be a separate patch on top of this so it is a little
bit of feature creepy to push into this patch, but I can make a 2-patch
series if you like. It basically does not block applying this one patch
on the way there.

> > the AFE rescaler does just offsetting and rescaling, in that case the
> > user should just use the raw channel. Also it would then take
> > precedence over a processed channel (which applies rescale and
> > offset internally) which doesn't make sense to me.
>
> Why isn't it perfectly fine for a device to provide only a raw
> channel and then expect that to be interpreted as the real unit?

You're right there is no problem with that.

The only problem I have with it is how to prioritize it.

Would need Jonathan's feedback here too though, I might be
missing something.

> Why would it need a processed channel when no processing is
> going on? E.g. a device reporting the temp in the expected unit
> in one of its registers. Or whatever with such a friendly
> register.

Good point.

Unless someone would call that a "processed channel" albeit
processed in hardware. But this definition of raw =3D=3D raw register
reads works for me.

> > I'm not sure I fully understood the remark, please elaborate if I got i=
t wrong!
>
> I agree that the patch does exactly as you intend. I question if
> what you intend is correct, but since I don't know the rules, I'd
> simply like to have the rules clarified.

Like I know the rules :D

Whenever I do anything in IIO I feel like Socrates, all I know is
that I know nothing.

Yours,
Linus Walleij
