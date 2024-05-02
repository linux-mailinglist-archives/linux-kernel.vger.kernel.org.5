Return-Path: <linux-kernel+bounces-166761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA51E8B9F29
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659B228A126
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9C16FF31;
	Thu,  2 May 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCq+1a3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6916F919;
	Thu,  2 May 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669331; cv=none; b=NWCmnlQG1OACY4N0pA7Fd1nPxVBdpBOPJfn9POgdxwIOIdj4vEEkFdloczUw/1mK94E4lEZcqtZ4RpoUzEochheh2xswEag6Q4uieoUqiWi4TAtbSCjyOLdAww3DoEU6yc4myDiS+ckz+IGbwiOIpas4vuktoMzMT4tv2O5FP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669331; c=relaxed/simple;
	bh=dzcRh9vvoHLf1Dofq5gdOS3EEFs6BfZ6FAKB4VmdUYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5btzhLMRb0xpyE6FE9MlSJcyoZJl1Seh52XPZBzjUgVl7Dr9xnetT9zuivivd+puLhzKMCFN//t9SoxjpKI/MHLVPKnFu0es9aRqKbl/PUJmh2Th2j2QoBjh0aoRvEfaTni2/FvwIuUlzdXw1JeETEncIi7l/VK3wSr1DItu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCq+1a3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8578EC113CC;
	Thu,  2 May 2024 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714669331;
	bh=dzcRh9vvoHLf1Dofq5gdOS3EEFs6BfZ6FAKB4VmdUYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZCq+1a3zx8lx1nBHOmEWj5jZvQwUMjow8Pk1H4J0n3YPgg9t1X56ddYpLljGT3XFu
	 3KkAo7Y8/k/HNRYerPeJ8xmRTqWObb45GIKK/GeKmVWxM7YIb5T+m3S977jhOU4nHi
	 EK9+Js/+lhz6genY3dIt4ElFTvo8aWD15XpjDoeDAsFE+98XmDUelx7XxV+KJi7Chd
	 Gc9PPgrJBBsg5WtEOmgBpfcnKQ0fD0ejAiDML/K82UNtA5FnQYIVw+nSR3NwLbXUhm
	 kcRV7EIEXAKf+fuELX7AqrMspHcyBQ+LziyizM2XTcwSUDPJv2bHj5tuo1sIf5tsui
	 Yq1ucS/yca+mA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
In-Reply-To: <20240417153846.271751-2-u.kleine-koenig@pengutronix.de>
References: <20240417144943.GA2399047@google.com>
 <20240417153846.271751-2-u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH] leds: pwm: Disable PWM when going to suspend
Message-Id: <171466932928.1214296.17132644352212078458.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 17 Apr 2024 17:38:47 +0200, Uwe Kleine-König wrote:
> On stm32mp1xx based machines (and others) a PWM consumer has to disable
> the PWM because an enabled PWM refuses to suspend. So check the
> LED_SUSPENDED flag and depending on that set the .enabled property.
> 
> 

Applied, thanks!

[1/1] leds: pwm: Disable PWM when going to suspend
      commit: 974afccd37947a6951a052ef8118c961e57eaf7b

--
Lee Jones [李琼斯]


