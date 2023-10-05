Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B497BA1B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbjJEOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbjJEOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:39:04 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D69D55DEC;
        Thu,  5 Oct 2023 07:05:47 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231005084047euoutp0157366671422ee79fb9d4488c4343312b~LKXBm3CcK0218602186euoutp01D;
        Thu,  5 Oct 2023 08:40:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231005084047euoutp0157366671422ee79fb9d4488c4343312b~LKXBm3CcK0218602186euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696495247;
        bh=3m+W8OZ+q7U0Z5Xd3tHyUE/jHnrt0jaco7nrd9bM4bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9IKYeScFoZXwjr2IF9SUrMEOhixk6cOMLyr/PJ071E6QDl2N68SjjAemnKbtLIq5
         npS97x9n8m08e+7ZQebeQ/eZ/6qj9xmfGbnnItS73bd6a5OCSUBQf8XhsezLAN6M8Z
         oPggeWIXs4GLHKoD1/rdCWq/rGhBUM7GkeTWbQzg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005084047eucas1p1da5e0df7825edbc7344cb463cc3f8a9b~LKXBTTGYc1320813208eucas1p1_;
        Thu,  5 Oct 2023 08:40:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 41.1D.42423.E867E156; Thu,  5
        Oct 2023 09:40:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231005084046eucas1p1a8dcb84361cc0ef1242768ecc1a96664~LKXA8RBwW0854408544eucas1p19;
        Thu,  5 Oct 2023 08:40:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231005084046eusmtrp110d01553a8e57750494a7a7668d25921~LKXA7op2P1084310843eusmtrp1F;
        Thu,  5 Oct 2023 08:40:46 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-85-651e768e23d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D0.38.25043.E867E156; Thu,  5
        Oct 2023 09:40:46 +0100 (BST)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231005084046eusmtip1fb381a4d3621657d165da451e1e6f248~LKXAxc23d0602606026eusmtip1W;
        Thu,  5 Oct 2023 08:40:46 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ax88796c: replace deprecated strncpy with strscpy
