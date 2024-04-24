Return-Path: <linux-kernel+bounces-157609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5A8B1387
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE411C22A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330177604F;
	Wed, 24 Apr 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJIqqU5C"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B421CD13
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986949; cv=none; b=IUgbjqLrxK4ofOsiM9aon3a0bjHIWY9M9K+p22pNH1thdsAVzz23vF6k3ZqTA0QRLOwjbS86h2mXLwLpNbUYIcFNa3tgsZWusdkT0rCD7sMqq3gNGxZy1dnpv7jQNjAkemX+2w8cv4gIHpmdzyNfGmLOJIVA2Ljq+OZX/bxc1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986949; c=relaxed/simple;
	bh=JRgPzzH/fUdn/O1GrRi+kxCDdF4o2Jgz/8RWeLVXu70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3jKbkhL2P21g9JDGpNN2mxF/ZgNL5IezygtJzGhE2Z2oV9T3c5EnnLk1QHrCQD5/7YXP3Op5+kGGJu36wv3NCGXTRQrRIIZQkloeSMU5GntYkfUJ6cSFm75Ecgu+3r2Db29xYPa0uklPET0NRzZl3Rhzr/FMQSEtp7vftTLt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJIqqU5C; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4702457ccbso30066066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713986946; x=1714591746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRgPzzH/fUdn/O1GrRi+kxCDdF4o2Jgz/8RWeLVXu70=;
        b=iJIqqU5C8POYjI7bXkvqdSfZr0QiY8ebx6mvVQFaWfkXoOr6H3U1P9Myr1MpEfuOT8
         qd9UArVFbKR4RuRAGBFGWw1lB909vPP64mu+ECa6tu1cPEcZ3OKuUKh+/ZYpOknXmjA+
         cPc+s2qowYpEaQcB01dZ5dqFQ6+RfCVp2HmmzC2zPORQBFAiRjhteeOjbCfXsNZgySRt
         nDu1Vc85wuCc5o/LglJd4IFJgHKdlAjbm9rHtdZLAnsaFjTcYbaVl5k6Nf8yQhCZ6tOv
         yptSNpzUHQQlNSp+OUCQlJes+oR8aD4aKGeljqkWWIT03kYfAtl9jGegVZ0tqZMdSmSa
         VjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986946; x=1714591746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRgPzzH/fUdn/O1GrRi+kxCDdF4o2Jgz/8RWeLVXu70=;
        b=jQRreaere1hMLvjG1hinnWL97W0DjCnJNSZlfQkbwA4K9QRyzWHYpDJossp6qmoSvH
         YtdEwff19OVTLuWV8Tq6wESNiupBFb+4QJT7aOtbVS+m7yoALqxZSK1q30weXTwf8Ott
         QK5jHLCoOrzdJvZtRD45RIeKlNggOaZnVYyRIpdTeKYR4RuR/cfGJjK6ItXM/tEPbqv7
         lNDVEHRlU0RaxDZAo3DNBZnkveO2PeTUZ45vdBThh622GCWxVcBLzcTur03bL3HqUMTy
         1DnY9vAavbcqJi0Ufjzrep3vZalJoYHcVkaDpHPRW3WJDBKJLYYBTarhmvjfPgzkzUmA
         wjKg==
X-Forwarded-Encrypted: i=1; AJvYcCW5rfKkKYnoFdt8cpkoeDnOYuQ70A+k2rcdYSwM2Fms9H0pSYDqVs/z9J9X2HSoG6Wk7DTj3z5M5D2AMs1BH8Ntr68hS01z7CbB7WY5
X-Gm-Message-State: AOJu0Yy4PCUUMUKqvbduE1jS5i7Nf/DnPZR1Jo4hQEunAZqtH18BHhlZ
	kz3w7t0skjZ8ruYhg2a+IK3VMOaNiELWvgTk/FhXB2Q2y7UoIgDijxF/vWyxvhatlubVBzQWCle
	S1ojZ/Qk3rOSAFcZwPted/dg2MmxN3ofa
X-Google-Smtp-Source: AGHT+IG97Op9uh3XQx6nVCuZMD0+FdWgvvNu8K31rLDAtl5o1qOtmACvdr/IrrK+2QolFc1YQAbMP9dA6WkYMxje9mc=
X-Received: by 2002:a17:906:91c8:b0:a52:58a7:11cf with SMTP id
 b8-20020a17090691c800b00a5258a711cfmr2427662ejx.2.1713986946153; Wed, 24 Apr
 2024 12:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424181245.41141-1-tony.luck@intel.com> <20240424181523.42023-1-tony.luck@intel.com>
In-Reply-To: <20240424181523.42023-1-tony.luck@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 22:28:29 +0300
Message-ID: <CAHp75Vea8OoJ6cb64B1M-2QLCguXNUze=QSjyWKEOKd7VBsAaA@mail.gmail.com>
Subject: Re: [PATCH v4 45/71] x86/platform/intel-mid: Switch to new Intel CPU
 model defines
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:15=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> New CPU #defines encode vendor and family as well as model.

Acked-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

