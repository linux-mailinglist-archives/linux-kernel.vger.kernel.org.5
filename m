Return-Path: <linux-kernel+bounces-9217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE681C26A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDB728461A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8AEB8;
	Fri, 22 Dec 2023 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X56fcH9F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4108A23;
	Fri, 22 Dec 2023 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso943428b3a.3;
        Thu, 21 Dec 2023 16:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703206053; x=1703810853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0DkFx3QkS/a8cZdxuqsiGOFIG2X1G3gZilc4HvyolY=;
        b=X56fcH9FTFqHZ+B0Nwas+tTCfN9pInLDIgvrrgoLTnnm82QWrhIlg1cnyq+Bub7vTs
         yNAitTv7JZURmfqGR8XZUqjMnr5ys795fsHvYI6l73Gj25F+Hd5qjxdNBAFHgs2DjUf1
         xBihI6jCPBmUyUW6Y0mF6NtdefdGrB4Z6W+NnlSkIvRMW8LpuQJEl+DRkaj5yIl2Ellz
         z1Z8++TD8bNq9Ce/ZB7hl/4vfcs5kALw/P3KvMe4iNzzmXZgk7CmLqG5/vD8c4Dogtz7
         /cIpFFLGj5hk13HZvVlCakXdCyFSxlnJyPLktZSlUvv//mDGNLrtByT2uRqikvmkvPjz
         uk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206053; x=1703810853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0DkFx3QkS/a8cZdxuqsiGOFIG2X1G3gZilc4HvyolY=;
        b=n3b08YJE30vJiqR/KAgFzsZGz/I+7SJmKfAR6TwwOI6Zc/ngu3libff5CvvArzIsjN
         zQ6XDDM4ikJlcFuKEu8Jijq46nah0Jl2gbGYYUs+rLC4AINNLWJyzARZGJvjCdYVjBfM
         LqDyNffOu2R9qvSVRvGB4M0loku5cBONdCMKDHUcR5YndnDAR7xZxjwiwJSJqa0iTFUy
         Mf92aAnODACkx+X7P97IU1s1tyx9w+VWppNcR79kjkBcqgzI64RBdWVSS8AUBjQi69KZ
         lejj7GjlIKfr2gt/7fwhaPAD1ThhD9UQxzgefucgkm4JlsaAciVVoXsPfInCBZIqIPWt
         eMOg==
X-Gm-Message-State: AOJu0Yx4grmAppS/OnV+V+OxMiURxVzG5YbP4MH3+exAOmq41iW3U0XJ
	TAw4wsSd+oF10Dta+8FXdL4=
X-Google-Smtp-Source: AGHT+IGeefGo6HnuINBQc66Bc5fAf0J2wMMeqn1LKaBmVMrEU/rhaVTOrAVbtDmvFcPdOMKBgkRjfg==
X-Received: by 2002:a05:6a21:a59d:b0:187:23f4:d061 with SMTP id gd29-20020a056a21a59d00b0018723f4d061mr561588pzc.37.1703206052811;
        Thu, 21 Dec 2023 16:47:32 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001b86dd825e7sm2241282plh.108.2023.12.21.16.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 16:47:32 -0800 (PST)
Date: Fri, 22 Dec 2023 08:47:27 +0800
From: Kent Gibson <warthog618@gmail.com>
To: brgl@bgdev.pl
Cc: andy@kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v2 5/5] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
Message-ID: <ZYTcn-UX0TUM5P9O@rigel>
References: <20231221012040.17763-1-warthog618@gmail.com>
 <20231221012040.17763-6-warthog618@gmail.com>
 <ZYReZI_TnX1MyvP7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYReZI_TnX1MyvP7@smile.fi.intel.com>

On Thu, Dec 21, 2023 at 05:48:52PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 21, 2023 at 09:20:40AM +0800, Kent Gibson wrote:
> > Replace the wrapping functions that inhibit removal of the gpio chip
>
> GPIO
>

Bart, I don't care either way and not enough to respin a v3.
If it bothers you could you fix it on the way in?

That is if you aren't too busy reversing xmas trees ;-).

Thanks,
Kent.


