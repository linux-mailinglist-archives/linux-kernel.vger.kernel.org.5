Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A887AA4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjIUW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjIUWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:36 -0400
X-Greylist: delayed 3334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 10:59:07 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90313A59C5;
        Thu, 21 Sep 2023 10:59:06 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 206D3150AC2D;
        Thu, 21 Sep 2023 07:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1695272574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CBBr2jfDzLMCIhDU0Px248rD/FOXEfErM7/x99M3aDM=;
        b=GLaqSqG4vq2RFzSGUNB2nPqN50JbIQHga5A+ZnDQ/pAvQdCnf1TdR4oZPjneXPUjbkJssh
        NewB0E7ctuCiZaYC0f+Mvif8TAXhgY7vzca3GrvyUJrzFGCXj0rSgdp1M/dhyYwQerXSyJ
        dqRjguWNaJQwTrl8VyJBhSwjfIudnJs=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: remove VHT160 capability on MT7915
Date:   Thu, 21 Sep 2023 07:02:41 +0200
Message-ID: <12289744.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20230726091704.25795-1-nbd@nbd.name>
References: <20230726091704.25795-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5713149.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5713149.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-wireless@vger.kernel.org
Date: Thu, 21 Sep 2023 07:02:41 +0200
Message-ID: <12289744.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20230726091704.25795-1-nbd@nbd.name>
References: <20230726091704.25795-1-nbd@nbd.name>
MIME-Version: 1.0

Hello Felix.

On st=C5=99eda 26. =C4=8Dervence 2023 11:17:02 CEST Felix Fietkau wrote:
> The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for half=
=2DNSS
> 160 MHz support, so it is wrong to also advertise full 160 MHz support.
>=20
> Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel width s=
upport for MT7915")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index ee976657bfc3..78552f10b377 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
>  			if (!dev->dbdc_support)
>  				vht_cap->cap |=3D
>  					IEEE80211_VHT_CAP_SHORT_GI_160 |
> -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
>  					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
>  		} else {
>  			vht_cap->cap |=3D
>=20

=46or some reason this got backported into the stable kernel:

```
$ git log --oneline v6.5.2..v6.5.4 -- drivers/net/wireless/mediatek/mt76/mt=
7915/
c43017fbebcc3 wifi: mt76: mt7915: fix power-limits while chan_switch
edb1afe042c74 wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib=
_info
9ec0dec0baea3 wifi: mt76: mt7915: remove VHT160 capability on MT7915
0e61f73e6ebc0 wifi: mt76: mt7915: fix capabilities in non-AP mode
6bce28ce28390 wifi: mt76: mt7915: fix command timeout in AP stop period
7af917d4864c6 wifi: mt76: mt7915: rework tx bytes counting when WED is acti=
ve
feae00c6468ce wifi: mt76: mt7915: rework tx packets counting when WED is ac=
tive
70bbcc4ad6544 wifi: mt76: mt7915: fix background radar event being blocked
```

and this broke my mt7915-based AP.

However, if I remove `[VT160]` capability from the hostapd config, things g=
o back to normal. It does seem that 160 MHz still works even.

Is this expected?

Please check.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5713149.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmULznEACgkQil/iNcg8
M0vrVxAAr2A2S5y3K3KZCf6eC4XHPkTxvLb/VNZfY4NVE+mHkgFZU9lFxYIw5D6y
XxfukONRVtusbi5M2gHCGPQEpNCAeSr2P9P/v8KRaYOoT54lrOvQquyliuoujuYC
jeO2XtIJUWxIpz5+BoXYrroD7z5k9sHIXf/xDuAmHa2IGy/bpU6yYb1V+dwEvzbi
43QoscmGzjAbZvrZiufetU3hUq4/oyZycwdUDK0/9cbEliQ8NkM6JiTFBQylgnmP
NI2iy0SZlHVcf/AWgps6TZwx3Frb12OvNAmnGWga2axpkXRm5pPkFEjxOreLteps
uSFcV12ZmTEsaHsAQOd+demq75/H3f9tJPMy1gz06oixO/3k9tUpdxVNiFgOuyg9
iKGUWTb5ETjufpJe6dpnnuhpHU2i+npAgs0tf8gVux/DZncvYbaYxb6iEIefwfXk
yUENnOzfud2aEFM/WJ8W9B8X+qGzsJD17YKV0VYKi0M6BQRdGFKP82EWAoTizTPj
0oSswygE9pf9ApswpOm0kq+3/iywejIchCNNjNFxvlrIMZCTtUSBeoUdNGitzcjE
7qOtBUpB5TikczCJt5ut4R9i51xCRrRi681XGx89zepc42DwpSj5qkORYOkGtWap
e8C01yUtMwdenAIJBYikBhNLtilZYg6epSuf7HhpGcn7fQDXwTM=
=VAkp
-----END PGP SIGNATURE-----

--nextPart5713149.DvuYhMxLoT--



