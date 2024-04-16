Return-Path: <linux-kernel+bounces-146851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952448A6BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55231C21871
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAA12C463;
	Tue, 16 Apr 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1hMs6mu"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781E12BF29
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272864; cv=none; b=jImH9SUlacd0SD6HkdP7K61Q5v9E9L/F3mhLSHdz8Aew8kHtNQXoCmNNvXNzzFW4BI8u6kvj5O8JbVee3TRYn6M3fcQVhVKpVVnbPqnJNCnT4vN/QR19+C1DHnjz1Y2Y3KoMqoRIzjEnG1lT974jXMvykumE/OeWfp/t4UFNnks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272864; c=relaxed/simple;
	bh=7uLnhRptJhIlL/WoucKKi6qhTOkpC62d1wAP3c/jHHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxW5SeLxL9PusHVL0xyu3N1COOsIs9JPK5fDMusrKoKq4BpvXLtf+Yl2cslVxnUdHY+1LHeqwS6Re0z9K7hFVnTqI09S0Qzr4koVIO1k2srO+h4GoBGLkXSq0vFb1REWi3VHK2fc2UvlChYGRVND+tCUb1EH0NDjrpIqRDa9zFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1hMs6mu; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa1fe2ad39so2993567eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713272862; x=1713877662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea6CgGbzHVftCIUlE44bhMIJf3xGIJgS5bdRui+rEss=;
        b=R1hMs6mu0NtjDxOqe5Z6R0tV/vOvDyBLK1Yp7cCDppKfLaf6bCYG4rqlWkWsHc3U7P
         zYw8TQGpHqphnnft3uXyAa0oX1PONuRllZbzJ1Gy4fz1VsItiSwx0my2FJG0FBUDawkV
         gao6P94scI+Mwq//XxXCo6wcKABLSfHCk9/ZzfJ1j3tOmHBzyeRheRq6pgOaru+vH9R6
         lv/F9vYhx7DUr7m+szlZn+PheH7IKdHooh+qs4Ofjmp5CfiEHGnc0VDQy+LU7LaoA32V
         6A5XEGHaEdDK+MpqMgVXoZtMQg21NUfPLaDp7jpMrLRgR5k4c9E2ntPC7ewksoCvOa5a
         f47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713272862; x=1713877662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea6CgGbzHVftCIUlE44bhMIJf3xGIJgS5bdRui+rEss=;
        b=Mjlv4WJR4jgyn3cI1V5asqkmSVnM8PJrBT0kmXiZDFUNNqRVgNHDeSX0uA/OjUlXot
         xEdzPnkwpvdoKDUAk1KejkxijL9qaHUhdFhQ0a6fYsQhdwcBv56Uaynuc+SPdbVxLqMv
         hEd5jaTggCiyv2E4fo83nEkplLcMZpxDINX+V4P5bGfgo/hzLAJVY8WWUoxA2tn4ydu/
         UF1/o6GbwxKQsA8vxH1Vf3va+dc9kffg2g2HqngLKHBVZSTBqb9IIi52LP5kbYAbEHch
         n3rm2E+tvP3IPeB8ajX66Cqp7xf++kYmug5B2WWvTx9Wgp9M4JYe9JXFwPs232sMCiyL
         rnew==
X-Forwarded-Encrypted: i=1; AJvYcCWjzkZWc8mlb0EHFzB+HJvdnuBWcGELc4ImbFxbkzeQz14DA5mbGj7Ysw7pNy06nfIgS6HJelE+q17+bO1X0ajWiJWo2u+MUYEb8bmK
X-Gm-Message-State: AOJu0Yw/DLnExI0Zfl36GyAIJuzA/FuuEguVC35ExUXFUHBgMVzDsoOO
	1LxNkD9OOTEhWiXvuPWLNkBLGIU2GJaNDwhoVUElPBaOHS7fwlNieMaG+bYdT7+fuxJ4Rc+5SVK
	b57MV/hSpcuT24qH7icS7AkzQYNnKSCaaQIuFiA==
X-Google-Smtp-Source: AGHT+IH7nHIwoL3TWj/tf4kEGG9jfaQ98hAGzRADAS0JU5ClDVgTBcndZ1ImALsskvzSGFQFySrHCtTqVF/FVHBvAsY=
X-Received: by 2002:a05:6359:4b89:b0:186:3ae:e13c with SMTP id
 oi9-20020a0563594b8900b0018603aee13cmr15909727rwb.0.1713272861886; Tue, 16
 Apr 2024 06:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141953.365222063@linuxfoundation.org> <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
In-Reply-To: <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Apr 2024 18:37:30 +0530
Message-ID: <CA+G9fYu-AjRm-BBA=8fWS8oCbBJ5W443JHPh3uddD7ea7MY-YA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Yihuang Yu <yihyu@redhat.com>, Marc Zyngier <maz@kernel.org>, Gavin Shan <gshan@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 16:04, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.28 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> The bisect of the boot issue that's affecting the FVP in v6.6 (only)
> landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
> e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
> the -rc for v6.8 but that seems fine.  I've done no investigation beyond
> the bisect and looking at the commit log to pull out people to CC and
> note that the fix was explicitly targeted at v6.6.

Anders investigated this reported issues and bisected and also found
the missing commit for stable-rc 6.6 is
e2768b798a19 ("arm64/mm: Modify range-based tlbi to decrement scale")

--
Linaro LKFT
https://lkft.linaro.org

