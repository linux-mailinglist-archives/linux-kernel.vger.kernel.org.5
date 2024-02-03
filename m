Return-Path: <linux-kernel+bounces-51209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F68487CB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7567B24696
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C935FDBB;
	Sat,  3 Feb 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWkH6GL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B65F549;
	Sat,  3 Feb 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979987; cv=none; b=n9ZC8hhVbZ75MLptAFxAgq1cKSE2/nwm3NL5aULpCWsxbGJqMStjyFzoRltqQxLteDWCWPvQvb+M1uY2fTJyU5/Ujcu5a1CW6D8S0LYMKUTz0/I/N6Az9z/E7L2EewPMIR0e2k+HG+mxfQswh85L3pKKPp8qOnyQVQqOswc5HGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979987; c=relaxed/simple;
	bh=fuAoO5+dM7iUereIafdAkD1l5Uc8z2CT//6owE7RRrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDNI2POEFrzB7Lssm4+jdaeyAnZycBTZN+RxVhcdRiqJapeVWX5e1WtUVq+k9xe+Jxv5CWpelqDnbaGykIaWXJq8tTUfEs0cFlnhAcjOZBlMBPAWLXG49W91yIMBKscWkb6DJY1iEaF7HORle0RWlqewl3g8cxC98f2rhaso4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWkH6GL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B3AC433F1;
	Sat,  3 Feb 2024 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706979987;
	bh=fuAoO5+dM7iUereIafdAkD1l5Uc8z2CT//6owE7RRrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWkH6GL/RwuO3rFM/hRRF9i0mqypWQihgQJ33AKXyHEdt7iq9X0dC1a09fhhi1DYv
	 jcbyRBFwuCWo5Fy0Cs/8kRyX4s2nc1pQTJcMws6Zto9fLZCv2slAOIX81QAFHiBd+p
	 rQJDyxlzT8LSYhNK6mBf4HTBetG+TAAZQYMW4ym/H1lczcrOVwFITXHfdMVDsDfjbr
	 8L/T7pRL8btwSCcyID8ldPYh0gZ3o2ufMtPmvYpeNAaHliWlJtGbvEnZuqqNAw9sCD
	 sDdglwJODKOxw6i1wwqww7sxp2taW9B7fdrILv/PrYhgQ78S35evSefjw3MOJRbLJW
	 jW08QOXWX27Bg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/2] arm64: qcom: sm8650: add support for USB-C Altmode
Date: Sat,  3 Feb 2024 11:06:18 -0600
Message-ID: <170697997764.332807.12206368060165117821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org>
References: <20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Jan 2024 14:21:14 +0100, Neil Armstrong wrote:
> This adds the missing bits to support Display Port external
> display over the USB-C Altmode support using the Redriver/Retimer
> and WCD939x USBSS Mux/Switch to provide the correct switching.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8650-qrd: add USB-C Altmode Support
      commit: 63b78ca1a7b83113c0147325013746dd2c2992a3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

