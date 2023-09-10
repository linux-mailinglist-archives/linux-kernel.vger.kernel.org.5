Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9344A799D63
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbjIJIyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 04:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjIJIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 04:54:36 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699B19E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 01:54:32 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5717f7b932aso2270988eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694336070; x=1694940870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lgpH9+mYIZiTiSRi4aA6jYtZEqamFekNzmEa3uRVpo=;
        b=Mw0DGMC4i0VlCwKll7t6c025MVA6oxRtYAZ6MKroa6FDa4G+ka0Yc3z/91AAeJJrUP
         VAqAgaO8x6HHmEqCpwigqhRqL2wTyrGLDteN/dJv1efxUTG2XDIjahfPxevQOLUk2515
         UH+muc5wCrJSOaqzi3HRYaZwjt99EzUfWFkP5LMzwBVbgdw8Gtpg5YUjz2ehhEWKgaAz
         NVzJCMQAgId//T4p/m8RwnQUZNWzvYScKYAsQGFrX/wq1Jr4warGFIRV7B7etMzDo3Y0
         0tRdyUlMzqx5NX/GaI1I6an8VY/nTxMcP7JKndLrLBvVh6dNLnxGVzAcpDhVU61RCvQs
         jcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694336070; x=1694940870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lgpH9+mYIZiTiSRi4aA6jYtZEqamFekNzmEa3uRVpo=;
        b=R1iS2/HK7wKVLKZ1+KNG7IoGfTn6yddy8Xrl/lpZ2PprZeFSmENTlisXIpzSUzzicb
         mFmX8LImGrCgUkSEqAdUWsoH9qPV3k7pJZ4WQ5ncenJu08WRh8PCSjToJUYMVOdARwkZ
         B9WgGSO2Y0/CwjuhZ8K/C7uuREljyQtCgbiJ5D9/wdRyE1vntT+yNOwjnh2a/0bbiPUK
         9hssVhcgeQxZ8ZDPAO5Ydw5WZdwcz46oF8GdJUlGaGWy+szTEqsOkPmowfQePzqBaqnY
         3jXcb5mFei2/WiBdlPBfSLWxIr97JzcZHq+OxkQC9K1B29ujmITi67R5/FTOrwEgGtmY
         NSGA==
X-Gm-Message-State: AOJu0Yz7tarifj9fUUpctaMACl36QrXnGt0yXKtwxRSq3c/WUtaGsl4k
        pM03ZZ7gFj//KLSH3mbKd16ig1Akwt8=
X-Google-Smtp-Source: AGHT+IFo0lXuVT4laYGMB6yJcUTqFaZMQzZR8Ia5MJVnJ73100N8fueG1wWvlVMiQqr/DMEjDeftmg==
X-Received: by 2002:a05:6870:c214:b0:1c8:d72a:d6b8 with SMTP id z20-20020a056870c21400b001c8d72ad6b8mr8286404oae.36.1694336070626;
        Sun, 10 Sep 2023 01:54:30 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b001bb9f104328sm4270163plg.146.2023.09.10.01.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 01:54:30 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 41E948B25F93; Sun, 10 Sep 2023 15:54:28 +0700 (WIB)
Date:   Sun, 10 Sep 2023 15:54:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Andres Salomon <dilinger@queued.net>,
        "Timur I. Davletshin" <timur.davletshin@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMD GEODE <linux-geode@lists.infradead.org>
Subject: Re: Fwd: AMD Geode LX hardware RNG driver produces regular patterns
 (geode-rng.c)
Message-ID: <ZP2ERFydER7pJprL@debian.me>
References: <9a28c2fc-d769-4802-a1f2-77ba2cb34d25@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulctYQL3W5/kDSuY"
Content-Disposition: inline
In-Reply-To: <9a28c2fc-d769-4802-a1f2-77ba2cb34d25@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulctYQL3W5/kDSuY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:37:00PM +0700, Bagas Sanjaya wrote:
> #regzbot ^introduced: v4.14.267..v5.15.127
> #regzbot title: predictable urandom output on Alix 2d13
>=20

#regzbot fix: https://lore.kernel.org/lkml/20230910083418.8990-1-jonas.gors=
ki@gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--ulctYQL3W5/kDSuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZP2EPwAKCRD2uYlJVVFO
ozp8AP97BdzdydMFXvDsCeRnXjJh+ZjSSO52H0t51A3rrvrtmwD+I+a3DQwcf00v
t9AfVXJJ+3iWZXZb6Mw31XNa6wPzQwU=
=CWvC
-----END PGP SIGNATURE-----

--ulctYQL3W5/kDSuY--
