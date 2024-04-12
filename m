Return-Path: <linux-kernel+bounces-142613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050C8A2DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44A0B2170D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0756754;
	Fri, 12 Apr 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="vK+omR2p"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B854FB7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922660; cv=none; b=sGVWe5rVwPlUACGhNhYSK1JjySB8CBrblz7K0PXPy4yLkp32G/8pYN+NVbKIIHdz2nzz6b5Pdy1hjc7iApqeZuiTY70u0GAm1a5phwLMWVNGQy8HsXUg+dM2q/OKtCJlIJHGUq1EjyCpDPvoctPXMdppMWP4U3gobR9YPxTwXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922660; c=relaxed/simple;
	bh=6z1NM+xFuUNh+JCkp6BiT4e7bjolhUgniKMAOQP3vq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEYgt0k842NyozJSRv2538f0f/QJE9rN0zmw+cOq+AhvX+szMnb7RzASmJNosCAunFN6109AXFEGsTPmSHNmDAtIXNZpSNm1PLvw4bNbcnvXVmNMl2D8w7l/aTlStxK+rnbJS2pf0n0MUXDysFtDdgUMIKm+YD35fBw+RrA8A9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=vK+omR2p; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso691446b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712922657; x=1713527457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fISH+O8RMH1Vim1fhD1kwnl/iMlNkK4IQpBqECYAtN4=;
        b=vK+omR2pJqPGrL3jxemQteuSDuBmIab2U7grJcXpkf3vntUsQT3rIskgr7gh0dWNZu
         LJlXUlmmrPxMpBF7Tuo8Q8GNueoa4ufrp/wHr3KPCp2zX3pQBMQX3Sg8pl8X8K/91dqy
         4pCGGYclmAl5CRE3DqiG9sNUrVpQAF3DkRvzfTL3Mt7VdtUsSxt5BOoaCXObjaBptfZZ
         9ZR74sfun+1NNfHRRT0UcL7S8kNjZLPCBhE73KQEY+0jaM6wVUKjdf+SNaiWDUH6itZo
         zdqO5uzKdbipj/6hWt5OWNqYlpRs9pXJ4zb3oT172S7VPbAD6fokdg9RK1GvA+kTapZ/
         Rp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712922657; x=1713527457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fISH+O8RMH1Vim1fhD1kwnl/iMlNkK4IQpBqECYAtN4=;
        b=PtxV104iczQmHUiHi+LzwAMVTdyIPdWdang4SyvR54MU33nPa7u0enfh9LppdhRLHk
         N90ftyr/mCISAJzAet01RzaMvhRp9jXPho9EndBZCi0TmWh706dSZnPgHWbHfAuXtqz3
         WD+kT99zmLjKhYUcVHmnOkc9wawlPq9FofxlAXsgnqZ6NM57AyE/PtabwoL2OYnYHugq
         9WhZfRqE0fVeirvpNDdXrjCdZoMlWGWD31akLuQIth/zhl8p1+ZJtGV9lSYieCNxI0iT
         W0R2Wyhldq0tobW73jbojg7LD5FKKNA6N4dS8I4YUrGsnQqtMH13Ov/DKmEVatyqmaI4
         wlYg==
X-Forwarded-Encrypted: i=1; AJvYcCX+/blaCUtHddpO6P+EtZzXRrANtooSxNMv926svJMGj8ViORHQQfY+Wbi7NOZW7y1TAYLzirD5GP/6vWeR/EdNGk0dJAsGVnnoQgEF
X-Gm-Message-State: AOJu0Yykn9WTBJ12T6yqZUyyMo9sYyyH0CiZuCGTo9gBInL/jHIPIW74
	B5t30iOoKHa+8G1XnlXXsODgEYy1BJd40tcLN6TKmOo3oh1Zrch96NJ+Ty0m4pCvvjPMywIn84M
	m5BvjNWRo2vvUHDXkJcdMJ96Ipl67IS04HDutAw==
X-Google-Smtp-Source: AGHT+IHaFtm91nTnlsAoPlDzCvBuH9jkOA41r/Q2yzSRO8GdMNfDBlujSAYpXUO3pUimW9Z99G8gVa1f7Mlje8Hn9xE=
X-Received: by 2002:a05:6a20:9791:b0:1a7:7358:f108 with SMTP id
 hx17-20020a056a20979100b001a77358f108mr2373491pzc.24.1712922657034; Fri, 12
 Apr 2024 04:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095416.853744210@linuxfoundation.org>
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 12 Apr 2024 20:50:46 +0900
Message-ID: <CAKL4bV6up8KqinyhFqBPPvc+fyabtBkwy-7tVyNVzABx9QY3fg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
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

On Thu, Apr 11, 2024 at 7:25=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.27-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.27-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.27-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Fri Apr 12 19:42:31 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

