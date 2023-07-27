Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37967657D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjG0PiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjG0PiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:38:11 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200CB4;
        Thu, 27 Jul 2023 08:38:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230727153807euoutp019c33f5ec5929d6bfef6d3725ee255188~1w5au0E4A3207632076euoutp01V;
        Thu, 27 Jul 2023 15:38:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230727153807euoutp019c33f5ec5929d6bfef6d3725ee255188~1w5au0E4A3207632076euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690472287;
        bh=STUlWAOlDIA06osjrSwDwcVK8v733Fr4i1T10ZqvEWA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SSINP7uzaRxKDkhWPSy6RDQk9D436+tDoi75XZwGm00gWj1Q5CcOzN3Su3RrYwpuL
         LjACgNON6I5jWY2pJKnMSTDGVZl93rTdm63ruXHjLQR7jW0UmwxDWZCPKf43eu4CIL
         gI173oU9pIVbfZNXkLGWLyWSDyvEj3bDrVlJoZ+U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230727153806eucas1p162af71edd14581e10fb7855caee88257~1w5amGkX40760907609eucas1p1E;
        Thu, 27 Jul 2023 15:38:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D9.69.42423.E5F82C46; Thu, 27
        Jul 2023 16:38:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230727153806eucas1p28cf57ed6e287ad6efbae39c34b32a1b1~1w5Z9pSLl2676626766eucas1p2T;
        Thu, 27 Jul 2023 15:38:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230727153806eusmtrp29465efb34ab5e6407c4e6b2e1e69c582~1w5Z9Cm5g1642016420eusmtrp2Q;
        Thu, 27 Jul 2023 15:38:06 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-c0-64c28f5e0da8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E2.7C.10549.E5F82C46; Thu, 27
        Jul 2023 16:38:06 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230727153806eusmtip23c8f0e8af46c522556060f9d30107412~1w5ZxivrA0442804428eusmtip2N;
        Thu, 27 Jul 2023 15:38:06 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 27 Jul 2023 16:38:05 +0100
