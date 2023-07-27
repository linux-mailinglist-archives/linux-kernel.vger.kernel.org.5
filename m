Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE1B7653FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjG0MbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjG0MbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:31:18 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31959A0;
        Thu, 27 Jul 2023 05:31:17 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230727123115euoutp02efe56ab69c0f6d93bf5e44daa135fa62~1uWRJ0u2b0676306763euoutp02q;
        Thu, 27 Jul 2023 12:31:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230727123115euoutp02efe56ab69c0f6d93bf5e44daa135fa62~1uWRJ0u2b0676306763euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690461075;
        bh=XLMM8OV6uWDkuXMdbW6WQEC+PZrDreWRKnf1tR2c17M=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=GGMFwmrg36OOUx5Yl2h9yXEBL+aHfrnF8DTSjp+nHkmqf5IKTjc9x7HupuUMKTTM8
         Z0WDlY0b5f0e/3Hd09Wjrz0y55xIAUvgvNKLoTo0RDrfq49rxNwdicBe3N44V3DC2b
         7NSSK1EZM8OUSh52ksQyFpLuTfdJCvE2j8/iSKPU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230727123115eucas1p2c7ec941ceae294f571f9dcf65e509333~1uWQ2oYhW1532515325eucas1p2T;
        Thu, 27 Jul 2023 12:31:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.2F.42423.39362C46; Thu, 27
        Jul 2023 13:31:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230727123114eucas1p14efcc62318a464c7649eb110674a6600~1uWQOwPaD2836028360eucas1p1W;
        Thu, 27 Jul 2023 12:31:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230727123114eusmtrp1ca18667da63524cef3a56277e802de58~1uWQODzo82940429404eusmtrp1r;
        Thu, 27 Jul 2023 12:31:14 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-8a-64c2639328c2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.8B.14344.29362C46; Thu, 27
        Jul 2023 13:31:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230727123114eusmtip2d578c5d3d5bcf4a510dcfdb801f7ffe1~1uWQCy8IK2983829838eusmtip2H;
        Thu, 27 Jul 2023 12:31:14 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 27 Jul 2023 13:31:13 +0100
Date:   Thu, 27 Jul 2023 14:31:12 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <willy@infradead.org>,
        <keescook@chromium.org>, <josh@joshtriplett.org>,
        <linux-hams@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/14] ax.25: Update to register_net_sysctl_sz
Message-ID: <20230727123112.yhgbxrhznrp6r3jt@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="4vknydsdvtpt7ldd"
Content-Disposition: inline
In-Reply-To: <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7djPc7qTkw+lGJw5wWox53wLi8XTY4/Y
        Lf4vyLf42cdtcaY71+LCtj5Wi2vb7zJZXN41h83ixoSnjBbHFohZfDv9htHi0h4Vi98/5rA5
        8HrMbrjI4rFl5U0mjwWbSj02r9DyuPXa1mPTqk42j6Mr1zJ5vN93lc3j8yY5jzfTXjMFcEVx
        2aSk5mSWpRbp2yVwZXS+uMxUcIWnYvbrDSwNjD+4uhg5OSQETCQeTrnMBGILCaxglNh4vaSL
        kQvI/sIosb7hOzOE85lR4uzLl8wwHe+37GSF6FjOKPFwZjlc0anJe6E6tjJKLF3bCjaXRUBV
        4sjdWWDdbAI6Euff3AGzRQQ0JPZN6GUCaWAWaGKWOLziPxtIQljASeLxhCtgK3gFzCV+397F
        BmELSpyc+YQFxGYWqJBYP+0FkM0BZEtLLP/HARLmFDCT2Pn+FtSlyhIHl/xmh7BrJU5tuQW2
        S0LgHqdE09sWNpBeCQEXic37eCBqhCVeHd8CVS8jcXpyDwtE/WRGif3/PrBDOKsZJZY1fmWC
        qLKWaLnyBKrDUeJMzw5WiKF8EjfeCkLcyScxadt0Zogwr0RHmxBEtZrE6ntvWCYwKs9C8tks
        JJ/NQvgMIqwjsWD3JzYMYW2JZQtfM0PYthLr1r1nWcDIvopRPLW0ODc9tdgwL7Vcrzgxt7g0
        L10vOT93EyMwUZ7+d/zTDsa5rz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivKcCDqUI8aYk
        VlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYKoVeav8nuWRP1dO
        x/LLHOu/19u/PfEpy7L7xlH5aSbG5X6qp75NeCf1rn1B/+Ura2z6ima+qf35vS3wf3l8xs1z
        hrY21RNa7dblb4qIuqQ6Y+l6xT/nirKnz34vdYU38+/KgInawmKLOcse/XlamHnDId1xwfzn
        Bv3zOT5VmZsqL9pwUWPfPt8ld3a1/ilU52Oo7jlmVHIyaH6FJVfXybVrJxw20m/adcnHbNPi
        ujCzhweadbvvvHNPnh/48Gn2V8NHEmfMkuPLXrjuSzbZ0s32N3xvsbju6YsbLnrGZjBzqdm7
        RB7hj7duDPa5eqXw+u8jHjMa/8yQ9dmhGrr8+I4r/wV2Ff6azaxy+NXO3f+UWIozEg21mIuK
        EwHaqaHNDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xe7qTkg+lGGy7IW0x53wLi8XTY4/Y
        Lf4vyLf42cdtcaY71+LCtj5Wi2vb7zJZXN41h83ixoSnjBbHFohZfDv9htHi0h4Vi98/5rA5
        8HrMbrjI4rFl5U0mjwWbSj02r9DyuPXa1mPTqk42j6Mr1zJ5vN93lc3j8yY5jzfTXjMFcEXp
        2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXxe8IS5
        4BJPxfLnc9gbGL9xdTFyckgImEi837KTtYuRi0NIYCmjRMOn56wQCRmJjV+uQtnCEn+udbFB
        FH1klHi38RwThLOVUWLG1rUsIFUsAqoSR+7OYgax2QR0JM6/uQNmiwhoSOyb0AvWwCzQxCxx
        eMV/NpCEsICTxOMJV8BW8AqYS/y+vQtqxSdGieXrO5kgEoISJ2c+AdvALFAmcb/tGtBUDiBb
        WmL5Pw6QMKeAmcTO97eYIU5Vlji45Dc7hF0r8fnvM8YJjMKzkEyahWTSLIRJEGEtiRv/XjJh
        CGtLLFv4mhnCtpVYt+49ywJG9lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBKWPbsZ9bdjCu
        fPVR7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US4T0VcChFiDclsbIqtSg/vqg0J7X4EKMpMBgn
        MkuJJucDk1leSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTiYF3
        qfoMtgnMRZetetLF5/XNul94OTfBq/RuzuV/O/rc10gvEzr+/xaXf8fmaTOuRTVLaKWsy43N
        FF/kqbwnnJn/8X3OcLXvJi49McenWay3YZvGvyXnRqqdxYHP/+L16hnNxdyXCqpYVL5OkHw4
        /RgP5y057i9/Y5f8Ot1x9OtdKYfAxOT059/fhH1Vdsz+dmTyyhXH8oNnfHu5TtGzS3kNu/Pq
        6qKUucezV/67rb+hz8vbVnMFc4H2jgs2mw5OuvXMpGLrA7U/bOof2bZFFuR/W/bqc4dZGttz
        Ax0f3e0zfktYp9QcPMGeesK1e1ruep17bo2bGDk26VccTN02S+fpNFvXozGrbnoyL3VRYinO
        SDTUYi4qTgQAfrzcy64DAAA=
