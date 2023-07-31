Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AE2768D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGaHMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGaHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:12:06 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC893A9C;
        Mon, 31 Jul 2023 00:10:00 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230731070956euoutp0264de954025e344e8023c8d24a0917c29~24i3dUT0s1932919329euoutp02Z;
        Mon, 31 Jul 2023 07:09:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230731070956euoutp0264de954025e344e8023c8d24a0917c29~24i3dUT0s1932919329euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690787396;
        bh=qX81sDg++xdwGNh71jssIPoPVeEsZ1ZQdv8PBhFtj1w=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Ouvh6NB+6ieAx9TR0UowL+BAn1puroAicNMoBV/1sNkxmnbS4/GUT03IPjg8UwKc6
         WWpREpMgL5v75eExVFDHng2fgaEUOJQl+sx35Abl0eT9vNiKsegctQaxIchsjTwwKr
         WpMVZDW1v2acCCdPP4o3AEHqkrQELWGjKCKI/lVc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230731070956eucas1p22a25925d1fc61d715147356e560627ba~24i3UC9O00747607476eucas1p2o;
        Mon, 31 Jul 2023 07:09:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7F.B8.42423.44E57C46; Mon, 31
        Jul 2023 08:09:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230731070956eucas1p1b5b3926217569aecd7ab494f4d5f299c~24i236n162856228562eucas1p1m;
        Mon, 31 Jul 2023 07:09:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230731070956eusmtrp2616b9eb8daa0c90fdac641c1353590cc~24i23LieI2095920959eusmtrp2P;
        Mon, 31 Jul 2023 07:09:56 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-1a-64c75e44c43a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.1A.10549.34E57C46; Mon, 31
        Jul 2023 08:09:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230731070955eusmtip2679635c8e71e8a70939fc14c44d47585~24i2qF_Dz2275022750eusmtip2P;
        Mon, 31 Jul 2023 07:09:55 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 31 Jul 2023 08:09:55 +0100
Date:   Mon, 31 Jul 2023 09:09:54 +0200
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
Message-ID: <20230731070954.fb3tez2dsusikwn4@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="xj42hsy674mnn2ti"
Content-Disposition: inline
In-Reply-To: <ZMQF5mN7wWN2eax3@bombadil.infradead.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7djP87ouccdTDJY3SFvMOd/CYvH02CN2
        i/8L8i1+9nFbnOnOtbiwrY/V4tr2u0wWl3fNYbO4MeEpo8WxBWIW306/YbS4tEfF4vePOWwO
        vB6zGy6yeGxZeZPJY8GmUo/NK7Q8br229di0qpPN4+jKtUwe7/ddZfP4vEnO482010wBXFFc
        NimpOZllqUX6dglcGfPvXmIq+CJW0XDsDXsD43uhLkZODgkBE4nVz+eydTFycQgJrGCUmH1p
        H5TzhVGibcUkVgjnM6PEhJ7VTF2MHGAtC97GQcSXM0o8WLaGGa5oxqatUO1bGCVuXZjHCrKE
        RUBVYvKpNSwgNpuAjsT5N3eYQWwRAQ2JfRN6mUAamAWamCUOr/jPBpIQFnCSeDzhClgzr4C5
        xOX2SSwQtqDEyZlPwGxmgQqJpj2XGEFOYhaQllj+jwPE5BQwk9i3zhHiNyWJr296WSHsWolT
        W24xQdiPOCVundCCeMZFovdJJERYWOLV8S3sELaMxP+d88EukxCYzCix/98HdghnNaPEssav
        UIOsJVquPIHqcJQ407ODFWIon8SNt4IQV/JJTNo2nRkizCvR0QYNdjWJ1ffesExgVJ6F5K9Z
        SP6ahfAXRFhHYsHuT2wYwtoSyxa+ZoawbSXWrXvPsoCRfRWjeGppcW56arFhXmq5XnFibnFp
        Xrpecn7uJkZgmjz97/inHYxzX33UO8TIxMF4iFEFqPnRhtUXGKVY8vLzUpVEeE8FHEoR4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwDSVueS6dW2ki8HM
        fOP54a1X+ZTn8dTe/Hj+XEe0Qog3z9cZqfUHd2xOr6+dWZsn+dX7nrivQH2n3OXTX/tiXfaz
        b16TZdsiycMY2mjluiwnqUzqyJm9OSExTyx8w8ssbV+bBH7y/aP8yixgop/kdI16dgGuhoQj
        py7+NsoQ3+PO0jlzfaTRBFedSeqbDKwVL87pVZmoOmVu5inVjdZfUgUiuTZsMFgZpaipuPIJ
        qwCbv73H/mN9MVpWq9nXNkllVLtOeNy8NiUt+VSfub9IQo/1poZnrI1SFqG/zT3eXzwn7b8g
        S7bz+o2bHy9ZuN2fdj/4SlHM+xD7bfp7tpf3mH7/9n/3rphl3TEPrC2VWIozEg21mIuKEwEl
        gqUXDgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xe7rOccdTDCadtrGYc76FxeLpsUfs
        Fv8X5Fv87OO2ONOda3FhWx+rxbXtd5ksLu+aw2ZxY8JTRotjC8Qsvp1+w2hxaY+Kxe8fc9gc
        eD1mN1xk8diy8iaTx4JNpR6bV2h53Hpt67FpVSebx9GVa5k83u+7yubxeZOcx5tpr5kCuKL0
        bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mq6cuctc
        8EmsYtaRl4wNjG+Fuhg5OCQETCQWvI3rYuTiEBJYyijxbMU29i5GTqC4jMTGL1dZIWxhiT/X
        utggij4ySsx6vJ8FJCEksIVR4u9dGRCbRUBVYvKpNWBxNgEdifNv7jCD2CICGhL7JvQygTQz
        CzQxSxxe8Z8NJCEs4CTxeMIVsA28AuYSl9snsUBsWMYssaOzjx0iIShxcuYTsKnMAmUSe7f+
        ZgE5m1lAWmL5Pw4Qk1PATGLfOkeIQ5Ukvr7phTq6VuLz32eMExiFZyEZNAvJoFkIgyDCWhI3
        /r1kwhDWlli28DUzhG0rsW7de5YFjOyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxApPFtmM/
        N+9gnPfqo94hRiYOxkOMKkCdjzasvsAoxZKXn5eqJMJ7KuBQihBvSmJlVWpRfnxRaU5q8SFG
        U2AoTmSWEk3OB6axvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkG
        JpeOjzcXzJT9oXPjo2qUvlrEh+WN//liZyWm5p55YfRw0vW1PjMLAvOncUp8kr3m5nH1tqZT
        fltOUEvHzcqCTdfeCEzJ6uduX3BzW/D5JcmpeVo+/iyL61NvmpfL+Zq9nPDjjb/1vGre9s/C
        3WFfTuXPlLrikVrJd/mZamH98cSp4bJVne9Z7jf4sEX1nP1VWB6e7HX7wMRJziqPixeqMkwN
        iaySzRbfUqTvOklq0+lzmWcyr2rsF7FQZr5esY3hUk/wBv24ipvq657GqXpV8nu21p5KXPvy
        Jnvfwdl2yXOnO3+2jOCbuKd27sv2expyG+5svPopZP4v+yUniyOVrzJHvhI8zqh0OvRcx14x
        JZbijERDLeai4kQACBclEqsDAAA=
