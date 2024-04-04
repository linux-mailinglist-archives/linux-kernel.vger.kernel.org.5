Return-Path: <linux-kernel+bounces-131314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090BC898611
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94171B2694B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C7839E0;
	Thu,  4 Apr 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="EpgpKt68"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56882C7E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230255; cv=none; b=Hb8KAr0aQGGP+KYOL2dZHM54ueq4SB0JFwBmer7Z5HoecTKwXae80IZS9b2tCbd5DcgU7SJnFvKo1AUh/XTMDMr4Q+VFUN2HlzYzz4Xxd/oBNNBIFT+8lRzKO1YO6RzYYjitRfTb8dL78mDjhcboNVa9+KU4PF9WsJ2ZM77vM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230255; c=relaxed/simple;
	bh=hbUkkTO/U4EMpnbOF6FBCVXqVCPGG6PylWE9C7brf+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdFwUZ9mHRF2Oy0MfmQps4PGe/KHJtet257SAAHIkV58XUFCWC9CMNmC5R/bZElVFXi+bkz3M45jIKERI2q5B6z+LdFcMeFeTR6C/pJX+qlRe58KoNcw72X/UcO2kChtiTbMZua5raWDvhqAkC26rlgOkeT87VeOVlCuC3zwKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=EpgpKt68; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso433394b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712230252; x=1712835052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5mGpLNN+a7Au2G/EYQDoNReDpzvoncflKDPE5zOJmE=;
        b=EpgpKt68ukmgDyfXX6S2hYiYe9O4jbkLxLnzdLC9Y+QXbes34iCwOFWr/vs2i1zHDr
         HY4h7N9ky6CZfrBS8qPvpLTXW0jJlErbMEjm5d1s+OZxYNZx1MQyBD7xu1lZkU/+Nu86
         8YIoxKC3PKrtZyHf+JknGUZ2jKav7dwuFEVGlLhjCgXTAiw22HGEnkdbxRQXNZaxyj+1
         AQvfWh7lbRlTp/312CSAOK+U08beLDQKaJjYgdYJd5dq3ec5E+W+QnLA4KbsZh8c0kU+
         eUcD/R1SwEWXcweY1KDFkjjYJ3jXmlqou7FrlMs+GAFyHrN3/Q1Rw3e/P/ATdZpkQXCo
         T44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230252; x=1712835052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5mGpLNN+a7Au2G/EYQDoNReDpzvoncflKDPE5zOJmE=;
        b=w04idrYxKonZCNBe/2Sp3BuNGd49seH/WGmV/Yhgf4vKklo41Mg7Dxg383SHYZJpwa
         6+qHHGmsPVnKwZQ0uNWJSe/jKtOMPjLYbrYNmHiFIU8eWBrbiOF5fEiudq6Rwrz1byNc
         rnuQbFRJoe5YbvSH+8hqvDZsFOsgXeCivSlG/QTR+bfvbd18tDVOTeiKlJt2qo9iaS7Y
         tYE+G6wLQ+VuoHQ5UXAzTsQgJGWUQNpS8ae+QgHt8R3BLySxTgj69x6dr4VQI3u/Kbyv
         OJwQ5ffniLMeV2/UNuIL8lJohTAZGXTtUNhWiTmiNc3PHu9EaCDw9vH3j1gjkMyZKq8Q
         kQJA==
X-Forwarded-Encrypted: i=1; AJvYcCXaH9vDuuyYCDosQgeYcjGh5V4uLpxbE8DBqbSrzrFW55KOqmlpvcA/DCTTh3jojLNPpCxW+rT6p0AiMy82AERXqrysTQTpycZ12cVN
X-Gm-Message-State: AOJu0Yx1RSmInJKnK6yLUudcRdv/gBNGk3qrS+qr+5Ms/RMc0pRUgO5Z
	HmNgQkM1339wT1Ki7OPLsF4NpCLBJbNtaVhDb9kGpqoyt6otdZzEfjgolv5RtLpugAmTGeeEKtM
	Up1pM5bXj8go3nUqlV9UvHWvw3q+4LesezKGwcKPzlKN7ApuItRY=
X-Google-Smtp-Source: AGHT+IFN6dZWmAgrAkglzr4sW4NjlCbAfdN8/hIeao7f5iZTSqTUjUYfMiqUfdOryXKK78X9Ck6xcqvzBuTpgIOCMWg=
X-Received: by 2002:a05:6a20:dca0:b0:1a3:aaea:a45b with SMTP id
 ky32-20020a056a20dca000b001a3aaeaa45bmr2091520pzb.39.1712230252503; Thu, 04
 Apr 2024 04:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403175126.839589571@linuxfoundation.org>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 4 Apr 2024 20:30:41 +0900
Message-ID: <CAKL4bV4EuV2AHv8g6HoRVmQXtS_ATE6oHE40gvUQd43bUqTGjw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
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

On Thu, Apr 4, 2024 at 2:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.25-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.25-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.25-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Apr  4 18:22:42 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

