Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E737B6A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjJCNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjJCNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:24:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B4A3;
        Tue,  3 Oct 2023 06:24:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCC4C433C7;
        Tue,  3 Oct 2023 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696339490;
        bh=CxIkwypfvU3z9vygcWVVY8BLzFLCggWhUa897wUjQuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFtKp3ziuL2SwnrsuKpC1Vb9fS1fyG4AE/0ohTmt1ckKJfoZ84PfM9GTsOwSiRqGl
         WqKcMz5Azhe9j7okYGNJRZOqSNwUFw3dhLP5R060pk9/EIQW4cLGgMJjxwk3CAaG1H
         E5vH0txHpuDKCQGZQzXnqyaPkPxZoZDdosc2jGDRb3XjgBcmacyWuBJNn3n2LWsM8G
         sianjMN9J9ez3/lPf+uHTYw4fxR9YyX0Gh4qavI6no4QqwnWvwoPk+LY4RKWdDVfjy
         Rt8o/IUiunpsZHxVREeU9/psOyva7fYrbAu5YLVYb1Ul6c7Ek8RdPU3bIwnPuKMrye
         Z4oebvtYlhJvg==
Date:   Tue, 3 Oct 2023 15:24:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231003-kalziumreich-besonderen-2f067cc50606@brauner>
References: <20231003093005.66556fcb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003093005.66556fcb@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:30:05AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs-brauner tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ERROR: modpost: "fget_files_rcu" [arch/powerpc/platforms/cell/spufs/spufs.ko] undefined!
> 
> Caused by commit
> 
>   af66b51563ad ("file: convert to SLAB_TYPESAFE_BY_RCU")
> 
> I applied the following fix up patch.

Thank you. On vacation this week (I saw Jan already informed you.) but I
fixed this up by removing fget_files_rcu() exposure in a header
completely.