X-CMS-MailID: 20230731070956eucas1p1b5b3926217569aecd7ab494f4d5f299c
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
        <20230728073536.egpe6to3s3pndi6r@localhost>
        <ZMQF5mN7wWN2eax3@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xj42hsy674mnn2ti
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 11:16:06AM -0700, Luis Chamberlain wrote:
> On Fri, Jul 28, 2023 at 09:35:36AM +0200, Joel Granados wrote:
> > On Thu, Jul 27, 2023 at 08:44:24AM -0700, Luis Chamberlain wrote:
> > > On Thu, Jul 27, 2023 at 02:31:12PM +0200, Joel Granados wrote:
> > > > There are no deltas in this patch set. We start seeing the deltas w=
hen
> > > > we start removing with the next 6 chunks. I'll try to make that more
> > > > clear in the commit message.
> > >=20
> > > Indeed, even if no deltas are created it is importan then to say that.
> > > If there are no deltas the "why" becomes more important. If the why is
> > > to make it easier to apply subsequent patches, that must be said. When
> > yes. The why for this patch set in particular is to make it easier to
> > apply the sentinel removal patches.
> >=20
> > I think the difficulty for me comes from having two whys: 1. The one for
> > this patch set which is to make it easier to apply sentinel removal pat=
ches. And 2.
> > The one for the "big" patch (that actually removes the sentinels) which=
 is to
> > reduce build time size and run time memory bloat.
>=20
> The 2) is part of the real why, 1) is more of how to do 2) cleanly. But
> the real why is the savings in memory because we are moving arrays out
> of kernel/sysctl.c so we don't want to incur a size penalty. The
> collateral to avoid increasing size in the moves also proves to save us
> more memory overall, on the ballpark of about 64 bytes per array in the
> kernel both at runtime and build time. The build time gain is mostly
> on the __init stuff and so gets freed right away, but since sysctl
> code always kzallocs the arrays passed we also save 64 bytes per array
> in the end at runtime.
Yes. In my new version I have tried to mention both 1 and 2 and
differentiate between them. I stuck with the "why" for this patch set is
to make it easier to reach 2.

I'll send it out today.
>=20
>   Luis

--=20

Joel Granados

--xj42hsy674mnn2ti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTHXkIACgkQupfNUreW
QU+2Agv/Z16D0X3qBhPZAkn8ZBVq8+Mws95QU+VZQyb969rZ8jqAtsiVDgbyVdJm
dKzk9Ilvi217UQLNxkwlXoXtQeChp6nXFdiO6rgIDuFKQueqwtoKnMd7iCWv3DKR
wPtLV5j9d88jt/UkFeHvxqSOXtn4NN3/SYEHG6avS9JVCl4W6P6SHBKc/VLmDvu2
KfQZL/qSJAB+BRtWynu+BJEZlw0+TD6/2D5SBJeQdhuTSMkldbwVfYWdKhzPks83
8wypFtm2l3EqZstUtPC/ainbqzVBcfPXryG/ekJkBReSEH+CHrhCo9MCQYRylL9+
Tara17WEHsgTi2fR5MAFdmAOx5QmpYtf/Swdu5u2Ytu4PkkPqtqeqFrWyvBQDQlJ
RuC/ofKYKFrmxmY4EQ9vvTV7fnoMGHPyJbS+KBeO0NsrfV5qKCXGPufaypTgruK9
9mhbJhg4++EBHT1sy7Mf1o2oxJb/ZjeVMrBkAOm0qjhw7TMSnXKmD9k6/le4qn8l
RA39uFUH
=vkUq
-----END PGP SIGNATURE-----

--xj42hsy674mnn2ti--
