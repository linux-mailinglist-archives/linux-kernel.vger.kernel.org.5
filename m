Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111CA803242
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjLDMOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:14:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542AFD2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:14:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D19C433C8;
        Mon,  4 Dec 2023 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701692079;
        bh=UO++fzPbk7oE2nPQaJdRbj1/Gln8Y85B2q+MfxWqQhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8nq7UXmsenLOa7cAonkmS0cjI3t+0bc5HMHksyIHgYSvDtOVHSg0hTVbW96bdWrs
         UKQ5TiexUr3/G5zwi3cgjse5BMGZfYczPR5AbUkWo7oQPQ0DSnTIcLwcReyiV6TG6x
         MaFhAEMm83Xdyd9pVvJCtmLqN9dFP5/FdZUSSPmBi1pqo78B1swA3pzZlxBHWUgyGD
         rP6fkDP6mAcn1fMZtL/hTp3TyEonz9GeCuJFc+9Cmagm+ZbvswIjMxbXpF8cP68wsQ
         DrU/tb4dNgkRwyEsVQemEHsTh0yNxOyFoulIAJ3R0vowBqfY/PXV1auGd/t24YhNR5
         eWwpCSzq0disA==
Date:   Mon, 4 Dec 2023 12:14:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rajeshwar Shinde <coolrrsh@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that
 can never be negative
Message-ID: <b7b27bf6-3e17-4392-804e-c46324a5bdd6@sirena.org.uk>
References: <20230813141207.150336-1-coolrrsh@gmail.com>
 <CA+VNjV1=xVyRkvB6RAnLySAOzS=X1XiJihrtiMx3Jmifpdq9ng@mail.gmail.com>
 <df10d700-3f3f-4665-9197-534abc24523a@sirena.org.uk>
 <CA+VNjV1K6WoKPqP4zrax5SOF3UFCiJ5oYA=YamjZwfZ5fkEHWg@mail.gmail.com>
 <ZPTAQWZ0XoL9zfW7@finisterre.sirena.org.uk>
 <CA+VNjV3_JRvhjanLEdYRnxcTZv2pv307utD-bpmy_7QFT3Y+Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lu5MX3pFXYQCC8VH"
Content-Disposition: inline
In-Reply-To: <CA+VNjV3_JRvhjanLEdYRnxcTZv2pv307utD-bpmy_7QFT3Y+Pg@mail.gmail.com>
X-Cookie: For office use only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lu5MX3pFXYQCC8VH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 02, 2023 at 10:00:21AM +0530, Rajeshwar Shinde wrote:
> Remainder

Seriously, please read and act on what I'm writing.

--lu5MX3pFXYQCC8VH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVtwqgACgkQJNaLcl1U
h9BNwQf/S63rsI3fLUB10zkKjnEZzXJtFIBDO3bgRpZCsA5nS8LvamCOJiDRzKOv
/OZyxrDCvji9tZw9iUUvOi8Cq4s4Xx0GiJUl896iJ3vJOupYes1xhl1b4YvrNnWo
K4z+5STjLLGHEjrljSxORNEN5LdAfxfQQgT97mqNdlRc0dEBrhxe54CQmr2aqWby
+3Oq2mBFW6R0FRPqsd7BMrlOk6wY+pnAxZ46eMuEKInbaDUeCAQoSejhJyyYC6Bh
4KXuPb8arFpWhgv/MAbjb0PqGWH2RkHyJVQ4vITDhU7WO88RB9PMW6/f+kLySXYq
pWIPx37qTD0bb+Gi+UWiNLepWg6Y2g==
=tK58
-----END PGP SIGNATURE-----

--lu5MX3pFXYQCC8VH--
