Return-Path: <linux-kernel+bounces-141327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E78A1CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1641C21F00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0D127E10;
	Thu, 11 Apr 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZaxF5pK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF723E479;
	Thu, 11 Apr 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853165; cv=none; b=SVV25zSkC5dPpXJpWq5OfTVKOXaSD8SCKjNVJ2aTH0DGmk9CjPMX7XNE8zp6Seih3vpKYzVvyfFdXoPDz/WrDBYM0jiHpR/wpLaoyhgTOYWggNSdfvnF9mFbhZnp0Erw44gRcvQAkyXKjprtJBHuuChPf/MdlQ4Lf6QLnegBBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853165; c=relaxed/simple;
	bh=9j/+bUy2vxwWDxN2Z77Pi1fa21Xq2qMCNe5aayMINCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHS3zQkN9aaPzQdfElOftOZbiJ8JOR2Nu62hYyo4qIf8/cUmkRQWwmQ63i0xQpOtWm1XUel4kcmDax18mkcL2kHe8C9JBFk5NxP5Vn/BFU+Lczzwk8acWZNb68gZhUxj4tnogYqhKi8Xf0NT9HoRByAVvaJCCf2fGn2OLUSxZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZaxF5pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A20FC072AA;
	Thu, 11 Apr 2024 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712853164;
	bh=9j/+bUy2vxwWDxN2Z77Pi1fa21Xq2qMCNe5aayMINCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZaxF5pKpueDte2zqZzZYfLIQ1KbT5a43TD3fR2IIKcepT1+bijSeg+I/aoiPjfXw
	 yzFeqwfeqGj7BSZzv0hb2Daylm3jOTOgiR3P9UpLyvjNKY3Yr7e6gvVsbBdY1EYKb8
	 A4H3c6lWzf5Qd9seVxAyYEBg+KnOmutpvevvlNv9P/+4VsrZjpXTOcNukqEzsn7AFO
	 Vye+A6yYaT3Q2g2/+JqbtfihnSI+CAoGOzpLkMVv6kK0iRtJt/L9Y4iGeyM4w8A7Cg
	 947p1Gx3MxF3JhHwkYiDs2Sbfzx7E/R+YPhkDWYbdt2fdrrUlKGX4UdCbuV5GwwEFC
	 2tU9NuIv2RgVA==
Date: Thu, 11 Apr 2024 17:32:40 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/1] ptp: 82p33: move register definitions
 out of ptp folder
Message-ID: <20240411163240.GI2399047@google.com>
References: <LV3P220MB12026EB15790ABE932799E53A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB12026EB15790ABE932799E53A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Wed, 10 Apr 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> Relocate idt82p33 register definitions so that other multi-functional
> devices can access those definitions.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Submit to net-next and add driver name suggested by Jakub
> 
>  drivers/ptp/ptp_idt82p33.h       | 27 -----------------------
>  include/linux/mfd/idt82p33_reg.h | 38 +++++++++++++++++++++++++++++---

Why does this need to go into net-next?

-- 
Lee Jones [李琼斯]

