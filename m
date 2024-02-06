Return-Path: <linux-kernel+bounces-55613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C498D84BEF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E954E1C24367
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612251B94E;
	Tue,  6 Feb 2024 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEtomTKB"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7E1B940
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252842; cv=none; b=Js+xIbRUidqdM8QM/UTAPguPl2tizMXpOqXWCoY4V0R9ULFTifSqX768BW8/MmRVxaOAluWTm3SEGuELs2NwO1RIS5m6npg9AAecjpa1l1QlwdRgQRxnOIWibxkhu4sCabJGkCirRoT5pP6l6tUfb5UvgzmqpUyRafklMWCB4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252842; c=relaxed/simple;
	bh=rCoI0IEgASsZwX3GEF3GMgFm8erAoLhV/zT5w1y+gP4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=B5gG3Pn+cVxGHWVpubUhENo365n/7uDzbkwiOu51msJj4FJKMNv+q4+xxn3gefKhFQK5psEpXqUVVSwMh6GXlsOiSRDWVoVQ37QpnGoA7sMU7uMpHgrOdd9U4e/bHLo60EElJ4l3H68G4hWGEC+lDbt2zvmBjRN25Kc/Ov7jwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.org.tr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEtomTKB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.org.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0bc402c8eso10585481fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707252838; x=1707857638; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgRkIenYJFiu/zNi6m6sN/UnG3a2bdak/SFXuvfD3B4=;
        b=aEtomTKB3BsiB9R+SYEpDehspPDs37GxN5pVlpLLNik2c2W8dFsLH5zjSD6Jkr3Y0/
         mdTj5e6tFqRc2XDLrHqr7xLb7M0sRFRDF81Qbl1Co/4CWhulHUQVknfKE7rH1Ahd9Czc
         IgPmQenuiZI17gv2xDAG7nd3VNs4/RBciFeRTcslFori2ZiHG9g+02Bp3dNlcIIZPj9r
         LnkQdBRQYxmW3jV9TUlVmdb2vZqrG0VjWABO460/cjrIZbPZ4q8+je8mhjlZQtjUVGZJ
         RSBbhlUu2tVkGNoBq3tn2fYssYcsVLrWo0UQlsHhfIU6QdlYPSS709SAG6xRh/WKPSez
         8nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707252838; x=1707857638;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgRkIenYJFiu/zNi6m6sN/UnG3a2bdak/SFXuvfD3B4=;
        b=FfjMiZkww7ECXJEHV8C/42KGd3A2Kf2uxTiOvzzYsbYLN+mIWW4Q0rbu9a2B0XY2D6
         sXKdQ9QxgWp750JummrX+QAkDoQsBOh6BCxZVSAy9DDhMTo7JRP7wpGYpM8s9B8R8djE
         khzy695Ss7/oHQU6SH8IB7ihzQUFKls2YnJE7BwUBj6o/W+4JKvyQGh8vOetV7Q6bOLK
         X78W5ckhXlRToL3bl1Py3tPmNKc1Vj8j6Y9qr4T9IoprrrJeQNd3fS1l0bz+dyxi1HYR
         rKb1lR469JflTbze1YiAjnUH2fCFWgNckwx0FNi6o7+wjRVS0sYHXiYv6y3eRafueNBY
         2dYg==
X-Gm-Message-State: AOJu0Yzyk2rb5bE8JNlQh6I1gKacnkGcymC0V4YTGwsKBdo9k8ATTQSC
	wR6xHrrLQ1R9MIQBXcX2orEWaBgJzpFRDvtOjrMPfg9XjgKINsv9
X-Google-Smtp-Source: AGHT+IHW8TrVEnqh+xLqpb6ocvvrktYxkvPHYBFBu7FbiQm0/MpnIoHiNNk+unSM+kRZUlzIVRQeww==
X-Received: by 2002:a2e:3509:0:b0:2d0:8294:27c7 with SMTP id z9-20020a2e3509000000b002d0829427c7mr1213473ljz.1.1707252838316;
        Tue, 06 Feb 2024 12:53:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYC8FI8v9jOw/uW57rIxrpBxAcBzl3PyzgMUeLh2exrk7f6XtVC0Zccni1u2zfamIJg0PNpmnt+w+LHaWqNu5oUKX0Z1b7fs2qETk7
Received: from [172.27.234.83] ([194.182.161.117])
        by smtp.gmail.com with ESMTPSA id 5-20020a05651c00c500b002d0a10d7618sm374112ljr.75.2024.02.06.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:53:58 -0800 (PST)
Sender: Ahmet Sezgin Duran <marjinalist1@gmail.com>
Message-ID: <b97e1f8927d81b9b72cdea7a30f300b35854c38d.camel@linux.org.tr>
Subject: [PATCH] staging: rtl8192e: remove redundant braces from single line
 if-else blocks
From: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 06 Feb 2024 23:53:38 +0300
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

From de5c5bb23c77fe62987b446c740b971e85105526 Mon Sep 17 00:00:00 2001
From: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
Date: Tue, 6 Feb 2024 22:28:55 +0300
Subject: [PATCH] staging: rtl8192e: remove redundant braces from single lin=
e
if-else blocks

This commit cleans up redundant braces from single line if-else blocks
for improved readability.

Signed-off-by: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 ++---
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/stagi=
ng/rtl8192e/rtl8192e/r8192E_dev.c
index 9b9d95ba06df..080fe9c4585e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -693,11 +693,10 @@ void rtl92e_link_change(struct net_device *dev)
 		u32 reg;
=20
 		reg =3D rtl92e_readl(dev, RCR);
-		if (priv->rtllib->link_state =3D=3D MAC80211_LINKED) {
+		if (priv->rtllib->link_state =3D=3D MAC80211_LINKED)
 			priv->receive_config =3D reg |=3D RCR_CBSSID;
-		} else {
+		else
 			priv->receive_config =3D reg &=3D ~RCR_CBSSID;
-		}
=20
 		rtl92e_writel(dev, RCR, reg);
 	}
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rt=
l8192e/rtl819x_HTProc.c
index 6d0912f90198..49b882c363bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -480,9 +480,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	}
=20
 	ht_info->current_mpdu_density =3D pPeerHTCap->MPDUDensity;
-	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
+	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K)
 		ht_info->current_ampdu_enable =3D false;
-	}
+
 	ht_info->cur_rx_reorder_enable =3D 1;
=20
 	if (pPeerHTCap->MCS[0] =3D=3D 0)
--=20
2.43.0



