Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892097DE327
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjKAO2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbjKAO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B587DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:28:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5576AC433C7;
        Wed,  1 Nov 2023 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698848883;
        bh=a0qkXSjOyDeXe1GXN/anRJBe4gdOp1j2urwMHhRe9Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF5SS8UFB2nUpJNvZouZVdpKHp8hqj4/0yCpPoT7m2clkvx/FPVII0EBS5Vm6xCAk
         OB7Q97Jqyhvq5ex/RqUT7fnF0i3A/sbx3ntYHLmsXrDHFcEhnlnNRKtAkKu75CGCgP
         DMtRSZOfneiQa2owLfbYMkqfdWDR2P/plYqPXPaA=
Date:   Wed, 1 Nov 2023 15:28:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
Message-ID: <2023110159-rasping-stature-af8d@gregkh>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
 <2023103159-punctuate-amount-f09d@gregkh>
 <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
 <a8693232-431e-4840-a020-cd83c162446e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8693232-431e-4840-a020-cd83c162446e@linux.ibm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:16:37AM -0400, Stefan Berger wrote:
> 
> 
> On 11/1/23 07:35, Rob Landley wrote:
> > On 10/31/23 11:56, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
> > > > rootfs currently does not use tmpfs if the root= boot option is passed
> > > > even though the documentation about rootfs (added in 6e19eded3684) in
> > > > Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> > > > 
> > > >    If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
> > > >    default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
> > > >    line.
> > > 
> > > At this point in time, is there even any difference between ramfs and
> > > tmpfs anymore?  Why would you want to choose one over the other here?
> > 
> > I submitted a patch to fix this to the list multiple times, which got ignored as
> > always. Most recently here:
> > 
> > https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
> 
> Everyone,
> I now responded to Rob's patch over here:
> https://lkml.org/lkml/2023/11/1/333

Note, we can't do anything with lkml.org links, they don't even work at
times, please always use lore.kernel.org

Also, one patch out of a longer series also will not work as we can't
pick it up from there either.

Can someone resend it, as a stand-alone patch, with the proper people
 cc:ed and then we can handle that.  You all know this...

 thanks,

 greg k-h

> 
> 
> > 
> > Rob
