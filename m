Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5ED7FB0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjK1EWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjK1EW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:22:26 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56821B4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:22:32 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-285afc7d53aso1996859a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701145352; x=1701750152; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgMs+FA2uRdRydo7QTTHxfVxYoJ/VeG+Rds1RS5XwD8=;
        b=Hy07jg0MuqnwNm4DA0cu4x/ElnfhbU7e/LQMQu1j4EHx18FAnCCB2L9oTvhfegZAnU
         Ai1bHebbmbMDlUTfED53lkCoT5BDlYlYpmhi7XWYKBm0KDk5PGRNlgiCMVpomEf2xWcS
         prlldTU+IHVZvxG/UG8EJmO4hppsKYEcvYXyul0ThdiSq8fjgMfJVIUkbxVdqBpbvL1O
         psnc7u3jKLMe5J5aGHF6IyG0wrONPvb+0WL3HfHoD510tKHEBNuzbl82ASNn4grryNp4
         y5uyKpiRR/Ic62yjQpYZH4+3bGAQiM8JfeotD3SLwAa353SPgwCIjzasdYRsopvNH7KH
         qvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701145352; x=1701750152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgMs+FA2uRdRydo7QTTHxfVxYoJ/VeG+Rds1RS5XwD8=;
        b=vXSKFW09/alMR0e9baNLB7rXO2D9lVr+psJbFmViH0XWogfdSAHvT2drSlTXGetK1z
         I7qi4RyuAuvAns/4Ezata7REr01Dhml1hdKlQci5dqES+RV/TuB24/BXnRtezNSNTm6+
         1l+uQghFXjr3fxwyPELfWQ02DxTiLslo/K1xq8u7uMZUBILXWG8rhfW4iMsXA2k/xyBh
         J1TyfoZzvwCv5KgGe7e2iyt2PArHqcz2tbGgnrXLbCWp4zWZPICb6aWVveWRIRe6/FVi
         /s3xqbxyub7CPwmoSKVT3K15zdUMcqACer3Amh2FALm7mmU+Td+bFuiXuLCtR1O58Y09
         dawA==
X-Gm-Message-State: AOJu0YzlU691PwxEuV2w48hdBmBfEpRnChj0P7TWNSOcevYht3eU1w26
        dNcZ+9BTTpw5X2cv5FrOzvAmpA==
X-Google-Smtp-Source: AGHT+IHHG3HHcqIdeyqhTum97P/I46I9Hh5VumkUxPbdNd8VW8kcRCxRWILwSKP5Mcr6OJhpTLtfqQ==
X-Received: by 2002:a17:90a:190e:b0:285:8cb1:7f53 with SMTP id 14-20020a17090a190e00b002858cb17f53mr12960246pjg.31.1701145352037;
        Mon, 27 Nov 2023 20:22:32 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:8338:14c0:b892:2482:e230? ([2402:7500:4ce:8338:14c0:b892:2482:e230])
        by smtp.gmail.com with ESMTPSA id pm18-20020a17090b3c5200b00285e53d90cesm1567515pjb.26.2023.11.27.20.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2023 20:22:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231128035630.GG1463@sol.localdomain>
Date:   Tue, 28 Nov 2023 12:22:26 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BE5BD19-7401-455D-838B-56264F78471B@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-5-jerry.shih@sifive.com>
 <20231128035630.GG1463@sol.localdomain>
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

On Nov 28, 2023, at 11:56, Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Nov 27, 2023 at 03:06:54PM +0800, Jerry Shih wrote:
>> +int riscv64_aes_setkey(struct crypto_aes_ctx *ctx, const u8 *key,
>> +		       unsigned int keylen)
>> +{
>> +	int ret;
>> +
>> +	ret =3D aes_check_keylen(keylen);
>> +	if (ret < 0)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The RISC-V AES vector crypto key expanding doesn't support =
AES-192.
>> +	 * Use the generic software key expanding for that case.
>> +	 */
>> +	if ((keylen =3D=3D 16 || keylen =3D=3D 32) && =
crypto_simd_usable()) {
>> +		/*
>> +		 * All zvkned-based functions use encryption expanding =
keys for both
>> +		 * encryption and decryption.
>> +		 */
>> +		kernel_vector_begin();
>> +		rv64i_zvkned_set_encrypt_key(key, keylen, ctx);
>> +		kernel_vector_end();
>> +	} else {
>> +		ret =3D aes_expandkey(ctx, key, keylen);
>> +	}
>=20
> rv64i_zvkned_set_encrypt_key() does not initialize =
crypto_aes_ctx::key_dec.
> So, decryption results will be incorrect if !crypto_simd_usable() =
later.

Will we have the situation that `crypto_simd_usable()` condition is not =
consistent
during the aes_setkey(), aes_enc/dec()? If yes, all accelerated(or HW =
specific)
crypto algorithms should do the same implementations as the sw fallback =
path
since the `crypto_simd_usable()` will change back and forth.

>> +static int aes_setkey(struct crypto_tfm *tfm, const u8 *key,
>> +		      unsigned int keylen)
>=20
> It's best to avoid generic-sounding function names like this that =
could collide
> with functions in crypto/ or lib/crypto/.  A better name for this =
function, for
> example, would be aes_setkey_zvkned().

Thx, I will fix that.

>> diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.pl =
b/arch/riscv/crypto/aes-riscv64-zvkned.pl
>> new file mode 100644
>> index 000000000000..303e82d9f6f0
>> --- /dev/null
>> +++ b/arch/riscv/crypto/aes-riscv64-zvkned.pl
> [...]
>> +L_enc_128:
> [...]
>> +L_enc_192:
> [...]
>> +L_enc_256:
>=20
> There's some severe source code duplication going on in the AES =
assembly, with
> the three AES variants having separate source code.  You can just =
leave this
> as-is since this is what was merged into OpenSSL and we are borrowing =
that for
> now, but I do expect that we'll want to clean this up later.

Do we prefer the code with the branches instead of the specified =
implementation?
We could make AES-128/192/256 together like:

    @{[vaesz_vs $V24, $V1]}
    @{[vaesem_vs $V24, $V2]}
    @{[vaesem_vs $V24, $V3]}
    @{[vaesem_vs $V24, $V4]}
    @{[vaesem_vs $V24, $V5]}
    @{[vaesem_vs $V24, $V6]}
    @{[vaesem_vs $V24, $V7]}
    @{[vaesem_vs $V24, $V8]}
    @{[vaesem_vs $V24, $V9]}
    @{[vaesem_vs $V24, $V10]}
    beq $ROUND, $ROUND_11, 1f
    @{[vaesem_vs $V24, $V11]}
    @{[vaesem_vs $V24, $V12]}
    beq $ROUND, $ROUND_13, 1f
    @{[vaesem_vs $V24, $V13]}
    @{[vaesem_vs $V24, $V14]}
1:
    @{[vaesef_vs $V24, $V15]}

But we will have the additional costs for the branches.

> - Eric



