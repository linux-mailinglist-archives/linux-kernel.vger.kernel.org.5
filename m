Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B37A970E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjIURLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIURJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:24 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 007F27281
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:24 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 5B08E150B9B2;
        Thu, 21 Sep 2023 18:03:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1695312216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxsO6UkNvxMnaFNUASnMsSuKlQTdxo+O3u8ycIHVlUc=;
        b=oaQWT3Kzb4K5+aOUjPKPbiQf6IWki7Osf4bE/fWdYLN5HY9SsjuVaXG2jYRHSz1/q9wpVG
        0tkVCbGHHmiNN5zGTlbWeUZZykzTP9L3ZMsNG78SDMHxl+9Law0Clmpr+5ydPUzqzKJP50
        yg8Nm0Do/mnojCQeQBnhZW61Vq32naU=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: remove VHT160 capability on MT7915
Date:   Thu, 21 Sep 2023 18:03:23 +0200
Message-ID: <4862789.31r3eYUQgx@natalenko.name>
In-Reply-To: <2023092145-luxury-fender-d5b9@gregkh>
References: <20230726091704.25795-1-nbd@nbd.name> <12289744.O9o76ZdvQC@natalenko.name>
 <2023092145-luxury-fender-d5b9@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4513970.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4513970.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 21 Sep 2023 18:03:23 +0200
Message-ID: <4862789.31r3eYUQgx@natalenko.name>
In-Reply-To: <2023092145-luxury-fender-d5b9@gregkh>
MIME-Version: 1.0

Hello.

On =C4=8Dtvrtek 21. z=C3=A1=C5=99=C3=AD 2023 9:19:58 CEST Greg Kroah-Hartma=
n wrote:
> On Thu, Sep 21, 2023 at 07:02:41AM +0200, Oleksandr Natalenko wrote:
> > Hello Felix.
> >=20
> > On st=C5=99eda 26. =C4=8Dervence 2023 11:17:02 CEST Felix Fietkau wrote:
> > > The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for =
half-NSS
> > > 160 MHz support, so it is wrong to also advertise full 160 MHz suppor=
t.
> > >=20
> > > Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel wid=
th support for MT7915")
> > > Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drive=
rs/net/wireless/mediatek/mt76/mt7915/init.c
> > > index ee976657bfc3..78552f10b377 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > > @@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
> > >  			if (!dev->dbdc_support)
> > >  				vht_cap->cap |=3D
> > >  					IEEE80211_VHT_CAP_SHORT_GI_160 |
> > > -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
> > >  					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
> > >  		} else {
> > >  			vht_cap->cap |=3D
> > >=20
> >=20
> > For some reason this got backported into the stable kernel:
> >=20
> > ```
> > $ git log --oneline v6.5.2..v6.5.4 -- drivers/net/wireless/mediatek/mt7=
6/mt7915/
> > c43017fbebcc3 wifi: mt76: mt7915: fix power-limits while chan_switch
> > edb1afe042c74 wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan=
_mib_info
> > 9ec0dec0baea3 wifi: mt76: mt7915: remove VHT160 capability on MT7915
> > 0e61f73e6ebc0 wifi: mt76: mt7915: fix capabilities in non-AP mode
> > 6bce28ce28390 wifi: mt76: mt7915: fix command timeout in AP stop period
> > 7af917d4864c6 wifi: mt76: mt7915: rework tx bytes counting when WED is =
active
> > feae00c6468ce wifi: mt76: mt7915: rework tx packets counting when WED i=
s active
> > 70bbcc4ad6544 wifi: mt76: mt7915: fix background radar event being bloc=
ked
> > ```
> >=20
> > and this broke my mt7915-based AP.
> >=20
> > However, if I remove `[VT160]` capability from the hostapd config, thin=
gs go back to normal. It does seem that 160 MHz still works even.
> >=20
> > Is this expected?
>=20
> Is your device also broken in 6.6-rc2?

Yes, the same behaviour is observed with v6.6-rc2:

```
hostapd[1316]: Configured VHT capability [VHT_CAP_SUPP_CHAN_WIDTH_MASK] exc=
eeds max value supported by the driver (1 > 0)
```

while having `[VT160]` in `vht_capab=3D`.

Thanks.

> thanks,
>=20
> greg k-h
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4513970.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUMaUsACgkQil/iNcg8
M0vq2BAAuqUjADQGA+kGleFQ3VOqGsfXScI5KLV6AdTLuLpWqs9aFt/DsrE8hj+B
lUkTpEdWJvWRcMrWluTVp4wM+DVmrIid0+nY7yLJ9YwQEW2IzCIhrQrmoSrP09+6
MFmtvwolHlnAB6Mfat+uEPY6Bj6x6AY6BwHuqOpZVhI6mYZ/AUfVl0nmnuHRfiNw
ztpYDirxtQiG+zeEfegFzgRsYh3icFXo5G7R4nGmJrJWtr8DXd4NqObMFFtCLufH
vzNzk+isp/tA++kPE5gHwSXAJGjKWzecNdKuZNrr9X+FaF69yo6sCsF0scq1lvz5
i2zOzi6/jU6NMDJZbRsPLIrXKKZxj9DS3UEypFTI39oHgqHmqaWGMRutb5G9PeyQ
yhNj0ozWPOJxsSUfDQWs9plYwoHSvDc3L1T0NsjNojlDdkn8jJEaezV4RlcvJ5xU
iDVzTDru1jiCUnJ+RZyh9bLj9XdoR8l80w90DFnQ+BTbX2fUVARzub/4CJPfoTGy
1llvYYCi4sOrDMKuhxvgzVllwWy9exd2P4yMKifoYXjKhZeSgndSvhjF1f6TS6VQ
DWGYK4GWAwYUkTHpgdQSL/Mpo7Uz2yGLLKuoKorEMVtHA6HuMd83Mk7ABNsk6Nha
bNyC27xssOgbzCQPQOwIzouEE+Gnj2OfCko0DoDxzrvHreRGZY0=
=NwXY
-----END PGP SIGNATURE-----

--nextPart4513970.LvFx2qVVIh--



