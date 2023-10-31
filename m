Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FB67DC8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjJaIwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjJaIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:52:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184CDB;
        Tue, 31 Oct 2023 01:52:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FFE31F38C;
        Tue, 31 Oct 2023 08:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698742319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+iYeM98QfMfdGUAHhPC4lg66X9RsOV61gBe01YkBns=;
        b=SpPphZo/6p6SGomQgaf7GPs5FA3OxG4KnZLA9RGqG0bvpwA4CeaZJLYx2K/L385+aHO2hY
        zOUxbGs3BN1pdCmiezpNj2E+8xNzOQLIHelUgLnF/rpzBVRr4icbT+DzEFPwQY2GU/Vj0M
        +kvqfzAveBz1JAjpnvEF/fU7ZNrtvjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698742319;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+iYeM98QfMfdGUAHhPC4lg66X9RsOV61gBe01YkBns=;
        b=qSoR7otn2JCkxrFpZSaCgRgco75LeprvVlMoZIPSq4WdfGA3OCFKVuK8GrEE0VwYpHwsuv
        o5RXH2iJJ0+TpPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7A5A138EF;
        Tue, 31 Oct 2023 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LUWEOC7AQGXwTAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Oct 2023 08:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 76549A06E5; Tue, 31 Oct 2023 09:51:58 +0100 (CET)
Date:   Tue, 31 Oct 2023 09:51:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231031085158.o4ilb5d47sxcqm3o@quack3>
References: <20231030103415.401ce804@canb.auug.org.au>
 <20231030173228.691620ca@xps-13>
 <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-10-23 21:11:36, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> >> Today's linux-next merge of the mtd tree got a conflict in:
> >> 
> >>   drivers/mtd/devices/block2mtd.c
> >> 
> >> between commit:
> >> 
> >>   1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")
> > 
> > I haven't seen this commit, I was not Cc'ed.
> 
> Me neither. :-/

I'm sorry for that but I took the maintainers entry for BLOCK2MTD which is:

BLOCK2MTD DRIVER
M:      Joern Engel <joern@lazybastard.org>
L:      linux-mtd@lists.infradead.org
S:      Maintained
F:      drivers/mtd/devices/block2mtd.c

And both Joern and linux-mtd were CCed on the patch. If different people
should be CCed these days, please update the entry. Thanks!

> >> from the vfs-brauner tree and commit:
> >> 
> >>   ff6abbe85634 ("mtd: block2mtd: Add a valid holder to blkdev_put()")
> > 
> > I will drop this commit from mtd/next. Please take it through the
> > vfs-brauner tree as well to avoid conflicts or otherwise, Richard, can
> > you send an update at -rc1?
> 
> A side effect of 1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")
> is that it fixes the problem too. That's a good thing.
> 
> I'm a bit puzzled how to fix the problem for 6.5.y and 6.6.y stable releases.
> Back porting 1bcded92d938 seems risky to me since the commit is large.
> On the other hand, ff6abbe85634 will not make it into Linus' tree and therefore
> is not suitable for stable either.

Yes, that's one of the cases where stable rules make life harder for actual
fixes... You can try pushing ff6abbe85634 to stable even if it is not
upstream since it fixes a real bug and taking the upstream solution is
indeed IMO too intrusive. Sometimes stable maintainers accept such fixes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
