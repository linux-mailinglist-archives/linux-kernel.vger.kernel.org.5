Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716CA75F354
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGXKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGXKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:30:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91138199C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:29:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E886B320091C;
        Mon, 24 Jul 2023 06:29:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 24 Jul 2023 06:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690194564; x=1690280964; bh=bRwBeznDm7R257YGjVw6nEKDUe4UcUMR/8q
        E2bCz4vc=; b=GX2ZDMvAXgehf2SahEhgC/O4Cd/11DUqRB4BEwVtVLEZHRQCz7w
        wuARVsCq8jmdpJlCVBWu5P7fUuD96g2XeAkF2GvVafQdE0cv3QK9LCje/B26nQtL
        pKN9mhe0XnYsOn014yTIxaSLoq4tiCuQ07xB01LaoGh73DrH4EERYU3Ko9gzqqKw
        vPyZOdhqANRpVSRyRvLVkVac6PR1amCUJq35F/R8JBNJkW/go21J0YI6pnpw9n/Z
        F1ykGw3cWq56UqrXOWHgubhaBaLXAo4zkkA2H7JmBtVopZVlH/REGPr//C+LEO8M
        JMZzaY/Zj6yZ1WeMFcWPDRcaD/ToWgvxV2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690194564; x=1690280964; bh=bRwBeznDm7R25
        7YGjVw6nEKDUe4UcUMR/8qE2bCz4vc=; b=0CY6hNqRUvzNjyEMbdOXDFJN71QjD
        zHNksNkVVRhUKnrLsRJKzBMJz0ILMbDRbhoNyOO0xahVyXHkWRPGhkVuS1pNjDRR
        oC69Pg8F0xw3N9tj0/rirn8oDhlcWusRNmWh83m90FPEeDrUX8zyeyAMKuTbc8BM
        csz3gosk7BvwGrrwWmDsrLx5/plVTCt7fJyKOEBHWcro5YRr6Xwm6jG0Nqwe5DGy
        71KYbSfuPHKVLnQh53Vel+tfBYFHfRDIsHz5+heGJ4AvYQ8LO4IrG96SobEQyd+A
        KO3p+DK2Q1It9YjgvQEyc0JhAzrPAaVT6TUA787bejxWxL5BAI7Ls4tXw==
X-ME-Sender: <xms:hFK-ZJdW_kEmBIRp34dLp2PaFRsTyUE2Aqmmg0rUQgN4MvbARAhcoA>
    <xme:hFK-ZHOkQKhp5cXxmcEcjSypAtZyfpvLsE92Q2fpCFVeg2SlRhuC0svD2F-be_j_E
    -MoJImGz0FBHBs>
X-ME-Received: <xmr:hFK-ZCivqQKrO8-vov09bJFYDsxkQfvwm099ZaVIbX8853-f50PQo2Mf_sI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffgguffvvehfhfgjtgesghdtreertddtjeenucfhrhhomhepufhimhhonhcu
    ifgrihhsvghruceoshhimhhonhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeftdefudeltdevhfehkeefhfeutdfhffdugeetffdv
    gfehfeekhfetgedvuefggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhimhhonhesihhn
    vhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:hFK-ZC_wYAPQOYH8iG3S8VnC9ffRLxMQug32483z2RCe668YzirbVg>
    <xmx:hFK-ZFtCqPEDnnycVZD5lGXgb2lWyRTElQlL6ZalwWYKSiOlZoIc9w>
    <xmx:hFK-ZBGfDKcvYyx1gKKQWOOWqS_PNVNgfOIJJjHnSufWL_0vd9IPgQ>
    <xmx:hFK-ZO4f2YDJBVI2IDvm-n7MwbP17-4TznU9uvB_qEju_qR-xcRIJQ>
Feedback-ID: idc5945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jul 2023 06:29:22 -0400 (EDT)
Message-ID: <81ca146e-986c-b934-3567-2e1267a31ad7@invisiblethingslab.com>
Date:   Mon, 24 Jul 2023 12:29:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] xen/events: Add wakeup support to xen-pirq
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20230313134102.3157-1-simon@invisiblethingslab.com>
From:   Simon Gaiser <simon@invisiblethingslab.com>
In-Reply-To: <20230313134102.3157-1-simon@invisiblethingslab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Hf0VWW22SHCK1Z6ZaG9MPeYj"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Hf0VWW22SHCK1Z6ZaG9MPeYj
Content-Type: multipart/mixed; boundary="------------NM7xgrV6rptQJ4hiPTQm8Yjd";
 protected-headers="v1"
