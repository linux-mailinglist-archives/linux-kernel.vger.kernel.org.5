Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655A7DE358
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjKAPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjKAPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:00:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE0115;
        Wed,  1 Nov 2023 08:00:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0C5C433C8;
        Wed,  1 Nov 2023 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698850840;
        bh=61VJ8pl4e3NGwPPj59m3HBRGj5+ApAztxPeXNk4KdN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/H7TOP9PGYTmwk/6ArJ9rVSu9xTz850uhD7MPwufzxy0ADppO+ofF/Kg2me+Vrdi
         yoqJwLr6lLXYnngLyzbAzxb2blibWSz+RIaHTlGDh5Buezwt4Bbp97SMuEu2D89dC/
         W0mLnX8jIVpbDLYTOmqKkiAzTsjllZaO2MQrj/2D1nnRDe2pvnFGz482RQr7WRDf6Z
         iBhTfXJX7ZOOERwko2yo99IaOSrVmT2X7pGYUaDlngsHMy2JOF9LSkvshcaGXqnrNC
         31OuRZ3yZkvvQ3bpWv+3DPyW7TVt8cQThD3XlYQ/m5n61cAvOj3utUvHUmyD5SFQIZ
         KNyPci3/0YpuQ==
Date:   Wed, 1 Nov 2023 16:00:36 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Tom Waldron <tom@baremetal.dev>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] wifi: mt76: mt7921: Add a new VID/PID 0b48/7922 for
 MT7922
Message-ID: <ZUJoFAcKMrVD5Glo@lore-desk>
References: <20231101095533.45258-1-tom@baremetal.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wsOepGTnfH8POUN2"
Content-Disposition: inline
In-Reply-To: <20231101095533.45258-1-tom@baremetal.dev>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wsOepGTnfH8POUN2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add VID/PID 0b48/7922 for MediaTek MT7922 wifi chip.
> Change tested on Redmi Book Pro 15 2023 (Fedora 38).
>=20
> Signed-off-by: Tom Waldron <tom@baremetal.dev>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 3dda84a93..ba805cb02 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -21,6 +21,8 @@ static const struct pci_device_id mt7921_pci_device_tab=
le[] =3D {
>  		.driver_data =3D (kernel_ulong_t)MT7921_FIRMWARE_WM },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
>  		.driver_data =3D (kernel_ulong_t)MT7922_FIRMWARE_WM },
> +	{ PCI_DEVICE(0x0b48, 0x7922),
> +		.driver_data =3D (kernel_ulong_t)MT7922_FIRMWARE_WM },

is PCI VID 0x0b48 PCI_VENDOR_ID_ITTIM?

Regards,
Lorenzo

>  	{ },
>  };
> =20
> --=20
> 2.41.0
>=20

--wsOepGTnfH8POUN2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZUJoFAAKCRA6cBh0uS2t
rAJOAP0caGBM5srfImXm+Ko83soD7yWACQIuY/L49z76kaIv1AEAvMHiruc7+J3r
WUbEUXvt6Qv/7cAabeUjYTV9C6lEJwI=
=ylh9
-----END PGP SIGNATURE-----

--wsOepGTnfH8POUN2--
