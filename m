Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1787DB4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjJ3IPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjJ3IPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:15:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E291;
        Mon, 30 Oct 2023 01:15:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5079f9675c6so6280367e87.2;
        Mon, 30 Oct 2023 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698653742; x=1699258542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KWYjvSDY5DIMMFjnpJiqvif2JTitQHxK/8ZOowXvcTI=;
        b=gpwVR6g/irhgPQClnd1F4QpmwjX2W+eoQ5E5IbHIzEJvOHHCN8bJNfbZ3dlM2C4w4N
         HXn7Su/r6ZaTIxVjKuBb0E0b3wYzGsDtvQFYgP4AozZPyN6qUbgOxHaRxbdDE+kxiXY4
         W6Z/AXAAhVeBzV5+qLBHYj9Uaq0Xsb/hhEhoDFugEPwXfqezKJh203SUgGC6Wg9a3KHV
         Csq89Zf97He0VofY4iP9mStj8we/DQF2RXowXTlf84pZ0hFy6vkHQ4u9tmVMQsT2ywx2
         tvGb6aoZHptOPtKGg2hg6qDHaYldtEm4MMWV17pMgx4hnOAOJibIrRRHn/GSWL4uKPvX
         wrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698653742; x=1699258542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWYjvSDY5DIMMFjnpJiqvif2JTitQHxK/8ZOowXvcTI=;
        b=vuiL7A+4p0T8e7DDJlV6FtdCkO1z/LLfbAMeLdhTyuTYc5mtyxItHmwwsnaDEQBIX4
         GIgveE5l5U9KJP3UiBHLbb52fVJ9KoiCK63tNBOgApRAG7rWsnyBMh2Yj5aJeAgAwa0F
         BxA/66rAXyuozKplop0CMEpTmyIIbQ0Lj+ewdl8xWoh9hNT6+gDGxdD+AeyRkEgpscdM
         4zAZVKkc6YrKelJ9ahLoBhTS2i5vEpIDyGOvkFskeszwMPuOwY9dHvyYTjTClDsyyFd+
         Nsz0mZA1G8KhRv7MMZBoZoFV1G/CdC1+atQ1BV5lejeu6o/IQzagoJN5NR2P0QK9AYCQ
         eIrA==
X-Gm-Message-State: AOJu0YwqtsjHV3mb6usPHrSlSnbgivm9V6BA9dFWXiL96bPhow3COZYj
        PYBKHlur6s7BzZHrgX6c+rBAZuHsVoBxXd6YX2ErYtdX
X-Google-Smtp-Source: AGHT+IHblBhpQey3QA286YT9LUKfwfKp4KRW2N0/x8HmCpUcyQrgHgSeWzhTZnzJekj9aqpKhjR75KioNv30Rn+svKI=
X-Received: by 2002:ac2:4a79:0:b0:503:90d:e0df with SMTP id
 q25-20020ac24a79000000b00503090de0dfmr6221722lfp.34.1698653742068; Mon, 30
 Oct 2023 01:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFGKuwoFUaXMsOOWJNBenQDG6+syt80Z9pvQQK1XSZFztC2_SQ@mail.gmail.com>
 <2023103052-unpeeled-calibrate-ae48@gregkh>
In-Reply-To: <2023103052-unpeeled-calibrate-ae48@gregkh>
From:   ariel marcovitch <arielmarcovitch@gmail.com>
Date:   Mon, 30 Oct 2023 10:15:30 +0200
Message-ID: <CAFGKuwp7JH8H9vjz8iJ24R9TRW0GDE-O96VBAG4L8X4DhTabXg@mail.gmail.com>
Subject: Re: Gaps in logs while using usb-serial as a console
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 08:22, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 29, 2023 at 08:21:21PM +0200, ariel marcovitch wrote:
> > Greetings!
> >
> > While using a usb-serial device as console, I've noticed some
> > significant gaps in the kernel logs it receives.
> >
> > The problem can be reproduced in qemu like this (the kernel is a
> > x86_64_defconfig with usb-serial enabled and with the ftdi_sio driver
> > enabled):
> > qemu-system-x86_64 -m 4G -kernel arch/x86_64/boot/bzImage -usb -device
> > usb-serial,chardev=ser -chardev pty,id=ser -append 'console=ttyUSB0'
> > (this will create a `pts` device that will connect to the other end of
> > the emulated usb-serial)
> >
> > Then the logs look something like this:
> > [    1.006459] SELinux:  Initializing.
> > [    1.011620] Mount-cache hash table entries: 8192 (order: 4, 65536
> > bytes, li[    2.315341] ACPI: \_SB_.LNKD: Enabled at IRQ 11
> >
> > This probably happens because of the code in
> > `usb_serial_generic_write` which tries to insert the data into the
> > fifo:
> > count = kfifo_in_locked(&port->write_fifo, buf, count, &port->lock);
> > Because added indications for when the result is less than expected
> > and it showed significant losses.
> > The return value is silently ignored in `usb_console_write`
> > Also making the fifo bigger in `setup_port_bulk_out` helped (I made it
> > 10 times bigger and there were no losses)
> >
> > The reason so much data is written at a short time is because
> > usb-serial is initialized rather late, and when it is registered as a
> > console, all the logs until this point are written to it.
> >
> > I'm not sure what the solution should be. Maybe we need to check
> > whether the write in `console_emit_next_record` was successful and not
> > increase the seq counter in this case.
> >
> > Any suggestions?
>
> Please realize that usb-serial console was the result of me loosing a
> drunken bet.  It's amazing it works at all.  For "fake" devices like
LOL your drunken bet was quite helpful to some people
Because modern PCs come without a serial port, I wanted to use it to
see early logs on my crashing kernel without having to use printk
delay and things like that.
I'm curious as to how kernel people debug PCs in general...
In any case, the usb-serial setup was quite weird as it required two
usb-serial and a gender changer

> this, that use the generic usb-serial code, yes, you will have overruns
> and other problems, that's just part of how it works (i.e. not well.)
>
> For something like qemu, please use a real console, like the serial port
> (i.e. a fake serial port), not the fake usb-serial port.
Yeah I was just using it to demonstrate the problem (I agree it is
quite weird to use usb-serial as a console for qemu)
I experienced the same problem with a real usb-serial device, then I
tried to use emulation so I can debug it more easily

>
> So this is "working as designed" in that it wasn't designed at all and
> again, it is a miracle any data is flowing there at all :)
I see...
However it may be possible to fix it without much effort, so why not?
Something like checking the return value for the console's write
function seems reasonable to me anyway...
Besides, don't other types of consoles have the same problem (being
initialized late, getting a lot of data, losing some of it)?
>
> sorry,
>
> greg k-h
Thank you for your honest feedback,

Ariel Marcovitch
