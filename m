Return-Path: <linux-kernel+bounces-25529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D082D1EE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBEE281DD1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE92125A9;
	Sun, 14 Jan 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFnQrDFX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072E5243;
	Sun, 14 Jan 2024 18:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90279C433F1;
	Sun, 14 Jan 2024 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705258777;
	bh=qvi9nETLBaswD8m/wZDVKJ3xr98jjCZHihd1L0QIv84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFnQrDFXUmO30DSgcK8WhOTT/k40IuozJjOHCgBVy6z2Lza6FIkjqKklu8/WUuEZj
	 cqXxHPYyNkJCZs+4twR3wp9MFAcgtchlLpilAuag6E958+SdslvGe80RtFaeaQB1ZN
	 0V8tprL1Hne0hU8gxSP/FgTcHUwnE1wU3qX5TrVqsHGjui2Va12//D+BposyJasOEo
	 VfIsMYzvQbrP3xuqiFkaxytxQJ80chYhN36R/tpw1TXukXS+nePn6umY/TxtPq51OT
	 yPaWsud4UH8WB6SjWc26nuss+GBgWzPvHgtvoHY7sU6ikRQBS/fhfkIs7r2+Pn7SRr
	 ONGuiaYtG4mVQ==
Date: Sun, 14 Jan 2024 13:59:36 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcus Aram <marcus+oss@oxar.nl>,
	Mark Herbert <mark.herbert42@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 3/6] pinctrl: amd: Mask non-wake source pins
 with interrupt enabled at suspend
Message-ID: <ZaQvGNNPpgZ5VCfa@sashalap>
References: <20231226002725.7471-1-sashal@kernel.org>
 <20231226002725.7471-3-sashal@kernel.org>
 <ZZ0xX2Mqx0ezfoWG@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZZ0xX2Mqx0ezfoWG@duo.ucw.cz>

On Tue, Jan 09, 2024 at 12:43:27PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> [ Upstream commit 2fff0b5e1a6b9c577b4dd4958902c877159c856b ]
>>
>> If a pin isn't marked as a wake source processing any interrupts is
>> just going to destroy battery life.  The APU may wake up from a hardware
>> sleep state to process the interrupt but not return control to the OS.
>>
>> Mask interrupt for all non-wake source pins at suspend. They'll be
>> re-enabled at resume.
>
>Not sure what is going on here, but it is queued for 6.6 and 4.14, but
>not for the kernels between them.

Ack, it should have been dropped from 4.14. Thanks!

-- 
Thanks,
Sasha

