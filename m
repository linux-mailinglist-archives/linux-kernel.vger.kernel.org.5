Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7E7DBB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjJ3OUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjJ3OUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:20:00 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 09AE0C0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:19:55 -0700 (PDT)
Received: (qmail 672852 invoked by uid 1000); 30 Oct 2023 10:19:54 -0400
Date:   Mon, 30 Oct 2023 10:19:54 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ariel marcovitch <arielmarcovitch@gmail.com>, johan@kernel.org,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Gaps in logs while using usb-serial as a console
Message-ID: <968c62ca-0ef2-4bf1-a17b-a6d88d5e2e20@rowland.harvard.edu>
References: <CAFGKuwoFUaXMsOOWJNBenQDG6+syt80Z9pvQQK1XSZFztC2_SQ@mail.gmail.com>
 <2023103052-unpeeled-calibrate-ae48@gregkh>
 <CAFGKuwp7JH8H9vjz8iJ24R9TRW0GDE-O96VBAG4L8X4DhTabXg@mail.gmail.com>
 <2023103003-defection-recess-cf49@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023103003-defection-recess-cf49@gregkh>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:30:15AM +0100, Greg KH wrote:
> On Mon, Oct 30, 2023 at 10:15:30AM +0200, ariel marcovitch wrote:
> > > Please realize that usb-serial console was the result of me loosing a
> > > drunken bet.  It's amazing it works at all.  For "fake" devices like
> > LOL your drunken bet was quite helpful to some people
> > Because modern PCs come without a serial port, I wanted to use it to
> > see early logs on my crashing kernel without having to use printk
> > delay and things like that.
> > I'm curious as to how kernel people debug PCs in general...
> 
> We use a usb debug port connection (it's a special cable).

Sometimes people use netconsole (see 
Documentation/networking/netconsole.rst).  I don't know how common it is 
nowadays, and it may not be quite as reliable as a debug port device, 
but it should still work.  And it doesn't require special hardware.

Alan Stern
