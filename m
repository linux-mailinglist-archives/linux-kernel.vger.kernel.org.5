Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662B87A45AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbjIRJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjIRJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:13:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39F101;
        Mon, 18 Sep 2023 02:13:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5FEC433C9;
        Mon, 18 Sep 2023 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695028430;
        bh=whlYEbg0DzO/KaeHx4IUmv+8ht2g6zEaB02kgj9QRlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVm9RoqmY9pw5j44iuI9/V8VmPSZxWjziZszTcS9OtJCx0/Swm1yDih28d1PFw6G1
         KdQJdRt/sgY2gl736SZk+ifKSvueR40EfGgw+Uv8hJ/W85OjufeN8NW/WGetRgmI1e
         n9yqvrlBefFHJaC41Btz0KylriOQnNoWycArC9GU=
Date:   Mon, 18 Sep 2023 11:13:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <eadavis@sina.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Message-ID: <2023091850-fever-nintendo-a2b6@gregkh>
References: <2023091826-spherical-shindig-016b@gregkh>
 <20230918084526.2824669-1-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918084526.2824669-1-eadavis@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:45:26PM +0800, Edward AD wrote:
> On Mon, 18 Sep 2023 10:06:58 +0200, Greg KH wrote:
> > > When the call to gsm_register_devices() fails, we need to reclaim the memory
> > > requested in gsm_dlci_alloc().
> > >
> > > Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> > > Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> > > Signed-off-by: Edward AD <eadavis@sina.com>
> > > ---
> > >  drivers/tty/n_gsm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > This message never made it to lore.kernel.org, so you might need to fix
> > up your email system so that it doesn't get dropped from there.
> This matter has been bothering me all along. I don't know why, some of the 
> patch emails I sent can be quickly responded to by "lore. kernel. org" correctly, 
> while others cannot. It wasn't until someone like you replied that I could see the 
> patches I sent.
> > 
> > Can you do so and resend?
> Yes, I can.
> However, it may take a long time as I currently do not know how to set up my email 
> system to avoid such issues from occurring.

Look at the tool `patatt`, it's what we use in `b4` to verify emails are
correct and sent by whom they say they are sent by.

Yours fail the checks by that tool, so try sending yourself an email and
work from there.

good luck!

greg k-h
