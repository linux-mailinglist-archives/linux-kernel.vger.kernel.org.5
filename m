Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7EC765A18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjG0RVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjG0RVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:21:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732613C00
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C32C61F0D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A4C433C8;
        Thu, 27 Jul 2023 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690478471;
        bh=1siF8FEzIm/u9nbl1sknyH/SiSYpK9pi4eRex4u1zSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufU3DUXJT2VB/NpAfG2FWTTFW+/OmMFFUxDSz+qZgzAD9FBJ7NugNg2dN+YmO/3HB
         pVa+tG3mh4DgcW0i+KlbnF1Hfeiyxmx7aIdxD5P5SEiFwwJJdDP9TEnI7eBTAiS1Of
         YELuN9s4gUI63hao133fWBeTxa0xKdFNSKzPbVJc=
Date:   Thu, 27 Jul 2023 19:21:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <2023072752-stem-pupil-76ab@gregkh>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
 <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
 <2023072741-mankind-ethics-b95b@gregkh>
 <ZMKkgItqf8r8BcRB@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMKkgItqf8r8BcRB@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:08:16PM -0300, Alexon Oliveira wrote:
> On Thu, Jul 27, 2023 at 05:05:03PM +0200, Greg KH wrote:
> > You resolved one warning by replacing it with a different one, that's
> > not good :(
> 
> Well, honestly, I couldn't spot any new issue caused by this patch. At least it was not reported by the checkpatch.pl. The ones that are still showing up were already there. But, to move on, if you think it's more productive, I can fix all warnings and checks reported by the checkpatch.pl and send them over in only one patch. Is it that feasible?

I would have thought you would get a "line is too long" warning, that
didn't happen?

Anyway, no, you can't send a "fix all the issues at once" patch, sorry,
if you do that you will get a message from my patch bot that says:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

So please break it up into logical changes.

thanks,

greg k-h
