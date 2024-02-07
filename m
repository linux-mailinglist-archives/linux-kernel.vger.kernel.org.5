Return-Path: <linux-kernel+bounces-55957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88E84C40E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3501C20E0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BE286BD;
	Wed,  7 Feb 2024 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0Cbzkqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9825635;
	Wed,  7 Feb 2024 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281234; cv=none; b=DNnt0zviR4JxHzV/lHKfez5KcDhJ/jcKXYqUCv7pZi7D6OC3RZMylD7UyGgNJuP9a9qE4+X+RGAWpdEBUOuMkQ9l2mKeOc8W3JuxH/14BOG4jSMDmJ7Se0+IAxpckPQX1XWMsXoU9ad1TUJCsmESb9cqopuXywLiyq/TUfHhaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281234; c=relaxed/simple;
	bh=+oVlhw6XekS4PFzGgkgVfFcGrycAQ+k4aClu0aKDSSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAw9r2zbTopWxvC2dYrRxVqsmdnFKGmSpLOK+Ty47xf6FytaTcBg8ZJH8p6e0s7myEiQ26CciXG3aAXcvbsXhmKi4ck9aLTwhr+dxQSDq/ZBmXNH8Ks4FhN3j6I2q0Ot5Xfg0w7T/SnfXI5LfH3iiwl8PCTt5ifeA0p4m0ay3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0Cbzkqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5BFC433C7;
	Wed,  7 Feb 2024 04:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281234;
	bh=+oVlhw6XekS4PFzGgkgVfFcGrycAQ+k4aClu0aKDSSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0CbzkqeITwZrsxkVQuRi81Hpv1/0gM5EEpxRTTq/otHNeiettsN4EwYMKfPSgWt7
	 zPgzq/3vrySM3lBCDz/b4FhDT39oMk/8dXAZQfeNw4kpRpSEoaUiepluRFrQpL44pR
	 sWe1lvIBSS3efMgzaEWcIynd9JQI4BKxxF/bC/xdgHWZ9z2JJuUxQWWGTJguKiieYi
	 +jD3KE1DxBZHt/hsY0v0LRMlvPXAdmSumF1cOtndt6wtYlSEqJkkb+XocOWTtj28HK
	 gwhWlzoxCEogkpeisuht1hf7UnY74jIR4wvJtdArB/dNE6hcNosmSay+0cs2MJaam3
	 XQ2532K8T0KXw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-hdk: correct WCD9385 route and port mapping
Date: Tue,  6 Feb 2024 22:46:32 -0600
Message-ID: <170728117691.479358.17858995235061107650.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201-topic-sm8550-hdk8550-audio-fix-v1-1-aa526c9c91d5@linaro.org>
References: <20240201-topic-sm8550-hdk8550-audio-fix-v1-1-aa526c9c91d5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Feb 2024 10:16:21 +0100, Neil Armstrong wrote:
> Starting from SM8550, the TX ADC input soundwire port is offset by 1,
> and uses the new SWR_INPUTx input ports, so replace the legacy
> SWR_ADCx routes for SWR_INPUT0 & SWR_INPUT1 following the correct
> TX Soundwire port mapping.
> 
> Add some comments on the routing for clarity.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550-hdk: correct WCD9385 route and port mapping
      commit: 31ca6241fee837927cc4cae2e1ace0c84b01a03f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

