Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6020E7D95EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbjJ0LD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbjJ0LD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ACD9C;
        Fri, 27 Oct 2023 04:03:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2E1C433C8;
        Fri, 27 Oct 2023 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698404635;
        bh=rKqTsV9BKs2B75uTkGng9ux0ILcsTDMPSxQwjPaFWkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxyV9PfOYYe4HD8hDn8OIR17NlgLmYO5UXZzKhYq1xjn9D18NGhS+r0Dqx4g8FtAJ
         24uq3TBrr3yeWNbIZgVUw7THjdZaZAw8uoNJD47t6itNI3rdq52VHFYL+Rd8uQnYg4
         7pBcbjy1nyuA+XA419DRA2NlRmi7me+HWnhBnaNo=
Date:   Fri, 27 Oct 2023 13:03:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v4 0/7] Fixes and improvements for RS485
Message-ID: <2023102707-customer-nastiness-9c80@gregkh>
References: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 07:48:33PM +0200, Lino Sanfilippo wrote:
> The following series includes some fixes and improvements around RS485 in
> the serial core and UART drivers:
> 
> Patch 1: Do not hold the port lock when setting rx-during-tx GPIO
> Patch 2: set missing supported flag for RX during TX GPIO
> Patch 3: fix sanitizing check for RTS settings
> Patch 4: make sure RS485 is cannot be enabled when it is not supported
> Patch 5: imx: do not set RS485 enabled if it is not supported
> Patch 6: omap: do not override settings for rs485 support
> Patch 7: exar: set missing RS485 supported flag
> 
> Changes in v4:
> - add comment for function uart_set_rs485_gpios after hint from Hugo
> - correct commit message as pointed out by Hugo
> - rephrase commit messages
> - add patch 7 after discussion with Ilpo

There's a lot of fuzz for this series against my current tree, so much
so I don't feel comfortable taking it right now.  Can you resend it
after 6.7-rc1 is out and you have rebased it against that?  If these
really are all bugfixes, we can still get them into 6.7-final then.

thanks,

greg k-h
