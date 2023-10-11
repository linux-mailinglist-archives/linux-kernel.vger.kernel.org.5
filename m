Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138D37C4E94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbjJKJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbjJKJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:26:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3A9D;
        Wed, 11 Oct 2023 02:26:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7802A21847;
        Wed, 11 Oct 2023 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697016410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/EBe5ZBlc1UdzTBDkR0kZny3LfCJ1gv2QaEQ5cP4Aw=;
        b=FQ63SgUDnaAzC38d7plQBWOaiF9HqTgWJODPIBu/yLTLsYZbMyINt8sIHx10rtfQMRZ683
        ZVVgRlpzKDsaem1BjpKLyAK/wf3er9xPYWfp7qj2pZ04DwGYAeXg1GfDELOUxBn87K3MTd
        7MiomytD9Up9a0YBj2omi0xB5ub1OVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697016410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/EBe5ZBlc1UdzTBDkR0kZny3LfCJ1gv2QaEQ5cP4Aw=;
        b=7K6e8JrotMQJiKx0rlXxl35F8w5WVDZk2BkfOQ7g7N/97vnFgoiSoBwKIZr3c3e/NJFHxZ
        UJs847r7DNcBAjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D38F134F5;
        Wed, 11 Oct 2023 09:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7SIXElpqJmW0QAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 Oct 2023 09:26:50 +0000
Date:   Wed, 11 Oct 2023 11:20:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231011092004.GE2211@suse.cz>
Reply-To: dsterba@suse.cz
References: <20231009104840.1bdadc80@canb.auug.org.au>
 <20231009-bauch-gedanken-e02e35804e03@brauner>
 <20231011083754.45a9ed53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011083754.45a9ed53@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 08:37:54AM +1100, Stephen Rothwell wrote:
> Hi Christian,
> 
> On Mon, 9 Oct 2023 18:15:53 +0200 Christian Brauner <brauner@kernel.org> wrote:
> >
> > > I have dropped the vfs-brauner tree for today as there is no way I can
> > > sort them out in a reasonable time.  Please sort this out between
> > > yourselves.  
> > 
> > I'll fix that up!
> 
> The btrfs tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git#for-next)
> has moved again.  I don't know (yet) if this will cause conflicts
> again, but there is a good chance that it will.

I'm updating the for-next snapshost a few times a week but as this would
cause too much work for the VFS merges I'll do one more push but remove
anything that is not finalized for 6.7 merge window.

This should provide a stable base. I may need to push some fixes but
this could be done via the next-fixes branch so that it would not
interfere with auto-merging of the regular for-next.
