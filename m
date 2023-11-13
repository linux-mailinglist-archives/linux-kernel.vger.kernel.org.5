Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D027EA5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKMWIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:08:35 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A610C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699913308; x=1700172508;
        bh=Cgx6Jlyi/PqfWlF1PLRvcbzm0SmQSL/fmBdfVpYYr8U=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=s/MJK+6zQSB9dDZMJJoPt8ViBmm/2VBPiDbsaPRBftmQ9rq63Vu1qAfF5+ay4R1bv
         dj0tqSg4LYq26TeKQuKrsOhuLj58T3Rrwy6V1/cpMBl0R2J1dD9IRQN9ZdvEGNR1ij
         buiBABuLad6Pz1vatHEhDYhdxcabwHzOG17bhiWkKPaNH5BW09Rn+l5YcjOimBKZbM
         OLd6wMSvhKgieD4jT/ix9+zeiObMWJ2biV0kecdLfcZQpFfFWMpHqSIC2W3xb5EIin
         X5LqHaOETBUfpvCnGXUdNxlDXxW6Vw58yZgq/T3lJqOJFM9dalwuTcKKtF+bW0yFJo
         a+X8L6mZ+MmRQ==
Date:   Mon, 13 Nov 2023 22:08:03 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com>
In-Reply-To: <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com> <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com> <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com> <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com> <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com> <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com> <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

> Here is a little bit of history of why you were encountering this bug [..=
.]

Many thanks for all the details you wrote about the bug, I found=20
your email so interesting that I couldn't resist to copy/paste it=20
on my blog[1]. =20

> And that's exactly what happened in your case David. Which is why I'm
> so happy (also because I fixed the tools from an author I like and
> already had the books at home :-P):

Please send me an email in private with your adress; I'll be happy to
send you an original drawing. That will be my way to thank you :-)=20

> Could you please once again attach the hid-recorder of the Pro 24
> while doing the following sequence:
> - touch with the tip of the stylus the tablet
> - while touching, press the upper button (the problematic one)
> - still while touching, release the button
> - remove the stylus

Sure, you'll find the action (repeated three times) recorded here [2]

> you could also give a test of the artifacts of job 51469284[3].
>=20
> The points to check are:
> - if you right click while touching the surface, do you still get only
> a right click or some weird glitches in addition to it?
> - if you right click while not touching (hovering), no glitches?

I tested. It's a bit hard to tell if it causes glitches or if the
behavior is normal or not. I'm not using the right-click this way.
I always use it in "hover mode". With artifact or without, the=20
behavior is while the tip is pressed, the right-click quickly=20
'disapear' but it is probably normal because I test on contextual
menu and clicking somewhere else makes this type of menu disapear.

I hope this will help,
Cheers,

David

[1] https://www.davidrevoy.com/article1002/how-a-kernel-developer-made-my-s=
tyluses-work-again =20
[2] https://www.peppercarrot.com/extras/mailing-list/hid-records/XPPEN-Arti=
st-24-Pro/XPPEN-Artist-24-Pro_pen_tip-contact-and-action-press-release-uppe=
r-stylus-button-x3.txt  
