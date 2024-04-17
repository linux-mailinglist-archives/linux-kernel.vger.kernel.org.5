Return-Path: <linux-kernel+bounces-149082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20418A8B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15208B2690B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF101DA53;
	Wed, 17 Apr 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7HypdlL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330E14287;
	Wed, 17 Apr 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379834; cv=none; b=pCpOVZT5Vbwn0B4UM3GovxpLnc5z5lWY/2ZevL0/ZF5jc53FfX6rBJLFhY2hXtdKCYMQQl074cONPlBpic+kgbWQjucklf8y/k5TzqrkmVvDLUZqrpbvVcitT2/nzH+xIMyKuvCJ7yiceO3mbLRuw+YcLZ3aDCR1vlKHZHT6uXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379834; c=relaxed/simple;
	bh=hqK4irrz7Bv5r/zDzSMYUGCUqRdTaAZbUy0HF/Hv68U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFpgzqfLWbjIGVTTdV0g0K69BbOtrhWzThyspU1fUura712DJ3IGzBoDxmInRalKUzu6sWSh9qcWioVWzexv7jjlk6W+Lp9B+ICovhuLAgugmJbDOG2dBE2jbG6tCrCgeHBKW1pmmlqpFrduEJDtyKmTb26eB1UtJdcsj5GER9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7HypdlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EACC072AA;
	Wed, 17 Apr 2024 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379833;
	bh=hqK4irrz7Bv5r/zDzSMYUGCUqRdTaAZbUy0HF/Hv68U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7HypdlLNs02Gklyv3kz6NzC3xlYXuv8BKAHRIg4m7C/t82KpEjNywUG6klCPTVD6
	 GL8HHK78g0rwem+rCY5opdCFpueZHTu+mX2z+zM2Q0T08SjUbBosxOgYKNgRn/Smqs
	 nVsEFxn0vXmqX/Uha117hdgVhwZz5v8Cii9mWx4hfqa62H1OpVX/1UR4PgyLrG3qTY
	 XC/llwBzKxIJMLcqU/TqdWTV1FrQOq/zKcJ+To7AQEBgL0bDUN6DOWWAciryKu1Fcq
	 WJW5nsFliIoDo529lYka9fRO9i0i3Ag8W7U7/tQPZZiUkuzHfrI8BMwZ0FG+OWv8k0
	 DuHLM7YTibzsA==
Date: Wed, 17 Apr 2024 13:50:31 -0500
From: Rob Herring <robh@kernel.org>
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH V2 4/8] dt-bindings: clock: qcom: add bindings for camcc
 on SM4450
Message-ID: <171337981738.3083095.5538266376603051623.robh@kernel.org>
References: <20240416182005.75422-1-quic_ajipan@quicinc.com>
 <20240416182005.75422-5-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416182005.75422-5-quic_ajipan@quicinc.com>


On Tue, 16 Apr 2024 23:50:01 +0530, Ajit Pandey wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM4450 platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  .../bindings/clock/qcom,sm4450-camcc.yaml     |  63 +++++++++++
>  include/dt-bindings/clock/qcom,sm4450-camcc.h | 106 ++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm4450-camcc.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


