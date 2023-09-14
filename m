Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF27A038E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbjINMRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjINMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:17:02 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B6F1FC9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:16:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81a4b96a86so308639276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694693817; x=1695298617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr+llaI5KQeooOMwZpfHvY4lngd1AofNhZErF5ZMjrQ=;
        b=DQr6ovxBcWfbud4kiE4WnHiQxwwZgK7DFaczKXoQGkF45/t6uHFzjvrdANaoATRvCa
         Nokly/4zkydGsZ1EnCi5A/MJxkuvDBt6Gz2RwWydOPWP+GdtE17ceM2EWHtIDQpRSjgk
         jAtmY1hQVFcE9eQJScDoah1maMvzoO3jWadeeotfELOHLZ5FiclD8GP9v0eqmxjdvmLT
         dxUv+P1ILJiTdY4Zrzhqs609My3IQGg5uLWPscyRQEWJzF75ln+w8z2vAL/Oa2eBb8dn
         AAUF3LLHc+EujKbAXpGnMWJOUQZQb11Zagr5TVRPvHnx55/IlvUpK+i4eW7vtjgMgqz4
         plFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693817; x=1695298617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr+llaI5KQeooOMwZpfHvY4lngd1AofNhZErF5ZMjrQ=;
        b=VedsAJkuJ1SOZIrhrhL958XpVf36CfTkiastBjVa2LlStL0Du0N6+ihkTKJoVE7C6D
         ytY3FN246nZ288oFr9kzKMhUigVyAZq8QEciUgyc5TJLmJTynhArVuH4WU7+1SBuJCMU
         twmX3qaPLSkKRIm3Ht3nN5l2qZ1yEZVOCdJYW0mkWxZiX8h9rTvinuWADmAlJT9zSfkm
         SqXDVBgOZg8hvSjc6L2gV4PTnf3icuvlCLLBtU6a7XzdW0FIpwVy3ZBhRGIcoYz4S+Tk
         mhGAGEZzX5SmiBN7B4fnRmV+Zv7XjQ2WqpA0xk77MzAOnkPZ0I/5IjFxPKv5rEY5x4f7
         976g==
X-Gm-Message-State: AOJu0YwUH6MzzAaCDyV+gyONHYeUDei1cGndbq/J0Fihzza5v/vdHN4h
        iAynvpQHHBHDzQSY9uW3j0keWwzQMjUvz+62qXZh0g==
X-Google-Smtp-Source: AGHT+IGy47RyRdUCvMqANoPaoR6Tn7BvENA0d/H15MygaC3tgtS2zUr1kqNSdPGpbC+cdFyfG/H6N87XJuUgcjYAYUg=
X-Received: by 2002:a25:ac4b:0:b0:d81:754a:7cb8 with SMTP id
 r11-20020a25ac4b000000b00d81754a7cb8mr3274641ybd.65.1694693817406; Thu, 14
 Sep 2023 05:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com> <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com>
In-Reply-To: <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 14:16:21 +0200
Message-ID: <CAPDyKFrX1JNBio1tm4TbOwO4KSGP5ZHsLbJEXVv8qn-2Cq_KJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Remove preprocessor directive
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 09:18, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Mon, Aug 28, 2023 at 12:04=E2=80=AFPM Balamanikandan Gunasundar
> <balamanikandan.gunasundar@microchip.com> wrote:
>
> > Remove the preprocessor directive IS_ENABLED(CONFIG_MMC_ATMELMCI) while
> > checking if the device is compatible with atmel,hsmci. Instead handle i=
t in
> > the if() condition. The compiler optimizes out the entire if() clause i=
f
> > the first expression in the if() clause is constant false.
> >
> > Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@mic=
rochip.com>
> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks for tidying this up Balamanikandan!

Linus, we didn't manage to get this into v6.6. So, it's probably
better if you pick up this via your tree for v6.7.

Note that the commit message header may be a bit misleading, as this
is really a gpio patch. Maybe you can amend that when applying?

Kind regards
Uffe
