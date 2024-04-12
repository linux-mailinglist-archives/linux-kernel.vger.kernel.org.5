Return-Path: <linux-kernel+bounces-142605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26CE8A2DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A15B22232
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B054FB1;
	Fri, 12 Apr 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpW16t+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1D54BD3;
	Fri, 12 Apr 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922059; cv=none; b=pU/Tsl+dqI7yYU3VTHEvnU20g1l/8ILLHkCRFV3mz/Oq/ZeOt6Sg2otG+OZadXMrrlZIIK/TpQ32r5ZcwqOW120wxacKSeXN/lvmm+Mvjw4KxdtDL697gmyjoxO/NmSGiWanuWj6jVmqxWEw+wXvMYz86gTtXvTLQhOpGpy+Dis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922059; c=relaxed/simple;
	bh=U92xJokYVHJr5H1O8Xzfx7z03ges1L0OJWlyaDwZUTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S4vzOZ5IERarOEDRUztTVfUqmm82m5eqBDLb1JZQodUnl3UMA3GUqDu3AEK4l/8imyXXf5xGsNkLxrIOiCwTCSrp2oT0R4dyjTLnMqG4ZhAPXEXo94kUDiHhx11YdAIYhZTf6flArKy4kt3axBSqJ+1nCQ03k8dxEyi2R8XDV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpW16t+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7F6C113CD;
	Fri, 12 Apr 2024 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712922058;
	bh=U92xJokYVHJr5H1O8Xzfx7z03ges1L0OJWlyaDwZUTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KpW16t+EkgI918zNqvGZ4zeouI7sT38bJW5VZknpS/vZX3WW45bTd+FAL0/fntP41
	 4/+YFbAxRJCASy+8MonIV9jUsUh9qZR4+CrG5ydP1XRIYf/GuQYEnytvZCp9yJVc9E
	 HUNAPv2khTv6e7o9LJAIjmLWu8fuR9AVTXRch/x9IjnGBjvXBK3bvV3s08ZH/i1OiH
	 bG36a90K6JQDEpeQwPFF6s0M8cK+gY5Gq7V0GXHBrc3715SQJjGUsDuYc6fzAuT9rs
	 kMtV/jJHBdwWJQLZpfcv2BG2Q6uisBthFrepginxI+tFUgOJN0Nu2A70GUv2QF07vq
	 ObwfbDCZxRQgg==
Date: Fri, 12 Apr 2024 13:40:56 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc: djogorchock@gmail.com, bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] HID: nintendo: Remove unused function
In-Reply-To: <20240407021100.48008-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <nycvar.YFH.7.76.2404121340480.5680@cbobk.fhfr.pm>
References: <20240407021100.48008-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 7 Apr 2024, Jiapeng Chong wrote:

> The function are defined in the hid-nintendo.c file, but not called
> elsewhere, so delete the unused function.
> 
> drivers/hid/hid-nintendo.c:697:20: warning: unused function 'joycon_device_has_usb'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8704
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


