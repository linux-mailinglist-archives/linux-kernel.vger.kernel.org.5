Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38737F976D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjK0COa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0CO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:14:28 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07425111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:14:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so2702049b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701051273; x=1701656073; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQuCTKkjoab2EfyY20C3fybDK6Ql2G05fa9QjwE7uds=;
        b=ag7MrEnEez3mjHPzhmWO7eP5KpzOrOq8iR7X7TlOKpQ09p/TFNsC3a+9thyah0Dffw
         ICI6SOOyga/rXyUoM6Mvb7StVcKBS+8ia+4EkPVW/NgoSIO5QVW4gsvNC8wILMrJSj9s
         cSXyE/Ckgyz4DjiTa7USt/ou67dxNYFz1y4BHylxS0yD+LKWDRczNgs5cvsRXdd4uu9q
         OWmGwO5XD1Og+/UgFSaZ5ce1+KhAk+sEoLO53b0Ps7X95vaOou1ioo1ABNLITOnG7XbN
         nsXDsE/8ElW172x7/DqodrE4ZZvq0eEVSpHcCcTjOzonIO52tQvsBCgdFzPE5qsaQotn
         HQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701051273; x=1701656073;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQuCTKkjoab2EfyY20C3fybDK6Ql2G05fa9QjwE7uds=;
        b=dRzgXVTYdK8YGq+X0/twFmWqQvvqDRxjmjLYtTgimyB/2QmFa70gMf//rmpr4jbtl0
         u0sQ0WGqwgPR6T228O2JKzI82V/aTHfx6kf6FbEXL3DeGu7YQeIwAfdqCwp9oONVWMje
         Wz6oD3KolM9pIgv8SWPzcaANxywzDiAIqK0Y7nSbH4Jkj5A2FjoCyKZaavWK7jSK859o
         C706SnZjoFbJHXdcbNk5sUTfxEQHDJ+attB4JyVsVhwu9tMe5va8q821eKighI/mdbog
         2iOZnHE/ZH+iyNEBrCZimSBOLyCy2UjFlRgL58QfKx56VtHrNklsMIooqo4W8CiggC91
         vssQ==
X-Gm-Message-State: AOJu0Yy6qjDCtbT9fvkFm5HvGHSHx1gemWJdSKffpZ2D91oq850pl5KI
        LCn7TlvtW4rqK50ywbtWyO7UwQ==
X-Google-Smtp-Source: AGHT+IGCytZMxu7H10W/RpstzoB24pSc/2pOM0mtxh/XBOupAfkyHHRrNPwHxAWsSzb0+rVLqYYqmg==
X-Received: by 2002:a05:6a20:8403:b0:18b:a011:f955 with SMTP id c3-20020a056a20840300b0018ba011f955mr10693520pzd.60.1701051273409;
        Sun, 26 Nov 2023 18:14:33 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:95c7:2856:b238:775:b338? ([2402:7500:4ce:95c7:2856:b238:775:b338])
        by smtp.gmail.com with ESMTPSA id q16-20020a63cc50000000b0059b782e8541sm6831644pgi.28.2023.11.26.18.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 18:14:32 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231122012933.GG2172@sol.localdomain>
Date:   Mon, 27 Nov 2023 10:14:27 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <69B2D415-3626-4D6C-B559-0724EC1CD853@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
 <20231122012933.GG2172@sol.localdomain>
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

