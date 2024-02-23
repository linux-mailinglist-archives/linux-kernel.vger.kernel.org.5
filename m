Return-Path: <linux-kernel+bounces-78619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E028615F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF11F25E00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E48287A;
	Fri, 23 Feb 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mILdl0BO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094FE567F;
	Fri, 23 Feb 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702545; cv=none; b=fs1fWOzwYoMVYKgBvqE4UApz0i8Z4xZ7PxQVfKRRy3gppAYucwM/RBB4PBDgYfU5rg3t1aET6LJ3bG7aFrYsdT1TQ9IjLUaW6Bp0IT7DiMol0l27mdvT+oOGMKnVc1YnF7NT+CVeO+pgsKRWJJr9k0sAGSU3JipEYrLvVjIDGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702545; c=relaxed/simple;
	bh=SXQ3eQ3ao+baIMoqLDm5AXQTKDx9eEFqMrwt+ibBWNw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sxhaAbbB0zxN2FY+wKsy5brXhgLKGZE4pIWFWLg0Y2DVRGslbVtcGtidEkR+rd8vKYO2emYddBoqewb39PCM8AjArU2JFLVL0ph2KxEXSipdWRZm4w9ppovx6O/04jQGohNf18MxrL5NqTP3nEQPbD1YWDkvZLSkKYBmge9Tusk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mILdl0BO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4F1C433C7;
	Fri, 23 Feb 2024 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708702544;
	bh=SXQ3eQ3ao+baIMoqLDm5AXQTKDx9eEFqMrwt+ibBWNw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mILdl0BOCbDrNTcp25KFYci1H/I70C1UIiJ0+qAvSGipfcEN+P2ETPKaaQOYcd8MX
	 a4i1tjkbTK/dGQPSDXW0gPS2fTn9GtngsU41LOVc+7M0+PIaINyQ9DUlUxhYZPpckE
	 ODylk166Z2bG/T6lykplj7bmyC+iR2fLxqO9UPnBNslMxG4yjU7HMg7MPVwZBbfFD6
	 rndTc4ErOQQHi8ycd9IJt3K8Un+AvZZJ3AmcNvknyvsNAnYd/MOI0sts+QUNAjHTw/
	 AKMuDWnxkPAWSLNArz+YnAqvGi2hS1GC/ECK244eQmf9zxs0RkgB4mXTHVgv/MAA4N
	 Ra42+eb+DczUA==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 ChiYuan Huang <cy_huang@richtek.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213165602.2230970-1-arnd@kernel.org>
References: <20240213165602.2230970-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] leds: ktd2692: add gpiolib dependency
Message-Id: <170870254198.1708897.11776260792446922226.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 15:35:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 13 Feb 2024 17:55:50 +0100, Arnd Bergmann wrote:
> The expresswire module requires gpiolib, so anything selecting it
> also needs this dependency:
> 
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - LEDS_KTD2692 [=y] && NEW_LEDS [=y] && LEDS_CLASS_FLASH [=y] && OF [=y]
> 
> [...]

Applied, thanks!

[1/1] leds: ktd2692: add gpiolib dependency
      commit: 52380f87d190e1e3f376f6a01d70bca753e81251

--
Lee Jones [李琼斯]


