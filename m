Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F184E7B3B46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjI2Ug1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2Ug0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:36:26 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6730B1A7;
        Fri, 29 Sep 2023 13:36:22 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 88FC8151F5BA;
        Fri, 29 Sep 2023 22:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696019778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDRs7Gz0S8XKWG8d8n8yfhBlGk/DX136F9VchbG9m8Q=;
        b=NZBUuV2bX2r7v5rH1+Z3xzSBUuBgp/OUyfmgU/Je987if/zW0iWOO70XP3OiY211y7w+MD
        yZY6vBie98mLM/xxrdbS7NBBFgZc6DYGaC+6yp92ofP1zMQsvucRZ5ir8jGcPnSbe5HwsE
        C+QbhHhwatry1M60h3Pr+4gYylr3SkE=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-wireless@vger.kernel.org,
        Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc:     Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: remove VHT160 capability on MT7915
Date:   Fri, 29 Sep 2023 22:36:05 +0200
Message-ID: <12294858.O9o76ZdvQC@natalenko.name>
In-Reply-To: <eab8e74b-61e0-4ef4-bfb3-751047d879bc@green-communications.fr>
References: <20230726091704.25795-1-nbd@nbd.name> <12289744.O9o76ZdvQC@natalenko.name>
 <eab8e74b-61e0-4ef4-bfb3-751047d879bc@green-communications.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5715364.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5715364.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Fri, 29 Sep 2023 22:36:05 +0200
Message-ID: <12294858.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 29. z=C3=A1=C5=99=C3=AD 2023 14:59:26 CEST Nicolas Cavallari =
wrote:
> On 21/09/2023 07:02, Oleksandr Natalenko wrote:
> > Hello Felix.
> >=20
> > On st=C5=99eda 26. =C4=8Dervence 2023 11:17:02 CEST Felix Fietkau wrote:
> >> The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for h=
alf-NSS
> >> 160 MHz support, so it is wrong to also advertise full 160 MHz support.
> >>
> >> Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel widt=
h support for MT7915")
> >> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >> ---
> >>   drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/init.c
> >> index ee976657bfc3..78552f10b377 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> >> @@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
> >>   			if (!dev->dbdc_support)
> >>   				vht_cap->cap |=3D
> >>   					IEEE80211_VHT_CAP_SHORT_GI_160 |
> >> -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
> >>   					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
> >>   		} else {
> >>   			vht_cap->cap |=3D
> >>
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
> I would say it is expected.
>=20
> hostapd seems to solely rely on the VHT Supported Channel Width and does =
not=20
> seem to support the VHT Extended NSS BW stuff.  So it only knows about fu=
ll VHT=20
> 160 MHz support and not about half NSS VHT 160 MHz.
>=20
> The hardware does not actually support full 160 MHz (despite the driver=20
> erroneously claiming support for it before this patch) so it make sense t=
hat=20
> hostapd fails to start the AP if the config file requests (full) VHT 160 =
MHz.
>=20
> However, hostapd knows about half NSS HE 160 MHz and I suspect your=20
> configuration also requests HE 160 MHz, so 160 MHz works fine in HE but n=
ot in VHT.

I see, thanks for the explanation.

> In any case, it would help to know the hostapd version and your configura=
tion file.

It's 2.10 with the following config at the very moment:

```
interface=3Dwlp1s0
ctrl_interface=3D/run/hostapd/wlp1s0
driver=3Dnl80211
ssid=3Dxxx
utf8_ssid=3D1
interworking=3D1
ipaddr_type_availability=3D12
country_code=3DXX
auth_algs=3D1
wpa=3D2
wpa_key_mgmt=3DWPA-PSK FT-PSK
wpa_pairwise=3DCCMP
rsn_pairwise=3DCCMP
wpa_psk_file=3D/run/credentials/hostapd@wlp1s0.service/hostapd.wpa_psk
macaddr_acl=3D1
accept_mac_file=3D/etc/hostapd/hostapd.accept
noscan=3D1
hw_mode=3Da
ieee80211n=3D1
channel=3D100
vht_oper_chwidth=3D2
vht_oper_centr_freq_seg0_idx=3D114
ieee80211ax=3D1
he_oper_chwidth=3D2
he_oper_centr_freq_seg0_idx=3D114
ieee80211w=3D1
ocv=3D1
ieee80211d=3D1
ieee80211h=3D1
wmm_enabled=3D1
ht_capab=3D[RXLDPC][HT40+][GF][SHORT-GI-20][SHORT-GI-40][TX-STBC][RX-STBC1]=
[MAX-AMSDU-7935][DSSS_CCK-40]
mobility_domain=3Dabcd
ft_psk_generate_local=3D1
pmk_r1_push=3D1
rsn_preauth=3D1
rsn_preauth_interfaces=3Dwifi-br
nas_identifier=3Dyyy
r1_key_holder=3Dyyy
r0kh=3Dff:ff:ff:ff:ff:ff * zzz
r1kh=3D00:00:00:00:00:00 00:00:00:00:00:00 zzz
disassoc_low_ack=3D1
fst_group_id=3Dwifi-br
fst_priority=3D100
mbo=3D1
mbo_cell_data_conn_pref=3D1
require_ht=3D1
ieee80211ac=3D1
require_vht=3D1
vht_capab=3D[MAX-MPDU-7991][RXLDPC][SHORT-GI-80][SHORT-GI-160][TX-STBC-2BY1=
][RX-STBC-1][SU-BEAMFORMER][SU-BEAMFORMEE][MU-BEAMFORMER][MU-BEAMFORMEE][RX=
=2DANTENNA-PATTERN][TX-ANTENNA-PATTERN][MAX-A-MPDU-LEN-EXP7]
```

(I wonder if I did other obviously stupid things here)

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5715364.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUXNTYACgkQil/iNcg8
M0s2MBAAgiZ/bSWCeVKR7b1a5mtQ5rwZdw6YQUMDiOJvfYMU2LzRG4NcdSmJ9KBu
DcPAzayK2Ue6pPBAxDH2Evl4U4cWa+Dn99wFYjf9T0ljnG17Sl73WM8jCRrsDLM/
g0BbBHDpFPvH8qPLxSerfmJmqdoCM9I/zekSJqcA/+3vSukd7ZunSkGn7o3hWhfZ
8BpLqdhv8+FrilncdybEBzz0Q/g4thWmEEbUmRpakwwoeUehnrvNs67G/p7LEm65
YvK4GU92jkb3suxt0V8nBbCmtj8/++Z3UGrDSvM+oY2OUzWt5fA+i+hCEQcamwZe
kUiwAOXGdefjzgtM4ecSGM/JajQLDA4prj8AhCz2Jnc/oUT1diwD3jMxncoK1SdN
k3qEULBzQ0930XeHdo++yiqycWfDmyFP5yPfbxf+RnwC0bJ6Ai05SS8XamGNzFfA
G/1Tmhu5yc9RcW8J8bZNZ6IdTSPi12j5pvIQYXzLMYkE5Qoi7FjzEJzUopezdHrk
VOeFZczEVxNai3V4Ac8TEzsV2SPVCJ47fiwTWALtsiMCaoSWa8Gr5tIBgGj3LFYT
gGYIO6gJIqf2GpGJ0r2U0qY19ySGUgV2puZ/DeOQqxiWBQssYOmDEHtJP63PCIm6
MrgqCxWCObBvzU3LTO89v+YAfowE/ow5uynnHssMDTcMxget8Iw=
=1GhB
-----END PGP SIGNATURE-----

--nextPart5715364.DvuYhMxLoT--



