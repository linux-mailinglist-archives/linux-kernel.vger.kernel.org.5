Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FBA7C6A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377774AbjJLKJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377780AbjJLKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:09:19 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC6FBB;
        Thu, 12 Oct 2023 03:09:12 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231012100909euoutp016ea11b911d2c6c5671ae630727e1725c~NVFL7ZROb2714027140euoutp01R;
        Thu, 12 Oct 2023 10:09:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231012100909euoutp016ea11b911d2c6c5671ae630727e1725c~NVFL7ZROb2714027140euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697105350;
        bh=6v49dC8AAIWBFHKCsEEGE1cKwiObfLEvGAhTZjQDX/c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=tsFjf1iHOSDy5Immeay1gLcQ1HcV6w2+YtSOp2xtiahDMItX7vu0nGYxTdliVu5Cd
         I1t0qvFt4Tb9i/EjqJObloZa6IrfWLu3ZiHW6fVlAZUF5cqhxmjesQMOwEWjiOXmR7
         ElUblAyhQdHrkESCM66zBF37Z1oswNAjx0go0VVo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231012100909eucas1p16b0b4761acdd2396e35dd717348315c0~NVFLox5Pv0300803008eucas1p1E;
        Thu, 12 Oct 2023 10:09:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D3.C3.37758.5C5C7256; Thu, 12
        Oct 2023 11:09:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231012100909eucas1p25d5d7cf1c43c0f3d2c0c41554f7d3e50~NVFLPQ6ID2320123201eucas1p2E;
        Thu, 12 Oct 2023 10:09:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231012100909eusmtrp2badf23b4b09bab372a513a3b36759f61~NVFLOvEui0846208462eusmtrp2D;
        Thu, 12 Oct 2023 10:09:09 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-ad-6527c5c5d311
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.4E.25043.5C5C7256; Thu, 12
        Oct 2023 11:09:09 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231012100909eusmtip17cdbbf5f0abdb191d88aa29aa2e454c1~NVFLEMxNA0573605736eusmtip1T;
        Thu, 12 Oct 2023 10:09:09 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 12 Oct 2023 11:09:08 +0100
Date:   Thu, 12 Oct 2023 12:09:07 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the sysctl tree
Message-ID: <20231012100907.52wjhbcputj2dsrf@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="izdyxgdhjaaezjvi"
Content-Disposition: inline
In-Reply-To: <ZSb0oRABk03KOTKU@bombadil.infradead.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87pHj6qnGvSvVbFYfbefzeLyrjls
        FgcXtjFa3JjwlNFi6jI9i617r7I7sHk03rjB5nH5bKnHplWdbB4Pdm9g8fi8SS6ANYrLJiU1
        J7MstUjfLoEro+PuYbaCyfwVLd92MTcwPuHpYuTkkBAwkfhxbyp7FyMXh5DACkaJtmPbmCCc
        L4wSDxY3sUE4nxklViz4wNjFyAHWMuuWHUR8OVB8wx2EojOTtjKDzBUS2MIosfqQKojNIqAq
        saa/mxHEZhPQkTj/5g5YjYiAhsS+Cb1MIDazwHNGieY1hiC2sIC1xPILfSwgNq+AucSS/cuh
        bEGJkzOfsEDUV0ic7b/OBnIQs4C0xPJ/HCBhTgEziS0NLxkhXlOS+PqmlxXCrpVYe+wM2JsS
        Av2cErsaH0I94yLxbGYFRI2wxKvjW9ghbBmJ/zvnM0HUT2aU2P/vA1TzakaJZY1fmSCqrCVa
        rjyB6nCU2LwcxAYZyidx460gxJ18EpO2TWeGCPNKdLQJQVSrSay+94ZlAqPyLCSfzULy2SyE
        zyDCOhILdn/CFNaWWLbwNTOEbSuxbt17lgWM7KsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNz
        NzECU9fpf8e/7mBc8eqj3iFGJg7GQ4wqQM2PNqy+wCjFkpefl6okwvsoUyVViDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1Oqgan3w5pK9oeS7iueCM0R+iWj
        9f+TePOBn6+mcMY2GTw8svJs+uHrWatepa8KnHvjapPZK4Z/z8z7fFmXrNS2knPdGy+o+FN+
        AdPLw5oH/zS4Hdw/38yrrKlzq9aPrmNJOzS6bW21azcyvw4SmCXEPflny8FDc04LzFn1buPG
        cIGYBWJ/vbacYDpVkaWndEPrldALuQsH5z+6lKl/S61Gge+5bPgxRhnl+LWTogwUJ5TWzbmS
        /vpDvueZRQ8e/Ct4dkzHtdJsR87lsyYLSj0M7vYrt2zll/90MPg2q2GEacKpZe06Qj/fbLh9
        941x7ZcP35bHpBSVZQTLuU5dO3cK0zmnyKnTNO8tFMl1tvM684FZiaU4I9FQi7moOBEAry0T
        pNgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xu7pHj6qnGvxYxmmx+m4/m8XlXXPY
        LA4ubGO0uDHhKaPF1GV6Flv3XmV3YPNovHGDzePy2VKPTas62Twe7N7A4vF5k1wAa5SeTVF+
        aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRldrJ2vBRP6K
        Dz/WsjcwPuLpYuTgkBAwkZh1y66LkYtDSGApo8TmXd1MXYycQHEZiY1frrJC2MISf651sUEU
        fWSUmPrgDAuEs4VR4vXqeWwgVSwCqhJr+rsZQWw2AR2J82/uMIPYIgIaEvsm9IJNZRZ4zijR
        vMYQxBYWsJZYfqGPBcTmFTCXWLJ/OZgtJPCEUeLQmmKIuKDEyZlPWEAuZRYok/i00QvClJZY
        /o8DpIJTwExiS8NLRog7lSS+vumFurlW4tX93YwTGIVnIRk0C2HQLIRBs8BO05K48e8lE4aw
        tsSyha+ZIWxbiXXr3rMsYGRfxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERi924793LKDceWr
        j3qHGJk4GA8xqgB1Ptqw+gKjFEtefl6qkgjvo0yVVCHelMTKqtSi/Pii0pzU4kOMpsAgnMgs
        JZqcD0wreSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTBo2/JcF
        N3A/4OTS53Sf2Fq8Nu6m/qcdHz/+9FNvCp55wUCZqf3X0llR6/cE/nTdo7u72mJ5qbpiRF2f
        guB9lyPs856da9vxbMWt2V9F+A57H5i0aPJWu7z6n3mcBcnVHLu2G3b9rVsn/bP0lN+VEze/
        yd44cNtYsqI4hbH68uybkZYKTcv+fjgV0jvptWP+7yP8PwqCshN2+6z7KnqSvV//ycazdUaL
        fskJq/9mZlY3W27xfOJGx+KD81ZbOz/Zq/LZwytaa9lftomVAgnP42LOR98LUQuO8C1cEP1d
        RlOxysRMRds/ZF1QhKnR0ia5s+5hYo2GOp/4+ab9Oen9QMlVz/X60cWr5Patu+h1VomlOCPR
        UIu5qDgRAOLF2bZzAwAA
