Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48E7EE411
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjKPPVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjKPPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:21:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43061D4B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:21:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD24C433C7;
        Thu, 16 Nov 2023 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700148068;
        bh=8zlYWy/9GrwiD4xbJy7aGkZiO1aytlOU0+w/a72MJkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mx5wkoTklAbDN9BqccT/xK73eraVqp/wGEI6YLTsPr6rUcrZj+pkTnkv7UXwfjVIx
         sX0QEJjvWuwIDPm65JzD8V1nIjskNAMgssWDTj5dNKAKwNb3vWY4snuiJP50s7lDxM
         7LuRk0puHOB4SSiOZaSVlKk04lQviHcGZwA0QP3JjwTKUMkMJGzPLNq9bFVVdCpLiZ
         06sm63zUJKjwhrTK2JApoZ7r3kYQH0VB6EfZBk6EI79UhRmCjEyBnCB411JNc8EnIL
         cIvSJXqlSey62Pmzg8J8kzXE4M8pJ9iDmu13QoE8yqhtJUWWXItb/EquSIYEQ2hxhp
         lG+ooEUDd5gQA==
Date:   Thu, 16 Nov 2023 15:21:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op
 checking
Message-ID: <401df72f-9255-4da3-b97e-93d3f38d352c@sirena.org.uk>
References: <20231116024338.337304-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dP03VA4Totf7dmr2"
Content-Disposition: inline
In-Reply-To: <20231116024338.337304-1-acelan.kao@canonical.com>
X-Cookie: micro:
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dP03VA4Totf7dmr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2023 at 10:43:37AM +0800, AceLan Kao wrote:

> The purpose of this patch is to distinguish the "operation not support"
> error from the generic "not support", so that drivers could better
> handle different errors.

What is the intended distinction between the two?

--dP03VA4Totf7dmr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWM1wACgkQJNaLcl1U
h9DVoAf9FsYgJbRkewWfJj4CYQNTj+v2sw4dP9JH34SqOtdUAGb6bv3gs8u0nN5M
Isbda5lciCIG+R+CD1Qr0O5EtcIQjDbCi0NNUSYSwUiAR/7tXA48IDREmW9A+YH6
alQg11NNogCzP/r+jt0ODempK/G0LkwbBpQxhuNOEbXARDr2KNljx48eyayikbAJ
44fwGEg+E/7z2XCmdIJcZBGNmUP1gCEGZF/qP1axHyAkiTvCBsLSg+cRFjO62RZK
tvgetbmtDhymAUyHmigrro4+VG1uKz3/voob4Hs9VaH/ihS6Eg3w1BV52r+tOQ8L
pDBoZvuYqywEEHoTTL11h2/MNc7hSA==
=Jqhu
-----END PGP SIGNATURE-----

--dP03VA4Totf7dmr2--