Date:   Thu, 05 Oct 2023 10:40:46 +0200
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
        (Justin Stitt's message of "Thu, 05 Oct 2023 01:06:26 +0000")
Message-ID: <oypijd34yp5unl.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87p9ZXKpBpd+mlvMOd/CYvH02CN2
        i2mrF7NZXNjWx2oxb/1PRovLu+awWRxbIGbx7fQbRgcOjy0rbzJ5LNhU6rFpVSebx/t9V9k8
        Pm+SC2CN4rJJSc3JLEst0rdL4MqYteYvY8EUyYrdm7axNTBuFu1i5OSQEDCR6Jh+gbGLkYtD
        SGAFo8TlE0eZIZwvjBKPlr9ngnA+M0rsPfuFtYuRA6zlyGoHiPhyRok5N95Dtb9glDje/ZQJ
        pIhNQE9i7doIkBUiApoSZ7dOZAepYQaZ2jOjhRkkISzgLdH6u5kNxGYRUJWYsmYn2CBOkKlt
        604wgiR4Bcwl+k7+YwGxRQUsJY5vbWeDiAtKnJz5BCzOLJArMfP8G7BmCYEfHBJbjq5jg/jO
        ReLGv3/MELawxKvjW9ghbBmJ05N7WCAa2hklmq4sZIVwJjBKfO5oYoKospa4c+4X1CRHiS2z
        Z0ADgE/ixltBiM18EpO2TWeGCPNKdLQJQVSrSKzr38MCYUtJ9L5awQhhe0i07DvJAgmuXYwS
        byZ0sExgVJiF5KFZSB6aBTSWGRh863fpQ4S1JZYtfM0MYdtKrFv3nmUBI+sqRvHU0uLc9NRi
        w7zUcr3ixNzi0rx0veT83E2MwER1+t/xTzsY5776qHeIkYmD8RCjClDzow2rLzBKseTl56Uq
        ifCmN8ikCvGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamBy
        eMEk7vYo39UnOtitpHvLw61WGncempsLRMZmPbHxiDnLc3Ph01DVr/MDVzDHds1ZynFcnnHt
        KsPHb6ZHTc//+v7x9T6h2cInVouejXhyrbd4621epi+7FWa73m5+mO6w7NfCJV1bnhp+ebe5
        2mB2UZrBBYvdHl9C2JZdun9ssddKuXUpmcprLY/PtAgIFJRtqVgW8/rRnYnmu7/+WXGjUWPj
        hQPZV69O/p3clihhFHPlcuU0V0apI68aMqLWnjF6vb2+wiFndmSnQtiWMwJKW7UP+HP8qBC1
        u7vV7vONKydZn53Vvf5w75UpsUGzTLM/hXfsc5wfeTbwWfbPE+vFavb8FdaUiPun6Zx9zmuP
        jRJLcUaioRZzUXEiAO0gP1jPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7p9ZXKpBosmqVjMOd/CYvH02CN2
        i2mrF7NZXNjWx2oxb/1PRovLu+awWRxbIGbx7fQbRgcOjy0rbzJ5LNhU6rFpVSebx/t9V9k8
        Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0MuYteYvY8EUyYrdm7axNTBuFu1i5OCQEDCROLLaoYuRk0NIYCmjxNS2KoiwlMTKuekgYQkB
        YYk/17rYuhi5gEqeMUosOfKDEaSGTUBPYu3aCJAaEQFNibNbJ7KD2MwCXxklGqf4gdjCAt4S
        rb+b2SDGp0ncf9bHAmKzCKhKTFmzkxFkJqfAckaJtnUnGEESvALmEn0n/4EViQpYShzf2s4G
        EReUODnzCQvEgmyJr6ufM09gFJiFJDULSWoW0HnMQDet36UPEdaWWLbwNTOEbSuxbt17lgWM
        rKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY2vbsZ9bdjCufPVR7xAjEwfjIUYVoM5HG1Zf
        YJRiycvPS1US4U1vkEkV4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5Hxg1OeVxBuaGZgamphZ
        GphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTDN4th+dFMt/w8GS5a7p60czLfzu/ff
        1rxg88XJfe173o17OjTKnsQklU3wnL6lRj96c+zPtInX8u4sMLJJvDDxcVAix8tjGuE7WKf3
        /M7rv+nwLnwbq/g1KaEHv6YF3jPLXFN87+gaG+7nB5Z95fZSKljhpX4uWvavv/kdw5muPvcD
        pIPb/qUl6/Sm8MwvX+QvV/N21eXe+EiTuq2pXzbYfJkoqr5AZuOz+M4Tiq5Fj6d7cDad7dp2
        Nuu/g6I0n8hCpiVb3ALDV23ff8k080t6S+KKP5cNPV7VnTPuW5e78EXcdWZle5n/NTXZ759c
        XHZATb5cQmDtHYbkCifWnwoBZUlNxf4GWz2nHm6qDVZiKc5INNRiLipOBAB3/X3cQgMAAA==
X-CMS-MailID: 20231005084046eucas1p1a8dcb84361cc0ef1242768ecc1a96664
X-Msg-Generator: CA
X-RootMTR: 20231005084046eucas1p1a8dcb84361cc0ef1242768ecc1a96664
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231005084046eucas1p1a8dcb84361cc0ef1242768ecc1a96664
References: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
        <CGME20231005084046eucas1p1a8dcb84361cc0ef1242768ecc1a96664@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2023-10-05 czw 01:06>, when Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
>
> It should be noted that there doesn't currently exist a bug here as
> DRV_NAME is a small string literal which means no overread bugs are
> present.
>
> Also to note, other ethernet drivers are using strscpy in a similar
> pattern:
> |       dec/tulip/tulip_core.c
> |       861:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       8390/ax88796.c
> |       582:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       dec/tulip/dmfe.c
> |       1077:   strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       8390/etherh.c
> |       558:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/asix/ax88796c_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Lukasz Stelmach <l.stelmach@samsung.com>

> diff --git a/drivers/net/ethernet/asix/ax88796c_ioctl.c b/drivers/net/eth=
ernet/asix/ax88796c_ioctl.c
> index 916ae380a004..7d2fe2e5af92 100644
> --- a/drivers/net/ethernet/asix/ax88796c_ioctl.c
> +++ b/drivers/net/ethernet/asix/ax88796c_ioctl.c
> @@ -24,7 +24,7 @@ static void
>  ax88796c_get_drvinfo(struct net_device *ndev, struct ethtool_drvinfo *in=
fo)
>  {
>  	/* Inherit standard device info */
> -	strncpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
>  }
>=20=20
>  static u32 ax88796c_get_msglevel(struct net_device *ndev)
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-56=
af20b7d992
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
>
>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmUedo4ACgkQsK4enJil
gBBtOgf/bIfVw7cQUrX08F5M1kR+r8NPkBJEcRU0/LsDSm7kFknOqcpcT0HY9P4u
BXSG73gLX18UvSzi+wshSzsDbyGNbwSHtvO3z1ADa1jAfTfKcXjKXPK7A+I9e6FV
ooqTslmfuO/kTYkwUUSvy//kI7HSL4cmJWFvKridRMhqXmui3UNaRymFCoeUXf1z
D/Xuf6VgmPEUZ3wZH7UaKi07IgmkryxGz5J3U+XJi8Xk0jg72gALO+6IGmeYyPUu
jHrj75qYCCoQ4uynjloHO0QlKpfs3Wu46SRdoFQdGNYIGrGdrSNAwGDK/86Z26k4
Zei/eRNsNhk5YQA2CC67DK/JHM76WA==
=MNNw
-----END PGP SIGNATURE-----
--=-=-=--
