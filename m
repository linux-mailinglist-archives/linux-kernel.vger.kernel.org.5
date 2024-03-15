Return-Path: <linux-kernel+bounces-104645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4E887D166
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CDDB221F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E924AECB;
	Fri, 15 Mar 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKokrbdU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764724AECA;
	Fri, 15 Mar 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521174; cv=none; b=bTwzzodKyetBZEPrfMnrr/Jp1gevxwoDV0s0aeG7KEVsIF95n+AR+Yi/pKU7ZCwJNwtSw0F0M8qOfcWb9Q7C4rieqeNHVf1kcL/inSRNqRCl93giRdaBX7kfbeLf32dKKmBDIeqOT9DuLJiqJko0OZBwbsmmsmKx0Cr+sa35WlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521174; c=relaxed/simple;
	bh=PpEhH4GqBsauzs6ODWAzUA/PTPNGnpyFFKUoPIpq/Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFS0p3EHWk7gPyQbrACEhL41r2hDteN5SX2VEUGxEnFN7f0XGRFzPL/PE0TC77rahfT3AHtIR53LnqougUuES0+AocTxVoCjr5tS1/yMvNB6wxqiDV/zCNtn5WSkK7u/B02pDYxZCnvRyXF0EU5N+1sasn0I/stOI8Y4u/x1vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKokrbdU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6eb891db9so1863047b3a.3;
        Fri, 15 Mar 2024 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710521172; x=1711125972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZOX6485f2YWoIfffYyPIciWIsiQeBaoKCVT6/JJ1iI=;
        b=jKokrbdUGpZv5G8s6VykVFOKLJpAiLdelVO4mVTfv1zcQNQ7gzQ8gKkOwYHE1wwle+
         m4fxotOU0yltQKpA9EtAHp2zcZSMZ3TGQFuyJiP2db6bkwhTgM4HzQtQHXQY6ZGfKoqi
         Z/lSM+viEkrwG6fJwxtmNORqp+uvMjD8QDfKdEfTjqXMF6xNU3udRweWVb4SVpX9ty7x
         Z4JZr5JZRafi+4XVZCKD/hMPLJodV9BNt7ajQjK+UBqDC1DyWlExs4xrIqRXnjIRzW5d
         FqAkb/NEa+2sci3dFk64Pf4rBdcKTaOrUuPdDq92m0L8Jt8EWZmc0+n9WTCsO0ZoFFhG
         a6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710521172; x=1711125972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZOX6485f2YWoIfffYyPIciWIsiQeBaoKCVT6/JJ1iI=;
        b=L5lUTZ3Og+xKCHUFUpq4piSR0wO7azXy0A0DhECDEIsX5t7HTo1kQXmBWcapwZyPsA
         7uoI8GYTvTyqXWhjfy2kSl4IDHWZ9uiLU24TNeU/g8mvI6dAiS2pPxOz32Ix1UWNelXA
         7NI7+5nCCUD4pmKEb19hLNYRUrizbvpVT3aF+J8qbooBTf0QAvgzrKRhYVqNm5WoHhAg
         BGsmT4DW/Cvzw0OueS9w4/ZilT9GdC7QAO1h0vjyQGkdkrJXs8VQ9czYokdYgKNO4j65
         m8JCvxSxm+KdAxy+AXYMfv8HIK516M8mgAbnb/P4BFIEp8TXI/xuNNscwvMKkphnwsIU
         fi+A==
X-Forwarded-Encrypted: i=1; AJvYcCX0++6AhUMHYDp+/z2QYmSMvzaUaLt6Qb7xFg1aTx7VvS9liGXSHP1T7L8usq7yCbLK9zD+aAkeTDSaxKy95ZLlL3G+tbdihnzA+iZ+s7UD84IM2Sev1Aa+qXTbi0DREKMIdCXWdQDG3c/Q2yh6qalsEJs0FFrbnuTsb9nTF50=
X-Gm-Message-State: AOJu0YxADBltOeY5I5ImWB052R7Fc+xdvljpzHQjjzotCanxWIWQ54v8
	HcM+g3az3oGnYyGZcRT+v/4dI5vEC0QyiOt/LfhM8PF28m0RlZb2uaX1+abQFqphG+p0gJOBATC
	cn1S7EM4Pg4UC0bZA4MNpCx+llOPdZ5PZ
