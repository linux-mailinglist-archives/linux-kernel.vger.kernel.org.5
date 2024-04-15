Return-Path: <linux-kernel+bounces-145422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F828A55F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FAA2833D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E680C09;
	Mon, 15 Apr 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZQShd1y"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97D7E0F4;
	Mon, 15 Apr 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193511; cv=none; b=BPqXvvI2hII1J4JEuu4Yza3LuGW/+UGOCnr49XN0Ex8dPxzz21OnAHRMueV8ssqAMFCUyluJ1sYGofAl6G53/VesNDVyr1MNTtUt291YhBkh8Osnbs9FKu167We2eJb02UqCHyBzZML1k1zLupgcDJC9wc9fMb4TRXxkaFbAv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193511; c=relaxed/simple;
	bh=6ML2aSaXsuAzFVNhdPewOEk6bDpNpols2sKAQORUAXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXL/GQdQYdus7NFOHt1/7g1Y8dNXdvHthF46pNgyEGy0qwp+S4Ucn4W89rybOhQcQgvJgjrAhQIHne6fszMtD0UOC6GEdeZNbeug4h2d8OdZWqo4SyqsI806T8rn6tq0s4B7f6iZ01/dFp4ACa1eD8Jz/dPUJHCrJ+Tm2LDZ5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZQShd1y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2678005a12.2;
        Mon, 15 Apr 2024 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193508; x=1713798308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MchRxx74dTbYu503nGGqEqc0g3arLCUesliZbRkQQPQ=;
        b=aZQShd1yJCfjBSJmyu1NkQ0CirNpEW83cAEyZkedidl3Q+XzZAcdnmdEf6ceZRG+fv
         DINdtutVB0pnOuORO2gWB8kEMd3g5XW3ezeQq/2hCrecHmEi1nZgL6cznDzh4DQR/0hw
         lvVV1Vimhe20gpWby0akZZx3wt1msH2gqbyF6ZcQLH3SlMQ7NX0jB7e3oc4RiF3I1k6K
         5GFrtBb8ICdYrDv3evis+JEf5hIjeSzOXpt6YfnYp56/uap9wfaX2ekiRbIycbz1lLFX
         olnpzgxsSpFXsHnWoX2w0iVtDy3Nha9Ui+G+261UeivhRvTUgdCPrhcbnoEnApDYnxU+
         sLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193508; x=1713798308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MchRxx74dTbYu503nGGqEqc0g3arLCUesliZbRkQQPQ=;
        b=YfPiK0nAKXc1JpWFddUGGOXFneKwF2PYPppqWL4p8tnX/+MQYUU9pQAzhNg9Hggddz
         DNXACw/Gak9ltKBpqoeOSF1FPHQE7TLOp4PFPsCEM+TeJUK4Y3YbcUAWx7E/8w8/t6zq
         7sRkZ2JLhBLqcZjY7SN1M0KmD+ffZql0HZv+mNBHMnoKqG9VEaokGzktgOcK5//b1YIY
         jOCjnvK3lVAVMI+uu4qBRFj7E4rpKYhTNvv6lox1oUUE6oa9Kd/A34vfQHzCXpipJ8ZD
         S4ckS+gfg3//wcdS9g2gEpM5L4NSjsnlhzByY40YB8L7X3I0R4uiXcjyDfG06m2EBGBN
         1GhA==
X-Forwarded-Encrypted: i=1; AJvYcCWVp0l0XVilGrQoRbrKglV0LbNblvkPT3PFKlp/fYPMSmyo5z/vc7jny/YSKJARRNopUHELgjv1EbxS2IGNbzHgP4a3xf3ih0a3PKPWBw/8X1jYohwA4V7bhn+7TDI39eV9eUKg
X-Gm-Message-State: AOJu0YyNM8YuoenQXasLSyKsOwE7KqywjB6lbpoOqUN1yWgOeXrWpjo4
	ge8DkQvNljvvkZy+IJw4eaCGdqowbmc/q4J7vGvIsu3f8swZfnNhlBsoTTCdZbgDpAi4w9yU26o
	CYBsB4PvXgIFuSJqCLAoJedT+HHY=
X-Google-Smtp-Source: AGHT+IEO7I1lSzq0j+XEmqqLAv697PcGVygiYFHtKCQ8zWed31n/gCxa+Jv1oMUo2qrCY77NF3oB2ou9LHirHgzneMY=
X-Received: by 2002:a17:90a:9a86:b0:2a6:e703:3d06 with SMTP id
 e6-20020a17090a9a8600b002a6e7033d06mr6938696pjp.6.1713193507607; Mon, 15 Apr
 2024 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415131941.51153-1-linyunsheng@huawei.com> <20240415131941.51153-3-linyunsheng@huawei.com>
In-Reply-To: <20240415131941.51153-3-linyunsheng@huawei.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 15 Apr 2024 08:04:55 -0700
Message-ID: <CAMo8BfJ5KwXjFDKGs2oBSTH1C7Vnnsbvcm6-qfV5gYh30+VvUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/15] xtensa: remove the get_order() implementation
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:21=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> As the get_order() implemented by xtensa supporting 'nsau'
> instruction seems be the same as the generic implementation
> in include/asm-generic/getorder.h when size is not a constant
> value as the generic implementation calling the fls*() is also
> utilizing the 'nsau' instruction for xtensa.
>
> So remove the get_order() implemented by xtensa, as using the
> generic implementation may enable the compiler to do the
> computing when size is a constant value instead of runtime
> computing and enable the using of get_order() in BUILD_BUG_ON()
> macro.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  arch/xtensa/include/asm/page.h | 18 ------------------
>  1 file changed, 18 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

