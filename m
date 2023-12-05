Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEB804BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbjLEIBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:01:08 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5C83
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1701763273;
        bh=LEyxd27Gk0XOwyve4QrIliQ4+SQaDw1WzHmLAk3h3o0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E5x50bwjlWEAkvr65z9O0U24b5VdvGh320kknztpO+68TusDhIA/nYIbetYtIsjtE
         lNXkIMkhCr6MER94LALdRs0J09FyWoagBDuL13hzP5IdqWoK9HAEMTZHQygr3UVxDJ
         1ePp22C5rOWcyREWuaq8bUWaNak0tsCo3eVRhZSc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id CD1C166C44;
        Tue,  5 Dec 2023 03:01:12 -0500 (EST)
Message-ID: <369bce8101f2db6685c0e2446976eb7ea16510eb.camel@xry111.site>
Subject: Ping: [PATCH] LoongArch: Slightly clean up drdtime
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 05 Dec 2023 16:01:11 +0800
In-Reply-To: <20231126121727.47303-2-xry111@xry111.site>
References: <20231126121727.47303-2-xry111@xry111.site>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Sun, 2023-11-26 at 20:17 +0800, Xi Ruoyao wrote:
> As we are just discarding the stable clock ID, simply write it into
> $zero instead of allocating a temporary register.
>=20
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
> =C2=A0arch/loongarch/include/asm/loongarch.h | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/incl=
ude/asm/loongarch.h
> index 9b4957cefa8a..46366e783c84 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -1098,12 +1098,11 @@
> =C2=A0
> =C2=A0static __always_inline u64 drdtime(void)
> =C2=A0{
> -	int rID =3D 0;
> =C2=A0	u64 val =3D 0;
> =C2=A0
> =C2=A0	__asm__ __volatile__(
> -		"rdtime.d %0, %1 \n\t"
> -		: "=3Dr"(val), "=3Dr"(rID)
> +		"rdtime.d %0, $zero\n\t"
> +		: "=3Dr"(val)
> =C2=A0		:
> =C2=A0		);
> =C2=A0	return val;

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
