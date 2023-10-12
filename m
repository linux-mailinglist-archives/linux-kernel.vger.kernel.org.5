Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40DB7C71D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjJLPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJLPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:49:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE436B8;
        Thu, 12 Oct 2023 08:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43B821F8A4;
        Thu, 12 Oct 2023 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697125738;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7zcUuGqxLmhdnLjkvlh73uyAMqKR+CEj+MzY0szZiY=;
        b=X/sXIoWUOOHs/rKpdfUBBZmLPKBLZYzVTC/EmZc9cFn7eKJ2VZysrhgBH/9H1E+aBtXgg/
        sMHEnf5aU274XOrk+Uq/vMWxlAKDQBuHh/ySagA4KARbmJL7qqt1HU9y3pcgCUSXI1iWhc
        4J7uSt+Q+w1TDdsVVKPEHn0/vfUA0Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697125738;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7zcUuGqxLmhdnLjkvlh73uyAMqKR+CEj+MzY0szZiY=;
        b=sbnC5hIeFRj8DseFhD4PS7UC3NWjf/4++46lwwfkkD17+4yjLjLOAIMgNDcdERvk0Q4Csc
        dbIHGagKzAbiHODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D729139ED;
        Thu, 12 Oct 2023 15:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X6NEAmoVKGXZPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Oct 2023 15:48:58 +0000
Date:   Thu, 12 Oct 2023 17:42:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231012154210.GI2211@suse.cz>
Reply-To: dsterba@suse.cz
References: <20231009104840.1bdadc80@canb.auug.org.au>
 <20231009-bauch-gedanken-e02e35804e03@brauner>
 <20231011083754.45a9ed53@canb.auug.org.au>
 <20231011092004.GE2211@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092004.GE2211@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:20:04AM +0200, David Sterba wrote:
> On Wed, Oct 11, 2023 at 08:37:54AM +1100, Stephen Rothwell wrote:
> > Hi Christian,
> > 
> > On Mon, 9 Oct 2023 18:15:53 +0200 Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > I have dropped the vfs-brauner tree for today as there is no way I can
> > > > sort them out in a reasonable time.  Please sort this out between
> > > > yourselves.  
> > > 
> > > I'll fix that up!
> > 
> > The btrfs tree
> > (git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git#for-next)
> > has moved again.  I don't know (yet) if this will cause conflicts
> > again, but there is a good chance that it will.
> 
> I'm updating the for-next snapshost a few times a week but as this would
> cause too much work for the VFS merges I'll do one more push but remove
> anything that is not finalized for 6.7 merge window.
> 
> This should provide a stable base. I may need to push some fixes but
> this could be done via the next-fixes branch so that it would not
> interfere with auto-merging of the regular for-next.

The branch for-next at git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
has been pushed with top commit c6e8f898f56fae2cb5bc4396bec480f23cd8b066
and I won't update it (expecting until the merge window).
