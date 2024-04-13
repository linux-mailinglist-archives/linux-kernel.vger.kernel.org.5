Return-Path: <linux-kernel+bounces-143745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC68A3CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F135B21403
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C49446DB;
	Sat, 13 Apr 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI8PIQlI"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98C4087B;
	Sat, 13 Apr 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017522; cv=none; b=iveIN1VW2W4NLQjya0YldX8iCv+U2Bej1JiI6uH30ssVdBi6t/Gy9Denh3ytHujeJgzkCZLVNGPkubmmRAmw/o8RnDpH+6ABweQJJaCeriJmfkGz+0tMX01hm5WO+vZfY3rW+jk0ONTjjXxZi0thc9Ij1GHoaYQkihF96XjdaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017522; c=relaxed/simple;
	bh=qYYzrjG2ox687/KVEYrd3L48WfictZFnMFD9YgtiSaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU1FQU/hGJz8PRALh1eSZPYqjX6VmEB0IHVkHCrtg5v/Vxy9/Vo65ZLpEaBp4s1giCDOG1NqaMJ80MhYkgneehOUCV7fX3Vqw03U93sGzEgsgAufGIVsCbQlwBEqGh18c+63vpCGPBFRwZIlDsva3/dtEEcxxUYhsT4UCtu8fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI8PIQlI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2dd2221d3so1314097a91.0;
        Sat, 13 Apr 2024 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713017520; x=1713622320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j034miScG2h3n489b6gEKjqfM17fESZEXBWf4eIV8kQ=;
        b=OI8PIQlItkWCCUBkvf8e+mLxM+5sFlagvLK6mIpAk0z8EzrzLk9IdXkmyqXcBAf/m7
         tbS0fu0n0Krh8UP1amw6Xdq/i4Jznp0kYN6qGYpObUsfGS9oSTSgdazX6mMH3osIkNqY
         6esDcPdWjEOWIASDNviypzgXV+qiQwsDQ+s7WrhAwquNQaMPKrJy0deDZEacISSpSdvu
         Br9gyV4S8nI4jUf8aQ7QCwxNWVNu1BB8u72vax6txuOrCIYIxEzrGkEDBvElHeME9FvW
         wzCezgUAP0B1N/vQ4XIcHdOwwDhzXGxZJMNfG9OZPrtSe++CBUQ5sddM77xMpoILA7NL
         YMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713017520; x=1713622320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j034miScG2h3n489b6gEKjqfM17fESZEXBWf4eIV8kQ=;
        b=VPgqqXcMb4HnJy9Z1aCHrHCQS7SrWaBmauaUv2A7o03NBlI1Zqk/vS5HH49fyKdxvw
         aB3iTm9Lr0P8+B+CgsCR3rW10O5BGxRkKbltEhsHINnp7ydGHxUIAKvVX1ZUTp1mG9PL
         Av17BEghBbL6+2CJnZeltXlp7f+K4VGcqplNmepAJ/q3YmRArNo5teJpTtsBbeZrLZCd
         4ovObPnxOemMfrt/uAAjgxTsO4OuZQ1T6HFQUwz/Q+u2b6M9MoU4c/TlZ3DC+xDU/T/M
         X+rLoyAk/SbBmPpsdQs0jjUBReMZZHx1gE0wkEPVvPeBoCJnjinAeoBtMji7Ywlsa75H
         TmIA==
X-Forwarded-Encrypted: i=1; AJvYcCWIjRR0xMoTbTq2IKC+59umKBjjEFkqGFu5gp2lk5OTGjEFSyTAx70phu9IicJg1aZh5eYKr9Ug1pVjoz72Gd4CJKkyL1j7kcl+j3mE
X-Gm-Message-State: AOJu0Yytzndbl4ZoWut8q1WtyUOS8ZQwVG6NG7sO9zs0IhssGTzfmhZY
	PUcdUKgCzBg+jCG7Y0SWfKKJca97/w2WE6RguUF2+OiyZeHJ1F38
X-Google-Smtp-Source: AGHT+IFsqWM6Mb9S6gqS3qSFxMmALzWfWm5RfnIsL4vwTlmyphCOXxLPFC31W0J3A64pZSOvCoyKkA==
X-Received: by 2002:a17:90a:fb82:b0:2a5:3399:b703 with SMTP id cp2-20020a17090afb8200b002a53399b703mr4798789pjb.11.1713017519795;
        Sat, 13 Apr 2024 07:11:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mh14-20020a17090b4ace00b002a26245adffsm4231036pjb.41.2024.04.13.07.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 07:11:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 13 Apr 2024 07:11:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org, aleksandermj@google.com,
	ejcaruso@google.com, oneukum@suse.com
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
Message-ID: <9ac4f94c-414e-4c12-bfe0-36aff3e318bc@roeck-us.net>
References: <20240411095435.633465671@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>

Hi,

On Thu, Apr 11, 2024 at 11:52:43AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.215 release.
> There are 294 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.215-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
[ ... ]
> 
> Oliver Neukum <oneukum@suse.com>
>     usb: cdc-wdm: close race between read and workqueue
> 

Just in case it has not been reported yet:

This patch is causing connection failures (timeouts) on all
Chromebooks using the cdc-wdm driver for cellular modems, with
all kernel branches where this patch has been applied.
Reverting it fixes the problem.

I am copying some of the Google employees involved in identifying
the regression in case additional feedback is needed.

Guenter

