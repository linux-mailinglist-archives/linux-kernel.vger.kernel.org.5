Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194697B0CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjI0Tlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Tlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:41:36 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F2CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:41:34 -0700 (PDT)
Received: from [IPV6:2a02:8109:aa40:4e0:b5c6:9671:3477:8fde]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 27 Sep 2023 19:41:27 +0000
Message-ID: <741b7bed-919b-41c3-bd57-85e1cdfd6e48@sdfg.com.ar>
Date:   Wed, 27 Sep 2023 21:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools/nolibc: Add workarounds for centos-7
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
References: <20230926133647.467179-1-rodrigo@sdfg.com.ar>
 <20230926133647.467179-2-rodrigo@sdfg.com.ar>
 <e8ed17e6-8eb3-404d-9669-5e5b413904ed@t-8ch.de>
 <c658a72a-b3f6-4504-a940-7ff946c81559@sdfg.com.ar>
 <5d4d14f5-b90d-4fd7-865e-0d64b8520c0e@t-8ch.de>
Content-Language: en-US
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <5d4d14f5-b90d-4fd7-865e-0d64b8520c0e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 20:23, Thomas Weißschuh wrote:
> On 2023-09-27 15:06:03+0200, Rodrigo Campos wrote:
>> On 9/27/23 01:30, Thomas Weißschuh wrote:
>>> On 2023-09-26 15:36:47+0200, Rodrigo Campos wrote:
>> We can definitely remove that struct statx bits in our vendoring. It will
>> simplify updating if we don't have to patch it, so if we can't include a fix
>> in nolibc, I think we will continue doing the hack ourselves and that is
>> all. It is not too bad :)
> 
> How often are you planning on updating your vendoring?
> In the timeframe before you are dropping centos-7 support?

We will probably update if other MIPS variants are added, or other 
arches supported by golang. Other than that, I don't see that happening.

> The "nice" thing about the breakage is that it will break loudly during
> compilation so it will be easy to notice and fix it up.
> 
>> I don't think it is worth for nolibc, at least for this use case, to
>> reintroduce compatibility for stat() without statx().
> 
> It wouldn't even be full compatibility. The code would compile but be
> unusuable for stat()/statx(). And I don't think any application expects
> stat() to return -ENOSYS.

Right, it would not be fully compatible but it will be possible to 
compile and use the rest of the syscalls, just not stat().

It's really up to you to decide if that is worth or not. That happens to 
be what we need :)

> It's a bit ugly code to support a kernel that has been EOL upstream for
> six years for a fairly specific usecase.
> But who knows, maybe Willy has a soft spot for the 3.10 kernel :-)
> Let's wait for his input.

I can't agree more, that is why I was unsure supporting centos-7 was 
something we want to do in the first place.

Let's wait for Willy, but I will be slow to answer in the coming weeks, 
I'll be with limited internet connectivity.



Best,
Rodrigo
