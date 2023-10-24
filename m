Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B37D45B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjJXCtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjJXCtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:49:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF524D7C;
        Mon, 23 Oct 2023 19:49:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27e1eea2f0dso2143706a91.1;
        Mon, 23 Oct 2023 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698115749; x=1698720549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVsLY+T+frlNzIkA4CFr7Weie77YHu/MtNXkFtXeImU=;
        b=PpHqat7UBskqnGjF9nb7+MIy7y+ESBwE/P1PQfBSMOCQBG439cFZ3cOzd+FO6iTR1/
         soPqNMDHIF5HBZLHNyCQaPOFYSYXWqdNhVcG/JssyQLtwasLbXBgYBXZ+u5MoUBcYcr2
         mhsCC+RXVk0pt2AftP6VQfBGtINisxRUi72SE2LOifn/hNoNQQ1jj2+RbSpqZJ/JWcCR
         L6ZPVSTjeud2QIo1vLydALRSvKL6PF7bqhUTrc3rjg+IYe3Hw36aFEeOMBylx1ZcJ+Io
         IqY4IiXakSvVKaoM+PDv+yBGGmv4sHhwyj581muxmqB/6du6c/rkMlccGwf/Ql8dTezx
         X5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698115749; x=1698720549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVsLY+T+frlNzIkA4CFr7Weie77YHu/MtNXkFtXeImU=;
        b=hgVkljQOLpgVk5qAg2BsYtYnDN7kHRAglMvI2VClUv41aL4nX+nXGO28tbY5X5S+ko
         /B3+7HErwQaJcFhWn8GEFH35uGufB0uHmKWrZu3CTyJiBiuWNRM5FNPngNOiRJXVKeXw
         SshfeJ5BthLKrCGhE9hMf6dFD/wTiJQfzll5ZWQdZ4pkCR2JkmVjVoJcqNZwrE15F9JM
         E2rohuc5JRVI+EqLnElt3f7DPm3FN7521xVf+ZJQIZzBo6b6GS5FJ89KAnGkrwDLjCp2
         dWyyr7OL/RAHVH+KVh19BDztiWhLGyBoE2HL4tm98opXbjuSH2kwiblgW1RPs1kpHutW
         hZHg==
X-Gm-Message-State: AOJu0YzQ1hOg0TtdBIiUiLuh/24EcLbgttpEMeuhiIT9ibBJFLdR9PMP
        HB3i0Qg6Z6F8wIApu+YaRXM=
X-Google-Smtp-Source: AGHT+IHLyzVPkA4hnl2AdL6IpBmZ0xApdXiqnfPpjWULmzyQMg0qxYpVuIJg/DFvlgCmtqTBjbguHQ==
X-Received: by 2002:a17:90a:df95:b0:27d:4249:4040 with SMTP id p21-20020a17090adf9500b0027d42494040mr7884810pjv.43.1698115749277;
        Mon, 23 Oct 2023 19:49:09 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001c736370245sm6628325plb.54.2023.10.23.19.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:49:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0E98B835CB47; Tue, 24 Oct 2023 09:49:05 +0700 (WIB)
Date:   Tue, 24 Oct 2023 09:49:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Message-ID: <ZTcwoURTiNuvTLqt@debian.me>
References: <20231023104833.832874523@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EqdcrD72/hPiNIlf"
Content-Disposition: inline
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EqdcrD72/hPiNIlf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:53:06PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.9 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--EqdcrD72/hPiNIlf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTcwnAAKCRD2uYlJVVFO
o+0WAP94eZENF6MiUrUvOeoXW+781DqNKWbD30r5KyXqRDt3JAD/WFw3zpBi1C0Z
oUkb7VrL1V55aHO7O2u1ceyQv9EzXgM=
=E6zm
-----END PGP SIGNATURE-----

--EqdcrD72/hPiNIlf--
