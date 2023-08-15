Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0997977D05A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbjHOQrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbjHOQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:46:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4D1B5;
        Tue, 15 Aug 2023 09:46:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff882397ecso1073931e87.3;
        Tue, 15 Aug 2023 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692118003; x=1692722803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=If53RCBUL3psNaRCWLvzX+560q7uNFgIHgOS54tj/hQ=;
        b=YcRtI7jvRG3KmX79eeMTST1rqcFzTieR04DIMLIfPKBb8ccBhVcUeNh/qzLcsola1F
         T7DqdS2wGfInQtjd7CRvt0nuR+IdyaVigH2SRt1Qzr7nbwDSEAdshia8WS6KsE3qx0sR
         7XbhJ1Xt4teSggqnD4IpxFJ2WngqOnZSY2PUMiWcDurpbyEn2ENc6NhIhZ9lc9Xl5pG3
         7FqpLoc+Tu9cNdml8XJ9RgiAHmjVxQ2afgQeX+0iDeOVogMmQmqlkfgm7ykPFbtk/zw2
         vByR4Si8Np1yKRb3iFXC/UQv6Cjmneg+6ME3g0AZSTTo4hdaGEqoSP6RUMJi7rSlunrO
         BAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118003; x=1692722803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If53RCBUL3psNaRCWLvzX+560q7uNFgIHgOS54tj/hQ=;
        b=PagM+VDCPekRfZpyDwb6WdNp9SgyR+f6pbuQnrARhEcsQi5yEmXxkKasXXWJOJx+wK
         Tk0kA6jcFfS6xNSSNGyaB/qw6K2u9IieuO/cJf3NgJWXdwjy4g+/pnN5c23TfaBE/Ngq
         WhtnydJXYhMJNJOxEZc5oyhnEpZN9ZxK5PhAkDIx9Bw6hC7SNIdQeO1zyrswPNKgCRTJ
         PaJY26ND7jHEomXjooxpYZs+m+dTbrSRwnLaOq0Zj8qRBPSJd41D3+mgWUW4bsVlZgk8
         V5n85oKBBwRHi5095XfSQb+NynTgOV+cdyvGGXKSZef8pG3GJ3Qw4Jcab+aHk7tJq7Pi
         SfSw==
X-Gm-Message-State: AOJu0Yxk07TDDDxUVwKe41WJn8JdkUqZ7niPygAKwJNKVQeptaLGpRGQ
        v0f1I+HxXIebjWSIEUW3GTw=
X-Google-Smtp-Source: AGHT+IFvrl/phZeooY4g5IqD6jnEjiC3p/tH5091Sy4kC/bAtswbiNSu+NmFsoh09sBBSZjO+39kzQ==
X-Received: by 2002:a05:6512:2513:b0:4fe:8ba8:16a9 with SMTP id be19-20020a056512251300b004fe8ba816a9mr9501094lfb.55.1692118002781;
        Tue, 15 Aug 2023 09:46:42 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id j25-20020ac25519000000b004fe432108absm2532242lfk.182.2023.08.15.09.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:46:41 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:49:11 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] iio: adc: mcp3911: avoid ambiguity parameters in
 macros
Message-ID: <ZNush-mJqb8W6fjJ@gmail.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-5-marcus.folkesson@gmail.com>
 <ZNuSJTjOL1sEnVUd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gG4ZBKiCQPvz6Bk4"
Content-Disposition: inline
In-Reply-To: <ZNuSJTjOL1sEnVUd@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gG4ZBKiCQPvz6Bk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 05:56:37PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 14, 2023 at 02:10:09PM +0200, Marcus Folkesson wrote:
> > Name macro parameters after what they represent instead of 'x'.
>=20
> Yes, but it's not my suggestion, what I was talking about is how macro
> parameters being treated.

Sorry, I clearly missunderstood what you was aiming for.
I will change to (ch) in this patch and keep it consistent in the
following.


Best regards,
Marcus Folkesson

--gG4ZBKiCQPvz6Bk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTbrIIACgkQiIBOb1ld
UjLtPg/+P74NyFgPv+ugZTH+rxz9RzKBi0bGT6bAVV70G96YxRZlApT5K9Tn+q1V
WZu/zySEgF++o+rg4Nog6ElpOED5ySq9JQ+6btGaiEZ4rsiC38aqCDiEhOhiUTO9
DghF/7Lo33iGcDt4E7SdA9MtyXDJQirZH6/ULehVwS4CLcv9pi3mbZse16fI/o6s
xWwiLOaTUsXRaGRORF0/cecqoVgoXhW/Z3VYra7nehh7pruNB4WRwKnp+TzhyOwU
nOTZhJDytW9HxkwuQiLJ/aecwGDnTVe/VRvZvNDxLdcvmW3SY6tREYXYyp0wqSJ4
VhJwluO7fxkGGY/e6qPSNI/APbYuuOozi548LETj/g5x70YdJIJRMLmDW6YoK90J
/sffnaXcNiuh/tponMtErqWN15Dvi0M1RNi1V0NPaHwvCTc7TEtHyUVwyABcNlqb
k4OSoH8H1dS3mCZav11kCCEp51sMFG4amCkSLvFAm/8mMMLlFeEy8iXO0e1XUxv3
AZ0j0INKO6xa3ZeaTUO2ALMlBEUxCtLUo6nGEQibFGnsU5OJ7wgyLC6EIOKjqDBh
8pVinw0CKp1WwZ517rFqBlTBZAHz9z6cYWbjWbazrIc82sZn/hBzTR0WAfKowmGO
vpTUtssLqD1Bgq9Roaapj+qWGZIU2nmDh4cBAMXXviQaBCS87qo=
=tHfk
-----END PGP SIGNATURE-----

--gG4ZBKiCQPvz6Bk4--
