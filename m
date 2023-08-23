Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18B3784E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjHWCL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjHWCL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081A10B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8B460B38
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B47C433C8;
        Wed, 23 Aug 2023 02:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692756700;
        bh=bJxYPPMi7k7jkgr4HiySVgbID6xNn1h3lGOfe90Dgxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n/IF9o9jQ6Md4kkbdE0owEr6AUsc8gLpYBxtHInBeCmAhVsO2FRvLT6wLE2egY3iq
         COs7jXvFvpjyoqu7/l54Ua854HRjQ7Fpm51a6A0/jAfKjDATilEmja5rldaiyCIOZu
         ShVhOmS5/GzXJR/yB5inKVrHvdKsnq5uCjreOzy1JpXLgQI7ppQ0xnpJnB1GDaS/r7
         jb9o8OV9tpcmewX2qwkdI91a71ylQ8trWD8hZ6zTD7qPisyC4Tim/rgDavIIBxEUvh
         44H3qqrluYTY1FlTO6RUbhxk6ztXoekRWF6u56/fxPIb0EKhne2oQpySIiw6ivMuvr
         DeNlT+D75G//g==
Message-ID: <88964b2e-105a-b74b-ec3a-859de83b90a9@kernel.org>
Date:   Tue, 22 Aug 2023 21:11:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: socfpga: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230717225440.3211576-1-robh@kernel.org>
 <51dce096-1e45-c78e-e0b3-fcffa2cea4ec@kernel.org>
 <CAL_JsqKF_ncQ3KNOHXugGJQO-GCE4coUeOmhQXd3AkneTQv_7A@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAL_JsqKF_ncQ3KNOHXugGJQO-GCE4coUeOmhQXd3AkneTQv_7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 17:29, Rob Herring wrote:
> On Thu, Jul 20, 2023 at 4:29 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>>
>>
>> On 7/17/23 17:54, Rob Herring wrote:
>>> The DT of_device.h and of_platform.h date back to the separate
>>> of_platform_bus_type before it was merged into the regular platform bus.
>>> As part of that merge prepping Arm DT support 13 years ago, they
>>> "temporarily" include each other. They also include platform_device.h
>>> and of.h. As a result, there's a pretty much random mix of those include
>>> files used throughout the tree. In order to detangle these headers and
>>> replace the implicit includes with struct declarations, users need to
>>> explicitly include the correct includes.
>>>
>>
>> Applied!
> 
> Did you really? Doesn't look like this is in linux-next.

I did, but haven't sent a PR to armsoc. Will do it now, thanks for the 
reminder!

Dinh
