Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA87E6B26
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjKINUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:20:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C37B30D3;
        Thu,  9 Nov 2023 05:20:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EEBC433C8;
        Thu,  9 Nov 2023 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699536033;
        bh=E4W6J/5ZYEJjJNXSptSCcUbzx0AqvGA+6wYmOROwYnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgwaj2a8odr+tdl/sx7LLKHFX9YRTutZbiZxTDklCJxU5xdPNeFNHkyYIUxVrMt3q
         zpEMTIhP3ififF2jZxG2FFlTyabtVfyvnl4agv0t5vx3uCfcqsBUhhJX4JpVGWExCO
         sFYYVAnsMZr9WVFoAacQkXXPFWxKfrvPlxf6fP8o=
Date:   Thu, 9 Nov 2023 14:20:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     git@amd.com, michal.simek@amd.com, jacmet@sunsite.dk,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, radhey.shyam.pandey@amd.com,
        srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
        manion05gk@gmail.com
Subject: Re: [PATCH] serial: uartlite: Use dynamic allocation for major number
Message-ID: <2023110915-trusting-pointer-40b0@gregkh>
References: <20231109123640.1740310-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109123640.1740310-1-manikanta.guntupalli@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:06:40PM +0530, Manikanta Guntupalli wrote:
> Device number 204 has a range of minors on major number.
> uart_register_driver is failing due to lack of minor numbers
> when more number of uart ports used.

So you need more than the 4 allocated to you?

> So, use dynamic allocation
> for major number to avoid minor number limitation on 204 major
> number.
> 
> https://docs.kernel.org/arch/arm/sa1100/serial_uart.html

What does this break by doing this?

Also, you forgot to update the documentation :(

And how was this tested?  What about older systems with static device
nodes, are you sure none are out there for this old hardware anymore?

thanks,

greg k-h
