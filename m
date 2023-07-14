Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F363D752F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjGNCKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjGNCKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:10:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A126AE;
        Thu, 13 Jul 2023 19:10:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8b318c5cfso10577655ad.1;
        Thu, 13 Jul 2023 19:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689300640; x=1691892640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPGMulbK/a/rKvX1GI7gs5doujr0+mvZklDpvLLKFU8=;
        b=o9SgcuWAj7F2evkgku61FwpY5FIN0Ep2UMIodKe1dZ6S8BDtxqclc4X/6jVHyctw6k
         dcgmVCcJZ3FWpJ8qZmeQYrJx7u3E0jR0jMBEQu4agoYwVpLeSH1x2PcYr2Y6rLmr+5qv
         0j9njedh15shbRVTBzE79Dgg9vHZUbzpiUajRV2EbAZz3kcdFpDB8jy2RrAthbHHK0Mc
         QK4J8aWgOmsLtNYKnNuzdUMCUOz5TZzZ25S4J5EzlJtGLR0dEoeS8R5puiVAGThvHL/N
         OLmoOEX5ojz/DUV5kZAtN4MW8WLlRnNwIIRAp3tgj4G+BKAfyeR9FpLzB3wGWY45y3jG
         X9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689300640; x=1691892640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPGMulbK/a/rKvX1GI7gs5doujr0+mvZklDpvLLKFU8=;
        b=dmr+E4R7mM5JXzdqlmdarc5lYSevmbaKJEbBsvSvCGR/ncmI3qHQrYnD7Li/J8l4hR
         5jISOVDF7YwBFPrLWLC+k1CjYwv+U3rVsNPaaCO/pxWyQp8S3Lj0CmZcC/vG2pwasEiz
         XmMSBvLu/LtdE+iNpH/vx43malHU2H1GJDqghs7mXCUVAo69oOnZQ2f7gQFbNbsDPnpk
         JWKmPoem5Lf0gSlfSUr9m2gTy5H5lN1n9jFeqto6/21k+RAosRvfuUHh/pMSoAr4bwfH
         kcPg1QnN1GxZPT0SEHaWYe3yst5JSjrHmtwivSY0VHmSjEuRCwD/kOQ+ovV+zfNF4Fmp
         efcg==
X-Gm-Message-State: ABy/qLY/lE4Bdzv7312LT+fFWKzZWfpKzD81NXZOO3Wu6MiFpLizxFaf
        fAH0ovaUeOAJlm0/9F8Baq7oMY7P35P+KZgV
X-Google-Smtp-Source: APBJJlHnzBhxfLpSwyycts4R+2MtTMuMSUEURNWPlAJPkT7puz3mUvuIGSn5V2dLbn+hS8uHuVi86g==
X-Received: by 2002:a17:902:c410:b0:1b6:9551:e2b8 with SMTP id k16-20020a170902c41000b001b69551e2b8mr4078027plk.34.1689300639924;
        Thu, 13 Jul 2023 19:10:39 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902cecd00b001b9cd9d7ce4sm6527496plg.219.2023.07.13.19.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:10:39 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A26BB80618F7; Fri, 14 Jul 2023 09:10:35 +0700 (WIB)
Date:   Fri, 14 Jul 2023 09:10:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Another regression in the af_alg series (s390x-specific)
Message-ID: <ZLCumw4oY5QGL8Wi@debian.me>
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8RhcC9HrFkuMH7pS"
Content-Disposition: inline
In-Reply-To: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8RhcC9HrFkuMH7pS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 10:03:45AM +0200, Ondrej Mosn=C3=A1=C4=8Dek wrote:
> Hi,
>=20
> It turns out that beneath the first bug [1] there was another one
> hiding. It seems to happen only on the s390x architecture when running
> the following libkcapi [2] reproducer:
>=20
> kcapi -x 2 -s -c "gcm(aes)" -i 0d92aa861746b324f20ee6b7 \
>     -k f4a6a5e5f2066f6dd9ec6fc5169c29043560ef595c9e81e76f42d29212cc581c \
>     -a "" -t 5f24c68cbe6f32c29652442bf5d483ad -q ""
>=20
> Frequently (but not always) it triggers an oops like this one:
>=20
> [ 3986.766763] Unable to handle kernel pointer dereference in virtual
> kernel address space
> [ 3986.766774] Failing address: 0000000a00000000 TEID: 0000000a00000803
> [ 3986.766776] Fault in home space mode while using kernel ASCE.
> [ 3986.766778] AS:00000000a43a0007 R3:0000000000000024
> [ 3986.766825] Oops: 003b ilc:2 [#1] SMP
> <snip>
> [ 3986.766877] CPU: 0 PID: 271064 Comm: kcapi Tainted: G        W
>     6.5.0-rc1 #1
> [ 3986.767070] Hardware name: IBM 8561 LT1 400 (z/VM 7.2.0)
> <snip>
> [ 3986.767151] Call Trace:
> [ 3986.767153]  [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
> [ 3986.767160]  [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
> [ 3986.767166]  [<00000000a2a60888>] aead_recvmsg+0x478/0x698
> [ 3986.767169]  [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
> [ 3986.767175]  [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
> [ 3986.767177]  [<00000000a273e066>] vfs_read+0x26e/0x2a8
> [ 3986.767182]  [<00000000a273e8c4>] ksys_read+0xbc/0x100
> [ 3986.767184]  [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
> [ 3986.767189]  [<00000000a312ff30>] system_call+0x70/0x98
> [ 3986.767193] Last Breaking-Event-Address:
> [ 3986.767193]  [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]
> [ 3986.767198] Kernel panic - not syncing: Fatal exception: panic_on_oops
>=20
> This time the regression was bisected to:
>=20
> commit c1abe6f570aff4b6d396dc551e60570d2f50bd79
> Author: David Howells <dhowells@redhat.com>
> Date:   Tue Jun 6 14:08:52 2023 +0100
>=20
>    crypto: af_alg: Use extract_iter_to_sg() to create scatterlists
>=20
> I can't see what the problem is with the commit, so I'm reporting here
> hoping that David or someone else can pick it up from here.
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: c1abe6f570aff4b
#regzbot title: kernel pointer dereference regression due to extract_iter_t=
o_sg()

--=20
An old man doll... just what I always wanted! - Clara

--8RhcC9HrFkuMH7pS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLCulgAKCRD2uYlJVVFO
o4LVAP4kVT6SdcE/KVVP722UHRtHwWu2fafTlhILPIAcai6CxgEA94XCkNYU2sa+
hrNlDgjv0m1noaEIFbImGjD0UkkHJgY=
=3nSU
-----END PGP SIGNATURE-----

--8RhcC9HrFkuMH7pS--
