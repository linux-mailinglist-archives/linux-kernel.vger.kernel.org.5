Return-Path: <linux-kernel+bounces-2439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBAA815D31
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE91F22521
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769E015BE;
	Sun, 17 Dec 2023 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJFpDkED"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9AA5F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6da3659535fso1821202a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 18:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702779495; x=1703384295; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=OFl8kjpw91XelbaLp/NqZrQDKjPZSUtARdmSUPQXSX8=;
        b=VJFpDkEDGw/FR4o/St1bqanokQFV99ffBLRVEy4vwSZWwLafnkkXJAuTJnKac2oPV2
         OXBcr2dAu0hwlqf2wxz5aLt3UFQIep2NFn1wCmTuxnCtmodjGz/zDewvgsiU4iSXfixU
         5IVxUaZkOy7gQjYAuxwvMylvIqJJfZYzVtxdZI36NRheHiX2AnPmkUYB3odKBak+ULjN
         fTdaFgbyOwmFglxoXQ1Zg669yAOCvBj1QUubpLI6NCTEHawkbq6uL9HvFYiM634LjBnh
         64PUVxjLHjBEHLbM3gfV2plRQ4eK7UueVKhHogwHkhKUBayMnHNoIpCA5jfbhUHPF4sY
         tzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702779495; x=1703384295;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFl8kjpw91XelbaLp/NqZrQDKjPZSUtARdmSUPQXSX8=;
        b=QDg/DcidJLPWaWItxh8a9uE5dLkCKyGm4b1kKkQT7OCLFwhAr0tVpqBuDjVlllav3l
         J69PvPhC9lNY0P1TwJanh/cG1boTgGSbKhBFrhdBZeb0wJjTiB2KDDUQZkf222TTbQYS
         VAJ2bdt16rvvhhDi351Mh0skdLXBlucee/PL6hflgr24WuJuORK6Zx52kAGp0YSQMefB
         xQmvNN7iNGKmKkuqflPnzR8hzYmPY0s/Qa4xFJVMpZ6xhCRu8IDIiwR+8/OMN1yeHJhX
         BFBdWlmDMqR8+O5ih2X9qJF8eIG3M5I+ga5b7nutXMFUXTSQNjZFWa1NculNZNq1oCfv
         T3ww==
X-Gm-Message-State: AOJu0Yym3HGFkYx25xthJDGyewOUCWjgh+T5yYemGfmelM7Tsq7dIbGx
	1q9LcnNFFLVklrWaq2eNeSP92g==
X-Google-Smtp-Source: AGHT+IF+rykhjl/vJMlMFtG1M64I68Xtmq2p6wjQt8Jp7El542Y7P1lc23SbwSwdEGVtxnixp9/AeQ==
X-Received: by 2002:a05:6808:3a09:b0:3b9:e828:816 with SMTP id gr9-20020a0568083a0900b003b9e8280816mr20647236oib.48.1702779495498;
        Sat, 16 Dec 2023 18:18:15 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:a30f:cc0e:7239:16c3])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001d39f6edd54sm1453638plb.84.2023.12.16.18.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 18:18:14 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-34-201c483bd775@kernel.org>
 <875y1089i4.fsf@linaro.org>
 <485b6454-135c-4dd4-b38e-8fb8a02779cd@sirena.org.uk>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 34/39] kselftest/arm64: Add a GCS test program built
 with the system libc
In-reply-to: <485b6454-135c-4dd4-b38e-8fb8a02779cd@sirena.org.uk>
Date: Sat, 16 Dec 2023 23:18:13 -0300
Message-ID: <871qbl7esa.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

>> Also, it's strange that the tests defined after map_gcs.stack_overflow
>> don't run when I execute this test program. I'm doing:
>
>> $ ./run_kselftest.sh -t arm64:libc-gcs
>
>> I.e., these tests aren't being run in my FVP:
>
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, too_small)
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_1)
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_2)
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_3)
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_4)
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_5)
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_6)
>> > +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_7)
>> > +TEST_F(map_invalid_gcs, do_map)
>> > +FIXTURE_VARIANT_ADD(invalid_mprotect, exec)
>> > +FIXTURE_VARIANT_ADD(invalid_mprotect, bti)
>> > +FIXTURE_VARIANT_ADD(invalid_mprotect, exec_bti)
>> > +TEST_F(invalid_mprotect, do_map)
>> > +TEST_F(invalid_mprotect, do_map_read)
>
> I'm seeing all of those appearing.  I'm not sure what to say there -
> that's all kselftest framework stuff, I'd expect the framework to say
> something about what it's doing if it decides to skip and I can't think
> why it would decide to skip.

Thanks. I'll poke some more to see if I can figure out what's going on.

-- 
Thiago

