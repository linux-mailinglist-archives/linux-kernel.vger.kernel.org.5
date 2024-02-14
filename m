Return-Path: <linux-kernel+bounces-65579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF1854EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80E5288752
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09160DC9;
	Wed, 14 Feb 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b="YuvTpkTt"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783660BBE;
	Wed, 14 Feb 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929069; cv=none; b=kgB5pzjF12Q+KJn35HScASsNMZoeeoFxikojqFSpANoi+NVaTR39FYE6ocr0lZbalwcnJDjBIk5U5xbUFQORUbdg52/zaj+XQHmmVGh3gWqZpEsqeRjgCMAVf58so+Po7W/q53yUnrYFY5b9ICgVfZXuSEBx0JjxjjEvU2T+2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929069; c=relaxed/simple;
	bh=oGw9fVB7x4DqTTJd1RZp9jcHpF1ROTXB3RtCnAkqmII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSOqjL+TNn/Ap0FdJMCKn6J28I1eG3rmIoKci2kvvoLUbo28B6P5mF+ktnuUu4YcPBNOJ/fX5Ga0u73qmXhbbvd5bKxJ4W/HTrR/kgLaBB3cxaCDGSiO7ej5FXqiqZ2I7OuM0aK3SQEfSLEs65hKGmIJzcdwa4BC30QNhfBD/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b=YuvTpkTt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707929042; x=1708533842; i=svenjoac@gmx.de;
	bh=oGw9fVB7x4DqTTJd1RZp9jcHpF1ROTXB3RtCnAkqmII=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:
	 Date;
	b=YuvTpkTtxxPUIsgtfJ8tfRSeipuQq9MtNIizxhdgQlIrtuD3m7xaKZKcSYBYMOGs
	 6R6gMpXSQLLkT1s7Im1Qdre3uvrODgkj28uVcFS9sXctud0MibqNftnilSgh9LJyD
	 pMyYt9AfpyyRMcxtLVfawf4nb9CQ+9biIbv54QeEvwDEYZ8lkd/vecHv13G44S+9w
	 2rsFG+fbtr1Qlz9u1TZSKK+z6gcrignSx3gdvYczvN0e5/8nVWVjNbNlBtWU5HdtY
	 3LI69WPqo1PibdeP4jgA0GMr3ySe8hTVWGGA5QrA1V+cUB9lfRHNxA8ih37b9UK5d
	 CgqgD4EEmMiiKEEK6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.86.131]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M3lYB-1rb7Zp1mHj-000vwn; Wed, 14 Feb 2024 17:44:02 +0100
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 5CB7880095; Wed, 14 Feb 2024 17:44:00 +0100 (CET)
From: Sven Joachim <svenjoac@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,  patches@lists.linux.dev,
  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,
  akpm@linux-foundation.org,  linux@roeck-us.net,  shuah@kernel.org,
  patches@kernelci.org,  lkft-triage@lists.linaro.org,  pavel@denx.de,
  jonathanh@nvidia.com,  f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com,
  srw@sladewatkins.net,  rwarsow@gmx.de,  conor@kernel.org,
  allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
In-Reply-To: <20240213171844.702064831@linuxfoundation.org> (Greg
	Kroah-Hartman's message of "Tue, 13 Feb 2024 18:20:46 +0100")
References: <20240213171844.702064831@linuxfoundation.org>
Date: Wed, 14 Feb 2024 17:44:00 +0100
Message-ID: <871q9f3sj3.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:K+HOG/GQYW5pwarb/ntOh32vSaVyV1m9avODePCAc8oUG6iv0KR
 Gy6ajZl3yVsYiFhL392ecAAHAAQW/FUL7zGa6sC4YRthNDMqNma6cPci4kLTKNAxVY3KjtF
 unh2aUt2aFJUPpZ/5Kj6/0cOyWj+Kcwx1gFZPY5pzc7a1lFxtE4WNpmYx5CQi76q3B69aQw
 JNsMYFJ0jQhZKvSaRi0PQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qNJA9s8d16w=;MREgZfBOcuYvsbAw3nmPjZh63RO
 STE5gDCZje4oqY7UJ8xIR2xaLqfKsLN05ag0kyX9i2IrXebmwxOqDlJged+a84k+9w6GTpXea
 gulf5wyrMuWmdngoTxpBBBt9XepA8cF4Ybz9w6nrADfVkAdGMWBkO+ALhekmKyQbaUPR3MTJz
 5v07nSOachnKf1ctnZ8Ajodos21bSpVxxbs0C1rW3InSp2U/JA3IVpvrUAQNPsk08lJmhO9DX
 yx3EhSVbXoTiqIltf93MZNXWNPAgeP5Jqvlkw8W+wMG8blEKyfiBYlyyeoSs2NSv60wgYb//Y
 0tgxXo7CHD9KScyK56EgogvT7RszOX6XbnWONi2CG8ZokJYdYIJw6FRRbajrdZp8FFQ7746wA
 WWbm2bBee3nVGIYO/6pMT6oNObtX/BPStu3xgnZO+0Z0XPvjLuBrsdrzmxELzDfaRlsEdQFlu
 1xgEi0/WXz+hRINMQBcc9u7gM9Hpa9C3kIQBsc0lXhDMxdf1uOUq8+wsq9Sdk5v0wCdHhq9qW
 21ANEpwxjIpNuykUbA19aQQ25eF7alNjgPpbECt9BRXniySyaGjdOz0nGMsrbt98QL5LFpKfL
 PqFu3a6SDpVJf+M8C7euEep2qs9BHZz/PPjFzmWfpMHdwUzwZAJeEdB+6p4bpBG9Fdk+TP7w3
 yttKlYYCa8EpOsppwrsDZy3GuYxe+/XDvDj6wuIh6zFa6llpMpXyLytJAP91YMhr9ZcX99FVX
 UQta/ngggqwfAHNmKS7fLarVnpi5/xeTI/jNAf8DLoosVOWiIZlmVn1ingMcMWn9408LNPMnX
 1OJVG2Tujcxg5VF8mY2g53HTp8gXlay3FjVAAkHmInH9g=

On 2024-02-13 18:20 +0100, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.

Works fine for me on x86_64.

Tested-by: Sven Joachim <svenjoac@gmx.de>

Cheers,
       Sven

