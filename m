Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E497510D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGLTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGLTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBEB1BF8;
        Wed, 12 Jul 2023 12:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 050C3618CE;
        Wed, 12 Jul 2023 19:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB81C433C8;
        Wed, 12 Jul 2023 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689188430;
        bh=C75X2BnyEWDXBPD/0Zfk2U9UagD2+DsJ0ryNEGmeRYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kkxIXB1mjYsJzX/NO5wASfnLQjv3gxKU/O7ohYn38fe9Ls155Kge8I3xZGDCp/Hna
         khFKdJ1mUtbXr22HE9R0HLg+2RilUQAUAC+SEKT9lzFZXRSYCVUBvtDcLHZFYqsgbv
         HX1DK7bqMtC69K2ji+7JS373MAlvfvSxSSahzBaw=
Date:   Wed, 12 Jul 2023 21:00:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
Message-ID: <2023071215-able-mushy-c889@gregkh>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
 <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
 <2023071221-blade-reactive-0707@gregkh>
 <d8403c45-3561-4759-f6c2-d18afa5e323a@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8403c45-3561-4759-f6c2-d18afa5e323a@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 07:02:34PM +0200, Thorsten Leemhuis wrote:
> On 12.07.23 17:16, Greg KH wrote:
> > On Wed, Jul 12, 2023 at 11:30:30AM +0200, Thorsten Leemhuis wrote:
> >> While working on the latter I noticed one more thing:
> >>
> >> ```
> >>     .. warning::
> >>        The -stable-rc tree is a snapshot in time of the stable-queue
> >> tree and
> >>        will change frequently, hence will be rebased often. It should
> >> only be
> >>        used for testing purposes (e.g. to be consumed by CI systems).
> >> ```
> > [...]
> >> I'll thus likely
> >> change the text to something like this,
> >> unless I'm missing something or someone has a better idea:
> >> ```
> >>   .. warning::
> >>      The branches in the -stable-rc tree are rebased each time a new -rc
> >>      is released, as they are created by taking the latest release and
> >>      applying the patches from the stable-queue on top.
> > 
> > Yes, that is true, but they are also rebased sometimes in intermediate
> > places, before a -rc is released, just to give CI systems a chance to
> > test easier.
> > 
> > These are ONLY for CI systems to use, nothing else should be touching
> > them.  So I think the current text is correct, what am I missing?
> 
> That I misunderstood things and forgot about the "rebased sometimes in
> intermediate places" aspect I once knew about. Sorry. I'll leave the
> text as it is then.
> 
> Nevertheless makes me wonder: is that strategy wise in times when some
> ordinary users and some distributions are building kernels straight from
> git repos instead of tarballs? I'm one of those, as I distribute
> stable-rc packages for Fedora here:
> https://copr.fedorainfracloud.org/groups/g/kernel-vanilla/coprs/

As we keep the patches in quilt, not git, it's the best we can do.  The
-rc releases are never a straight-line if we have to do multiple ones,
we remove patches in the middle, add them at the end or beginning, and
sometimes even change existing ones.

All of this is stuff that a linear history tool like git can't really
model well, so we keep a quilt series of the patches in git for anyone
that want to generate the tree themselves, and we provide the -rc git
tree for those that don't want to generate it and can live with the
constant rebasing.

thanks,

greg k-h
