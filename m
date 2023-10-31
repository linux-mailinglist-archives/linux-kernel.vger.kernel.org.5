Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2037DCE38
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbjJaNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbjJaNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:50:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCC9F;
        Tue, 31 Oct 2023 06:50:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B04F4C000A;
        Tue, 31 Oct 2023 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698760209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxFIypa0LTfiiI18tkuJQWvHcLDKDhKP+leOpD6yEC8=;
        b=WXn1XyDnEoDBgQNhZltAs4pBhEA8yn34Vtgqn6dpgPCii0McQB669Mf1olRWLpa94fc/DP
        /RaWrM/tAaocCJDOm3bhjLOOsaBVP84kHL5TkkXYSB32RtlfgDOF0/bWoPVVSaOdYzXp63
        8v3/xti/T417KwY2ZbceRdNBKXSwSZ7w6Ff8gb4LQeZETOsmogJiiF6thsxQFEBaRw1RMe
        mdsxQQvzuRDTwj+5mUduspWlE1uhfV8HAA5jqVjkKLFE+kwbPpD9AJdphu4H83AlgqeMQV
        jcHyNy5yMyE4JYtcQO+/v0Tj9WMrAQ2ginLHOhhPWUsMmxmoh6sAPHMORzXKpQ==
Date:   Tue, 31 Oct 2023 14:50:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231031145006.3df11822@xps-13>
In-Reply-To: <440004449.28174.1698758033696.JavaMail.zimbra@nod.at>
References: <20231030103415.401ce804@canb.auug.org.au>
        <20231030173228.691620ca@xps-13>
        <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
        <20231031085158.o4ilb5d47sxcqm3o@quack3>
        <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
        <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner>
        <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at>
        <20231031134522.27e78274@xps-13>
        <440004449.28174.1698758033696.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


richard@nod.at wrote on Tue, 31 Oct 2023 14:13:53 +0100 (CET):

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com> =20
> >> Miquel, we could also keep ff6abbe85634 in the mtd tree and explain Li=
nus the
> >> conflict, what do you think? That would help with back porting to stab=
le. =20
> >=20
> > It's not relevant if the patch in Brauner's tree is already fixing this
> > up. Just send the smaller patch to stable@vger.kernel.org asking them to
> > backport this patch instead of the other one, they are used to this
> > kind of constraint, no? =20
>=20
> I'm just in fear of stable rule #1.
> "It or an equivalent fix must already exist in Linus' tree (upstream)."

It should be very soon, the merge window is open ;)

Cheers,
Miqu=C3=A8l
