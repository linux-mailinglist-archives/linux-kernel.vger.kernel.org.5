Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A37644F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjG0EiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjG0Eh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:37:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39928270F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:37:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0872F197BCD;
        Thu, 27 Jul 2023 00:37:56 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=syJJx0ZnbQZaI
        S1EYh4auknPhV1wln5D5dPlbAR/7oI=; b=SG0lU5goP8o6Le8CSGwQ2Q2l87gyh
        PcWY3N536C+gj9BaW5dix1vi/jXUIDMcR7KigBjj7awyCF71ec60J3/pOUoHet/n
        VmZq+fcAPejA5IkWEMXrhR/3PbungzrvHWW91nRvlqb+TPq/PtBPfpFWS21Hdj6j
        Gdy889VbWPTVjI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4D90197BCC;
        Thu, 27 Jul 2023 00:37:55 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=2019-09.pbsmtp; bh=v0fno4hXvRvf0mZcV/qvB0rwl9YQrVHFB1TPmTsvqcE=; b=kZR6nlCwn8o8bI09WeXy9+FCP1hXpj7a5Vn53VMhR1fv56r7vFlAtzVJgrnOfCJxFdeBJEHHPKCWormJ5U5Oa0T9ETL6Ob1EbrYafyd/YNld4POtRkIvRtvDMtiTQ0fTazaYrnDSlMZXyGCTBW/OFzq4lGmbVYQRn7bVxQn6tao=
Received: from oatmeal.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB24B197BCB;
        Thu, 27 Jul 2023 00:37:54 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 26 Jul 2023 21:37:47 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     philipp.g.hortmann@gmail.com, anjan@momi.ca, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Staging: rtl8192e: Function name cleanup series 1
Message-ID: <ZMH0g2hGaLlzFtL1@oatmeal.darkphysics>
References: <ZL9tmaSHxKh2JCau@basil>
 <2023072548-unpledged-slacker-90b6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023072548-unpledged-slacker-90b6@gregkh>
X-Pobox-Relay-ID: 5AC2A4D6-2C37-11EE-94A5-307A8E0A682E-45285927!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:48:28AM +0200, Greg KH wrote:
> On Mon, Jul 24, 2023 at 11:37:13PM -0700, Tree Davies wrote:
> > Rename functions to fix checkpatch warning: Avoid CamelCase
> >=20
> > Tree Davies (5):
> >   Staging: rtl8192e: Rename function ActivateBAEntry
> >   Staging: rtl8192e: Rename function DeActivateBAEntry
> >   Staging: rtl8192e: Rename function TxTsDeleteBA
> >   Staging: rtl8192e: Rename function RxTsDeleteBA
> >   Staging: rtl8192e: Rename function ResetBaEntry
> >=20
> >  drivers/staging/rtl8192e/rtl819x_BAProc.c | 44 +++++++++++----------=
--
> >  drivers/staging/rtl8192e/rtl819x_TSProc.c |  6 ++--
> >  drivers/staging/rtl8192e/rtllib.h         |  2 +-
> >  3 files changed, 26 insertions(+), 26 deletions(-)
>=20
> Odd, how did you send these patches?  They are not properly "threaded"
> or "connected" such that if you look them up on lore.kernel.org, or in
> your email client, they show that they should be connected.
>=20
> Here's what they look like in my inbox right now:
>=20
>=20
>    1   T Jul 24 Tree Davies     (0.6K) [PATCH 0/5] Staging: rtl8192e: F=
unction name cleanup series 1
>    2 N T Jul 24 Tree Davies     (1.9K) [PATCH 3/5] Staging: rtl8192e: R=
ename function TxTsDeleteBA
>    3   F Jul 25 To linux-kernel (  29) [PATCH v2] Documentation: embarg=
oed-hardware-issues.rst: add AMD to the list
>    4 N T Jul 24 Tree Davies     (2.5K) [PATCH 5/5] Staging: rtl8192e: R=
ename function ResetBaEntry
>    5 N T Jul 24 Tree Davies     (1.8K) [PATCH 4/5] Staging: rtl8192e: R=
ename function RxTsDeleteBA
>    6 N T Jul 24 Tree Davies     (3.1K) [PATCH 2/5] Staging: rtl8192e: R=
ename function DeActivateBAEntry
>    7 N T Jul 24 Tree Davies     (1.7K) [PATCH 1/5] Staging: rtl8192e: R=
ename function ActivateBAEntry
>=20
> While if I look at a different recent series sent for staging patches, =
send
> correctly, they look like:
>=20
>  372   T Jul 22 Franziska Naepe (0.9K) [PATCH 0/9] staging: rtl8723bs: =
ioctl_linux: Fix checkpatch issues
>  373   C Jul 22 Franziska Naepe (0.8K) =E2=94=9C=E2=94=80>[PATCH 9/9] s=
taging: rtl8723bs: ioctl_linux: Fix comparison to false
>  374   C Jul 22 Franziska Naepe (7.2K) =E2=94=9C=E2=94=80>[PATCH 8/9] s=
taging: rtl8723bs: ioctl_linux: Add preferred spaces
>  375   C Jul 22 Franziska Naepe (2.2K) =E2=94=9C=E2=94=80>[PATCH 7/9] s=
taging: rtl8723bs: ioctl_linux: Fix alignment on open parenthesis
>  376   C Jul 22 Franziska Naepe ( 10K) =E2=94=9C=E2=94=80>[PATCH 6/9] s=
taging: rtl8723bs: ioctl_linux: Remove unnecessary parentheses
>  377   C Jul 22 Franziska Naepe (5.9K) =E2=94=9C=E2=94=80>[PATCH 5/9] s=
taging: rtl8723bs: ioctl_linux: Remove unnecessary blank lines
>  378   C Jul 22 Franziska Naepe (4.1K) =E2=94=9C=E2=94=80>[PATCH 4/9] s=
taging: rtl8723bs: ioctl_linux: Remove multiple blank lines
>  379   C Jul 22 Franziska Naepe (1.0K) =E2=94=9C=E2=94=80>[PATCH 3/9] s=
taging: rtl8723bs: ioctl_linux: Fix block comment alignment
>  380   C Jul 22 Franziska Naepe (0.9K) =E2=94=9C=E2=94=80>[PATCH 2/9] s=
taging: rtl8723bs: ioctl_linux: Fix code indent
>  381   C Jul 22 Franziska Naepe (0.9K) =E2=94=94=E2=94=80>[PATCH 1/9] s=
taging: rtl8723bs: ioctl_linux: Fix else on next line
>=20
>=20
> See the difference with the -> and such?  No other messages in the midd=
le of
> the thread, and they are all connected together so that our tools can h=
andle
> them as a series, not as individual patches.
>=20
> If you use 'git send-email' to send the whole back of patches at once, =
they
> will be properly connected together, so I do recommend using that if yo=
u are
> starting out.
>=20
> Please fix up and try again, thanks.
>=20
> greg k-h

Greg,
I got git send-email working. Do I send this series as a v2, even though =
the=20
patches are the same, and how I send them is 'the change'?
The last commit I see in linux-next for rtl8192e is 4a22870cede374d80c5d2=
f9c5b79253a5a667832.
Can I send patches from that state?
Tree


