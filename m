Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC97DD38B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjJaQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjJaQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:58:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4D8A4C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:57:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE6CC433C7;
        Tue, 31 Oct 2023 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771387;
        bh=53tkJnb8p3NS4ttj6YNNQhw8ctV34HqGQR5VmSDqvsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0pKRxsNHlpsLgfhzLWp1NM+Osw2W6XLPIqWeMKjVPD/86xeI8wxJvflRAOrzrTui1
         /VS3nOZbPRzDwSpy3nilBNv4CfrKSpIqPbf/b6dYYpDorEF8N4VP4DKVMA4yO4e+IM
         O45TwdgoN/jlcN7RXruGGXMavIoQw/Brne4fR8Tg=
Date:   Tue, 31 Oct 2023 17:56:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Rob Landley <rob@landley.net>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
Message-ID: <2023103159-punctuate-amount-f09d@gregkh>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031154417.621742-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
> rootfs currently does not use tmpfs if the root= boot option is passed
> even though the documentation about rootfs (added in 6e19eded3684) in
> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> 
>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>   line.

At this point in time, is there even any difference between ramfs and
tmpfs anymore?  Why would you want to choose one over the other here?

thanks,

greg k-h
