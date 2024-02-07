Return-Path: <linux-kernel+bounces-55952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788684C3FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABAA1C25970
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789F224E3;
	Wed,  7 Feb 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hftIsCn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8F219FD;
	Wed,  7 Feb 2024 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281225; cv=none; b=pIDbsAf/6MrnhqQwWFWhOXOzsvJHutdaFtW3ZH2z+pyX4FbSoDjdBSJ/N+WYfe2i5xynziDZShTDx4CeDQlrnfFVSmjIFj+tSfdzEjXDupA2c5dR4rXhI1mldrBUIU9s4TtQWqywITfAZZDSz2vtt5S8CvnxCEsQNNPlnRlIzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281225; c=relaxed/simple;
	bh=iY0SgIfmD0SR5ThgyjjMZ3tbTVIJfNbscQJZdIHdO88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D85vh8KSyE4012tqbRFV71Kt3hDPAJjNUh5H5tQiw7tjJad8lR7rUYIMonADKfld3coD7qZfPHue1Y+9a63wFk8csCnMZ2FderJjE1c127kOJRbYo3VOQ5R3yvWhdEPcDXJyLIO9lRqqnjk/0gyIPR2dQNObZa+gPZ7BUaYYRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hftIsCn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC19BC43394;
	Wed,  7 Feb 2024 04:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281225;
	bh=iY0SgIfmD0SR5ThgyjjMZ3tbTVIJfNbscQJZdIHdO88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hftIsCn1cMr/XeIsfhGOHqa0x+pJiysxeSsYLr0y5CguJoAf9rNwUraB6k4OO7HoF
	 MLPSbsIAnXaZvsrudOU+iVJkk3fk2I2/HxCN2BJvGmAimZWGpc/9E1Hu9RawpTO02x
	 3FuuBVTFCsEw3uHfOr0VYIFFvKvFUPM8xVGiuE+kHIGzMohSTLnaiowwLDR4dMXNfo
	 hFxBs3Tsn01NS/E1UEhyYXSi7tDAlRI1jZ2gdKUsF4Aq+suH0861vFFT/ojvtZIYUM
	 4l1y5z3ma4tdIepzlg6NCYO+Ms+lbU0gSQQ7VhqGo9QDRerwbvjwTUYrWL0d6IwNOT
	 JoEhHQ5TdpeMw==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/3] Add MDSS_BCR reset (+some more) for MSM8953
Date: Tue,  6 Feb 2024 22:46:27 -0600
Message-ID: <170728117686.479358.8704110052717594470.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
References: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 22:35:11 +0100, Luca Weiss wrote:
> Add the MDSS_BCR reset that is found in the GCC of MSM8953 so we can
> make sure the MDSS gets properly reset before Linux starts using it.
> 
> Also add some others that have been found in the LK sources.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: msm8953: add reset for display subsystem
      commit: 9b4dec638c9cd1e881125894e263b0f824b8f75e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

