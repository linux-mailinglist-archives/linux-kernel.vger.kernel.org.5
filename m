Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E407E497E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjKGUAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjKGUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:00:07 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22684D7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:00:05 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4ac28bd2857so1496898e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699387204; x=1699992004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmxNlG3FaaeRhvK7Wue3XiQAUdscNV2HmALcVPSxmxM=;
        b=cEPbNLPOmnWbDCOi3L/oMqpFe3oObx480Uh+mjrAD6e9oe8gsXI/YLaNl+RAjkPAg7
         /eH0clR1Hjotu9FneBWxDnymgRFw9mWF/VcCbBsFTE2B0XUaoBE4zuTngldp5dLBTf4R
         6567yTdmlccVX1P6imWQRjGnnjTgWN/Rat/IaoMjKlvqIVX/qBlhoddBDLhc41buXxlQ
         z9HWTq9bOgG686OxI+t+FLYYtFdqrPtwLqkDo8Sh5WSf+o/FaBZ9fzUGeG1Klpl/Sd7u
         L8ElbEwvjK1l0nlPFb9Y4dub8ma2hwReOZdNzPCRyjAGf45nkT22ZsFB+Q7/ktm7JCi5
         Utxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699387204; x=1699992004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmxNlG3FaaeRhvK7Wue3XiQAUdscNV2HmALcVPSxmxM=;
        b=dWqcuNck7mhZbcDSoB3D+n6y8YjrW1CFPqOCKi67Kx3sDtDuCoK1B9hBPstQpQGs5s
         N094/SmKWtD/DAydcItf8FPSxlKc/lilgyHb22poh5822UnjUSui8H0IVv4Vyi78KkNX
         UQbSAqu4zRV25/DptuhjCvewtVVp+lRRLYGb0CAYDEyzH4mHzRWDqeYkZmnE3CU6FjQe
         wO41qYB0obCZzsv+TpNHGhEWGqc1vnlhd3/icsE4h/XdbEXZ+J2DQXabJFej/R9l8egv
         2t2dHq8Ja7p5vMgeJcH9H0tha/yn19s2mlft2FnGsDccvvwTtqvjyA4GzxUg1pgwD+e8
         fwMQ==
X-Gm-Message-State: AOJu0YyRGwsjOSiAuU03bx3AHOtKXJB3eU+PcUvP4D6JfXO4AZTkeJO5
        gTElUF5jWGi3/+E1uKIw74DCwPNQ4ULqXLT997Y=
X-Google-Smtp-Source: AGHT+IEBsnIl1hunqub+h18HwKd4ax6cBTYLlFha49VxNSZYLAu23BZOwK5YBq+66A0PNrlEyT52vtBvqwOIjjKsTa8=
X-Received: by 2002:a1f:a851:0:b0:4ac:67f3:e0b5 with SMTP id
 r78-20020a1fa851000000b004ac67f3e0b5mr5169469vke.11.1699387203974; Tue, 07
 Nov 2023 12:00:03 -0800 (PST)
MIME-Version: 1.0
References: <202311051347.7J6bthD7-lkp@intel.com> <CAHp75VfmUXgx3nkFR=dZqffOu-LSnU_9u9GRYy0bTPLcdYhHbg@mail.gmail.com>
 <ZUdFtJeXBtx/httL@rli9-mobl> <abdb00c4-c2f1-96e6-9731-5a1773099336@axentia.se>
In-Reply-To: <abdb00c4-c2f1-96e6-9731-5a1773099336@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Nov 2023 21:59:27 +0200
Message-ID: <CAHp75VeBgdSYE6=2q6kc+N6JDg_fy1Mc5DUJdJBmyZ8nnX8ywQ@mail.gmail.com>
Subject: Re: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined
 but not used
To:     Peter Rosin <peda@axentia.se>
Cc:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        oe-kbuild-all@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 11:31=E2=80=AFPM Peter Rosin <peda@axentia.se> wrote=
:
> 2023-11-05 at 08:35, Philip Li wrote:
> > On Sun, Nov 05, 2023 at 09:09:00AM +0200, Andy Shevchenko wrote:
> >> On Sun, Nov 5, 2023 at 7:03=E2=80=AFAM kernel test robot <lkp@intel.co=
m> wrote:
> >>> commit: e9e40543ad5b38b848879768359fd13650529961 spi: Add generic SPI=
 multiplexer

...

> >> I dunno why it's pointing out to that commit and some (random?) people
> >
> > Sorry for the incorrect bad commit, Andy. We will investigate this why
> > it locates to this commit in the bisection process, and try to avoid
> > similar wrong report if possible.
>
> In this case I think the reason is that you have CONFIG_SPI_MUX, which
> seletcs CONFIG_MULTIPLEXER, which in turn makes CONFIG_MUX_ADG792A
> "visible". I.e. before the fingered commit, it is likely that nothing
> selects CONFIG_MULTIPLEXER with the given configuration.

The use of the of_match_ptr() is quite doubtful, no?

--=20
With Best Regards,
Andy Shevchenko
