Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912A7F17FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjKTP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjKTPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:25:44 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01761B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:25:39 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00F21E000D;
        Mon, 20 Nov 2023 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700493938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVyjl2JgjwzwAOZdoBU8qtJUrkpjo468gdgCetORECI=;
        b=bZYukV0FY3Wkt1npcmgbzufEQEPJafXZfgp6VA5c7iyagj9NQAed4QBIJPozQbvhfyQia+
        PMM5hvwxxZm7fJB9OZrsDkf/1rRfeCRfY19POFkYlk/nDoLQ1zUFjosDel5FD0u6IY8JB3
        Ai3c+QWUZ5KEkFL4yEkpFrpdzcXGyjVROUcq0O+YQ2ij9e/FdvFrJq7QmsDools0sTILdb
        q2XmMZ7ox4TyCbOqfdXh6qpzGifBV1j3TSbknIeuLS3aW2ldd4WpwALOW3DcjQrK4AFF8K
        bUSnWP+tpBPzvso/lQTpddEJ4MjF/uolC9hEvdPKKlN298BvpFBax63WilCRZA==
Date:   Mon, 20 Nov 2023 16:25:37 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] firmware_loader: Expand Firmware upload error codes
 with firmware invalid error
Message-ID: <20231120162537.468de5b6@kmaincent-XPS-13-7390>
In-Reply-To: <2023111727-exert-dab-b940@gregkh>
References: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
        <2023111720-slicer-exes-7d9f@gregkh>
        <548c3b60-60ce-4166-9943-224e03152cc5@lunn.ch>
        <2023111727-exert-dab-b940@gregkh>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 14:48:32 -0500
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > > > This patch was initially submitted as part of a net patch series.
> > > > Conor expressed interest in using it in a different subsystem.
> > > > Consequently, I extracted it from the series and submitted it separ=
ately
> > > > to the main tree, driver-core.
> > > > https://lore.kernel.org/netdev/20231116-feature_poe-v1-7-be48044bf2=
49@bootlin.com/
> > > > =20
> > >=20
> > > So you want me to take it through my tree?  Sure, but if you are rely=
ing
> > > on this for any other code, it will be a while before it gets into
> > > Linus's tree, not until 6.8-rc1, is that ok? =20
> >=20
> > My idea was that you could create a stable branch, which can then be
> > pulled into netdev and arm-soc. =20
>=20
> I'll be glad to do so, you just need to ask me to do that, I don't see
> that request here :)

Sorry, my fault, I did not know well the merge actions that were needed for
this particular case.

> > If you don't want to do that, we can ask Arnd to take it, and he can
> > create a stable branch which we pull into netdev. =20
>=20
> You want a stable tag to pull from, right?
>=20
> But really, why not just take this through netdev?  It's just one
> commit, I have no problem with it going that way at all.  If the odd
> chance there's a merge conflict in the future, I can handle it.

Seems a good and simple idea to me, Andrew any thoughts about it?
Do I send a single patch to net-next and ask Conor to pull it in his
subsystem for his patch series?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
