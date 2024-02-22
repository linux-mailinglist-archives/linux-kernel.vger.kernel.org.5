Return-Path: <linux-kernel+bounces-76513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6585F833
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475511F26A32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051C560DD5;
	Thu, 22 Feb 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnvJ6qYY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B460BAB;
	Thu, 22 Feb 2024 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604999; cv=none; b=hcghllMH2mkrsGMV9qpSA3biPIRG/deh1FBjBpqNwGucuqHcJg12w3Ujr1gT1srfj2hgG/t9ggTSM/GbDQIsLlJUMLtsYArYSIokfwwxTj2Vi5dtsvRsov/zk2PkrHI7zZO05GbopZM6ctEIunWUiPX6Q5f9ZgOFtHP8NNExVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604999; c=relaxed/simple;
	bh=HJIZQiDobf5GxOwMaLIptvld+RatnI/3K+JbnfdVwzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqVuG4cJ4z7GYN+NvQ22Sy6w55cHAW9ffsXskBIMV56yovV6mi0jh0sE2E+TVI1tKpnR/7+/3ba8PJGkjOc3VtO+CQ8faXf9zLUztFXjIv763dS/kfkDks7HJ9hSUFNKJbrQ/XWnPk7+mWKEGeZWcZBtQMiI7SiCLx41Ae5kZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnvJ6qYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD46C433C7;
	Thu, 22 Feb 2024 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604998;
	bh=HJIZQiDobf5GxOwMaLIptvld+RatnI/3K+JbnfdVwzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnvJ6qYYOLeVoKfveH91sfsUv4Aqc9QDaj//vVCMo6S2qg+13cO4nIVAJsnwMjs4+
	 nbqdnsa7BCVoTajiZZsxYQ26uIcl+4mwmtqrHQeZVuTUIbiexKM7ustMujn/SRqDYc
	 JzQISeDOcRGwtjjNFJWujyf+afGySG/Uh5vBqq70Oz+5yXJ8F0pAzGKKaLt3Hd/ACb
	 xnm7msWQ+AGdtAEE6xTVknCVpO2t5eB40vQGXWfYrqVzhf39nDi3SeH0QU6w4Tq0R7
	 LksmBG7Uj4J5ea5d3NXlakAdln8KNbMXlGndzfWAV5RLP7d8sOSEEYfm17Qg1+KSDL
	 lD4kAPJP4cYkg==
Date: Thu, 22 Feb 2024 07:29:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 07/44] ASoC: codecs: wcd934x: drop unneeded
 regulator include
Message-ID: <Zdc-RtG4-FXYIkxk@sashalap>
References: <20240207212142.1399-1-sashal@kernel.org>
 <20240207212142.1399-7-sashal@kernel.org>
 <ZcS9EmcM1rtsNYy0@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcS9EmcM1rtsNYy0@finisterre.sirena.org.uk>

On Thu, Feb 08, 2024 at 11:37:54AM +0000, Mark Brown wrote:
>On Wed, Feb 07, 2024 at 04:20:34PM -0500, Sasha Levin wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> [ Upstream commit 35314e39dabcfb256832654ad0e856a9fba744bd ]
>>
>> Driver does not use any regulator code, so drop redundant include of
>> regulator/consumer.h header.
>
>This doesn't seem like an obvious stable candidate...

Dropped, thanks!

-- 
Thanks,
Sasha

