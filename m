Return-Path: <linux-kernel+bounces-130856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF05897E08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EA81F259D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E95208A5;
	Thu,  4 Apr 2024 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiWqwU26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAF1CA9F;
	Thu,  4 Apr 2024 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202244; cv=none; b=XS/6yXWwzRt5ueqBhTWmeDHDuUFickAMVQ0Xz6O2XJYp08/3+EBxSbKimj5PPA05YgmbQIxj7KDqPNDvSNAGcBJNafbC9diImK24/klkfWCCJm5C+OQi9/oMbxBg9CBjfavDm/Xzj6r1zX7E6qbodxOXRqM24GFUkxq3Fim3ZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202244; c=relaxed/simple;
	bh=kRbNb9/svIyoKLRfKl6/vBMTV+RsyR+umHBUh+HQO6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWDgWv6uOqQ0Nwo1mvqK/2hiePPh2B2i6w+MJOgagZmZZiMz2VkfaVkz219lyc+pUNbER/EwqpFeVuk/oSMfExE0n56wWx/yF9As0i7lpVl7SUH69G/nUbZ/aeaJEBD+RfDHtrpwy7HKFvoLmfuvoIyQe5DvGL4nrRTvmD4h6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiWqwU26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30048C433C7;
	Thu,  4 Apr 2024 03:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712202244;
	bh=kRbNb9/svIyoKLRfKl6/vBMTV+RsyR+umHBUh+HQO6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NiWqwU26KU99sxuB9VDlcnt99h8Hn+ylO3SwWFoQ5X5GvMkYpGjJnWYvqr6GZ6XVP
	 ss30PsdhHXAfmkuW0o6bHmpWEzGct+IFfKaDjPgoS98AQc4u8lT95CLs+lIsBoNrTK
	 xURElA9dhmjY+43JCo2YsiJoLB8x6fb622d3+ym8mpZL8lu8yjEr3waCbGd3PW56t+
	 7GgMfJXrTWbG0rgatU4V9Nt9IvwM1Y7PqZd+V+vrGi5jJQlu5O/k2mceTc8rc2la6l
	 k3BLsdfLtyaLzmLQI6bu+4zXHGJ8bZQOgQnymqFz55ljE7Qq3t+r+Al9V7PD5IBKkZ
	 lgNzdH/1tFFSA==
Message-ID: <a67f548a-fa68-4430-8743-81fa46b24b9e@kernel.org>
Date: Thu, 4 Apr 2024 12:44:01 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: sata_gemini: Add check for clk_enable
To: Chen Ni <nichen@iscas.ac.cn>, linus.walleij@linaro.org, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240403043349.3623961-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240403043349.3623961-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 13:33, Chen Ni wrote:
> The call to clk_enable() in gemini_sata_start_bridge() can fail.
> Add a check to detect such failure.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Applied to for-6.9-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research


