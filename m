Return-Path: <linux-kernel+bounces-116952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D246288A570
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607BC1F3AEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0221C68BE;
	Mon, 25 Mar 2024 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbkvmD0H"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D917279F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366622; cv=none; b=ZJjtzwS5f0hRj21r8IyRjXqeHbmVOk1Ap0aEQpBIX8wNAKWuPncbSWwAp5Jg1vCeYBeqGkvtxDwb3Q7nFk9x1JgCn/aOVZsR+KxjhU27KlCjNAvEuZEU2ClLaa9xuMk/YL98k81OC4uhItOKLkYncfoQzezywBFXmnOjYnaVPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366622; c=relaxed/simple;
	bh=/D52BHvUewCK2GL9Y8W0RqUx68ljr4iQuIDQFK1r6z4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XVS7l8aLxp1phBkFeHky7uzEeevR1Oiish4wpZCNgODZLoSFTkvJ4VWXz+9jwQDjC9fqS2KVjRUY1gA+KqII5qT35lJbhLRs4/viY/9aDhQT7tRtmjabe+zU4v8Mu27OYy/ZmKiouo/M1R1EJH7RJT5LDqN2qB0UaZ/iAn5pGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbkvmD0H; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso516388766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711366619; x=1711971419; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yYmh9ilGatslqz9nzmGmez9Ks5eyhsXtq+smawLikQ=;
        b=WbkvmD0HmL1Coxm4keZo8yjEGAQXz/hUd3MFWQX/+04VTaF7SoLePmnVvAT8biu2Sg
         fDSo0dKULuNLbaxGPolVJyvUtQA051CsxWCcKkmuXQs/9wJgB5g+n5drxad0OIzMZq0f
         E3RWhtfa74ON01T0PZwSwBsTSheCO0nparCtv05IyxiTapX4jFte7bSC7zBzNnFwqDc0
         SiEf5/3HjrQIrISvYLP/uSiBpKoD/7H4i0T33hPYBHSyT9NDxfNCee0gGKntZ3SqSYCs
         lLYueBQPnmX76/XD71jZKtxYUrE9qSV3uk4eqCu+sclE98J0b0EZyK0WNaF6BJ4JYPi+
         D7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711366619; x=1711971419;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yYmh9ilGatslqz9nzmGmez9Ks5eyhsXtq+smawLikQ=;
        b=tSYHyGJTaI0w49X3W3yVtu5YRiW1lzcI8e6GP6PmnaESj90lxr3AoJFbUgOg41QlN4
         RdGt6WbUt7RuCZuvhmc/xZJtWCQkdk6Y0DL/sanPi6BTVmJJZzM5ebu6lMyjxQXkZe9E
         rso1eASkmgATu4MByqwfLB4hsayA45r7U5hkxDglQjQN0/ie6xj8HbuazV7blrjUimew
         Uibm4AI5hvFxZ0IQ46kCPIlAm1b9SOwgJx3G/eHE9yjkyVZmSi0F5rsm0RfiYCfiUEQa
         GGTDYMfkjhVwXzvsYLToALQ1pwrWCet2/TmnbETePr4heCtAcKPMp5tZ3aeWWiB3/Ba1
         rMMw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1KgcbvUVDNBFn7Ci+1FPQ0wQarHEmr/Lu+nZWBGvXnU6fbXWhIao6eEUOgEL/2PhkKn1ndfoVXUTzWNlhTdIJfuW/3DxtLI/O8+n
X-Gm-Message-State: AOJu0YzRTzoiZ/W6jTRTvRgd/ngv3Dm1ygEpEmSJsm8vYLx1UbSn7QlN
	8EnZo+XgUQBiZxNXHJ/K6HPeSetWp3hOsFPyXAN8gQTWHW1WyH5kZEjcKmvfbrozQQ==
X-Google-Smtp-Source: AGHT+IH6c0oCiM6CpSIH3+fOqTkyS+RcmYNisq65V7JULsv8sbnj16RwVvb8LtKycoS2t3mWk74Utw==
X-Received: by 2002:a17:906:c2d0:b0:a45:5be1:6e20 with SMTP id ch16-20020a170906c2d000b00a455be16e20mr4420850ejb.23.1711366619050;
        Mon, 25 Mar 2024 04:36:59 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id hj13-20020a170906874d00b00a474ef94fddsm1922774ejb.70.2024.03.25.04.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 04:36:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] drm/panfrost: fix power transition timeout warnings
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <bad16bba-5469-4f20-bf23-7f3c2953edc5@arm.com>
Date: Mon, 25 Mar 2024 15:36:40 +0400
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <620A6EF4-4361-4B5F-889B-268091FB72D9@gmail.com>
References: <20240322164525.2617508-1-christianshewitt@gmail.com>
 <bad16bba-5469-4f20-bf23-7f3c2953edc5@arm.com>
