Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3538023AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 13:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjLCMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 07:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 07:18:03 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF81DB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 04:18:08 -0800 (PST)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B2FEC15BE737;
        Sun,  3 Dec 2023 13:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1701605883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWconi64HU2UMrEzXVGirhF6XlCSN88CtDiKuAViGZY=;
        b=DVzOH+NcB6UgGEsQ9qsxJMihopRGFxDTDd5xg05XxJYewd9D6zLrQ/AB2NKaE7UNDYkCc2
        UZufCki0ZFSd7KnxK+PvI94vrTeL3hZaE0Rr4aVy28/6XyXc5V9/oOrC6Is8craosQeMfC
        4g627JWsubDDZ8kThu+1Nk1Eb39tPLE=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zach <zacheryvig@outlook.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Regression: Inoperative bluetooth, Intel chipset,
 mainline kernel 6.6.2+
Date:   Sun, 03 Dec 2023 13:17:50 +0100
Message-ID: <2709774.mvXUDI8C0e@natalenko.name>
In-Reply-To: <115e819b-0271-403c-b034-ef3aebbb85cd@moonlit-rail.com>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <ZWl82n695TIC7nUO@archie.me>
 <115e819b-0271-403c-b034-ef3aebbb85cd@moonlit-rail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12334996.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12334996.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Sun, 03 Dec 2023 13:17:50 +0100
Message-ID: <2709774.mvXUDI8C0e@natalenko.name>
In-Reply-To: <115e819b-0271-403c-b034-ef3aebbb85cd@moonlit-rail.com>
MIME-Version: 1.0

Hello.

On p=E1tek 1. prosince 2023 9:19:04 CET Kris Karas (Bug Reporting) wrote:
> Bagas Sanjaya wrote:
> > Kris Karas (Bug Reporting) wrote:
> >> I have a regression going from mainline kernel 6.1.62 to 6.1.63, and a=
lso
> >> from kernel 6.6.1 to 6.6.2; I can bisect if patch authors can't locate=
 the
> >> relevant commit.  In the most recent kernels mentioned, bluetooth won't
> >> function.
> >=20
> > Then please do bisection; without it, nobody will look into this proper=
ly.
>=20
> As only a few people are reporting this, it must be pretty=20
> hardware-specific (or perhaps Kconfig/firmware specific).  I'll do a=20
> bisect.  A bit too late here in Boston (03:00), and kiddo's birthday=20
> "later today", so will probably get to this on the weekend.
>=20
> > You may also want to check current mainline (v6.7-rc3) to see if this
> > regression have already been fixed.
>=20
> Just tried 6.7.0-rc3, and it is also affected.

Does passing `btusb.enable_autosuspend=3DN` via a kernel cmdline help? [1]

[1] https://lore.kernel.org/lkml/5993222.lOV4Wx5bFT@natalenko.name/

> I hadn't git-pulled my linux-stable since May, so that gave me a good=20
> chance to test the very latest.  :-)  And conveniently I'm now set for=20
> the bisect.
>=20
> Kris
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12334996.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmVsce4ACgkQil/iNcg8
M0uSzg/+PnIaA0fuuuC6/Ac4oJnJVWvHWdKY9rSw0tT7Ak5rrng/iLqLPnlIHQa5
fLznZrmIFSRphCNtvnxYSxp5yl/4XXB/IHaIXiVxhngDHma3TNjGzvpQ9oKkcEQE
vPITZ41BqgAGgaRqvPeU/EKCjRygXgz+5Gj4xOKaVOedIPv8Jxitdga8jup9HgJW
SnZ4Uy+oMAmVA145BltC6G6glgIXqL7P5J1jUVf3qn/yotHLqRt9r3m14yD7zjfD
1VleMcKIArpGIOdkEbGOIjIFE4iZyvWiBp+NF2Q02D5kVu983mTtc6u2hnzmRxq1
8IlkFYHTvTGxen+F1ic1AwSm2OFoxIcDpjhGAoUHDB2PbY6A5sbUjIvBCoJOQXs+
E3pSrrnV5G4x1SL3ujXIcc++xyR6IsX4sNtp+RLNN2fonivsi3ZLBySPyonPVhPn
CglNu54Z3HBToeUetL1atuSLHN2JE5AZ/9WfWaV9lBNrUXWF0P/rntHFQvD2sE5/
S3k4tceJoti5ZMMTOSvcRc8C1cQYjWNbFEasxHlyoLVaBXB31mEEBhiPMrxlDW/h
iB7T0O/EVa4vuu+pQBf3Psip4cPBUrDlnelQE571DTcGAyrwnqLcp8T9kJRKIcI+
JM+GRZlqH7l78bNAWbkgDfBvZr29wV5/JhECMw1isEtXYfQJB7s=
=6+6I
-----END PGP SIGNATURE-----

--nextPart12334996.O9o76ZdvQC--



