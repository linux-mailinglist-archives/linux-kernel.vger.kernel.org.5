Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197607C0060
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjJJP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJJP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:28:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0FF99;
        Tue, 10 Oct 2023 08:28:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so10241294a12.3;
        Tue, 10 Oct 2023 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696951726; x=1697556526; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G6ejQKMQhHXkFl4KtoQA7cEqCddO07ycizXIhPaPkg=;
        b=KAVQZiDQZY/gbAQxtAJG3rJcHK8ntSRxBhppOPjd+6kz0b7kTPfDhzd218YBkwznzL
         TZFNxz0e+3IwU2NtEs7Xm4IAy3EJS7zc5+spuCS8ZHyJo5toNT0/xD4At6uCrcgRHKrq
         n0f8AvxBOhAidYK94FBNAYuW/Hs7U5/l6z8T+cq7ES4cRaW/sV1sobp9xgXLNIeazaol
         w994viRuXch+ak7+b7YMrkLUO6R4ks96hbgAL+Mg7AZJnJ+dBsR945YMng7+bV/zYtBb
         9QvnGMOsszJj7tBpB+5wCvHgkX+szr2VJlqELBwJDVAk4BTDyyco8pV8KActSkefABjO
         uoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696951726; x=1697556526;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/G6ejQKMQhHXkFl4KtoQA7cEqCddO07ycizXIhPaPkg=;
        b=V/fMprt8aTi4kXEuaycY3eaT5E+otEtei9BuGlkAp+P67xLhVeIV1awz4FmvmC3PD2
         kEALE+dKpLE4SGEHc8PuXcEKJ9W7xotvR+J/C27pnvmlkOnmWs86xas49mNBbKezIjCL
         kRz6SegGHcAtBt9gWe1xQ99p8UJOlqVYgfzVkMZ1U7cwWHFhVXBcuc5sMCU5QKygBiKp
         rC+tHDe2QuyZ6Zbk9ySch2mys9fjzI4k8lNUZmf0fiu39TwqHP91nx2AoB7Q1R2S1dpm
         ZUGN0K1nKFsHS5Cbp3TG3341J+CElFBn1kE1cuGEXa6AApSRSkRN7GPmL6d5/nV+Fk2t
         hPCw==
X-Gm-Message-State: AOJu0Yz76aAKG8RveeaUCV4fRJqdnKz0asxvwy/02+14JLCZAZcp4NfT
        QYWPDf6du6foZ9D9ZK+XTPg=
X-Google-Smtp-Source: AGHT+IEDkZ2Bbac1OspEoQ14qb4STQ+50PQBxeRkKLlrIzUqPBOnNLqRS1m81/DzBZor6WxgPLiNnA==
X-Received: by 2002:aa7:d88e:0:b0:532:e24d:34f4 with SMTP id u14-20020aa7d88e000000b00532e24d34f4mr15983184edq.39.1696951725720;
        Tue, 10 Oct 2023 08:28:45 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402344800b0053537ad3936sm7811005edc.21.2023.10.10.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:28:45 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:28:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/tegra: Remove surplus else after return
Message-ID: <ZSVtqxTdTuPp7aTf@orome.fritz.box>
References: <20230626143331.640454-1-suijingfeng@loongson.cn>
 <20230626143331.640454-2-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jzKm22+bkF0mQ8Ka"
Content-Disposition: inline
In-Reply-To: <20230626143331.640454-2-suijingfeng@loongson.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jzKm22+bkF0mQ8Ka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 10:33:31PM +0800, Sui Jingfeng wrote:
> else is not generally useful after return
>=20
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/tegra/gem.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Applied, thanks.

Thierry

--jzKm22+bkF0mQ8Ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUlbakACgkQ3SOs138+
s6FCUg/+OD33m/0vdz7o+NyI0mZZyDfZVh2DgPER+q3n6LDkKCpEYQpawTh879En
YNGwa0fX1Ug8IGwFEJK1zoVVALT9kHbkO33U0O5XgE9SpRigIdyYeeuubT4sBYFb
ikHphXIQ1MXfVvAs3opcwbuWvI++r19Lsxo/TMq+TbABwfUPdOTB4yjnw0JEZnEL
nUkL1ZGdITv86GXhxV3f+5Nc+jd16QeJDu7sAFpZUISdm2JQ1s+hSbMDAZOn0u7I
5Iqp+vbQMc5Kobmxn5PpxLIMGD5BecRwNtqhSbrrcGZ+KziRc/rd9O5SdMAaxSv2
YOFM8TEsPng4FqJgk7ui98OHhSRka+WHKCWPoPQ+lfVTazoyz8yeksELqNEuIrCt
BeRYGugLpbjCR3PXPHjB5xjS9rZ/DtU2CByIC1G/TZ14eGFQCHAN39Ou70FE7Fc2
QyHcAVhwRgiy4VQOCi3gxX7kJOJcEt/x4AirXdmgoowXRu1rif+xjndH1zEIx4/1
4huPz7V7/GuO1jjO1C4P+i/8LIFTnVRkEVExj2abf515Q7eevlMKNDRp18bXupen
AAhX+Ab23qPKbXpVhTwmEItA7ni6IokCwdeagAp507kM8poRt6e5UIsXTdjxtk0D
0XCLPtjB5tuJ7MJKspaOsjPINXPp2Edw6LRIDbdxIGPyAi/UKKY=
=JkQa
-----END PGP SIGNATURE-----

--jzKm22+bkF0mQ8Ka--
