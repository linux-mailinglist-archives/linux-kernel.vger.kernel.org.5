Return-Path: <linux-kernel+bounces-85454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4586B63A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D262E1F285D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03D15CD5D;
	Wed, 28 Feb 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOwcFido"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD13FBB0;
	Wed, 28 Feb 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142045; cv=none; b=K971NcC23SQO0OzwUX9BiIQwB7i0bsmTHA0jt59XJbqjsZEiuc+rWNtYM/2OJVEJYmUBbdnZWCvIsvRJqgzGh7FmHkl52RuzC+OL/CuXGmP4H0t51dVYTd4NSBi3Gdecnj1rN/y6ZTAEhArwbUi0OnfqOgPWRYx9BmV4/wQSn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142045; c=relaxed/simple;
	bh=48CGxSL0nimyBR7hV1JMGOPtSOuj21Q9ZvH3thQgDzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/aBY6Gvcr0yf9QKnQdO60FdJhnY0DrXN74ybMY9gMxF6eINL/fTRz12ucNRv4VMO129aAwdpUgwhIAqaRvZBv+QXl5LAyZG1KUVr060lS5+juu4A+RY8ft3gUGD7Sd+GE2o2Wo4kXUr7k+uOkPMdz38HZioK50o3eiIS3cxJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOwcFido; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-471e18cd6e3so1115547137.3;
        Wed, 28 Feb 2024 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142043; x=1709746843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iUJmtckHKi/1Ij75fGxk5wcnwB8ZABZ/vlRQjgqtgfQ=;
        b=FOwcFidooo7NUaAp/+FDFPxPCJMOQa6cE8sNtyF2mUuy8VqkO167IbgNN2bG5KQKk/
         DOZEMl5bTWtpiDgSnm8iHRojMhJdDouVQWdDce9bqtkTLm6oh+5L4VKVdMUKiuTfrCr6
         8nmLnkv5E2lG3x/KywTi9CtzzL4rVztF2veOIKgFLZc2y1i3QrthXx04wCwvCqOs6Dvs
         LaKIzX0fngqcnRQoMY9Dz5dRbbtxlOVJIqyZMiih7SGOYyI6ncIrVio5Q7IJMu0tT1aE
         AA99tP9zUz9KLzXlL55XlgR1KV9fbBSGKgY3U72TQJAa484DX98diZJJUvfNREA0U5mM
         710g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142043; x=1709746843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUJmtckHKi/1Ij75fGxk5wcnwB8ZABZ/vlRQjgqtgfQ=;
        b=BsnQFIaRPATiEd1U2z/uajk1NhC7jiufcui8CzsMo4hbD24tLAQG9AQiqGuzghS1pF
         qRiUqdyRgYOLJQSgi0KVc8zdPWByJn9FVac1xNThABg4XWamAQbG/HRC7EgM6A3F0/cU
         egzNvV3Ib+swsHQq59VaiOFqNedCy94/5jIC4ACiEVMmHgrsXPdIoFb4sQMB7CSSgJ5v
         X+95j8uLlWMkUSJa7aBvjCD44KUpQSVwfJ33Dno9YT5+bl96Jcn7GZtMLNYAxaRILSb6
         cmeuWqJi9vzBON6/P2v3RDXg7KKPSAXAsSbBaMklznpRNjOyKl+wsB8cc1rvuPj9JRQw
         qBJg==
X-Forwarded-Encrypted: i=1; AJvYcCUDJqQZUZBdFpgfiHc+heY2ASK555H65eLyuxNENibQbpUebJosURC3n2BRQg9UYR1naERefwlMcSru6GFfwVa2xMwZSc686UDnI9oO
X-Gm-Message-State: AOJu0Yx1Wh055uG0q8DpC0X/A4QBo0Gul+p2NU4JgfUJpMyf612+r71G
	07W7ORk6t+aZQHFwvTk0+H3md+rD4otg6Kn0kW/+d3Hjey8e//6u7BxpZ/Sa635bLnqa9k78jkF
	2TdLusSkkAUdeQSRHHMpccHLX1oc=
X-Google-Smtp-Source: AGHT+IFwbYwjbm+Zvkg0glMifQIhcw6NDLseE5sVvTj2Yw269u2BoSy382YAUgvL+7/vpr5MJiVjRPe3m5FpskF/+mY=
X-Received: by 2002:a67:f490:0:b0:471:e1ac:57a8 with SMTP id
 o16-20020a67f490000000b00471e1ac57a8mr259470vsn.12.1709142042595; Wed, 28 Feb
 2024 09:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131615.098467438@linuxfoundation.org>
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 28 Feb 2024 09:40:24 -0800
Message-ID: <CAOMdWSKV9H_F6gD0jkNzM0P4XkBax3ZONk9K1xPx+vWQdm7-vA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

