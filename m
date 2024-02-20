Return-Path: <linux-kernel+bounces-72194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C393485B0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010B01C20C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A661A3E485;
	Tue, 20 Feb 2024 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URlVho21"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACA37705
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394453; cv=none; b=p+EsUYbFQfwQlKwRLqAttXfQipqO/MKr+gGpkQKL8Ve4uIyeKsw8Uskp+WvpntitJdVOuCWLn5vzkg1rwd9cqOOkAo7X34uFh7z5ubGGrhWmjg1ZzdhJHiMCknsdfWma8rYYmpKahGcb2duPy+1AjuvqyU/nMq7Khb33QYCWd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394453; c=relaxed/simple;
	bh=qiYCOBCXkZA+S1xJHN9t4SVRhSQ71ysKQ9Kl/44/lHY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=dm+BxGTJpmu4h8IIAWZ6yxXImNdvh33a6hR/g36YGtIycXKh28UpbiUVDU8qKnnYali0MiTRwYazgaTf4AtkuOwC8bBJ+wu96lyCOkDt8Aj8PvXbZmaVoDev6cB8Fi8S3OrgLZEtrDYaQk45d4MXFvkN6HjH296/hiNKAhhLsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URlVho21; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dc949f998fso3464724a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708394450; x=1708999250; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=TPVEuybRyh8o5XcrU4e2hriNxyZdgI2hibiqaIMVscs=;
        b=URlVho21yMR+Z+qZ71EA8PfKbTuWDMqmMZV9NTDt07CJBjJyVQbK4/RGHZIYPnzH6B
         N2f6rsZRAoVQcPtpMtktwRhOBooal9CvWgW938zAJhgMpiYhtM1xFCqPvOjlJJ3Z2dTo
         taMHDxMIuxB5Cob2ZufYifbQwRt/irAPvrIbUx7v4hZgRG/tgwf3KAga8qSBafRVBLwV
         xy2heh+04XdBPdQxZ2zpSfB6jIxVB4hui+Ih5Zv/JTXTt1mmW6ZAqh+vQWWHvbMNEctu
         Bc1OkUy9VfIp8UJS2X9RUnyyXE2JCgXwQ8ADilO8XVudBpIs4US5I6t1zAlEYks0woq0
         YDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708394450; x=1708999250;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPVEuybRyh8o5XcrU4e2hriNxyZdgI2hibiqaIMVscs=;
        b=sZzYE6TbP2raFDuwgiT2cfW7iJerhYM6ITiecxFc+uoWqDqL77O+nJjO+koiauvpHV
         37RU6KAIt7Afw5jNSUJjYflyZ8whPPEMzZK21OY86TR1hSVQnzs5q6ZPSeotL5qFRKlz
         3hRxdgCRylHMOvT192hGeYaLwtnyMK7ZZRsZWIG0rLP+vyxo8FYj5NCzh4rma/Jrj/Tt
         ZD+QmvEaCRBUQGAFWZI+vR8+4r9mD7XnWm3WY8UdR4vttFB6bWY3gMFxEr2cdhOWE8lg
         bLNIKx3n+qMM1huauXroDVK/zI39hMCxTo+MhMKa18FRvUMo574pi0OGUHLLQAXpLfw/
         vJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT2/aZzcNfnkUKhiJPRRPKPypas2n+33SMzHF6/NWVMz+a4jYCy84m4cAXYZsJ784BemB5+EMgPHm6rsbvRALolWg8j6K5MAxKNtmQ
X-Gm-Message-State: AOJu0Yw9EAUYJH19c9kRHlxnJrK+XZV8of8CFdpNdzHU73c9yeXCFohU
	Gxbx/XVP+ikyt1HHs9PcRKfhhgTNnu0HeA4fNyR4iPHH1ZU6B7CMEqc0nBzJb1c=
X-Google-Smtp-Source: AGHT+IHQRCR15jZ5TkL4psb84wN2RgNzkdO9BEfcOkiOYvFiSNgotMA3Enz/ysz1JOMgmumVFviryA==
X-Received: by 2002:a17:90a:de0d:b0:299:3332:a649 with SMTP id m13-20020a17090ade0d00b002993332a649mr8755614pjv.18.1708394450582;
        Mon, 19 Feb 2024 18:00:50 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:a328:9cae:8aed:4821])
        by smtp.gmail.com with ESMTPSA id z19-20020a17090acb1300b00296e2434e7esm6167416pjt.53.2024.02.19.18.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:00:49 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
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
Subject: Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
In-reply-to: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
Date: Mon, 19 Feb 2024 23:00:46 -0300
Message-ID: <878r3f99o1.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

Mark Brown <broonie@kernel.org> writes:

> Changes in v8:
> - Invalidate signal cap token on stack when consuming.
> - Typo and other trivial fixes.
> - Don't try to use process_vm_write() on GCS, it intentionally does not
>   work.
> - Fix leak of thread GCSs.
> - Rebase onto latest clone3() series.
> - Link to v7: https://lore.kernel.org/r/20231122-arm64-gcs-v7-0-201c483bd775@kernel.org

Thank you for addressing my comments. I still have a few nets and
questions in a few patches, but regardless of them:

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

