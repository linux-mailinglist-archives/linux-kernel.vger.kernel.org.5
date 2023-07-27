Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234027651FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjG0LIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjG0LIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:08:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6FC0;
        Thu, 27 Jul 2023 04:08:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so1409623e87.3;
        Thu, 27 Jul 2023 04:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690456079; x=1691060879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5kNcxNoM/NBCHBj/sZwkTdvy4fIKuH9KCl0U3Yfro0=;
        b=sk4nBgwa56blsmau6xT3DDLmsazzohWHmva2oDdPJumZcDXBqpM7H0uoHztvWfDxtG
         vKpj4Zfq9LpV/7hnhRjKTerH6Z5TXy33YGSCsZzNXvaBL+NA/pcLSGMjb/sUliwWGkzO
         IPtePMax07YlG1MrdfJXIPI03n9l9CvRVWn7M/iKwa0zIBSSMLdNi2lWVz7LbdsY9kbk
         fSizPtgo45P5yG+99rQ3ZbBsSbTTQQWUsIwrPkgaz3hroIlAE0A67a3DZ40PNcLQv8eF
         uDrzPVD2bgjngE0LOQI3aZWSUeyfQZNT8w4J9FmB7Pj92SuRmYpl6spTzE0Swe9U+/vw
         OR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456079; x=1691060879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5kNcxNoM/NBCHBj/sZwkTdvy4fIKuH9KCl0U3Yfro0=;
        b=Fj1MbMAz2P5DUzPgQuhY07Ljt49YqPoZBaue/nxiKAJP3RY3QOrT+EHxV4zN1KVuti
         50fepHi82cC8idQ6P1ClAfIDH2zaRvxV8BrzTyfQCbDPgzsXDuxXDFZxzZfdd9OQlRO9
         DY5O3jXYjutmi8yNu+OyGN83PSlzaY9yBq1Pk/mwyAa/GuTCzzufpzjSEvWdNzUcWb0J
         nlUaIZhdZw6D1A66DFpuquUoFVr02vwMSn2DcT26uZTTp80uMGiBwrRuYievcOKcAfR7
         mkmyrRqDsr5NWORu4JAL6dtOB+AonxX8fIRmSMyYOBxYr9WAEUmM+3fdDYtwVhLdfs6o
         4w5Q==
X-Gm-Message-State: ABy/qLZsKiGjpFH4BJVFFZJe+8zM+0QBv9QZ4uNG0hT2GKop9+ij9EG7
        yhUCZqQr2nzzevUSfJ1Pp/g=
X-Google-Smtp-Source: APBJJlHJ7vcwwcFzwXaKsSNx7guxdQ7p6EoMMpcgxR4hIhGUEeF5V0F0bI98uP0rqgJr6ACGxAKE9A==
X-Received: by 2002:ac2:5f9c:0:b0:4fe:825:a081 with SMTP id r28-20020ac25f9c000000b004fe0825a081mr1582496lfe.45.1690456078632;
        Thu, 27 Jul 2023 04:07:58 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b004fe07f06337sm267402lfc.53.2023.07.27.04.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:07:56 -0700 (PDT)
Date:   Thu, 27 Jul 2023 13:09:58 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: mcp3911: add support for the whole MCP39xx
 family
Message-ID: <ZMJQhuMpm6jSOzvB@gmail.com>
References: <20230727101318.2764379-1-marcus.folkesson@gmail.com>
 <20230727101318.2764379-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DeRl1II0JmCihG0L"
Content-Disposition: inline
In-Reply-To: <20230727101318.2764379-2-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DeRl1II0JmCihG0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I will update the Kconfig help text to mention all supported chips in
v2.

Best regards,
Marcus Folkesson


--DeRl1II0JmCihG0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTCUIIACgkQiIBOb1ld
UjIZLg//UFA6CNgv9tM0/CDMzGQA8DShrqijB39GyNvnop6zG0MQrGgSfVzsGpk6
YD8PKy+JuVLQZ1vltN2gS9MKR4/5IUu2LRW/GSgU2+79AT/2cXcuIq2J1hsT2un4
U4RrU1dgcGlmUwUvGaTSw6pVM+Gq31tgUzyNMMAWLRknkltqifKgc8Ch4pLl54rZ
j9/7N+FUdyHU0cWP1Vjv0salc64HYsdAzBsXp8QN5dkaRkRLAHW/QgHPv/Hm6aVJ
PLtnPvNPQrNcJa3sIX5+8Iu6ENxrWL36tipBEjPWtGePAGv770ail7yXqklMU+9l
4LKqOmWYifX9OlN2Ju8XwH7QQFUYT/WvWIQh+67zewsm7fjJzafUrDieGfO0rcbX
qcExwUZAF+BVDseLdAfFUanu8OAqdN9xcyPI/E1ft+Zj7CmIJwVPbW7ewFKkbloQ
DX5FxZybV/lttNhUNZlYWvDIAdaVYB45SEs2rrS3I1elC2TlPQ2iW2o1EQ1j7lEw
a3LCs+oOQ9ofVmG522U9u1c7sH8e2ot5xz6+MCGrvHpoLr403eC2Mel287Btc1E2
YxJvVG9T8E6T71Vl65fG4gVB2Gy5OZKlAPdVXi7cDGN/AC0huXFssrIljmOoFJcT
be2u9oThDxbSm0uVYc5LFjBuqHENbFUAwdToMzr3y8PxXiGytwg=
=/flD
-----END PGP SIGNATURE-----

--DeRl1II0JmCihG0L--
