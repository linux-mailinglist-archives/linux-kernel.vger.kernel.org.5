Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D897A2B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbjIPAFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjIPAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:05:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9339B2102;
        Fri, 15 Sep 2023 17:05:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fb2e9ebbfso2263879b3a.2;
        Fri, 15 Sep 2023 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694822713; x=1695427513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBFU91Ab8Ty50yBCscF+Su8H4xiggY1DMOJHupjwHzg=;
        b=iR0jblj6A4F3WEwG0SY1rSNR3HzQymwwpzmcST0dKpzLP4Dboq9QmxzPyrebEPxS3n
         QJvKCzw2b6gLni10oXASC6oenaRPcJKSUNEmVz/L3wDnYVSFXkqaO4IaTfeKUHtmNIbg
         J0WH1YwAbxRQrJPAJGm/hpUiAFwR05DL+8w4iefR8txGUug7Jd0+SG1r91PYY8DnPid7
         w3NiOV2jAZzETh6GMX/M15XRYhFrBj/YfwUB8wMYxQu6ejo7AqS9Vn+y4AgDot2OrxBc
         IfJvTNDngVFnLIRhY1f0DH4VA9v6xXsw+HHG5Bfaoxqol3CeA0awWRTUF3Km4+4Eruh+
         XJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694822713; x=1695427513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBFU91Ab8Ty50yBCscF+Su8H4xiggY1DMOJHupjwHzg=;
        b=Dw4At7CEPRITC/Wm33K0D3wNod1Y3IRbz3gUHUQdbs2feq13z6y9xinpugFF3YoDdM
         Ee8pUxHbR9De2LWjjAXoAAlRxaBWBZ1SByV4M8NIxiCg9EL1Jyu4X4UhAFMTP0uUlhAC
         p1CkziOuk221bnX8TvrldyQINtEB8W2PozB0A4N15/geR8ZPRG8/GBXYK8CLkz88eWmW
         0Rac5gfEkQS8gUF+6fiWrhQzxHQ2RdZumj4kcWC585xofd8Dcqw5MtGar1aaUfGwb7UH
         PtopU71PtccAMGKip8bgZv7d6hdmemfNQqK43MmutJCDI1RG36sOl+UGZDe2udBpZlS9
         WCyg==
X-Gm-Message-State: AOJu0YyeVTYRHS+KV7MesUFXObrEe4kc5G0JwUqGbh71G3nHSl3Uu7pj
        0Yhvl0K8+EphHZ5vcL723wI=
X-Google-Smtp-Source: AGHT+IF0Gziwgjs8IBkPNW32gp0eqmvsqmMuvS0x7PTIdUhgCFb6Vt3ZXEPLS8yJVzATlvoLr0H0cw==
X-Received: by 2002:a05:6a00:1588:b0:68c:4e22:8f78 with SMTP id u8-20020a056a00158800b0068c4e228f78mr3528463pfk.25.1694822712935;
        Fri, 15 Sep 2023 17:05:12 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c5-20020aa78805000000b0068ff6d21563sm3569946pfo.148.2023.09.15.17.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 17:05:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 33456811F023; Sat, 16 Sep 2023 07:05:07 +0700 (WIB)
Date:   Sat, 16 Sep 2023 07:05:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Tester47 <e598@gmx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux TTY & Serial <linux-serial@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: Fwd: Kernel 6.6-rc1 fails to reboot or shutdown Ryzen 5825U
Message-ID: <ZQTxM0JdyV8mpxbt@debian.me>
References: <2bc62c07-2195-e378-c057-f28e8d4a6034@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xh9/EH8MO3HbfOrP"
Content-Disposition: inline
In-Reply-To: <2bc62c07-2195-e378-c057-f28e8d4a6034@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xh9/EH8MO3HbfOrP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 02:03:00PM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: v6.5..v6.6 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217905
> #regzbot title: shutdown/reboot hang on Ryzen 5825U (stuck on amdgpu init=
ialization)
>=20

Fixing up commit range:

#regzbot introduced: v6.5..v6.6-rc1

--=20
An old man doll... just what I always wanted! - Clara

--Xh9/EH8MO3HbfOrP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQTxLQAKCRD2uYlJVVFO
o8rgAPwIzBXYXKeK6pcEOYV2weLfbQUqgqPF2jOk3Ec5KM6KWQD/bUH8Sr/mt0Fy
cMDw3XSd1I3kgWf0GonS0cLKCV7tpQ0=
=kMdp
-----END PGP SIGNATURE-----

--Xh9/EH8MO3HbfOrP--
