Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6834E7F979D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjK0CtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjK0CtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:49:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E91111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:49:11 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf5901b4c8so30945375ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701053351; x=1701658151; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKAcGhLjW+Mvs5EpwSa0BHJFl4vGnQQP4AO9iXzVC3M=;
        b=UnTj1UacMJKgFE4IjPRh7dJS5+/MaaRy2zAEleoHRt/iAtu3Rmeg7SvBMNBvvECl2n
         d1KNL4YueVueRSlk6LJoVSuxCP3K3qJnkkO4Xzr/vHHvelsaHxcswWR3SVB5fNTTJ18N
         cqfQpVSgSzZJyYPV8T0g+ElMHV1ZpmToLH9ZIrW6dUvldv8myzoGs/d5XWNr8Ao/JOId
         SQMrelHj3w+JX63p9ZRSskpYz9+xInFNq13bH4RMkR5vpUZzuLL0bn+oB6jWxbfxnhCn
         C912OuMu3m/wmZzCnU6QvhR3PMobNkHrDA3e5hBv1aPsqD0BbHxeEutX8R8Lul6hp5JP
         +KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701053351; x=1701658151;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKAcGhLjW+Mvs5EpwSa0BHJFl4vGnQQP4AO9iXzVC3M=;
        b=DtYTLbLwlIL+fZIHHL+WvwBXDiI+LJt/cX8w+6TyfhH/SqmyOEVFXPECAsMTyugWzK
         f6HP4qnfJVWRUkwjS2ITLRxOw+U5AlxeY61A77fiGPuwyz1TEGL8HP45OPOv1+F2u0Hg
         myR8Z86V5RY3H6ogVhsqzDjCLu5dwNbpZqGIyxFVE6q65eUPrsTIgLzYIaNpGip+D+Ug
         xqeFl/y40BillO2Zi13uf1X3DthK+WQh5zIPOuaoQ6KYSG8V9fhZvI72aONNl+mxmDp6
         N2pj3vQkvqmR5/WdAJTLDF74Y1RJrLXrHemLsV4OCLZG8uMDwAisRKG+6A06yKjalOWf
         LXvQ==
X-Gm-Message-State: AOJu0YxH3WYqIIMQPlXuzh8rmNYKKclg3IcN58nQN9TGkf4/K53QjM1j
        3up39FjFRKec9UME6m+cq3WWuQ==
X-Google-Smtp-Source: AGHT+IEJDX1ywIRA2yybgn0V12rpBI4hcbgHrdWUbOpGdBuIKseg3QyOMxgm76BvwV0ixIdrwd6rOQ==
X-Received: by 2002:a17:902:9f87:b0:1cc:4e46:3e45 with SMTP id g7-20020a1709029f8700b001cc4e463e45mr11188671plq.49.1701053351105;
        Sun, 26 Nov 2023 18:49:11 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:95c7:2856:b238:775:b338? ([2402:7500:4ce:95c7:2856:b238:775:b338])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b001b898595be7sm7028182plk.291.2023.11.26.18.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 18:49:10 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 07/12] RISC-V: crypto: add Zvkg accelerated GCM GHASH
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231122014216.GI2172@sol.localdomain>
Date:   Mon, 27 Nov 2023 10:49:05 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1C10635-7799-4400-B85E-746D156D714A@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-8-jerry.shih@sifive.com>
 <20231122014216.GI2172@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
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

On Nov 22, 2023, at 09:42, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:39AM +0800, Jerry Shih wrote:
>> +struct riscv64_ghash_context {
>> +	be128 key;
>> +};
>> +
>> +struct riscv64_ghash_desc_ctx {
>> +	be128 shash;
>> +	u8 buffer[GHASH_BLOCK_SIZE];
>> +	u32 bytes;
>> +};
>=20
> I recommend calling the first struct 'riscv64_ghash_tfm_ctx', and =
making the
> pointers to it be named 'tctx'.  That would more clearly distinguish =
it from the
> desc_ctx / dctx.

Fixed.

