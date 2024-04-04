Return-Path: <linux-kernel+bounces-131103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D4C898320
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DCA28C22B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4B6CDCA;
	Thu,  4 Apr 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL7K8O2m"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886D6BB29;
	Thu,  4 Apr 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219109; cv=none; b=GTB3ww58ZShNVbL9aWIKeWMVjjcvip6grG3bI153C1w9+UaRExemnBpit6qRur9Rg/lhEYJ6j7W2O65l7oz/WP1LJimVoIL/D16EZjp1+AdOz5R3Uv28QL6wBly+nxFU7LO3tbYvfXhWFT6h3lJPw/o5YqnawR9VRrTuyhMCpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219109; c=relaxed/simple;
	bh=LrK3xAPTQqfV+xsDOVCRWUgxE3ONbMiMSCOYKjP9yEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxoOzPbkpIFFzGG0GdS0nXJEO+hoc2xfwDNwMpmH29ARTuJJCBp8blvKDO0IjflyYZKm80OKYcZArQyQXu/pwQ1r671avFUFg/1DU9pTohi1fLwbGNN2/N9xtWsOqQb82eW8N1CgJhqAPI8aNKUJgR7ViYji1FTOwNMRqfz55tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL7K8O2m; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so171360b3a.0;
        Thu, 04 Apr 2024 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712219107; x=1712823907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1Cs/1U20b71/iJrSnxluFtesA0Ybe4cNXvTMs/mjag=;
        b=kL7K8O2mNdQRBjXZfLioUQLQG6zNnEJXOLjFrw2geE5P+rOZR+kAwxRQt/YxWNRFPR
         EcDkuXcBv7nCatu7oV6wr6BqWluLL/7v6cZV5YZ/5GSou9KEU8jbw9LHIv7TIAihtHpf
         ld4uCo7EqRE664zLjrjVAFSyZ3lvzUhlw3pDsJKd56Qyma8yEtuaoG+j7cnp1sYertDB
         iT8qxebs/A29MiC2q09BiEQrLZ5Hdw/NnkqSdADLqY+MXjiHj15V9AlZYDgdYKIuMFZm
         cjdelg2EmcUTbAN7ep5JGsGIsc6bGbOoJtFqCpsMpFeiOlohF/bRzFG6/fIODhG/0WWG
         q6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712219107; x=1712823907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1Cs/1U20b71/iJrSnxluFtesA0Ybe4cNXvTMs/mjag=;
        b=dvPnJI+K+w6aYmwEXvKwGjj6AXhB6nEraOvrb3Momlgg8/CElWKzmIELIfwgaqut7A
         fDi2q8OZDSJF4JvpuHUloD340rXDiYdTVXu/diVsvc0vNE5PiU8vmkVbX3bZv5EtVFEO
         cdVxO34Txu1jaWwCE03vnie00alHhvCQjnI2hHsoiErzrd0a/JUIZBaG7sn90Jqz66Xk
         n5Z4BJWj1KWViFzaNb4g03EDIDmW/g+0eGJ8dAYtkgAROBDnLRW/6xUVbCL1DpSiGbct
         HIVIt9fW6eB4LRT0S06MezYGxGnGyOEL7pgmm7uLAdbFeuuNN1vokly5d5FWWspS3mYw
         BbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgGDTXikYXt7RfIYbW9X0cZ3+7zZHoHusdrqeLHZHO2nI/THeXBpcgC8PQOtPSKlsMKdTHnvXNrJ5C5BMpLITA9K4E9E/0iZj50Tgg2A9M1cboVkvtIS3SQBOBSBwSTcswi+vo
X-Gm-Message-State: AOJu0YxFMlYBLwT8udxTfDTcpo8MaG30sh+ApVeEbNvzDua4c6ozYiqv
	UdN4/h1WnBLGPEkCqyroJ+VMKRJgmpLdZqtg9xNVrMscwAp4p7zuDLKmxRVbRF06Ol9zlskyzWd
	cQdhktG+YL9moxGxQyQWeAwQU0sE=
X-Google-Smtp-Source: AGHT+IHpzrZ7vtYaun8Dk1P4IDiwX4yPdWi41t0LdBAiMRnEnthPpThqCcJAKOZj8x4EU8NhzLLtkRMs+GWuSkbdMmw=
X-Received: by 2002:a05:6a20:9c97:b0:1a7:c2c:c882 with SMTP id
 mj23-20020a056a209c9700b001a70c2cc882mr1913334pzb.39.1712219107341; Thu, 04
 Apr 2024 01:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403175125.754099419@linuxfoundation.org> <63e194fc-07e4-bced-f0ee-7617e0232e54@w6rz.net>
In-Reply-To: <63e194fc-07e4-bced-f0ee-7617e0232e54@w6rz.net>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 4 Apr 2024 10:24:54 +0200
Message-ID: <CADo9pHg7w2Ha=cXcGf7RUn+Qwtv+Q-asUkcYuEjkOMj9ES_HFA@mail.gmail.com>
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
To: Ron Economos <re@w6rz.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

Den tors 4 apr. 2024 kl 10:03 skrev Ron Economos <re@w6rz.net>:
>
> On 4/3/24 10:55 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.8.4 release.
> > There are 11 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.4-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Built and booted successfully on RISC-V RV64 (HiFive Unmatched).
>
> Tested-by: Ron Economos <re@w6rz.net>
>
>


Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
5600 6-Core Processor

Tested-by: Luna Jernberg <droidbittin@gmail.com>

