Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B557E7FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjKJR4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjKJRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277017EFC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:56:28 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b6cb515917so430698b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699599387; x=1700204187; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUDU8jgptAxW+fbE2XJsHM9R/m1WuxaBgSA3vJN2eHc=;
        b=XsxMtVJ+ztTce63GgJsS6f7s5v7Co8TModV1jKTB5z0Um8keegDMAgj3EH7l30BD9h
         PmB1b4lAaay0XMK8TbdBlCO2+UHZk3GGLLGTDC+MXLbeWDwiAdkI/sLKvUTlQhFdFJZ+
         BcSOa1r3WIByl0f0PXDwRWtSxvPTh8tzeXCL+Jq9HENpSX/yBPRER48HaNsQ723Mb+za
         dU74rFT394UjgnzS3KOQT8vZytpTgruUcB1K7kpvYgWCruvqba6rsZ5mvzD1jLitsIJl
         5tya6QLM+JVnNmGI6nxmBwLe+s795YGg8hhXBzD86fozyUP6lFHYpzFIn4d7qh49hLNF
         xnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699599387; x=1700204187;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUDU8jgptAxW+fbE2XJsHM9R/m1WuxaBgSA3vJN2eHc=;
        b=An0upD/ZI+Fhc35+nhphCe8vNUtDno/Ta7eHC0nSVQ6hNQWHF8j27rZESbqvs1YB/1
         r1wo07zDdvHgGtaCzn66l3TrfJoe5VADqGhZv9FMgLaXSKDEcrK6lkG+r16g0X8MW7zA
         sTUay030uKS1rjkblLGHTVOfz+271qnsNmvayztQqGaelixQwsn7PPxnlaA2DtHD3UOm
         MPZugKge9ZJGncqvJ4pkT0UgH+F5acrh7J8E2tT5hqF3pFB3X+VzDgz7pMw4hVB0n5zS
         9Rw0H4WbN9CRUzlIQt9YT3kFDKMJ1RmN6oUaBqEQRAQMp9Y0iN+/N1YxpmuDhOhjN6Jc
         ceWg==
X-Gm-Message-State: AOJu0YyMKpotEu5TxeKhJzeBtgJNzPw6tCljn1DD+eteC2JjHCWasYsx
        Pc/YUEecg7Z5TFNp5DxWSRVFkAFsEE9oTjR4INIzbw==
X-Google-Smtp-Source: AGHT+IHRC6A0RYIZ+hAK7pADe4iS4Ng9L/OaXImZUunvvqSvdYwesELoXVdLs1NatCPZXbqISvIX0A==
X-Received: by 2002:a67:e0c6:0:b0:45d:9376:a873 with SMTP id m6-20020a67e0c6000000b0045d9376a873mr7001350vsl.29.1699589176700;
        Thu, 09 Nov 2023 20:06:16 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:aeef:99fc:78aa:eebe:b7e0? ([2402:7500:4ce:aeef:99fc:78aa:eebe:b7e0])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902e88d00b001c627413e87sm4301587plg.290.2023.11.09.20.06.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2023 20:06:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS
 implementations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231109080549.GC1245@sol.localdomain>
Date:   Fri, 10 Nov 2023 12:06:10 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF7F714A-CAC1-41C4-A43A-DA1273111492@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231109080549.GC1245@sol.localdomain>
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

On Nov 9, 2023, at 16:05, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
>> +# prepare input data(v24), iv(v28), bit-reversed-iv(v16), =
bit-reversed-iv-multiplier(v20)
>> +sub init_first_round {
>> ....
>> +    # Prepare GF(2^128) multiplier [1, x, x^2, x^3, ...] in v8.
>> +    slli $T0, $LEN32, 2
>> +    @{[vsetvli "zero", $T0, "e32", "m1", "ta", "ma"]}
>> +    # v2: [`1`, `1`, `1`, `1`, ...]
>> +    @{[vmv_v_i $V2, 1]}
>> +    # v3: [`0`, `1`, `2`, `3`, ...]
>> +    @{[vid_v $V3]}
>> +    @{[vsetvli "zero", $T0, "e64", "m2", "ta", "ma"]}
>> +    # v4: [`1`, 0, `1`, 0, `1`, 0, `1`, 0, ...]
>> +    @{[vzext_vf2 $V4, $V2]}
>> +    # v6: [`0`, 0, `1`, 0, `2`, 0, `3`, 0, ...]
>> +    @{[vzext_vf2 $V6, $V3]}
>> +    slli $T0, $LEN32, 1
>> +    @{[vsetvli "zero", $T0, "e32", "m2", "ta", "ma"]}
>> +    # v8: [1<<0=3D1, 0, 0, 0, 1<<1=3Dx, 0, 0, 0, 1<<2=3Dx^2, 0, 0, =
0, ...]
>> +    @{[vwsll_vv $V8, $V4, $V6]}
>=20
> This code assumes that '1 << i' fits in 64 bits, for 0 <=3D i < vl.
>=20
> I think that works out to an implicit assumption that VLEN <=3D 2048.  =
I.e.,
> AES-XTS encryption/decryption would produce the wrong result on RISC-V
> implementations with VLEN > 2048.
>=20
> Perhaps it should be explicitly checked that VLEN <=3D 2048?
>=20
> - Eric

Yes, we could just have the simple checking like:

  riscv_vector_vlen() >=3D 128 || riscv_vector_vlen() <=3D2048

We could also truncate the VL inside for VLEN>2048 case.
Let me think more about these two approaches.=20

-Jerry=
