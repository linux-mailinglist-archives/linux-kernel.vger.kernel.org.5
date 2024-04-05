Return-Path: <linux-kernel+bounces-132905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00C899BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D84E1C22087
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417016C687;
	Fri,  5 Apr 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4gQ3IoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611F16C434;
	Fri,  5 Apr 2024 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316355; cv=none; b=YXwVS5pJO30f9aHQ6qZrIc84NP8FlQOhb/2ZkmOS62kOtWO3ilg0wH4BdYWTl+PiNZkMQGg+401zDRr+xBLIELbwSFxvEV8jDV3hK9riXSAT8uxIZIdSFXgNUSx5vvvKWlmYOPYCcUYY46mMNWEfEhP+Jn1ZXFflA9fDbwNHpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316355; c=relaxed/simple;
	bh=lGhLQBeP+Wco5+eAYUzJL/YnZD/zNP4Ecc8OgvFdTFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0tWTnN1bgW3mIGKgs0InOBLziOGXXqIzl42sWI0OIY2jK/waR9tH8k80z9uZg4vkLxQLYoJPauR3JbZbXrr/mdG0NTxJhew7bP2RJi3rJciCD7SNWObIyKwZy8D+hv/aVkd3f5umyF8N9jvyPlyVseFllvY5RAIBmAe16M46kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4gQ3IoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9BEC433C7;
	Fri,  5 Apr 2024 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712316354;
	bh=lGhLQBeP+Wco5+eAYUzJL/YnZD/zNP4Ecc8OgvFdTFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4gQ3IoOEyFtTOHr3ToOiSQ1Ctokd5Xa+W3mvJWNiSqgyosrflmeqcoIa4zaLFXYR
	 EUr0PUiJUDt7x8fZWMgR8Q8SGDca1D/v2/6KsAb3j6ES1H8W6Lgs7j7hi6P1/q7e9q
	 7PoG/TOCHQ2d4j5/9o8c3lddJPSBw9XC6TRN+/sUnGS9MkN1SqowdYSQnnmJ/aPfEG
	 JQSBQnZxCxtZutxgKgyDwyEsPqErkFzyc1LoM8IdjdWCaGlUlIViu+C1xabYCEZ/Mv
	 F1RKAgp8BKzhrgkmlqbu72T9H+/jY2InJ0jbKz3yhBNYNjya4um4NHdykhBZbFBO8W
	 EVeaFX6EiNqTA==
Date: Fri, 5 Apr 2024 16:55:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] soundwire: qcom: allow multi-link on newer devices
Message-ID: <Zg_fvU-SA9nwmzW8@matsya>
References: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>

On 03-04-24, 15:27, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> over two Soundwire controllers, thus they need a multi-link Soundwire
> stream runtime.

This does on apply on sdw/next.

Pls rebase

-- 
~Vinod

