Return-Path: <linux-kernel+bounces-150681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6BE8AA2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE00B1C22677
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9822817F360;
	Thu, 18 Apr 2024 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZR3OOny"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E917736;
	Thu, 18 Apr 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469142; cv=none; b=citL69aR3yU5ByGZR85v7gkXBQ3JM3nU/0XFm1wpFEDRNINygrNgJ/Vwaw8908la9aZjAxHanjSchBghVevl4RDbFy6W2ghSxK0Ev5zIcGgAmpSsTz/dK75kAssWpkj05Z5JUhw96r37ktAHkBZt1VRX++Ki4l5buTR9GbVGXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469142; c=relaxed/simple;
	bh=3AmLu6fuTglDHdN6HuJ7Xq3eNdZpOuUL/x2iprMEBP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oen0DzOfRk8TK2XmEyLz0TeSlThyRv3hFz7pK/OaJQZ/GPS9UW67BpaS0gBPPS7JObPcmlngsC/1ZmdqiNuSp+W1FkIrR68oOyRcxYXNtmoJv8BqsE09Hq9MLkM10aysFYJ1kZQzlzVwvwi4iB0+VVoyW7RV96TN84gzbwrulYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZR3OOny; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a4bdef3d8eso1087108a91.1;
        Thu, 18 Apr 2024 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713469141; x=1714073941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgmECHn+IUJlMNN8CLsfysKsR/Z7Bc7D2FVBk+o+7qQ=;
        b=lZR3OOnyIai1EtkYhOJIsCjXwKLTdFPf0jkztwC9WGQJAfrc7QJbaSTBwD01RQydHK
         DANEetnKjSgBTqI6Ag03WbYjkPfOi64fEHQH9QCNh+rRYqR9XXCWxzZIa3luh1rKq6+2
         8kD5juXY247/7ZENBNJq1KUbXrpV/fzyDIMAfMCsSQzq+F6UQPldL5386nbgSf0cgpPF
         sH+OF8Wz4p0MUQxDVxug2nDP3fCVVbNdDQ3Aza1UXAIIxD4Gju2PnKXylcGs7bckAiDg
         hsak8zHjeznCfguWPet1KhYX1UyMO11vxlCDcY830y3rpDp0Hc8OEQ6iuK4aYPSsyLA2
         49Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469141; x=1714073941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgmECHn+IUJlMNN8CLsfysKsR/Z7Bc7D2FVBk+o+7qQ=;
        b=GUdpgtTeUVYUaDLTylYfPdXfIJkj4WZoCbrUiNvyVTfMd4lOGseIGV1MYjURBGHO7g
         7t7jFuaXZ17wost2uGjbxJJNsrGa9fFsvI2ZcSUNw+H0OzKlwkCfnhdeeKb7P5yBnuMY
         a6ZmtNW6RVuvbLVKMMFoJqM5nNFLzpdFUOV58I4zRGsW0m/fr6+hIa2pHBRT+/8H3Pg2
         k/RvSsfRE7xPhICNKXP069ABf38IK+JoaczqF4uxCv4TzsDr+SP+c/ZHHGPZcIZmiKgn
         3dYugyuRs0EggM2bPdi/z9d5067l3ldEjteLFtEg6GO0GlHbB4zny7ZppA97G5U9GZ+1
         tFJg==
X-Forwarded-Encrypted: i=1; AJvYcCVj1OI+6EzFeeWioJwqmQkarADYhu5C6Te4CivuXcFR/ioqMST22e+Baw7MJ9y+6OLSJIZYI7BqvuUtFT/M7Y5fmKEFgdN2faFVaKbG
X-Gm-Message-State: AOJu0YyK4XwjcOMJmlMaeFXhM2kfiiSkYEZ6Z/MpEktQPp29q5R/ur54
	l2vvIHgQ2ey7IQ0iR9ai9adajf5F0Gc2mVBOv4r+ezZtWw0yGY23
X-Google-Smtp-Source: AGHT+IGcl83ls5csOd31qry2hdPL3nzhI3ZTNwSoEJX1jZOXPdbKQ92PAX5/q90K087n49o0YP/DnQ==
X-Received: by 2002:a17:90a:ebd1:b0:2a3:be59:e969 with SMTP id cf17-20020a17090aebd100b002a3be59e969mr114833pjb.47.1713469140821;
        Thu, 18 Apr 2024 12:39:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a390300b002a232e4f9ddsm1982272pjb.34.2024.04.18.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:39:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Apr 2024 12:38:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Phillip Pearson <philpearson@google.com>
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
Message-ID: <c5d0c7f7-96a0-4806-b3b6-269d9189037d@roeck-us.net>
References: <20240411095424.875421572@linuxfoundation.org>
 <787e0ac1-cb31-47d9-8200-3f6a3b4119dd@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787e0ac1-cb31-47d9-8200-3f6a3b4119dd@roeck-us.net>

On Thu, Apr 18, 2024 at 12:25:21PM -0700, Guenter Roeck wrote:
> On Thu, Apr 11, 2024 at 11:53:29AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.274 release.
> > There are 215 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > Anything received after that time might be too late.
> > 
> [ ... ]
> > 
> > Sean Christopherson <seanjc@google.com>
> >     KVM: Always flush async #PF workqueue when vCPU is being destroyed
> > 
> 
> This backport is bad. In kvm_setup_async_pf(), it removes a call to
> kvm_get_kvm(). However, it does not remove the call to kvm_put_kvm()
> in its error handler. Also see upstream commit 7863e346e108 ("KVM:
> async_pf: Cleanup kvm_setup_async_pf()") which explains that one of
> the error paths in kvm_setup_async_pf() which is not supposed to be
> observed can be observed after all.
> 

Reverting the above commit from v5.4.y fixes the problem. Alternatively,
applying commit 7863e346e108 on top of v5.4.274 fixes it as well.

I added Phillip Pearson to Cc:; he did all the testing and can provide
additional information if needed.

Thanks,
Guenter

