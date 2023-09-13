Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7779E875
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbjIMM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjIMM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:58:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5F19BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:58:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC443C433C8;
        Wed, 13 Sep 2023 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694609912;
        bh=Dm8nPuZvFh0PS3q5tY1maihWmD+gVq1qHqcDYEbybag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVtCamP8iz+I2giT9zMKAjS2SBf1eYvu3XQunocMDBLGluzwPONUi4rgZXGfOah1N
         dDURtGrmzQIBVa8UR5t5YFAtw5c67zowXZcO3FOCdVXJ78hCD+MkNNusqJwTACdXZn
         kp8YWupGS0Pk4Ss9gPHnfHX+jqvWOh6AXq+15SefYYx5sU2/ppx5xo8xPNhTuLpGet
         RqXD/qQ6GtD9ZgGXvHdTr06r9YY+vAgjTVjfR8BS5PeP1kyPjDNapTfEWQ20ZF8eXF
         nC5/Khz09WnmWo1E/XQ0FMHPvQaXv0DRaUAIGXHyEfdcdDI6MBEGsV3Io4iLu/Vs7Q
         DD9DlVIhmGvcA==
Date:   Wed, 13 Sep 2023 13:58:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        pierre-louis.bossart@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 1/4] ASoC: soc-card: Add storage for PCI SSID
Message-ID: <66a4381b-1a35-495f-a74a-1da0af1334c1@sirena.org.uk>
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
 <20230912163207.3498161-2-rf@opensource.cirrus.com>
 <92b2b69e-3175-651f-45bb-d9ae11eaec82@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k8z/zzyoNTrEHxEA"
Content-Disposition: inline
In-Reply-To: <92b2b69e-3175-651f-45bb-d9ae11eaec82@linux.intel.com>
X-Cookie: You will be surrounded by luxury.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k8z/zzyoNTrEHxEA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 12:56:03PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> On 9/12/2023 6:32 PM, Richard Fitzgerald wrote:

> > +#ifdef CONFIG_PCI
> > +	/*
> > +	 * PCI does not define 0 as invalid, so pci_subsystem_set indicates
> > +	 * whether a value has been written to these fields.
> > +	 */
> > +	unsigned short pci_subsystem_vendor;
> > +	unsigned short pci_subsystem_device;
> > +	bool pci_subsystem_set;
> > +#endif /* CONFIG_PCI */
> > +
> >   	char topology_shortname[32];
> >   	struct device *dev;

> This looks bit weird to me, snd_soc_card is _generic_ struct which is not
> device specific in any way, and now you add fields for PCI, can't this
> somehow be done using drvdata or something?

You're right that it's a bit messy but if we use driver data then it
becomes specific to a particular driver and there's a goal here to share
with subfunction drivers.  I was thinking we could refactor to a union
or otherwise extend if we find other users with a similar need.

--k8z/zzyoNTrEHxEA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUBsfEACgkQJNaLcl1U
h9AY/Qf/YSKmZXsq1uAETsqoTJwyPENEXumzubfY98BLa82pFZ16eFJP991TrQI9
3Ac1oKOmelk4tkUV6dHnYCf4vipVmW7gOalV09kGgVmfUk5cRBjKvMRG/wjp7EoT
MP6EmgUT29aS0MhVvtcvKYtAL7KHIOQQdTT+r/fkcN6dCvp5w6wyexy0ZPLnLno+
2OH+3IbuQ5cJqwBbdepRBoc1Y6NNllkUz/D0IuvUZQ8UBYeOhQCJcPZk9nSIfpl/
Z9wWpq++HJhCtCS3hxygKOw9k7UETmGsMkvdDTa0ivH41Jc3R1LfCh4iXp7op+JO
nOFVux2zyeFWHGJ0JG3q1gkwfj9Lzg==
=hQRp
-----END PGP SIGNATURE-----

--k8z/zzyoNTrEHxEA--
