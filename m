Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF437FC1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbjK1OLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346304AbjK1OLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:11:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0324F271F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:10:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD3C433C9;
        Tue, 28 Nov 2023 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701180629;
        bh=60EtB08YT7Ko8yqV3Wwijj0Q4rDlAXw7Ibne/o3zM/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4OShPFUo67/hTM7CP0T5xlROgke47ag9YYEcSS/ddt4MiwJzPweh7w6xdi0Cvesx
         F/8yEKqXWrixCvb1kA2smHWsNtmgQN/ovflspS+geIMXD2+AJgKxKXTlYxvH7K6Vhn
         WHbqKUN3K31QmfxQ2/pKM+CXH3J95hQTGtOETNXh/ZnWapdNWYEFpZEtLvvMXvrV+F
         4+8ofw5pC1p64zwwB2+Axp/kGR/Oz2Q5idf3lljuruSLhgfx+NyLdo1+IwK0RAni4O
         hvuf9HEsXlCgWGIE3Zx9ZJIVmOxHcwv2gKqkZT/JltiXlFI1ncAeRdqMRMa1u+NTn2
         L+JXI1dxyLYMQ==
Date:   Tue, 28 Nov 2023 14:10:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        David Gow <davidgow@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] kselftest: devices: Add sample board file for
 google,spherion
Message-ID: <1baeddbe-83ed-476e-a748-7d2838b44c5f@sirena.org.uk>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
 <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VIfEQR6tichIZgMF"
Content-Disposition: inline
In-Reply-To: <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
X-Cookie: Must be over 21.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VIfEQR6tichIZgMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 12:10:46AM +0000, Bird, Tim wrote:

> I'm not a big fan of naming these with a comma in the name.  Is there a r=
eason
> you are not using dash or underscore?

That's a common patter with this sort of software (eg, bootrr does the
same).  It's convenient to just be able to use the compatible straight
=66rom DT without having to mangle it.

--VIfEQR6tichIZgMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl9M0ACgkQJNaLcl1U
h9Cktgf+Oq0BN8WyZ7CzPTibZyr6k1r2sWjG2VUqEZQKYA66zH1D965ND5J8XJB8
cqw3KD0X/8KNc/u890NCBnr7QTxlKdczAbTEMZtYAcy/7xiA41z0ITXFc6DE8/nO
V76cOaRGh2vCNkBROokKzewYxb+4MWHHFNUBu/7AXYZHVhtt4U1kcxNcm9HwvC/j
S3ubDODyZk++hbyHQhxf3ENesyQuIObeKWx6qVPieVbbeCEn3SLZH1KTEOcEr4Cz
uCkWQKMpUS4iMafKTdMigLtOE4TskFAd+eH+cFMm4Yy7bhr+5pxKmAaDleKBAORF
/OS87yV3a5qUCNslQ03RnzaSJr1BmQ==
=ujz7
-----END PGP SIGNATURE-----

--VIfEQR6tichIZgMF--
