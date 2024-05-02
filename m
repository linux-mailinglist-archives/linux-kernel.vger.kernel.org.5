Return-Path: <linux-kernel+bounces-167015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527838BA370
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B64B284934
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27A1C286;
	Thu,  2 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZ7tGXWg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F81B28D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689927; cv=none; b=BfkoJxqey9DMM5CpRRj4QxWbkjbm5hcRAj8BVBsd9nTEjq/e15BEHADfsPwuMbjSieKkAHayjioqeoDj4k9XLbrfZvpGQjCb+uP/n9cK3jtaNT68DAtakyds8dY1bRDw9yokXb4dSBQJJJ4yfNBFtT5Au5Gs30a+/ci5QWPXdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689927; c=relaxed/simple;
	bh=I3uuLxNzOCssz8m+55xA6cGRFEwNKBKZs5w/RJydG7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qYS0QgESkn4Vx3CFRSvmODogDJuETSF0+r7p0K030YqdM3KfiMWsQipbLKt76bq3+nP/kd1CbswDlnmdEYR3HRjV2s2ClwRXTPPpJrk0EnP+sF4PMsaRAkD6rD1VVS7ugmWQ1bZu95zZQyjuXdgmvhVlO0z1lFdfZyqMyvqI74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZ7tGXWg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60321ce6cso8423728276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714689924; x=1715294724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng8wdniletCwnFQX4IxNkyDUgPARM59dfJ0NnGdDa/E=;
        b=mZ7tGXWg2jZXu408aU7lE3xcxXutK/7tP//AXPMwln79e9Uh/Q1sBWEoUE7ge2WboF
         zH7f3QtnQc8jfOVVwpkLFtnWxNN/b0yrc+B5fPjA6FQ8Z2t8FC/mikfHTxbmPCEjHSlw
         qNzdvEmTYI2Zu5KVVUxrg7HbKdrg1jDDyv90eVAtCKl3WMJ0rc4WlOL6+QiWsUPd0XZx
         I1QxR3n/27jZqlHOVCkXqt3iTagjdJmmbKCymY4aYx3Z9Ky66yrPGVu5gPZ54Rp+OASR
         +Udv2+2oAcBBXqiV54G2UuQYND0PrrNQvs4i0DTejSXxOFap9d9iZIDj5Y1EVvwwQUi7
         +a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689924; x=1715294724;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ng8wdniletCwnFQX4IxNkyDUgPARM59dfJ0NnGdDa/E=;
        b=XHfyrjSsAqVNJFOvo1f/aZnOn7C3F/Movj8XnhNPfWq/rdl0clp4upuScFUZlxbnOd
         06gOTQDDufIz6MHPAkIFtTMpA3FGIpd8nk4J9zJgbX3/LpGe+e/DLwC+IWLfBQoiSY1N
         Ol50BHoToiiYL2VfZDhoRAoqpaUyfF8IYq7Bq/0vKebN/iSbObng/ibT03B96wm1aDlx
         SgwADn2mJqfOtoXcrgpl0HCVBh0xYpsllho/Y9GNtKdCn24SgApN5ekYLw341YVniuGQ
         +REHGIxejRLXLIFpLjF9DmRMIiTbx1zg6nzXn/+GT3uQCEBVo6YO9PDKJTaxLXO/V3gZ
         x0zw==
X-Forwarded-Encrypted: i=1; AJvYcCVzA2LsbAE0BJEf3HooD0GFTUQXzWTiWBoo+kTp3nq6vLAzIZzSg59gcZdxwRF5hiycVZbuOkhnomvyzjUbpeZiQ65cMWCeKgDE2wE7
X-Gm-Message-State: AOJu0YxKHh3g3qyvzvvYSnLpK6x+CX3pugSwYvU38fDu5ro1wZotWku9
	UMPekCV15b8jGTHmK4yA3CaztW1DBlUywOwoBbO8n+kw7ZRNvpwOmu6QazCbHMcPSwOfh2Pmqpw
	SnA==
X-Google-Smtp-Source: AGHT+IHSaclY4T7RoFl8xX5G9CqldxXXjOMPdHJpuQAdr0cFPX+iMLHEEOj88Q1SBORTFHpk2Agd2Mml/kE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154f:b0:dc6:cd85:bcd7 with SMTP id
 r15-20020a056902154f00b00dc6cd85bcd7mr359179ybu.3.1714689923750; Thu, 02 May
 2024 15:45:23 -0700 (PDT)
Date: Thu, 2 May 2024 15:45:22 -0700
In-Reply-To: <20240502210926.145539-11-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502210926.145539-1-mic@digikod.net> <20240502210926.145539-11-mic@digikod.net>
Message-ID: <ZjQXghB6imRFU4HX@google.com>
Subject: Re: [PATCH v4 10/10] selftests/harness: Fix TEST_F()'s exit codes
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> @@ -462,8 +462,10 @@ static inline pid_t clone3_vfork(void)
>  		munmap(teardown, sizeof(*teardown)); \
>  		if (self && fixture_name##_teardown_parent) \
>  			munmap(self, sizeof(*self)); \
> -		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
> -			/* Forward signal to __wait_for_test(). */ \
> +		/* Forward exit codes and signals to __wait_for_test(). */ \
> +		if (WIFEXITED(status)) \
> +			_exit(_metadata->exit_code); \

This needs to be:

		if (WIFEXITED(status)) \
			_exit(WEXITSTATUS(status)); \

otherwise existing tests that communicate FAIL/SKIP via exit() continue to =
yield
exit(0) and thus false passes.

If that conflicts with tests that want to communicate via _metadata->exit_c=
ode,
then maybe this?

		if (WIFEXITED(status)) \
			_exit(WEXITSTATUS(status) ?: _metadata->exit_code); \

Or I suppose _metadata->exit_code could have priority, but that seems weird=
 to
me, e.g. if a test sets exit_code and then explodes, it seems like the expl=
osion
should be reported.

> +		if (WIFSIGNALED(status)) \
>  			kill(getpid(), WTERMSIG(status)); \
>  		__test_check_assert(_metadata); \
>  	} \
> --=20
> 2.45.0
>=20

