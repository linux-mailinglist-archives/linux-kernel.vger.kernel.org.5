Return-Path: <linux-kernel+bounces-45430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83E843067
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AE5B210B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092977EEFE;
	Tue, 30 Jan 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns9OFMOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FC7EEE3;
	Tue, 30 Jan 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655066; cv=none; b=dNotqgnFc+m6RcUv0/41feeHr+C99fIl5ehGTQCm7Jt1zHAjAPGvsgCihEUmaTdFi/DqFG70/OlhRmX6HpXkEIcP7PLVlZQIfkNr5VWnJaSzhikuV4RRU4BZ9jyazvENdP9umoa5A39kBIxvCPeIx0LAhAJcewClhFcsw+RSlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655066; c=relaxed/simple;
	bh=bIrBrbX48HIWDuxq8XoOFI3Dqwa8CFXd3p8UGpUs+hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDJMMH8YC1a2u5uC6wQu9vO31Te3UDXDRaDgkZtVE3yUq83SipY2LhlVxx23S2Pzivg/TOm51dRXEdIxFjqn3AcCG9bnBOkEQKwcDDM+abDk8kH+OWXl20XMlhFz8q9UDau3jyIgxHBFvi0Wq1FphUnJYROKt4Q/o23ExPwDsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns9OFMOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB1DC433C7;
	Tue, 30 Jan 2024 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706655065;
	bh=bIrBrbX48HIWDuxq8XoOFI3Dqwa8CFXd3p8UGpUs+hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ns9OFMOMvY4m35RdXyZZwO5clfUmNSQQD/3O7Gn7YKHhGxm9ANHX2Fy4MKhPosx+d
	 DCdL+z/O5vcvwWiKWOd0IZSVU4T2Zv80+lfnEDuIXeOfGGu1DS0Hq0GSIHd/mq5Yyx
	 d4CXaYcheXxYhOKHRQOlzt4mT0C3ZAgLl1yK7oF407NxGoufqRfX4pUXlXDc+bLhhm
	 j6WLCH82X4Nxw13/73+o+bYO7ViW249SAckIGkF0YH9FKdqgNeKqcuKVPUx2cit0Ji
	 6WLz8Tdz6sOxVVIi6l2D58JGDVvKK3/1nm2Mx5Bq/ldj5Wnbno/pBlt+88atebJZC/
	 53FOgkz6Eno6w==
Date: Tue, 30 Jan 2024 17:51:04 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	duanqiangwen <duanqiangwen@net-swift.com>, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, bhelgaas@google.com,
	maciej.fijalkowski@intel.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 050/108] net: wangxun: fix changing mac
 failed when running
Message-ID: <Zbl9WNs5qfcRD3nK@sashalap>
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-50-sashal@kernel.org>
 <20240116173955.57ba27f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240116173955.57ba27f3@kernel.org>

On Tue, Jan 16, 2024 at 05:39:55PM -0800, Jakub Kicinski wrote:
>On Tue, 16 Jan 2024 14:39:16 -0500 Sasha Levin wrote:
>> in some bonding mode, service need to change mac when
>> netif is running. Wangxun netdev add IFF_LIVE_ADDR_CHANGE
>> priv_flag to support it.
>
>Not really a fix, more of a feature ennoblement.
>Let's drop it, we don't know what it may uncover.
>
>We should probably start complaining when people use
>the word "fix" for non-fixes :(

I'll drop it :)

-- 
Thanks,
Sasha

