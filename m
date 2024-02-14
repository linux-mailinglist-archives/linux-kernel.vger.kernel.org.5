Return-Path: <linux-kernel+bounces-65632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F9854FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B2628F746
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7F77C0A6;
	Wed, 14 Feb 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng9gosTC"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B87BAEA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930962; cv=none; b=pzwvAkhjVV0oDzHG+esVrRgvQwTbw/NybvpfoIpq8lGnQMuCrhOMs3MtLpgK8eaG0gZIJm5rCU/3QuRRBvzs+C9PxZ8zGGVZDDVkykS7oCUX+tpaj2nOfYbR3S529r0sL0CnWuwkeejyVUOlXb0vqczUxhU4DtTl8jLgwfZqheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930962; c=relaxed/simple;
	bh=Ene65fYJJquc4AEYtE1LCICsAUahdiIa3q9X62z8LQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldNE4Q2G2X31gXKYHelv7LV/8moUTykz+PWVhDkoEgvPHb1y1HWKiZnbq9nSPngeBTtGLJn6AEAY8/61fFdM63MW2B6oMN+AhlPCUtZT057QT2K/BMVTPF7r0XJbX/vvEcIoOvLSsEWE6QAxmtepZm4SNioranK7ffp66Ea+IjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng9gosTC; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso5182343276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707930959; x=1708535759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ene65fYJJquc4AEYtE1LCICsAUahdiIa3q9X62z8LQQ=;
        b=ng9gosTCj43xM3I4Qt7XkBrrX7yLtAmEdFzZuMT4gDw5s1VeueRLswf1UobTEHi7EI
         75TTKZWtE1IUpdc88fRfVCahDcfDQ+3Ct1obwvJVF0B3MM+J3Wbr9I+ZRuvhnM98tfoI
         swdzh/QcFgRO8TDwxYF1Q4OlSIZq8BiSYAoT8qJKGTyTquCRuIpkUlEFhGt5qRXt62ei
         fgclnOk55p4JjAixyibHi+E/UjWHZGuHHpFJKNz82hmxrRU8QSZmFNHzKUZvGM2x2uTB
         qCg9b4Y2UDpXLd15uxTxDno9eyvVP8aitgdoE/KjsoGnfMnjLaDLAzR/Z+PRniBtsjVI
         UrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930959; x=1708535759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ene65fYJJquc4AEYtE1LCICsAUahdiIa3q9X62z8LQQ=;
        b=OTEX5zlri5wkd3gCInrlbt2VnGmfjQ9X4jHIS/VbkWba7RT1Yck0mwk945W4RinIsv
         FMJZdamUqrQGQHb/VvIaDsPAiqT44fHAuY5p+8bEEVYk860YEwzgiab6vfbIjuijE4Rz
         DOtez0eEMIEM6Pjbhoy8lWc8akQFh36rtxxoUwmpS39w4aJgqar+Lar4QpGU7zQNU0W7
         VTpQEMfah/AvRgDtYIefwycPhlxiSHcjNuZTjB+WFBp4YCRgTlerOTNvv5Jx0OGC0U7j
         DbX8fqnbrUSaH/OZ0hPB8TlKfVc9ABnsxguMuVUJIVN7OAzsQVEpI1flROPbWxAHy5Bi
         FsqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpURdZcGokVbPPs/SrOGeApbNeQXk7ZRvVSRWfnf1BIHPJ9pIPRhTLSiGyOVgajBgNOR6fqxsWTY2ucpfIehkX3eOn42WF1NgTjIQN
X-Gm-Message-State: AOJu0YwXy/O61RrL+p1fH4loWPOmpS1WfseSQFt2hu5VN60D6I4didbn
	RhW+T8oX1HmmcnyMh/y9lM3RCyVWLrWJj+ArG4gfTyK+gSsCDVIgmWgWezAEe4LtlIs5ZMirfA2
	tJc80gHfOb4GUd8lFpd5x5tJB0lk=
X-Google-Smtp-Source: AGHT+IG98dwwtygWTFTU/gt45MN7ZYxVvTXF3FxHNKyUgKCJO1xJcWLMSM0CmGXAf2cgOtZxhsYAfg0O+8Np8cOUs7A=
X-Received: by 2002:a25:df12:0:b0:dcc:1f6a:d755 with SMTP id
 w18-20020a25df12000000b00dcc1f6ad755mr2815170ybg.39.1707930959665; Wed, 14
 Feb 2024 09:15:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
 <Zcoe9axtLXxB7Jeo@smile.fi.intel.com> <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
In-Reply-To: <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Feb 2024 18:15:48 +0100
Message-ID: <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem folder
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:59=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> /me looked at your branch
>
> Just use a pattern? drivers/auxdisplay/cfag12864b*

+1

In fact, for `cfag12864b{,fb}` and `ks0108`, they should probably go
into staging anyway and removed if nobody complains (I am not aware of
anyone using them nowadays).

Cheers,
Miguel

