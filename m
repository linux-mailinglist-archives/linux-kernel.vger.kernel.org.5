Return-Path: <linux-kernel+bounces-67480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C1856C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14A51C213F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F21386BA;
	Thu, 15 Feb 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj3WcKDl"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C28136995;
	Thu, 15 Feb 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020800; cv=none; b=j1JoCdCGr9KXOBpRmb2X6vG+CpLKzigIbtP4kq+1d2a00KD49nFajw37ajrXIs71kLkv4xXWs89BAQHY24DKh+N4FEnUb7SG4BZrPBU4cWQI+Pk1uCXCCceUdyC1wXCVnVaVugmFXffzjkznoysdWtP4LSs9YJN44zJTzyQZe1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020800; c=relaxed/simple;
	bh=Vi81D9bfSDr+m+P3qTgsqyjlvtqqJ9WpSh3551CARqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqOY/NMd71ez4G8aHWOZ3XOJXAYt1Pp3MgK/SDPldwy7g/rdpNhGc/5LOPH+dm0/bF13o7Tcy7UsYWggxW05atZP+NYIZgtC4hpwaE2g5k35vJVdf4aaB1jj9aksesGFd90GB18UfvPURBlGpJSK12LN8JfwVAbaHq48UFFoJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj3WcKDl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso580491a12.3;
        Thu, 15 Feb 2024 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020797; x=1708625597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=juVCM1rRHSBlSMP/d1mEg6+OxvELnwq4fa4K1QNtEvM=;
        b=Jj3WcKDlTxcJIrqKJ/XI23QzNpFRbAMcSKCGlBX5ZXWywQ+rqXD4zoRuNo6++YuOva
         BDpAvkbOT9lnBFtZhdC4taAIJmkJx97uLTkXgPUmKRRlUzuH4hGUx36F+mchFaPilnYq
         F9AYJiK6X6k3XJF6Dd95Y6QQRWRFnqMcn8WwbqzTf9z/ezH+XlcaQvRywF5lCKK6IitC
         5Lt7qs+YYpXPw4DBgSSZdjYIkn0d7B1qrlz18tC+rJQNJUL8rrhn1KYy8yvByKjG/YDu
         e2Wb7eFMfkdzq9wfZMMzUHeDfg7ooVseT4E4r6QmkbuQqW0Z1li33vSrylAE8XENvF1z
         rvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020797; x=1708625597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juVCM1rRHSBlSMP/d1mEg6+OxvELnwq4fa4K1QNtEvM=;
        b=WAxyiusNxY0CrgoIW0krfWCb/0wUxETzzb3M3JLtdRQ/7c6YB40bE4G9GJkoHHQXWh
         k4FIu+IYRGEqHnnr2OVc2afUffBRLE/GW+xX7A+4K9ioDT9dBv1s0UsVIssRz2l37Y9u
         xz6YEPffLUl7j23SCTCeNyAzcAlxhJLS6z2nNlgVgXItOyl87XVUSp2jkm3FX0dm3MPV
         LpnbOhwwMTIHe90KClZ3JhxyEXFwdefa+OGwUOInzS3ju00VpQ/ndyI0/hYoOMHFOVpH
         1xNChu9RpoLTcqSf/X68g7nDo/M8mraTHAk84NGn7QkM7ERC8NRUGU2bCb6fGFs7YE3P
         jDtg==
X-Forwarded-Encrypted: i=1; AJvYcCVfFi0s2vXZFQxriLbhCDnzvbEgadvJLuAQoiyahipUywvB9w1v0bW4SSiVh3ZJjpI3TJn/s0Oi+BwwhfzZRFDzcn1A0UzpcmhmFEK0
X-Gm-Message-State: AOJu0YzRtrcmypAtJebSJAiREUlTk7PlxSqOq44ytQ9JkHIF0thQDstS
	e108+hdV6L4B7gnsa15N/fFWJsfLIEu3/U7v7WCMerKHS+iAncsC
X-Google-Smtp-Source: AGHT+IGthifnHmAEqhCcEbmUdCkSxu/XDdmbCurctxhen5Mi8VcqjRFROKiGLYJYhV8U36BlXdTjWw==
X-Received: by 2002:aa7:c48c:0:b0:561:4238:e6e2 with SMTP id m12-20020aa7c48c000000b005614238e6e2mr2147942edq.29.1708020796710;
        Thu, 15 Feb 2024 10:13:16 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id z9-20020aa7c649000000b00563819d224esm774517edr.21.2024.02.15.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:13:16 -0800 (PST)
Date: Thu, 15 Feb 2024 20:13:14 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 15/15] net: dsa: vsc73xx: Add bridge support
Message-ID: <20240215181314.nq5zscq2oum44oem@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-16-paweldembicki@gmail.com>
 <20240213220331.239031-16-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-16-paweldembicki@gmail.com>
 <20240213220331.239031-16-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:28PM +0100, Pawel Dembicki wrote:
> This patch adds bridge support for vsc73xx driver.
> It introduce two functions for port_bridge_join and
> vsc73xx_port_bridge_leave handling.
> 
> Those functions implement forwarding adjust and use
> dsa_tag_8021q_bridge_* api for adjust VLAN configuration.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

