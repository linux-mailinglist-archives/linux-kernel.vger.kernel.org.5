Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3378E7741FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHHRbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjHHRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:30:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8C8DCDA;
        Tue,  8 Aug 2023 09:13:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bcc0adab4so849862966b.2;
        Tue, 08 Aug 2023 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511158; x=1692115958;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urR17NXXORwlJc/4xV0du1ERMO9/hff0y5pQAkxNBf4=;
        b=OYnOe/MvzzbujQUxN1S0npvgjNC03GtAFcOicE9asTr7vN4yIjwc25N1DAxNt8dver
         HZHWymiBrLQsmbwVPyt2b1T9Q8axUkAtPLG7Mg7fCfcYpUROYXXoUumAEFsyEn/7rUP8
         dmVgtZwxVZlUgETSzADUhbgI9JCbRwzerXz0OSlGPQIf70u9ZcZbYmkL4isvH9zBGbMe
         ZCehQkzQ0mY2UUdDoVVQ07vfmzezqh1wuuc2LWX4unLiv7EaqZwXjst9Uo41vYq15Yhn
         UYUdCKX2em6d2HahLXKAusHJE46DdBEMh1N8n1T8/H8vkyScBY5a/TpHwWWB0Duj0z/K
         Dr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511158; x=1692115958;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=urR17NXXORwlJc/4xV0du1ERMO9/hff0y5pQAkxNBf4=;
        b=klRZAQtHkKKfePDsEj+oRlb4IYYFaC9AjKcL3ax+AuyLvsOn/KJdb0UsPZoygKoiro
         guZuC8fj9KMVRbQyComDqCzzOtMmzcYCIvPD0HtdQUuPxgV6l6Wq+7iIHhrkO32+Uf9p
         4uUgmmhPtHFakBwODOQUXfICkYFK3xI+O2Dy/exKrw5m5X6YnUsvr9oCUt1Gy1ZvTgee
         js0ABa8r4b2mSAnoH9ch9YDGxX+NR9ODQ86hfn+3vGZLPgNeDU7/jyTk1v2pQ3FbC7gB
         3i4p6R8bR94FeQf0Sg4MthrinYyGjoPnOrZ2zY7kieQDSVYVIifKYNipqSyfZVlIoZp+
         aA6A==
X-Gm-Message-State: AOJu0YypzN51J+CJ2IoGKeb3/AitUpypWd6Dg7Ko1YfycDikCM0xKXZC
        3mw8tqK/lIpo2KqTsiL5FhkXANB2KMELQJbR
X-Google-Smtp-Source: AGHT+IEk2GZHsfbq4NRBC+hd8CRYTMqVTpZAo8FgFYwPwTkChWOvxklnvB8Kw3achB7XNCG4HVqIZQ==
X-Received: by 2002:a17:906:3009:b0:99c:5623:a2f1 with SMTP id 9-20020a170906300900b0099c5623a2f1mr9683792ejz.48.1691476217677;
        Mon, 07 Aug 2023 23:30:17 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef09:a500:ffed:38f8:59e7:f38e? (p200300f6ef09a500ffed38f859e7f38e.dip0.t-ipconnect.de. [2003:f6:ef09:a500:ffed:38f8:59e7:f38e])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906525000b0099bd046170fsm6136063ejm.104.2023.08.07.23.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 23:30:17 -0700 (PDT)
Message-ID: <2df639c71d3a6e876efddd5ba18c56ca68a4ccaa.camel@gmail.com>
Subject: Re: [PATCH] iio: admv1013: add mixer_vgate corner cases
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Aug 2023 08:32:51 +0200
In-Reply-To: <20230807143806.6954-1-antoniu.miclaus@analog.com>
References: <20230807143806.6954-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-07 at 17:38 +0300, Antoniu Miclaus wrote:
> Include the corner cases in the computation of the MIXER_VGATE register
> value.
>=20
> According to the datasheet: The MIXER_VGATE values follows the VCM such
> as, that for a 0V to 1.8V VCM, MIXER_VGATE =3D 23.89 VCM + 81, and for a =
>
> 1.8V to 2.6V VCM, MIXER_VGATE =3D 23.75 VCM + 1.25.
>=20
> Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013"=
)
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/frequency/admv1013.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/admv1013.c
> b/drivers/iio/frequency/admv1013.c
> index 9bf8337806fc..df29f1216b9a 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -348,9 +348,9 @@ static int admv1013_update_mixer_vgate(struct
> admv1013_state *st)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vcm =3D regulator_get_vol=
tage(st->reg);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vcm < 1800000)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vcm <=3D 1800000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mixer_vgate =3D (2389 * vcm / 1000000 + 8100) / 100=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (vcm > 1800000 && vcm =
< 2600000)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (vcm > 1800000 && vcm =
<=3D 2600000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mixer_vgate =3D (2375 * vcm / 1000000 + 125) / 100;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;

