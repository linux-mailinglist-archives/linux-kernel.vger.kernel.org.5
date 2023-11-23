Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1833D7F5AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjKWIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:55:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6413392
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:55:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA498C433C9;
        Thu, 23 Nov 2023 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700729711;
        bh=a8bIfdWRjbbeVBGYW6CWhqPVbcXuU1WN/e10YeYK80Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8/Tjm3JpVMhpB+KM7SMZzbHYF4Ry1DWiMCi14G6/nZU6W5eJCWqwhlceu4FHH/Db
         0QMJsUhtZDlgMCH73xQ9CVrPEvDIbR7Pk1RzNoqPkg/sjMy0/Ci1znb7erU2GaobZ1
         7UA3E/FoisWfHVUOr6Rmg+uFsu5PwCIkpC9hhv/s=
Date:   Thu, 23 Nov 2023 08:55:08 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     "syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com" 
        <syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [kernel?] general protection fault in joydev_connect
Message-ID: <2023112332-award-fanciness-2bcf@gregkh>
References: <CABOYnLyCRyK4qpS2X8ssA6yxCDtEWR3dSsee2Lm6VCQUyD07VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLyCRyK4qpS2X8ssA6yxCDtEWR3dSsee2Lm6VCQUyD07VQ@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:55:50PM +0800, xingwei lee wrote:
> Hi. I have reproduced this bug with repro.txt and repro.c below:
> 
> repro.txt
> r0 = openat$uinput(0xffffffffffffff9c, &(0x7f0000000500), 0x802, 0x0)
> ioctl$UI_DEV_SETUP(r0, 0x405c5503, &(0x7f0000000080)={{0x0, 0xffff,
> 0x3}, 'syz0\x00'})
> ioctl$UI_DEV_CREATE(r0, 0x5501) (fail_nth: 51)

You are using fault injection, which, by it's very name, causes faults :)

Can you reproduce it without causing faults in the kernel?  And if so,
can you create a patch to fix this?

thanks,

greg k-h
