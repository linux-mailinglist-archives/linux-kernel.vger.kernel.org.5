Return-Path: <linux-kernel+bounces-83899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C076869FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB724291CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DA51C4D;
	Tue, 27 Feb 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDcLqfa0"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F350A7C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060939; cv=none; b=EUZh/3yFmVsDgV8eWChqf29CB4DHnpPSa86sB6pCGUbQBJ18qf7OkpTGVW69TzblzDpEu6GLpiTIZ8xOkE0q5RwiSDZGDTBfQQpfu7g8dXC6U+fvbGAqkN+x+EjNTSnvFa0/yiMSs8kjk7kTxGqbeVBOd2S8d34h6gd8VvqI5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060939; c=relaxed/simple;
	bh=73wabGAltLGPlrbwx5dEuZuw5LGsvnG/XNxCGcyGdEc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmFOTYE+eNqlEtukSVlpEaRiWV9AV+ph9CZoMPq05LxHKDNCFwVFKWnBv6rTIF6PisIJ83+naWyze8zy22CgW+caHDy/9n1a3stLyCcxCidjFODSweIaUpirgu31cHT8wqRocUiWwpDWxKVncjeOCp1wWOHgda4z0nOTjyF4hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDcLqfa0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso3685094b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709060937; x=1709665737; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=aDa40DJKClW8mXYqnyP7bggV377JTuxgqEkMOwvAuyk=;
        b=vDcLqfa0WUK0hRIAR49yMaDbMLLePg7UCxDiuzjeWczGsuWY8N8AFq7OL4j3Dec4RU
         TCsGv5yrh1SCpqIn8mc7J4RRByf0t16mtu6V+D+2w+efHZDtWmkVUNa5fe7vXwKHfc/y
         UPNAeN3wbr2QKxeb4BvC/hBchLASSdQ6/e5mYT1xUmlxdGdTYvcWKmKN4Ju+ce9plyvc
         vIckt3dacJzm5mERoyqN53mbATQzwkMBqFUqcH8qOfSnBU1HIBOgsXZSosnRHfa4vuV+
         +aroAjl/6R0kjN1Y+xFMm/BlycpghfEGPPIFFb3Juhj+uLYF4JIfWHKlm8McPqZ7gJzx
         q8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060937; x=1709665737;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDa40DJKClW8mXYqnyP7bggV377JTuxgqEkMOwvAuyk=;
        b=OfipWgi/j/8Ikh/OPHaoMKTEBV4tsir+9zrcM1smRvIiVci1uww05T1YemTWs7rkt5
         hfZM4Fif241R7IH6HrEZYhUYoZ3OTizhB8usccLNlAIixAaf+fAumq57OLyAwhhASebM
         VJ/jxTlWFIQ2k+EHHx2ZHWKaWrhTiUAC5U5uuNKwIHyRO1E1XbrQn7yZ8mVG15Hplhlu
         wnX0OgyiJAIYvjDl8LE82gr7+PcKYLhnNs8DTDzg+flkTL/D2NVG5jAaDOlTxz9GQXl+
         y3Itf0wioKv5Jp0+Qy/xPo8wwSpwyIs/OQfFniiY6hAu8hqjPN3fTTO8VQSo2qojvKih
         iysQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdUVbjvN4Dm1gUKvjY/2EnC1d2VsifV4YHmPp69jfxVpb6nuMNWJ6yf81bUthmmEFAvKznnMhpPJYU42UJPqoYI3sZOK3Li1F333Ie
X-Gm-Message-State: AOJu0Yw20pRjVSCV7VYAVT1l521Ef3L224S5Rbg3rMNhXJs6yiJt9mLk
	9039SSmMKwW8mbEe+mXVB29l9vPctorWUfeB8Vq52U4PWhCr0DMfW6jTK6nCYDE=
X-Google-Smtp-Source: AGHT+IGtXhFFwEJ+AgMWI6EdwH6IahppDs+nYPC080WdpMAQ57X/AOuTkrytFfwmna6ljKJ3aYPMfQ==
X-Received: by 2002:a62:aa0c:0:b0:6e5:54a6:5a9c with SMTP id e12-20020a62aa0c000000b006e554a65a9cmr1287142pff.17.1709060936644;
        Tue, 27 Feb 2024 11:08:56 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:d617:f08f:e330:49c1])
        by smtp.gmail.com with ESMTPSA id u3-20020a62d443000000b006e24991dd5bsm6713883pfl.98.2024.02.27.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:08:56 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
 <87sf1n7uea.fsf@linaro.org>
 <9b899b4e-7410-4c3b-967b-7794dac742e4@sirena.org.uk>
 <87ttlzsyro.fsf@linaro.org>
 <4adb0c7e-34a1-4c50-b011-6e31ef8813a7@sirena.org.uk>
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
Subject: Re: [PATCH v8 33/38] kselftest/arm64: Add a GCS test program built
 with the system libc
In-reply-to: <4adb0c7e-34a1-4c50-b011-6e31ef8813a7@sirena.org.uk>
Date: Tue, 27 Feb 2024 16:08:53 -0300
Message-ID: <87plwh912y.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> [[PGP Signed Part:Undecided]]
> On Thu, Feb 22, 2024 at 11:24:59PM -0300, Thiago Jung Bauermann wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> My rootfs is Ubuntu 22.04.3. In case it's useful, my kernel config is
>> here:
>
>> https://people.linaro.org/~thiago.bauermann/gcs/config-v6.8.0-rc2
>
> Does using defconfig make a difference for you?

No, I still get the same result with the defconfig.

-- 
Thiago

