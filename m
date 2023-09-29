Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1297B33B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjI2NeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjI2NeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:34:01 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B18CD4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:33:59 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49d0ae5eb7bso554840e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1695994438; x=1696599238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+xdIamtWar0MYfhb0rDcSmv8dCB5Xt4XPVLRYRJ3b4=;
        b=DfKq+khyi68MO5POorqL+w7FLTVw7kpOAkyb9ENUlnq6VS8kKM0LYG5LtaTNSXguI3
         JxYAPv8jl3jDKY5JGwecfL28x+40ORzrGuakykh1C5iaSUZ5YwUEWRAEKsVUWdrp/8un
         7pobgqgt4LEWomqMgDIogohzC0zxVwyg3IDE+zIIIsDti/6/xjXqBdt9jCr/Bi3S4Px5
         0fQPctMzlZv+OTdeLVw/bGWVl7UFl660dcPlpYdfiOYwwAGKgN7izR7wTktMr6AUVurw
         78MyioCleHY4Cd9aG2gYgZSrgwJ/UmYA3hO8TG8fJK1xMrJd/tTQpZrwdfyjwy/Wt36g
         8Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695994438; x=1696599238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+xdIamtWar0MYfhb0rDcSmv8dCB5Xt4XPVLRYRJ3b4=;
        b=Qyb+BP8KIOI41/X3Dq7QInuyfxvIQuvalrBc5MyjWgpLt/MMl0mamLxPw0KSiC9dJ5
         LbHylZVuhPS7FxR1LQqw+TC3VfhvfvzlX2dvoCCUQmHEgV02E+jmK/lkFKJqi0ycw5Sq
         K6a+VZ/cyrd9n15NWNfha+nol1aqwOvWGL+weaoUp5DO6F0MJQ/DK1ezAsmaYq8pFowk
         1k4dBZdVgv7+I6udU0GRLDlSd33vQsn6gz4bLE+mxhHyo1YOQ8UaMAmG00z+heqaZ4hu
         7FQloXwH+azua0KoJxUYp1H2mlAv1931Q2woCfbnhiWOGcHSBUHTjQcuOy+HjPk5KnWe
         7PVQ==
X-Gm-Message-State: AOJu0YxK427obqpgneJVwfUWQWgjEO4vNqx5tfwER214lG2xFjRYhWSV
        W7WxRWMniwnUC2mXDnDdD0T8b+wQ7uuChVhZLFOO2g==
X-Google-Smtp-Source: AGHT+IHHyhyo65ld9rgo3x3D0p/k9tLyqy8oiJ8aVd5/jh05D1feMiR8+2dvprSCCjc8uaoechR6+ou6NnvdxiYCR94=
X-Received: by 2002:a1f:cc46:0:b0:48d:eaa:45c4 with SMTP id
 c67-20020a1fcc46000000b0048d0eaa45c4mr3791108vkg.7.1695994438460; Fri, 29 Sep
 2023 06:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <m3y1gpw8ri.fsf@t19.piap.pl>
In-Reply-To: <m3y1gpw8ri.fsf@t19.piap.pl>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 29 Sep 2023 14:33:42 +0100
Message-ID: <CAPY8ntASwh3AcRqE+2zF4Df=u+=wJ5K9icAeOrXTMJGDd1+caw@mail.gmail.com>
Subject: Re: Sony IMX290/462 image sensors I2C xfer peculiarity
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-media <linux-media@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Fri, 29 Sept 2023 at 11:53, Krzysztof Ha=C5=82asa <khalasa@piap.pl> wrot=
e:
>
> Hi,
>
> I am debugging certain IMX290 and IMX462 I2C failures on an NXP
> i.MX6MP based board and there seem to be interesting "feature" here:
> Sony IMX290 and IMX462 image sensors apparently terminate I2C transfers
> after 2^18 of their master clock cycles. For example, with a typical
> 37.125 MHz clock oscillator, this means about 7 ms. In practice, I'm
> barely able to read a block of 128 registers (at I2C 400 kHz clock
> rate).
>
> I think the sensors simply disconnect from the bus after 2^18 clock
> cycles (starting from the first START condition, the repeated STARTs
> don't reset the timeout). This means, in case of a READ operation, the
> data read by the CPU after the timeout contains all bits set to 1.
> i.MX8MP detects arbitration losses, so if the SDA change to 1 happens on
> high clock value (but not on ACK bit), the whole transfer is aborted.
> Otherwise, the ending bytes are simply set to FF (and the last non-FF
> may be corrupted partially).
>
> The problem is 7 ms is a short time and on a non-real time system even
> a simple non-DMA I2C register writes can take as much time. This causes
> driver failures.

What's your requirement to be able to read back so many registers at once?

Whilst potentially useful during development, most sensor drivers
write specific registers but never read anything other than
potentially a model ID register during probe.
Large block writes are generally not possible as at least the IMX290
datasheet does state "Do not perform communication to addresses not
listed in the Register Map", and there are numerous reserved blocks
throughout the map.
As far as I know there's no OTP on these sensors which would be about
the only reason I can think of for needing to read large blocks.

I currently can't see a reason for a sensor driver to be needing to do
these big reads, so how can it cause a driver failure?

Scanning the IMX290 datasheet further, there is a slightly worrying
paragraph in "Register Communication Timing (I2C)":
"In I2C communication system, communication can be performed excluding
during the period when communication is prohibited from the falling
edge of XVS to 6H after (1H period)."
and the diagram shows a 1 line period 6 lines after XVS which is
marked "communication prohibited period". Ouch!
I've never experienced issues with I2C comms to these modules, but is
it possible that you're hitting this period with your longer I2C
transactions? A logic analyser looking at XVS, XHS, and the I2C might
give you some clues. Or are you not streaming when you're doing these
transactions?
IMX462 appears to list a similar restriction.

  Dave

> Needless to say, the datasheets know nothing about the feature.
>
> Any thoughts?
> --
> Krzysztof "Chris" Ha=C5=82asa
>
> Sie=C4=87 Badawcza =C5=81ukasiewicz
> Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa
