Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C567CAAA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjJPN7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjJPN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:58:55 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A510D;
        Mon, 16 Oct 2023 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=IlCu/jWp8SVoI/cMKgzgDIUk/DbaqOCC0hxXFHL5jQs=; b=R58bHo9++XgOQJOs0Ni2j2q631
        5at3w+OTR1BhxmRlw9U03h0l8beJbj9vhcM5wSS5Ar7V49Lta+q8FmgHU4YnwojtnNeMqtld1dxt4
        A1YF6Jx7y0Lh4dnZApjwUgb3aJiFp8LebkIMbxE6hL8oor6YAh541SAsqoRlThxD2xOw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56974 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qsO7N-000654-LP; Mon, 16 Oct 2023 09:58:50 -0400
Date:   Mon, 16 Oct 2023 09:58:48 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Message-Id: <20231016095848.ba76e14c41bb7ceae8217e04@hugovil.com>
In-Reply-To: <2b12a49c-ed82-4632-86c6-349976cd714b@linaro.org>
References: <20231013141925.3427158-1-hugo@hugovil.com>
        <20231013141925.3427158-3-hugo@hugovil.com>
        <2b12a49c-ed82-4632-86c6-349976cd714b@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH 2/2] dt-bindings: serial: sc16is7xx: remove
 'clock-frequency' property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 08:09:56 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/10/2023 16:19, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The 'clock-frequency' property is supported but mainly in ACPI-based
> > configurations, for example.
> > 
> > This property has therefore no place in the sc16is7xx YAML binding.
> 
> Please reference commit which you question - 0d447e927. I don't
> understand why do you remove it. The property was in the original binding.

Hi,
in the max310x YAML conversion review (last week), you told me to
drop the clock-frequency from the binding, even
if it is supported by the driver, since it is related to ACPI
configuration, not DT.

The sc16is7xx driver (IC) is very similar to the max310x, and it also
supports the clock-frequency property, and I just assumed that its
presence in the original text binding was some kind of error or legacy
leftover, and would need to be removed based on your comments.

Just as a reference, here are the original commits in both drivers that
added support for the clock-frequency property:

-----------------------
commit d4d6f03c4fb3a91dadfe147b47edd40e4d7e4d36
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon May 17 20:29:30 2021 +0300

    serial: max310x: Try to get crystal clock rate from property
    
    In some configurations, mainly ACPI-based, the clock frequency of
the device is supplied by very well established 'clock-frequency'
property. Hence, try to get it from the property at last if no other
providers are available.


commit 24bc6e68efa00f95034dbef0ba91661dd80bd37d
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Mar 18 12:29:15 2019 +0200

    serial: sc16is7xx: Respect clock-frequency property
    
    If the property is provided and there are no other possibilities to
detect UART clock frequency, use it as a fallback.
-----------------------

Hugo.
