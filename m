Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A9766570
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjG1Hfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjG1Hfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:35:43 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF772D5B;
        Fri, 28 Jul 2023 00:35:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230728073539euoutp024ce08c88b937ef44594e48c547dec293~199dW91ly3106331063euoutp02F;
        Fri, 28 Jul 2023 07:35:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230728073539euoutp024ce08c88b937ef44594e48c547dec293~199dW91ly3106331063euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690529739;
        bh=jUzBfACVBE6PRXtosK5veJt2pcwU2AhBbGaNBCP0R8M=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=biG7FzOrlqlayuOGUKkhLs3BBNP5YHjKHrq9ooM+zrk0GJXPK/CPusfD6PUt0dN6j
         /7dgKeZ9rgRyvumFU2WK3Z8qz8AKHt+oCXLg0iC17CBw26xOPT/e23Rs32SdwKSuNu
         q8C5scIIXExYnuSYwIn3pKM5+QNgGQ//+dweL7pk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230728073539eucas1p1decf1bbfd5d886005ea3252b6f8e2652~199dJor031741017410eucas1p1o;
        Fri, 28 Jul 2023 07:35:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 50.B0.37758.BCF63C46; Fri, 28
        Jul 2023 08:35:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230728073538eucas1p2982d41e7680ab7c3864e41aafab811e5~199c0NyvD2749527495eucas1p2U;
        Fri, 28 Jul 2023 07:35:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230728073538eusmtrp227449068ccd63271a22a314a291265a8~199czmarN0886108861eusmtrp2n;
        Fri, 28 Jul 2023 07:35:38 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-1d-64c36fcb28c2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.2B.10549.ACF63C46; Fri, 28
        Jul 2023 08:35:38 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230728073538eusmtip12c211f8d94a72e1b9053d1e713e8076d~199cncDM92884028840eusmtip1U;
        Fri, 28 Jul 2023 07:35:38 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 28 Jul 2023 08:35:37 +0100
Date:   Fri, 28 Jul 2023 09:35:36 +0200
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
Message-ID: <20230728073536.egpe6to3s3pndi6r@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="qapdrkzqpsgeioz3"
Content-Disposition: inline
In-Reply-To: <ZMKQ2OuFy1deZktP@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7djP87qn8w+nGLy9wmox53wLi8XTY4/Y
        Lf4vyLf42cdtcaY71+LCtj5Wi2vb7zJZXN41h83ixoSnjBbHFohZfDv9htHi0h4Vi98/5rA5
        8HrMbrjI4rFl5U0mjwWbSj02r9DyuPXa1mPTqk42j6Mr1zJ5vN93lc3j8yY5jzfTXjMFcEVx
        2aSk5mSWpRbp2yVwZfTu3sFY8E6w4tL1D8wNjC38XYycHBICJhILZl1jArGFBFYwSmxY5tjF
        yAVkf2GU+DCxhwnC+cwo8WTGF3aYjnVL+6ESyxklHk56zQhXda15MxuEs5VR4mLnJzaQFhYB
        VYlbyw6BLWET0JE4/+YOM4gtIqAhsW9CL9goZoEmZonDK/6DNQgLOEk8nnCFFcTmFTCXaGz6
        xghhC0qcnPmEpYuRA6ihQuLuA3cIU1pi+T8OEJNTwEyie7swxKHKEgeX/IY6ulbi1JZbYJsk
        BO5xSpxqXcIGkXCR6DiygBHCFpZ4dXwLVIOMxP+d86EaJjNK7P/3gR3CWc0osazxKxNElbVE
        y5UnUB2OEmd6drCCXCEhwCdx460gSJgZyJy0bTozRJhXoqNNCKJaTWL1vTcsExiVZyF5bBbC
        Y7MQHpsFNkdHYsHuT2wYwtoSyxa+ZoawbSXWrXvPsoCRfRWjeGppcW56arFxXmq5XnFibnFp
        Xrpecn7uJkZgmjz97/jXHYwrXn3UO8TIxMF4iFEFqPnRhtUXGKVY8vLzUpVEeE8FHEoR4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwJS94fCGmg2C4o61
        jx0UjhkfE7SOrBQR469vnjvlnt1eHYOpp2by1cj3Bfy3jo2KiIrgclRQW9Iw7a+pG1/Vv8zy
        NJHc2F6LPoOPV1OPP+tNaJj1NWRiPpOx41SvbOFpRdcCr69R7/GLWzBfidXz9gXVvQ1zFz/r
        3qibvta89/cluziFmJ/TVFd5bHgXwST99J+3370+Qd+G6UqdsfMmaC+1SzJP7170kdXA0/zg
        4q1eolf9NUpevKm9zuHldf3Qp8PLQwV6zz6a4HdJr8KcVbfDcu3JOrt9NRMPRvZOlpm9dfrD
        uORPl1sEvHmK3zV9+F2s35uo//6TdsmZ4PQmu9M57dmyE63s5NZ8faqtxFKckWioxVxUnAgA
        0RJrZQ4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xu7qn8g+nGBzs1bGYc76FxeLpsUfs
        Fv8X5Fv87OO2ONOda3FhWx+rxbXtd5ksLu+aw2ZxY8JTRotjC8Qsvp1+w2hxaY+Kxe8fc9gc
        eD1mN1xk8diy8iaTx4JNpR6bV2h53Hpt67FpVSebx9GVa5k83u+7yubxeZOcx5tpr5kCuKL0
        bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MnY33WIp
        eCNYMfP9FfYGxib+LkZODgkBE4l1S/uZQGwhgaWMEu//xkLEZSQ2frnKCmELS/y51sXWxcgF
        VPORUeLo6S/MEM5WRolVk/eDVbEIqErcWnYIbBKbgI7E+Td3mEFsEQENiX0TeplAGpgFmpgl
        Dq/4zwaSEBZwkng84QpYM6+AuURj0zdGiKlnmCQmrZ3ABJEQlDg58wkLiM0sUCbxvnEF0FQO
        IFtaYvk/DhCTU8BMonu7MMSlyhIHl/xmh7BrJT7/fcY4gVF4FpJBs5AMmoUwCCKsJXHj30sm
        DGFtiWULXzND2LYS69a9Z1nAyL6KUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMF1sO/Zz8w7G
        ea8+6h1iZOJgPMSoAtT5aMPqC4xSLHn5ealKIrynAg6lCPGmJFZWpRblxxeV5qQWH2I0BYbi
        RGYp0eR8YCLLK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgso5e
        xu7PlfglM2nB66VfRT8kvJwWuPjWodKFyiKXWCU0r3PO1VaocFpWs9hBk3XC2kUfn/28cbUj
        5UuIFLOD8IxegwrtCc2f+sV/uNxkOzzhcmliYIlusveHyLkFJ8onHU3lirrIOC088bmhqqqL
        hqjLy6jpjNxbhe8JXrD6OWN23CP2Ob9Psky7af3KSt3RK/nEac0514tknb9vT1I/Na/FbVlH
        T1Jw49cp3x25pA5suHTM4KbWmSMvHr3Q/ae9sOtM+h2X4s7FH2rfavvwJ69tqHaJq6wX/zm/
        9OGnG2wt5vIb19TOmbGqYI5sWYXp2VM/NszdvDPgoMqMR/X/nli9tdmbGt8n3v4+Z4LrWSWW
        4oxEQy3mouJEAGLzvSKsAwAA
