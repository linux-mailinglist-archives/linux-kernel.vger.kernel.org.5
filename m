Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0667AE382
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjIZBzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIZBzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:55:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F4811F;
        Mon, 25 Sep 2023 18:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695693297;
        bh=HDZLuCU5ZxOEpFG2Eug34ssRxcz/61/hDfUmS5JlVAE=;
        h=Date:From:To:Cc:Subject:From;
        b=liggGrUhFYLwEy1ikysvKkLCjE9d4cFFReTEi+ZMp/6KnM2sOJkE3jqAzPsjp8ZMx
         CpLJRYwl4t6WhhyaZHKxxfwVr+8r29T00TWJecwuijyY1NIPkIKTlw+JSo2Ip7OKO+
         mnhMsEn6RjX6907U+zwbEBzigPkkgUp8j/rCtgaMCnt6DEsOnjnbWrD9kVi0nBc08i
         Z3BxCoRRxkgzjbbhwVLN/9qcUDSiclqqcAyslmDR4Q0gS+vTQymLDebLM3/fRV8sBv
         SXA7cSyS11LCWOOLKNNGGHO6JNj43+W+3Mf+8EH4BIdy/lCGIVKdZLVZ7b02wFmD72
         +k8wJfM/NcJ4Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvjVR02R0z4xPN;
        Tue, 26 Sep 2023 11:54:54 +1000 (AEST)
Date:   Tue, 26 Sep 2023 11:54:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Aloka Dixit <quic_alokad@quicinc.com>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with Linus' tree
Message-ID: <20230926115452.68a71261@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JalrC.AZ1PGpYjh_00BopLc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JalrC.AZ1PGpYjh_00BopLc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c

between commit:

  1d85bb7fd66a ("staging: rtl8723bs: Fix alignment open parenthesis")

from Linus' tree and commit:

  66f85d57b710 ("wifi: cfg80211: modify prototype for change_beacon")
  bb55441c57cc ("wifi: cfg80211: split struct cfg80211_ap_settings")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index af155fca39b8,1e683212027c..000000000000
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@@ -2317,9 -2318,8 +2317,9 @@@ static int cfg80211_rtw_start_ap(struc
  	return ret;
  }
 =20
 -static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_dev=
ice *ndev,
 -		struct cfg80211_ap_update *info)
 +static int cfg80211_rtw_change_beacon(struct wiphy *wiphy,
 +				      struct net_device *ndev,
- 				      struct cfg80211_beacon_data *info)
++				      struct cfg80211_ap_update *info)
  {
  	struct adapter *adapter =3D rtw_netdev_priv(ndev);
 =20

--Sig_/JalrC.AZ1PGpYjh_00BopLc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSOewACgkQAVBC80lX
0GzRkgf+LO1FZ7xB5Ik2HCu0EVzVKonj1o9b1DhJLcI5IXsN4LkMNNK9c+8f2haq
qTHTdWlJEr+DNE/4yLHU5T+Kr9M1v+PcMcZ/4oYiXy6xspNLg1YMxmewYGFH60Z8
gGNei3BmbVALMO/dtxY44SctP4brCshowGkxYj94a56cGZjIBlELbniID/ECVjb1
SfAmPhcK4xv+vToOzzM8BDDxqQso0dZKz39djAwhVICQQ+HvAzc5yWALVpe6sGz6
ooN6HMriAq20AFl26j8dBvSPcGEgQBzz1/5SieAEYV3F5MW/AZkjJcUcHgbDFhty
lfChdMI8LlYdr7OXseWfvgtrdF3GVQ==
=SBoU
-----END PGP SIGNATURE-----

--Sig_/JalrC.AZ1PGpYjh_00BopLc--
