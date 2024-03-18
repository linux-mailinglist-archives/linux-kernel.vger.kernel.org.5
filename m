Return-Path: <linux-kernel+bounces-105635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5487E1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C51C220F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F61CFBC;
	Mon, 18 Mar 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnwkgakV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71EF1E871;
	Mon, 18 Mar 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725887; cv=none; b=u9EiBXka2q2hXXWbC1fjO7oagRnnDRsCBZclbhlrUhZR87A1xFwyUqq35OTxIF6jyKKqaah8ikmIhDDZnWSeAMSE4SZsbnemyd9486bCU5uQq/NnJdZBBLpNg6HD+92mXACzTNBgCC2yzDTW1GH5WYBA/h1ojpdqw3EFgMcqHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725887; c=relaxed/simple;
	bh=abbct26wTrMUyltc8w8vDKXfu7lI92WSLNvjqZxdqwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujis0zaBnVB2nsVkyErqAOd/rRl02NJC/TF1S/IfuRasAj8/RaPmuPzXYGh2rkQBnhn52wdekkmpJmE5svlN9RibZI3AOujTemm+SNJtnpJEKcYXJMi4hGRC2Wg36kn4YNO9Pn/DXPGiVpcnfCsLEL9+gTA5xvZwI1Rz31RcegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnwkgakV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5ACC43390;
	Mon, 18 Mar 2024 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710725886;
	bh=abbct26wTrMUyltc8w8vDKXfu7lI92WSLNvjqZxdqwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnwkgakV55W6VZ7b1kTW6Yxd2aSZyPC16MJntBf/ACuyI00RQNiEdu4ZgL6MWw6sg
	 w7YU4u16BfmEcGoGaMUl64UsvqKCLXeY4xVpypfi1q8P707qchFO95nxRA4uL37vOg
	 Id++s1iGYliVG/1kfmn5l7wWKkG6WoOCHMCt9b5SypNqOeuY8kfUHJhNrrV5ALbLHW
	 WRLpK0EmhkwYoGN+z3OGWSGQQuBNkPs4aha9brBvOS4dP3OBzkdzOIXyK8ubKWAw5N
	 4HOlh1uEkr6CCdNgtasSd4Vi5l+JFJ7jDdNP0GpT4iUIuIhc0QKdW83SZBAvgznnjO
	 ISgBpvNtVqxZw==
Date: Sun, 17 Mar 2024 21:38:04 -0400
From: Sasha Levin <sashal@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, andy.gross@linaro.org,
	david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 05/14] arm64: dts: qcom: sc8280xp-crd: limit
 pcie4 link speed
Message-ID: <Zfea_Ksyo1kDbcqx@sashalap>
References: <20240311183618.327694-1-sashal@kernel.org>
 <20240311183618.327694-5-sashal@kernel.org>
 <ZfAJKTvQFtoZ8SSN@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfAJKTvQFtoZ8SSN@hovoldconsulting.com>

On Tue, Mar 12, 2024 at 08:50:01AM +0100, Johan Hovold wrote:
>On Mon, Mar 11, 2024 at 02:36:08PM -0400, Sasha Levin wrote:
>> From: Johan Hovold <johan+linaro@kernel.org>
>>
>> [ Upstream commit db8138845cebcdd0c709570b8217bd052757b8df ]
>>
>> Limit the WiFi PCIe link speed to Gen2 speed (500 MB/s), which is the
>> speed that Windows uses.
>>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Link: https://lore.kernel.org/r/20240223152124.20042-7-johan+linaro@kernel.org
>> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This one was not marked for stable and does not need to be backported.
>Please drop from all queues.

Ack.

-- 
Thanks,
Sasha

