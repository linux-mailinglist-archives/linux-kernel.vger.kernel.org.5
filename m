Return-Path: <linux-kernel+bounces-125559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A98928A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EB02832E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B13AD4C;
	Sat, 30 Mar 2024 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qek4aQUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1EAD22
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760454; cv=none; b=gLlfDOWhsQC2AlN0Vjv7Ds6XwudkYA/VV8CpYOIJ9YP97eMGILj83SOS0cDl50RNYByilCwaUw+fyc7/RLBZWSPvPPZ65RY/eLAzcfi63Q/7ytj8Z+2kWLBeTP56UshlZkwWfkSLU2KneB4D+q8FNLdfvi/TmYnsZ/7tWTcQK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760454; c=relaxed/simple;
	bh=SB7j8kvTH9NRoI/QoVhyjgvW8q8QZckfgiEKfKSpBwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVsroWwqtDNloe2Q3eivWkhObBkAyyr4S/VXAEYUtQSNBlBJMSyb/JsWG7FChRoVMldu7rSkcsCNDFXrnm8wLFrGiQXO8klrIehUMDUpNFhVms7A5wq9JH6aphB+wY3xtTX5zfZkBM/e/xLfH4n5FqrpLZ+sU+NK816aGfR8HlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qek4aQUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5898FC433F1;
	Sat, 30 Mar 2024 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711760454;
	bh=SB7j8kvTH9NRoI/QoVhyjgvW8q8QZckfgiEKfKSpBwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qek4aQUiuNWz+CCuXQ3/bYg0/2hUw22G8C7TwIb6S96ayMSqTVi3HaLD8vu0OFzP7
	 Xr+Oj+T8pKoaCrVPXgH8cEVi000Ze6y3eLgL+j2bgLrKMMTog7cT9nTNczqeZtlWHa
	 +bePIIs+y/N8+tp8itixo1qLus5Lr1uit3cm5mywWsqLVZwcaM2E1ndZm3s6rkBlXV
	 X+fSlKeAmyisxhph0PiC92R2jzQm301Rs0PEpH2X04uVKFAk4uxuA3NXRF2KShPZT0
	 PWo+CrYE2f6b79vq2J/yCaVmqnpwedFtjHSDlwtaCNzixyBCJdlzdLToWqOnYwwxBI
	 E/Njp4TXfNV1g==
Message-ID: <5d4ca5e7-c516-4f0d-9794-f3cef8826f78@kernel.org>
Date: Fri, 29 Mar 2024 18:00:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARC: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240329221432.1658516-1-helgaas@kernel.org>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20240329221432.1658516-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 15:14, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix typos, most reported by "codespell arch/arc".  Only touches comments,
> no code changes.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Added to ARC for-curr.


Thx,
-Vineet

