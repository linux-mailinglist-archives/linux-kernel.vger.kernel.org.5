Return-Path: <linux-kernel+bounces-110449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC07885F13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F5E1F23576
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE76131743;
	Thu, 21 Mar 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnyA4TD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2C133404;
	Thu, 21 Mar 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040043; cv=none; b=UhBxQ16Yvau7xvrm9zhrIu2iEqRxH/SMVN0EhJ1VkX58h2DyVlWCs1uYx2GIv0UanrJgCxu9tTuhfiMBAx2Cu5DvIfy7bj6aWrXbZGVaVYFgakcUYEEQQ193s+y6NB+IC1tXnh5ZhKg0WLA+S2IdmU/LTu7Mt5TuVABM2PnjTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040043; c=relaxed/simple;
	bh=vKjcrD43FFa7nM60wwUAx4/dMdHQVuqCYLcviawXydE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SUxqALc2Pb22R0py/ZFXptM3f9COWGaEe8vrgz7cpbzq0XgZebLqrvMgV8WiXOuNCgTNx6wWNVffolGcZ3fyj9smblsCMzh/veyq2YTY0hIUQORnJ7GwpgLVnd0KIK3Zd94H4CsY2TtLn54Q62gHhuVoEY97q3iGzzO/qd0v7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnyA4TD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B759C433F1;
	Thu, 21 Mar 2024 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711040043;
	bh=vKjcrD43FFa7nM60wwUAx4/dMdHQVuqCYLcviawXydE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dnyA4TD8SOgARZOSxjRq4c+f2LWKm1InIveFkkW24ZDfRYmjYNGWpl8qmCcxOb4yG
	 LUiAwlK9/oghMbAMBbPnLl551VdA//wP5cPnjt0xI8hLCU7mSLFqI8mol9IWBWrAdn
	 QnUvtfrcFb83mCydQuQTje28ZZ2fpZ5CGQnmW3/e3QHCiXrqae5qkk1igMcH98Z+h6
	 OELEdicmshHtdMvNTq3wVlTygIxPD+6amXiJZmTd3sj+aPNXXLoQ6lDMAw4+kMnP1n
	 7v5mq/lKrLxH4Z5Lu+SKU4dkFvE6L2M0/iYN13/zeE8qc/UXcCzfVvcU1xyb49pXqN
	 PoQ30U+99Dcmg==
From: Kalle Valo <kvalo@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as mwifiex driver reviewer
References: <20240321163420.11158-1-francesco@dolcini.it>
Date: Thu, 21 Mar 2024 18:54:00 +0200
In-Reply-To: <20240321163420.11158-1-francesco@dolcini.it> (Francesco
	Dolcini's message of "Thu, 21 Mar 2024 17:34:20 +0100")
Message-ID: <87y1ab8r13.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Dolcini <francesco@dolcini.it> writes:

> As discussed on the mailing list [1], add myself as mwifiex driver reviewer.
>
> [1] https://lore.kernel.org/all/20240318112830.GA9565@francesco-nb/

I'm nitpicking but the preferred way is to use the Link tag. I can fix
that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

