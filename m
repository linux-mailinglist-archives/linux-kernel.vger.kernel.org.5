Return-Path: <linux-kernel+bounces-98893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BAB8780C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B50283A98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333A3DB89;
	Mon, 11 Mar 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hTDPl9nL"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7222064;
	Mon, 11 Mar 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164459; cv=none; b=NS0ATb5baIdECZbqUdV3IICU6qDfWDNWFrnYn2P6YCSLcYQS3b4mrve9L+EWKjMLTql3ij2hkI/xboWAcM9qnGqpZedJL+ie2NoIpjWzWh2whleQ/O5DZc9X0NoFunwELuTvDOXIjikGbNotaJW9BtNXUnlnpkyF+rvOXiQDur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164459; c=relaxed/simple;
	bh=k+J8N5R8sr7l5fncY01oycsxa0zAXE4WNpZdcwc6X9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afLgtvtwzX4ZjbL+zaTwXIBEhVSKoyc0puTFhYbuu7piRZ+tjpR1wON+by8NO9kMoA4eqUobw9xypoBWx2/3w9A5aNmqQkZOdIQtrNQa8wWqOuLy7KQMeHDHUoJBPGy52lGYiijjVScOZsZs9vxWTD8CUu6lR/P7/0Ryos9qerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hTDPl9nL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8VK8L/sGnEGTTfqH1UQDPWwZhR03D/2fXwjVW002TQ0=; t=1710164457;
	x=1710596457; b=hTDPl9nLiGf5O3Y/gje7aXRVQqDjgIQTwOTZJYSpfcxelPJ8FWYlF8qRKdqav
	LBtXVS3LBlJevgF0aVOtUEtpzMs7stzqchyOjJYdy6cvqtpYE6Sy0jl+kcamHLubgAuBPMNHazSY6
	f92n6QaCKURAwvZhOEchsj6xHLU8ykPF4zPFoRcF2DhRo8FjRkZUR/DUa3fiamgQFYW4Dx+hbC2u8
	0ZNom6PRJOkq7cp28NZmvwYR5eqNs/VO4iTDKyA1QHxIXwoW5TXtGSb7+C3VQsXjs/mrFyczGAYQk
	MFdcLQb6JbYsZ+Tl4Pm3O1u69WWGdIvivMT0x4kLk0AdAuv19A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rjftb-0007K8-8v; Mon, 11 Mar 2024 14:40:51 +0100
Message-ID: <e73a0418-33ad-470d-8740-97694e6dd6b1@leemhuis.info>
Date: Mon, 11 Mar 2024 14:40:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: handling-regressions.rst: Update regzbot
 command fixed-by to fix
Content-Language: en-US, de-DE
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
 <20240308-regzbot-fixes-v1-2-577a4fe16e12@collabora.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20240308-regzbot-fixes-v1-2-577a4fe16e12@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710164457;edbd8592;
X-HE-SMSGID: 1rjftb-0007K8-8v

Thx for this!

On 08.03.24 15:10, Nícolas F. R. A. Prado wrote:
> On the reference documentation for regzbot, the fixed-by command has
> been renamed to fix. Update the kernel documentation accordingly.
> 
> Link: https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> Link: https://gitlab.com/knurd42/regzbot/-/commit/6d8d30f6bda84e1b711121bb98a07a464d3f089a
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Thorsten Leemhuis <linux@leemhuis.info>

> ---
>  Documentation/process/handling-regressions.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
> index 42b13f77b019..ce6753a674f3 100644
> --- a/Documentation/process/handling-regressions.rst
> +++ b/Documentation/process/handling-regressions.rst
> @@ -432,7 +432,7 @@ or itself is a reply to that mail:
>   * Mark a regression as fixed by a commit that is heading upstream or already
>     landed::
>  
> -       #regzbot fixed-by: 1f2e3d4c5d
> +       #regzbot fix: 1f2e3d4c5d
>  
>   * Mark a regression as a duplicate of another one already tracked by regzbot::
>  
> 