To: Steven Price <steven.price@arm.com>
X-Mailer: Apple Mail (2.3774.400.31)

> On 25 Mar 2024, at 2:28=E2=80=AFpm, Steven Price =
<steven.price@arm.com> wrote:
>=20
> On 22/03/2024 16:45, Christian Hewitt wrote:
>> Increase the timeout value to prevent system logs on Amlogic boards =
flooding
>> with power transition warnings:
>>=20
>> [   13.047638] panfrost ffe40000.gpu: shader power transition timeout
>> [   13.048674] panfrost ffe40000.gpu: l2 power transition timeout
>> [   13.937324] panfrost ffe40000.gpu: shader power transition timeout
>> [   13.938351] panfrost ffe40000.gpu: l2 power transition timeout
>> ...
>> [39829.506904] panfrost ffe40000.gpu: shader power transition timeout
>> [39829.507938] panfrost ffe40000.gpu: l2 power transition timeout
>> [39949.508369] panfrost ffe40000.gpu: shader power transition timeout
>> [39949.509405] panfrost ffe40000.gpu: l2 power transition timeout
>>=20
>> The 2000 value has been found through trial and error testing with =
devices
>> using G52 and G31 GPUs.
>=20
> How close to 2ms did you need in your trial and error testing? I'm
> wondering if we should increase it further in case this might still
> trigger occasionally?

I backed it off progressively but still saw occasional messages at 1.6ms
so padded it a little with 2ms, and those systems haven=E2=80=99t shown =
errors
since so I currently see it as a =E2=80=99safe=E2=80=99 value. The one =
possible wildcard
is testing with older T820/T628 boards; but that needs to wait until =
I=E2=80=99m
back home from a long trip and able to test them. The possible theory
being that older/slower systems might require more time. Worst case =
I=E2=80=99ll
have to send another change.

> kbase seems to have a 5s (5000ms!) timeout before it will actually
> complain. But equally it doesn't busy wait on the registers in the =
same
> way as panfrost, so the impact to the rest of the system of a long =
wait
> is less.
>=20
> But 2ms doesn't sound an unreasonable timeout so:
>=20
> Reviewed-by: Steven Price <steven.price@arm.com>
>=20
>> Fixes: 22aa1a209018 ("drm/panfrost: Really power off GPU cores in =
panfrost_gpu_power_off()")
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>> ---
>> drivers/gpu/drm/panfrost/panfrost_gpu.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c =
b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> index 9063ce254642..fd8e44992184 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> @@ -441,19 +441,19 @@ void panfrost_gpu_power_off(struct =
panfrost_device *pfdev)
>>=20
>> gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
>> ret =3D readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
>> -  val, !val, 1, 1000);
>> +  val, !val, 1, 2000);
>> if (ret)
>> dev_err(pfdev->dev, "shader power transition timeout");
>>=20
>> gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
>> ret =3D readl_relaxed_poll_timeout(pfdev->iomem + TILER_PWRTRANS_LO,
>> -  val, !val, 1, 1000);
>> +  val, !val, 1, 2000);
>> if (ret)
>> dev_err(pfdev->dev, "tiler power transition timeout");
>=20
> As Angelo points out the tiler probably doesn't need such a long
> timeout, but I can't see the harm in consistency so I'm happy with =
this
> change. If my memory of the hardware is correct then the tiler power =
off
> actually does very little and so I wouldn't expect it to take very =
long.

I=E2=80=99ve seen tiler timeouts once I think and thus included it, but =
not since
the values were increased. As long as it=E2=80=99s acceptable I won=E2=80=99=
t over-think
it but if more testing is needed I can look at it more.

> Steve
>=20
>> gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
>> ret =3D readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
>> -  val, !val, 0, 1000);
>> +  val, !val, 0, 2000);
>> if (ret)
>> dev_err(pfdev->dev, "l2 power transition timeout");
>> }

Christian=

