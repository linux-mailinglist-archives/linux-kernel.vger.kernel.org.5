Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC1784B42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHVUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjHVUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C599BCC;
        Tue, 22 Aug 2023 13:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B98A64C4C;
        Tue, 22 Aug 2023 20:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7540C433C7;
        Tue, 22 Aug 2023 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692735544;
        bh=EujVosjeaZ6M6kI84/Zavgo9fVOB6xqVrX6gHH9XfbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbWELs9A+JWPanbDLc/gZ7GQTS2gRZRpeSDLYBfiXvygLWNV9/r9XggxBeQfXWvnu
         K6X3oUq+On3221bv7iz686CdVgizcgubRagsTyTjZ8cS+NZjDuLK5jlZc6nFdbi54l
         1CZWulleuaHSR7eq9a/OA+jmKgUOKgE+oMChAy/9dkdjpA+cURd93ZYejFqb5FgFJ2
         o+7PouZgP/J9XyDjDtKgtneyuCjUuSFMXMrwNnNyVEuFaOALxrbn9GgOjwB6+0VuX8
         Ewo95d0q4BfAymulZSPCXaBpE4/vBk8vH/EfWfvkQL1+9Ivag19TpXoB2F06Rxzh6A
         MoeP7PinHfyUw==
Date:   Tue, 22 Aug 2023 22:19:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 djw-vfs tree
Message-ID: <20230822-mitbringen-unwillig-176fd9e8873b@brauner>
References: <20230822110551.6386dd5d@canb.auug.org.au>
 <20230822025120.GA11286@frogsfrogsfrogs>
 <20230822-turnus-quert-9b11d4e30dc9@brauner>
 <20230822182604.GB11286@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822182604.GB11286@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > my preferred solution. How do you feel about that?
> 
> I'm happy to have you pull my xfs-linux tags into your vfs tree. :)

Ah, sweet. I apppreciate that. I'll mention in the pr to Linus that if
he wants to reject other parts of the super work that he should then
still simply pull the freeze stuff from you without the rest.

> 
> Here's a tag with just the two vfs patches:
> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/tag/?h=vfs-6.6-merge-2
> 
> This second tag builds on that, by adding the first actual user of
> FREEZE_HOLDER_KERNEL:
> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/tag/?h=vfs-6.6-merge-3

Assuming I understood correctly I did just pull both tags and pushed
them out. Would you please take a look at
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.super
and let me know if everything looks as expected? I'll be going afk in a
bit just waiting for the kernel build to finish to kick of some
xfstests. If you find anything I'll fix up any issues up tomorrow
morning.

> 
> There will be more for 6.7(+?) if Luis manages to get back to his
> auto-fsfreeze during suspend, or if Shiyang finishes the series to
> handle pmem media error reporting in xfs.

Ok, sounds good let me know/Cc me when ready/needed.

Thanks for all the help!
