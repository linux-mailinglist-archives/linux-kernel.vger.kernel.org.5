Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98A75A7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGTHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGTHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:36:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5BF1BC0;
        Thu, 20 Jul 2023 00:36:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992e22c09edso74036966b.2;
        Thu, 20 Jul 2023 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689838580; x=1690443380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04v/o0SF8GsTODqczOjwHO3xzTuSNIQOhyU0g3zvtqI=;
        b=k0Pcr8+Sg79/d2Ab0fSFnraSNRHiwX8pk/sLEM1P1pWxgR1VSXQsFJXlBZpeZ9x1oB
         Rvo/nHuiJ6mFa9MRK3bWGl25od/3XVvvpRYSr3p6OQrRyKHmbqx3XS1Ls455xCIFvmCb
         75BD+iG4dMgA2hOgrfgm9IlnRWGC5+oLBf9wh3QrgHpb6t05pAJIuVpgxy6Ma8Se8+xY
         ZQAH0AXfiMm9t0rho/c/sJXuCU7x/u1uqlyYYtQw0ZHuiMwXjeDxW0azt8KtL12Bn/H1
         7f7hoTC2OUtwS+qgjqyZKwe8NPWtRBtlUkRc/VOzKK1SjoI+pU8Qj3TeSx2xMHKvtH2p
         uR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838580; x=1690443380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=04v/o0SF8GsTODqczOjwHO3xzTuSNIQOhyU0g3zvtqI=;
        b=Gll+JaPsV6E+7WvlZ/MMEJVhj3tm6k1W6NH8bDKflKoAmhI2Dp86YEV+aDMTaIyaGz
         U0VtccoqFeffXmlnp/9XpqD5uikm6BI/FvvOx3oHRv0b+uvNS5p64xBYC22b/ZnEfA5Z
         mm970C3AoI0rsPB7zz6Ao7rx/h09mEXCQRUP6cnoAwRSrzy4Fib0+HdcLCekc9PCUoaA
         P5yyzdyEwGGI6fn6k5Ntm0CbpcHHM6jyZq2gzWWImgzuesuKg8s61w+eqb7y38rm2gC+
         9XPIcbh8pGMixTiFC56VzndcyhjGaoTtnghMVEhCzwbkH+95Vn1R5Mm5TfA1j/anR9jN
         /V/w==
X-Gm-Message-State: ABy/qLZhyLjrfrsCUsyigB9dEaztUShRVBzSc+G81X9MMYVaJqIKWApj
        bnt1zNU7ojGWiOzZ7ZERtFu01kRn6X0a9Q==
X-Google-Smtp-Source: APBJJlGVnYG9f6FPF2QM4NvVkmFvNq19Qj1+cgsccL9Yc1npcdcY/oNYIBsq0hRskWsFuUVFHO+r0g==
X-Received: by 2002:a17:906:2112:b0:992:9ea0:2317 with SMTP id 18-20020a170906211200b009929ea02317mr4204575ejt.61.1689838579912;
        Thu, 20 Jul 2023 00:36:19 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906868400b009920e9a3a73sm276774ejx.115.2023.07.20.00.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:36:19 -0700 (PDT)
Message-ID: <e2fa1ebc820745065e91bac875f287167a0cfef9.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: imu: adis16475.c: Remove unused enum
 elements
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Jul 2023 09:38:50 +0200
In-Reply-To: <20230719123152.309624-2-ramona.bolboaca@analog.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
         <20230719123152.309624-2-ramona.bolboaca@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-19 at 15:31 +0300, Ramona Bolboaca wrote:
> Remove unused enum elements ADIS16475_SCAN_DIAG_S_FLAGS and
> ADIS16475_SCAN_CRC_FAILURE.
>=20
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/imu/adis16475.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 3abffb01ba31..243f0a91fdf9 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -115,8 +115,6 @@ enum {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_ACCEL_Y,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_ACCEL_Z,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_TEMP,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_DIAG_S_FLAGS,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_CRC_FAILURE,
> =C2=A0};
> =C2=A0
> =C2=A0static bool low_rate_allow;

