Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9798076E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379728AbjLFRqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjLFRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:46:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C81137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:46:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf09be81bso28e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701884815; x=1702489615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40RVph6R6yt3n+vZ+PWPchr4/4jOFmgCoqk9cPDFhkM=;
        b=q06gnmi4/qD7JgaxyZtxstwMoS8lSEZrLmsYDrLEpXJHhJQnD5VgQtDR8Ek2NaRWN+
         2Utjl84JK+CbrI8NS/s/1k2xUoiLGH6rWy8Fy0c5nSG5CdnqGyEzsePf7HSDwhhS1eyX
         D2dQBk3OE16EmkJbmZHwr26T76nnIR2tauSDuqIlUbcyYy2KzGZBT5MbGFtblTel00Gp
         bkAE/gMGaj5r1qt3IISisamBrJJRpLFaIH2DIft5EhzbLCu8BGiNwKaFiH1Twimr8Ud1
         OjccF3zUMbTI5pThhaxXoJlVtxaMg+Sgq/k/QzjD+ThwDgV1Q9TwywGl9h9+yZbuxZR7
         MsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884815; x=1702489615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40RVph6R6yt3n+vZ+PWPchr4/4jOFmgCoqk9cPDFhkM=;
        b=JFmpe1vGMXjhXv9VUsMExSch/mQXS/td0B9a1qJqQWJ2b8D6wudk9hrnTz6eng5zAN
         p0iaS30xhjKOiA+UmS3X7ZSMG4+CQv3RCWes5JQcbcG/fDPXNsQigSf9Cu1okMEF8aMe
         gCbdsxfm4G+2J4U+HqnR32auKvWCgkyEtBOjfAbudRcvMklL8nwbe3OIfKXp4G7f2kxi
         indcZa2O+KOtMaC9fdFx3Exv95yHbQYg7JyIZxYoOei6LGQkdT5HGKg5XMW6DGvG+yEU
         ypMlwP/+Tseca9JPk5ztvUz2gfy/U0IlA1jinfNKDNTpWV2sM5Xx+ADsguEHhhHOtpTo
         hptw==
X-Gm-Message-State: AOJu0Ywr48KYkmu5oQbF4VNJ1hPKZk0VLVpYnAUiNRe0cF/h1Bn3eO0W
        57O6OsCe0+g5O+NFM4hS7F753pYk6Ir0loJFry06Mw==
X-Google-Smtp-Source: AGHT+IGStHTnn01sg/zP1v9g4k+SVZgsaH7zL+ozF8zFR4+YqFgj+VjQfKSSAPbT8vf0MCQMhkPE0MT3+VTAP3mTD24=
X-Received: by 2002:a05:6512:2255:b0:50c:147c:5022 with SMTP id
 i21-20020a056512225500b0050c147c5022mr52164lfu.6.1701884814669; Wed, 06 Dec
 2023 09:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20231128125959.1810039-1-nikunj@amd.com>
In-Reply-To: <20231128125959.1810039-1-nikunj@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 6 Dec 2023 10:46:43 -0700
Message-ID: <CAMkAt6pULjLVUO6Ys4Sq1a79d93_5w5URgLYNXY-aW2jSemruA@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Add Secure TSC support for SNP guests
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        dionnaglaze@google.com, seanjc@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 6:00=E2=80=AFAM Nikunj A Dadhania <nikunj@amd.com> =
wrote:
>
> Secure TSC allows guests to securely use RDTSC/RDTSCP instructions as the
> parameters being used cannot be changed by hypervisor once the guest is
> launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".
>
> During the boot-up of the secondary cpus, SecureTSC enabled guests need t=
o
> query TSC info from AMD Security Processor. This communication channel is
> encrypted between the AMD Security Processor and the guest, the hyperviso=
r
> is just the conduit to deliver the guest messages to the AMD Security
> Processor. Each message is protected with an AEAD (AES-256 GCM). See "SEV
> Secure Nested Paging Firmware ABI Specification" document (currently at
> https://www.amd.com/system/files/TechDocs/56860.pdf) section "TSC Info"
>
> Use a minimal GCM library to encrypt/decrypt SNP Guest messages to
> communicate with the AMD Security Processor which is available at early
> boot.
>
> SEV-guest driver has the implementation for guest and AMD Security
> Processor communication. As the TSC_INFO needs to be initialized during
> early boot before smp cpus are started, move most of the sev-guest driver
> code to kernel/sev.c and provide well defined APIs to the sev-guest drive=
r
> to use the interface to avoid code-duplication.
>
> Patches:
> 01-08: Preparation and movement of sev-guest driver code
> 09-16: SecureTSC enablement patches.
>
> Testing SecureTSC
> -----------------
>
> SecureTSC hypervisor patches based on top of SEV-SNP Guest MEMFD series:
> https://github.com/nikunjad/linux/tree/snp-host-latest-securetsc_v5
>
> QEMU changes:
> https://github.com/nikunjad/qemu/tree/snp_securetsc_v5
>
> QEMU commandline SEV-SNP-UPM with SecureTSC:
>
>   qemu-system-x86_64 -cpu EPYC-Milan-v2,+secure-tsc,+invtsc -smp 4 \
>     -object memory-backend-memfd-private,id=3Dram1,size=3D1G,share=3Dtrue=
 \
>     -object sev-snp-guest,id=3Dsev0,cbitpos=3D51,reduced-phys-bits=3D1,se=
cure-tsc=3Don \
>     -machine q35,confidential-guest-support=3Dsev0,memory-backend=3Dram1,=
kvm-type=3Dsnp \
>     ...

Thanks Nikunj!

I was able to modify my SNP host kernel to support SecureTSC based off
of your `snp-host-latest-securetsc_v5` and use that to test this
series. Seemed to work as intended in the happy path but I didn't
spend much time trying any corner cases. Also checked the series
continues to work without SecureTSC enabled for the V.

Tested-by: Peter Gonda <pgonda@google.com>
