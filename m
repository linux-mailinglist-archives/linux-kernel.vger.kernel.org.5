Return-Path: <linux-kernel+bounces-128819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCC5895FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08387B23581
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F043DB9A;
	Tue,  2 Apr 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpZHpkGe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5541D6AE;
	Tue,  2 Apr 2024 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099515; cv=none; b=JoMmVlYbHK1yiOfZWl7czCVecWqDKvMI4tWzvVf0s0ZCYBX7NHQ1CW5XfJ8nhZhHf0D2EDI8uyd6gLGU6BUYSC/gKoGcKinkor+qXS+GxB/94Ohs4lkGBkkVWu2gnlaH6fVbSbGBJcpDga88o2d3AtNdQTVOGACJgXu7E4wPjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099515; c=relaxed/simple;
	bh=m55o02E9LkyQVajq04E2Kh0e19YI8Iuv5LdATvq3Bbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKWnu5Lqflg02z6uaPtbKngFM8x44kpGSg4rIZ5fvyOi0+p33BYbTHRFg1nLH8BAFncqQUotSlR70tmLOoAvxGOH7W+PHfFjm4YlHMNi8lLBeh+ZQep8M4hyyhekI6IKegP4WhpC8GDVAKS7PVn943yT+QxvKDUmyzDBMziuSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpZHpkGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5C9C433F1;
	Tue,  2 Apr 2024 23:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712099515;
	bh=m55o02E9LkyQVajq04E2Kh0e19YI8Iuv5LdATvq3Bbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpZHpkGeyx5IbInhRBM7YBFoDSxOjb2x+MtF3KHWqUtgSc54FCaRGwNWh9xAcrivI
	 kePYY2oPT8hCtBb1eTf87gqxJWtvScCqCSlnICZq6zGDlLw7IvBhrsEq4cPKNWOD+l
	 wX2aZHA/P9d7zbNJZMddoj7X9IIl/rcwMIcJOj3UPKYdkyEEs+PAn0rySThAqh5uLa
	 RyUTw4WiXJ83GCLsOPcPvYeL94JRL7AxOd1F/GoUmNjsAANe4an+/sQiBqcAU+TmB8
	 XmhNjG1u1VUAbsJtRXrPQGEXqQSWinz1qecV9499omuo+bw8uWMf4+QrFZmW8ILlKb
	 92yQVjnpUSZPw==
Date: Tue, 2 Apr 2024 19:11:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 5.15 110/317] arm64: dts: renesas: r8a779a0: Update to
 R-Car Gen4 compatible values
Message-ID: <ZgyQu4X6Ah6HCEA9@sashalap>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-111-sashal@kernel.org>
 <CAMuHMdW9yQsq15Lc_uqULw4LXAzrKwOZe+KCGLrCkiFG9kuVnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW9yQsq15Lc_uqULw4LXAzrKwOZe+KCGLrCkiFG9kuVnw@mail.gmail.com>

On Tue, Apr 02, 2024 at 10:57:41AM +0200, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>Looks like I missed some things in my previous review...
>
>On Mon, Mar 25, 2024 at 12:36 AM Sasha Levin <sashal@kernel.org> wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> [ Upstream commit a1721bbbdb5c6687d157f8b8714bba837f6028ac ]
>
>This is not the corresponding upstream commit for this commit
>(a022251c2f950cd2 in v5.15.153).
>It should be a1ca409cc050166a9e8ed183c1d4192f511cf6a2.
>How could that happen? Interestingly, the backport in v6.1.83
>(efab55e16c55c637) does have the correct upstream commit.

I suspect that this is me fat-fingering it in an attempt to pull it back
to 5.15 when we had a conversation about it on the mailing list.

[...]

>The Renesas MSIOF driver in v5.15.153 does not handle
>"renesas,rcar-gen4-msiof" yet.  Please backport commit ea9d001550abaf2f
>("spi: sh-msiof: add generic Gen4 binding") in v6.1 to fix that.

I'll grab it, thanks!

-- 
Thanks,
Sasha

