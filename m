Return-Path: <linux-kernel+bounces-41425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90C83F0C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B327FB226FC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052681F927;
	Sat, 27 Jan 2024 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqNPd5ub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CA1EA7B;
	Sat, 27 Jan 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394869; cv=none; b=ZDVbX7TBFy56On/MDZFRE7Z3zIc1gbZUBaNl+uUQUagoB5dEKjCF1kLlogbCxGDEP4AhPL+nqoxW6SlMAxU77XPIMwj9bwg5Hf1VGWpgYVI1savOI4x5pnOgeweeA+0Y6IfW1ius2WCQCbtMdsa+vtbswZDbBtr68jNXDVSxwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394869; c=relaxed/simple;
	bh=ZRiySXP/jzz3Defc8d9Ij8AkI/S6SMYAcAmfy8jRBmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSC5GvlVqWWADGmZP5g3TyQf+gHfK2BUDZITSu6iN8a8ZYT4d9yaCZOicJrHKa2z8KVMss56P8AvrzfIhctsO0fE9bMR2FcB2jCGmSTGVppODX5WrAoy9LJnI+SqryY65YZMDch3f42bWhnb2hqna3MsZ9j5z+2kO8r2jSg/x7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqNPd5ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF3DC43399;
	Sat, 27 Jan 2024 22:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394868;
	bh=ZRiySXP/jzz3Defc8d9Ij8AkI/S6SMYAcAmfy8jRBmE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gqNPd5ubr7eHKALqL+ciL5o2HwG1rRaY63BqpAQj/ivRmwbJbaThkpha42sUMR7tv
	 wl4KETiWTQ7m+XydFKeT1ufrwo9p9gEGEmJg7OXokeF/Rb7/2OXNqE7NMCeqFeMGR5
	 no0q+tyld5oIIheqnk5XoACGygglrmejH4G+AUAlW/moX319R3isUgqshvMPIbawYa
	 igDrT9x2QFi9X8ciUBUR3TW8/IV0vCZy2ra61z2NE5O9COcjXBnV8J/y9Eg/fL4pBn
	 U9HBaJeeNkLusX9dvY21OrW27deiNJkHQtB/rCoIE5RUq4oAQoUunqpUskypJV4bdb
	 usWOCR5vM6Qgw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: drop qcom,drv-count
Date: Sat, 27 Jan 2024 16:34:21 -0600
Message-ID: <170639483111.20773.436977031472376160.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218145050.66394-1-krzysztof.kozlowski@linaro.org>
References: <20231218145050.66394-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 15:50:50 +0100, Krzysztof Kozlowski wrote:
> Property qcom,drv-count in the RSC node is not allowed and not used:
> 
>   x1e80100-crd.dtb: rsc@17500000: 'qcom,drv-count' does not match any of the regexes: '^regulators(-[0-9])?$', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: x1e80100: drop qcom,drv-count
      commit: e81e86765f957f3c5d48df9e275c527bd8c14156

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

