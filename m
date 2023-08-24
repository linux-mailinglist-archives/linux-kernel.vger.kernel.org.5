Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72BE786A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbjHXIe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbjHXIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:34:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE0172C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:34:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d77ad095f13so1840724276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866048; x=1693470848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx1JCcPjCZYdIsabGARYPpE09xWgY39/BIHBUOtvlRM=;
        b=yVZ0C6CryfeJ4SCnXKGUOcALhdyv1slpp7Ji0mGhkwM/usN3pjhkbw5Qcn5OCR0/Zc
         lGxRql8lTAOUaN3ONlHHbhf9IIWbdAd+nvegIwda0c7P6jkG0y3OOaZ6T12Gta+n1BS2
         XC1oTUwsZF9Idw+EcxIiRk902F4Ix4t8aTWIuNNTmliRVf/louFFkAP7o3RawwEtJYB0
         uGF64e1sIK9/Gtl7RdI+6Sq4J+35kqOvfRerfLjcOdN2oGg5vZX7h8pcV0BzggJQOkT7
         j86kPWrB5+x8UgcTBVozyU9CgIicOMtg10Uh6EhSSxek/EwfSRt6iseGWJ57i960GeiD
         B9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866048; x=1693470848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xx1JCcPjCZYdIsabGARYPpE09xWgY39/BIHBUOtvlRM=;
        b=RCvLoQBYYHlAJtpXWkJZWAoCcN9XEl25dGfa/PB4kq799yEwyg5MvNE3MPuMLA7XO6
         P9jDswJ5d9W/XEz/I++EuTRwSPtgJEDuNAWxxDVXrGhVnw3cDXD3ys3VWKKF1K9n3aux
         jl7cG9H5/avh7fMjerdP5/EOb2sESiHsH2ZpW8HilVXPc+eIKIMwxBLSxXw/7f4eywge
         IW4LmiP48J9MTw9cqzHqplU1qIVV0noSYjab8bW4OapQLmUaaanF3hw84O17uuAfCc8B
         y0MmamxgGaNuMRk1E/hqAfz1gdlb5JYIDEQPFgER3vALm9/pUqoxwAweQRIcOUVAFWKI
         PIvA==
X-Gm-Message-State: AOJu0YxmJsOBaSvB0d1A2gXG4eu5YgCkOzV0HFLwAqLXqAcjbEAubCIm
        19R7aJF8HgOKe5uI6kwrQE7YLhoQjuqoIj92Iy59Vg==
X-Google-Smtp-Source: AGHT+IEcJo7laVcyul2RySXcC4CyDoAj9lDi1bP6HOIeX0rCNYWlI+yADeeg7TSYUDFTmKqvliuX3LiW9/B3JDL/M5U=
X-Received: by 2002:a25:8689:0:b0:d0e:2e5c:2f80 with SMTP id
 z9-20020a258689000000b00d0e2e5c2f80mr15306360ybk.64.1692866047844; Thu, 24
 Aug 2023 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
 <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
 <CACRpkda2gJkj6_25rnLUHNaLC3_kcSbCF+y6RRvbnUsju-iJYg@mail.gmail.com> <63156971-6f3d-4023-90d9-98adc000a32e@microchip.com>
In-Reply-To: <63156971-6f3d-4023-90d9-98adc000a32e@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Aug 2023 10:33:56 +0200
Message-ID: <CACRpkdY83_nQx8tWRV9SJyD=-SvY+30FiSXkrb5vKkd+QfuPaA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
To:     Balamanikandan.Gunasundar@microchip.com
Cc:     dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Hari.PrasathGE@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 8:39=E2=80=AFAM <Balamanikandan.Gunasundar@microchi=
p.com> wrote:

> >> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> >> +       if (of_device_is_compatible(np->parent, "atmel,hsmci") &&
>
> The only difference above is "np->parent" while the existing code uses
> "np". This is because the compatible string is defined in the parent
> node here while the others have it in the same node.

Aha. What about this right before the for-loop
then:

/* The Atmel MSMCI has the property in a child node of the device */
if (IS_ENABLED(CONFIG_MMC_ATMELMCI) &&
of_device_is_compatible(np->parent, "atmel,hsmci"))
  np =3D parent->np;

Yours,
Linus Walleij
