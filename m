Return-Path: <linux-kernel+bounces-45548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4F843243
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16BC1C25559
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E375224;
	Wed, 31 Jan 2024 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdkupmkA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C834C7D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662049; cv=none; b=qdOtlFCRpZMLsDUobWmkYJaZ6oy63Q7Sip6/UsEX41pX1Ak5v6nMofhiSBjs8o7t3IJPlJJicqdBFk99Tmll/y3nCcxm4REJuT7bQVlqKwMOBtzpMSlmm4ay74D4nwtvhiDfOJ31BA1vx+begiUx3xO2aAWQt6jhKdnYWwbTF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662049; c=relaxed/simple;
	bh=ninTgaiN3nmFAHxl8tpds0wBfwAOd1pBJBheBbLfgh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+ZQVjz7FvpC74FE6AqUR7MVbAeqMpOkUTHl1CgOlq9lIYGGjOdsjh+gCQQIhHcpZOXdXWwYkG9omsMy6DE17273u5B0FZUiJrArI2RNFxkiWYptqst7p7DZhfwV3Ijf9wCb7J1+VFEDHHMAI7h5ITJb4cjMMjfR/2Do0OHDqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bdkupmkA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+zdfb/cHl3dXnmcyuQ8UW73rXI4wnC1EyuTSXPxPV7s=; b=bdkupmkAXZ7EQQm9xuTfiKhxh2
	TSgdaJbIN7c3XgwH6266OsGHN8FlfTMPPrUseBIL1w1DwdWxh1WDJX3DN0WDCBGRVgd8YjEGlXcVu
	vH8EBibQUe5fz3ZssmI0w9LKzpkLY7Terk0aF97xTwjMtYdNof4rWthhLGWocMk2Ru1hFAm7H2MBp
	Cs8/w0OqJF20zjb2vmfljZwpvIaiM5K313picfil+dQfzTI2FZvkDG/VRRQMjzS2DsxrElGf9YOqd
	txhsTOvVT+HOWqXnZRR1Lt8cWZZ0qKii+/fZHVNtL/waSgEvZVsYjnwE+eY0G6ztZVsmCuCZ+umWf
	8zQ+RQxQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUylD-000000013mc-0wGu;
	Wed, 31 Jan 2024 00:47:27 +0000
Message-ID: <118a560d-9e5f-4bc4-b0d2-ee0b3d6a5120@infradead.org>
Date: Tue, 30 Jan 2024 16:47:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit tag order vs. "b4 am"
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, x86@kernel.org
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Reinette Chatre <reinette.chatre@intel.com>, linux-kernel@vger.kernel.org
References: <Zbl5XvzpqND9exmW@agluck-desk3>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Zbl5XvzpqND9exmW@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/24 14:34, Tony Luck wrote:
> Reinette noticed that v14 of my resctrl/SNC patch series[1] did not adhere
> to the tag order proscribed in Documentation/process/maintainer-tip.rst
> Specifically my "Signed-off-by:" was now the last tag, instead of
> appearing before the "Reviewed-by:" and "Tested-by" tags as it had in
> v13.
> 
> A little digging showed that my tag had been moved to the end by "b4 am"
> when I used it to pick up some additonal tags.
> 
> An e-mail discussion with Konstantin ensued to determine if this was
> a bug. Konstantin said:
> 
>    This is the intended behaviour, because b4 follows the chain-of-custody
>    procedure. If we encounter a Signed-off-by trailer matching the identity of
>    the user preparing the series, we move it to the bottom to indicate that the
>    chain-of-custody boundary has moved to include the code review trailers
>    received after the initial submission.
> 
>    https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.local/
> 
>    Basically, the "Signed-off-by" trailer is special because it indicates that
>    everything above it is the responsibility of the person doing the sign-off. If
>    we kept your Signed-off-by in the original spot, then it wouldn't be clear who
>    collected and applied the trailers.

I can't find "chain of custody" anywhere in Documentation/process/, nor a
specification or example of this ordering.

Where did this b4 requirement come from?

> Question: Do the TIP maintainers agree with Konstantin's opinion that
> the Signed-off-by: includes all the tags applied prior? If so, this
> should be called out in Documentation/process/maintainer-tip.rst
> 
> 
> [1] https://lore.kernel.org/all/20240126223837.21835-1-tony.luck@intel.com/
> 

thanks.
-- 
#Randy

