Return-Path: <linux-kernel+bounces-141392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6FA8A1E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D52B29509
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1FB14F117;
	Thu, 11 Apr 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tji3vN2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5813FFC;
	Thu, 11 Apr 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855996; cv=none; b=Hts7SzR+WDh4gFIcb3vrgQ9AAdUSArfrqelRjG/oiS4OgdJDUdluDlD/gqQ4q+GS76Y6jmSZ/1sdf6Wc7pTIkQVUkLmDLzH1V2IbruZldTSXyQLA2PScrOe1+I03dFOZJFMJxgch8Xv23sPqgpY3XBKoErBwdYqq7p2uLrrx6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855996; c=relaxed/simple;
	bh=g+rh97gXhMk7bXFHOvAUpa2M3brb+cjQoTQ9MIbLCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tShFLkLJiHDlGghOxC8T83A4JEXt0fEzf2+NgtX8YwKNmSlLcvwS8EkLSrXEjsgMCw0ZLgwSIZQB435bzBEjxE2zdPSYEVC/nJFtzUUkrggr5T1eIDHgGtc3QcOX09JLAg4CoHs1p1gpR5qdVEo257OCdFu8YVoPgV7xAvLkA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tji3vN2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7033C072AA;
	Thu, 11 Apr 2024 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712855996;
	bh=g+rh97gXhMk7bXFHOvAUpa2M3brb+cjQoTQ9MIbLCXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tji3vN2A0ZpRs2aIL/PtCnQE4u2NF6LV5mPjjWudnrt2SJDA7ALoNZLq/skSsL8Tc
	 JJcgqIwkC6n0CM1gBGpZAHy71Wq9ambX+usqo7qcgkm4mQWp/ykpmFJGKk//pw/LV4
	 QFUvuf+8B8lxuyun3gV7k18Xx/HOmzgqctAQl4OJJHzG/ByWdeNiLdeub7TEJ0osAp
	 8i3n3c8MoUn7dQRWnrtVcdJf5enTRM2vffIzM37lW3z+iAwS//o1XiHXiL8p+ETjhm
	 3csUfxH33xi7MAC6lwL+mfJXfKE74lcE75+yqN/ILFJ6gtHYyEGVJJv+3otPdkrlwh
	 rVoRMPIwgebXw==
Date: Thu, 11 Apr 2024 22:49:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] soundwire: qcom: allow multi-link on newer devices
Message-ID: <ZhgbuL2GftDFrBHw@matsya>
References: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>
 <ZheyJ5PORudx9gsK@matsya>
 <5cad6693-8a76-4a74-92a0-00a0818b5210@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cad6693-8a76-4a74-92a0-00a0818b5210@linaro.org>

On 11-04-24, 12:10, Krzysztof Kozlowski wrote:
> On 11/04/2024 11:49, Vinod Koul wrote:
> > On 05-04-24, 16:41, Krzysztof Kozlowski wrote:
> >> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> >> over two Soundwire controllers, thus they need a multi-link Soundwire
> >> stream runtime.
> >>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: alsa-devel@alsa-project.org
> >> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes in v2:
> >> 1. Only rebase (slightly different context)
> > 
> > Applying /tmp/v2_20240405_krzysztof_kozlowski_soundwire_qcom_allow_multi_link_on_newer_devices.mbx
> > Applying: soundwire: qcom: allow multi-link on newer devices
> > error: drivers/soundwire/qcom.c: does not match index
> > Patch failed at 0001 soundwire: qcom: allow multi-link on newer devices
> > 
> > This fails as well :-(
> 
> I just applied it on v6.9-rc3 and next-20240410 with b4. No problems.
> 
> Did anything change since yesterday next? Can you point me to the tree
> and branch you are using?

Thanks for the clue, my tree was in a bad state, reset helped and the
patch is now applied

-- 
~Vinod

