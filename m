Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54D38112D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378962AbjLMN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjLMN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:26:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF31DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:26:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5E0C433C7;
        Wed, 13 Dec 2023 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702474003;
        bh=IKzEPJuxRJ70VYdW/2SaiHnZpZE1vJIdBlLNxNGneUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sh3710819in+LL0u6YtfRlRkB2RQ9Q55qNflXVQzV90qC6oYwmQfmDTByHLhXv4Ez
         auRR2iMQJf3m84D10+A2d7AqDMPBZprMmi4T7oFjZD997ce5RYmaCYpCapeQGC5xgL
         CRSLesDsqMyXng2LI96xv8SwjfxdP/jJvLM6NBob96bILqnibz195Ui1YrEU5mmO/p
         zh1xJnnip1dO2NeEzH0elAMgAHlaStqtZWAcCe/8bTEs5uzWieGFfsgcauvAZQzgaa
         heGMtQxQifPtH3hYx1I5nV1Y/xuSmXPlliMrFRqA2sFmvebaerKoZOQwlTHWAF/KdI
         5YSVPmu0OSO1Q==
Date:   Wed, 13 Dec 2023 14:26:39 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Message-ID: <ZXmxD1foASMaCDIe@lore-desk>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
 <874jgmnud8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9uLM4Nq5uaqfA0yL"
Content-Disposition: inline
In-Reply-To: <874jgmnud8.fsf@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9uLM4Nq5uaqfA0yL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Mario Limonciello <mario.limonciello@amd.com> writes:
>=20
> > Several users have reported awful latency when powersaving is enabled
> > with certain access point combinations.
>=20
> What APs are these exactly? In the past 802.11 Power Save Mode was
> challenging due to badly behaving APs. But nowadays with so many mobile
> devices in the market I would assume that APs work a lot better. It
> would be best to investigate the issues in detail and try to fix them in
> mt76, assuming the bugs are in mt76 driver or firmware.
>=20
> > It's also reported that the powersaving feature doesn't provide an
> > ample enough savings to justify being enabled by default with these
> > issues.
>=20
> Any numbers or how was this concluded?
>=20
> > Introduce a module parameter that would control the power saving
> > behavior.  Set it to default as disabled. This mirrors what some other
> > WLAN drivers like iwlwifi do.
>=20
> We have already several ways to control 802.11 power save mode:
>=20
> * NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')
>=20
> * CONFIG_CFG80211_DEFAULT_PS (for kernel level default)
>=20
> * WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the default sett=
ing)
>=20
> Adding module parameters as a fourth method sounds confusing so not
> really a fan of this. And the bar is quite high for adding new module
> parameters anyway.

agree, I think we do not need a new parameter for this, just use the current
APIs.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--9uLM4Nq5uaqfA0yL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZXmxDwAKCRA6cBh0uS2t
rMk4AP4meRcee0zlYRgossoI8og7N/lRVYrPEbK9Pvu+GoHvbwD9H342JwJu5cTO
ESqtC33FKLmyM0+wXLDJ/KpvDg+gNQQ=
=O53f
-----END PGP SIGNATURE-----

--9uLM4Nq5uaqfA0yL--
