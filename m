Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5805576CA5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjHBKEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjHBKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:04:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818EBB2;
        Wed,  2 Aug 2023 03:04:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686bc261111so4807797b3a.3;
        Wed, 02 Aug 2023 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690970666; x=1691575466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzdlr2mIcU2IrFz9o3Jf4YUjcTGYzuN5We6AMeqKFnM=;
        b=e0A+IMR4AQ69oBEH2PJ3vOWNecXFxEcr7qFduFBebgjyFo/sQDQvHu5QC18G567l9P
         wXBGYZ5gSQuuqopSKqJZMyjQqMuAK3sUmf3J5tO3RXgK8bHckDXyiv6bnH8+MGic7xTG
         LiH3GyxzC6EYqefD3tC2GjuB7nALQYZPEaXjkHNUxCrDm8Sh9rarVZijiPaf+aezchZx
         /01US6LpZsPrV6dYm6BZ0y2IsjGRoSUiHMHjW8o3JQFgfoTRFk+wlyGDoGU5LfeDizoO
         SUwz6orr/dfou3oyzIPdEIwpjIjyfw7FhpLk4MwYKzT9ubMn0IdTTLkSLmNkWHaYGDpH
         f2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970666; x=1691575466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzdlr2mIcU2IrFz9o3Jf4YUjcTGYzuN5We6AMeqKFnM=;
        b=NJGmxZt4GDTLYMy0zHvrtG95KV0C9htFCs1b3WA44FgVkZy8snApFvqHFUHct1c91/
         gEAVXWVou8HxAd7e8XZVOebkaBuqMUIJaIotNo3nApi/FZuLjLcq2JrL4dzppnnIcu8g
         S1Z7Y51F6nQbGTQwNhWCZrjdQMRqXZB44rLrJyD1BYodWC2jv0K1b2xLLxm2t/gdHBZL
         WFVt14gD8LJtcQCqYwVrhCSOhaTH49k4lp5WWBxjmiyA34BS99JAIR0Ou2ptEjsROc6Q
         YQE0P3RK/oiAYAld68f15vwHiYBq6EDMJ8LU/yJaEDF3ZpvVK9RLYfDv47DO1qfM+WJJ
         QzWw==
X-Gm-Message-State: ABy/qLZKLAYWrHthg6TRGJkjwJeH5IvlUqG/ULUfXNqC1K/BIUXyQLon
        UEDUivZoLvslBnfgiZEbTZE=
X-Google-Smtp-Source: APBJJlGonZPiBMK7/fd5/8vi7ZRncqWa4B1zav+8WCXhfN2F1WjwSMGZnigR6KOpwFBPpoHzeQfiUg==
X-Received: by 2002:a05:6a21:338c:b0:13c:b7e9:7a22 with SMTP id yy12-20020a056a21338c00b0013cb7e97a22mr15598546pzb.13.1690970665781;
        Wed, 02 Aug 2023 03:04:25 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78c18000000b0067b643b814csm10771972pfd.6.2023.08.02.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 03:04:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E10748197C37; Wed,  2 Aug 2023 17:04:21 +0700 (WIB)
Date:   Wed, 2 Aug 2023 17:04:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/228] 6.1.43-rc1 review
Message-ID: <ZMoqJXlKE/Z3zIEx@debian.me>
References: <20230801091922.799813980@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wKNwIsNqkSXovGwe"
Content-Disposition: inline
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wKNwIsNqkSXovGwe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 11:17:38AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--wKNwIsNqkSXovGwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMoqGwAKCRD2uYlJVVFO
o/7zAQCS7CnZISr6lL2mKcyEz5apiccehhYMQWs8cNZZcWfLZwD/d1fCvAmWTQjk
pKjMathiJyOsJm5lW1eN44F21g4vSQU=
=Hspl
-----END PGP SIGNATURE-----

--wKNwIsNqkSXovGwe--
