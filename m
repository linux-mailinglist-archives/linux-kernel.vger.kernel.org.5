Return-Path: <linux-kernel+bounces-149953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02B28A984B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C59D1C20EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62715E803;
	Thu, 18 Apr 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8RUpAz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95815E21B;
	Thu, 18 Apr 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438632; cv=none; b=QPBwV3Ww+yWMpjbz56+HgdWVmAgIK+1ewWmc4Pb+Y2hd4VSPJ3jY2A2RIVTREtWvIgCyxDjuR4uzLIxOSMe/Ibfmb6UzUKjudVLVMXgP4tI2WiNFXQ1W+tzaeSWjgfkKZPSDk8129gz8PHsywWE50EBymSD9tt4gG/a3ga14cAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438632; c=relaxed/simple;
	bh=zOHH2X/lpw7NGyKEvIeTY5HrLvu107q7by/WfSVVR6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aBtN3DfFVrl5ts9xGFmXbHniNXj8DQ+iiNGckhmnEm16Fvjk9750Gi1Qo40+80rMtE5gDDRd4fEfjlGX/U07e8kbkvtYCqtejwzLITmBZsjLEZpXC6ewL/upavsjBiBQJok9olwjBI3w4+6yaVCVocewft21VhtA1kSJjgXgKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8RUpAz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93874C3277B;
	Thu, 18 Apr 2024 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713438630;
	bh=zOHH2X/lpw7NGyKEvIeTY5HrLvu107q7by/WfSVVR6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I8RUpAz1dQR7zg+/kkLL6I6I6GZElSYRB6cVVEXdzPPRO7I2GrQFOxqqpJ96NHJ/q
	 FaKhemo08AMamdjT9R6pIGvffLIXsGp0iAOq/gkhNawcWBTt3xb70BtuqmcMoRIIbh
	 9XG5gY6pZ0MiRE6gq5BiiPOUTWxotkcTvQJYr0qoJwZ/2i7gkKJmKU4Mckcrb7i+jO
	 v6m/jz9hk71ocibw/IuGjzXypBvwVBte8GK+/A67vRro++huXP+/nowwlgRKmifVai
	 f2IuqkHQ4wHcNGMWhxYVwlBYrS0LLLil26mnla0CxMLUjg1CAwFfRsZU/VTd0qgxsQ
	 3OHPYMS6JKHHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ED9AC43616;
	Thu, 18 Apr 2024 11:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] net: ipa: header hygiene
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171343863051.18842.5095544708093707768.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 11:10:30 +0000
References: <20240416231018.389520-1-elder@linaro.org>
In-Reply-To: <20240416231018.389520-1-elder@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Apr 2024 18:10:11 -0500 you wrote:
> The end result of this series is that the list of files included in
> every IPA source file will be maintained in sorted order.  This
> imposes some consistency that was previously not possible.
> 
> If an IPA header file requires a symbol or type declared in another
> header, that other header must be included.  E.g., if bool or u32
> type is used in a function declaration in an IPA header file, the
> IPA header must include <linux/types.h>.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] net: ipa: include some standard header files
    https://git.kernel.org/netdev/net-next/c/ff39eefde76a
  - [net-next,2/7] net: ipa: remove unneeded standard includes
    https://git.kernel.org/netdev/net-next/c/8c044024e608
  - [net-next,3/7] net: ipa: include "ipa_interrupt.h" where needed
    https://git.kernel.org/netdev/net-next/c/a53c85f35258
  - [net-next,4/7] net: ipa: add some needed struct declarations
    https://git.kernel.org/netdev/net-next/c/81186959917a
  - [net-next,5/7] net: ipa: eliminate unneeded struct declarations
    https://git.kernel.org/netdev/net-next/c/116061962d88
  - [net-next,6/7] net: ipa: more include file cleanup
    https://git.kernel.org/netdev/net-next/c/f60e5fb6dfaf
  - [net-next,7/7] net: ipa: sort all includes
    https://git.kernel.org/netdev/net-next/c/884122775e67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



