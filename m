Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D697784AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHVTuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHVTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:50:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9165CD2;
        Tue, 22 Aug 2023 12:50:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so6150913e87.1;
        Tue, 22 Aug 2023 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733839; x=1693338639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl38s84Bb5+pPgPAv7UYy5hi9GPWy9+ON3cnlBWBRY8=;
        b=GJb5M6tkIT3y3Rh0gvNMfQ18PBNcC5kdWP8lX2NMHjJM+mCu6cx2KASnXmmeQHYODz
         1+/d3ez5fMZ/AxP6WakI7w7Xx96qx5nN9M8NxyueY+fSjVuveyywfNRGOTI1EpbWG4Ey
         wkB0ehGcNnvmGgevmo/Ee7IAn1pDa2M7i5hfDIDR5PMJ+IdgekatMtdzjUMirbyCZ9dg
         ZwDLYNDdUBwxbIgbCVA22xegmVMZp8CuNSfeyWlt8e1Yp4W/9dSuHwm12Br1lgL1rJHN
         xxJqPFac5/AGfWzqy8pUIBTrYQ2rMSrQUPgFcirrfTsp/TonutPvPzM3Ak3AX4rKLKiC
         5DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733839; x=1693338639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl38s84Bb5+pPgPAv7UYy5hi9GPWy9+ON3cnlBWBRY8=;
        b=NylhzEdfNTztGwUTQNvNabcrGhrDH1O1vMx0yrWDOJJl81VFMWJD+U2vMDbO5evcr6
         3e3EyY2zpZeQBwV8JCx3ixQjojPrbVqmcf/Xl52Sh/399D7Gr0qeXGSCsG2+64B1gxRb
         qRqTE0bO/Z7Faj07rUfh4vLb/LvZfGlAHWA/MkLLc3WIqF7MsftMfcjqrgBn6gPAVY/C
         L2pyeQWOVwZFzC2lqk3htLv3agJhM1nEFyi7lknT2h/deriA5XUkjrtyBnBNgzmhKT+p
         1YRfuLm4glb1PrsWXRsgUwml6uQuSi06X1WrnNesC1Lfu3AgfOC+i7Fm/c4SAULY+W1H
         modg==
X-Gm-Message-State: AOJu0Yx/Nc2kIYfYoYSXoAqrHIYOHJzUntdEpkagpG7102iYDInW1eeZ
        +FmTG9kK3Pq92OtI+ojC5kQ=
X-Google-Smtp-Source: AGHT+IEm7n/RSOliNoSuO0HMcxnC1hKXsUUNiBkgK5A6SL14apFr9yMsyRRuiVEAev7WeLc4Ctd2sA==
X-Received: by 2002:a05:6512:6c3:b0:4f8:7614:48a5 with SMTP id u3-20020a05651206c300b004f8761448a5mr9060486lff.66.1692733838910;
        Tue, 22 Aug 2023 12:50:38 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id r22-20020ac24d16000000b004fb745fd22fsm2317984lfi.32.2023.08.22.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:50:37 -0700 (PDT)
Date:   Tue, 22 Aug 2023 21:53:09 +0200
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
Subject: Re: [PATCH v7 6/6] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZOUSJf1_7YGx59_w@gmail.com>
References: <20230820102610.755188-1-marcus.folkesson@gmail.com>
 <20230820102610.755188-7-marcus.folkesson@gmail.com>
 <ZOMteFUsKhDy1yks@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aa6NWibIAoF7yy2z"
Content-Disposition: inline
In-Reply-To: <ZOMteFUsKhDy1yks@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aa6NWibIAoF7yy2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 12:25:12PM +0300, Andy Shevchenko wrote:
> On Sun, Aug 20, 2023 at 12:26:10PM +0200, Marcus Folkesson wrote:
> > Microchip does have many similar chips, add support for those.
> >=20
> > The new supported chips are:
> >   - microchip,mcp3910
> >   - microchip,mcp3912
> >   - microchip,mcp3913
> >   - microchip,mcp3914
> >   - microchip,mcp3918
> >   - microchip,mcp3919
>=20
> A few really minor things, after addressing them
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Thank you for this journey!

And thank you for your time and for being patient!

Best regards,
Marcus Folkesson

--aa6NWibIAoF7yy2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTlEiAACgkQiIBOb1ld
UjJ15BAA3jdDIQjUAaDq2bR9xijNPqjvzxVXi5S+XA79IFrVjQa08ITV1vZg7D6h
s8f81LX+6DZdYcCX/9FbIpmBnualQ+aWaPBWjvSBUymqGCyiceUAU9zPwmzbxJ0E
fmmCGxrpCcIeN7rb/9WigQrruQgsTJ2kP7M4YWkPWFqoQqxE3iul+ImX7aDJe/Ni
WChdidgrvh8kHiE2NlhgdQmO+IzXOnJ+0WHrF+894y8WW/All966e19l4waxGDv7
8OqtlYMiT6nH/6B4BdA8SCZWieY9bkEG2oroJneQDylnIqquEhBmakgDR4qRxCsO
MGTA42OK3icA/msdgsrS1Lca4hf/4QqiQzU/JirZgf8/51KHfH6l9dU4FFUA5V8K
CIh0QofxRg970Q8q0PQ72/OLFJq90N/0juO7pfVxidJBzyHDCWGt68uU4+g9OSML
SEFlemokD2xBptSJPkOF/4IFnhExLj/TIAj8QUejopcU8f8APSrB2u7XUHHtTBKA
GuRHL8y86zTHp5x6i/x25CMc7oB1L/HuCPa1RJUUSxcx2RbhfoWXSJohbXkpNRiC
YJhoEYtXZsf+G6N98smKDS4P7f4V3XB/u+LuupNOF+lAt0LfN42rvEUqjBy27wRr
yYsnqXUuhcQnBtLblnMdtCr570UwCb5hNqJqY9KfughVFo7HEto=
=piAa
-----END PGP SIGNATURE-----

--aa6NWibIAoF7yy2z--
