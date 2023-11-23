Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E318E7F5AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjKWJMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKWJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:12:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9F101
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:12:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1DBC433C7;
        Thu, 23 Nov 2023 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700730778;
        bh=zgvtUYdjLY8nf9Pvnu1e7wuBnq+SLxZIBLNnSHDbb4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1oopqca9BSADEWi9Y5SCPdbFj6iQ+IWsop1aLr0I3M6Fn9/QoXoYat5apwnJbdHK
         mY0bvimaK/HKGsW5XqkOUpyOS/Hh6fFzJKT2enH/uCoVGOZ1nit1jsl1UrfLR61ct4
         zBYrEgJhOyavR/C+8bNGY+c93fM9pxR3DLRwbFBjlJaPR1eNdMszII+QJ8IT6J9BCS
         8zpacQqMc8Aw56X7/tU/hzJ48KjKzWEKpag0cyrHHVmDjNPqyMEUzvYUlwmO6Vtdkz
         hUdrpnbcdSw3KSeXs6Pk8dsZBAGl7oAvE/Cr6tjW8H7PGsWZWVtaa5WZzmx406uO4b
         V38DrcvI84AgQ==
Date:   Thu, 23 Nov 2023 09:12:54 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] leds: syscon: Support 'reg' in addition to
 'offset' for register address
Message-ID: <20231123091254.GA1184245@google.com>
References: <20231122230754.2844665-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122230754.2844665-2-robh@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, Rob Herring wrote:

> The register-bit-led binding now also supports 'reg' in addition to
> 'offset' for the register address. Add support to the driver to get the
> address from 'reg'.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> The binding change landed, but v2[1] was never applied. The last 
> resend[2] may have missed kernel.org addresses.
> 
> [1] https://lore.kernel.org/all/20210913192816.1225025-3-robh@kernel.org/
> [2] https://lore.kernel.org/all/20231025190619.881090-2-robh@kernel.org/
> 
>  drivers/leds/leds-syscon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Looks like I just applied the last one.  I'm assuming no additional
changes, but please let me know if that's not the case.

-- 
Lee Jones [李琼斯]
