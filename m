Return-Path: <linux-kernel+bounces-87214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F6286D131
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD01282FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78AE757FC;
	Thu, 29 Feb 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr8/Jfvh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6C757E0;
	Thu, 29 Feb 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229241; cv=none; b=SQSTOgchvdSHrUB52E6YbVYhnsmlhv/RxbYlkex8F8VKtZj/9/MwceGApAgNzAdhEw3TSCFGwmu4xq//M/9Zt/vJKopbRtImrkuVnlYao7BQmsCH1cL+5Yc0Wwh9sdDwmizbJjIxYTzSr4s6+uHwUyiEy97kRcC8BTPVYmML/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229241; c=relaxed/simple;
	bh=YZUugaEduJPIO/IC9rc3iYrlycRDsvBkU7qZKHaKvgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EGLAd4jUN2jv9dww527KsPvjFucPsU2osqSutrJ1MI5eNa0hjAFfHBQHWXF1XNxV6MyvWRQpIgSlPfmenErEWW6sj/df1OuUci7b5F8j0Jsp3GISbtaDedONDbAG9MgnDK6mdN7WAtMdEW2f4RSJaaTwzuWvWtNoM7lY0prFCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr8/Jfvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE7BC433F1;
	Thu, 29 Feb 2024 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709229240;
	bh=YZUugaEduJPIO/IC9rc3iYrlycRDsvBkU7qZKHaKvgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Cr8/JfvhrEDDLHHfKmXDzD9ejGpeFWvUkTzOZuy8dyBsXdsf0pLX6FBGyfllDT06Q
	 fkTo1pllCwqzyXmq5t+lGEK51DjQrbMraCcWqz+sBM3cLhEZgKWJ1c4fKdRtun5zjp
	 pYb3qC5aUTmLPI0FPWRXYozxahm6MPCub31ZQTJ2kPqTC5PG5M6SabkfrRIhJ9ZUWx
	 wuA5bjXP1zd9KjCo2hzNTfzXhBUDkKzQulXB0E8tL0S2qbERmcH84b6ny0vltAYqym
	 TtxyiBNfHq2X1eWk5zCBZbU/tO5kbPS0mAphaVyIZ4DCjsYTIIRzeZ/Aj5WT48v5G5
	 z53aXAx0YWJpQ==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
 Vadim Pasternak <vadimp@nvidia.com>
In-Reply-To: <20240229071931.7870-1-rdunlap@infradead.org>
References: <20240229071931.7870-1-rdunlap@infradead.org>
Subject: Re: [PATCH] leds: fix 3 drivers' kernel-doc warnings
Message-Id: <170922923928.1633364.16208391297690612084.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:53:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 28 Feb 2024 23:19:28 -0800, Randy Dunlap wrote:
> Fix kernel-doc warnings in 3 leds drivers:
> 
>  [PATCH v2 1/3] leds: lm3601x: fix struct lm3601_led kernel-doc warnings
>  [PATCH v2 2/3] leds: leds-mlxcpld: fix struct mlxcpld_led_priv member name
>  [PATCH v2 3/3] leds: mlxreg: drop an excess struct mlxreg_led_data member
> 
>  drivers/leds/flash/leds-lm3601x.c |    3 +--
>  drivers/leds/leds-mlxcpld.c       |    2 +-
>  drivers/leds/leds-mlxreg.c        |    1 -
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] leds: lm3601x: fix struct lm3601_led kernel-doc warnings
      commit: 5edfca391c5fb2fa12c438aee5ccbe0b22713f31
[2/3] leds: leds-mlxcpld: fix struct mlxcpld_led_priv member name
      commit: 0e225365753c8824b720588252458be87a0841a1
[3/3] leds: mlxreg: drop an excess struct mlxreg_led_data member
      commit: 5764ba63b4256008d59d178dfbec9851cf9a7b92

--
Lee Jones [李琼斯]


