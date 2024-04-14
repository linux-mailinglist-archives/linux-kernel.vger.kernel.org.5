Return-Path: <linux-kernel+bounces-144407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153428A458C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A961C20DB2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687F137741;
	Sun, 14 Apr 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5KDiTXm"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2968136E31;
	Sun, 14 Apr 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713129488; cv=none; b=ZOCzmZpwUTCFJz6+2SBC5L6x5bRQT6/971gIM0aUdk46nJ7pTBwlMJZHKMb/WWRR85ycwem03xDeARBkkBMuzEhRPlQnHk5/tp4PZ8li33dDUq5tNwkYvUbH6Bypin+BKiitJJLoJOJpq4FSg293s8BOvMZzyRkpzyKHaF16asE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713129488; c=relaxed/simple;
	bh=G4TuJqmhrfi+7PAxNMiM5MQgUdsKKap5UGFURvOLTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkPMHcUhQG/LukiJUz370eBS7P1DTgeuQ0gQkZNIwNzZhRaJzkT06zUuhvzeo+hN7pi4+lfZCaMZYCvHkNCi17GrxIUpe51JTzfoTp7MicB7WPNBmcutlpZbh3MYJ01sDuGM7muuamVEC7AnW7oJoVsdVg7pcZoc+2We1KZam00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5KDiTXm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1895890b3a.0;
        Sun, 14 Apr 2024 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713129486; x=1713734286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZHsaHa41oigrMjD4LKjbkplqhy4ZTYVhx/T8eHvHZw=;
        b=Z5KDiTXmd+t0E6OTUeMfl3FMXo/O1InJTbkjwsTicb+zCVym0cT/+07po5b5q6q1UA
         VBKiXiHXYc9q7SNr2FJ4i83LKArxUHenC1qT3f5m0vwRYcES1oo05HmMRZX2TTyNDaaw
         EeRNRsdZN2Gw63k6+/HkWOSKrrRWmI991VeHqKgxKTarRzWRCyqmnzckVek1V9lFNZOZ
         SSoWIS7k0byYdl/QIEm8ox1FrCdsS1OEgT5HZdT2uFFZbud+bZJOHB4SlxuYlpMzItoE
         TX7aOwJapatnBjTHjGx5c/9fqVkK5uviBhEL/HYXJNjZ7qITxx9KO73irVvP1dHLVGPF
         eVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713129486; x=1713734286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZHsaHa41oigrMjD4LKjbkplqhy4ZTYVhx/T8eHvHZw=;
        b=MY58LwxhyvgNk9UODiGow2awoFHeaGQmNf97qGrdu0Kegrl0J1a/u0w4jkgRU4m/m4
         9B/zA76y/JGdFrSG1jv+01ScSBnzsVXosxZ3/VH2Sb2l5YuyhXIVIj/uydb95Zv41ns3
         jHVemMh5Q9NkGezkDv/Ms5ni4CXUGdJaFx0r6BcVgAHtQ2tPSN0xprrVNUASAGw0PwVz
         02BW5f7oBLTsXSJSOwZmPD3dHfgOI2iyKON+suuRk1Lz6DmOLJ68wyDgBJPekNAQwstZ
         DkSxmRygJODz85xzo9Dzy8O/kbSmh1tDZYtb/rbpSNwDCjg7/ZwdHJP7aiS2TCA12MAT
         LfsA==
X-Forwarded-Encrypted: i=1; AJvYcCXCQl9mLt9Y5hg+GD8muBE7gH5t85ANY4yz/2qCu1TP8wVU0yHGX4i1cEf7mt4kH8nfXYiF7q0fI+j7IrkGzm9CXZfP7GXaOPf2EGqp
X-Gm-Message-State: AOJu0Ywey/lgdl7PwfLds88c3LfGw7xQ9q+vUETrGLh6umuRs7kgWjt1
	gCrxsCqUpNFAHuRCnQwl1+x8eSL++XXaD/x2TjoOXjNcyQPTP9gZ
X-Google-Smtp-Source: AGHT+IFTYF9O0qn/emzVcYUt15HD4pY5VqmLs2K6GAWKwrb3f+qHDW5ftkqPaEPm11vtJiCFfG4NiQ==
X-Received: by 2002:a05:6a00:2308:b0:6e7:3223:4556 with SMTP id h8-20020a056a00230800b006e732234556mr8029025pfh.32.1713129486139;
        Sun, 14 Apr 2024 14:18:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a00181e00b006e6854d45afsm6127641pfa.97.2024.04.14.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 14:18:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 14 Apr 2024 14:18:03 -0700
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
Message-ID: <039f041e-ca03-4750-8d69-87aef0ad1752@roeck-us.net>
References: <20240411095435.633465671@linuxfoundation.org>
 <9ac4f94c-414e-4c12-bfe0-36aff3e318bc@roeck-us.net>
 <2024041411-stencil-unscathed-bc65@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041411-stencil-unscathed-bc65@gregkh>

Hi Greg,

On Sun, Apr 14, 2024 at 08:09:39AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 13, 2024 at 07:11:57AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Thu, Apr 11, 2024 at 11:52:43AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.10.215 release.
> > > There are 294 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.215-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > -------------
> > [ ... ]
> > > 
> > > Oliver Neukum <oneukum@suse.com>
> > >     usb: cdc-wdm: close race between read and workqueue
> > > 
> > 
> > Just in case it has not been reported yet:
> > 
> > This patch is causing connection failures (timeouts) on all
> > Chromebooks using the cdc-wdm driver for cellular modems, with
> > all kernel branches where this patch has been applied.
> > Reverting it fixes the problem.
> > 
> > I am copying some of the Google employees involved in identifying
> > the regression in case additional feedback is needed.
> 
> Can you all respond to Oliver on the linux-usb list where this was
> originally submitted to work it out?  This commit has been in the tree
> for almost a month now with no reported problems that I can see.
> 

Who knows, maybe only a certain type of usb cellular modems using cdc-wdm
is affected. Either case, the problem was found less than two days after
the stable tree merges into ChromeOS, and it took only about a week from
there to identify the offending patch. I think that was actually an amazing
job, given the size of those merges and because the failure is not absolute
but results in unreliable tests due to timeouts.

Anyway, sure, we'll get in touch with Oliver. Other than that, please take
this report as a heads-up in case anyone else reports similar problems.

Thanks,
Guenter

