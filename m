Return-Path: <linux-kernel+bounces-21211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061DC828C05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DF51F25253
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C553C092;
	Tue,  9 Jan 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYJlVYOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AB3BB53;
	Tue,  9 Jan 2024 18:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B109AC433F1;
	Tue,  9 Jan 2024 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704823333;
	bh=shSKY1w5aTYzV09A9d9FAgEOsAUKw342DuDn9xlkgN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYJlVYOptKscJ2fmaUvQyjYYNonnnv47GtyIbfdHydJDnKE5BlWJ3yR9swpNfB/IX
	 CzQ6ddSD5uh+NhJZAnkJstCCu9Q223TBI0pb7ikgOlkOflXa8hvQFs28ri17gmMcWI
	 dCKTSYUmRqJOYAECXMvuD2cREJCuN7NyP2RrPVmZKwv1lwe+sJ7U/otL1rQibttrbo
	 DVV1aeesGg+X4brhFKPNXX7lRPh5b0OjjgBCBS3LIxA+k9yW7Xu7cdeFuYMg5X+j4a
	 uF7h6IdTVLPfWMUX2GsXlCyDviaibZBGK3WrIsbDCvwUBg4OJEmQIona/hQ9YgL6f2
	 zPZRPZVBmRACA==
Received: (nullmailer pid 2851599 invoked by uid 1000);
	Tue, 09 Jan 2024 18:02:11 -0000
Date: Tue, 9 Jan 2024 12:02:11 -0600
From: Rob Herring <robh@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Message-ID: <20240109180211.GA2841248-robh@kernel.org>
References: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
 <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-2-b8e3a74a6e6a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-2-b8e3a74a6e6a@linaro.org>

On Tue, Jan 09, 2024 at 04:06:03PM +0000, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

This is where you mention dependencies. Didn't I say this already?

>  .../bindings/media/qcom,sc8280xp-camss.yaml        | 512 +++++++++++++++++++++
>  1 file changed, 512 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
> new file mode 100644
> index 000000000000..c0bc31709873
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
> @@ -0,0 +1,512 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,sc8280xp-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC8280XP Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> +
> +description: |

If you resend, don't need '|' here.

> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.

