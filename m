Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3727DE37C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjKAPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjKAPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:35:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12250DA;
        Wed,  1 Nov 2023 08:35:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596B4C433C8;
        Wed,  1 Nov 2023 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698852906;
        bh=i7SLqNYwMroJ9j6IeGlb9lr1J6JFmKijcwga1nozlgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjiS0rGQuzpA1Uq8UA44VJt7uRBrMkUEIhCSNc/J8Z1G+X4CenLaQ9c5gQAhqXkRd
         zqftjQYhulP9KricxTbFD6XlVDXzpYb5XWd9hng/jkmvsup0K+cjrTKB8yf+9ZjkiQ
         tjeNNADvfOsxZQtddYey0B7ZnKmJkmqBOxnU5EFLQbB7CicMuo+r0ViFNTTEX0lO8Q
         4/VcSShzHB1dCG5yWhdj+9ieK2+X8ghpQ+bXlPKa+Bgr3MImV6ex+7wtA5ULqCd548
         TT56hJcESdfB/BkoPxU0AiL5vxZ+BVmjslLmpH28bwGMx1vuvYIqJq+JCz8av32lfI
         VH0lzDs0u+weQ==
Date:   Wed, 1 Nov 2023 16:35:03 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Tom Waldron <tom@baremetal.dev>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] wifi: mt76: mt7921: Add a new VID/PID 0b48/7922 for
 MT7922
Message-ID: <ZUJwJ+bimXFVcXps@lore-desk>
References: <20231101095533.45258-1-tom@baremetal.dev>
 <ZUJoFAcKMrVD5Glo@lore-desk>
 <CANjHDnBkCW_zQxyCcKcyrZOYnnLNVKT1Z2AJr6x6DT55UZ+A7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WqCCO7JUs1yhqnjX"
Content-Disposition: inline
In-Reply-To: <CANjHDnBkCW_zQxyCcKcyrZOYnnLNVKT1Z2AJr6x6DT55UZ+A7Q@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WqCCO7JUs1yhqnjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> PCI VID 0x0b48 doesn't appear to be listed anywhere I can find, though
> a website named pcilookup.com suggests it belongs to TechnoTrend AG. I
> think it's more likely to be part of AMD RZ600 series - rebranded
> mediatek devices. Not sure how any of this might be verified.

I have just found it here: include/linux/pci_ids.h
but I am not sure if it is related. Anyway:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> On Wed, 1 Nov 2023 at 15:00, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >
> > > Add VID/PID 0b48/7922 for MediaTek MT7922 wifi chip.
> > > Change tested on Redmi Book Pro 15 2023 (Fedora 38).
> > >
> > > Signed-off-by: Tom Waldron <tom@baremetal.dev>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/pci.c
> > > index 3dda84a93..ba805cb02 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > > @@ -21,6 +21,8 @@ static const struct pci_device_id mt7921_pci_device=
_table[] =3D {
> > >               .driver_data =3D (kernel_ulong_t)MT7921_FIRMWARE_WM },
> > >       { PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
> > >               .driver_data =3D (kernel_ulong_t)MT7922_FIRMWARE_WM },
> > > +     { PCI_DEVICE(0x0b48, 0x7922),
> > > +             .driver_data =3D (kernel_ulong_t)MT7922_FIRMWARE_WM },
> >
> > is PCI VID 0x0b48 PCI_VENDOR_ID_ITTIM?
> >
> > Regards,
> > Lorenzo
> >
> > >       { },
> > >  };
> > >
> > > --
> > > 2.41.0
> > >

--WqCCO7JUs1yhqnjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZUJwJwAKCRA6cBh0uS2t
rDnIAP46mx8DfEExBed+hFhMm/5wX5CN9oCke5LtPX763BQasAD9H/IqZt28/EsZ
4vCLxApqMXI2QJzrT5l2rnGv80S6twc=
=QvB7
-----END PGP SIGNATURE-----

--WqCCO7JUs1yhqnjX--
