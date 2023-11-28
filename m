Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B04F7FB27E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbjK1HRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343813AbjK1HRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:17:01 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB3D4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:17:00 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-58d4e32ea2fso1846141eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701155818; x=1701760618; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hGy46pUf93WoDJ7rnnE2nED/iyelB1yhgDX8ASNQ7E=;
        b=VnvqGzM1DoJNEubPnROwF86hlxKEiEWVfnKtU35EpW3SwaDsQl00Vg4Q+3ei3FLYQL
         0IxC9bwYlWUizFMOJLbamv7xSQHZsJId4jdCNCSBrS2+nmRZ6EmiQxMDtxNB2mZ4w0kG
         CGKK+qbBS2n6W5CN1sfXbfK1Zc2Ew/UrEw536CDfeVOY/C5SxTnYDfWGnv/BHju8hzBJ
         H7qzYo3ZaDvnjhksHFSyBTx3hljMmgvCCa6i8vTUxVcHu+soTp2u5GNI4QtMsPrz5/xe
         0V194CeXMZ0ANSL2sAKQOOpdXK74z8Huy+zSLr04f7AAUyXZlQyOBuUYjsPDyj6HQOmo
         /0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701155818; x=1701760618;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hGy46pUf93WoDJ7rnnE2nED/iyelB1yhgDX8ASNQ7E=;
        b=fQqjeQLonL+Ncyszujkw/FXmTwws4068i51NBZnifu97b9bjSqrB5QT7B6/RExxnlQ
         pZMXS9VT/h4hMHHzQPODvT1R0eYx0lVA8nlfbceY4PotKSFGBEVvsArrHOmGuG94g4EJ
         3BSbxp+dyXeBw/eEN3PzkmtMnBiJ8hoMBPA43XvpKAmif3wiXJiaVfE3TOqhmTPCRpUx
         UX8SWVMDGMqT+IWP7U537XHFanhf7ega9DP7RgPxl3rVAGpxFsEP/LA/PhcwXBaTyJLT
         F+VhO0Sg74w0qZ9HHb2AxXd+zTMMUFe7D2D8WXEz9YQmMxmHVCK17XVnDX9F3zvdR/6a
         mpfQ==
X-Gm-Message-State: AOJu0YzatpUqtVvejRFb2xKm3fZLXriBpfxEJR5+N43hMJFaKJiaTeEK
        Q3r2Adl6yobFKqy3RQsVM1Fuag==
X-Google-Smtp-Source: AGHT+IFgwFw7npmV6jjE0YipeNTQs2cwOSwYlG2/9Hv4A2Hr9ObLQntqtxAzF+6fw3EgWDGHIqkZ2Q==
X-Received: by 2002:a05:6358:52c6:b0:16b:c479:d6c1 with SMTP id z6-20020a05635852c600b0016bc479d6c1mr17221034rwz.9.1701155817816;
        Mon, 27 Nov 2023 23:16:57 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:8338:14c0:b892:2482:e230? ([2402:7500:4ce:8338:14c0:b892:2482:e230])
        by smtp.gmail.com with ESMTPSA id n7-20020a634007000000b005c2185be2basm8957980pga.54.2023.11.27.23.16.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2023 23:16:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 09/13] RISC-V: crypto: add Zvknha/b accelerated
 SHA224/256 implementations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231128041235.GJ1463@sol.localdomain>
Date:   Tue, 28 Nov 2023 15:16:53 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <51190E7A-25BD-4D9A-AADF-02FE2A280508@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-10-jerry.shih@sifive.com>
 <20231128041235.GJ1463@sol.localdomain>
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

On Nov 28, 2023, at 12:12, Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Nov 27, 2023 at 03:06:59PM +0800, Jerry Shih wrote:
>> +/*
>> + * sha256 using zvkb and zvknha/b vector crypto extension
>> + *
>> + * This asm function will just take the first 256-bit as the sha256 =
state from
>> + * the pointer to `struct sha256_state`.
>> + */
>> +asmlinkage void
>> +sha256_block_data_order_zvkb_zvknha_or_zvknhb(struct sha256_state =
*digest,
>> +					      const u8 *data, int =
num_blks);
>=20
> The SHA-2 and SM3 assembly functions are potentially being called =
using indirect
> calls, depending on whether the compiler optimizes out the indirect =
call that
> exists in the code or not.  These assembly functions also are not =
defined using
> SYM_TYPED_FUNC_START.  This is not compatible with Control Flow =
Integrity
> (CONFIG_CFI_CLANG); these indirect calls might generate CFI failures.
>=20
> I recommend using wrapper functions to avoid this issue, like what is =
done in
> arch/arm64/crypto/sha2-ce-glue.c.
>=20
> - Eric

Here is the previous review comment for the assembly function wrapper:
> > +asmlinkage void sha256_block_data_order_zvbb_zvknha(u32 *digest, =
const void *data,
> > +					unsigned int num_blks);
> > +
> > +static void __sha256_block_data_order(struct sha256_state *sst, u8 =
const *src,
> > +				      int blocks)
> > +{
> > +	sha256_block_data_order_zvbb_zvknha(sst->state, src, blocks);
> > +}
> Having a double-underscored function wrap around a non-underscored one =
like this
> isn't conventional for Linux kernel code.  IIRC some of the other =
crypto code
> happens to do this, but it really is supposed to be the other way =
around.
>=20
> I think you should just declare the assembly function to take a =
'struct
> sha256_state', with a comment mentioning that only the 'u32 state[8]' =
at the
> beginning is actually used.  That's what =
arch/x86/crypto/sha256_ssse3_glue.c
> does, for example.  Then, __sha256_block_data_order() would be =
unneeded.

Do you mean that we need the wrapper functions back for both SHA-* and =
SM3?
If yes, we also don't need to check the state offset like:
	BUILD_BUG_ON(offsetof(struct sha256_state, state) !=3D 0);

Could we just use the `SYM_TYPED_FUNC_START` in asm directly without the
wrappers?

-Jerry=
