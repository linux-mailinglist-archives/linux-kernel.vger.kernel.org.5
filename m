Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93A57FB15B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbjK1Fia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjK1Fi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:38:29 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076BFDA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:38:35 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b844357f7cso3202514b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701149914; x=1701754714; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3smZGD6pLNRGkaXwEXKVlmQX+QFLadDCcT3fwIXSsw=;
        b=nbfwNWSoboTplLxvdYf114aUHYh0v2VFFkU+CLo3nXdQxi6lL2B3xq/q1CixUJyN4i
         I8Ix2Uem4kIFVGyW/zVshhU1DO3z0TurBLEsWa2/+bivLKz9Te8uPiVqDvA/A1wsJTPn
         uuG+2PzXKNsx2JhxxSDizCl5umvE2fNaCrNLGLih0mOqJhmDifeQUK9+FpoRWRQOlU1F
         ltfkVTp00e4X0tCgxVgHDR/v1LHw40FJEGNCu/vAwV23UtFwTvCnK0s00Qlh7ebVTm/u
         s39uMjAdUAOj9y1U+pwSIaWqtcDDSfz2z6w3uCYXo/1+OFdj85qGmjnNeWWozfrMmwnx
         Gcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149914; x=1701754714;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3smZGD6pLNRGkaXwEXKVlmQX+QFLadDCcT3fwIXSsw=;
        b=wlUZemIuGK23V7jFHOMdCYeHrgm/gFdM2OhMcyrC7LTWVpX/BM7GarDFf9zbo3eEtT
         GTwT+pCsjNR+pQVBZ+apEIsRs8ve3F0/GFw+4/SoozfpSSLKtfFwy0FfQLIKcxv6mgYE
         t9VUrzx2C5XHZapa9Wlwi7guAX70gowbcH+Ao44tB5u83NGmixmAzZ9p0I6jOYObncyA
         lbYYgy9vGKWoe9/E/Y3Xol0w4oqJ94/OqGJd0CppTwd5oF88Cg++oczIxH+xvNr6cGeD
         kTbTRpXXF6WAEYthvPl4EgvInlNur2IE+V+YGNGqp8ncOMkK5vXPo0px5bIaplFBEYcf
         5Rsw==
X-Gm-Message-State: AOJu0YzhNsr5NQUsN4G+lCq9f/c26dI8s13CTL7NFdp6ofdWFQSk4Lun
        SpAgDcVVjo+VFzXaGVTvhmU98g==
X-Google-Smtp-Source: AGHT+IEwY+qDOH5RdVmpp3afIODK9OZ2MAKzfbsV5gxBTlRaiFetM3EKZhzvR/gD6Q8ZvgHWcrukkA==
X-Received: by 2002:a05:6808:1901:b0:3ae:5e0e:1671 with SMTP id bf1-20020a056808190100b003ae5e0e1671mr20436537oib.4.1701149914332;
        Mon, 27 Nov 2023 21:38:34 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:8338:14c0:b892:2482:e230? ([2402:7500:4ce:8338:14c0:b892:2482:e230])
        by smtp.gmail.com with ESMTPSA id r10-20020aa78b8a000000b006cbb3512266sm8087953pfd.1.2023.11.27.21.38.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2023 21:38:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 05/13] crypto: simd - Update `walksize` in simd
 skcipher
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231128035814.GH1463@sol.localdomain>
Date:   Tue, 28 Nov 2023 13:38:29 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <56F07E23-CA7D-466B-84C7-643F2839E199@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-6-jerry.shih@sifive.com>
 <20231128035814.GH1463@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2023, at 11:58, Eric Biggers <ebiggers@kernel.org> wrote:
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
>>=20
>> diff --git a/crypto/simd.c b/crypto/simd.c
>> index edaa479a1ec5..ea0caabf90f1 100644
>> --- a/crypto/simd.c
>> +++ b/crypto/simd.c
>> @@ -181,6 +181,7 @@ struct simd_skcipher_alg =
*simd_skcipher_create_compat(const char *algname,
>>=20
>> 	alg->ivsize =3D ialg->ivsize;
>> 	alg->chunksize =3D ialg->chunksize;
>> +	alg->walksize =3D ialg->walksize;
>> 	alg->min_keysize =3D ialg->min_keysize;
>> 	alg->max_keysize =3D ialg->max_keysize;
>=20
> What are the consequences of this bug?  I wonder if it actually =
matters?  The
> "inner" algorithm is the one that actually gets used for the "walk", =
right?
>=20
> - Eric

Without this, we might still use chunksize or cra_blocksize as the =
walksize
even though we setup with the larger walksize.

Here is the code for the walksize default value:
	static int skcipher_prepare_alg(struct skcipher_alg *alg)
	{
		...
		if (!alg->chunksize)
			alg->chunksize =3D base->cra_blocksize;
		if (!alg->walksize)
			alg->walksize =3D alg->chunksize;

And we already have the bigger walksize for x86 aes-xts.
		.base =3D {
			.cra_name		=3D "__xts(aes)",
			...
		},
		.walksize	=3D 2 * AES_BLOCK_SIZE,

The x86 aes-xts only uses one `walk` to handle the tail elements. It =
assumes
that the walksize contains 2 aes blocks. If walksize is not set =
correctly, maybe
some tail elements is not processed in simd-cipher mode for x86 aes-xts.

-Jerry=
