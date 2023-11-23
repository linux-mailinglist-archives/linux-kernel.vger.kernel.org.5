Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348877F55CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjKWBS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:18:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF192
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:18:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2806cbd43b8so347682a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700702311; x=1701307111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRDfm5lmN9oWHrfQ6RGbONVD1D7o4JaIn9KZ+LQPA/I=;
        b=EBCh9vWeg5KLbudqEqzwcN5PKz56TjyTBE5SgTUhf3ognGJRAgZxdhvmI7Rneb0j8y
         j2TvO4rcYiEunKwHVoDsoabKNRXTt5S7aUp8J+7D6wpBJ1hyZT3u0zhEcZj7BWWEeoiC
         LL/HPy1sQh10S+oLxJesG0p+zGEa2K+Hw193MCBpymkaDQj02dxyIv4ZkiO1qF/8XFTL
         iallNQTlKOP7WXgj8nnXbTz3z4snp1t+dDgywZRg8PHJEfhQ+e+eymQan+GPaB/0WGH3
         HmG8UzNk80fP9SsbLHPCrJ1ap28m/vf8iCh5YDZVf/BkHaP2FJ+hEz4TJ333RXaOmJH+
         NKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700702311; x=1701307111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRDfm5lmN9oWHrfQ6RGbONVD1D7o4JaIn9KZ+LQPA/I=;
        b=h67cOUITBNKYzCLNkpmvMQnk8wwSkEMDHlkCNyeW6TlguNHfGoOmpB+cmYUKweMTE5
         1UdikVbErXE+F85qPYqHQub5xiZWryHTbIYH2rQC6JnCd+68e47fgi2dkwu/+K9sYpIe
         qyNtbx9jdZ1vmeA5Icw/NfPX/UuJprqK+Y0Lz8tDk0BiPvpwXVRPk+SXVpKBuKjD41Sp
         CcQt1gQMAqsu7j7jFDWGS0bj5HU1mVgmQHbb4pGTBLuUpNnwyLrGkEaoqzzY7ONpoJ13
         inPVWA9qiWy15v3bXYxnNnn1lygyVHtF09vk3KQ/JDZ/VJAa4DVEabEZBxn0A8di9vLf
         3tJQ==
X-Gm-Message-State: AOJu0YxXU1W9X4nuhSsDvg+jdj5hSSYezXnsx1iLVi9iyip/+327RGEv
        vv3RoLLp8NIMpjq2LEEkDI0=
X-Google-Smtp-Source: AGHT+IGiPmnbiCr8qnLgZAg5BZ3NCj3W2Rf9JG7Dmc59vfKQewrzihV4UcH7z/Y6mGAULjLnD3YGLQ==
X-Received: by 2002:a17:90b:390e:b0:285:24bd:d8bb with SMTP id ob14-20020a17090b390e00b0028524bdd8bbmr4493019pjb.36.1700702311225;
        Wed, 22 Nov 2023 17:18:31 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b001cf5d59c739sm44126plh.271.2023.11.22.17.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:18:30 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 4BED510207143; Thu, 23 Nov 2023 08:18:26 +0700 (WIB)
Date:   Thu, 23 Nov 2023 08:18:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Message-ID: <ZV6oYmVYsyYizvgg@archie.me>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oBSe3tCHKA7p0yt4"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oBSe3tCHKA7p0yt4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 08:03:19PM +0000, Chun Ng wrote:
> Hi,
>=20
> Recently I observed there is performance regression on system call mmap(.=
=2E). I tried both vanilla kernels and Raspberry Pi kernels on a Raspberry =
Pi 4 box and the results are pretty consistent among them.
>=20
> Bisection showed that the regression starts from k-6.1, and the latest va=
nilla k-6.7 is still showing the same regression.
>=20
> The test program calls mmap/munmap for a 4K page with MAP_ANON and MAP_PR=
IVATE flags, and ftrace is used to measure the time spent on the do_mmap(..=
) call.=C2=A0 Measured time of a sample run with different vanilla kernel v=
ersions are:
> k-5.10 and k-6.0: ~157us
> k-6.1: ~194us
> k-6.7: ~214us
> Results are pretty consistent across multiple runs with a small percentag=
e variance.=C2=A0 Ftrace shows that latency of mmap_region(...) has increas=
ed since k-6.1.=C2=A0=C2=A0An application that makes frequent mmap(..) call=
s the accumulated extra latency is very noticeable.=20

Did you mean that v6.0 doesn't have this regression?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--oBSe3tCHKA7p0yt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV6oXwAKCRD2uYlJVVFO
o3C7AP4snmZptoM1ihlFeB/5xpLDHZSoqPN2u/eqYYB2SY8R2gEAi5WXVXAcjnzt
x6LuHUALRKh0Ndw9CLixARM1Duf1hws=
=zXF1
-----END PGP SIGNATURE-----

--oBSe3tCHKA7p0yt4--
