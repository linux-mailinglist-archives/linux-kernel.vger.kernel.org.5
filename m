Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D368177E807
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345316AbjHPR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345369AbjHPR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466E2698;
        Wed, 16 Aug 2023 10:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31BDB62238;
        Wed, 16 Aug 2023 17:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3ACC433C8;
        Wed, 16 Aug 2023 17:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692208725;
        bh=fDU2HXAeFWB4n482i4GZf6hhte8bflt2UwJqfgDiRXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDr/hoxyn60n1Rb/HIgQ+4XMZC8loA7CRK/5KGyOtm/wv+1XnvWCEWpEWaBTCIXGa
         GJxp/OgdsWU5ZvzDN2AZ3ma+d927CGT2EhRWgIGQJ3zi9k4UGrCmScoeq9Rm+85gqa
         pdrW58ONBnBgRbK1PflCj8rVJ1/oxyBW3r/c9dF3Jaz1CVJl66vux10SI+3eI5a8qO
         VesWuulpU33K094jBs9Uk1g76Fwx6KLw0u4+TsvazU50xmHvEPUFV+Jg6+LfGjCN1y
         9iffwpCvFBLCEdoAvJEyZQNIAvpdMKwKYYChyoigyMefCPv+KhoU2SMd05KfF/MfkF
         ry2e4B8ZducKg==
Date:   Wed, 16 Aug 2023 18:58:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Drew Fustini <dfustini@baylibre.com>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/2] riscv: Add BeagleV Ahead board support
Message-ID: <20230816-lubricate-grout-b5db43b94163@spud>
References: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
 <20230815-aroma-graveyard-f1fcc61e5030@spud>
 <ZNzvGMmKufXxdOjt@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eZbM/ViOOX4Bfyy9"
Content-Disposition: inline
In-Reply-To: <ZNzvGMmKufXxdOjt@xhacker>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eZbM/ViOOX4Bfyy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 11:45:28PM +0800, Jisheng Zhang wrote:
> On Tue, Aug 15, 2023 at 02:15:46PM +0100, Conor Dooley wrote:
> > Hey Jisheng,
> >=20
> > On Fri, Aug 11, 2023 at 05:47:15PM -0700, Drew Fustini wrote:
> > > The BeagleV Ahead single board computer [1] features the T-Head TH1520
> > > SoC. Similar to the Lichee Pi 4A series from Jisheng [2], this adds a
> > > minimal device tree file to support booting to a basic shell [3].
> >=20
> > Am I supposed to take this, or will you? I still don't know where I
> > stand with any of this and will default to assuming things are for me
> > to take in the absence of clarity.
>=20
> Hi Conor,
>=20
> Since the patches in this window is small, so yes please help us to
> take this series and the one of changing the dts license. I see Guo Ren
> has acked it, I will ack too soon.

Okay, I will go grab both.
Can you please decide if you want me to take the patches going forward,
or will make a git tree, put it in linux-next & send PRs to the SoC
maintainers? One or the other, not this ad-hoc mix where neither I nor
contributors know?

Thanks,
Conor.

--eZbM/ViOOX4Bfyy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN0OTwAKCRB4tDGHoIJi
0jMSAP4hn/7YFk6PN0m3OewUmY2bsv72Mc41vuCdqYDleiDu2wEA80xVtTaRWClC
IXGNPUVCSg517oznOJnFXrkFdVT1uwk=
=0VY7
-----END PGP SIGNATURE-----

--eZbM/ViOOX4Bfyy9--
