Return-Path: <linux-kernel+bounces-129830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF38970F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B16283B32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287EB1494A2;
	Wed,  3 Apr 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuT87jJO"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CA1482FA;
	Wed,  3 Apr 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150791; cv=none; b=aO6hNjtggY3PWUfVNreqQLfwFzpP/n279sHU523kvmCezvvxv38CxhDN4WvYnMogzDmE4KTtK1d+YhaE7PY0WCq7asxCZ7LgVgdurqqcviIeiVrzTkgaY/36GftL47KvoHqGYK7nYNTHY8kh79gyz2qQEk1kYkW7E6FQYyDB/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150791; c=relaxed/simple;
	bh=pNqIMk3dXJAK1dmFXhtlvHJm8YAeYjgoXwxpjzjBV7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuJygQCCKClXQoKoC+tu3+0ltQoacWZ2ZwMYt17YBomfl4/y63CrT2IYNfQUc6W3Bc+eOkFreGz8nmbR8jdBtepICqQ3Dh8elrFSAasvCFAhsfKLuI5ecKDFLw0zz+LUffVHnmEZz5LhJ5DYcGUDYUOQQonHrowHfimJI0mIsT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuT87jJO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ea838bf357so5167258b3a.0;
        Wed, 03 Apr 2024 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150789; x=1712755589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tv8iMSkszzMWqrID5CXG8dHdxUEdUozJG+zGUFmwB4A=;
        b=XuT87jJOzluj5tMRmm1aaER7kM7bvaF3RGuBsVZPrnUSMovBeIaVfszsRsHvdJj6Ds
         9J3j86OZ3J2XCi5NWtxEtQDIa23CSORM6rzBrSrVmuNBrBht1shdDy8VgcQdZWjmwlJh
         +O5sQE7mjYdp6vqiPPvPXJYSch5D/+JnAf+2Q4QqrjF8n1VIbOp6c8J5xhhWZgJv1Y51
         iv1xz0t6+QXk5GFboJ2O5a0eU3yScuja/2NbF3Ij6uO1pNaCPpvjqhTk5VxG4Jh+yeF/
         /cy1Zzn3BSTjD5eKnNZr1tE9rn8itp7KfZGw0nou9kk9OsMbqrEYf8DTnH6yyd/2Fz2V
         qXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150789; x=1712755589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv8iMSkszzMWqrID5CXG8dHdxUEdUozJG+zGUFmwB4A=;
        b=wI1u6B1EBrJLHn5/c5Awqbtugmt22WITdaj1ddiEXVIKu1HbnXYSA6xyFl80U+LXyx
         smuhXfxlZtTic/GllQxsCeWlE9YWKK/QaKEdxFuOODnbl6MGRBspn/id6xQflrc2HbKA
         rwLa8fMqdpP18R95QzVDC1/Vn4/sI7UbfWWjvf+MdxCR3613dtnj6wvZfDXf5RE4BhLF
         Ra+LKmZTW28RsEeC/enA0RVVE4XrqdEuHCRIqB0KbgebOQELvWLHX9kUGKMCliuiJ1dX
         yB3Mf5vwvDM2lJhFky3SX8SNPMB5SQGoOZB8/HHOrr/U/ei5yHj7PT/BWqhDNMmhyZoq
         QPVw==
X-Forwarded-Encrypted: i=1; AJvYcCWrn3OUNqzoL3WmWebbol1z1ANMPLg1CfUlTSgGrTY5cNuQe5LEPz/xZhn+08xq/Q2CxTPELAVJcMVZ3h7gVsXMf0oz9Mil0mEKHBnUmXYMieYoEJOwqn0FHM6Olum2lSwH52g07MBw7hUTvJNMDXakH5TmGzY9i+7WL3PW6w7+W9xTBXtOCAZk
X-Gm-Message-State: AOJu0YyCfo982xCFNJJHR58VdvHvqjtv8z99m206+3vJg4/t8JIQjk9D
	qXL10PUkpjm1MQmSjEuuvyI/XTsUgmmW18kM6Tp3TZ+c9LCYL5Rx
X-Google-Smtp-Source: AGHT+IHPQcf1KauRRFFf95OsXrrxpcYKnvhoiA5NT6n4jVd/PqAHKw35hLjTyYgdc6RpO6DQuMy3vQ==
X-Received: by 2002:a05:6a00:1413:b0:6e6:89ad:1233 with SMTP id l19-20020a056a00141300b006e689ad1233mr17299843pfu.2.1712150788005;
        Wed, 03 Apr 2024 06:26:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fd30-20020a056a002e9e00b006eaf43b5982sm8479994pfb.108.2024.04.03.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:26:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 3 Apr 2024 06:26:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Message-ID: <d7522458-35b1-40ca-84a3-eaf1127a1e4e@roeck-us.net>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f8e743a6c49607de0dd7a27778383477e051b130.1712058690.git.mazziesaccount@gmail.com>
 <4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net>
 <279336b3-f28d-48ee-a10f-47abba7b0b89@gmail.com>
 <d2ab33e6-4d3e-472a-b4d7-b703955989ba@roeck-us.net>
 <1d956aab-2892-4a2b-a4b3-0a93504668eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d956aab-2892-4a2b-a4b3-0a93504668eb@gmail.com>

On Wed, Apr 03, 2024 at 03:47:12PM +0300, Matti Vaittinen wrote:
> > 
> > Other watchdog drivers call emergency_restart() if the watchdog times out
> > and triggers an interrupt. Are you saying this won't work for this system ?
> > If so, please explain.
> > 
> 
> Thanks Guenter. If it works with systems using other devices, then it should
> work (to the same extent) with systems using this PMIC. Thanks.
> 

You might also consider to just call panic(). What is what we do if the
pretimeout panic governor is enabled.

That makes me wonder if it would make sense to introduce watchdog timeout
governors, similar to the existing pretimeout governors. Maybe if I ever
find the time to do it ...

Guenter

> I'll add the IRQ handling to next version - but it may take a while as I'm
> currently having some problems with the IRQs in general, and because I'll
> wait for feedback from Mark to the regulator part.
> 
> Yours,
> 	-- Matti
> 
> -- 
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~
> 