X-CMS-MailID: 20231012100909eucas1p25d5d7cf1c43c0f3d2c0c41554f7d3e50
X-Msg-Generator: CA
X-RootMTR: 20231011052057eucas1p2876288636c2eaaf61a36985cffb29f8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231011052057eucas1p2876288636c2eaaf61a36985cffb29f8e
References: <CGME20231011052057eucas1p2876288636c2eaaf61a36985cffb29f8e@eucas1p2.samsung.com>
        <20231011162050.773ebb15@canb.auug.org.au>
        <20231011083612.4hymwsvc43hrwm6h@localhost>
        <ZSb0oRABk03KOTKU@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--izdyxgdhjaaezjvi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 12:16:49PM -0700, Luis Chamberlain wrote:
> On Wed, Oct 11, 2023 at 10:36:12AM +0200, Joel Granados wrote:
> > On Wed, Oct 11, 2023 at 04:20:50PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > The following commit is also in the block tree as a different commit
> > > (but the same patch):
> > >=20
> > >   80f3c6cfab37 ("cdrom: Remove now superfluous sentinel element from =
ctl_table array")
> > >=20
> > > This is commit
> > >=20
> > >   114b0ff62a65 ("cdrom: Remove now superfluous sentinel element from =
ctl_table array")
> > >=20
> > > in the block tree.
> > Is this a warning on the merge? or did it actually error out? if it is a
> > wraning and one of the two was skipped, it can be safely ignored as they
> > are the same. I can also remove that commit from my set and send another
> > version. @luis: How do you want to handle it?
>=20
> I just removed the cdrom patch from my tree.
perfect thx.

>=20
>   Luis

--=20

Joel Granados

--izdyxgdhjaaezjvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmUnxcIACgkQupfNUreW
QU+RQwv/QtEtkcnVUMKCVkebiR8vY1GdSf7Kkrwlv0v21L37qyjiL5rF1pxfNCa4
QFGTprUmfiuHJxmRdGKKx/n+a3iE7nvUsniS4Lmwllba3rbJf0yX2nU9HSYhs9dp
nLIofsu9JEKPCqQeIF5Ihsg+7ApE3P3EaFwr2R+ouKx93v3aOOqYcIlbtftm4jGk
6SX2hxUUpPFrlpimVOALuJ5RAgi6thtb6GWt8UjXwuXzFYN1h4atx48W3dZ8eyhi
mC1P+px8i+dpyarX/9B5+etivk0hexD8eC5AZCQaKTfXK5s4J4S0sTe7VnyuSGnB
KixlB7BWEkD+TDVGJNE2NA0UAu+gDfTPE9a4i7YxeRC2veFaoK8D9SAT/JWloM4t
HwCXnS0AwpDJ3RYzq+v4AEIC1OTdXlF/6NLYgL1JrDaRFmRE4tRVwSVIbOi2n6Kc
QGbVJMoMbDhqB1wBuKAdCOGoiH0aMWkwDCEjU1Yv6zYNIgFpc1YVqbclGapuBJS+
jE3Vx7tn
=FRB1
-----END PGP SIGNATURE-----

--izdyxgdhjaaezjvi--
