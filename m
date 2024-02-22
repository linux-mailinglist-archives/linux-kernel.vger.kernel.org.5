Return-Path: <linux-kernel+bounces-76518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285285F848
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CFA280DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3E12DD8E;
	Thu, 22 Feb 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEmfeymq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97381F95E;
	Thu, 22 Feb 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605285; cv=none; b=SoVfAAbkBRYQKHW5fvMnccAu+910h06402Ey2jD5VbW6aU35VJcX3NSGh1g/McL1OIxZLJ6DN4ThP/T0Dm7Y0sKY15uBBrGQBk6HOeHG6/62UfkBnzhufctXLr0Xi/yNSc9AZgoNQbqttmOdAOnjByTQy3+3wt17uivTySRikLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605285; c=relaxed/simple;
	bh=ZI+o8a8KnNcSBUYdnSaf3q7l9/6TqpPnGor6PEAB6kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwJt7BumPJZdSH+JjUxvR2DB2G3cA+jTXbc7VK8vNTG44BlBk8y7sV2PhrbOakGZImDv3tadqHrhqpwqo5TirZGhHwEZ4RQi4dhLDEzpUSm3OEynRXcOYkOT06v24JErfHINbI2eC2QvXhPL+9IBqQYDg0nkxf3OU2D7i2NibXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEmfeymq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346CC433F1;
	Thu, 22 Feb 2024 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605284;
	bh=ZI+o8a8KnNcSBUYdnSaf3q7l9/6TqpPnGor6PEAB6kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEmfeymqM7VQw7hx3G0r+Xzdoyt8kzAl79LLtb6r1ODhpfFKH7KHBgjfH4mBPk1oC
	 b1NPJy2Px2/7V4nOvICKBGEfL6Nx8agfEv1Gwl492uv8pEIOMb5ZJjrU6gYzPn04ye
	 oa15nK8Od9grkYZbGXeOkHhnys82jc0PEV+M250QP0ZDWbjC72YZ6bSAxz4Sfy24KX
	 LQOhvdj60szF+gjGfqEUWbsbQA0fSZ6hvtURUFfbwmitlSvWdonu+RXnvS1nlujDt5
	 sJ9VwRQc+HK0Ysk0F1ECl0+6RYEsUjVKqJ8C4tyDjxReR9oBIAOI9qwFoNTr04scYA
	 e59cCi/CQvt3g==
Date: Thu, 22 Feb 2024 07:34:44 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH AUTOSEL 6.1 05/15] x86/cpu: Add model number for Intel
 Clearwater Forest processor
Message-ID: <Zdc_ZLH200jhMTsx@sashalap>
References: <20240202184057.541411-1-sashal@kernel.org>
 <20240202184057.541411-5-sashal@kernel.org>
 <ZdJXAs2j6UGcSBBN@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZdJXAs2j6UGcSBBN@duo.ucw.cz>

On Sun, Feb 18, 2024 at 08:14:10PM +0100, Pavel Machek wrote:
>Hi!
>
>> [ Upstream commit 090e3bec01763e415bccae445f5bfe3d0c61b629 ]
>>
>> Server product based on the Atom Darkmont core.
>
>This adds unused include, I don't believe we need it in AUTOSEL.

Dropped, thanks!

-- 
Thanks,
Sasha

