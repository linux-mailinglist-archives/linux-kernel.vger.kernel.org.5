Return-Path: <linux-kernel+bounces-110153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64232885AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BD21C216A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90785274;
	Thu, 21 Mar 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfO9S2W+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2A1EB5B;
	Thu, 21 Mar 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031752; cv=none; b=MISEQyL1ojfywMjuYK6J3TivnMFAKU9uT78/ngkOvC7vsol/W51alHBsfQI/y/BGCQM5YRIA30mDoOHoiZfDfl5mgpwP02CxG//pB6jjHWwWDj2vbCWezCd3U6OWht7W+F2CGR1IUEeJDIsXnPZt1UrHfT6PnGSWrF77Sjag7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031752; c=relaxed/simple;
	bh=70vwzhgn79yogJCS87DlftU4oBSZhD43UWqQlGCtGrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIqXgTd317SI7q5RhmVwKUt6hMVHpqWwh3ZFGz07g4amw4W+6VtOgfGHhgjwcwuONxdL80EotZDsR78kBcR31aHey9uUJyUCy5iNB6Ib53/07YvQG49r5BkMvAc/Hf4r8FiU60ZeZzYhxmPdSGyfM0D+ApLmmCWjCxJycQriiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfO9S2W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079B5C433F1;
	Thu, 21 Mar 2024 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711031752;
	bh=70vwzhgn79yogJCS87DlftU4oBSZhD43UWqQlGCtGrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfO9S2W+we9+5OhEducULSvn5FUTOeaJNq3guTfppTUv1WpX4j/hMWhAC3Gm1S4jT
	 L45LPbzwRFpkZ2IfAlps/7oDBdJGBac4+KTB5kdleaEUqjx9RQPWueasnpO5j2ONFh
	 4FjsLrk+0ZTToJraGxS1cOu/6pcAmEV5D4ZnXYuQAWci4nPsoBcbZnVffzTFakRk1D
	 cUF6PT+LSrxFyymJvG1zYb50NJAtpEMrp9097oGWegoHDh5V2dI/V7N0IOrRsN9NCi
	 GsT3lJn4x7pzQtaLutknHpx/ZSVhJQmqn1GUZaRIJZ2QHl6i263pZyK3jFh2v5EMvi
	 +8lRtRPLeeLzQ==
Date: Thu, 21 Mar 2024 09:35:49 -0500
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <20240321143549.GA1679970-robh@kernel.org>
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321043149.2739204-2-quic_varada@quicinc.com>

On Thu, Mar 21, 2024 at 10:01:48AM +0530, Varadarajan Narayanan wrote:
> Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> interfaces. This will be used by the gcc-ipq9574 driver
> that will for providing interconnect services using the
> icc-clk framework.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> 
> diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> new file mode 100644
> index 000000000000..96f79a86e8d2
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

Where did you come up with GPL-2.0+? Every other qcom interconnect 
header is GPL-2.0-only. Is your employer okay with GPLv3 AND after?

Rob

