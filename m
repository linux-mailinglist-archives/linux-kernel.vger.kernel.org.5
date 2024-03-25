Return-Path: <linux-kernel+bounces-116884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002988A650
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C444B61AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AB14D2B8;
	Mon, 25 Mar 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="cuc1QpGR"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8615444D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363536; cv=none; b=RupYY/g5hZ7/HmnYZaU1TzjN6WjUuxzt8/UAMDoS5cM/1iju0sbDrVGl2pZQ8xVSSJVlW0ndVH9gjDBZELhf6uypPIe6n4qgb+uuYtztYljUQnKup7zwjOahqhV7pdtef6m/t4C+aS5h6MxGyYaa5vf+Kl0DH5dUlRJSqM1Lcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363536; c=relaxed/simple;
	bh=xFssiSj+B3KNV/TbO9JFeIfvLkCfQkNPPPwZSEnIQqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF70Vk7KysbFj69bLuJq1NqtucksXi8yoimFrWnXMNewkeX8rFLcHb5LkpuxPIUxqtW2eSGngb5vXuEafyyFsdxudcOE0UlJcw91chmU65jQJ679gZ/9Kig8OjbAytgIslki6PWqeRWQBHg9G8CJnTLgYCdpUZXEgbcXMx2pt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=cuc1QpGR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1662270a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1711363534; x=1711968334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5cMpRTj9+xACED6ZIv7TiLSV250W68WovhxSeO3KTs=;
        b=cuc1QpGRC/xDtWsJ65VoyBozBo9WkqwnUt5HqH7IFGgOcZ5NhBPR9Heopyewf8TCat
         oRUzoDTt09FQ22LKMzYwFjPLCryLLR6+0KrgkVipgSPAeDPNevdna2iZ3UC8tag+vqqt
         xTRp2Nz1NT4E10kyd//PjTr1B7r9HKROr9Ex7p3zWQba7yh/wZIbLmDEYIrBwBocDOyG
         E+3T+U0T/OnWAW+Oex1Vofg06I+K1jHcwnr3hzehYRAZ0vo58+uigfnURsQYNP9V4viU
         RIIZ2wg1TxfAqwn7hFlF69AOBWKvh8Ed3r+9fqTp77kxxgOPyEZOz2R2m/lpZMcwa308
         d09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363534; x=1711968334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5cMpRTj9+xACED6ZIv7TiLSV250W68WovhxSeO3KTs=;
        b=gkbLNNsWpvEp5KnmWO2unuAVV3gCbFHnq2y6ydksqiYRKfAuxyMX56Y5rdDU1w3aM7
         hBefjDXXf/8X59gvOyiojbnMEHkDoAk+gXjdXnYeXKtMwjRbOGfi0rDmTzFFT5XkPJYa
         G8rPpipfi+yXjX1rvr0Gyft/BzI35KNM/N7YlSo42/96IWLlbQsfomZL/zvhP73ZEdnt
         WHlh5/ND70GJxGacpPYgf3oXiN8oppgHsbtqWmXCVkd++8D5GR+An/qIMsFZt0GNzcqq
         69skZo9Pj9HyMu4MRnroBrDjefgVTlBOt1uo0ZAHUbJAcdso35tX5zj8FrOrp+ir7ds6
         GI0Q==
X-Gm-Message-State: AOJu0YwXIFzBzwVK1N+GHx6z7EvLG0Mb0B9rWZkRd4frL7j1YZHkE1i1
	a9Ov9+rYj2bN/QWhFf+j5DEZgcN1SIsQEMkdO87kI8vFRKUSKEYBU96/lpJuF53XlTIxPfOxfYE
	F5JFRhR45pjVRFLyG6HaEXROGANl144PXOnltfg==
X-Google-Smtp-Source: AGHT+IGCBrbXDBwydAl/u/1jRtQ2p43hCT7EuFJ5ky+hUizJPwTTHeqXK1hV1/7I97X3IB5keFT0dPkbz8CL9C+BouU=
X-Received: by 2002:a17:90a:e608:b0:29b:3106:7f24 with SMTP id
 j8-20020a17090ae60800b0029b31067f24mr4321213pjy.37.1711363534117; Mon, 25 Mar
 2024 03:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324230116.1348576-1-sashal@kernel.org>
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 25 Mar 2024 19:45:23 +0900
Message-ID: <CAKL4bV47RJMAxTMJPkfHNQm+ikWCMEYg_NBfB+e0_6_7=+3fVw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/638] 6.6.23-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

On Mon, Mar 25, 2024 at 2:34=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:01:10 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.6.y&id2=3Dv6.6.22
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

6.6.23-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.23-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Mon Mar 25 19:23:42 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

