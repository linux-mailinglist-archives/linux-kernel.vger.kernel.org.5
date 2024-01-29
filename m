Return-Path: <linux-kernel+bounces-43446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4B8413F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CC2B228EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F37602D;
	Mon, 29 Jan 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7BUNc3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3476C96;
	Mon, 29 Jan 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558456; cv=none; b=YDHV1uuz1rv16MLQfgFqmyyN6p7ZR0YqvdjK5QwJpJN6ObOq6TJip+S/TJ7ctVGOt94IQN1cRKlxBtk3r5dFlbByGiby6XhGePcMu3epqJz5DFb2Hw+8SJY+TdnlYIR3+G4+XxAntKM8t3SzisdmnP2jTC3M9O9kSwPPFs7Mxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558456; c=relaxed/simple;
	bh=5peBRijJCjJ1vS+5UErLapIuiN+4QR8bM504orhntSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLncfLo5CvA7/UU6p941uPjDyBWRV2qBu2aKpbVLt20OruVzuUwwgUR7KOhO2CYgdHllEPm83qRr8K1O3GXJrOlHDmveyuoyyUvB4mAOwxu7P/nmjTVX9x/d0Y0WAZSiI2vqSeeJMTCh3gnbtbHxUjERe+v7RuFZ/hOlMu4hJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7BUNc3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAA0C433F1;
	Mon, 29 Jan 2024 20:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558455;
	bh=5peBRijJCjJ1vS+5UErLapIuiN+4QR8bM504orhntSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S7BUNc3Sggs28B8IFRPNJxvph4I1PxmHi5tXgbjknZz3IlEYOviktc62/8IYzK/Lf
	 YnBeb+ADZYfgZKPuzJ8Qs6jjgAoh/1HpGccHBdcIKJ5VKpYNIqr/zLVbh3g8OWWbcR
	 d09PkbiaKAwSClxQ1Ki1sKd4MkDoH6wDWQPSuRx0vcAbTyuAX+VhfYKMyQbAIoLvb5
	 QyTgxgIuEMvxGw8699l48aBzeJlEqS2TjjwoYr15D6AUYBMCAIUsR8ifZmzmGNRXKP
	 1Ekx8tp7EfaQYUHP5naVq8mDM2v6kAkcGfdn90xRO+CtonYIv3B0n5Q0j8ajmbWLn3
	 8Wk1++iNnZsPw==
Date: Mon, 29 Jan 2024 12:00:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 00/10] Fix MODULE_DESCRIPTION() for net (p3)
Message-ID: <20240129120054.59a74fbf@kernel.org>
In-Reply-To: <170653082818.17887.7212554013876260614.git-patchwork-notify@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
	<170653082818.17887.7212554013876260614.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 12:20:28 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:

=F0=9F=A7=98

