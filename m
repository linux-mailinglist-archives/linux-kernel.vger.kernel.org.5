Return-Path: <linux-kernel+bounces-56366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AE84C949
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1BC1C222F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7B17BD6;
	Wed,  7 Feb 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG3UQSSu"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706F199B8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304400; cv=none; b=IeKJHjL6qyPV6LWXvYSI2OQRQop2jJf0HftRdRsE9qE2c7MrlDqxc1knEXNZtZ7xpBwWOT/tZlMy9eb6+c3XRQPLaImir/SD1SYiQttEtPlYZmeblchEpNKU+jG5dp1ABbyR/saNGI+OgfSqg/9JrLniCS4siSzHVfH4LjsSuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304400; c=relaxed/simple;
	bh=zySYFccihDrwZaT1IgLzPF7fD5IAJC5dyZNWYr213rc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRzHmO81xnDG63TTImmy4PMXh6OtVDxTbzRmeHyEkE5nawoJc2Gn4zKHAGFvGLRMCFpqw9ShU764aRV2jHE/PgkaWJALZtpGfi9HMJcS0I28I6ey2BcQg26vV45W7NcABc+m172LmlfNHy7toNPdDLWavJgacXRMnrpeFd9y9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.org.tr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG3UQSSu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.org.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so285427f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707304396; x=1707909196; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zySYFccihDrwZaT1IgLzPF7fD5IAJC5dyZNWYr213rc=;
        b=NG3UQSSuqFk7pxN+G5Psp/zFAN7N7xHBEiHiM0PCa/0H+79Am9Qj13haaKwt6sQsC5
         BQnWGMe1qdBfMAd00erUbtpxKGzRmKFMGju2EQzqQjD9u6VWVpo7BVVq7bfMmxjpoHYt
         v0Dc2LOUGM9Oho30YBSS60NQO1fU4xyP3VL9Lxc2EWCS11YCql/3aOEEDPYUuzTe1Yl2
         D4qtDVuaSRjrz3nIouktIqs/xk1FkL4MT3XM0mg9GgKKcQHtJw1IsZYgjtdfNBS17O9A
         vI9Cj2ZrXUJ/407p3ej/O9CVn3aOopRZm6/ue44bjYNyun8L7VoFktJzLANHtkJJqeJ2
         s8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304396; x=1707909196;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zySYFccihDrwZaT1IgLzPF7fD5IAJC5dyZNWYr213rc=;
        b=LXoaCVgt4yrIEbo3j+4TpO9uEYeCMhM1efvwrdGgrni6oasJOvHKqoLvj2qb4WbZXq
         P5XwHmYohxLrue6qfYaFEt1RyvS+7dQ2htXPy84PNjVSW2IT/gXX6elBjCHR6E+8mOlE
         HON2A6MgKLvbBLHNQi0ZdhDmWCGTi9hQ/jN0EBaY4jR3BcjGJtrvZZNUrnW5p7x5Aakp
         F7+hhCWnxNGaYQfzDLkf7j3RNxjuNcEeQ+CtqUEnnM/H4VOLH7Ud62Wh+RrZkHmT7YWX
         sPkLfH+tYb0JSTMrKVmNxOBZTZ8AYjG3Ox49PkGlHbyeu6PRkFcnyTbJ37hWM+73/PNU
         2a3A==
X-Gm-Message-State: AOJu0YwRObqAF2OTlXPuOM2gF4kmZ5Y9rSUDgCVsE0fy5hMqU9VzR2A/
	Sz1bCzsPVc0FEdJc+UKIGdrX+ZuCrAttRWx9MWIDNfMxw6I+xbkuTFQh++t5oGscc8YB
X-Google-Smtp-Source: AGHT+IFutYvy26omr7yA4m4eUfQxNYboE/Jf5Qxq/1tzF7Ce9rBlUf8UAj19Q9KNbr8wEnjM0y/6lg==
X-Received: by 2002:a05:6000:f:b0:33a:f503:30b3 with SMTP id h15-20020a056000000f00b0033af50330b3mr3375903wrx.24.1707304396109;
        Wed, 07 Feb 2024 03:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLegz0nhZiBeDJJGvsltfeGwkmJaOLjvh5L5wVPC+IEBhdrb9b/KtgfjeqZ7X+6STwom4FCrrWSvRDsrWTeVleTXrpQgbQ23ETeEJn
