Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755FB80ED48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbjLLNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjLLM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:56:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC395
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:56:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5104BC433C7;
        Tue, 12 Dec 2023 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702385779;
        bh=GrVkd+/b1LWKzr/NPA7li4EkjFJ8l71HN7z/zGWgdfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBA7Fjo38oVBJPFu+VxEkbzqCSCmCRa5zjoNdjOWFup2xnx258eBVs8/rJLkRmPX8
         x2HlZ7omY61gNW8/wcz/uVI2Xpqxph3eKEBYQMgFCcdZA769QcTthV53UUKqaezoj1
         zrnZA5JNDYtCttLqUelCgtbH07jrFrVkHOLrsxosNmLwYG37ZjNzWkh/a05AIWC411
         eKlC7OCTdMN+DwHHgds7iXM2oPDVuH8f1xZGjuVoSq6KtQ5myLOKet/LR86GcDnfpo
         k0OFLpqlJOLUCuKh0HlIhwOChBb+a2PBhPPbLHM5rzMKdoi+7kSRvmw0Sw2UhUZHD1
         PoknmYlVpi8dA==
Date:   Tue, 12 Dec 2023 12:56:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fuad Tabba <tabba@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion
 for DDI0601 2023-09
Message-ID: <6fc35f94-176e-4ad3-ab5b-79b57c36750a@sirena.org.uk>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
 <20231209-b4-arm64-sysreg-additions-v1-6-45284e538474@kernel.org>
 <CA+EHjTzdKS+ardXUofO+U1vnsOC3QjiJUBuKCHWw6z6zKdVGSA@mail.gmail.com>
 <20231212091047.GA28147@willie-the-truck>
 <CA+EHjTzswc6Qji6yaTcYu7uc57MFY-79KxY45wFT8tQ+9PEhPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DxzMBpxvvc/Bfpdv"
Content-Disposition: inline
In-Reply-To: <CA+EHjTzswc6Qji6yaTcYu7uc57MFY-79KxY45wFT8tQ+9PEhPw@mail.gmail.com>
X-Cookie: If rash develops, discontinue use.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DxzMBpxvvc/Bfpdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 10:24:46AM +0000, Fuad Tabba wrote:

> > I renamed it to PAuth_LR following your comment, but it looks like
> > ID_AA64ISAR1_EL1 is still missing this field entirely for the API and
> > APA fields.

> I noticed that, but thought it's more appropriate to have a separate
> patch for that. I have one ready as part of my respin, unless we
> accumulate a bunch of sysreg update patches first.

Yes, syncing each register individually should make life easier.  It's
definitely painful when there's a multi-register update and one of the
registers has a mistake.

--DxzMBpxvvc/Bfpdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4WG4ACgkQJNaLcl1U
h9AJDwf+Ii1KFhAJiHYX4RETiJ/CC7UihFR2yvmyC0/nkHedaLEq9LKeZwj2vaNK
NM8C0CZgc6vzlzKGg300bRFrB805o3OfkVrX5qxkFttAOFnfbaZMsX99oFlTULM+
VhbZo6/vOjhebge/mYKRDRMa0njgwN3PKcO+GBa8PQ7pJl1W37K+KimorekNbRR1
Xj2yYOu/21Kcc7nQbG5q7urm/Gql42TsjS8m+jr2B//fNwYsh35CqEiymqcrZc5+
el49KOXceZC/HCXhc7SzS0TEnfXPebGUNjbIypOZ25jHePaewDT0UQmc99nkC9ZN
cgOTrBnHHhQO4LrmJwN4zNU1DcK61A==
=dCou
-----END PGP SIGNATURE-----

--DxzMBpxvvc/Bfpdv--