On Nov 22, 2023, at 09:29, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:44AM +0800, Jerry Shih wrote:
>> diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c =
b/arch/riscv/crypto/chacha-riscv64-glue.c
>> new file mode 100644
>> index 000000000000..72011949f705
>> --- /dev/null
>> +++ b/arch/riscv/crypto/chacha-riscv64-glue.c
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Port of the OpenSSL ChaCha20 implementation for RISC-V 64
>> + *
>> + * Copyright (C) 2023 SiFive, Inc.
>> + * Author: Jerry Shih <jerry.shih@sifive.com>
>> + */
>> +
>> +#include <asm/simd.h>
>> +#include <asm/vector.h>
>> +#include <crypto/internal/chacha.h>
>> +#include <crypto/internal/simd.h>
>> +#include <crypto/internal/skcipher.h>
>> +#include <linux/crypto.h>
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +
>> +#define CHACHA_BLOCK_VALID_SIZE_MASK (~(CHACHA_BLOCK_SIZE - 1))
>> +#define CHACHA_BLOCK_REMAINING_SIZE_MASK (CHACHA_BLOCK_SIZE - 1)
>> +#define CHACHA_KEY_OFFSET 4
>> +#define CHACHA_IV_OFFSET 12
>> +
>> +/* chacha20 using zvkb vector crypto extension */
>> +void ChaCha20_ctr32_zvkb(u8 *out, const u8 *input, size_t len, const =
u32 *key,
>> +			 const u32 *counter);
>> +
>> +static int chacha20_encrypt(struct skcipher_request *req)
>> +{
>> +	u32 state[CHACHA_STATE_WORDS];
>=20
> This function doesn't need to create the whole state matrix on the =
stack, since
> the underlying assembly function takes as input the key and counter, =
not the
> state matrix.  I recommend something like the following:
>=20
> diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c =
b/arch/riscv/crypto/chacha-riscv64-glue.c
> index df185d0663fcc..216b4cd9d1e01 100644
> --- a/arch/riscv/crypto/chacha-riscv64-glue.c
> +++ b/arch/riscv/crypto/chacha-riscv64-glue.c
> @@ -16,45 +16,42 @@
> #include <linux/module.h>
> #include <linux/types.h>
>=20
> -#define CHACHA_KEY_OFFSET 4
> -#define CHACHA_IV_OFFSET 12
> -
> /* chacha20 using zvkb vector crypto extension */
> asmlinkage void ChaCha20_ctr32_zvkb(u8 *out, const u8 *input, size_t =
len,
> 				    const u32 *key, const u32 *counter);
>=20
> static int chacha20_encrypt(struct skcipher_request *req)
> {
> -	u32 state[CHACHA_STATE_WORDS];
> 	u8 block_buffer[CHACHA_BLOCK_SIZE];
> 	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
> 	const struct chacha_ctx *ctx =3D crypto_skcipher_ctx(tfm);
> 	struct skcipher_walk walk;
> 	unsigned int nbytes;
> 	unsigned int tail_bytes;
> +	u32 iv[4];
> 	int err;
>=20
> -	chacha_init_generic(state, ctx->key, req->iv);
> +	iv[0] =3D get_unaligned_le32(req->iv);
> +	iv[1] =3D get_unaligned_le32(req->iv + 4);
> +	iv[2] =3D get_unaligned_le32(req->iv + 8);
> +	iv[3] =3D get_unaligned_le32(req->iv + 12);
>=20
> 	err =3D skcipher_walk_virt(&walk, req, false);
> 	while (walk.nbytes) {
> -		nbytes =3D walk.nbytes & (~(CHACHA_BLOCK_SIZE - 1));
> +		nbytes =3D walk.nbytes & ~(CHACHA_BLOCK_SIZE - 1);
> 		tail_bytes =3D walk.nbytes & (CHACHA_BLOCK_SIZE - 1);
> 		kernel_vector_begin();
> 		if (nbytes) {
> 			ChaCha20_ctr32_zvkb(walk.dst.virt.addr,
> 					    walk.src.virt.addr, nbytes,
> -					    state + CHACHA_KEY_OFFSET,
> -					    state + CHACHA_IV_OFFSET);
> -			state[CHACHA_IV_OFFSET] +=3D nbytes / =
CHACHA_BLOCK_SIZE;
> +					    ctx->key, iv);
> +			iv[0] +=3D nbytes / CHACHA_BLOCK_SIZE;
> 		}
> 		if (walk.nbytes =3D=3D walk.total && tail_bytes > 0) {
> 			memcpy(block_buffer, walk.src.virt.addr + =
nbytes,
> 			       tail_bytes);
> 			ChaCha20_ctr32_zvkb(block_buffer, block_buffer,
> -					    CHACHA_BLOCK_SIZE,
> -					    state + CHACHA_KEY_OFFSET,
> -					    state + CHACHA_IV_OFFSET);
> +					    CHACHA_BLOCK_SIZE, ctx->key, =
iv);
> 			memcpy(walk.dst.virt.addr + nbytes, =
block_buffer,
> 			       tail_bytes);
> 			tail_bytes =3D 0;

Fixed.
We will only use the iv instead of the full chacha state matrix.

