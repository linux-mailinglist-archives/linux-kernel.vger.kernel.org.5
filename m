Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B856C783FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjHVLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjHVLpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69790CCA;
        Tue, 22 Aug 2023 04:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A6E6536A;
        Tue, 22 Aug 2023 11:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76106C433C9;
        Tue, 22 Aug 2023 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704672;
        bh=MirI7WFJqbzZP+o1PS5JUAE3PTXvaZM8yhv/B4WwiiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=md29PFr7vr5/llR1qWFR3O0n/ZnHiVZa7KfqypeX6hmQQxLCiclDg7ucXwxVXXg7A
         RJbu7S8G2iKJ9sKegW/w079a63nM9De4nVaGORIZXrjITyB5Fwbs11aR3w/+82puSr
         HhWdRuwcLjdu5fDFKwbeYOak4orjl7ppuhzooAFIs8FDi0DlMwPIdQck8fWz/0gwEJ
         xn+vel8ulD9kzVDOUJrjS8Rp8+O2D7OgQMT0+O73IDEwX4E/UQz5/bjVVUNk9+ufMZ
         HJYUTxVYxcpAYgTi/jJExntL4w8DWkR0ptJyfhjOFUZQD66feYl2P/6Sji55ImNWbB
         ptIUFaS18YOsg==
Date:   Tue, 22 Aug 2023 12:44:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AS50 WTLi <WTLI@nuvoton.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
        scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 2/2] ASoC: nau8821: Improve AMIC recording performance.
Message-ID: <9594bc07-ccaf-4f40-a988-a33491cea7c4@sirena.org.uk>
References: <20230816080006.1624342-1-wtli@nuvoton.com>
 <20230816080006.1624342-2-wtli@nuvoton.com>
 <2f72d241-7617-48c0-a0c9-86bd14c50ac8@sirena.org.uk>
 <5129f779-79e5-3c0a-aeca-ce558393f2cc@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pl7C7D3cmDRMFxGL"
Content-Disposition: inline
In-Reply-To: <5129f779-79e5-3c0a-aeca-ce558393f2cc@nuvoton.com>
X-Cookie: MIT:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pl7C7D3cmDRMFxGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2023 at 06:49:50PM +0800, AS50 WTLi wrote:

> Okay, but I have a question. After correcting the patch, do I only upload patch 2/2 or resend the entire patch?
> because I saw Acked mail by Rob.

Please resend everything, include any acks or other tags you've already
got when you repost.

--pl7C7D3cmDRMFxGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTkn5kACgkQJNaLcl1U
h9C0CQf+Lqh/3eJWWArHN+sBdV+pZx1TpHGWjNRXwBlG/zRveFRMPakbQ40AkVvD
K6e6UCbL7snOJv3OEwAJkj3j7Ew8vkjlhRenZJrosFf85CGr2+MeSS678gVtlaCe
R93CnpK+0K4qaD6UHUB0QMS47qww3TUJn51DFvTNtv+qrPV49wdXImpjA4yi7WXm
lBP/5DMQA3iFarvl9b36R0l4+V/oqLsLEHfttyc/auzkQMwVSsYJA/x6wIuhUDYT
8r36q0ohef0ukemaPaqZS6jn+UzPn6O5Io+9ejAdOSF/PFXfjq5nlhCklxFZw6QC
h8zqnzA+/b8xwKep/gWGrpmvgE+8Rg==
=sCVo
-----END PGP SIGNATURE-----

--pl7C7D3cmDRMFxGL--
