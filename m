Return-Path: <linux-kernel+bounces-78728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DC8617E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928871C22E69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1784FAE;
	Fri, 23 Feb 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkYRUySC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DD8565A;
	Fri, 23 Feb 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705730; cv=none; b=m/kxe+ri34L3fLWtjzaHE9Fq76rHhao/85dZiI7Ekx91r7m2glNenUwcQN4QckN9JOZwYCpeUAhK9rxUNWqquMrND2/aBmsuYkeBkw98Wxs1lr/t31pgks4wgu9ssYppraYXxlsV6MZtdEAktfZyl0BrJVXutkHk64DJedRPwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705730; c=relaxed/simple;
	bh=wEGHK2WBxOjfXbevpTQb3aIk60mWJqBlr3ZiHUy36VM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c5LpBTfAdsI0+JtLxfifOIwJ1OiRqv4X3fWl7Q9VOODOD7GBLkxzGryCIGjVzkA0udxsBq7rzNKZTQj2zJi2WVC7WwHSjV9e3FpzzfzajWqFuiG3gTu4wU8x9QfGiKyL3gz2MRmXCxuJ/2qSiSHTFOFxS+VkF1qs/eIJWcHQAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkYRUySC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203AAC43390;
	Fri, 23 Feb 2024 16:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705729;
	bh=wEGHK2WBxOjfXbevpTQb3aIk60mWJqBlr3ZiHUy36VM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SkYRUySC7rIkFog+P2vIgPZHmirWaNLzsVE0UJf5iJ3cwiTt8uvDiENx72N+umzwI
	 7+LpOSjln0PwmN+WL+WJsNu9O54/1X+4a2Efdt6pwBgSdyEzVf4Z2MhV+yypmC3SFx
	 pFGEi1SyLtad8/y+2LEQ+PWe+aC2rJHYaYWN4nxvOv0Yc95mbWb/VfZhCH4WR3yLHO
	 gUiKSg78OTlnbEr8Lg15KyOEyAmA5unW7M0YUxmCU24Or7ZsU7kbVW4GBRc5fvNNA2
	 MigHG6/ia+IBaOYVyqirFWnnIzM9ERex4xaaVYv2Xa1jEmH/NKIjeKcCdd5mV52iv7
	 MbHyGG4dbBDsg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Luca Weiss <luca@z3ntu.xyz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240220153532.76613-5-daniel.thompson@linaro.org>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
 <20240220153532.76613-5-daniel.thompson@linaro.org>
Subject: Re: (subset) [PATCH RESEND 4/4] backlight: mp3309c: Fully
 initialize backlight_properties during probe
Message-Id: <170870572786.1740438.15453067020985270956.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:28:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 20 Feb 2024 15:35:27 +0000, Daniel Thompson wrote:
> props is stack allocated and, although this driver initializes all the
> fields that are not "owned" by the framework, we'd still like to ensure
> it is zeroed to avoid problems from this driver if the fields change.
> 
> 

Applied, thanks!

[4/4] backlight: mp3309c: Fully initialize backlight_properties during probe
      commit: 50a2c0aee92699ed47076636b652f9d27a20fbef

--
Lee Jones [李琼斯]