Date:   Thu, 27 Jul 2023 17:38:04 +0200
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
Message-ID: <20230727153804.vjsofabjbkkfat25@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="xbxmoit7mrudyotx"
Content-Disposition: inline
In-Reply-To: <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7djP87px/YdSDO7OMLWYc76FxeLpsUfs
        Fv8X5Fv87OO2ONOda3FhWx+rxbXtd5ksLu+aw2ZxY8JTRotjC8Qsvp1+w2hxaY+Kxe8fc9gc
        eD1mN1xk8diy8iaTx4JNpR6bV2h53Hpt67FpVSebx9GVa5k83u+7yubxeZOcx5tpr5kCuKK4
        bFJSczLLUov07RK4MlqmrGYqOMNT0bf6E3sD4xeuLkZODgkBE4kp7zexdjFycQgJrGCUaD/7
        gAXC+cIo8ePQbDaQKiGBz4wSS/+Iw3S8/9XOBlG0nFHi6tKJTBAOUNGHgxPZIZytjBIPVq1j
        BWlhEVCVWHznBzuIzSagI3H+zR1mEFtEQENi34ResG5mgSZmicMr/oPtExZwkng84QpYM6+A
        ucS7lkXMELagxMmZT1hAbGaBCok/m9cADeUAsqUllv/jAAlzCphJ7Hx/ixniVGWJg0t+s0PY
        tRKnttxigrDvcUpMXWoOYbtILF8ymwXCFpZ4dXwLVL2MxP+d88FukxCYzCix/98HdghnNaPE
        ssavUJOsJVquPIHqcJQ407ODFeQgCQE+iRtvBSHu5JOYtG06M0SYV6KjTQiiWk1i9b03LBMY
        lWch+WwWks9mIXwGEdaRWLD7ExuGsLbEsoWvmSFsW4l1696zLGBkX8UonlpanJueWmyYl1qu
        V5yYW1yal66XnJ+7iRGYKk//O/5pB+PcVx/1DjEycTAeYlQBan60YfUFRimWvPy8VCUR3lMB
        h1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MHHU3jTM
        fyig6LVq28eHTbP2p/vF2oqzO8hMjUifsPWgcnlE3u+VwfLX5fakmi6cNstxfbUub/70l0ZZ
        ywvXyLvt+nNn/Yn5E2Xaljo/nOale6a1xvzanLWhNizlJswJ+4NWHI/nn6r0h09n+Zybget/
        T1jOk9NaIW16TXPn8Zqr9TuPlcYk1tcwNXO4JmW5JkWd2VR49eSe8APzTXvT9Xo4l7Dfn1G3
        6qqIz+3sINla6U/vs1OTnv8KX5cT9J5n/qJN5jyrG7tN3Gp5199V221yyaZXcd2ze51ntz59
        eo91nsELm63zXjybJ5UgMqNhK1NMgfxHj0Tu8r3NHo9OePxVVE/I9tn9KplFRKpXQ4mlOCPR
        UIu5qDgRAGF5CkgQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xe7px/YdSDJ6e5bKYc76FxeLpsUfs
        Fv8X5Fv87OO2ONOda3FhWx+rxbXtd5ksLu+aw2ZxY8JTRotjC8Qsvp1+w2hxaY+Kxe8fc9gc
        eD1mN1xk8diy8iaTx4JNpR6bV2h53Hpt67FpVSebx9GVa5k83u+7yubxeZOcx5tpr5kCuKL0
        bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MmZMX8dS
        cIqn4tK8qUwNjJ+4uhg5OSQETCTe/2pn62Lk4hASWMoosej7WzaIhIzExi9XWSFsYYk/17qg
        ij4ySiye95gRwtkK5Hxfzw5SxSKgKrH4zg8wm01AR+L8mzvMILaIgIbEvgm9TCANzAJNzBKH
        V/wHWyEs4CTxeMIVsBW8AuYS71oWMUNM/cQosXx9JxNEQlDi5MwnLCA2s0CZxNJ5O4AaOIBs
        aYnl/zhAwpwCZhI7399ihjhVWeLgkt/sEHatxOe/zxgnMArPQjJpFpJJsxAmQYS1JG78e8mE
        IawtsWzha2YI21Zi3br3LAsY2VcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEpoxtx35u3sE4
        79VHvUOMTByMhxhVgDofbVh9gVGKJS8/L1VJhPdUwKEUId6UxMqq1KL8+KLSnNTiQ4ymwGCc
        yCwlmpwPTGZ5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M3P4b
        u+bLLA3K+iJttZ83ub+13K6ONflTcYaN0MuJkhfkG/dPXHVKtnDfrEQ77saX+jsYcptfqi0r
        V9yuH5GmIFm4c1VH6M2lt6LW5sqfmJpQuCOfWab1/puPWUen37jFnbz73lPm0j19/1tWntv1
        sloqjne9/+4dP29c0fKyNyoUPPi888vFysKJe4Q/nE6cOSX8+PH9Iu42S/ft7PnFPvnZ10Br
        VeUZW9dusPDXzV8TM0/ufMjlji8H6nLkUppUS/569v/KNFYN0grt3pqYFv4+T4U5df6UnvUb
        Ts7k3nqRNyhhe5q71KUn8fN+JU0XsT+8VOKhWrbgfqdEG039VwvqV+eHbDeZPaHr/DkmJZbi
        jERDLeai4kQAvJR+sa4DAAA=
X-CMS-MailID: 20230727153806eucas1p28cf57ed6e287ad6efbae39c34b32a1b1
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

--xbxmoit7mrudyotx
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
> is any delta on size at compile or runtime.
Just to be on the same page:
You mean the specific why for this commit. like for example:
"
We update to register_net_sysctl_sz to prepare for when the ctl_table
array sentinels are removed.
"

right?


>=20
>   Luis

--=20

Joel Granados

--xbxmoit7mrudyotx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTCj1oACgkQupfNUreW
QU/6Wgv/boBnYKcKv0VodcQJqgAMPYJRtOq0N1zq3xjIc3RF64wyLuvxJeS3mouM
FUSKJeEGjApvCTmxWpQ7tqdRjkAh0q3UllWuryh0OhcUmHt5SPlqrA40tv2wIpBk
nWmrjkLCRRdm4sxGdR128kNUGLaeexEYZirEf7I2QzDWkX5Y89eMwlCJ9JETyZ/Y
MsMXPM1/US71pbEuM8GKcWTNKw1Q0yB5TEyjNOfj2W3wjtC1rq7hgMMlE5FcU44a
eCd6TUO8uJ9DaIbHpIysKrMhz7kvgQLZpsaUWaJX/0AZK0T/JETQ+oIkt39CeAfU
w+6xEJsCPqPYZmkYmw508U4rxNgTMvLRjAIJEqkxNeW8tMQ1qtacTcIfNSTpw9Ju
Hb2LamLSN8O0lmOMg1eO/ndyxixv2vg08zpPemlgzYtctC2D5rtIa7j0Jo4QZ1Ia
ZuXaO5oKHr/nU+XR+qpvYSe45gM++EkGdvLcNaE9HPm7ejXgjQ1ZPTKWLtvR6sap
FJTVfQmF
=ZZUn
-----END PGP SIGNATURE-----

--xbxmoit7mrudyotx--
