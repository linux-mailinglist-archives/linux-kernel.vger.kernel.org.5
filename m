Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFF7D3E77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjJWSCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjJWSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:02:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE773A1;
        Mon, 23 Oct 2023 11:02:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E59E1FE2E;
        Mon, 23 Oct 2023 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698084127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3WlEZgcIfJgRIrkvHNxp4feVtb0Iw1T4imeJTf297tM=;
        b=LgZh1CEVdA7r6IDeEqXHbSBD/snh/RWLxWCD9gPSk++eybKxd8um19wZr420mX9YNdh06s
        wS6jqhSVYsgT2vUQ9G2agqm2e+T8K9ABQoipvly83BAATHX/TZi5Xdu7v/vtoma5XSQrmp
        DmxJpDzxs4TTLJSAjlgxyiJS6YzCBMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698084127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3WlEZgcIfJgRIrkvHNxp4feVtb0Iw1T4imeJTf297tM=;
        b=Z73oakCOzFmyaArMP88UwjCH481M9ef0XATvk8GW6yywhxagNCUYCIaaUCcBBc0DwxVtkU
        sG7HGDGqP6VmPuBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35818132FD;
        Mon, 23 Oct 2023 18:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TDNmDB+1NmWzXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 23 Oct 2023 18:02:07 +0000
Date:   Mon, 23 Oct 2023 19:55:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231023175513.GL26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231009104840.1bdadc80@canb.auug.org.au>
 <20231009-bauch-gedanken-e02e35804e03@brauner>
 <20231011083754.45a9ed53@canb.auug.org.au>
 <20231011092004.GE2211@suse.cz>
 <20231012154210.GI2211@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012154210.GI2211@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:42:10PM +0200, David Sterba wrote:
> On Wed, Oct 11, 2023 at 11:20:04AM +0200, David Sterba wrote:
> > On Wed, Oct 11, 2023 at 08:37:54AM +1100, Stephen Rothwell wrote:
> > > Hi Christian,
> > > 
> > > On Mon, 9 Oct 2023 18:15:53 +0200 Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > > I have dropped the vfs-brauner tree for today as there is no way I can
> > > > > sort them out in a reasonable time.  Please sort this out between
> > > > > yourselves.  
> > > > 
> > > > I'll fix that up!
> > > 
> > > The btrfs tree
> > > (git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git#for-next)
> > > has moved again.  I don't know (yet) if this will cause conflicts
> > > again, but there is a good chance that it will.
> > 
> > I'm updating the for-next snapshost a few times a week but as this would
> > cause too much work for the VFS merges I'll do one more push but remove
> > anything that is not finalized for 6.7 merge window.
> > 
> > This should provide a stable base. I may need to push some fixes but
> > this could be done via the next-fixes branch so that it would not
> > interfere with auto-merging of the regular for-next.
> 
> The branch for-next at git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
> has been pushed with top commit c6e8f898f56fae2cb5bc4396bec480f23cd8b066
> and I won't update it (expecting until the merge window).

I have updated my for-next branch again, sorry (top commit 1a4dc97c883a4f763cbaf50).
There are some fixes I don't want to miss from the 6.7 pull request.
There should be minimal change to the VFS tree conflict resolution so
the diff should be reusable.
