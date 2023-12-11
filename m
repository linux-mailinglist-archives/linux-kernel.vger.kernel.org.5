Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ABC80C2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjLKIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLKIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:15:36 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01BED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:15:42 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-dbc55ebb312so2150199276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702282541; x=1702887341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TXq9YTAU0K/Wyg67l3QF0mK1qAP+uioFbjUi30daDLE=;
        b=Gl7pQfnqeul1cqU4KjVecz+bNXrsTQXRIeny73E7zkFiC5jlDfMIjww7TeGgCkTMlY
         ZyLsSesDpAd5F9nveBiu0fSL07Q8ZEFwKzrlGDtWI7jZUBhKJXAXBWgWEf9IFdCoVyZT
         8xskZmgoLVUZ5iyMCcBulBxn+57jj4XowtU+wQd4lbhicECJ6dAVOZskPOCjPUasyO1m
         ZxonGzVX5mC/POYCPXaBaY0bbzHylJwldCdh2rqfHuMynYb0IjMqy6qdKo+ezUSGJnsR
         Xa7JlqdKlNNfRxXdo4Aza9JDgYi70Nri8oKh2kuICobsWtD6EkCY8gi0zJHNs3hpTaUs
         JVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702282541; x=1702887341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXq9YTAU0K/Wyg67l3QF0mK1qAP+uioFbjUi30daDLE=;
        b=hls4wXXdqm1CNHEDpakJxtf7MqDJ4U7O2eyyK/xaheOEf9mlGomsQUpgL7ge2QtZ0t
         MpfPt2QuFHgC/w4U55QXhhcr4IMd8hikL5QwO/FksOOBE4Llh5wuTfS/ODZzTArqcim+
         nmB4YQW3dX+CDIZfUyYeH6OIRi1doIDKnFK953qDN3lv7uaYtnPQCWK6s32o4AABY2un
         x21P56IpvoU+bR0TkOuGrqrejBrGhz0iAlPEb/OAlQ1Y8ZlwJ3t6h/aXcaby3Quduc/d
         fJowI2wqaCtREE1CM+s4zdZmFizPxKwP3WHcQlI3nLK7/9y7D6BJaHfBtBIg+7b6NQFJ
         rg0Q==
X-Gm-Message-State: AOJu0YzUSJ/T2uF+rTuiONZiH1xFDGxu6Vs3AXLE1HDSV8/nIUGH4k7B
        mHLtLExuQ8PxJ/ehrrOTwGvZHtpiF71gs5j3A3TqND8DzNJdJaAtimDf6g==
X-Google-Smtp-Source: AGHT+IEqQ1QWl9N8VrJdERt7hZAN05TSsYkaTWMXlqSVGHm1KL+k3i3fwo/Z1+5pnTt/WgCjEwjtbr25GU8ej2hs3FE=
X-Received: by 2002:a25:8f8f:0:b0:db5:4b23:534 with SMTP id
 u15-20020a258f8f000000b00db54b230534mr2204353ybl.17.1702282541327; Mon, 11
 Dec 2023 00:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20231211145056.23fbfd7d@canb.auug.org.au>
In-Reply-To: <20231211145056.23fbfd7d@canb.auug.org.au>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Mon, 11 Dec 2023 09:15:30 +0100
Message-ID: <CACMJSetGz1fCnqS_HPTLyV8dOWOUtO07-bZKKXu3=3Lk2PGdyw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl-intel tree with the
 gpio-brgl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 04:51, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pinctrl-intel tree got a conflict in:
>
>   drivers/pinctrl/intel/pinctrl-baytrail.c
>
> between commit:
>
>   c73505c8a001 ("pinctrl: baytrail: use gpiochip_dup_line_label()")
>
> from the gpio-brgl tree and commit:
>
>   6191e49de389 ("pinctrl: baytrail: Simplify code with cleanup helpers")
>
> from the pinctrl-intel tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/pinctrl/intel/pinctrl-baytrail.c
> index 3c8c02043481,9b76819e606a..000000000000
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@@ -1173,7 -1136,7 +1136,6 @@@ static void byt_gpio_dbg_show(struct se
>                 void __iomem *conf_reg, *val_reg;
>                 const char *pull_str = NULL;
>                 const char *pull = NULL;
> -               unsigned long flags;
>  -              const char *label;
>                 unsigned int pin;
>
>                 pin = vg->soc->pins[i].number;

Andy, please pull the following into your baytrail tree:

https://lore.kernel.org/lkml/20231208083650.25015-1-brgl@bgdev.pl/

Bart
