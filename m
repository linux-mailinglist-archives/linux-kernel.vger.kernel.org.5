Return-Path: <linux-kernel+bounces-134052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0270C89AC8D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C09281E95
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E945950;
	Sat,  6 Apr 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="OUY6OY7F"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806340BE6;
	Sat,  6 Apr 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425645; cv=none; b=HOnD7hLhMimtptGTjPDBXjCW/HC5KqFYI+ET4oFChrSEO54bkOgt811HZp4US9x8LZv8PHI8gcR9Agi8/ROBQgYBXv2xnFyxVylW+OJLMwdeRLEILnniFsYorm6UcB/xnXkdYS+gLjtMj9doGsh9oKLlcw51lTkEzMJrI9SP3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425645; c=relaxed/simple;
	bh=1TbzBF6TZ7jowuvFuef763KmaAKfAp+fdsyr87ylRCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxVDRxVToxRU1pXD+egYrH19aA/kCPbocgLvheXW32Tu+s9Y6YXfBoDzAyyneyGg6v6jmt74jIOd+z/UtDzMVKwLLBp08I1nxNS+0712M9gL3kmRwabUZdAYbsrW8KZAzb7Y7KQ3ylCH/gqq13OYVVuvpyAJ3BGHqwUCOi8bxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=OUY6OY7F; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712425641; bh=1TbzBF6TZ7jowuvFuef763KmaAKfAp+fdsyr87ylRCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OUY6OY7Frgh4YJTlpMVYJVHU7kPr3lSRxipzfVFrvSlT15eBgJhpbywmpcJzb7wgB
	 5quYEZKpVZnYFBTdqd1kA71iEjLMY0qLaPztl+EPM0peDRAEUamMuoA5EPYzsYVwcz
	 +QJrYGKd2Ladfy40cdK/dxHTgMlXBhoLZdXutvj4=
From: Luca Weiss <luca@z3ntu.xyz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: document in_temp_input file
Date: Sat, 06 Apr 2024 19:47:18 +0200
Message-ID: <2850305.mvXUDI8C0e@g550jk>
In-Reply-To: <20240406174513.13b4e9e4@jic23-huawei>
References:
 <20240406-in_temp_input-v1-1-a1744a4a49e3@z3ntu.xyz>
 <20240406174513.13b4e9e4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Samstag, 6. April 2024 18:45:21 CEST Jonathan Cameron wrote:
> On Sat, 06 Apr 2024 17:31:04 +0200
> Luca Weiss <luca@z3ntu.xyz> wrote:
> 
> > For example the BMP280 barometric pressure sensor on Qualcomm
> > MSM8974-based Nexus 5 smartphone exposes such file in sysfs.
> > Document it.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> 
> Hi Luca,
> 
> Applied with a note added on fixing the line above to not reuse X.
> A good additional thing but needs mentioning in the commit message.

Good point! I wrote the patch in Feb 2021 without any description so
I had to retroactively make something up ;)

Thanks for amending and applying!

Regards
Luca

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 2e6d5ebfd3c7..7cee78ad4108 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -243,7 +243,8 @@ Description:
> >  		less measurements. Units after application of scale and offset
> >  		are milli degrees Celsius.
> >  
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_input
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_input
> >  KernelVersion:	2.6.38
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > 
> > ---
> > base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> > change-id: 20240406-in_temp_input-4505d7fafff8
> > 
> > Best regards,
> 
> 





