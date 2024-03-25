Return-Path: <linux-kernel+bounces-116655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2188A1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6CF1C38732
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22974E1CC;
	Mon, 25 Mar 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb+Kb+V1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778486AC6;
	Mon, 25 Mar 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352093; cv=none; b=tVjcr1F3jWCKb+oDo6t1mhQ4CdSNzVADQcxUuoicda4w54XAqvCeLFg78FWh68LSWSEr1vhF2XhmIq708kl18qflcZWj0F4WxMKJ9lY98p6PFC8A4PVMHD5s6AIp9mN4K1sR/D0g9IPnXooIIlh9+n8Ex25iYWS2yRGPOq7jegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352093; c=relaxed/simple;
	bh=YLL8wyThsoNIzlB2gYOJ685aw65IkgO7LR8Ze3FY1ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6xYVJvdKCOkwR6ijPDkVPI7jhVZ+NndFbbj6CQJLu+hHGefqsvuDWaZypio5NRgwqiWk1NoicsLxVobltbKE0W5oZ8W+j31xu38CqFmjHwowYEVbmXy8aQfCxFdVB9mxr/57NNOTS3QFP7asWYEcc1ZCbDXUi61tIuM4RD1WAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb+Kb+V1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C461AC433C7;
	Mon, 25 Mar 2024 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711352092;
	bh=YLL8wyThsoNIzlB2gYOJ685aw65IkgO7LR8Ze3FY1ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qb+Kb+V1uZs+nDsPawvQlcbPyZELFxSaAxxlVXTdQKgth8JBH+lHdF06KdKXXv/Sh
	 jXBe6lGhyJkYdCNmqbZCKSQzktnG8gC+qH33JWLAltPI54IccD0K0bCANY9ZvKZEkt
	 zrU/61rJvSV7pJu6Q3iKYejwk2CpWMbEQMaQqS5McxwByx3ImPnbscYchVlhhPfMVh
	 ZvimcuQBcT1wP049e4wXnuO10KgiraJW26UccQKz3Ei90tloWREQnGIozaVYobnClB
	 jm69wsq2/XuMS9sqbpazPm8HNSbC3bHJNhsWWvVP26asSKybOmtKQ3klxUQ+twyffT
	 TZmch5PyUnCgA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1roerD-000000001iI-0JtJ;
	Mon, 25 Mar 2024 08:34:59 +0100
Date: Mon, 25 Mar 2024 08:34:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 6.1 130/451] arm64: dts: qcom: sc8280xp: update UFS PHY
 nodes
Message-ID: <ZgEpI31-OJkNchPF@hovoldconsulting.com>
References: <20240324231207.1351418-1-sashal@kernel.org>
 <20240324231207.1351418-131-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324231207.1351418-131-sashal@kernel.org>

On Sun, Mar 24, 2024 at 07:06:46PM -0400, Sasha Levin wrote:
> From: Johan Hovold <johan+linaro@kernel.org>
> 
> [ Upstream commit 33c4e6588e4f018abc43381ee21fe2bed37e34a5 ]
> 
> Update the UFS PHY nodes to match the new binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Link: https://lore.kernel.org/r/20221104092045.17410-3-johan+linaro@kernel.org
> Stable-dep-of: 1d4ef9644e21 ("arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

As I already pointed out once when you added the patch, this change on
its own breaks the driver and must not be backported. Neither should the
Stable-dep-off (similar for the other Qualcomm SoCs).

You acked that mail, but looks like they were not dropped from the 6.1
queue.

Johan

