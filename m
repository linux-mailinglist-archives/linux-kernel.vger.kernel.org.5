Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA878E60F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbjHaF7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjHaF7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:59:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09307E0;
        Wed, 30 Aug 2023 22:59:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26fc9e49859so342178a91.0;
        Wed, 30 Aug 2023 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693461591; x=1694066391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf4ZLHQJDSZ6LP6AyJ6FAFVwKlDmGeG8mwIgn9s5FDo=;
        b=OH/VqLtVxe3z+SemSb1icUSBoaHOCN+GroS/WAAKL63irDdrRepY0WdkyWq5B2jliV
         383C5SIZyDLS5Uh3lOgFa/Dhg29QlmRi9tBPAF0b40xGeQrlkSRnFbJG3aZTIYK0cgH8
         +h8IHBs2jBEC17CdOcKhkFYNSqJ6xybBO30VPmK/8QVrUVowSPiufoYnj6F540QXCeL+
         CKaX/nE1eqqDVzOWl/VT81zUrRZNFnCkwnoDcQ1Bku+J8GiENXP5Eq/tIgve6x4lzefH
         b9Lhfh4Mm8QBi60q9aia48i7CSBuuYb6AMLk2NIjArvpvpu3sqUKL1dIn6p7pH0YepMr
         RWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693461591; x=1694066391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf4ZLHQJDSZ6LP6AyJ6FAFVwKlDmGeG8mwIgn9s5FDo=;
        b=epgGWTdS5KqcqCeEX/KDnZyqVS8hjmc5SDSKwttvTJ3i0v8l5s5QkQil2yjQGuGV30
         2GeFv43skvopISZ1zNxR0pTTx3rEzIS8PdBn5a5Qo8AVmPtfQwC96JgGwD2fYwgq2sSv
         w572gIprJD1do2+jwOr7N/SJ3nIqLLj+9G1z4ZnpBLUecfchT99Zx5q+eELCUG3Xzccg
         EXNCicm5ZnJQ79+IbcaeYkigj9IybvjOoxBMF6iAWWLKHsGS4qrVNJseobPMhFquuQh+
         3tiknVbNRb5+rvmL2L5AVB5xHyZYtvj7VHR937V7HU3Wab1C77jpADudilviw09kID7W
         D2uQ==
X-Gm-Message-State: AOJu0YzmCIA2DKMetzQVhNoGvm698Y8CSnuRVq/uXtQf8+M3P6/NxOm6
        3xYa5gAdVkj/U11QiCZVuqsX8R5s/vU=
X-Google-Smtp-Source: AGHT+IE5hnyEGLipkDO9TTKdoDXpsktWQ5QVaIitLUAr5zJXsi0uL0HEXzLGFL1it0swdOmOyXwtXw==
X-Received: by 2002:a17:90a:b305:b0:263:e423:5939 with SMTP id d5-20020a17090ab30500b00263e4235939mr4273224pjr.28.1693461591407;
        Wed, 30 Aug 2023 22:59:51 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090ae61700b00268238583acsm2156218pjy.32.2023.08.30.22.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 22:59:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1474D8205DE8; Thu, 31 Aug 2023 12:59:47 +0700 (WIB)
Date:   Thu, 31 Aug 2023 12:59:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     youngbludproductions <youngbludproductions@proton.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH] Update: Fixing SSH Hardware Key Issue
Message-ID: <ZPAsU4Ywy44gqlt5@debian.me>
References: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/12qiNF5hL0WbB6p"
Content-Disposition: inline
In-Reply-To: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/12qiNF5hL0WbB6p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 05:20:19AM +0000, youngbludproductions wrote:
> Hey folks,
>=20
> I've been experiencing some weird behavior with SSH and my hardware key. =
After some investigation, I've identified the root cause and prepared a pat=
ch to address the issue.
>=20
> The patch modifies the SSH code to ensure proper handling of hardware key=
s, resolving the unexpected behavior. I've tested it extensively and it see=
ms to resolve the problem on my end.
>=20
> Please find the patch below:
>=20
> diff --git a/net/ssh.c b/net/ssh.c
> index 1234567..abcdefg 100644
> --- a/net/ssh.c
> +++ b/net/ssh.c
> @@ -123,7 +123,7 @@ static int ssh_handle_key(struct ssh_session *session=
, struct ssh_key *key)
>         /* Code to handle key goes here */
>         return 0;
>  }
>=20
> -// Additional changes go here
> +// Additional changes go here to fix the hardware key issue

What? Dummy diff?

Does configuring openssh not fix your issue so that you have to resort
to patching openssh package?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--/12qiNF5hL0WbB6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPAsSwAKCRD2uYlJVVFO
o+EKAP9TmiqOLbJWKdkc/KDxG3OiY0D5VH64KsVbmQx5Eom2qgD+KwWllvS4Xtbp
dpDArBYsw52SGAFlS4PGq8YPDY893ws=
=0eZy
-----END PGP SIGNATURE-----

--/12qiNF5hL0WbB6p--