Received: from [172.27.235.95] ([194.182.161.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000104d00b0033b4ef142edsm1031749wrx.110.2024.02.07.03.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:13:15 -0800 (PST)
Sender: Ahmet Sezgin Duran <marjinalist1@gmail.com>
Message-ID: <54d63b6edc5421a5be2e552b03592eca5cf85b2e.camel@linux.org.tr>
Subject: Re: [PATCH] staging: rtl8192e: remove redundant braces from single
 line if-else blocks
From: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2024 14:13:14 +0300
In-Reply-To: <2024020757-desktop-atlantic-749e@gregkh>
References: <b97e1f8927d81b9b72cdea7a30f300b35854c38d.camel@linux.org.tr>
	 <2024020757-desktop-atlantic-749e@gregkh>
Autocrypt: addr=sezgin.duran@linux.org.tr; prefer-encrypt=mutual; keydata=mQINBGOrInABEACu7yscz4VnzHiFxkokQr/3I8dGSJNwCezSCyQWRQWZC7uBTHjLtECKVespRPFF+U4FC9PkjWsTf3MwlcgqgcD5RXD4y/JDaHdxUFukSg+gpMxV+DrVGaQQKEx3ny8Kp0OGbNDGL5E8v2bOM2UCKDheBIC7/DJEBMSawHkMHby9j6WZDpwW2JFCbCbJAl3cPfA54ke38jNGrANKTfPeGkml5Xzah8uLiNC9Xxt2qpsV5+CT6CjnWWYDU+KxGLc4ETTPl2iDdChBBB6RAvPa+Qku+zZPvS+b9V+luOnT1aiUCSpF/CENoSgfJB2PH1Y1HjHiXMjXLpo5T+phe1pslIrEmUIEjJ0BcJhzA8ytrOifhIzho7qO+gQSIFB+a74WLgMH7u9KoSyKvOD36rg8C3i9HFZALej2mDOqtQTwDIaJyM89X6K7b7veOwjBy3igqykfeQ6R5gzfI87pMtBiyz+aCbu/DjULmGRbwJJZ06bPL9XjNigQEWFZzBWB9nPt75J675JMszHMo1JmBPa4XuO2rNtrXaO00cxPznjuRSPWjMbx8XgNXVSO5QiGwSQEV76iWdzoiS3zgAL51tzZjCX00UVxD9uaHCv+85HuAocjulpZVgyTm2Pt/rSzE9eparQ0Ijx4nwBZdpZg+oIpQHuQ0cOl0DxqlJs8qYcXsjCuQQARAQABtC5BaG1ldCBTZXpnaW4gRHVyYW4gPHNlemdpbi5kdXJhbkBsaW51eC5vcmcudHI+iQJOBBMBCAA4AhsDAheAFiEEnm0RpBDOXPRjeFQeA8hM05xpM6wFAmOrI20FCwkIBwMFFQoJCAsFFgIDAQACHgUACgkQA8hM05xpM6wYxA//VAr7YEEputCZqh1R6NsJ/hza/+05Clhf0NVlLb/AbVLJBkLI
 lK6N8JajpsuO3XLQSi6flwiVRX2eW3fU2jwIiU6bGlmEmsmJoxvGxQQeyxNzGx+vT 00kAdbLoEHN1xOmOQfb7N+uAUvFNZbf3Lz3rKI6UZ/vIxZDuFtIaLp+WhLG7oJxyQpRloTgFfz2/PBd5oxkuqJsU4SELiDCk3o68fCXRFzDKrpaJvDvV5dVFPFS9KHPQBKvTPNDKVDaRAt7eeezzYMv+4Wby7UScCBdBp7vo8WW4H1fsewVofJ/9qASPn+BwUp+b2xmeomCGGjndpad/sLOeV9Ipw/9w2iw0N5bH49fPYYO2mN4uX3ayPquNwOlifOcwtU4taMqX6lFLGWJa0zoBugwN0lhD7k8m54jgyFo5FtlmrKmBKHCzBK6j5s3qZ5brpvJEsvegxKnMFN1vZXh4nyCjrtucoFFQ8doX02YQtH2kPi3/g9PbHshfiq1gN+vp/ryCbWSpXMUR6qB0QwMRGRujTUZJ+XFNBjtRGm5+gf1ewK4fYlk8r2QtiatohWZu4sv/DWvSH7dH4kk+9YDows29TNhmv9Ov+YGvIjFNK2T+tT29b3YJCEaYQzfqCbSNjMBgxVQghgS2vV0uIxvyK2RgP5UrAjCwst1AZbKjNfNAeS4hfUX+Lu5Ag0EY6sicAEQAKDjpATqBlSE5dI8/ks/LKCztIir1bFOlBZLftTeNaDOQPF2vsmUSnlsICQ+/hoHW/vtV4i0I5aclEw+bWvD3ETEw2f5anfXu7VBlZCqcO1n53SXneYBuIQGSqPOcMzWn+khaP1zsIJPnjyR/UhtxXxrx5nsIcDnKafp7cn5ZQLlsZJfZMXkW2QeD8Afpz/T34p75hnd/neQgB72nAWMwjhUYbDnJ8FRiUPpH4zvzfBbvNpQbcT97aBFju8m8hx0PG6BtZkNQA17o0tbC9h2/PpZNDItUQMbfy9HpomWR0p2fTAQxgIil6n3cbVF9Xmr6FVAedjJ7jJNmFAP3h6U3D68BpDz
 ctDholQLhirZk3HzmwV+g5tfHQL/Bvg+ymZ2PhB+fMTftjECSMl98YGDYI9LXI0O12 VfD11yQUxv6jzJjk4cT2+EFk6CZHOCndZWZuEOd5e4DKa8zJYkNp58iiV7Ikovzyo78kZNl0Psr5iI4QA05enWD4PxK7VA+sGExcOeOu6BUUzRHlqdEjNE0u+u/1c3Tj6JRYKxzKcfICHtbtNgBAa9lY4AGQDOG50aYl/AO4aNqAknikGesv7eQfpS8T0OHyWxUeH58pu2xwgxzhhsI5PR21AC4v+IuL+MmDPOvo65ls7QHP9B5Mn/Y0AuWDON41xJLOsysYxrtvGVABEBAAGJAjYEGAEIACAWIQSebRGkEM5c9GN4VB4DyEzTnGkzrAUCY6sicAIbDAAKCRADyEzTnGkzrBhgEACq4myBQrJXefRw8a6zBQHl0zgVsukJBVWIKFhM4IuZiQcCj5cxCEDnJxjW7V+0SUNrrhpBM8ZoSdeLVNl7GksqjYKkjzNOUUgm19eKREwxZl+76sHm1hVzvPbWJarJzgiTFiNuKQDVsFiVpp8elawRnz7EbBb6jCWaFAgDfx7XMptRv2KiuFVcVzYvGOi/UyyodsYoWHP3ozAB84XhMH6n+cXufG2rvi+H0RYoTlbOsvdNBKXDLHpGCgNI21X7tjtOPToxHVqLieVQ7PiAYKROvxfEERy3WH38DLn41sWKOCmgHZte7LqCDMt2DSUfJcklTSWCk0uYwITPwamzfWttVmG3E855mskJukhYLpaZYowI/7GxYQedOY2K2NxHF5UaP6wpAtjkrvAFAUYrb3symewQe9efEz40xtid+ROY0JTosYR+rN5nb8zYqQQL8v8fyNQ88YUkOJthPydbYAfnOQEj0ERZZleLxGzrvjluMWupjNlJuQeEw4BXj260jA/Jcpd7/VNUJ+zp94OHuS1rECK+nU3O/Lshbf+exHc9vTInRArvh3zZqS4++/vhEWDE
 8DiBk/uuk277ftC+6EsEDLFmAtbmBztueFWszagrz8JLI3kxfcYFzDFFARY2bgq4na/ 0FzGsRHZjDgS0nTk+qw2arV2kpIEVvUODwYwFQrkCDQRjqyOAARAA3petyzMO6FmQKhwdceNgYHEBc14iY8Ad2zS1nyIc4Fnp9S8lRdrw+8rMDYAaBArDhSqlYnaO200rX1bvlDeXB9N0wsD/hAfUqQT8TGd7w7MKuzLxMZQSP5j7eXm04XeMh/X20ntYnaUtCxhwqFXDAbu5cy9ZNkFSzgwg66wjt1uKG9Fx+HEpdJknLVgFMTuxlO2aP9bfT5jDTaHzJRT+NflOA/g16fmIvg0ZdOMhScePeuwnQSrTiVl+Eb77PBdCd1N7xW2rFh7oGJf9FWB2zJyZt7CKrfNK4LHWpmVFt79qhMInzxnJ6kwxqq5x9uYjTVjGrztRqOokvDk5XHMFJ7Y1lXnbeu7RrRL2rJg9CEenQ9O9IFaucIGsBFbTs4uNvd7FsV7BjELpH4fQk9REWNuwuM4waXyIzjNSxEXGRGlF0ZcHbcgV7GtPf6nTn2fN6QgKu6cNIaw6FwPHF3k1Z/DrLGW4hrBd8jPnkAB+nb1rMVRTlbsv4NHuv/NS4gwxNV8IIJzh0CiqeCGz+dYgYt5MjKcXlIyAchTuYleLpn/Qe2+Kj7Be8qL29IP492KQ+3eBb/PUGDB75nkVsH4FvyLuJkb8gtdoh4lY0bAiBsEbk9WtzyaGVwrx9jgW8Req1FryAaLeZwR3wfUXOM8+eWIvjQBI8VxstFntFpu2+EkAEQEAAYkEbAQYAQgAIBYhBJ5tEaQQzlz0Y3hUHgPITNOcaTOsBQJjqyOAAhsCAkAJEAPITNOcaTOswXQgBBkBCAAdFiEEVrallu17RpnrJgHorXZms6aPC8wFAmOrI4AACgkQrXZms6aPC8w4MxAA2IgCTsf+4lnxUGvEjWGhGndO5HFKGBvv/WQiSQn7P55q
 ffhmp2xzn+3GK/CnI4z/7xMvQfJ+evytqyuXqgOMPu0V8cTJrJyTRKDg8Vua82I82vXu QWBLO3Bex7BaB3neJGTQ5MMq59C6JmTnp24Om+LBI05g95FJnzbGeDlqKN0dNqFBdkZQjxymNXHcWjr28ml2Trsmf3A6cZ2wEy5UI6k8EQ9yPG2yjjH7DOEnRgWHyWaDFIA7LLNSCmZmB6R6DJp7KHBq7k8R6aDbux7HvQxTYVJZqqHJ9AiFbW/RbjFkkjmT/C7X/P4Z4OXkUcFbcZ5m6tr+RZazRyGT0/tBv0jfwVa3W9HLAG1hslNWtmYZ3gvepNxwTPokfU63gqzywsVKj3hJ/Bs120VFgOxNb+wbs0xrpQNWJp7IuSx0gPPHkwNVk2sMWI2ThKj/n3oCdrknYi2sy2DnWLIvYGFAUdyI17zFniTEN9Qg9JA11bBnPureVZ4Ioa/JJMshfoVYvwNTNKsrCyN+S0/wDXsr0OJLvau4j9eiz3PDcD0kKEGqPxpQTCNM3xT0Vf2W3A+QQSoYoyY6p/G7zTy2HwXxz5nUAQSx+bjWy6XixkqL2ZM08NYi9IY0QfG2NXUNF2t3OqCQ7guXkXlBQxHQYJH+uPGbrnJNmjvZ/fZp6UWbFolbFg//URWdYfmYVmvonVWZ+9dEm+O7LmuqMlx2UcMUtF1uwx7KOaJ4gqEyuka8qmEQQSfeUHsuhu0ZLAxmNDC9RTUsTHC+/QFPN5mY4hNhkODeCHThKtpzm7j+Gi6xFceLxLT5pumK/GjDnVrnNYOjRo052frv0Mq2hF9bivNDrk0ZZPV7CyAt4FhSibJEju2wSo8LrX9vfi5xdedSORgwhqJYAYxUDkKDTniSEsBqtdtA995jUHCuQ2nFYTY3k5FDdM7kUhyAd3GlhklJ7IAV0MFoqgW9B6UThYTg+f0zzT6g7Gjz6IR80PUo486L8ELsTT+udLqOO4SBIO1C99N/A6zK3aR+udFnnkXo
 cKs8fMG+avecJ8dqbMgQElqg5RSTeDFvTbadkpCKv0EnYtGLKXYY/54Fr2iYS1V1etXg/ 2V8WpGHY0YdKQS16FppKuhx30NDl66OuPBCZfdibV3nPikQzeP3TobSOxmUJ48Rcyl4GnzcBQ37I66juAiK5YyXN6kQFMU+qJoBuBI/dXAx5/+WX2gp7leiLVA1wqgFB5eNg5RktKOZXUnQwbUxrOHF2dXewsIAsoMipLs5smRZm39Cv/4Fzrbj05BqZB5F4LCMql2JLWyR47kJKWzWKkkm69RdiA84E20pJl+E9X21cUOtI1+hIUo/fg+5+DBQ0w+AGj4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Why is all of this here in the changelog body?
>=20
> Please fix up and send a v2.
>=20
> thanks,
>=20
> greg k-h

Sorry, I forgot to remove those before sending.

Should I send a v2, even though Michael Straube has already sent a patch?
(didn't know)

Regards,
Ahmet