X-CMS-MailID: 20230727123114eucas1p14efcc62318a464c7649eb110674a6600
X-Msg-Generator: CA
X-RootMTR: 20230726140703eucas1p2786577bcc67d5ae434671dac11870c60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140703eucas1p2786577bcc67d5ae434671dac11870c60
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140703eucas1p2786577bcc67d5ae434671dac11870c60@eucas1p2.samsung.com>
        <20230726140635.2059334-10-j.granados@samsung.com>
        <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4vknydsdvtpt7ldd
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:00:37AM -0700, Luis Chamberlain wrote:
> On Wed, Jul 26, 2023 at 04:06:29PM +0200, Joel Granados wrote:
> > This is part of the effort to remove the sentinel (last empty) element
> > from the ctl_table arrays. We update to the new function and pass it the
> > array size.
>=20
> The commit log does not explain why. It also does not explain if there
I'll add the "why".

> is any delta on size at compile or runtime.
There are no deltas in this patch set. We start seeing the deltas when
we start removing with the next 6 chunks. I'll try to make that more
clear in the commit message.

>=20
>   Luis

thx for the feedback

--=20

Joel Granados

--4vknydsdvtpt7ldd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTCY5AACgkQupfNUreW
QU+yAgv+NSm02fMf1oKbi5C+jAFBaaqaXxpYTOSvT3lz6av99sRRWxz3CucBCZat
6mDgSSacaT2HmqZF40ZlcnLfEsLKUEQWHe8Y1ipMmSfqW8egaRy7UlLeRBSXxAYR
kIPpWJlWeAqA6dtfRYD2/5dmo+j7TuPvMhCfh8z8Qa6i+AEph2nMEVaCeav+09ml
j8Q14ppd0sIJrmyFGRRSFX6NSaVyKmGAPfnPheZl+vcxXjtgXuezt77MDpvL5Q0A
NC2U/n5+Wjb92sSEfzT5wU4qgD8R9UIadz32Pk5L6Gh3iaWtsWkfoj+3/9Dz6zix
Q051sYTq+FprW+WQHKXl52Ok45mG9HzmxPqvA/vtZrPHV7BEeNHwnx6gwin0OxZX
XrKIc+NywsGsMaPPB6nrUm9f4JwHYALCMfj2cwKaURUlIdIAwyQZiJGz30vnyYIj
G6859Eas2Y8X32Pk1sA8rrLNJcKzHw0Zs+45d15kH/PF5SdFORQeqz14fpEuXKH9
KWyogJY0
=P4Vs
-----END PGP SIGNATURE-----

--4vknydsdvtpt7ldd--
