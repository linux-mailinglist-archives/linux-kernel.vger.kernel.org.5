Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322967C9810
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJOFhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJOFhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:37:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FFA2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:37:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4639FC433C8;
        Sun, 15 Oct 2023 05:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697348252;
        bh=cYiN/rDOSxfdgPDehCPj0uNGMsIsA2nH4XQt//rThOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhLyxXtE2YBZQ/6TVBbyph8qQnh9EKQFvL4amq6L6wMvvedNvdj1VFhX2Q1Rw8k3u
         dPGHtxvdcH6U4pT8iuhtYA1TUNAMclhlqexO9vKOYSHz2zVU/YuUH0WJmLkj3ePn7E
         QCQhfdv6vB92+YmfhXcABwvLiMa4GXXWmz+hpk8I=
Date:   Sun, 15 Oct 2023 07:37:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: gdm724x: Add blank line after declaration
Message-ID: <2023101551-placidly-garnish-3ee7@gregkh>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <3b24ca9976cf873dbaadb499e09d7b545e9db89c.1697184167.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b24ca9976cf873dbaadb499e09d7b545e9db89c.1697184167.git.soumya.negi97@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:26:35AM -0700, Soumya Negi wrote:
> Fix WARNING: Missing a blank line after declarations
> Issue found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 1 +
>  1 file changed, 1 insertion(+)

Why do you have "tty:" as the prefix for a staging driver?  Shouldn't it
be "staging: gdm724x: ...."?

thanks,

greg k-h
