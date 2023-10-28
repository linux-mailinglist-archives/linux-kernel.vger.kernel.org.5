Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BFB7DA663
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjJ1KXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjJ1KXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:23:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B56ED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:23:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36144C433C7;
        Sat, 28 Oct 2023 10:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698488584;
        bh=Ybc/3OKDFGr5Oyuw6CaiBiWX3vORQK3q2t4/NJUbrXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/iIJVX7lQLpJrPONMym5FcssbOZKkCH7AvDEiJF8Qqgc48y1q8cDV9Czrv3Sv8ki
         55Q8RFG+SNz0Bp2SfgGtMSgAcWZvuxdRxuRHuuDHnMhklE2nLQj+tC1G5eXQAdppgN
         WumCyYuewnPDjHGgu6N5QRmaV5Cwy/zNzbqRTF+4=
Date:   Sat, 28 Oct 2023 12:23:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     LihaSika <lihasika@gmail.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux USB Storage <usb-storage@lists.one-eyed-alien.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Milan Svoboda <milan.svoboda@centrum.cz>,
        Matthieu Castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] usb: storage: set 1.50 as the lower bcdDevice for older
 "Super Top" compatibility
Message-ID: <2023102848-esteemed-reptile-851f@gregkh>
References: <ZTsR-RhhjxSpqrsz@debian.me>
 <055de764-c422-4c22-a79b-dd4db56122ce@gmail.com>
 <2023102704-stable-lid-c86a@gregkh>
 <7484f7c8-a49c-4111-83f0-bb6db2906fae@gmail.com>
 <2023102729-spent-ninja-7e39@gregkh>
 <037e5af2-3afd-4a37-a4d7-6dc87af605c7@gmail.com>
 <21c2b8ee-7753-413e-98f9-d1401edf5c73@gmail.com>
 <2023102720-emotion-overlying-9bb4@gregkh>
 <ccf7d12a-8362-4916-b3e0-f4150f54affd@gmail.com>
 <ZTyyDXYR4f6WKdLM@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTyyDXYR4f6WKdLM@debian.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 02:02:37PM +0700, Bagas Sanjaya wrote:
> On Fri, Oct 27, 2023 at 08:28:04PM +0300, LihaSika wrote:
> > Change lower bcdDevice value for "Super Top USB 2.0  SATA BRIDGE" to match
> > 1.50. I have such an older device with bcdDevice=1.50 and it will not work
> > otherwise.
> 
> What about below description?
> 
> ```
> Some old USB hard drives using Super Top USB 2.0 SATA bridge have lower
> minimum bcdDevice value than currently allowed (1.60). Such devices
> cannot be used by ums-cypress driver since their bcdDevice is out of range.
> 
> Lower minimum bcdDevice to fix that. 
> ```
> 
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Liha Sikanen <lihasika@gmail.com>
> 
> Is your intended author name in your From: header or Signed-off-by: trailer?
> 
> Also, don't forget to add Fixes: tag; that is:
> 
> Fixes: a9c143c82608 ("usb-storage: restrict bcdDevice range for Super Top in Cypress ATACB")
> 
> When above reviews are addressed, resend as v2. Make sure that the patch
> subject begins with `[PATCH v2]`.

There's no need, I can take this as-is, thanks.

greg k-h
