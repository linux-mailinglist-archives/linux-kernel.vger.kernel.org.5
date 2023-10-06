Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92F7BC0D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjJFVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJFVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:01:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9D4C6;
        Fri,  6 Oct 2023 14:01:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c894e4573bso5966965ad.0;
        Fri, 06 Oct 2023 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696626111; x=1697230911; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn5uZMjSaH8hIqbejs5h+ffQC2Qffbsh01CXuNBPa6o=;
        b=Ei8fPucpyPNN3vDJeL+LHPCmXd8e3H7/Am02fKhmBnZbC0u5+EjgUMbH9n77eln5yI
         bs/MbP5hqxLnMsJ2OlTYzN523Jq8QT5f1FIv/CSmuL38i3GOSemmUiVgnamTRlSHq38T
         yemOmW9JVCi2T7+mFmahDPMycCHhxHKtt3TRfRaUHK1LHYvzFru8txzTwTHd9XftpO3p
         cdxXIHMA+REclTSucO7lwUBzCQhbYarxG1kYJkV5/8P5pA0O/ypEN13k6CQCSywYiQ0O
         kVOrZNldsULdZnJIiqN1IZfpmXguXIuHWs99OCIIVmLtYEFjvB2xxCOGnxMuLL9X4y+A
         nlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696626111; x=1697230911;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn5uZMjSaH8hIqbejs5h+ffQC2Qffbsh01CXuNBPa6o=;
        b=ZGZlrXjRDPxS4VVn0f0zzsqmmM7bKD3jJn/6Y8g1619BFfRPQqVDyzl/a28sSz+BWK
         0vFJ5TTMQReJVtm7Z8ks5LsdueB/0OVPIyEGrnL1a4FgpgnQq/7DAR/kR+BW12m1Aog0
         WfzfLUKOfTwdbGBjM4guIJBwbDbEeMGln9iman74iN3/vRkXKdCI1q4GmtbHIRdTcOSX
         ElBJvHoO0Fy30nd71rMr2bNuoHuM7R123FvtrDlOJEu/XZlRDc8dyM2t+hqVrygOeTPq
         YfHWsaSCNmF9vkdAIrFrzTzJWJCaHmC4GNZ0bWaC3NzajYp4z5PFzgucwSQkNPZewNVI
         wpkg==
X-Gm-Message-State: AOJu0YyoKzEZQpTp9IYZQP7WInFOH37i93Ih0DTZ35e5JABWYVdwRoXm
        JNHFB1n5jDacR3VFqWUwXj0=
X-Google-Smtp-Source: AGHT+IEjflmzJLhvFDRd6fvsIeJr17A0jYfL5yzBGWwFWgxAw2a5w9SCEWl9UhOk8TPYjI7SjeLZXQ==
X-Received: by 2002:a17:902:6bc1:b0:1c3:6e38:3943 with SMTP id m1-20020a1709026bc100b001c36e383943mr7985566plt.56.1696626111133;
        Fri, 06 Oct 2023 14:01:51 -0700 (PDT)
Received: from ?IPv6:2402:7500:4d5:8d3d:81fd:40de:c351:7a06? ([2402:7500:4d5:8d3d:81fd:40de:c351:7a06])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001c60a2b5c61sm4335297plr.134.2023.10.06.14.01.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:01:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
From:   He-Jie Shih <bignose1007@gmail.com>
In-Reply-To: <20231006194741.GA68531@google.com>
Date:   Sat, 7 Oct 2023 05:01:45 +0800
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
Message-Id: <7BC51820-61BC-422C-A2F7-B68CE679972C@gmail.com>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain> <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 7, 2023, at 03:47, Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, Sep 15, 2023 at 11:21:28AM +0800, Jerry Shih wrote:
>> On Sep 15, 2023, at 09:48, He-Jie Shih <bignose1007@gmail.com> wrote:
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

We have specialized aes-cbc/ecb/ctr patch locally and pass the `testmgr` =
test
cases. But the test patterns in `testmgr` are quite simple, I think it =
doesn't test the
corner case(e.g. aes-xts with tail element).

For aes-xts, I'm trying to update the implementation from OpenSSL. The =
design
philosophy is different between OpenSSL and linux. In linux crypto, the =
data will
be split into `scatterlist`. I need to preserve the aes-xts's iv for =
each scatterlist
entry call. And I'm thinking about how to handle the tail data in a =
simple way.
By the way, the `xts(aes)` implementation for arm and x86 are using
`cra_blocksize=3D AES_BLOCK_SIZE`. I don't know why we need to handle =
the tail
element. I think we will hit `EINVAL` error in `skcipher_walk_next()` if =
the data size
it not be a multiple of block size.

Overall, we will have
1) aes cipher
2) aes with cbc/ecb/ctr/xts mode
3) sha256/512 for `vlen>=3D128` platform
4) sm3 for `vlen>=3D128` platform
5) sm4
6) ghash
7) `chacha20` stream cipher

The vector crypto pr in OpenSSL is under reviewing, we are still =
updating the
perl file into linux.

The most complicated `gcm(aes)` mode will be in our next plan.

> I'm also wondering about riscv.pm and the choice of generating the =
crypto
> instructions from .words instead of using the assembler.  It makes it
> significantly harder to review the code, IMO.  Can we depend on =
assembler
> support for these instructions, or is that just not ready yet?

I have asked the same question before[1]. The reason is that Openssl =
could use
very old compiler for compiling. Thus, the assembler might not know the =
standard
rvv 1.0[2] and other vector crypto[3] instructions. That's why we use =
opcode for all
vector instructions. IMO, I would prefer to use opcode for `vector =
crypto` only. The
gcc-12 and clang-14 are already supporting rvv 1.0. Actually, I just =
read the `perl`
file instead of the actually generated opcode for OpenSSL pr reviewing. =
And it's
not hard to read the perl code.


Thanks,
- Jerry

[1]
https://github.com/openssl/openssl/pull/20149#discussion_r1244655440
[2]
https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc
[3
=
https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-sp=
ec-vector.adoc]=
