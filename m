Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1767DCFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjJaOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjJaOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:46:38 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A94DB;
        Tue, 31 Oct 2023 07:46:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36A2EC0009;
        Tue, 31 Oct 2023 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698763594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KULM1KY0Lj9Mz/GZCCMoNQMoHMjvZdIx4RtFjfmlps=;
        b=ksIyObctg3yLoNLPuB3hEsglG19un9LzETpfaYVycRwRLKeYxAl8h+zTTm5ugB5kOrdMg8
        /NhqUGKH/y3GO2vloEU7t+BlyB1gMTT0mk5Xz4LA6EZMlSULzkO/p56uCzzonOxoYit73u
        BZIjPh42QvvQYEVemX7GLjqKLimXtyeTKm6bkpaPBCGpF+m1fteJ9+2LRSAQ2PQnw8/Hl1
        lmni/9C0h3lWd2ZhCrl9l4EZJmFn/fyo4glhw0WVo0WKtNYrlUriEzJCcE1V2ttN3RA59N
        dvhGerBmF1+UPTKcAAXc/txC95tmbgRQey8tggvtTNIZ0LXH1vjAKIGoURG8Cg==
Date:   Tue, 31 Oct 2023 15:46:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231031154631.61e5f83e@xps-13>
In-Reply-To: <20231031-trauben-jobben-40074a43e5a0@brauner>
References: <20231030103415.401ce804@canb.auug.org.au>
        <20231030173228.691620ca@xps-13>
        <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
        <20231031085158.o4ilb5d47sxcqm3o@quack3>
        <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
        <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner>
        <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at>
        <20231031134522.27e78274@xps-13>
        <440004449.28174.1698758033696.JavaMail.zimbra@nod.at>
        <20231031145006.3df11822@xps-13>
        <20231031-trauben-jobben-40074a43e5a0@brauner>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

brauner@kernel.org wrote on Tue, 31 Oct 2023 15:25:19 +0100:

> On Tue, Oct 31, 2023 at 02:50:06PM +0100, Miquel Raynal wrote:
> >=20
> > richard@nod.at wrote on Tue, 31 Oct 2023 14:13:53 +0100 (CET):
> >  =20
> > > ----- Urspr=C3=BCngliche Mail ----- =20
> > > > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>   =20
> > > >> Miquel, we could also keep ff6abbe85634 in the mtd tree and explai=
n Linus the
> > > >> conflict, what do you think? That would help with back porting to =
stable.   =20
> > > >=20
> > > > It's not relevant if the patch in Brauner's tree is already fixing =
this
> > > > up. Just send the smaller patch to stable@vger.kernel.org asking th=
em to
> > > > backport this patch instead of the other one, they are used to this
> > > > kind of constraint, no?   =20
> > >=20
> > > I'm just in fear of stable rule #1.
> > > "It or an equivalent fix must already exist in Linus' tree (upstream)=
." =20
> >=20
> > It should be very soon, the merge window is open ;) =20
>=20
> vfs-6.7.super was merged yesterday, if that's what this is about.

Great, thanks for the confirmation. Then Richard you have your upstream
commit already!

Thanks,
Miqu=C3=A8l
