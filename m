Return-Path: <linux-kernel+bounces-119535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE688C9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12014301151
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BC13D511;
	Tue, 26 Mar 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvuxaomW"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8813D51F;
	Tue, 26 Mar 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472465; cv=none; b=QzS6Pj/LmdGVebFcTYC58oRUrYej1ukYF3upsZBh+70Qw/hAfRjXyPmlQYQJ6rZIHELMX7TU7bNtD1U0uXdux+EG0YLcqlj2X5SfgUyO0o2/q8+AdJDd/z5XKOfN7svKV9A8sTRcbzRWhSC0GjHUi6dfoHC0iOrlln05PLzxGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472465; c=relaxed/simple;
	bh=uZMNYEaSYzRLyOQcLYp01OkMILTIpdBUfnshhKAM9tA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ov+xOQYXNHgZaoh4fO+cfZlv9tOosncJKOKRpiF3ANt96R8mY+YqpDulzUm7aNqc0ERb8J0CaWfv+6zqRomL9KUYecC9kruVzdbwT5CtYSNl+ZFjMiRv33u9RLYijP6c/+67E/TpcZWJUMTJ9YI/mbIzmU3Nye3+imAXVGvcJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvuxaomW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so82938511fa.0;
        Tue, 26 Mar 2024 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711472462; x=1712077262; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzfexKZPZkf85+a0gllV0ajlzNUH9m6yIuTzuBccjB8=;
        b=XvuxaomW8SPhNyOAA4FaRDcKPHDGCJQ5+0uAuxJg6A+jsKFJf2uVuq3X/JwALggGMP
         +XR47bNhNeq5izEM2c5Tqr7J5Gzg4nVfOUTXuaILEYOUS/4snqWnhlaanaOwpA49StVN
         aODxJdZwAIxgtZ4bz9njmBI3yv2irnNK+b7m8yEidwD5QJ0IC5rDvrgJ+XmSXv2ypywk
         b5rR+Tu/mROykUVgQ1bhGjSkfUSTkAXNDGywpEuj3ujvamyMqKs+Ut54jJwCI3up4dGS
         /Y3kELlXmmwrTtMUCsagndMKSM8SkB/fo3rPi0VlXEGhxQTuRolnMNbSUgxxh0DZQXUj
         JiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472462; x=1712077262;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzfexKZPZkf85+a0gllV0ajlzNUH9m6yIuTzuBccjB8=;
        b=Z49TLX+Bkur8hUPRCfkXMnKWiiGwJt5071J7K0FIjysE/Wtt2jbjfMGK4//ykFNnka
         q3WhcWzzDao4fel7Gq0O2g+2BjSB5gOKkoUXOkDZGPcLQoPmoZb9xlbG2Nk/ylb1BZRe
         Eg07oXyD/v1Gal0MylH9mkPFAUXWDzzwIXiHA+72MeZDS5Ht5iH8M5EQYGGtpYg0dnpg
         8nr+8PEPBSuq5gcWQMmKr88ckBXa6ZNl0gFuhwefokntxVnUnB4FUz1cVuzuVrS3Z9Nl
         ZeqdH7+1l60n/8Is2x+Aurw35ayVZSIrHUju6/O1Y4spJTQm3IBPGEHwVYw2Kcv7P0T0
         gxSg==
X-Forwarded-Encrypted: i=1; AJvYcCVECPJ7e3jZ19M9vv7Rd4gszyJKKTxlLcuKH8YIGxzQRJ3DOkcml/3jYSTOlNjSOob4EeEZN2rGKjvq8SZl4FNiqJkNk96wHj9LUuxMm21QDlQYS4I68aeYg+k9P1A/fuh1vr/Q0aua
X-Gm-Message-State: AOJu0YwoDBD7U5QwiEsqEIIBvTzDiqBgCTBo/oKNjBqMK3G/asobOAfA
	POOh1tlwp5l6c9NUBKCpT8emjGPGqHyR/9anpsiqSRSgDQuORWa+
X-Google-Smtp-Source: AGHT+IH8ru9poxTyHOPjWkzoiAaXgaGlMH2HCJf8Y/pvDqqw8XN1YAg1gTzHA8UnbhEqJC3qSt7zJw==
X-Received: by 2002:a2e:9b01:0:b0:2d6:c535:bf3e with SMTP id u1-20020a2e9b01000000b002d6c535bf3emr1250510lji.14.1711472461652;
        Tue, 26 Mar 2024 10:01:01 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e486:aac9:8397:25ce])
        by smtp.gmail.com with ESMTPSA id o33-20020a05600c512100b004131310a29fsm12116647wms.15.2024.03.26.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:01:01 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: amogh.linux.kernel.dev@gmail.com,  airlied@gmail.com,  corbet@lwn.net,
  daniel@ffwll.ch,  dri-devel@lists.freedesktop.org,
  javier.carrasco.cruz@gmail.com,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  maarten.lankhorst@linux.intel.com,
  mripard@kernel.org,  skhan@linuxfoundation.org,  tzimmermann@suse.de,
  willy@infradead.org,  Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] Fix duplicate C declaration warnings
In-Reply-To: <f735ce0b-db1e-49bc-86ac-b5ab8e4aec31@gmail.com> (Akira
	Yokosawa's message of "Tue, 26 Mar 2024 13:05:39 +0900")
Date: Tue, 26 Mar 2024 16:01:50 +0000
Message-ID: <m2bk710yoh.fsf@gmail.com>
References: <287eb3f74e4c31adb065668ff49c8e1577388227.camel@gmail.com>
	<f735ce0b-db1e-49bc-86ac-b5ab8e4aec31@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:
>
> That message of mine just pointed out that the Sphinx bug of false
> duplicate C declaration warning first reported by Mauro (+CC'd) at:
> https://github.com/sphinx-doc/sphinx/issues/8241 --
> "C domain issues when building the Linux Kernel documentation".
> It had not been resolved despite Mauro's recognition of the issue at the
> time.
>
> It was closed without fixing the bug but delegate the issue to an earlier
> one of the same nature at: https://github.com/sphinx-doc/sphinx/issues/7819 --
> "C, distinguish between ordinary identifiers and tag names", which was
> opened on Jun 12, 2020 and has not been resolved.  (almost 4 years ago!)
>
> There is two pull requests attempting to resolve the issue at:
> https://github.com/sphinx-doc/sphinx/pull/8313 --
> "C, distinguish between tag names and ordinary names" and
> https://github.com/sphinx-doc/sphinx/pull/8929 --
> "Intersphinx delegation to domains".
> PR #8313 needs #8929 as its prerequisite.
>
> Unfortunately, both PRs are still open as well as the issue #7819.
> Honestly speaking, I don't have any idea what prevents those pulls,
> give or take the need of rebasing with conflict resolution.
>
>>                                                  So by changing the
>> function name to something like "query_drm_format_info(u32 format)" is
>> a possible fix. Question is what should I rename this function to, that
>> aligns with the coding standards? Also suggest a new function name for
>> "drm_modeset_lock" that causes the second warning.
>
> So, I would rather not rename valid identifiers for the sake of working
> around a bug of Sphinx.  Rather, I'd appreciate if you'd send a message
> encouraging Sphinx devs to resolve the issue sooner rather than later.
>
>         Thanks, Akira

Agreed, we should try and get the bug resolved in Sphinx. This same
issue came up in relation to this PR that I am working on so hopefully
we can work together to get fixes merged upstream:

https://github.com/sphinx-doc/sphinx/pull/12162

Thanks,
Donald.

