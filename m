Return-Path: <linux-kernel+bounces-106158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDFF87EA01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E750CB220BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417446B98;
	Mon, 18 Mar 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhrlDmbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B647A67;
	Mon, 18 Mar 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768244; cv=none; b=HXhc1hnyydxCkrdrggKyPllf9Z+bMQXo2q+8J5ZBP59Zw8NxtFwSZJ83WYbv1pqU8DBnND6b8nVrYCLEZFuBMCzo7/aYs9zk9nNocTAlSn14aTOBlpMl6uzIj7GU6g4mm1Eyg8A1WnGeoJg1Lvm92TBaU22l3K1Y9mbMjBrdLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768244; c=relaxed/simple;
	bh=VvX1STzoEKZxI2yXA1AdvH4nP1ml68nJ/w8mL6oc7+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfpzenCtUKEbXYKhZkKir/oPtZKO+Ia4NiAvPbDSS2llh8SOqUczGVx9AnWG4pZ3cXBpY+c5fScN16aquLd+DHdYSqtThZKCg3NW6eXw1Km0KPKP3OglLELNOHDPxvSFn7xmq5wbYSd39osxfR+cgCYZSYwQ0Otar3kuxJEpkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhrlDmbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0516EC433C7;
	Mon, 18 Mar 2024 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710768244;
	bh=VvX1STzoEKZxI2yXA1AdvH4nP1ml68nJ/w8mL6oc7+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhrlDmbe2Fpc+LRtWYzDVl8KZSwIGe4tyop96uk9hSmBFSv4RFibrHCrnrs7vQMiH
	 Vi/i/OW6tQiJ/EDtbRUzrc5f7UJMY9I3aFpRRAaMmIFMbPmdyMybVmPmAT8MGDyVkB
	 Yok8b9hP8eKaoja2qyHRgw+Q+DHokMp3LzaM+QQwNvKdsXkzhC4uYpruk168J2kL2I
	 FrjPHbD2lZ4dlIrumlkza52FFQEHOP7yP84/QYtDJGBjUeJIPGHSPvS6k4tDleZh4S
	 dcWb8ydkGd2radjuF3SBMCNmmiBiTfAdpqQrPwfHXz7RNab09GQFa0yZURmJqAhX0J
	 mdssaL1SnZ4GQ==
Date: Mon, 18 Mar 2024 09:24:02 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Fangrui Song <maskray@google.com>, Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>, peterz@infradead.org,
	jpoimboe@kernel.org, jbaron@akamai.com, catalin.marinas@arm.com,
	nathan@kernel.org, linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.7 07/26] arm64: jump_label: use constraints
 "Si" instead of "i"
Message-ID: <ZfhAcikh8h9D7crJ@sashalap>
References: <20240229154851.2849367-1-sashal@kernel.org>
 <20240229154851.2849367-7-sashal@kernel.org>
 <ZeCpOPDi18OBEclz@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZeCpOPDi18OBEclz@FVFF77S0Q05N>

On Thu, Feb 29, 2024 at 03:56:40PM +0000, Mark Rutland wrote:
>On Thu, Feb 29, 2024 at 10:48:26AM -0500, Sasha Levin wrote:
>> From: Fangrui Song <maskray@google.com>
>>
>> [ Upstream commit f9daab0ad01cf9d165dbbbf106ca4e61d06e7fe8 ]
>
>That upstream patch caused issues and was subsequently reverted in commit:
>
>  a6b3eb304a82c29665a0ab947cfe276f6d29f523
>  ("Revert "arm64: jump_label: use constraints "Si" instead of "i""")
>
>Please drop this; it'll break stable in the same way, and it wasn't necessary
>to backport in the first place.

Will do.

>As an aside, that revert has been upstream since v6.8-rc4, ~2.5 weeks ago; it's
>unfortunate for the broken patch to be AUTOSEL'd now! It'd be good if something
>could automatically check for reverts in mainline...

Sorry for the noise - usually the fixes/revert check happens before
commits actually end up in the queue.

-- 
Thanks,
Sasha

