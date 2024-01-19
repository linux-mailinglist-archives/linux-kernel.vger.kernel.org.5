Return-Path: <linux-kernel+bounces-31222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F27832AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8177B28857F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A7952F8C;
	Fri, 19 Jan 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="gMbEWgmj"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485B52F70;
	Fri, 19 Jan 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672140; cv=none; b=hB9swjaAVMe4qtx7q7paAdEZdlieHf8dcN7CVvo8wOgX6skvIC/ONClYDFrZRD6uZ7qUtzdZ09489hgIxfJj3LRtFaV8wUM2QWQ4wlY81iiEXvLGCNrYzhn7bj4vNqTonBHXzjF+tIffsGg+vbC/aauAXUSUUdiR7N89a8hLtE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672140; c=relaxed/simple;
	bh=B6tArqyOlxI1H47kNCNJM0kXaH+yQwNZI7lr3yQI7A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+m8a3IkMs2E98ANgayHDTtbPDA9zzdj1ocD8s8L+qyWo7IIiGgTmGtc3i1zLqdX6KuvqdZ8fF/wZGB6rTQNrIerXxXIcj/LmgYuYx1m7R6UPbfFv+6zOCXpGcWlEH+KkOPiDEY+dJxn/by4At++9FFF3jUzm2PI76QZYzNWlzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=gMbEWgmj reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d4414ec9c7so5105425ad.0;
        Fri, 19 Jan 2024 05:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705672137; x=1706276937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=44+0PG1XUq1Z6WTgtSqi90k4/IQaacVFaI25/F2OJSk=;
        b=Pe8T0wmlnAkY6jdwL7fGgchlbpDdd+c0hYG8XWUSOtsxMtvu7iuUVwqJmCaap5fezz
         P6PVDa8Rut/qyzuZajQM3GiZ8OVwbYYw5skR/QgEN3Nh+H/ZwuExFWDWCow+dLh4/eU4
         jo+0jv1tZNSv3hoHURxMP0QpLHXoUj2M8XoXGg6v8Plx/RObaP+MZa3JXIsL2LUAmB+9
         Fl5VqCCXFLVKm3UOkZtnQW8RrdXbrv4LQ7Nw4t6LBgUV6voJagm/97Q2xFL1OHFJamb5
         Ntz1NZRdJII3Yd96jT3FEgsCXuT83ABaetNSRyhYk1hufjArYFuOw9MDjvsH0Ouy2DI6
         Ev2A==
X-Gm-Message-State: AOJu0Yz/ruC8beNBbjZ/WUR23ctti76zE0Blfff/YrUl5Iup8BEQntQU
	MPD2yUi94X9fqhlvKvCWJZYDsc/PdsurIyNSMuiM/EOMSECFVTAC
X-Google-Smtp-Source: AGHT+IEZnmYFzGUAs/4hjDfJ5v4w3mjQG4gnmyhxLexgFOz3I6DEGAPVP6AtfgsgUeL/uz2KmHPZdw==
X-Received: by 2002:a17:902:d4cc:b0:1d5:e722:1089 with SMTP id o12-20020a170902d4cc00b001d5e7221089mr2886716plg.122.1705672137295;
        Fri, 19 Jan 2024 05:48:57 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm3084090plb.14.2024.01.19.05.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 05:48:56 -0800 (PST)
Date: Fri, 19 Jan 2024 10:49:03 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1705672134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44+0PG1XUq1Z6WTgtSqi90k4/IQaacVFaI25/F2OJSk=;
	b=gMbEWgmjHfcoD6mgwuQzJFkOJmLVtAza2zjo82TzrA/QEUpf1AJh3GwQKxWnsnSgb0Mq5A
	71tTR3GLtOMJcPTEZf/eItM0mSmHwamS/r5JCXqiobOl7x8sSG4boUxjko8Eq4lZl+LeW/
	xHrzD9Z62Sd0TbAzhwYCSiUEN1eSlkJsdRJqarwhZEFaeGKa5LVo9fNNZ0tvdLUu3jSMiq
	iYJTyWhbldg+iI/2Zsd9FLhATouLH2JkBB7wNCpgKrPY+riCiTYoTUrHz0jj/q3ukBVRVN
	3l1TJPl0RviKGYzzcksIlippWavqWozz3pVt0vO8EXjVE7C8ctZJHW5wu4ZVaQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Message-ID: <obbv2pprfnw2gvgi3lo6stvlmrumwgak5vgmmp7udqvqmgqf3z@ierap4ymxfch>
References: <20240118104301.249503558@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>

On 18 Jan 11:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No noticeable regressions on my system (x86_64).

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!

