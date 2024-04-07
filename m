Return-Path: <linux-kernel+bounces-134667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234EB89B4A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542EE1C20CDE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D844C8D;
	Sun,  7 Apr 2024 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMWsOY75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E643172;
	Sun,  7 Apr 2024 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533584; cv=none; b=YH0fDuUijcrRXoT2Ww7dyT5DBFVdWDbJQRTPQGzG+h4m0N3vkqi1P/7fNIlpiVgcMTBr+dsJZYY5tk1n5m9FJNkoeRQxPIP9VerJVzwNqpkiVri8zXHEXBPvJXvyHozg8iOViK0wokKwljIOsCs4oMIFG1kTEcS1Qd+8oyKGN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533584; c=relaxed/simple;
	bh=u61bII2xsJDl/KUl3dW2WgCWq2w/r3VSINpti3J9G18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiEPpKyuQwylrUEKuhd9ubXjHjnNtaD8foDsiJ891Ju02C9K+RxXxO48NHklisa8zI14Vh4V4whMh6vQL9FJNPsuARHm/bpZJTs/s6o5pU3Pr0WAvHCsLtdhLxlBJSMx/jk+z/Px1e+FB6Ct2zmSKXYf5I6T0HzAcmCETS8qXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMWsOY75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2442FC433C7;
	Sun,  7 Apr 2024 23:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712533583;
	bh=u61bII2xsJDl/KUl3dW2WgCWq2w/r3VSINpti3J9G18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMWsOY75peMAQFLsYAe+74hHH6bVgcTJhvvuM42VKGrVfXlJP15lWPdcOZmmzgcFo
	 3mqd0H3kvSASJBOtGlqR3eVU+Ms2x2vUH10EQ1C7w6LM4R2Xj5ayQfyUf4XygQOs6i
	 UcEsCPMs7an/KkjXOzivt+TZV/0UkinC3z0AWBvv4EjDjetwsHRA16W0WmkP/EdQ5F
	 zVHTjWSUzIZcq52YGR+GfHsUeTyoY76zpqJ4OjdeOWO38DPxSnNAFvPMpUSrZXbmW4
	 gmKergSSgFYNqR575KYllhRNpV33pWepC/n4spMLnRsrarKakK0O9Z9VPu9BtbljWU
	 P7bbIcGUsg0rg==
Date: Sun, 7 Apr 2024 19:46:22 -0400
From: Sasha Levin <sashal@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	konrad.dybcio@linaro.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 36/98] arm64: dts: sc8280xp: correct DMIC2
 and DMIC3 pin config node names
Message-ID: <ZhMwTpveIYSDWsIS@sashalap>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-36-sashal@kernel.org>
 <Zguyil0WVwEudPga@hovoldconsulting.com>
 <730ac728-a333-46cc-aa0c-5e922b3c871e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <730ac728-a333-46cc-aa0c-5e922b3c871e@linaro.org>

On Tue, Apr 02, 2024 at 12:17:08PM +0200, Krzysztof Kozlowski wrote:
>On 02/04/2024 09:23, Johan Hovold wrote:
>> On Fri, Mar 29, 2024 at 08:37:07AM -0400, Sasha Levin wrote:
>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> [ Upstream commit 61474b18e762671a69b2df9665f3cec5c87a38af ]
>>>
>>> Correct the TLMM pin configuration and muxing node names used for DMIC2
>>> and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
>>> improves code readability and avoids any confusion when reading the DTS.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Link: https://lore.kernel.org/r/20240212172335.124845-1-krzysztof.kozlowski@linaro.org
>>> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> This is not a bug fix. Please drop from all stable queues (e.g. 6.8 and
>> 6.6).
>
>I should just avoid names "fix" and "correct" :)

I'll drop it, thanks!

-- 
Thanks,
Sasha

