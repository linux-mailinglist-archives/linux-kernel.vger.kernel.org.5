Return-Path: <linux-kernel+bounces-69306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA108586F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0784A1C2418C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98C414AD1A;
	Fri, 16 Feb 2024 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLD9lB2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FE14A083;
	Fri, 16 Feb 2024 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115602; cv=none; b=J7fd/IateRe2KdyXKOFNq2m8mOUFMSgSNHq2AlyJwcUaFSXHRTPYt+nttuJVO5CaKWnfgOmcBI7/VfYjfImF0EvCWKwf7vg3cPIPf9HMPQNbOQgRUd5eGTlqmNhTj8Qv7jGKro7KD2sEmoxk4izPn+3HN9I473QdPAaLBWMWuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115602; c=relaxed/simple;
	bh=1k4hBx0smdtZuP5mnz0mn9vpM3lMDeZ7dObeRWkPNpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWc72IUGTHZp0iFbPRzdY/91SBGL5FzaMm1s6xSOSk43iU/bsUtj6rGkBosPdKoqlGL7q56oBHGGTZrypGU7EyJOXbDcptB5wDGTw7OoOFBsEZfGLEPZKsEJBzLZY8PxZcDBZZja/5eRaGlq8eCOzxjb6aFGUopXwIJ/TmrR2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLD9lB2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C237C4166D;
	Fri, 16 Feb 2024 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708115600;
	bh=1k4hBx0smdtZuP5mnz0mn9vpM3lMDeZ7dObeRWkPNpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLD9lB2wzlChBxKsIkE5U+RmYdxk23oblh8RGx9FhOVN4d+kXAuqNIj51CbDzaihi
	 gYGXypBa4OTU2TJV8oT3VuYuJqhRgPy64rDdjcqf6MvjDu1L96VZX1i0WYFyNO6K5n
	 hZAZc26eqcUpSvaosKerIHc1PkCvRh4pwfyQnfRx4hLN4xZZrQ/MhHp8Q2GB7Q99lw
	 avSQjOaJ8cHO6cT985q1NSBvmRvthFGzAKaNq7wbFSe6eDAloN3OWhU6MBrd0l+FLW
	 4K3kGbwkczAJTD/7F2b9xpeHvFTO6claOWMhb0KzCvzejGdwZPufoDZCE1WCU8uOH3
	 Smir5zwhBek2Q==
Date: Fri, 16 Feb 2024 14:33:16 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pbs to SPMI
 device types
Message-ID: <zaqjoyucfohfdqlkkjdwh3ggakmvgir7na5s7egorbcxdpvsit@oxmlh7jhjo4x>
References: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
 <20240205-pmi632-ppg-v1-1-e236c95a2099@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205-pmi632-ppg-v1-1-e236c95a2099@fairphone.com>

On Mon, Feb 05, 2024 at 10:51:38AM +0100, Luca Weiss wrote:
> Add the PBS (Programmable Boot Sequencer) to the list of devices.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 8103fb61a16c..b7f01cbb8fff 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -160,6 +160,10 @@ patternProperties:
>      type: object
>      $ref: /schemas/nvmem/qcom,spmi-sdam.yaml#
>  
> +  "^pbs@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/soc/qcom/qcom,pbs.yaml#
> +
>    "phy@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/phy/qcom,snps-eusb2-repeater.yaml#
> 
> -- 
> 2.43.0
> 

