Return-Path: <linux-kernel+bounces-146606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D28A67EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88226B219B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA6C126F03;
	Tue, 16 Apr 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="Ou/+1mni"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC586250
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262425; cv=none; b=IdAqazWVJDp1xzLZP88jUr0f25Su1Sj7YbkoscxXVMSBfC9OnNvwADriieSMoxuCZm8utQQcmgeb5M0bvyF6OlsvbvsRI7lxxRw7OqMmxbHgfvhC4hpTB2k7X4O/FuQxFjn7rinsJoM2lGYg0dGYjdUXyyqQahthlvOU4NuojQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262425; c=relaxed/simple;
	bh=PLfHS/pr861fPjFBeMBoEopPIt381ou0qj9dA0o7sxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNNI63hSCRSXKOlKglhHQY/ahgoryFI0FewZc5ytd3TiwexGqGfeklET2DOwB0pXD5i6Q4RYLClDvIhXBP8X93XcNr63wZn1xq+Fh0N3btPPPycxQAcl4i5aIPQ6b95JvotZTrN37YaBqxxDn58TIHX/25ge0NNudWC6oqsJRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=Ou/+1mni; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so2732875a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1713262422; x=1713867222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZfb01z1cElSdFgczCPztvVWoygfwcGgF7HnVAPTuEs=;
        b=Ou/+1mnibDBFuGPcQ0dWFkRgXX9GC0Nywe2x4pGJI0/QodftMdTwehlyON8vOOciQa
         BeEn4O4ss2KnJQII1/G83f3p4FPr2znkx7MfwCmsLz4tEjrxeKKYnr0HrzZAlTPync7d
         xBrRsG21s+E2Z3YyG6vO+6rqOoZSFFxiYAsy6eCkXNodDsPsvKA1V7vh07Qp/S4JK4lr
         hq/cePmHYYJqfMWHlQH18BqKdrjXsGlaq+ybfpYFBLuHHDSxHRfw30z+hfcXA7xNJIu8
         HXOkF/sBRBU6/97i24RMvIIWwUsiEbDzykoIxTo+nUV0/5dl+7EQICdKAN1paTWYXpLJ
         V4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713262422; x=1713867222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZfb01z1cElSdFgczCPztvVWoygfwcGgF7HnVAPTuEs=;
        b=RW2wlG0GWms2XfqA3FohV1XDYlFMGSaSrtggq1NoW7cxzrZ8J2eSErIKrA4Y7eQvXL
         uo6v5pQc1pJJvQTlKDANx1SnULFEMpQnQhmVR4VdlEEBsnkoz2e9mcgR/pfNZHsfDTAd
         qMtCL41WVr49n0BWhWJwvWf7cbM02BDqt8tZf6lnit6h2UKuEoEcSgV+vglOGgwh2/YR
         7y48Wv/A0AyO8cyDWu9K7UMF15AdaRuQPCqJxoDKd6RzjynRpSWZxysfFtkBMVkHt20J
         0A2TvbdRLFQHAM/KA1MSxnBTFKP8iQKRjZfClzHaNkFRhLw15PoYoh//O7K7sTyKjP4W
         0Z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMFFF6hSJynmF1csvv+YDACPSXW6XeVltWGJg+H3EURJWEVfQ0iyutNRX3nx5Eg/es1RbulyentLFX7nYlMgwK3kXzVIT7b2xlBDAk
X-Gm-Message-State: AOJu0Yw+D7h1xOK37Y0z7BiA2Kax0j7NuIwn/mKMsV5lyyijZGX6odzE
	YYNi/gbQKOptfxnoA+ozhJM47QPzt/4XV9SDyfAgQrUBRZQbaTY/xpKK6j7kBXfnKVt37DQfcc6
	aQj0bdmriRNzeh+cyFxNRcoV5tCULW+neWnyHkQ==
X-Google-Smtp-Source: AGHT+IEAmCX3pj6Nd8BE8HVb4J6COM8iyob7Dnrh8XVaPFzBOespQeJDXW+F7FT5eUBAa5B9DPn9VuXJil6nMAitpYE=
X-Received: by 2002:a17:90a:f105:b0:2a7:8674:a0c8 with SMTP id
 cc5-20020a17090af10500b002a78674a0c8mr2945956pjb.1.1713262421827; Tue, 16 Apr
 2024 03:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141953.365222063@linuxfoundation.org>
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 16 Apr 2024 19:13:30 +0900
Message-ID: <CAKL4bV6gTOUt=LomZjGceMm6SjqWeOXXeTE8EQ7H-ovQvnfzZA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Mon, Apr 15, 2024 at 11:35=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.28 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.28-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.28-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.28-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Apr 16 18:32:52 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

