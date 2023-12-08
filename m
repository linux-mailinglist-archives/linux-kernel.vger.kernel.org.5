Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168AF809AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjLHESl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHESj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:18:39 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A641723
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:18:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c68da9d639so1310531a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 20:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702009124; x=1702613924; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Tnty8uGnrsIVXtmr+TvgEkcR6UqhS9WZGqa9cLAzU=;
        b=UMJjJUs5zN4ZD9xrC8PvcPqrsXHoXvrBCm4jrddzgnKeFOmXi9ivbn+7ldA6gJ/SnU
         Tmfk0jzvEC44Su9lU/j+abLVxsgbV6UXvp9suAW1Fjnru8ET/ztmZ/iR4sz4pW+PguXm
         if2Aj27cDUn8YINGO1UHpCwfhPls8XXDLvn0aR+dWo6diTYnEYKKxKHwfwwNAGWdCPkr
         oqpWQa4NSQ0cfO+0H1JjcXdP8oTY729u0otwFDKYI+wWjqK2CbYFjbtq5/Uhx1+NvbsF
         Nm71oELv6uKInx6I+WQq10JLmuNcgz2qbGzr2BxmaqW8J1JX6np67Z8Ysg6kJ+0+ZhsD
         TbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702009124; x=1702613924;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Tnty8uGnrsIVXtmr+TvgEkcR6UqhS9WZGqa9cLAzU=;
        b=Fw6V6L3tP77OpcoTiGPpN0oH+WJf4Nb6fTofkSnqSA8f7m1O0McQPyZtMZ7XVebBpI
         MWdqAXLYn46NqyKtR0HN5lWuWrgtzdjK7UcQdBHF3O+rAN7NJ3ipV+YtPRIX+B5fq/DQ
         eeMNdRVB8Yy/Z5nMv5pVkkmlO9+/CmLORoHOshTRaw4e74HdafSJIoshN76Rw7XPHbh2
         Mg7Mvs8UnoWoSBbjuB36ZU2kArVRJAzBwyt9dNk51NerSTyP52dT8T47PxqUMvZNxpWB
         QhH/ouL505SPgzGaGncIqYyLzmQ44eSxloo33l1XDTaGsoIROOElP8mLCSihCIrL0PQY
         mOIw==
X-Gm-Message-State: AOJu0YzWjXGoFUjF7jlO/AzdaVeNj9qsBkN5uczCufsfQWWK0r9lOaML
        YAwRsddOgZLe39Ya0ijFemaBig==
X-Google-Smtp-Source: AGHT+IFp9iNb7QqJ7wb16q4wxd1kROAdjldRBrd9Y5SAmktLgQrezvI5AuaKkgiGqBj1DHg2d5+eYA==
X-Received: by 2002:a17:90b:3b44:b0:286:815b:8c75 with SMTP id ot4-20020a17090b3b4400b00286815b8c75mr3090891pjb.16.1702009124417;
        Thu, 07 Dec 2023 20:18:44 -0800 (PST)
Received: from ?IPv6:2402:7500:4d5:3ce7:e047:b0e5:91bf:940? ([2402:7500:4d5:3ce7:e047:b0e5:91bf:940])
        by smtp.gmail.com with ESMTPSA id dw8-20020a17090b094800b0028862dc530bsm2235275pjb.25.2023.12.07.20.18.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 20:18:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 05/13] crypto: simd - Update `walksize` in simd
 skcipher
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <ZXKV/nLAQpUx6AX0@gondor.apana.org.au>
Date:   Fri, 8 Dec 2023 12:18:39 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, davem@davemloft.net,
        conor.dooley@microchip.com, ebiggers@kernel.org, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5684F139-A0DE-4A9A-B937-9DF5130E5BD7@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-6-jerry.shih@sifive.com>
 <ZXKV/nLAQpUx6AX0@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 8, 2023, at 12:05, Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
> On Mon, Nov 27, 2023 at 03:06:55PM +0800, Jerry Shih wrote:
>> The `walksize` assignment is missed in simd skcipher.
>>=20
>> Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
>> ---
>> crypto/cryptd.c | 1 +
>> crypto/simd.c   | 1 +
>> 2 files changed, 2 insertions(+)
>>=20
>> diff --git a/crypto/cryptd.c b/crypto/cryptd.c
>> index bbcc368b6a55..253d13504ccb 100644
>> --- a/crypto/cryptd.c
>> +++ b/crypto/cryptd.c
>> @@ -405,6 +405,7 @@ static int cryptd_create_skcipher(struct =
crypto_template *tmpl,
>> 		(alg->base.cra_flags & CRYPTO_ALG_INTERNAL);
>> 	inst->alg.ivsize =3D crypto_skcipher_alg_ivsize(alg);
>> 	inst->alg.chunksize =3D crypto_skcipher_alg_chunksize(alg);
>> +	inst->alg.walksize =3D crypto_skcipher_alg_walksize(alg);
>> 	inst->alg.min_keysize =3D crypto_skcipher_alg_min_keysize(alg);
>> 	inst->alg.max_keysize =3D crypto_skcipher_alg_max_keysize(alg);
>=20
> Sorry but this patch doesn't apply any more now that we have
> lskcipher.

The lskcipher is merged in kernel `6.7`. I will rebase the v3 series to =
`6.7` later.
Link: =
https://lore.kernel.org/all/20231205092801.1335-1-jerry.shih@sifive.com/

Some dependent patches are not applicable to `6.7` now. I will check the =
status for the
dependent patches.

-Jerry=
