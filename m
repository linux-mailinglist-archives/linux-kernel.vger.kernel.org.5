Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F181765B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjG0SRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjG0SRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19B9E;
        Thu, 27 Jul 2023 11:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1190261F16;
        Thu, 27 Jul 2023 18:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73799C433C8;
        Thu, 27 Jul 2023 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690481862;
        bh=EAPW2/jZA19hRpdPJx+6bXtYpX7swvI4NR8hiI2bQmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esnyJWs5clWJvdQrsXo+ldF1J5FIioEuzaFcTEsg+Z/O4zUMYbg8G6ZM7FG7HTB6m
         GVePop/9yamuaYnUbs2spPmHzGFHueqtFHbD2ACAPK7YBgA501eVDW/Osgldd5wd9E
         bCUbp7Z8g9TVceGgK+x3HrEVz1nz+8lRBYc/K02FThnz8PGaW/Q29BBegDB4c2xFcI
         5jtsl6XvdqhFXFXjc4ucUbHBIjz881vp8KGvFSExOJ/zuDx5perk+Du3k8CNhCsG6P
         Py+8pAhd5z9erzqI122WCAlVWCNm4Ara5CQjjfzGW54hZvqOI3RitbJwnlNvXbLTJe
         bdrK3LQYcl3kQ==
Date:   Thu, 27 Jul 2023 19:17:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] regulator: dt-bindings: dlg,slg51000: Convert to DT
 schema
Message-ID: <6ea0325d-d33b-4bd2-b9a4-009bb8bc1d2e@sirena.org.uk>
References: <20230725063132.42132-1-krzysztof.kozlowski@linaro.org>
 <d33e5dbc-ca38-4702-903a-b36f9a824391@sirena.org.uk>
 <1c3684e3-b88a-0476-9376-19d07956e261@linaro.org>
 <4859d289-f4e2-4676-9be4-182f7dbda8b6@sirena.org.uk>
 <2df8d695-62aa-329f-f355-d6081d970ec2@linaro.org>
 <34edabd6-8dd1-42f8-8309-07dfbf157dff@sirena.org.uk>
 <52c60fe9-fff0-29a7-1e7a-12ebd207ca58@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HnuvgxUHPi2WpqVc"
Content-Disposition: inline
In-Reply-To: <52c60fe9-fff0-29a7-1e7a-12ebd207ca58@linaro.org>
X-Cookie: Go 'way!  You're bothering me!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HnuvgxUHPi2WpqVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2023 at 06:06:24PM +0200, Krzysztof Kozlowski wrote:
> On 26/07/2023 14:30, Mark Brown wrote:

> > Right, you said "enabled" in the changelog bit though.

> Regulator can be enabled in different ways, including by drivers. The
> text in description was accurate.

No, really.  The requirement here is orthogonal to the regulator ever
being powered on.

--HnuvgxUHPi2WpqVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTCtL4ACgkQJNaLcl1U
h9CAJgf7BJy6GCw+IH60CeuSxLUljiVtQw4ojeIQznIx+QkzPZRQe59CFMPzkziD
HkVCIYjqTqii6zLXu/doO6HqTO76kg6g5IMUJJ4Uh3sClR5oCaCP1/BEj0pKSvnu
nBi05+9nuu0+suBailTwpAQwNajIjl/+iur812T098eUnzCsA2EpBDpqfnFsjFXz
XUpTXDh/P4boHKX+XOYgyqO/s4zAO8CUkGvnTwtsksFEJ2KtYqALLLtkJrWd02ex
sISgr4hZkM4BO8HWmepfGk8UmsWbEiWD5Wo4Jj5LEAKeZ24F/28LQXK89ixTlL57
frG0OLZWdF6IjuBhIuTHXILGoBOdmg==
=rrYV
-----END PGP SIGNATURE-----

--HnuvgxUHPi2WpqVc--
