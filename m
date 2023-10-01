Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C8B7B4934
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjJASjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjJASjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:39:16 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F7C6;
        Sun,  1 Oct 2023 11:39:12 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 8CA7D836E7;
        Sun,  1 Oct 2023 20:39:09 +0200 (CEST)
Message-ID: <8c101322-085b-451c-90b6-90d2799ef192@skole.hr>
Date:   Sun, 1 Oct 2023 20:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/6] ARM: pxa: Convert Spitz OHCI to GPIO
 descriptors
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr>
 <20231001-pxa-gpio-v4-1-0f3b975e6ed5@skole.hr>
 <CAHp75VcBY3W8aVEsRMPNMW9940yT+_=-w8J2uKfqvmUiAVjPhg@mail.gmail.com>
From:   =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <CAHp75VcBY3W8aVEsRMPNMW9940yT+_=-w8J2uKfqvmUiAVjPhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/2023 4:32 PM, Andy Shevchenko wrote:
>> +       pxa_ohci->usb_host = gpiod_get_optional(&pdev->dev, "usb-host", GPIOD_OUT_LOW);
>> +       if (IS_ERR(pxa_ohci->usb_host))
>> +               dev_warn(&pdev->dev, "failed to get USB host GPIO with %pe\n",
>> +                               pxa_ohci->usb_host);
> 
> Since you are using _optional() API, you need to bail out on the error
> case and replace dev_warn() by dev_err(). I guess I already commented
> on this. What is the rationale to not follow my comment?

I must have missed it, sorry about that. I'll be sure to do so in v5.

Regards,
Duje

