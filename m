Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC97E516D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjKHHyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjKHHyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:54:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175BD41
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:54:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2AEC433C7;
        Wed,  8 Nov 2023 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699430047;
        bh=772PrGqUMV5ONmuvUTo5sx1NVLn/lFjsmcoErE/9xPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF6nImAi8TiB0t2cUUbYzbvixL9fPJEhgK/tg3LoqHPkrL1bICOVk1CON1/P+X399
         utNMqkC25BReE+5jF6qlLB37dLuqquDSYmjX+zyLflhEZfYi3AHDEnMIznUaoqf09b
         3aDAQpi3T9kAIDS/LInQAp71HtXwijUx8j4O+39M=
Date:   Wed, 8 Nov 2023 08:54:04 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
Cc:     Marco Elver <elver@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: Reply: A null-ptr crash in linux-6.4 usb driver
Message-ID: <2023110809-headache-heaving-3472@gregkh>
References: <043105feee62401f833a06ea480a3b1b@qianxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <043105feee62401f833a06ea480a3b1b@qianxin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 07:40:08AM +0000, 柳菁峰 wrote:
> I have made a patch that simply checks for null pointer, but I am not sure if this will affect certain functions or logic. I hope you can check it carefully.
> 
> 1006c1006
> <       if (dev->p->dead) {
> ---
> >       if (!dev->p||dev->p->dead) {

Can you take a look at the file,
Documentation/process/submitting-patches.rst for how to properly
generate a patch?  This does not give us any context to even know what
file you are changing.

Also, we have no context at all to even know what this is about at all,
what is this for?

confused,

greg k-h
