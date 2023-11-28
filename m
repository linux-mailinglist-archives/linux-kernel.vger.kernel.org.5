Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAB7FB4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjK1I5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbjK1I5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:57:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C797A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:57:43 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cd89f2af9dso2167877b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701161863; x=1701766663; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTYsamGNaQ8fRNjNMaxridTGMNfJmuFsAlfcl9yavQs=;
        b=jrl1bmceyHOFSDtvQApVUTf5TVwt6J7Mv/Mq6VjJic6wS1BHy8agCIMRXABStPzYOw
         WmGDF2ELP6qmx6LyxcP+KwWnLsahstorvThiBWPTRZGDOrQNF1rg3Irv0yS0JxZpAzVK
         +0uo5DLXF828BUL6NXVFSIssdFrHdF09t+NwEQ0zNYo9VXWOAMrrm1TgOoRgreRtRcF2
         CIk7oAr2rjiSDFZU/pTD6x+OGzyH1/7K01yTO2VDaNV5kn5q7xr97kgu5fvPJz7EVVNI
         tPP0pw6WF8zTDk/rJtadRqtw+LHUaHM5rrz1+FTZCKHQfxK87KOiHxJ1vUbpEUr2IGFg
         /m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161863; x=1701766663;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTYsamGNaQ8fRNjNMaxridTGMNfJmuFsAlfcl9yavQs=;
        b=CNaiqXOvIrbVyUbTffzoLAuPrRuLGZwkvOWy4q57AJOSdGI1+aESKFr90kuYkCWIvI
         V9ZQRbBxu3HnvRH/6hXfUUmeJJzrLzEE8N6ICsQyUrMo39DlaJprXfTjiwPLGGI57LO1
         W0d6SjCeXvKfZYg045RO5dl5ASBNxjmJtkqV5xOEC6NUUToKD5oAq8a7/YQtyKCAZbJ/
         ImRNPayqiZO3oEL9YM+GlSKonNeiPNa6lM9ORfYoURYe3Al+Bz3Kr9Nwmv8BgztSH4W/
         5PcJiDZuJogexmupx1+5pkEB9xlC+pt+eCtKfbK2gChiBbUuFg4R3sfY2RjGaznzzT54
         QO9Q==
X-Gm-Message-State: AOJu0YwxrAsswS6trx6WebQAyU972VUVT5+CinAghwH8XTmtPGPp6B9y
        1i5msRBKunFnRvoHPkv5gaoUqA==
X-Google-Smtp-Source: AGHT+IE/fng9QOuiUZBluDfizhRPgWmYcOqQIfRFSizRR9MTI4Ihwkn53PdiTZ2Of0dfq0nFdnkdKA==
X-Received: by 2002:a05:6a20:5650:b0:18b:9053:d865 with SMTP id is16-20020a056a20565000b0018b9053d865mr15666672pzc.42.1701161862894;
        Tue, 28 Nov 2023 00:57:42 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:8338:14c0:b892:2482:e230? ([2402:7500:4ce:8338:14c0:b892:2482:e230])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a00078800b00694fee1011asm8522232pfu.208.2023.11.28.00.57.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:57:42 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 13/13] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231128042503.GL1463@sol.localdomain>
Date:   Tue, 28 Nov 2023 16:57:38 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B3784E0-0DE2-4A99-878E-657BB0E0765D@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-14-jerry.shih@sifive.com>
 <20231128042503.GL1463@sol.localdomain>
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

On Nov 28, 2023, at 12:25, Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Nov 27, 2023 at 03:07:03PM +0800, Jerry Shih wrote:
>> +config CRYPTO_CHACHA20_RISCV64
>=20
> Can you call this kconfig option just CRYPTO_CHACHA_RISCV64?  I.e. =
drop the
> "20".  The ChaCha family of ciphers includes more than just ChaCha20.
>=20
> The other architectures do use "CHACHA20" in their equivalent option, =
even when
> they implement XChaCha12 too.  But that's for historical reasons -- we =
didn't
> want to break anything by renaming the kconfig options.  For a new =
option we
> should use the more general name from the beginning, even if initially =
only
> ChaCha20 is implemented (which is fine).

I will use `CRYPTO_CHACHA_RISCV64` instead.

>> +static int chacha20_encrypt(struct skcipher_request *req)
>=20
> riscv64_chacha_crypt(), please.  chacha20_encrypt() is dangerously =
close to
> being the same name as chacha20_crypt() which already exists in =
crypto/chacha.h.

The function will will have additional prefix/suffix.

>> +static inline bool check_chacha20_ext(void)
>> +{
>> +	return riscv_isa_extension_available(NULL, ZVKB) &&
>> +	       riscv_vector_vlen() >=3D 128;
>> +}
>=20
> Just to double check: your intent is to simply require VLEN >=3D 128 =
for all the
> RISC-V vector crypto code, even when some might work with a shorter =
VLEN?  I
> don't see anything in chacha-riscv64-zvkb.pl that assumes VLEN >=3D =
128, for
> example.  I think it would even work with VLEN =3D=3D 32.

Yes, the chacha algorithm here only needs the VLEN>=3D32. But I think we =
will not get
benefits with that kind of hw.

> I think requiring VLEN >=3D 128 anyway makes sense so that we don't =
have to worry
> about validating the code with shorter VLEN.  And "application =
processors" are
> supposed to have VLEN >=3D 128.  But I just wanted to make sure this =
is what you
> intended too.

The standard "V" extension assumes VLEN>=3D128. I just follow that =
assumption.
=
https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc#183-v-vector=
-extension-for-application-processors

-Jerry

