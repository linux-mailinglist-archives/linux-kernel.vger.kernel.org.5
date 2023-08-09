Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F82775435
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHIHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHIHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89CE61;
        Wed,  9 Aug 2023 00:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE17762FF7;
        Wed,  9 Aug 2023 07:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33DBC433C8;
        Wed,  9 Aug 2023 07:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691566427;
        bh=iU8R+ctz5geLHcyaRS5E4bRzn4q4mLf4kYxs6vhpb4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Frcq2eRDJx+94e28igWtMCyYxOS5S0rYec9mTgOKf9RJFSrmGx6OkbTpUAvzW00Rk
         Eaf0z7SKRl4/VuadYzGlcU8A0pHQLfj6LOoS5daj/TazggFH8g5GRU4bgJasSS6EPq
         HyV5eeZw9eJDz0xoyXNw3V5sHrywdIp5u1g9/9DY=
Date:   Wed, 9 Aug 2023 09:33:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, Yuezhang.Mo@sony.com,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: Patch "exfat: move exfat_entry_set_cache from heap to stack" has
 been added to the 5.10-stable tree
Message-ID: <2023080916-retype-backup-ecfd@gregkh>
References: <20230809014920.320461-1-sashal@kernel.org>
 <2023080949-reveal-curling-20fa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080949-reveal-curling-20fa@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:32:18AM +0200, Greg KH wrote:
> On Tue, Aug 08, 2023 at 09:49:19PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     exfat: move exfat_entry_set_cache from heap to stack
> > 
> > to the 5.10-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      exfat-move-exfat_entry_set_cache-from-heap-to-stack.patch
> > and it can be found in the queue-5.10 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This patch broke the build, so I've dropped it, and the other exfat
> patches from the 5.10.y queue for now.

I take that back, I've only dropped this one patch, the others can stay
(including the real fix that this one was added for.)  So all should be
good now.

thanks,

greg k-h
