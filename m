Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF24C78A00A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjH0PnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjH0PnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 11:43:05 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 08:43:00 PDT
Received: from ymitury.uuid.uk (ymitury.uuid.uk [95.179.232.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F6A9;
        Sun, 27 Aug 2023 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=3jEC/JzsYyiCyfDk3Nb5D9X8K6LjBzpi7Vo3QkOXNQI=; t=1693150981; 
        b=ouMeYqqC8l74Ikn5oos/NuZYZq3twtTbeqJVvN235I3ze2JaAwlQ2Aefe2QrT3QZcDJ4g5+7vpn
        q/1S0H3hyVJOZsielrz16Ov5g0HIPXOFa3Zt4jjwuV2vmYv7LCExJnL8Bp8eSTlonFq8bwconDSK2
        mpeu0X2G+F+pnd7eyeFL+4ldd1goDbUOyVBEYpz2EVeluTTzf3+BLGiqDi4tNAG/YtvisUeTBrqkV
        qEh3w9hI/bOJClNKL7KJWW99IwQzj9va0mmcwE9Kp+bDAnkgAt8pWUey7KaLoTqYgfDDI7S8v0OQ9
        vI3H1IC8E74MCDbcPCtoOi/tKUcBAytIzKz3cbPxnMMdQMh0Is1DNZqWntI+Ix/KK1fu5K+xHmxID
        v1UXQMfgrl4KQ2qO73n43zC0YFjeOESn7ZGauvB7rDB1Gs0f0iDR6i8fOF1w2OCMXzI+x5tQRjYtp
        Z3qOKaSSUtEuQj8RnjyspBQXUJcQ2Y3GjuT8nskc3wpKpYUDfM48;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=3jEC/JzsYyiCyfDk3Nb5D9X8K6LjBzpi7Vo3QkOXNQI=; t=1693150981; 
        b=6B3NtcTwxSa6aOUPyUSIE9XJJFib//tFrlYSrx3himA1i7CkfFJ/QDSlxlLZgeBEuVDXSsHyAiE
        oZrHUObBMCA==;
Received: by ymitury.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qaHo4-00EIjc-QZ; Sun, 27 Aug 2023 16:36:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=3jEC/JzsYyiCyfDk3Nb5D9X8K6LjBzpi7Vo3QkOXNQI=; t=1693150564; 
        b=kP8UFBmJYDGkrUfbeMKi7tuUJ8jaIQvJsiMrWVRNYXwTwuhBFp5MQWyzPLoqIH8MC8fLcg5VSoE
        YdTSoHkSxmkdCyg0WNbHF5BlDYkLxqvSHnk5+ulR1DAUOHvJNkX+CvnCwe/0+LW1a0/6TxfUD4xi7
        N2fNfvpPjm/P54U+DzEpJYJ8oSzHTTeRwuaMsG7FG1RQoc/3nrTEV6dTpLpw4fUJ/NMsbfVfoZZZ4
        rd83iDKwcz8bbu3c9DQEkYVs3GtXM/hw4A3dYF6rl/RpPtUZ1+o2rwsVCkrGdoD0LhfYbscaCeokY
        cl0XlwTRJ7M3PZki1pjGIw5xyDjoNuexzy67yoyCuBI2duDoVwKsurZJ+qpYSlCHjqX9eCWQaizff
        tRgsdqQvAC4y0Crb27iDS8YKoWO6oP7wlq+ka3RPfAAYpGi4D+iJvBpy6l1xDCpBa5ISUrIMgG9lX
        J1CoWlIOSUrMDt8Wt+5GxUfrOaKO+iOsTP4RazdTKUtT87gw6RuW;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=3jEC/JzsYyiCyfDk3Nb5D9X8K6LjBzpi7Vo3QkOXNQI=; t=1693150564; 
        b=6mUEM1Of0GSKbtsH3V8mWdj1uSsK5sKeIi9d/vTNgR1spKd94vhGWwJL2rmTnfAJkj/EraBR7Yw
        D6JveDYYJCw==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qaHo1-005xPH-3J; Sun, 27 Aug 2023 16:36:01 +0100
Message-ID: <d02c3df7-dee0-0260-acb2-6fcdf089218a@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date:   Sun, 27 Aug 2023 16:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <2023082403-masculine-scuttle-f0ad@gregkh>
 <d313a1a9-833e-981e-b9d7-920989458d37@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <2023082442-arose-jitters-00bb@gregkh>
From:   Simon Arlott <simon@octiron.net>
X-Face: -|Y&Xues/.'(7\@`_\lFE/)pw"7..-Ur1^@pRL`Nad5a()6r+Y)18-pi'!`GI/zGn>6a6ik
 mcW-%sg_wM:4PXDw:(;Uu,n&!8=;A<P|QG`;AMu5ypJkN-Sa<eyt,Ap3q`5Z{D0BN3G`OmX^8x^++R
 Gr9G'%+PNM/w+w1+vB*a($wYgA%*cm3Hds`a7k)CQ7'"[\C|g2k]FQ-f*DDi{pU]v%5JZm
In-Reply-To: <2023082442-arose-jitters-00bb@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 20:22, Greg Kroah-Hartman wrote:
> So this looks like you feel there should be a way to modify serial port
> values without the ioctl api.  That's good, maybe we do need to do this,
> but then, if so, it needs to happen for all serial ports, not just one
> single device type.
> 
> Note that the tty api is really really old, so modifications and
> enhancements need to be done carefully.  And be sure that there isn't
> already another way to do this.  The open/close DTR/RTS issue has been
> brought up many times, and I thought that there was ways to prevent it
> already, are you sure that modern tools don't already take this into
> consideration?

On 25/08/2023 02:53, Alan Stern wrote:
> Is it feasible to add a sysfs attribute for ttys or the serial layer to 
> control the side effect of opening (avoid raising DTR/RTS)?  If that 
> could be done, a program could use the existing ioctl to set close_delay 
> and closing_wait to 0 with no penalties.

The port will still be "activated". That has side effects for an
application running on a microcontroller providing the USB CDC ACM
interface because it may be waiting for that state change to output a
message or start doing something.

> Or better yet, don't make any change until you actually open the port
> for access.  Why wory about these values until you need to use it?  Why
> insist on doing it from a udev rule when there is no real user of the

Because the applications that access the serial port aren't typically
aware that close() may block for 30 seconds. Even if they are, they
can't do much about it because of the next problem.

> port yet?  Who are you setting the port up for, and why can't they do it
> when they open and set the other values that they want?

Because they're not running as root and so don't have CAP_SYS_ADMIN and
can't change these two values.

>>> If any apis are needed, let's make them for all tty devices, through the
>>> existing ioctl api, so they work for all devices and userspace doesn't
>>> have to try to figure out just exactly what type of tty/serial device it
>>> is talking to (as that will not scale and is exactly the opposite of
>>> what common apis are for.)
>>
>> Are you ok with adding the same two attributes to sysfs for all ttys?
> 
> Why just these attributes, why not tty settings?  :)

I assume you mean all tty settings? Looking at termios(3) there are a
lot of them...

Restricting them to just the serial settings (include/uapi/linux/serial.h
serial_struct), some of them only apply to real 16550-like serial ports
("type") and won't be applicable everywhere ("irq").

There would then be several serial devices with attributes that don't do
anything, e.g. "irq" will read as 0 and writes will do nothing. We
wouldn't know at the tty layer which writes will do nothing because
there's only one operation for the whole serial_struct.

The "close_delay" and "closing_wait" values have universal application
because the tty layer uses them. They're set on the tty_port in
tty_port_init() and then the serial port drivers modify them when
TIOCSSERIAL is used. There doesn't appear to be a tty-level API to
modify them.

>> I'd use a different name (appending "_centisecs") because serial_core
>> already uses those names on the tty device and I think it's better to
>> define "infinite wait" and "no wait" as -1 and 0 instead of 0 and 65535.
> 
> Ah, so this already is an api?  Or is it a different one?

The serial_core adds read-only attributes to the tty device for most of
the TIOCGSERIAL values. That includes the tty closing options but
they're exact mirrors of the ioctl API which means it has special values
selected by the range of a u16 value.

A new sysfs attribute should use better special values.

-- 
Simon Arlott

