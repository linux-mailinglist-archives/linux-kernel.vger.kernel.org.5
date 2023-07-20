Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE275B3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjGTP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGTP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:57:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5CE0;
        Thu, 20 Jul 2023 08:57:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992ace062f3so160894266b.2;
        Thu, 20 Jul 2023 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689868649; x=1690473449;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+QYvjk4JswBL9BSCn/o4aTnoq/NNAUPcNRmWTlC0Fw=;
        b=SzY0RAhGiSq+AX526QQ+qqBDw/ILGBgZkfpNp8dnMvKFv43Nken9eOtnikyaMq7bNX
         QtVICXaFoHxE3DY2pcfnmg+OVv8IAraX1yrB0niz04gR0Mv0Q4LJtqpvE0t5XmBe0NDp
         d7GEeseVmHCLg/wjJ2K4yGYuOpF4Ah5Uv9nWq1/B6sBYwVjquo4I5jGImb1pE7aI9XMb
         inSV+EEWp1Jl6rCy3Jibot00QAItF8lUCIGhs6hl/Jt+E6zgTKuAsNTIHg21/X3HZnEv
         OWPS9Qodd7ySKaoOm/w5/WeWo/9QsiBOEm4JyayVDSCiV7uM8LMAPwKsAqZD8JR/EDgC
         ONmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868649; x=1690473449;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+QYvjk4JswBL9BSCn/o4aTnoq/NNAUPcNRmWTlC0Fw=;
        b=Y4drXMcJtqg7vFMJGk5mzEACP/BW6qEPIvDkFM+4AMlQ2z6M6AIw/PVON9L63E7qBz
         SH2l8LSvj6M4MFCg7cdUPxGE1+UJmjEzRNjUgCwVVbIfLCWv5csTDCEyis1hIIENymH/
         DfBxk3i2tbyWuD+pgdmx6q50/vDdrOdjjA9L0xTPRm5j3Tj8bN4ACmPNSZE/Ykosrr6n
         PVTDQiZbfuKrVF/zjnH0XdZ92amw9suxdp7pmWu9HiGV6xWEFcx0q7sGyeHNKbuc3iR/
         /aEa1gl7ylKw0HbOHRVFdSZW/ChxMOTMdWQ60w9AkxCQu+zviw9WJhn2SkKG3ud6WmVE
         cwdw==
X-Gm-Message-State: ABy/qLZG1ueeABATJqC8n/CsUd3kKR1GD1C9LlIUqG4N9iHtxnUIcTnf
        /z6rQMm8LlrWNT3n4anOSGE=
X-Google-Smtp-Source: APBJJlHyWzaJn4RDg4hoe1kskMsVjmKfGD9qXIgRJQTCFm5VexEnWOBYPCaIv5bHvtHrLy8hiE8MqA==
X-Received: by 2002:a17:907:7613:b0:99b:574f:d201 with SMTP id jx19-20020a170907761300b0099b574fd201mr1958976ejc.40.1689868649222;
        Thu, 20 Jul 2023 08:57:29 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qn15-20020a170907210f00b009892cca8ae3sm859740ejb.165.2023.07.20.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:57:28 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:57:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Message-ID: <ZLlZZyR19tQUfsx-@orome>
References: <20230718062200.79306-1-jaewon02.kim@samsung.com>
 <CGME20230718062724epcas2p4c5e986c62fba72f722a37973e721a452@epcas2p4.samsung.com>
 <20230718062200.79306-2-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qpP/98MEhHRgR+z4"
Content-Disposition: inline
In-Reply-To: <20230718062200.79306-2-jaewon02.kim@samsung.com>
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


--qpP/98MEhHRgR+z4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 03:21:59PM +0900, Jaewon Kim wrote:
> Add samsung,exynosautov9-pwm compatible string to binding document.
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.yaml    | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Kryzsztof,

do you want to pick this up along with the DT change? If so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

Let me know if you prefer for this to go through the PWM tree.

Thierry

--qpP/98MEhHRgR+z4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS5WWQACgkQ3SOs138+
s6GaVg/7Ba0ikWx8DB0QbrMH/jkLqyKpqiTtQeHGCstsWiEY5SsWs5q/h36+OP9C
1TMkR1trJ78Zm+eu+Wk48pWxaBO/ir2BGUO7nPzPK8ieQMVNZBnreu02kCtO3f6H
304nRMowPhzB4PR3OkHJN/Lxj1wQOlFQaQDBLa5L+spYIysf/0IM5L4h0FFt+zN3
Ion7FegVkIaT6Le7VwmiDJw562m+EKjnVpVaIM3zG+/QajitvBP5rETG1BGXA5Lc
M1WQllwSu0ulf8Mm2KA1WAJ6iHWlxif8k0OYua14+rpjmG3zfqMEZ1ai4vyOhsll
3FkwL1485b5czLkG/Ty2AO7E7/ReYwOsBtdL+v6k6q91PifBuJvVGuGUl5qwb+e1
mz+f57/25v+1sQVNEjqmOjt2FgorI+D7uOWhaftaTJIV04Sy6BG99BLDUBXIBlR7
sS3UWNlOoTQ5K9MO3g0XEeAj//tJCNO0TcFZCULtmszopKWGYrIJ8xTG9tOzGQkM
5RWaILnfzoev4vNGZHRFgp84uTBNcyenpR1+8uoFSNMdpEdpGy3j2SX+o5ubWW2F
6tdFaWieiS6A1TNuRYW1VOYbA4IQhq+lCPSWtXfbnzj+5VPzg8GBZs64DML8Yygr
QvZnp49socumO8J/uYfFYFjxMdDgc1PRvHxTG58LJC7YuZ/zPW8=
=9FdW
-----END PGP SIGNATURE-----

--qpP/98MEhHRgR+z4--
