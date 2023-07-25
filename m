Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2A76215A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGYSbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGYSbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC71FC2;
        Tue, 25 Jul 2023 11:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E95E61853;
        Tue, 25 Jul 2023 18:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C6EC433C7;
        Tue, 25 Jul 2023 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690309880;
        bh=oYiFfH4/ejDhli0ntnUBCBnZXV270dLH0QAu/hyht28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/ia/X885onJOScij37SG3MjorUGIzudHT85xBrhaGx9TEDZnLgWX1htTUGKJkXTY
         f62qS50naU0aKLzc8FXvqni2T9PLPQrBfpNnI37fpJhYtoczqmXUdKCSe4hU7pJiAo
         7W/aXRQ8SKTqbqWKLufLC4u5KMuQoKyPuPYsvOh0=
Date:   Tue, 25 Jul 2023 20:31:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ruihong Luo <colorsu1922@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        stable@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re: [PATCH v4] serial: 8250_dw: Preserve original value of DLF
 register
Message-ID: <2023072546-ladies-landlord-8a6d@gregkh>
References: <20230713004235.35904-1-colorsu1922@gmail.com>
 <5fac4a28-ff70-d6e6-dcee-8cb45916789@linux.intel.com>
 <ZLFAD8lblUA6/cVd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLFAD8lblUA6/cVd@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 03:31:11PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 14, 2023 at 03:07:42PM +0300, Ilpo Järvinen wrote:
> > On Thu, 13 Jul 2023, Ruihong Luo wrote:
> > 
> > > Preserve the original value of the Divisor Latch Fraction (DLF) register.
> > > When the DLF register is modified without preservation, it can disrupt
> > > the baudrate settings established by firmware or bootloader, leading to
> > > data corruption and the generation of unreadable or distorted characters.
> > > 
> > > Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> 
> > You forgot to add:
> > 
> > Cc: stable@vger.kernel.org
> 
> It's there. Just not in the commit message. It's fine.

No it isn't, that's not how to have a patch added to the stable tree, as
my form letter says:

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

I'll go fix it up by hand...
