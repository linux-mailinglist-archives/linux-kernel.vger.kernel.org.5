Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0937A5DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjISJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjISJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:32:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16572EC;
        Tue, 19 Sep 2023 02:32:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F1C433B9;
        Tue, 19 Sep 2023 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695115920;
        bh=XoKfY+2bobKh/T78yDrtW3xvz2h+QyrN4E4QTW95BE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVsJ0b6euwIwWufSA/LmyTOQF4AIwvp6znQq4JDF0eufBxQPs9o/DkMoTz4rmizr6
         FCj2YNCSk5Z/v/uAk6JqJKXTpyMc1umm9Nx+iIRbLj1OSFgnUBR3SpQRMEZ31Lf+1y
         TxoAhKSu9Eck8DWjb8o1lS5/Zwb/ezjTk+rq5FMQ=
Date:   Tue, 19 Sep 2023 11:31:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     eadavis@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Message-ID: <2023091921-duke-gory-866e@gregkh>
References: <2023091922-unplug-flask-f2e5@gregkh>
 <20230919092225.3732786-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919092225.3732786-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:22:26PM +0800, Edward AD wrote:
> On Tue, 19 Sep 2023 10:29:08 +0200 Greg KH wrote:
> > > When the call to gsm_register_devices() fails, we need to reclaim the memory
> > > requested in gsm_dlci_alloc().
> > >
> > > Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> > > Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> > > Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> > 
> > Please use your company name/email address, and then just set a manual
> > "From:" line as the first line in the changelog as the documentation
> > asks.  That's how developers work around their broken corporate email
> > systems (but really, you should go and poke your IT group to fix it.)
> This repair was completed in my personal time. Additionally, there may be a 
> possibility of the company's email being thrown away by 'lore.kernel.org'. 
> If you are not very strict with this, I will continue to use my private email.

As you previously submitted this under your company name/address, we
have to be strict for obvious reasons, sorry.

> I will only keep one line starting with 'From:' in the patch.

I don't understand what you mean by this.

greg k-h
