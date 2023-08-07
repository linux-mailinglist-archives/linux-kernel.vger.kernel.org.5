Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBE77291D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjHGP0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjHGP0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0EC83
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF23261E03
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB24C433C7;
        Mon,  7 Aug 2023 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691421972;
        bh=fqUuoBJCLCaWtjsfkRUPNSG8YF8xLnqGYw03JAiy+g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmcfMmf8om5sN6Swzz80F5I8nqef8JzZIhk7oza6Rbpq29OBYP8doQu7TaQXkwtj/
         8CBrfW4hmlc7igg3N05EBz4Ghhfp8phBMClogYqwceDXdv/pIKU8qx2wd0yVWc1AGG
         y4KTOHAV/DCSFBWsVDZlNgbOMAY7ZwoJqDLaodbk=
Date:   Mon, 7 Aug 2023 17:26:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <2023080746-consonant-employed-030d@gregkh>
References: <ZM1rsu0M22HHtjfl@alolivei-thinkpadt480s.gru.csb>
 <2023080510-vacation-support-7afe@gregkh>
 <ZNEKJH3mEoOwV6eF@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEKJH3mEoOwV6eF@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 12:13:40PM -0300, Alexon Oliveira wrote:
> On Sat, Aug 05, 2023 at 08:14:33AM +0200, Greg KH wrote:
> > On Fri, Aug 04, 2023 at 06:20:50PM -0300, Alexon Oliveira wrote:
> > > Fixed all CHECK: Alignment should match open parenthesis
> > > as reported by checkpatch to adhere to the Linux kernel
> > > coding-style guidelines.
> > 
> > This does not describe the changes you actually made in this patch :(
> > 
> Hi Greg,
> 
> Thank you for your feedback. Don't get me wrong, please, I'm just trying
> to understand it now, but honestly I don't know what is wrong with
> it this time. I described exactly what I did in the code: ran the
> checkpatch, which identified a lot of "CHECK: Alignment should match
> open parenthesis" messages, fixed them all according to the coding-style
> guidelines and comitted it.

But you did not change the alignment of the open parenthesis, right?
You deleted the trailing whitespace.

> 
> This is the same thing I did previously for the file
> drivers/staging/vme_user/vme_bridge.h in the commit
> 7d5ce25fb4c3cc91d16e27163dc141de0eba213b, but now is the file
> drivers/staging/vme_user/vme.c and commit
> a1f0b0a8ba9a496504c2e3d4b37cee388e78f0ea. Different files,
> different commits, similar fixes for the same warnings,
> and same description.
> 
> The only thing I found strange is because instead of starting a new
> email thread it ended up in the same email thread as the previous
> patch. Would that be the problem?

That would be a problem, and it seems you used the same subject line as
previous patches that were different?

Anyway, my comment was about the trailing whitespace change.

thanks,

greg k-h