From: Simon Gaiser <simon@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <81ca146e-986c-b934-3567-2e1267a31ad7@invisiblethingslab.com>
Subject: Re: [PATCH] xen/events: Add wakeup support to xen-pirq
References: <20230313134102.3157-1-simon@invisiblethingslab.com>
In-Reply-To: <20230313134102.3157-1-simon@invisiblethingslab.com>

--------------NM7xgrV6rptQJ4hiPTQm8Yjd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Simon Gaiser:
> This allows entering and exiting s2idle. Actual S0ix residency is
> another topic [1].
>=20
> Without this the ACPI code currently ignores the error enable_irq_wake(=
)
> returns when being used on a xen-pirq and the system goes to idle for
> ever since the wakeup IRQ doesn't gets enabled. With [2] the error is
> handled and the system refuses to go to s2idle.
>=20
> Link: https://lore.kernel.org/xen-devel/9051e484-b128-715a-9253-48af8e4=
7bb9d@invisiblethingslab.com/ # [1]
> Link: https://lore.kernel.org/linux-acpi/20230313125344.2893-1-simon@in=
visiblethingslab.com/ # [2]
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> ---
>=20
> While I think that the set of flags I set is correct, I'm not familiar
> with that code, so please pay special attention during review if they
> are actually correct for xen-pirq.
>=20
>  drivers/xen/events/events_base.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/even=
ts_base.c
> index c7715f8bd452..991082f04f05 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -2176,6 +2176,10 @@ static struct irq_chip xen_pirq_chip __read_most=
ly =3D {
>  	.irq_set_affinity	=3D set_affinity_irq,
> =20
>  	.irq_retrigger		=3D retrigger_dynirq,
> +
> +	.flags                  =3D IRQCHIP_SKIP_SET_WAKE |
> +				  IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND |
> +				  IRQCHIP_MASK_ON_SUSPEND,
>  };
> =20
>  static struct irq_chip xen_percpu_chip __read_mostly =3D {
ping

--------------NM7xgrV6rptQJ4hiPTQm8Yjd--

--------------Hf0VWW22SHCK1Z6ZaG9MPeYj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAmS+UncACgkQkO9xfO/x
ly9H4w/9H6fMRreUIMniGKL0lM56B1kdKr6WGIfsRP979zHetmBSz0dKKcjJ7e5b
M+ljI+bNMocw/Pq4ph6EKLtrkCjsfH51+44EnZJmDgONbF5kZbxOZc1/YB+WHmWm
qr1eRhq6p7ORtCCRiHdc2Rpr72HMoxc+YDNLhfxdF10j3CVI2jShuEp/hf46zZnM
T3JSVXd1boQo09O2pt6Ka7BjbblfINJ0wT6zNdyhOeBEZMDI5siFP6cddKf+nrAo
2m7CYP7Njgr0IALV1OC4NC39s+qEx7uNzBTVSLJkBpYvyvKC6XfHyJavyaY40MA7
iyeA8hjq6IWCsZ67OcjAokF06ox0xr4ll7H8kx7QAZSwtSTbC+gK4zBgPn/DBAD1
NWj8qHhxFl3oEb/KBZXTg+0JuABbU7ARk/JZhZxR62WZU2hwHMzUViy1hzUvOzty
b1rzZTi3SsSmTaxZOr/vEHBkdde0FYQpLRowLs0v0uUvYB227Ey/HNxr0DJCC6CJ
WhcArncJhkRV+A5kYy47iLJeDMQTElGCRNm1Anm42BMo475b2GT2CWcw0Spnhnnl
pqGSfJISZTQ2HdZmcwFOzDnwBpTcByYsBI5ou5m2/JfRx5UWNGcsxRQaXSAp5IQ4
QelAecD+Fh6LNjnWn3AXXDhBL3o40A+upI4T1prOr74lPjYZudI=
=hLGI
-----END PGP SIGNATURE-----

--------------Hf0VWW22SHCK1Z6ZaG9MPeYj--