X-CMS-MailID: 20230728073538eucas1p2982d41e7680ab7c3864e41aafab811e5
X-Msg-Generator: CA
X-RootMTR: 20230726140703eucas1p2786577bcc67d5ae434671dac11870c60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140703eucas1p2786577bcc67d5ae434671dac11870c60
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140703eucas1p2786577bcc67d5ae434671dac11870c60@eucas1p2.samsung.com>
        <20230726140635.2059334-10-j.granados@samsung.com>
        <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
        <20230727123112.yhgbxrhznrp6r3jt@localhost>
        <ZMKQ2OuFy1deZktP@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--qapdrkzqpsgeioz3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 08:44:24AM -0700, Luis Chamberlain wrote:
> On Thu, Jul 27, 2023 at 02:31:12PM +0200, Joel Granados wrote:
> > There are no deltas in this patch set. We start seeing the deltas when
> > we start removing with the next 6 chunks. I'll try to make that more
> > clear in the commit message.
>=20
> Indeed, even if no deltas are created it is importan then to say that.
> If there are no deltas the "why" becomes more important. If the why is
> to make it easier to apply subsequent patches, that must be said. When
yes. The why for this patch set in particular is to make it easier to
apply the sentinel removal patches.

I think the difficulty for me comes from having two whys: 1. The one for
this patch set which is to make it easier to apply sentinel removal patches=
=2E And 2.
The one for the "big" patch (that actually removes the sentinels) which is =
to
reduce build time size and run time memory bloat.

> you iterate your new series try to review the patches as if you were not
> the person submitting them, and try to think of ways to make it easier
> for the patch reviewer to do less work. The less work and easier patch
> review is the better for them.
Ack. For all these commits I'll try to weave in the two Whys to make the
review process a bit easier.

>=20
>   Luis

--=20

Joel Granados

--qapdrkzqpsgeioz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTDb8YACgkQupfNUreW
QU+p5Qv+Ny6GD1gN48hVrnGHM/gw/gd6W0YawMBGaag+E9wch++MavDe3IrOjoGY
KUr3UrXl0hkqH2lCYK0jfELRuRzahODuBPAcsxZuyBAn+DdcxOevc40IIWCBl10r
TMrvkJeXEWCe///Jzj61eRQnG6XKCZ0CkoUS+jsA2Gnc9SqExhp1cxT/hqTcg+4G
O3lMTR13FxIO1yx1/qMWGMTm2lAJStVksJRhteW9oCKN3yIlp3dtSDi+OgzLYscN
4u2MtE5BEFDTRRCu4JNZ6AzmBA6IyyYDN5LxZ+gh1rIzWiJBzmfB3Jfayaff00ba
j9UmqKJmuMKTsJHJVKTNoeuXj/6kgdWO86NWbiA/wPenp8c7K/SFpQD9a7p33pPY
A3fQknP0dtjXjJk9oY7czXgsM+o9lfzp7RgeGwb0c44VC2npK4boBpvgW3106bbJ
gIuQgu+NyIgEKU2ugZxKXeJYa67pRuuuPde0zajzM/W9dzJP3n279THPrODfbN+q
S++x+6T7
=D9gN
-----END PGP SIGNATURE-----

--qapdrkzqpsgeioz3--
