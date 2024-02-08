Return-Path: <linux-kernel+bounces-58795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2341B84EBE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FFF1C23C10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036995025F;
	Thu,  8 Feb 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AGf6wq9o"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7950253
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432563; cv=none; b=Aae1BZZcLgnhfkmEid61KPG8GUDG6HwpjBNony6VUVdu0jiG+baaEonITFESTPht6E0WYeSenuXukyPGkwZSUjg+hyn+OVBK9WCP5hkwPIwaNyRRyq2874nB8XWLpFqnJUFyHmdiT4MxlI29j8MlbDjVWgDQWzL9yuiCA7MjS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432563; c=relaxed/simple;
	bh=MxOaPzzHRDi/ypFyffFgplU62HMKfrqkFHEs4jO/zWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MhlkLk7YTX7YK5pTqXmZsypRzcl+qrtp+ASK6vIMBwehZ25DcCRi8kn6WL3EjtzREDysizzBqKDP0YKc8GINANzifrMiRSDhksN/W8dXggbq7yVk9D+q/ALwIBkUJnsS1pCnTIT0DOMto4Yv7Y6qbxmkaajhVR65r8zlXqhlvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AGf6wq9o; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3E17F45917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707432561; bh=k4KY7m/3T4//7Jq+kgzpSiVC4a+H1ztr9QJip2zqyeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AGf6wq9owD8fn8/iuJ7e8HcrR6duGAsVebHpSNQ68/IMBYt+SZk3MqoZIpS+xj2dq
	 ECDcPYaGcUs1/5Ul+fU9laLwCknt83TZqAUkmAvpXfRVP3m3M2e8EE/aDM6g/fBH4h
	 H1MV6XP2q8w2t4ttFA3ay96xALC6jqjR3ZnY1uO3QPC9IvhEYZQXKxjJ5dPPbMqqy3
	 Mo8TvrLrUJ6AICJioz2eKj+nrlNG4N/WCpdEUaFQj+MZ/3t9pEnKQGeUWOCJnWMFPY
	 ZbyJxm7npgl8oi5P3Zu35XjitwSM4Z+EF4RsqFe8FCPAuE4l1kMuPxiCALrv0U7VqN
	 0czdsrVnKtgog==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3E17F45917;
	Thu,  8 Feb 2024 22:49:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [RESEND PATCH] README: Fix spelling/capitalization
In-Reply-To: <20240207122127.9182-1-thorsten.blum@toblux.com>
References: <20240205120904.1711-1-thorsten.blum@toblux.com>
 <20240207122127.9182-1-thorsten.blum@toblux.com>
Date: Thu, 08 Feb 2024 15:49:20 -0700
Message-ID: <87eddmfu6n.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> - Fix spelling/capitalization s/Restructured/ReStructured/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README b/README
> index 669ac7c32292..026eff0b8e06 100644
> --- a/README
> +++ b/README
> @@ -11,7 +11,7 @@ In order to build the documentation, use ``make htmldocs`` or
>      https://www.kernel.org/doc/html/latest/
>  
>  There are various text files in the Documentation/ subdirectory,
> -several of them using the Restructured Text markup notation.
> +several of them using the ReStructured Text markup notation.
>  
Applied, thanks.

jon

