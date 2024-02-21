Return-Path: <linux-kernel+bounces-74895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F185DFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322081F23DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436297F7F2;
	Wed, 21 Feb 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="acd0dMN6"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5E67E8B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525889; cv=none; b=digKKxro3uHx+k40K91vGgJQlxUEnXFTZX2//GSYmxgIayd7KWJEeMlUvGntv6sNhXM0HYKUlGbQKB5I9lcH/S3fnKFI8P73Eve5IlV+D8sLM6CnyhdrdOoIMa/bOxMhITCj6gOiMaVVUgrUo/HLOjLgtPJ4lH5V3K7FVLG/DhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525889; c=relaxed/simple;
	bh=ai0Y3ghr43o6eth14mZfN6FyOqZZgNeqaxFSD2r3C1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6Kv4yqUYab4vpRoDXxLK+i8HHvkIYMTxBStV4uKZRIs4P15U7a0kcoY9hvyhdRi/gnykd41rMw5lXygwANos9JB6hmQ9i30s8b/24bs9NkpKP+Z19Z7pvBva5iG4/ZNAus4ZVXiFddLRtd5+COblr3gvpl2p93/luSeMp5A9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=acd0dMN6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso10266315e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1708525885; x=1709130685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG0WBB4ciOPrXJmNteBsGP2QAaf4Oc9Vg6ruFampq5U=;
        b=acd0dMN6Rq9+83tfG3q4us8gqzw0xaywraGDhNlsHogblG2RxBXDqR7qm3ALFDDTZ8
         od/SWMd+AjtdZywAtVBE8T4gPbSSS0ODwT4Q5RlGz/pv+PASkC+2Ld1xx1b8iKVzqjZT
         6FLUZDmWTVfOXkGmmLBGsf/cW1YhUen2pRa38ixEgt8r3Jw70sDh+Hr1C5F2o0MvE3gr
         WG9CnOVsjCxhi0/6euFxCbi2fBCC8i9kZXTrFgq5L0fXws+zDR3SvM9ajEDHkGoNxIbo
         GGgHKUsIj7W9Pcfn3z+CbKslGqPRxtQMoMmWVzCibecJKAx8i6COQBmM3MfMyPgllMsl
         Gr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525885; x=1709130685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG0WBB4ciOPrXJmNteBsGP2QAaf4Oc9Vg6ruFampq5U=;
        b=AJ7xQJRLYmFGnEWI+p875PYFbFG6DVXfOzF+1g4ByVfKBRNY61RvglaNlTLaLpBx1g
         d1AUT1wOt+PDYXA5CUjPJ80d/+dCMzwtl08nLDMqkWqxvLNFJBzak6XNg5xwHviPikjc
         aEcUpsn1arQl0RvAe/xI0KB6iYtwz+kHbFHE0ImDhI160dX4qo3+2jznMzg1H3lE0p2T
         DGdI9/RK1eyOCKaLRx8NWypROC85ES3lQO16+9L4NFunNS8eKbjYgFo1U+yx+E3wpveo
         rN6x+NJHXpNeIcw7q8RTY7w8OVp1Gz/OuI53qMfqX2H+4EEDvFkI8ZNiAwdD4m2dqGF+
         9SdA==
X-Forwarded-Encrypted: i=1; AJvYcCVawVhQIiUl2X3jOCDtAB3tuZutwifSVH7srBP4uuDkLFOvPeFwDFKx0cB2Hus9Nxr0sIzUBZ9sNng8C0YESzAEfmMjSKg+vMlYAr9+
X-Gm-Message-State: AOJu0YzYNfcwDeCv9KOjgDRGmU5yOG2sHiwYmXMD7jEIRgSq84g8dEzv
	8Ozj9tZThjYo8GjOLzunymNU9G7HNXilZx/9Sldv2ZyUQcMcmTaO+nCUl53BbwQPMgVLpid+xhf
	Teiy7wjNu5QR38FY/M/paA7RR3F01PflA+uPGew==
X-Google-Smtp-Source: AGHT+IFgyTlvcYZuUnsc3Px/pDWdM8WzXwTcIeRlitvcBj8aH7M0N907h7RZJroGn8CWGEbJElLaPVXUsGJ8sQLr8yk=
X-Received: by 2002:ac2:456b:0:b0:512:a9aa:ab48 with SMTP id
 k11-20020ac2456b000000b00512a9aaab48mr5990070lfm.7.1708525884593; Wed, 21 Feb
 2024 06:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125953.770767246@linuxfoundation.org>
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 21 Feb 2024 23:31:13 +0900
Message-ID: <CAKL4bV5Txf=FBfcKbCS5NrBtu9uN5ZLtLBfeMr2R8Uc1wRLEpg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Feb 21, 2024 at 10:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.18-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.18-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.18-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Feb 21 23:14:15 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

