Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1197DCD03
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344248AbjJaM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJaM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:29:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593197;
        Tue, 31 Oct 2023 05:29:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 146A221865;
        Tue, 31 Oct 2023 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698755348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+gX2TOBSmrNTj4oQZtaBPOQ4VhI3qDA87tKE1H/664=;
        b=eZTnJk8wU5gxef5Zw+dPOCzlp08TllMLOeP7vyQx5Cc92mct4h+RfR5CjI3YGf5OJoaMmQ
        34FRW51HbPRLf/hwoW8BstPb8WShUO0oNEoyooouRZryYi6ucLw/+u0jn1Pl6J50Xch+DM
        +Nt9fqicTaWTZssuRmSVV7gbfhyE0r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698755348;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+gX2TOBSmrNTj4oQZtaBPOQ4VhI3qDA87tKE1H/664=;
        b=QCnAMuNEthPx/cI2YckKq7zKTjumX4xqZDs3G+07mzolCz6vVPADQp3FA/GMZTfxlttaDC
        KLY7zF6oK7qyInCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0214A1391B;
        Tue, 31 Oct 2023 12:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OR2BABTzQGVETgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Oct 2023 12:29:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 645E7A06E5; Tue, 31 Oct 2023 13:29:07 +0100 (CET)
Date:   Tue, 31 Oct 2023 13:29:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Weinberger <richard@nod.at>
Cc:     Jan Kara <jack@suse.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231031122907.456ovpae6tgrgi7e@quack3>
References: <20231030103415.401ce804@canb.auug.org.au>
 <20231030173228.691620ca@xps-13>
 <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
 <20231031085158.o4ilb5d47sxcqm3o@quack3>
 <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-10-23 10:02:10, Richard Weinberger wrote:
> Jan,
> 
> ----- Ursprüngliche Mail -----
> >> >>   1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")
> >> > 
> >> > I haven't seen this commit, I was not Cc'ed.
> >> 
> >> Me neither. :-/
> > 
> > I'm sorry for that but I took the maintainers entry for BLOCK2MTD which is:
> > 
> > BLOCK2MTD DRIVER
> > M:      Joern Engel <joern@lazybastard.org>
> > L:      linux-mtd@lists.infradead.org
> > S:      Maintained
> > F:      drivers/mtd/devices/block2mtd.c
> > 
> > And both Joern and linux-mtd were CCed on the patch. If different people
> > should be CCed these days, please update the entry. Thanks!
> 
> Ah, you did a manual lookup?

Yes.

> Because get_maintainer.pl seems to do the right thing:
> 
> $ ./scripts/get_maintainer.pl drivers/mtd/devices/block2mtd.c
> Joern Engel <joern@lazybastard.org> (maintainer:BLOCK2MTD DRIVER)
> Miquel Raynal <miquel.raynal@bootlin.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> Richard Weinberger <richard@nod.at> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> Vignesh Raghavendra <vigneshr@ti.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> linux-mtd@lists.infradead.org (open list:BLOCK2MTD DRIVER)
> linux-kernel@vger.kernel.org (open list)

Hum, right. I didn't realize there could be multiple entries matching one
file. My mistake.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
