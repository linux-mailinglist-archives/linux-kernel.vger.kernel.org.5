Return-Path: <linux-kernel+bounces-151879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71048AB525
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256761C20F04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFEC2A1CA;
	Fri, 19 Apr 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw57Y5jz"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA728F1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552005; cv=none; b=G8mU3eM3288uCvd+i+qmReXLDtaiBR6WJbyuLYTovM1T0nYC+rV+zOav1Hh0F8woDEo+PWb2zMC3+eFPLgJ4LC/jYL8yiPnRVLJiBlK9qVpcy9OXyNgLBlWj3OANwWx60nqmO8IBbSwIkbDyN/0my2YYqlkxkjs7DEBiTkCG3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552005; c=relaxed/simple;
	bh=84mRXH5nKKq7zATKWocjus7qLMMvkm5k5IIZ35P4EMw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QYmbMBYnVpZ83ORjd95bVeBZdaH4vag+W/0Z9oiMpDVxHJeYV1B96AfPUXyUP4Zo1DygWus6m8Gm8p0UW9SFUz/tHWbI9xlVGnI6tHalea7q0mKeqJyi7QeexT5kxtFF8sEu8PXGhC2SCT8wl+3nndegNQxh4VAeM28bIeYYKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw57Y5jz; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea26393116so1457345a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713552003; x=1714156803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84mRXH5nKKq7zATKWocjus7qLMMvkm5k5IIZ35P4EMw=;
        b=Hw57Y5jzqhGhrtcBalohevAwux7Trz431d+HWbZMz7e4YNrMoUgl1NL2kg9L8RYHI8
         PlE+N3z2EjydK5Uq/NV76kY+0e5iYLdrp+Z0tcFLaZSoVfP4AX50CZn/AtPQnLcB96a6
         qK/JUECbepzIh739W1hOO8vR1wIpb9l2MeOX4DytdbKzfD//s1R8R1NcYydCRdU8VYvL
         vAD8roZVLt+wAwzzfgBo3QkZpFeUNNiJ7uD72KzN2c4vKBIeTzuGEpMPJLpUn3QvpYla
         FOeIPwuzJmpP8ZaPvCdfMPcagyEX5paPzmhZyHUVdFy2lHnjRUVpXdr0+40QFjriAX64
         Byww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552003; x=1714156803;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=84mRXH5nKKq7zATKWocjus7qLMMvkm5k5IIZ35P4EMw=;
        b=jy4Z+yC9zOmChje3tOv3iPov1tALY/J1KnbA8z8Ok1GBI1gaA/vq0ytgcnvem7T+XZ
         VkDPdZe7vHrvjo4QJbM4K7PQQUhNn0lsAGE8Is3LQVlCWBCEgoqD6kySzDJsfIcvkG/t
         RWMNM0xWYLCn8OLkSfYwMN/3xYXeskavCdTfxkMCSzJrJoF1iy2UfZFinYYMgH+SCBEk
         dMxvCvTn/8rqFXO8Krdu3Ksuvhs5e2ziG7QAtW8aRjCvMTNS3rF7HMejp+luCQgivl68
         yWArZwVFHVXEnewQIA/hUqmw6h3pLtAw7extf3pZwf10NN1NEPFvBf+zngnVl/zn/m3M
         A+SA==
X-Forwarded-Encrypted: i=1; AJvYcCU88HyKwMUkCGwj1a95ok7jiyTqaE2foW+qUkvluFcSvlCCVP3lM4ozjt5qx/ddrBpA8J3sNGHAmWl2OCUtyFFYyi7XWY8rhDga27ST
X-Gm-Message-State: AOJu0YxpLOr11c0DrtiEnR6bcBm8Ys+ZA5o7vBxPCbpGRNxozqkAgrTP
	hpKd1n31i6VhLdwQsiSJYOVzEfKS88/jSPZ+TMpU9bjQBoFsq2nG
X-Google-Smtp-Source: AGHT+IG61CBGNpBR2TQY2OBRo2uoW+1B+2+D3/d94h4yz8WG2qoOxPMgfFalgVh5IE+Vx9XFHbSh5Q==
X-Received: by 2002:a05:6830:2084:b0:6eb:8ccf:2a8e with SMTP id y4-20020a056830208400b006eb8ccf2a8emr3111953otq.38.1713552002968;
        Fri, 19 Apr 2024 11:40:02 -0700 (PDT)
Received: from [127.0.0.1] ([106.194.121.201])
        by smtp.gmail.com with ESMTPSA id f4-20020a656284000000b005c6617b52e6sm3116408pgv.5.2024.04.19.11.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 11:40:02 -0700 (PDT)
Date: Sat, 20 Apr 2024 00:09:56 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: vincenzo.mezzela@gmail.com, gregkh@linuxfoundation.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
	rafael@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5128b428-c26e-46ea-8289-1e7580f4fbf8@gmail.com>
In-Reply-To: <20240419182642.b7li4mlnvryephhg@bogus>
References: <CAE8VWiLErhCkD9w+Rbh8mTnRQs-4iJDBrWdVXXFFFDQ3yeTaLg@mail.gmail.com> <20240419182642.b7li4mlnvryephhg@bogus>
Subject: Re: [PATCH] drivers: use __free attribute instead of of_node_put()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <5128b428-c26e-46ea-8289-1e7580f4fbf8@gmail.com>

19 Apr 2024 11:56:47 pm Sudeep Holla <sudeep.holla@arm.com>:

> On Fri, Apr 19, 2024 at 11:16:37PM +0530, Shresth Prasad wrote:
>>> Please fix the subject line to be "backlight: <driver>: ...". I came
>>> very close to deleting this patch without reading it ;-) .
>>=20
>> Really sorry about that, I'll fix it.
>>=20
>>> Do we need to get dev->of_node at all? The device, which we are
>>> borrowing, already owns a reference to the node so I don't see
>>> any point in this function taking an extra one.
>>>=20
>>> So why not simply make this:
>>>=20
>>> =C2=A0=C2=A0=C2=A0 struct device_node *np =3D dev->of_node;
>>=20
>> Looking at it again, I'm not sure why the call to of_node_put is there i=
n
>> the first place. I think removing it would be fine.
>>=20
>> I'll fix both of these issues and send a patch v2.
>=20
> I assume you are using lore "Reply using the --to, --cc, and..." option
> or something similar.
>=20
> You seem to have mixed up 2 different message ID. I was not able to make
> any sense of this email.
>=20
> You have wrongly used [1] but you really want [2]. I think both have
> very similar $subject and hence the confusion. Another reason
> why getting subject right is very important on the mailing list.
>=20
> --=20
> Regards,
> Sudeep
>=20
> [1] 20240419131956.665769-1-vincenzo.mezzela@gmail.com
> (https://lore.kernel.org/all/20240419131956.665769-1-vincenzo.mezzela@gma=
il.com/)
> [2] 20240419111613.GA12884@aspen.lan
> https://lore.kernel.org/all/20240419111613.GA12884@aspen.lan/
I'm very new to using mailing lists, sorry for any confusion. I was indeed =
using the reply option on lore. I'll be more careful next.

Is there anyway to remove the incorrect reply from this thread?

Regards,
Shresth Prasad

