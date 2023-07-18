Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70817757587
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGRHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGRHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:40:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94DA19BA;
        Tue, 18 Jul 2023 00:40:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso8830226e87.3;
        Tue, 18 Jul 2023 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689666005; x=1692258005;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlUUoYrCI/PAw1b9Jcxa6W/yhkHrrsXYB8ywBb4Zdcw=;
        b=kjDicRWDABKhbwaNAQ0t5axb/afcaD0DP5Q4MPYeRPIHpGD7r2KtF58q4y93nWfF2b
         49VVL9MukYEaIY6p3upv0Jkd6SzR1QnGGcqIuKMylp1Ud+AKaEmngB4ed/VJeurAE7AD
         VdStOvapIk/cV//SDyf22g05q5gnj043/39V2HeYNDgUzlZv2Hnd8xasORgd9uOZLAMc
         9g6wuZRboi64mU4ggfU/KgZwggakOtkwFtimgJOd/xoxzdveeHrYG2O4AqAKp0tnrR+B
         htXPjftOOvDBTuJ5hzjX3CsyclAoUAhb5Yar5MxyrP4mZzoCTcuWiDdEVOA2A1xhxkCb
         kg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666005; x=1692258005;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlUUoYrCI/PAw1b9Jcxa6W/yhkHrrsXYB8ywBb4Zdcw=;
        b=IE+iJTixa63GCHX3jv9dZtDtRIEd7mWVCUhuJgJ01DwQmoOg6S9F8qQqmqeOOWQS0d
         UKmX94LqaFooZGyB5tcQTyn4OdeHVit+FdKlAp7x1KkuP1ImRlUwb3br/xy5iREq7O2M
         Li5F2hJYzwIdNpl2hzE08R4p6mB6+ramW5jD1rcZiXKleB1GrotUPW7DYSzGEkLK9lJ1
         loB9Ha6oG38J0y5lGkfZCLBFIZXxEPKfPUiYN/Qw+0t+aM8bGtSxjoghC4W5U/fwyxDF
         znA0tOSgzVNbpnl/ADbfmNLEmwiWwnEu4vuQzEco6HoAk6zbI5zQLzS/IQJ1ovLqtmVd
         cg9Q==
X-Gm-Message-State: ABy/qLYdsj9ZVQ3bUBPADtGrOjd6BJyk7tp7bZ35+1nqo0Ahc75J/UFc
        L+5Pl1GDDr5mqF65aoc5Fwo=
X-Google-Smtp-Source: APBJJlEX8zzhQn7Ou05/CQZQgAl+5rvY7vzNrtVjpZZJO0DRW82rk/rzW43gjG3e1aiIIPG6nLE4Cg==
X-Received: by 2002:a05:6512:3248:b0:4fb:73d1:58e5 with SMTP id c8-20020a056512324800b004fb73d158e5mr8279860lfr.53.1689666004642;
        Tue, 18 Jul 2023 00:40:04 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n17-20020aa7c791000000b005215eb17bb7sm779736eds.88.2023.07.18.00.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:40:04 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:40:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Message-ID: <ZLZB0om1y9qLXDdF@orome>
References: <20230718034201.136800-1-jaewon02.kim@samsung.com>
 <CGME20230718034723epcas2p3913ad208c70659965b4ec204570aa0a1@epcas2p3.samsung.com>
 <20230718034201.136800-2-jaewon02.kim@samsung.com>
 <4e546dbf-8f10-a27e-dd8b-052151ebf00a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dlM6TTb11shujLiI"
Content-Disposition: inline
In-Reply-To: <4e546dbf-8f10-a27e-dd8b-052151ebf00a@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dlM6TTb11shujLiI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 08:04:51AM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2023 05:42, Jaewon Kim wrote:
> > Add samsung,exynosautov9-pwm compatible string to binding document.
> >=20
> > Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> > ---
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Do you prefer to take this through the Samsung tree for DT validation
and whatnot, or should I pick this up via the PWM tree?

In case of the former:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--dlM6TTb11shujLiI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2QdIACgkQ3SOs138+
s6GPvQ//TUOiCPcnWeVXaAwdZc2XSAxzoylvus3O4J09K1PohEs9vtWqQgeC0t+R
TLPHjqnvTyxLPv8V3xCKOTotz9ygzHan5jwrbjL+YFvVSKAY+PoveltFqE9cZ58B
IS8LOpKNM1QlIXWAtAiO/S0GSHnj8QkKHuuLyTx6Che3+PXA1KcZP4Rkj6qaCFV5
/TVfgNXwG2EdpalIHQL/9h2E45cxSPiwUZKRVf/9nZH20cKFJzlnSSvKXM1XMlbx
qkkWeODv0I3gqzJYmxDKIK/ud44QqtT8eNE359nfFvlGHNaaxTuM2g9Z7SItqkFx
BlEHroATKiJ/9pLv6rZPb7l3Pq76JwFzr2/hVZg/TMqDblJnpIbKE3VsLHvBFpQk
BRa9ggt4+PYbRcaD1Phs+XgRHxiLBTJJqLk/VWsjy17eGseL77WBwrEkI9+I8cgH
n67pjD6X2lo1mpnUvwKxPzZ3t/SUOHMTOnrBdAciwywItpK4Qc7wHRQah4DVW/q+
69cPxUAvl25iIvOioNzDbmZ41Dkn5jJkfQakFp4kKCxO8xJzv+cBz1wKmU/vcLlU
JrVUtIIFZ+9lY/NxIjd8qOCCO6hjQCOcm+7aq0NVW2UX1DxTe5YE1dwYUQhRCOf/
khwiyqRpotI0D1kjPtNG8MPd3WM5bGEDV+7TTo97T86zGFMREnE=
=PPnI
-----END PGP SIGNATURE-----

--dlM6TTb11shujLiI--
