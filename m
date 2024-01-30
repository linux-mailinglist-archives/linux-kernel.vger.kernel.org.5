Return-Path: <linux-kernel+bounces-45023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC5842A98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231E11F24C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01912BF1C;
	Tue, 30 Jan 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Tiv5n/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23C1292DE;
	Tue, 30 Jan 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634763; cv=none; b=Oq798TsA1AAt0e72at5QQBXnSyOk5x5G7KHcYAwshVmMLdyZwv6AbM2jJbP9Wy5d5g9Luft1AFF4/h3fGL5AeTVYNr58J/b5ju3Ggok1SjfM6COoufznhc2hqJxq/8FKVYhq6ZPzhikX5z7Yh4B66tFgACXn2EpXDSm7B7vTofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634763; c=relaxed/simple;
	bh=PkjZQsYbArDQxHJBdjmN5B4YsdpxE+UZi7kgvdMCax0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOuiHnNb5bYS1BF4kp7laC+bTZiURsJLuE3gUfUGepLN18DIeSMq7HHrNH/P7rBxgPVxfHIak7s/a1FjHaQ8BRo0Xl8E/zqnyx5dBy5JTxk+nkqB9XoavedtQwx366NQB+wJrgE87D+XY+9MLGV4yCheGNmO8uJu7Z6soNMZa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Tiv5n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C96C433C7;
	Tue, 30 Jan 2024 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706634762;
	bh=PkjZQsYbArDQxHJBdjmN5B4YsdpxE+UZi7kgvdMCax0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7Tiv5n/1AF3v/eZDPM2lN64tvP7ZN0+vrjw2Nf60G3hzWh7MPldpgoOAQNCAemW2
	 FXHxsb36rjhVR1VDy0pBeb2X4SSrIfJ6Cn3S2KdK3dWCVoXu0doo7U9x6QpxI59abY
	 fXbYLGkiqCfrGn1nZEbW8Ie24C2e4tJdt37GA/4yFM0Z/M0LdjYdgyjZIAd5l5oVru
	 whznUDbHYf4iMFAvYMRwFYPmM/cSGyHMikyTaKa+mRySzvcqzdg1ZHhhk6KTS2QtS4
	 6PD7frXkNb9R9CJwEWmjqIiZpFpcdKcODE1pWlLSYTjxiwbS7XWXUZs207RvH0AeTU
	 0ePwfXAJNaD/w==
Date: Tue, 30 Jan 2024 11:12:40 -0600
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org
Subject: Re: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
Message-ID: <20240130171240.GA1929440-robh@kernel.org>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117173458.2312669-2-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 11:04:52PM +0530, Sibi Sankar wrote:
> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
> controller.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> new file mode 100644
> index 000000000000..2617e5555acb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/qcom,cpucp-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. CPUCP Mailbox Controller
> +
> +maintainers:
> +  - Sibi Sankar <quic_sibis@qti.qualcomm.com>
> +
> +description:
> +  The CPUSS Control Processor (CPUCP) mailbox controller enables communication
> +  between AP and CPUCP by acting as a doorbell between them.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,x1e80100-cpucp-mbox
> +      - const: qcom,cpucp-mbox

A generic fallback implies multiple devices use the same unchanged 
block. That seems doubtful given you have not defined any others and 
given Konrad's comments.

Rob

