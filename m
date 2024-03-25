Return-Path: <linux-kernel+bounces-116660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B316688A20E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BF281173
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571F1AF8CE;
	Mon, 25 Mar 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOXKaIMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D812CD80;
	Mon, 25 Mar 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352570; cv=none; b=Bw+0DkMLn/xreP19DztqbKusfxv2AAHFxdD6+SGhEnAgAVj5kgu1aE09Z/++2CQn4h4ab3bUJkar8Cx5qgP6uXZcS0TKwNCKYenrrvd3gVhGEFd2wK80MqR3I2Fmi+ScghBoFiBmajIqF889bxC5vJWUnDutnpJOvBu9v5ooUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352570; c=relaxed/simple;
	bh=RWfkuRN0X+C0bbZNf4OcFVxtl6l9vXxG/jRERy0pc1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUaiWljRkR+Kj0OQiLvW5wijBB16Fol2so8J8UmH2tQXUeBNhCyVzyTwTOUJrMXV7UHFU2umLqHSgnjvLCzqnIwiVvcvz1dFrk51SIrgf7EIj2A1QnJWZAV7Kjw4h3SSo0G9SKjoqo9NLedtukH6jv+j64yvzeafbmFPd63OQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOXKaIMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70E9C433C7;
	Mon, 25 Mar 2024 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711352569;
	bh=RWfkuRN0X+C0bbZNf4OcFVxtl6l9vXxG/jRERy0pc1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOXKaIMcHZ920IrB3iuwrbsPrOVB+8M1bx1I/7kKRDpHuMrMynNFtf1Pvb88ReXkd
	 xQ3qVwo8fUVVWzdtWUQaJGwLMJw8NnBb4TPki0diVxCSpySBPncEfyV5+OGmYOvMcI
	 Abyin5ib4zS167YpN1e/dLZTW3p5gsSmY83/0Yrz0Vzu0CSGGgy8G19dBWsZoraWoV
	 QuXbJ7OgmexfjY83ell2RG2FkXKdxtDlzK3WkHE9doPaYhI8skyvYX/oNV1WfNd0uj
	 FvXk33lG4aUqoUkJWvW8pYosim6uX01rywyGfcbVnins8BKlCtIqZRprr81RCsTYYN
	 MYNzSdtNvhzKg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1roeyt-000000001lI-2VMm;
	Mon, 25 Mar 2024 08:42:56 +0100
Date: Mon, 25 Mar 2024 08:42:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 5.15 087/317] arm64: dts: qcom: msm8998: drop USB PHY
 clock index
Message-ID: <ZgEq_w87g1O17IkW@hovoldconsulting.com>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-88-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324233458.1352854-88-sashal@kernel.org>

On Sun, Mar 24, 2024 at 07:31:07PM -0400, Sasha Levin wrote:
> From: Johan Hovold <johan+linaro@kernel.org>
> 
> [ Upstream commit ed9cbbcb8c6a1925db7995214602c6a8983ff870 ]
> 
> The QMP USB PHY provides a single clock so drop the redundant clock
> index.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Link: https://lore.kernel.org/r/20220705114032.22787-7-johan+linaro@kernel.org
> Stable-dep-of: fc835b2311d4 ("arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY")

As I also already pointed out once, this patch does not make sense to
backport and neither does the Stable-dep-of which depends on a new
driver in 6.9.

Please drop from all stable queues, including the other deps that will
break the driver such as:

	b7efebfeb2e8 ("arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings")

Sasha, you can't around picking intrusive patches like this on your own.

The Stable-dep-of did not have a stable tag and should never have been a
candidate for backporting in the first place.

Having to point this out to you twice in two days is quite frustrating
and I'm worried about what breaks next time when I happen to look away.

Johan

