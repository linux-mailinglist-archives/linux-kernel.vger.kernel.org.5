Return-Path: <linux-kernel+bounces-142600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A98A2DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D95428153F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662054FB8;
	Fri, 12 Apr 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwFVNXpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A354918;
	Fri, 12 Apr 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921896; cv=none; b=j/Yd6rvtHXrUpkVWEao32bNBLDqrTJU3xoebhLH07NtwZVLQcl0E4LsM+zF4frFRJEQflFMuh9Q8/vGH/tK+JC4K5O+RCZuG37Elg3OYmDeI4n7GyBnL6U/xSYaBmpnUh4bNTtpkLZzNbi+V7ssE9dsQvWkWc1GD9VfliGSwLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921896; c=relaxed/simple;
	bh=pGc+Ksvp/3JDoauuu3KTD0EO0x9YqlaiRkeoKCKbnww=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n3xYVGQQi3BVt3xauyodlmmcgc5nCCxDA5Xe8upMAbSs66wsRaqQVQZjcLN2Qkd66qugPoUcn5cVb6R3SYMVfc/aop3VDCG5kiZNfbqxC3ttgkJHJRghhdH1T8hgl5T4g06IKMbJNey9oWVHzhUprrkYIVx4WLeoacQ9ews3nEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwFVNXpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544D4C113CC;
	Fri, 12 Apr 2024 11:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921896;
	bh=pGc+Ksvp/3JDoauuu3KTD0EO0x9YqlaiRkeoKCKbnww=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fwFVNXpiPzNtRMkFN+9o4xt/MGLfatDVeS5YCcWOfh9hKW2ItvnsCV/i1OcT1n4cW
	 gYQoyvFXPzbJX38Lr1+KeV2dt432MIBX3sdDwc0pvP6OORDpyAenICW22+4XPaFsI3
	 bVLE9xeDvESfOM30eL9OuZDyHJBxkXW5bkc9wD/A808tjQ7ORoH1HqysxOnIL3ZSCX
	 RVlbWRHPN2uqo5LbsRCFIWF/jfvXlDwbbcXJS2aqmtPUWLUztReeJIUT21UfPedfhB
	 2YDcNpfzBHGk3BYQPo1dQINgcXRiAVaWp6PvQtF8kWqaf5wmCeDftEIBW2xDN7gQPA
	 sumu4iglry+6Q==
Date: Fri, 12 Apr 2024 13:38:14 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>, 
    Ivan Gorinov <linux-kernel@altimeter.info>
Subject: Re: [PATCH] HID: Remove the unused variable minor
In-Reply-To: <20240407022804.27081-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <nycvar.YFH.7.76.2404121337420.5680@cbobk.fhfr.pm>
References: <20240407022804.27081-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 7 Apr 2024, Jiapeng Chong wrote:

> Variable minor is not effectively used, so delete it.
> 
> drivers/hid/hid-winwing.c:123:15: warning: variable 'minor' set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8705
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

I've added

	Fixes: 266c990debad2 ("HID: Add WinWing Orion2 throttle support")

CCed Ivan here, and applied. Thanks,

-- 
Jiri Kosina
SUSE Labs


