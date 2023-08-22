Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14719784ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHVTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHVTpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:45:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6ECCD0;
        Tue, 22 Aug 2023 12:45:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so22322441fa.2;
        Tue, 22 Aug 2023 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733511; x=1693338311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCEP1XtisWbLq7T9ufLUjbBdCtY2Ei6DbosMoAGMNy0=;
        b=McY7tcvAUT4z+xHSADPJEb516Nmlm3hjRkSaoX+kvTHBZY7TR7nPTY0Ipdy7Shx3r7
         D6v5b19PCycPwCYOpUgHEY16nmaBHdjVBylVnrZXNp5dvgI16YfpZTWE3qfnbahnaDNq
         Ouuk9Akp3WoLIZrjUIQ1prvcUgwLCkSRoFZ3ovmROYdsGfb9/paKEbRIzxW0/SE4D3Xc
         YrPhn97/LR+v5Ym7Mo+FrTXsgwj7VwqLWQZ5zGCExPuo1aqSOdsLVg+YgTvjAuj0FGpT
         iniikJv7rN0MllFQrlT/bI/zhham8yooLeLEOWAQ0LrRVl7Lw5TELO8L5TnCWQCWs66g
         pp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733511; x=1693338311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCEP1XtisWbLq7T9ufLUjbBdCtY2Ei6DbosMoAGMNy0=;
        b=Ff2p3paS1quZfmEKNRGJKJf8GUqnSYAjjKpOgPs8J2tatk5oXhln6TzVWTtDtx05XO
         GvRuV4KdR0fAlh7tpnb39w7ZtGz5hVThjTTo74ciXmiI8Y2tZUt5+4GQhFnTZBmWP8cj
         NXtV9cpeqL0A4cD62X8gdyuOD6JhkzTiZJ4ZAgrKnvLcTsx1XtpLaOAOg3YGVd6KfX65
         f8NX97s9cgBzMXamRla6rfS5J2TP0/lCxcHitBG/pEfwMdz42KEi0hkA2EzurcSi//pt
         mrxRaw3PF1qzyNsj7UkOGMc67kiqgqGXXYRY+TXvnU5yiUDog2xqXkY1E2+d5c+hU8KU
         cszQ==
X-Gm-Message-State: AOJu0Yx2w91J3jxgN1GNjSfoBtwmcqg58FlAhehQX7TUehnAEdJcfdCQ
        hjck3PX/YckONuFRMLiwu9g=
X-Google-Smtp-Source: AGHT+IEpehQ0KJYSqZ670d9aM3acrIuBj+shB2P6jYDVmfi5IWqV85CaKamnncU4W77uSinQ9rZVBg==
X-Received: by 2002:a2e:9658:0:b0:2b6:c886:681 with SMTP id z24-20020a2e9658000000b002b6c8860681mr8149972ljh.6.1692733510586;
        Tue, 22 Aug 2023 12:45:10 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id l8-20020a2e7008000000b002bcd84dcb1fsm149649ljc.21.2023.08.22.12.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:45:09 -0700 (PDT)
Date:   Tue, 22 Aug 2023 21:47:35 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/6] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZOUQ1_UeCkQmnaIa@gmail.com>
References: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
 <20230822192259.1125792-7-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="36Sbbzb3fmGshIfb"
Content-Disposition: inline
In-Reply-To: <20230822192259.1125792-7-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36Sbbzb3fmGshIfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 09:22:59PM +0200, Marcus Folkesson wrote:
> Microchip does have many similar chips, add support for those.
>=20
> The new supported chips are:
>   - microchip,mcp3910
>   - microchip,mcp3912
>   - microchip,mcp3913
>   - microchip,mcp3914
>   - microchip,mcp3918
>   - microchip,mcp3919
>=20


Forgot to include the tag from Andy:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>


/Marcus

--36Sbbzb3fmGshIfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTlENMACgkQiIBOb1ld
UjIC9Q//cWnZSE/XDa0lxdHQvgdz+mZHP3NHipH3Uns7BO3WxLMqZXbFHjszC1uF
wYjTZW1pbOYUtF7O9O/LZONz/1L8BVXLyKPDohFyl+XUTKbtuX2Qr+tPMv9KhLIZ
J33Ar1/kZ1W19S6LEEjtpe0RXPtzPmOjzwOYy7SA8wv/jGkjEMxAH8iNEhl8P+1e
AMXr+4xCTRjxPRsqJxRZ+LuJNYltlfHfE7tJo8dmH2bLMmYru5EJZ6iOBJtFzrr2
bSYqRXcRiLE8cp2chdUk+ayE7h150FueKLSuqjDw/5lkmfMl9lCALaUjcw/z0K+K
dSpMu5rWZ7qUkrlu/HIeaP11WGP9quBYPoNF9lIA/Q+AaDngsL+Qz0Opo52MhD2N
xxyq2s6Qmz3vL7TkRPrdWZHlULD+yQXU2q2jHkZSMDuJljfEN1h+PGO3VeEiySBc
/PL69/iFWP8nmPcf36cEM30dgzRT7nL9QitbPKZKZzqRPusG5geWl4me5m+/gO0M
xtpk9b39rOvUYjyCfcHC6ENgpSfqAefZjb/PuJZ9HPqF+mgv2sNoR9Vpu3rEQ5/R
LQiNuqUN4Wr+/xSgp5oMCXcAmK/vD7r/PwU7TJeKn4rotU6+fj4qpCiOGH7ZvCS5
klMW6YEJUyCM0Ycs3xX9QzTlhtYSGCtSj1WyLaF1Wtga662egfg=
=BWiQ
-----END PGP SIGNATURE-----

--36Sbbzb3fmGshIfb--
