Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62257F2B09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjKUKzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjKUKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:55:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4911C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:55:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28397a2c402so2808307a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700564114; x=1701168914; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzKhOUKLZx+pr4SVfAMWtXoFfmy98an63KyE2M6t84k=;
        b=XgSV4SHMNAUCMicuOlSC3Ue+eIOT4uw3mBv0wXdpVmkEA1S6fWvKK937eb8bYnRaIo
         lYcn/K/eA7j7QNkeyx+IgAyS7sVgPXJ//8aolU1bkSI5tVFUYmaMU4YTENjV+YOQHpzM
         FC2cSmexK5dbsQ2nfJWJh4Ifqq5QP6zGOGyAdsHkUQrMjuoA6WwXjk2MEPzuzMwEBy9x
         6EceSVgtL+tk+1308yb+xMBZeYk3XtuCiu1V9mj+YlW0LhajLq5sk/PEBMx4gFusvx0d
         p5ZT3VTNjIQOh2jx+7k7WW1DqKsfYKJvYKFpM1gjfNJlpej5+50A+a30UaiJGN3mW2x/
         Lgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564114; x=1701168914;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzKhOUKLZx+pr4SVfAMWtXoFfmy98an63KyE2M6t84k=;
        b=whlCePIufJN/FeXMbMCrXXpnmeEMgnPDIt/Barww3U2N6rnaQceqKK9Vj5ea/+Niwp
         c+j5Q7cIThaYg2O+6Fm/HI2yGQ8/5IL44kW9hEQauY+oeK9jaQv5KceU3EYHTwWbKSb7
         GQZkdYeme80ZyFDKUu2VNPIHUlJynBSXvzpjCVGgPx32A2JsaDArJ4Mmlz4TgtMxcnq1
         rtgH/XmyObVBOZTpTd5mB1Ts/BBG50F6RVqEyoxujGD8TfHjllRD3e9gFUX4ohMGtZ2m
         TkH18jBOahf9rBlMQfFdh1sbEtxKelXMqYtRZusYQO+QGXyzci+NJdEworOQp3lZcVJC
         iAvA==
X-Gm-Message-State: AOJu0YzlIRplOMvY8NScF4ay0FBCuOb78hyyMRKAL+VZR9lJLDjRBb3v
        zE9tuN5dRwNKAtccFD1gsQwdzg==
X-Google-Smtp-Source: AGHT+IGpo4GmETcpbWDFdme7zudYwMnFovLtMACr2PLZcHekMbKtafj/QTIGaeb+fzIx1InGwWUNwA==
X-Received: by 2002:a17:90b:3ec2:b0:27e:31a:2ab2 with SMTP id rm2-20020a17090b3ec200b0027e031a2ab2mr7901807pjb.34.1700564113881;
        Tue, 21 Nov 2023 02:55:13 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:5aed:1852:f03:f8df:692b? ([2402:7500:4ce:5aed:1852:f03:f8df:692b])
        by smtp.gmail.com with ESMTPSA id g21-20020a17090a579500b002777001ee76sm8937627pji.18.2023.11.21.02.55.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 02:55:13 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231120191856.GA964@sol.localdomain>
Date:   Tue, 21 Nov 2023 18:55:07 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9724E3A5-F43C-4239-9031-2B33B72C4EF4@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
 <20231102054327.GH1498@sol.localdomain>
 <90E2B1B4-ACC1-4316-81CD-E919D3BD03BA@sifive.com>
 <20231120191856.GA964@sol.localdomain>
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

On Nov 21, 2023, at 03:18, Eric Biggers <ebiggers@kernel.org> wrote:
> First, I can see your updated patchset at branch
> "dev/jerrys/vector-crypto-upstream-v2" of =
https://github.com/JerryShih/linux,
> but I haven't seen it on the mailing list yet.  Are you planning to =
send it out?

I will send it out soon.

> Second, with your updated patchset, I'm not seeing any of the RISC-V =
optimized
> algorithms be registered when I boot the kernel in QEMU.  This is =
caused by the
> new check 'riscv_isa_extension_available(NULL, ZICCLSM)' not passing.  =
Is
> checking for "Zicclsm" the correct way to determine whether unaligned =
memory
> accesses are supported?
>=20
> I'm using 'qemu-system-riscv64 -cpu max -machine virt', with the very =
latest
> QEMU commit (af9264da80073435), so it should have all the CPU =
features.
>=20
> - Eric

Sorry, I just use my `internal` qemu with vector-crypto and rva22 =
patches.

The public qemu haven't supported rva22 profiles. Here is the qemu =
patch[1] for
that. But here is the discussion why the qemu doesn't export these
`named extensions`(e.g. Zicclsm).
I try to add Zicclsm in DT in the v2 patch set. Maybe we will have more =
discussion
about the rva22 profiles in kernel DT.

[1]
LINK: =
https://lore.kernel.org/all/d1d6f2dc-55b2-4dce-a48a-4afbbf6df526@ventanami=
cro.com/#t

I don't know whether it's a good practice to check unaligned access =
using
`Zicclsm`.=20

Here is another related cpu feature for unaligned access:
RISCV_HWPROBE_MISALIGNED_*
But it looks like it always be initialized with =
`RISCV_HWPROBE_MISALIGNED_SLOW`[2].
It implies that linux kernel always supports unaligned access. But we =
have the
actual HW which doesn't support unaligned access for vector unit.

[2]
LINK: =
https://github.com/torvalds/linux/blob/98b1cc82c4affc16f5598d4fa14b1858671=
b2263/arch/riscv/kernel/cpufeature.c#L575

I will still use `Zicclsm` checking in this stage for reviewing. And I =
will create qemu
branch with Zicclsm enabled feature for testing.

-Jerry=
