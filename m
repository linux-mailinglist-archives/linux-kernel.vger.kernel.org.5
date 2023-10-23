Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718FF7D393F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjJWOZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:25:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403CA100;
        Mon, 23 Oct 2023 07:24:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9be3b66f254so478789766b.3;
        Mon, 23 Oct 2023 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698071097; x=1698675897; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOo26F7ddMgMPqh3lV7DV+yYzFbyW/ocxujpUxCvn1o=;
        b=lAT3OapmgowhVHbWZU3fz3YaNtGXYTpkzlflvv1PSaoM4EbL1hgY/Pf4m36hWykw0W
         KlVLBr4p0Neci30Ulm5ezYobobpgpoePKDMapsIFi7DH7w3IVmCdCtq2aeCUMND+6NEB
         jMxmZWhH+VGhKVM78fNrKX2naCdbFJ88L5Qi1bbjMmSgt1UOo7bvRyEE+kkYT3bdY8bd
         jqC1Q8ZTLbSsrbcZ5BGYf4VU6qKj/jAfrM48Q4UmHDnLPXhZ0nyJZv21FW5caAg+Os8n
         6CJG49zwMm2qiAfeOZpAkqVCOFqzEPy8ePf5IJ1m5ODrSHFx0ozHStGiPo4df1hWySJu
         Voog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071097; x=1698675897;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOo26F7ddMgMPqh3lV7DV+yYzFbyW/ocxujpUxCvn1o=;
        b=hlrlj96llRzwxOCvPcaHMz+ArXPkqLSkT1IdZf2o1QSd37F4Lkw7PK1KMwnKSM2Pv3
         rZKUM0so/nQqIf7nrjbwQgr+XLydPB+fXW/WH7OVCAZd0dDR1/Uc0Yf7CZNTT5zVQt0b
         qrzHut0QwPJzWwB+mEp0wivVPkg7gu8J7qUuB07lLtj75+eath56FWwpBspE0dSxIUlq
         jg5Xi0mDEDMHHnD0df6JWIeJMQFsaI936r+IjaSZ59/OIJ3jG6ef990AEO+FhwM2pfuL
         HwgLq9QBVZ+dAvqBOedrLbJ3uClB39sB2fuVNM5WHiN1WugWk3c6ric6s4FUTbXfYHwc
         7vsw==
X-Gm-Message-State: AOJu0YxxaO6Z1Ub9XRJ3tv+611vDVsWNiirYsStY2VcmrQ7f8pyyuVw9
        epEDq0OIiK6kN2ec9cRCLVI=
X-Google-Smtp-Source: AGHT+IGDPYcqybnKKGxteO1DjEkEWIGmlvC8h+HZU+3bP7Wgjm4MehUQpms5PfgDSWvJuk/B75OlaA==
X-Received: by 2002:a17:906:db0a:b0:9bf:4915:22c4 with SMTP id xj10-20020a170906db0a00b009bf491522c4mr8074201ejb.67.1698071097349;
        Mon, 23 Oct 2023 07:24:57 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id lh22-20020a170906f8d600b0099290e2c163sm6618118ejb.204.2023.10.23.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:24:56 -0700 (PDT)
Message-ID: <e97ac024cb2654507ed8f7af715f3604efefbdbb.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: adis16460: Add
 'spi-cs-inactive-delay-ns' property
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Gradinariu <ramona.gradinariu@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Mon, 23 Oct 2023 16:27:48 +0200
In-Reply-To: <20231023140534.704312-4-ramona.gradinariu@analog.com>
References: <20231023140534.704312-1-ramona.gradinariu@analog.com>
         <20231023140534.704312-4-ramona.gradinariu@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
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

On Mon, 2023-10-23 at 17:05 +0300, Ramona Gradinariu wrote:
> The adis16460 device requires a stall time between SPI
> transactions (during which the chip select is inactive),
> with a minimum value equal to 16 microseconds.
> This commit adds 'spi-cs-inactive-delay-ns' property, which should
> indicate the stall time between consecutive SPI transactions.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
> changes in v2:
> =C2=A0- added default value
> =C2=A0- updated description
> =C2=A0- updated commit message
> =C2=A0.../devicetree/bindings/iio/imu/adi,adis16460.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> index 4e43c80e5119..f10469b86ee0 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> @@ -25,6 +25,12 @@ properties:
>=20
> =C2=A0=C2=A0 spi-cpol: true
>=20
> +=C2=A0 spi-cs-inactive-delay-ns:
> +=C2=A0=C2=A0=C2=A0 minimum: 16000
> +=C2=A0=C2=A0=C2=A0 default: 16000
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Indicates the stall time between consecut=
ive SPI transactions.
> +

You should drop the description...=20

Also, give more time before posting a v2 so others get a chance to review y=
our
patches. It's also better for you since you can gather more change requests=
.

- Nuno S=C3=A1

