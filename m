Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE87DC440
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjJaCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjJaCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:17:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568EEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:17:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2800c221af2so2767639a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698718639; x=1699323439; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FYXELKOgFv1uqwcp59pbFz1ZZ95RxWQk/gFtrN2AhA=;
        b=HtWpxrS9yntTaHRw84hdzQ51raRJjOAF/oBhZHiEKlnZ1T5QDbOu0fqE9NmFNVOKcu
         DMv7mzhQ9tQyVpiQCZEjH2BjATJHuTUOdwCcgOzR8egZokz0tSFoz85TSEE1lx5ls87+
         lAOMBVaxuRsT7ay4XHVYSEsBb/mp61kXr3o+ubFAG03pSAqGJJjo9+PwS25bpO/TaEbJ
         lbhaNeSIEyRoteo7GTx7w7pstn3gh0V4O1QpfX4bYR8hmxh1Ap+N0L8PESN6k06AlxOl
         P44Qsah0zkKHJAs6Oa2PSDRTrGPEhC7B4/TOiwx5p0sFy0ADb56NxqiP4P4kh0Kgna5J
         JI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698718639; x=1699323439;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FYXELKOgFv1uqwcp59pbFz1ZZ95RxWQk/gFtrN2AhA=;
        b=F1787YUE0GnC8Z2q1JuF469cM0kuqPgdLbzc5lp1gQlqj6o0bUTdUv9nMDe7rOG0FW
         3f4kywKERFsQTbxpVqyBKq2RoHgj7AMNlVQ/C1Et6gBt6m6ZNdx5U8xAx6t0X9e8Uqkj
         QCBJfcLi/kq2RsXgSsB+tcys1HBvHbhM8DoTwwYW90PDg6jgflruTpxklaUqKjYTMAD9
         YqclHpynx3uWeLlhG59G7JfA7yCh1/HMPREtaVXJlP+c9AnJvqZE5x2KTpDfQVqcm0CR
         rimCtN0i2FHe5KW+G6drR5ea42KdWMuinNhTRYRKjuqbwal4p6oVfSN1sgB1xYPn9H2j
         +svw==
X-Gm-Message-State: AOJu0Yzb8ckC6LxMtepQ73QDys/03AY/+Syb2YMHQ593f4e1pizlZ0cY
        gIgbu7/AvMK2oErBlSrEspPDZg==
X-Google-Smtp-Source: AGHT+IGJ28lY1cTChUE7onXf43JzC58/5Bp1fU+0G9i9fxk6B9LmIgoCIzVyIkzsla7jJzZ+dWFUiw==
X-Received: by 2002:a17:90a:7:b0:27c:fdc6:c52 with SMTP id 7-20020a17090a000700b0027cfdc60c52mr8199049pja.30.1698718638711;
        Mon, 30 Oct 2023 19:17:18 -0700 (PDT)
Received: from ?IPv6:2402:7500:5d5:c8ac:c44a:458:311d:fb2c? ([2402:7500:5d5:c8ac:c44a:458:311d:fb2c])
        by smtp.gmail.com with ESMTPSA id gq9-20020a17090b104900b002609cadc56esm133548pjb.11.2023.10.30.19.17.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2023 19:17:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231006194741.GA68531@google.com>
Date:   Tue, 31 Oct 2023 10:17:11 +0800
Cc:     Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Reply-To: 20231006194741.GA68531@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB98E114-A8DE-492E-B078-7394EE4FA83E@sifive.com>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain> <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 7, 2023, at 03:47, Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, Sep 15, 2023 at 11:21:28AM +0800, Jerry Shih wrote:
>> On Sep 15, 2023, at 09:48, He-Jie Shih <bignose1007@gmail.com> wrote:
>>=20
>> The OpenSSL PR is at [1].
>> And we are from SiFive.
>>=20
>> -Jerry
>>=20
>> [1]
>> https://github.com/openssl/openssl/pull/21923
>=20
> Hi Jerry, I'm wondering if you have an update on this?  Do you need =
any help?

The RISC-V vector crypto OpenSSL pr[1] is merged.
And we also sent the vector-crypto patch based on Heiko's and OpenSSL
works.
Here is the link:
https://lore.kernel.org/all/20231025183644.8735-1-jerry.shih@sifive.com/

[1]
https://github.com/openssl/openssl/pull/21923

> I'm also wondering about riscv.pm and the choice of generating the =
crypto
> instructions from .words instead of using the assembler.  It makes it
> significantly harder to review the code, IMO.  Can we depend on =
assembler
> support for these instructions, or is that just not ready yet?
>=20
> - Eric

There is no public assembler supports the vector-crypto asm mnemonics.
We should still use `opcode` for vector-crypto instructions. But we =
might
use asm for standard rvv parts.
In order to reuse the codes in OpenSSL as much as possible,  we still =
use
the `riscv.pm` for all standard rvv and vector-crypto instructions. If =
the asm
mnemonic is still a better approach,  I will `rewrite` all standard rvv =
parts
with asm mnemonics in next patch.

-Jerry


