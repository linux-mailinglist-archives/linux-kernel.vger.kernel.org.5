Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FCF7C87F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjJMOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjJMOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:38:59 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22595;
        Fri, 13 Oct 2023 07:38:56 -0700 (PDT)
Received: from [10.6.0.9] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 1957C2FC0052;
        Fri, 13 Oct 2023 16:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1697207935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ChgUT0Eqw/nIEIvwaS0dwvVVK4YCEQmQRVbYoYtxio=;
        b=sXHGk4et/tA5wCWNxD4VLMKj4osg9aEUTEczCyB6GXLERYz5UaMpKIX2EhZWw/XovNgYzE
        g46pc7/dLOaBxW8GpUvM+lck1oeKuiKeEZWCw+fkfX7n4BBmxllWJbKgwMV/b/fQEFBIel
        oZYHG6NpTjDbP/z80hYIdjE8aq/KwVg=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <28af2d0a-191d-4496-95de-b4243adc9112@tuxedocomputers.com>
Date:   Fri, 13 Oct 2023 16:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 13.10.23 um 14:19 schrieb Pavel Machek:
> Hi!
>
>> Every multi_zone_* mode could also output a zones_image. That is a greyscale
>> bitmap or even a svg containing the information where each zone is located
>> and which outline it has. For the bitmap the information would be encoded in
>> the grey value, aka 0 = zone 0 etc with 0xff = no zone (i.e. space between
>> the keys). For the svg, the name of the paths would indicate the
>> zone they
> This is not really suitable for kernel.
Yeah thought as much
>
>>> It would go to drivers/auxdisplay, most probably.
>> Looking into it, thanks for the direction. But this would come with the
>> downside that upowers kbd_brightness no longer controls the keyboard.
> Yep. We could add some kind of kludge to fix that.
>
> Perhaps first question is to ask auxdisplay people if treating
> keyboard as a weird display is okay? cc: lkml, leds, drm, input at
> least.

On it

But i don't know how to implement the different hardware effect modes then.

>
> Best regards,
> 								Pavel