>> +
>> +typedef void (*ghash_func)(be128 *Xi, const be128 *H, const u8 *inp,
>> +			   size_t len);
>> +
>> +static inline void ghash_blocks(const struct riscv64_ghash_context =
*ctx,
>> +				struct riscv64_ghash_desc_ctx *dctx,
>> +				const u8 *src, size_t srclen, ghash_func =
func)
>> +	if (crypto_simd_usable()) {
>> +		kernel_vector_begin();
>> +		func(&dctx->shash, &ctx->key, src, srclen);
>> +		kernel_vector_end();
>=20
> The indirection to ghash_func is unnecessary, since the only value is
> gcm_ghash_rv64i_zvkg.
>=20
> This also means that ghash_update() should be folded into =
ghash_update_zvkg(),
> and ghash_final() into ghash_final_zvkg().

Fixed. The `gcm_ghash_rv64i_zvkg()` is folded into `ghash_update_zvkg()` =
and
`ghash_final_zvkg()`.

>> +	} else {
>> +		while (srclen >=3D GHASH_BLOCK_SIZE) {
>> +			crypto_xor((u8 *)&dctx->shash, src, =
GHASH_BLOCK_SIZE);
>> +			gf128mul_lle(&dctx->shash, &ctx->key);
>> +			srclen -=3D GHASH_BLOCK_SIZE;
>> +			src +=3D GHASH_BLOCK_SIZE;
>> +		}
>> +	}
>=20
> The assembly code uses the equivalent of the following do-while loop =
instead:
>=20
>        do {
>                srclen -=3D GHASH_BLOCK_SIZE;
>        } while (srclen);
>=20
> I.e., it assumes the length here is nonzero and a multiple of 16, =
which it is.
>=20
> To avoid confusion, I recommend making the C code use the same =
do-while loop.

Fixed.

>>       const struct riscv64_ghash_context *ctx =3D
>>              crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
>=20
> crypto_tfm_ctx(crypto_shash_tfm(tfm)) should be crypto_shash_ctx(tfm)

Fixed.
But the original code do the same thing.

>> +static int ghash_final(struct shash_desc *desc, u8 *out, ghash_func =
func)
>> +{
>> +	const struct riscv64_ghash_context *ctx =3D
>> +		crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
>> +	struct riscv64_ghash_desc_ctx *dctx =3D shash_desc_ctx(desc);
>> +	int i;
>> +
>> +	if (dctx->bytes) {
>> +		for (i =3D dctx->bytes; i < GHASH_BLOCK_SIZE; i++)
>> +			dctx->buffer[i] =3D 0;
>> +
>> +		ghash_blocks(ctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE, =
func);
>> +		dctx->bytes =3D 0;
>> +	}
>> +
>=20
> Setting dctx->bytes above is unnecessary.

Fixed.

>> +static int ghash_init(struct shash_desc *desc)
>> +{
>> +	struct riscv64_ghash_desc_ctx *dctx =3D shash_desc_ctx(desc);
>> +
>> +	*dctx =3D (struct riscv64_ghash_desc_ctx){};
>> +
>> +	return 0;
>> +}
>> +
>> +static int ghash_update_zvkg(struct shash_desc *desc, const u8 *src,
>> +			     unsigned int srclen)
>> +{
>> +	return ghash_update(desc, src, srclen, gcm_ghash_rv64i_zvkg);
>> +}
>> +
>> +static int ghash_final_zvkg(struct shash_desc *desc, u8 *out)
>> +{
>> +	return ghash_final(desc, out, gcm_ghash_rv64i_zvkg);
>> +}
>> +
>> +static int ghash_setkey(struct crypto_shash *tfm, const u8 *key,
>> +			unsigned int keylen)
>> +{
>> +	struct riscv64_ghash_context *ctx =3D
>> +		crypto_tfm_ctx(crypto_shash_tfm(tfm));
>> +
>> +	if (keylen !=3D GHASH_BLOCK_SIZE)
>> +		return -EINVAL;
>> +
>> +	memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct shash_alg riscv64_ghash_alg_zvkg =3D {
>> +	.digestsize =3D GHASH_DIGEST_SIZE,
>> +	.init =3D ghash_init,
>> +	.update =3D ghash_update_zvkg,
>> +	.final =3D ghash_final_zvkg,
>> +	.setkey =3D ghash_setkey,
>=20
> IMO it's helpful to order the shash functions as follows, both in =
their
> definitions and their fields in struct shash_alg:
>=20
>    setkey
>    init
>    update
>    final
>=20
> That matches the order in which they're called.

I have different opinion. I reorder the initialization in the order =
declared.
That will help us to check whether the function/member is missed.

> - Eric


-Jerry=
