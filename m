Return-Path: <linux-kernel+bounces-99646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D5878B61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706212823D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4F58AC0;
	Mon, 11 Mar 2024 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzMq/1Pg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934F5822B;
	Mon, 11 Mar 2024 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198358; cv=none; b=NvPH8/xjxOjtJXlkLymY9djN99Gov9O4bLeWbaSvVZMkSlT+t7493nDqwsfFKI0lvjVv6+R3v7KEyo56xLsWMJ0x/i0wB4NUBijOy7kmFNRr6autay9nG7KDcllhK7k+8iqQ7zjFcF3RU/bFc5LYM/cUL955zBgD2r8MnaNinxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198358; c=relaxed/simple;
	bh=EatrB5D9TJSPm3YFnPCenxX91s899LOVNXNp9lcYDZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R73yrlO65s2VijNixat9uCkuOwYV2NBBznUvVAYDFB4FudwOLxB0JIe26LGBliYrYHleG4Wqr3u2EXgy4adedatF7LyzphwPdS1gAyOkF9xIqKGP7G4q+G5xqYEB49bFVQ9zopjteMKrO8pvv6azWM2uIg5YZ0DaWaCdJvZWqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzMq/1Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33365C433C7;
	Mon, 11 Mar 2024 23:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710198358;
	bh=EatrB5D9TJSPm3YFnPCenxX91s899LOVNXNp9lcYDZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IzMq/1Pgg5gY88lOO25I/1MfWii0PtNjbBjIdDG1XL8gdZHoZSjg6162q9sBnlqP4
	 EHVunXQkYyy5HOAXQrAPvOr4W0cylwZbBslbsaBf9RqmvN5xQ8cfcc7sbAMcXQVZvx
	 EmmJXCy5212FyrDWeq1YSAv3u6UnqQkW67uBqkXQEQMKeqbhdaOcAdrW7Yxku5cVUb
	 N3U88cEojFghEOUQo9iTUkOHgPOhdJ4N6RqU7rRjNrXbpexZH7Yqawpv1EGliYY3Ag
	 cVZDsWS2mFkDOqRWclQ7aRY6oImw7Ph1bP3so0RUZ6kBR1+VTBvQhqW7AxjYtS9zCs
	 EtKDSmqY11grg==
Date: Mon, 11 Mar 2024 16:05:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni
 <pabeni@redhat.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman
 <horms@kernel.org>, Wojciech Drewek <wojciech.drewek@intel.com>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>, Ziyang
 Xuan <william.xuanziyang@huawei.com>, Kristian Overskeid
 <koverskeid@gmail.com>, Matthieu Baerts <matttbe@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: hsr: Provide RedBox support
Message-ID: <20240311160556.02da78e3@kernel.org>
In-Reply-To: <20240311115644.823829-1-lukma@denx.de>
References: <20240311115644.823829-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 12:56:44 +0100 Lukasz Majewski wrote:
> Introduce RedBox support (HSR-SAN to be more precise) for HSR networks.
> Following traffic reduction optimizations have been implemented:
> - Do not send HSR supervisory frames to Port C (interlink)
> - Do not forward to HSR ring frames addressed to Port C
> - Do not forward to Port C frames from HSR ring
> - Do not send duplicate HSR frame to HSR ring when destination is Port C

Linus tagged v6.8 and the merge window for v6.9 has started.
Please repost in 2 weeks once the merge window is over.
-- 
pw-bot: defer

