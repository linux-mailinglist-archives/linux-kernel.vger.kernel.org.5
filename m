Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3104878A040
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjH0Qrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjH0Qrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:47:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7AFA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7382619B9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62FBC433C7;
        Sun, 27 Aug 2023 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693154857;
        bh=/2yYss0mXQw0a3CVsDaLwI8APat97dVsnVdJ8zWStSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhicOAyD28nAEWr9xc2z8+o1cKDLNIsQtH5yWLyh3YO9zmqrtppWipR3gh/C3bho7
         7e9tW0q2fxd5pujoqQ60nefSa1MEbzDyxTXmEzWGAu4lcoQ64it+24XZ+3LtsW/8el
         TvhYq4OOUph0LTGvvjUiPhnKsMMOPUFbE/M1/C4c=
Date:   Sun, 27 Aug 2023 18:47:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, luisbg@kernel.org,
        salah.triki@gmail.com,
        syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
Message-ID: <2023082746-antelope-drop-down-5562@gregkh>
References: <24deab57-5480-3af6-17e6-0874aeaef3db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24deab57-5480-3af6-17e6-0874aeaef3db@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 04:46:40PM +0530, Manas Ghandat wrote:
> Hi Greg,
> 
> Sorry for directly mailing to you but I tried to reach the maintainers for
> quite some time now. I haven't received any response on my patch. I was told
> to mail you in order to get my patch pulled.
> 

I have no context here, sorry.

Also, I am not a filesystem developer or maintainer.  And befs?  I doubt
that's maintained anymore as the operating system is long obsolete,
right?

confused,

greg k-h