X-Google-Smtp-Source: AGHT+IFIU7jP06uCSEgXyzplvCTBrSSs+Qaju6dpK+T6gLdLY6C5EtagC5SC8hsgKq7e8HnNEV0OMeFo+GSklwcnSQQ=
X-Received: by 2002:a05:6a20:12c6:b0:1a2:b33b:d6e0 with SMTP id
 v6-20020a056a2012c600b001a2b33bd6e0mr6414408pzg.59.1710521171702; Fri, 15 Mar
 2024 09:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com> <20240315113828.258005-2-cgzones@googlemail.com>
In-Reply-To: <20240315113828.258005-2-cgzones@googlemail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 09:45:59 -0700
Message-ID: <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:39=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add the interfaces `capable_any()` and `ns_capable_any()` as an
> alternative to multiple `capable()`/`ns_capable()` calls, like
> `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
>
> `capable_any()`/`ns_capable_any()` will in particular generate exactly
> one audit message, either for the left most capability in effect or, if
> the task has none, the first one.
>
> This is especially helpful with regard to SELinux, where each audit
> message about a not allowed capability request will create a denial
> message.  Using this new wrapper with the least invasive capability as
> left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
> policy writers to only grant the least invasive one for the particular
> subject instead of both.
>
> CC: linux-block@vger.kernel.org
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v5:
>    - add check for identical passed capabilities
>    - rename internal helper according to flag rename to
>      ns_capable_noauditondeny()
> v4:
>    Use CAP_OPT_NODENYAUDIT via added ns_capable_nodenyaudit()
> v3:
>    - rename to capable_any()
>    - fix typo in function documentation
>    - add ns_capable_any()
> v2:
>    avoid varargs and fix to two capabilities; capable_or3() can be added
>    later if needed
> ---
>  include/linux/capability.h | 10 ++++++
>  kernel/capability.c        | 73 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>

[...]

>
> +/**
> + * ns_capable_any - Determine if the current task has one of two superio=
r capabilities in effect
> + * @ns:  The usernamespace we want the capability in
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given sup=
erior
> + * capabilities currently available for use, false if not.
> + *
> + * In contrast to or'ing capable() this call will create exactly one aud=
it
> + * message, either for @cap1, if it is granted or both are not permitted=
,
> + * or @cap2, if it is granted while the other one is not.
> + *
> + * The capabilities should be ordered from least to most invasive, i.e. =
CAP_SYS_ADMIN last.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on =
the
> + * assumption that it's about to be used.
> + */
> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +       if (cap1 =3D=3D cap2)
> +               return ns_capable(ns, cap1);
> +
> +       if (ns_capable_noauditondeny(ns, cap1))
> +               return true;
> +
> +       if (ns_capable_noauditondeny(ns, cap2))
> +               return true;
> +
> +       return ns_capable(ns, cap1);

this will incur an extra capable() check (with all the LSMs involved,
etc), and so for some cases where capability is expected to not be
present, this will be a regression. Is there some way to not redo the
check, but just audit the failure? At this point we do know that cap1
failed before, so might as well just log that.

> +}
> +EXPORT_SYMBOL(ns_capable_any);
> +
> +/**
> + * capable_any - Determine if the current task has one of two superior c=
apabilities in effect
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given sup=
erior
> + * capabilities currently available for use, false if not.
> + *
> + * In contrast to or'ing capable() this call will create exactly one aud=
it
> + * message, either for @cap1, if it is granted or both are not permitted=
,
> + * or @cap2, if it is granted while the other one is not.
> + *
> + * The capabilities should be ordered from least to most invasive, i.e. =
CAP_SYS_ADMIN last.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on =
the
> + * assumption that it's about to be used.
> + */
> +bool capable_any(int cap1, int cap2)
> +{
> +       return ns_capable_any(&init_user_ns, cap1, cap2);
> +}
> +EXPORT_SYMBOL(capable_any);
> +
>  /**
>   * capable - Determine if the current task has a superior capability in =
effect
>   * @cap: The capability to be tested for
> --
> 2.43.0
>
>

