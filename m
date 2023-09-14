Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804D979F5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjINA2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINA2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:28:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B5E69;
        Wed, 13 Sep 2023 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694651314;
        bh=e1YoH197EdDGHpCVZmCs5PD+GAzKVkGxdxV3Lv5LF4k=;
        h=Date:From:To:Cc:Subject:From;
        b=oFWDr//j/nAazXnSMZxu8aZFoDRNaCdP3K+lg6fK0RvD3WoSKuFOkzb3Q4XlY35Xl
         7KPFbRtKuQKy9r9CuuAzx/Xfgm4s/VS3jN2SXF7L1nXbpI/BE2VS63DO8LGttICDig
         MH7rsrk+wc6u9ZU5yiS2L4pkg1yh6Cqss3216bIXVfE5HX12Affn+YksCP4kjgBir8
         hdmAJAwdlejvrkxzH456RmINyS5odCyber8eOe85H1zFyq2laCh1Yt/I8XWZlly6z/
         eh1gsBuucL51UtDGqjQSyw7yjlwEkATEnhjeR+vS76YOYdONUH+WZAhN0oQOW7Bkkt
         v5OF3+aqyk3TA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmJ8J4cDnz4wxf;
        Thu, 14 Sep 2023 10:28:32 +1000 (AEST)
Date:   Thu, 14 Sep 2023 10:28:30 +1000
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
Message-ID: <20230914102830.00537203@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5WOeVV/K_dvnbDjNnTl9w+j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5WOeVV/K_dvnbDjNnTl9w+j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c

between commit:

  1d85bb7fd66a ("staging: rtl8723bs: Fix alignment open parenthesis")

from Linus' tree and commit:

  66f85d57b710 ("wifi: cfg80211: modify prototype for change_beacon")

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
index af155fca39b8,5ddc2d9a6060..000000000000
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@@ -2317,9 -2318,8 +2317,9 @@@ static int cfg80211_rtw_start_ap(struc
  	return ret;
  }
 =20
 -static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_dev=
ice *ndev,
 -		struct cfg80211_ap_settings *info)
 +static int cfg80211_rtw_change_beacon(struct wiphy *wiphy,
 +				      struct net_device *ndev,
- 				      struct cfg80211_beacon_data *info)
++				      struct cfg80211_ap_settings *info)
  {
  	struct adapter *adapter =3D rtw_netdev_priv(ndev);
 =20

--Sig_/5WOeVV/K_dvnbDjNnTl9w+j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCU64ACgkQAVBC80lX
0GwFhQgAhNW3BFJpdKD9FgttzHHCaGWXr1+hqBNZnyAGrOvoMCVNY5LjPcVBT+MX
yPu76jRySi8Sp4w/iVL+Qi9rOKkx6yP/sQacPy+/RKX5yWn3sntVzWrbPPP0h5nQ
LptGQv+RW2GApE4Rypur0yN1dTi2MHUaBBEMKLzXombAKkkLsn6Q2yVv+UUulZT2
aJGXpZd7Nld8D3aYBjcJLhJX1peBylaGQb5R6B65pWFjt/fJyVk+rpqy1nRagD1Q
jyh7BUmAX+EgD4TcEF/rZcO+IXxWKsqz8gh+CHWsLaPAAzAIhOWq8m0iED6e2Opo
rQwNJ/LnS2v3tawoYf/EQ1c18Gs+XQ==
=aFyh
-----END PGP SIGNATURE-----

--Sig_/5WOeVV/K_dvnbDjNnTl9w+j--
