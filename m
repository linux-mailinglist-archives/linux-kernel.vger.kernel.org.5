Return-Path: <linux-kernel+bounces-37480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AABD83B0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CCD286D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF608129A7C;
	Wed, 24 Jan 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="DJkGbLm3"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153286125;
	Wed, 24 Jan 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119357; cv=none; b=MZWZB4jWc17e7QP/P6DHVCYr7gQSF70h/bz401R3GT75dmS5k3AKQCmSCXBRE15K/bzpJ9hK1WsOGwr6N86nENCVqNBDa5qTtsjLR6fg8Y0TsMEnJT3fi0z55mky6E24MKxASBUPLEeSyopJQEsrjLAMnRBBE+8pbNLfDDyNcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119357; c=relaxed/simple;
	bh=hjk1jZv8+jDw4hCH9E8I1p2DBtxZD5hQhq7GfriuuoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHg2IgCF5QvtjKRN4sHY3bML2ANg8RjkZirE5BKmmz5bqrdI/extp5v8Ncd/rm0FIMf1LXvO52O8TZX8IBcbb4kxIwQAR1DMWafm0tKJCWKTg51A3BPcllhPIQXwpfThyyQxBIjjQpYSK/VopUvQfZ059R0Mo1DpyEQDEYLxPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=DJkGbLm3; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Qyp4ND3n+s5/V2GGVxToiInyto4LLQcezgdlxoZNjMo=; b=DJkGbLm3g0gXgnKwyzZs4duz6s
	oZH/zpjJfmPRNtJA8M9Z6WAxNkwUadIIvf481OlBfRNxAeEjCJ8yCUhSX+Ww43py0T4OyXP6IE6tU
	4qRUCR+NdRY5lpp4MTQyUkbJzL0TaS9xMc3K7tkdA/KHoM8vuyrGjnUCyQlXyMFj8vglhYtFCwqHA
	849IDDzpfoAVMcj7K5KYCn1TgNpkQbnzaEVxybPzhnQ1Nu8deNDAGS8V5LogS+ws2R+Hc2XD7MJ2V
	2/Zyiad7ScZpWemJsnh/hsKe26UnMj6Jp6HJgEqhelqrl8YYT7I81q05tbbvjsy4jBnw9duMw6DDh
	4PP7+OQg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSha4-00EKcL-1c;
	Wed, 24 Jan 2024 12:02:32 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Cc: wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/9] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Wed, 24 Jan 2024 12:02:32 -0600
Message-ID: <4864383.GXAFRqVoOG@camazotz>
In-Reply-To: <18c814fa-b458-48f9-b7e8-88b23a1825e2@app.fastmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-6-zfigura@codeweavers.com>
 <18c814fa-b458-48f9-b7e8-88b23a1825e2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 January 2024 01:56:52 CST Arnd Bergmann wrote:
> On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
> 
> > +	if (args->timeout) {
> > +		struct timespec64 to;
> > +
> > +		if (get_timespec64(&to, u64_to_user_ptr(args->timeout)))
> > +			return -EFAULT;
> > +		if (!timespec64_valid(&to))
> > +			return -EINVAL;
> > +
> > +		timeout = timespec64_to_ns(&to);
> > +	}
> 
> Have you considered just passing the nanosecond value here?
> Since you do not appear to write it back, that would avoid
> the complexities of dealing with timespec layout differences
> and indirection.

That'd be nicer in general. I think there was some documentation that advised
using timespec64 for new ioctl interfaces but it may have been outdated or
misread.

> 
> > +	ids = kmalloc_array(count, sizeof(*ids), GFP_KERNEL);
> > +	if (!ids)
> > +		return -ENOMEM;
> > +	if (copy_from_user(ids, u64_to_user_ptr(args->objs),
> > +			   array_size(count, sizeof(*ids)))) {
> > +		kfree(ids);
> > +		return -EFAULT;
> > +	}
> 
> This looks like memdup_user() would be slightly simpler.

That's useful, thanks.



