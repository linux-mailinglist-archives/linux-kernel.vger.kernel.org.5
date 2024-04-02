Return-Path: <linux-kernel+bounces-127502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86096894C92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7581F218E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01203D0C4;
	Tue,  2 Apr 2024 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSsCwMxz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193553A1CB;
	Tue,  2 Apr 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042637; cv=none; b=hJqaEr/p81RqfnWnnYFjucqqNbP5/4d3Z3RrR5vNKdJKgoivUkPjOdfmzebDP2P0hHrXirSTPbjrvap1ih7Ia81jiUPAhvuHPwlwKiDVMjzH/ZRutmKMDyOiHh2+GNDsT4Hgz74bo8ybfqaEKb9qFU+fU0mqSAPPwHvXwGFvzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042637; c=relaxed/simple;
	bh=/k8682TRmouJoXcVHje6f0bVVq1K2vQIKjhlfsY1dZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNQT36thzN8ZLtLVk5Y+nZ0fFtfZOrkC6XaL0UNOse37pAFOTIuBiMUykdMDz+83c+/MXJOxj8eLEBf0OiC2HZ4WKzOBsvKI1ETGobZ+sOeztDOZ2AxXw7NkxNqOM0gXpsQbaQF7wPKg/dfsCpsluuV59FXDkb/HQQBO1ZnDEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSsCwMxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D05C433C7;
	Tue,  2 Apr 2024 07:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042636;
	bh=/k8682TRmouJoXcVHje6f0bVVq1K2vQIKjhlfsY1dZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSsCwMxzo84q0Mef98yGQ/v1X6jYcd3uTUF45SGemMQ2/ENutrtsmIgRADPnFSOHs
	 mPBLL59usZGk68eqSpnaBlLVRoEKhWoWTX89JqYTm4/ILbhamjs2JJd0PcD3ggdbDg
	 IxVbWtpfeEMAtE46wCmRfQwdXe6asVbbHODj/taeRC5DP5jYGEBfFi3rqEeM0PMqyI
	 I75WGYwHvwrMNrE3cbI81iDrCx5l/IiiO998/reNljRElJoxIsGiveAE+HuVo9AkDs
	 jon5UejQ3pFFMhZuRTp//1r4/Dg478W86/m9n9imM4dHeCdicn4XMEe3jwUaE2PQoV
	 RYX1yxtOh180A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rrYUs-000000004KE-3RU6;
	Tue, 02 Apr 2024 09:23:55 +0200
Date: Tue, 2 Apr 2024 09:23:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, konrad.dybcio@linaro.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 36/98] arm64: dts: sc8280xp: correct DMIC2
 and DMIC3 pin config node names
Message-ID: <Zguyil0WVwEudPga@hovoldconsulting.com>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-36-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329123919.3087149-36-sashal@kernel.org>

On Fri, Mar 29, 2024 at 08:37:07AM -0400, Sasha Levin wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [ Upstream commit 61474b18e762671a69b2df9665f3cec5c87a38af ]
> 
> Correct the TLMM pin configuration and muxing node names used for DMIC2
> and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
> improves code readability and avoids any confusion when reading the DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20240212172335.124845-1-krzysztof.kozlowski@linaro.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is not a bug fix. Please drop from all stable queues (e.g. 6.8 and
6.6).

Johan

