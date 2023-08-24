Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF8787765
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbjHXSDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbjHXSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:02:58 -0400
Received: from papylos.uuid.uk (papylos.uuid.uk [209.16.157.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CD1BDF;
        Thu, 24 Aug 2023 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=EZ3RCjAcVF0Kb4Cn3K1wUIFyYhFcXLKwOtJWRRqnlTA=; t=1692900173; 
        b=vVhy/Ja+gGKoj+0n30/Rfq+Fe3NEBewtS7jZ19rOr8i0Mm+gSbyRTPseuIbz6rBFm69aDOchtd6
        TRO8SSFS39yj8sDn2lx3Gp+lOFVjmjYsHEx7otRjdUhRtjzsKoSBBIWphE7/P/ZL+xWAgfvfJHjhZ
        UXuxcC1BWpnr84mSaiYG605wfWjxOuMlfYCsarMglwtGo8TGLcqwRdhbyt95xSZcDOEfBahvAcxAm
        koekooESVOKP6wz/ptQvk9w1hClCkNr+6WQSRcIEv2a4AOgM4aivdRT/m7fgjuJlQ6J2E5iTdgin0
        rcYfzTI5Dz0uKkWqaQ2+sOu1wgnSP4Ixw+X+B2d26+PYs5KkDXL5vtx5sOgBdd1oBTM1beJY2rZeB
        H6ngHzUTVGXM2MtX4Cf66ro/3Kpkdrhp/tPtWiX4CUafI+8h4A37PMo0aM+pYdgeZx9CQ7Nca60d0
        9ZH6yoZWXjnOPOvnvyV+pQZlYgHnpckyxRj+ToUJsolhRz/2/05O;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=EZ3RCjAcVF0Kb4Cn3K1wUIFyYhFcXLKwOtJWRRqnlTA=; t=1692900173; 
        b=D8Qt6YeJBryodD026PaLqCusb4T8vFozf5fMJW7I17ZlaS880+pI05NLtxQBBFzlnwUVSMlf39G
        oj1jK4PXeDw==;
Received: by papylos.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qZEfP-00BNjN-Cu; Thu, 24 Aug 2023 19:02:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=EZ3RCjAcVF0Kb4Cn3K1wUIFyYhFcXLKwOtJWRRqnlTA=; t=1692900167; 
        b=AZzBnVRo4Day4czfhaU0BuhBGzrzxUN8ZSMa0laMNK1LZwMzKnn9iTSKl0IpVKUBVWlmTr1JiKq
        /vriL59aTu2jRra34/fzLp2ewYzbStTVpxfTI/cV2FXAjyfFAa7FViyCZdKu1AiOe1GH5tFVoGyoD
        mrFCti+mxqQIOHkSETqiHpNvkZ7JtaS/0Ob2oVtBKVxVWn4xj8r90xnRpPHe4zaoEwRl04IqYwZNj
        Cd8UoyIybGoarkveh+xnySZAaM/QKvmmrJlu41d3WNgW6fPf+DAM6mK1FWHLDzgLqyjHGisRFNvp9
        13+vhVPMtVyNj5XTLR4Y+Tg43KIMcfxUmMoYukDLxltnpqrHDuz92TwItHdgF7z+Dz6PasrbWw2Oo
        /d1Kdlq7DX/qK9oz9iVZM/pV5+2qPOA4HvSYX4TvCmXJ3RLNFFK3sIteySuWRnVPFNiBLcfETgApK
        /yt5oD1eT9q5EGN2elzTy81/e5sQQrccWhK3jetYSf332WRwKG81;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=EZ3RCjAcVF0Kb4Cn3K1wUIFyYhFcXLKwOtJWRRqnlTA=; t=1692900167; 
        b=FYuG4rk2Imakq3+Q5/AtY38KD81MHwvcC5RjUOBff8LCNkicG0BhzdT+s3OeArZbU6bec+2u6S9
        KEqIMCz4eDQ==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qZEfI-004u01-U2; Thu, 24 Aug 2023 19:02:41 +0100
Message-ID: <d313a1a9-833e-981e-b9d7-920989458d37@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date:   Thu, 24 Aug 2023 19:02:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <2023082403-masculine-scuttle-f0ad@gregkh>
From:   Simon Arlott <simon@octiron.net>
X-Face: -|Y&Xues/.'(7\@`_\lFE/)pw"7..-Ur1^@pRL`Nad5a()6r+Y)18-pi'!`GI/zGn>6a6ik
 mcW-%sg_wM:4PXDw:(;Uu,n&!8=;A<P|QG`;AMu5ypJkN-Sa<eyt,Ap3q`5Z{D0BN3G`OmX^8x^++R
 Gr9G'%+PNM/w+w1+vB*a($wYgA%*cm3Hds`a7k)CQ7'"[\C|g2k]FQ-f*DDi{pU]v%5JZm
In-Reply-To: <2023082403-masculine-scuttle-f0ad@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 15:48, Greg Kroah-Hartman wrote:
> On Wed, Aug 23, 2023 at 09:37:45PM +0100, Simon Arlott wrote:
>> This can happen with the ESP32-H2/ESP32-C6 USB serial interface. Instead of
>> changing all userspace applications to flush (discard) their output in this
>> specific scenario it would be easier to adjust the closing_wait timeout
>> with udev rules but the only available interface is the TIOCGSERIAL ioctl.
> 
> Then why not use that?

It's not practical to use TIOCGSERIAL from a udev rule. Instead of a
sysfs attribute (that udev has built-in support for writing) it would
require a separate compiled process or other non-trivial dependencies
(e.g. Python) to modify the closing_wait value. There's no shell script
support for read-modify-write of a complex ioctl struct.

The ioctl can't be used without opening and closing the tty, which has
side effects. On open() it'll raise DTR/RTS and activate it. For cdc-acm
that will indicate to the device that the serial port has been opened
which will be visible to the software running on the USB device. On
close() it'll be delayed by the close_delay if any process is currently
doing a blocking open() and there's no carrier, then the closing_wait
time if there's been any incomplete transmitted data (by any process).

I want to be able to automatically set close_delay to 0 and closing_wait
to 65535 ("no waiting") on all USB serial devices without these kind of
side effects. I'm sure these have a purpose when connected to a real tty
but forcing a process to wait 30 seconds before it can close the port
(or exit) if the USB device isn't reading data properly is inconvenient.

Those two values require CAP_SYS_ADMIN to modify (which is separately
enforced by many of the tty drivers) so user applications can't change
them even if they're aware of them.

> If any apis are needed, let's make them for all tty devices, through the
> existing ioctl api, so they work for all devices and userspace doesn't
> have to try to figure out just exactly what type of tty/serial device it
> is talking to (as that will not scale and is exactly the opposite of
> what common apis are for.)

Are you ok with adding the same two attributes to sysfs for all ttys?

I'd use a different name (appending "_centisecs") because serial_core
already uses those names on the tty device and I think it's better to
define "infinite wait" and "no wait" as -1 and 0 instead of 0 and 65535.

-- 
Simon Arlott

