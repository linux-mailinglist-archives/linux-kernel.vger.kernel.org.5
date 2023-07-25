Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14EC760E15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjGYJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjGYJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:12:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A010D1;
        Tue, 25 Jul 2023 02:12:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26834a73b8dso365181a91.2;
        Tue, 25 Jul 2023 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690276345; x=1690881145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy4cplgUNKS/9BcirQhDIU2ZvQMme3avaAgjDUzLJFI=;
        b=Prlvhi+W3NQigLGT4jThq88LFysqxcqnyIKmuPJdKUnzioowF3f4q/higXZowJ/hKt
         s3cHWWSCReTLuRDyFUgab6YxWa5ptOtLDtDdrWV4hZAjCaYHaSrXOMzJi8o2jMsLCCz2
         OUo7sayJw/xDH7y46LzpxLG8rE8BGVC0yDeONls8hZ3HW7IJaI8H3gZ/Udvizs/4fXZT
         etx9DgZcDmoqp3iOG0NklLQJZg8PDuwJyv++3WdW+hgtQu3HbobYXlIahU9UuSON9qCn
         z/ZD4/2VO67p6bHtAbUAnPd9EnWew4bmy/arprpFJRdccBSdb0IEAqreSGLBuhW9tR34
         Oh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690276345; x=1690881145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy4cplgUNKS/9BcirQhDIU2ZvQMme3avaAgjDUzLJFI=;
        b=SociSeF3r1aKrmuRvKa5SrlTMRor6GQ7a3TsdSQpMS6qcipCCMLI/eR3VcgGOogaFC
         NsXdi6gjQxuaA/B/05EMmLnnv+AQ2x8p6HgSwt5BZIa+nZvERl53I3cR+dD9OPtsgTJ1
         r4fRxlBYV4a4z3i3GKZiFX/gDkkVhJhBymAjxR3pBc6EpKmh094qnN0g/isjOuxor4z+
         iTqjSU5cuc+O8w7/IaHKJGYwQ83Dum0OKawSSLycZYdwcO4u9dWNk6RC0RMlHNKU8egr
         NbkZ4Gk3a/eZMYwhDU/BHjaBoCcYGkWrEqweDk+0GtvDWw3ebeyN0mDOR3gXAUGQy+P+
         xdyw==
X-Gm-Message-State: ABy/qLa0K1hU5RIjasa4wusiBd47Ssdj2cCD/KpEVQ8S2TcsNHdsJdVC
        uYV7A2d4WJkHShULbvjjMYS3ASwbYdgmsqbDVlA=
X-Google-Smtp-Source: APBJJlGyXl77l7rNbCiEBT6wuO+tKE75bot9gLJIEjBVAep3CYCmhlB26HO/n36iO05IO1h9jceGOIu0ZO0UNSO8dus=
X-Received: by 2002:a17:90a:ce83:b0:267:f893:d562 with SMTP id
 g3-20020a17090ace8300b00267f893d562mr6667046pju.8.1690276345470; Tue, 25 Jul
 2023 02:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230314092311.8924-1-jim.t90615@gmail.com> <20230314092311.8924-2-jim.t90615@gmail.com>
 <519312b6-f28c-7482-21c1-d9628f0295cb@molgen.mpg.de> <CAKUZ0+FGSEgzbK6H_sHaGpP9JnvrLeBRQViqmViR1OVXoVs7vA@mail.gmail.com>
 <45cf294e-3124-9a0d-864f-ba7c605405c0@molgen.mpg.de>
In-Reply-To: <45cf294e-3124-9a0d-864f-ba7c605405c0@molgen.mpg.de>
From:   Jim Liu <jim.t90615@gmail.com>
Date:   Tue, 25 Jul 2023 17:12:12 +0800
Message-ID: <CAKUZ0+GcnDNY8rmM0wi920LSCqFdMY0UCGmxqn_RMwLbdr5Jxg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Paul

Thanks for your reply.

> If this is paid work, using your company email address should be
> preferred in my opinion.

because I can't use company email to send the patch upstream.
So BMC NPCM all drivers always  use gmail to send the patch.
It's the company mail security rule. I am sorry about that.
After the V3 version I changed to gmail.


> One byte would also fit into `unsigned int`, wouldn=E2=80=99t it?

Yes, so should i change u8 ,u16, u32 to standard `unsigned int` is
better than now?
Could you provide more information?

Best regards,
Jim



On Mon, Jul 24, 2023 at 10:44=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Jim,
>
>
> Am 24.07.23 um 05:04 schrieb Jim Liu:
>
> > sorry for reply late.
>
> No problem. Thank you for your reply. Some minor comments below.
>
> > First, thanks for your review.
> >
> > the description is as below:
> >
> > The SGPIO module can be programmed to support from zero (none) to
> > eight external output ports ,
>
> No space before the comma.
>
> > each with eight output pins (for a total of 64 output pins). The
> > output ports must be serial-to-parallel devices (such as the HC595 or
> > a faster equivalent).
> >
> > The SGPIO can be programmed to accept from zero to eight external
> > input ports (IXPp), each with eight input pins, supporting a total of
> > 64 input pins. The input ports must be parallel-to-serial devices
> > (such as the HC165 or a faster equivalent).
> >
> > you can add hc595 and hc165 ic to get the serial data from BMC and
> > send serial data to BMC.
> > This driver can expand  extra gpio pins up to 64 input and 64 output.
>
> One space before =E2=80=9Cextra=E2=80=9D. Maybe:
>
> hc595 and c165 ic allow to transmit serial data from and to the BMC.
> This driver can expand extra GPIO pins up to 64 inputs and 64 outputs.
>
> > i will use jim.t90615@gmail.com this mail to upstream this driver not
> > company mail.
>
> If this is paid work, using your company email address should be
> preferred in my opinion.
>
> > The driver needs to fix the length of the variables, because the reg
> > size is one byte.
>
> One byte would also fit into `unsigned int`, wouldn=E2=80=99t it?
>
> > I will follow your suggestion to modify and upstream again. If you
> > have any questions please let me know.
>
> If you could use Mozilla Thunderbird to reply easily in interleaved
> style, that would great.
>
> Otherwise, I am looking forward to the next revision.
>
>
> Kind regards,
>
> Paul
