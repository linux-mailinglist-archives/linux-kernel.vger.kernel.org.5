Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584547FCAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376428AbjK1XSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjK1XSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:18:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1D9198;
        Tue, 28 Nov 2023 15:18:52 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso3568376b3a.0;
        Tue, 28 Nov 2023 15:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701213532; x=1701818332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJfb8Ev4FQngJNMWt60qDvQUzvZyIitYBuhtl7HB7ms=;
        b=M/Pk4U1Y4OVz2ES8nFfBRUnRBZDaICGhir5OuJSrhR2c0LTg7Gi5v1c0TJJOSLwgcG
         072ZCwYhErUMwY/+YHqpPhOGqilKCuVQxKuTCXABxNEL4KiRlpwYPJNzpmzCI1kB53zm
         syTpMJnWd8x+BZKDnz1B74MeYRfp6xOGe0uItCGbr+MxK73j/u6Pxf7+ABRTzYn93kX8
         XDIjk6PX6YWWpFhsZ1sRvC/t7FMThVnNYm/rGNJdDWgF/obc5Wd89QLbgKKbDCtBT3YX
         DPm/QmF7/rhEb5hpizh1Smht+DLIAncdtyx8GRfzPkfojlWstn8rEzY0XMyTIWexZPzN
         F4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701213532; x=1701818332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJfb8Ev4FQngJNMWt60qDvQUzvZyIitYBuhtl7HB7ms=;
        b=UzdhVn4C/O0Xz+SunisGx68RC6USIjuh+6m96FwkpinnZmaUR/IYOwI60UudtvyokQ
         0SpqC6BTi8a77zSeUEwH6s9GkinNH23qmt7uIZrIasG/ZTZcNRbaaMj8jyKhriuMsprf
         qSt3FVEzFeuVS+I6jwzV7/dvLICYHdbZSeecfgYGhw0sdJPWtbWfOr0PmFPgGHJn5Q89
         agW8fbebf2vusBgsaDyIsVk4tE1X3jdxPYXBlnRACu8zE7OfVjjKOrjZX9L0WeclOe0R
         jmr4I1uxZYyPmBBjfR1fXxdxAx8upQFl0wKyg16PwPcwW3dG1DFDLuUbuWjYPAjtjzEi
         +iyw==
X-Gm-Message-State: AOJu0YwruTvnw1cajlQ+y+MG2D1KTU3kZs2idaFoo/n7qHFZNzS1rA4k
        9a/8+ABJx7GG9xvLUzwCKaA=
X-Google-Smtp-Source: AGHT+IF/plHB5gXIJkREqoI4DCoI+v2816GheXyYF8KwECvmk0TEo2cNkYm3UK5WRVa3n6ChbtP0Tg==
X-Received: by 2002:a05:6a20:42a3:b0:187:ce5a:2a90 with SMTP id o35-20020a056a2042a300b00187ce5a2a90mr24569662pzj.51.1701213531926;
        Tue, 28 Nov 2023 15:18:51 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78043000000b006933f85bc29sm9404108pfm.111.2023.11.28.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:18:51 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 789751025EE67; Wed, 29 Nov 2023 06:18:49 +0700 (WIB)
Date:   Wed, 29 Nov 2023 06:18:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Pawel <pawel.veselov@gmail.com>
Subject: Re: Fwd: 6.5.5 hardware access timeout / HW error / GPF in iwlwifi
Message-ID: <ZWZ1WYWp-vigRNN7@archie.me>
References: <9fa3c04b-bd98-4fde-9bfd-27d83132e766@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CjzFAuf1OzzSKykF"
Content-Disposition: inline
In-Reply-To: <9fa3c04b-bd98-4fde-9bfd-27d83132e766@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CjzFAuf1OzzSKykF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 06:11:35PM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217963
>=20

#regzbot resolve: fixed by distro (Fedora) upgrade

--=20
An old man doll... just what I always wanted! - Clara

--CjzFAuf1OzzSKykF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWZ1VQAKCRD2uYlJVVFO
o8CAAP0XlrWdIRMofAZO/oiL8cPLqdo5cDTJ3OYGXpM4zZuKmAEAuld1gxhIiTjs
LCOPaRJ+LB6+n21SNyaGaYzuWk90twI=
=3HvI
-----END PGP SIGNATURE-----

--CjzFAuf1OzzSKykF--
