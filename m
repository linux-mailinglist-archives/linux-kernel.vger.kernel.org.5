Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777AA7BEE83
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378924AbjJIWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378784AbjJIWwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:52:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DEA9D;
        Mon,  9 Oct 2023 15:52:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445E9C433C7;
        Mon,  9 Oct 2023 22:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696891967;
        bh=LaaMidcIjwG7KTfhf+zLhqWeHT1nH9Z9olCRuW6pcks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrTh8/gbsC36n6H4NHvB8Jz5IA/r+G+ldzfrcaK/lGqVm/KPHWmkVWw2jLijGNwnj
         IWugdlSm3QflVyGLll4FtmpdIQrZFi79iYntpmPtUu87Gwse9bsTsboxCYVSadiBQA
         gTz/zqiAAnJ6wzg4Y9gHSHjPkz84huRmAjCmaUChi1AfG9U1jx4fw2salldDOlOGYw
         ZIeBnSBFkgd9l2bZYmmZkF7oWh6odFyygE423jQrijXtD5GQps0LfhmptGJDIaiZIs
         3XeWPhDE99yvxFFBQyLGcgk6Gz4P/cG4fV0RHMd8LODwpQcsKoALB80B/sJGmh0AuV
         H1fusi2napJSg==
Date:   Mon, 9 Oct 2023 23:52:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Kennington <william@wkennington.com>
Cc:     avifishman70@gmail.com, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        tali.perry1@gmail.com, tmaimon77@gmail.com
Subject: Re: [PATCH] spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0
Message-ID: <ac0f55e5-e78c-42d6-a262-d0cef0bc0629@sirena.org.uk>
References: <20230922182812.2728066-1-william@wkennington.com>
 <169626129142.73782.530918104356513259.b4-ty@kernel.org>
 <CAD_4BXgMp5-gdsmzbCsWu7Xn+cFC=pwRf=YvNDSK0mDP=se0fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZ+qtdZ5vTH7O8vg"
Content-Disposition: inline
In-Reply-To: <CAD_4BXgMp5-gdsmzbCsWu7Xn+cFC=pwRf=YvNDSK0mDP=se0fQ@mail.gmail.com>
X-Cookie: What is the sound of one hand clapping?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OZ+qtdZ5vTH7O8vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 09, 2023 at 03:39:43PM -0700, William Kennington wrote:
> > All being well this means that it will be integrated into the linux-next
> > tree (usually sometime in the next 24 hours) and sent to Linus during
> > the next merge window (or sooner if it is a bug fix), however if
> > problems are discovered then the patch may be dropped or

> Should I have marked this as a fix? I realized this after the fact but I
> need this backported to stable tree in order for my spi device to not crash
> the kernel.

Yes, although given the way stable picks things up there's a good chance
they'll grab it anyway based on the changelog.  You can mail the stable
maintainers and ask for a backport once it hits Linus' tree to make
sure.

--OZ+qtdZ5vTH7O8vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUkhDgACgkQJNaLcl1U
h9B8Kwf+L4zE3mS90lxSe9aB5aVL4p1myJjggLrkJ8G+QBI/EjmcfxoFVr3G3Gyl
jFr4H+u6hRTVJy3OOGSfD19q1j/oqCvMLhYhOENyARKj3qA41fFxUQXGMP/91RbX
2SG30BF+vBHOXz3gZvNcMGircbc+K0FUfekSw+8UwQfZPZ9Kkh1mCY6opj5sdY8S
/Z2kMjGTSCtD0j1LXBUQ2esZrzfxmHrvJ7rwo62tmlwtpRp5uAB7yXOXrV7PC52/
nhqT4RAPNv5AhevbUZOkVQgTGzJpt4fLq5RHFP2ND5aoTJJ+L7k2lXx4dOec1q3f
Gg+nBSGzgaJiB5mtseqEAn79cFPNHA==
=fcK5
-----END PGP SIGNATURE-----

--OZ+qtdZ5vTH7O8vg--
