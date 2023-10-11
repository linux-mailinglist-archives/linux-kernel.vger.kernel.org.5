Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FEE7C5A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjJKRrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjJKRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:47:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9298;
        Wed, 11 Oct 2023 10:47:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB214C433C8;
        Wed, 11 Oct 2023 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697046449;
        bh=6gk3lV9H02jasWYgxY4XpO2pvYNQaiPtpbSGkq2ai3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBzWjpZGQfV24e9/4CLpBiMWewMbCLso6+UMnO/uCdI+p0aCu9w6I94CyZ156lEZe
         GTdLy09uuc994KvwQPZVLBxud3X82azkcLs+aNY5D62Daj0qZ3G1OBsQ4QzgdD5aGE
         NkCHoc0Mr5PyQguTnRqtBTBUhJKQHZwji7WzJhA4=
Date:   Wed, 11 Oct 2023 19:47:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v2 2/7] serial: amba-pl011: get rid of useless wrapper
 pl011_get_rs485_mode()
Message-ID: <2023101101-knoll-dust-6308@gregkh>
References: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
 <20231011173829.10508-3-l.sanfilippo@kunbus.com>
 <2023101134-theater-oversleep-a58b@gregkh>
 <20d22e11-b9be-b547-ec4e-9964a57924a4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d22e11-b9be-b547-ec4e-9964a57924a4@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:44:51PM +0200, Lino Sanfilippo wrote:
> 
> Hi,
> 
> On 11.10.23 at 19:42, Greg KH wrote:
> > On Wed, Oct 11, 2023 at 07:38:24PM +0200, Lino Sanfilippo wrote:
> >> Due to earlier code changes function pl011_get_rs485_mode() is now merely
> >> a wrapper for uart_get_rs485_mode() which does not add any further
> >> functionality. So remove it and instead call uart_get_rs485_mode()
> >> directly.
> >>
> >> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >> ---
> >>  drivers/tty/serial/amba-pl011.c | 14 +-------------
> >>  1 file changed, 1 insertion(+), 13 deletions(-)
> >
> > Why is patch 2/7 not cc: stable, when patches 3-7 are?  Either this
> > patch isn't needed in this series, and can go later (or to a different
> > branch), or it also needs to be marked for stable as the later patches
> > depend on it?
> >
> 
> 2/7 is really only a cleanup patch that does not provide a bugfix.
> Should I remove it from this series?

Please do, and send it later, or as part of a separate patch series
independant of this one.

thanks,

greg k-h
