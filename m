Return-Path: <linux-kernel+bounces-31347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F184832CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7AA1C20E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647654F90;
	Fri, 19 Jan 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P01zzIBO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6C4C624;
	Fri, 19 Jan 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680661; cv=none; b=TFKGbhfKs/qALaxlZN5IKY/OTuwEEGLv4p9Bc1yRAzFXKuitdqPEc4jMUqL7fkWzi2345R+N+1II3pCY2f/611lZhySwEU4kR3sZkb9uotrfC75thSVhDpObJaLU5Mzf8mijyZRGjYhCyQU9lEUjmcuJM9W9Bjbfk7ftrYjyOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680661; c=relaxed/simple;
	bh=xKv9OveGBp1yi7jxl9iqJDBz8g4glIa0iEOOdUTCpgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz8vTD+Wiu4rHciAAqzU09HZL9Ju/J2M9S8M3IEFRtJLA3rrktPFk9o4sJNKbjiBFdfL5PcXFhZssLdjw+Vc+svn1qDGkD45/E0S0QB5qps6zWRfpSn//1sTj0ZM6YQTLZYFNrWa5jWouWFxKep9an3wn1/ikbAHU/cFoHlswz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P01zzIBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55698C433C7;
	Fri, 19 Jan 2024 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705680659;
	bh=xKv9OveGBp1yi7jxl9iqJDBz8g4glIa0iEOOdUTCpgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P01zzIBOdua+kfwu0BNq4w2WH+GL7eaFAweAs7l+L572UwZCPqGi71hEb11JQC/S8
	 bQyRIRKNnrLJ5zUHT0Ot2UFJ2HLrPZ/uFnB+hcTr4UXZ9IDgDtq3Tbu2r3V6Yzwtr8
	 QAoHxfi2xyGqj8nzUUlu9+umTaLXUCxV9m6fn1nw=
Date: Fri, 19 Jan 2024 17:10:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Message-ID: <2024011935-snowman-regain-b820@gregkh>
References: <20240118104310.892180084@linuxfoundation.org>
 <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>
 <6d016325-f6af-43e8-ad57-343485439b55@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d016325-f6af-43e8-ad57-343485439b55@nokia.com>

On Fri, Jan 19, 2024 at 05:07:08PM +0100, Stefan Wiehler wrote:
> Hi Florian,
> 
> > It looks like rcutree_report_cpu_starting() has been introduced
> > 448e9f34d91d1a4799fdb06a93c2c24b34b6fd9d ("rcu: Standardize explicit
> > CPU-hotplug calls") which is in v6.7.
> > 
> > For MIPS, it would like an adequate fix would be to
> > 's/rcutree_report_cpu_starting/rcu_cpu_starting/' for the 6.1 and 6.6
> > branches.
> > 
> > Stefan, do you agree?
> 
> Yes, I agree, that is also how the patch looks like in our internal branch
> based on 5.15.

Great, can someone send a working version of this patch for us to apply
for the next round of releases?  It's dropped from all queues right now.

thanks,

greg k-h

