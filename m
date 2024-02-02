Return-Path: <linux-kernel+bounces-49857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E27A847091
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FDF1F2CE98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D38C187F;
	Fri,  2 Feb 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcGUc6+J"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF8185B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877860; cv=none; b=ZP7QAT+j2uvl2yhFw10aJS4l0RJsdoXSIW1HjOGjBUJJ8rNRFoPO6G/f8g1Z+iB0nkHU+05GQE1gJcHOtN0VuxcQ9ow6AU45ICiCssaxbd7V4i6zF4fUVPgjox4Hr7EoC8KC/ZJSfnHmOHvsMXhX5PY/FlJfi2zjM65eAjAEAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877860; c=relaxed/simple;
	bh=AHccFh1vhbj9D8lNavBos4qXxlEB48XAwTNCBRo9exs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j32oMK8il9OST8I8gTuxepa5bCvpfjmL5P0iJBSbgTOuhVWSma0+npVRvuamQnG9i4LyLYEtOzCOpynpCWVS44bbVbotD1u+W/WYO9q6izhwSkr+zxhZfW1X4wTRz9rDo6NXpKUFGzvBcxbpjjY7NarsCshrrUIiYO65ta3kevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jcGUc6+J; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d9607f2b3aso5085255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706877858; x=1707482658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rm02oG7clY3fiBMowynDm3V+C/aVHnna+vNWkYG4Ykk=;
        b=jcGUc6+JT9suoeLfSDJHXl+0gc3jwfYIoCcpDzybVONGcjol96glU1Cig7h0o8smua
         o29O4cAPYEkdkIrScix/k1q8pKcM3CoiiRvNizPVUxYo/DlQwtRdVzg0mm4+GroWheVg
         zKvBkI2OIZZv35kryDK0kMlNDZRIyOsjYBMEwvzClVy6g8N/3BL+jdClYsdaaAIakDyZ
         QdqOCF3lioiIKF0KFEyVKkJF7xPnePM4JXy85YYwTa6k9MFzbcnn2GzUoHf4zkCFuILZ
         17k2A6UhdYMS4xUDAtCVkxALsTvMlLW7DHOeNdL5Ec/4xPYQDzh/cGhpkW+qZQppuXNs
         z1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877858; x=1707482658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm02oG7clY3fiBMowynDm3V+C/aVHnna+vNWkYG4Ykk=;
        b=AAlqzRwuPSXlLiFVQtI0xUfe1QwitB68OZpAJk7aQ1xs/4M8mfJ2c+Ma584qf0ZuUM
         6e+4SYEzOLKDhOeasN/KmhwzyASMRNApa+YeB9eNW2y6sWohjIjU2odhhDjboNPQfthm
         ptZxHMk3Y/wLQRNLNHOZMrT7qEiAOh2x5B1wWg7K0ifMvMj0TNDgeNM/YgL6v/67f0NV
         3iypAEN0EEuM67I4lGYIaoha61chEZ5CR3Hv9X84+CuBe2NXZOj/4Imm8We1h5pgsZ2L
         0t9C49tnYAPP4egrQafBiZl4zZem6wgOLpyM4gvdAzt/dojsow0uQlH49NgM17oyJ7+n
         SnRQ==
X-Gm-Message-State: AOJu0Yytp3lPjlU+Zbs4QrKPIcD1eBZ2w/ewlqueFesE+2EdQ355ZaTs
	mBAcGEfJAW56h3GWtxoHaW2Jl4EX8jLHExl+rG3w+9GwXoFNdm7UTdmQtGBsDg==
X-Google-Smtp-Source: AGHT+IGy9bAdHYdFNg1g9DDUGNxltAsmrrrmJY1U7q8ZmZPYcgJwS1tYM325jCVPGcRigXZYLKd+Zw==
X-Received: by 2002:a17:902:db11:b0:1d9:4143:5fe1 with SMTP id m17-20020a170902db1100b001d941435fe1mr2898553plx.0.1706877858240;
        Fri, 02 Feb 2024 04:44:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlxolnBRum91Y/AqKP2BCANY3KuTteRYOFf3lJx7luihX6UAtboZl9soeI4NSaT4AKy6oYWyyWbz5sEoKGMCJKR8uvEynUck+/7BOPKlxRTWbRJZZ2cKTifj+GMQmWKenC2L1ag5NegC8lWZrFA8Ad7pitBdw/+JYAB8Ir8w6JvDJNtyOZ7dpT1pYJjD0FCM3aUd5jw63zkAmkeK7i16cP1LH4nc+FPVk+AoQOY4IKHT0VSbihdO94RkzXy3YeBqWkNMJ0Gs3PhNNykwr/1FZQJHGpRzJLOOkOX5swMm/tAOfQRM4/SmoZFMRc
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id ml12-20020a17090334cc00b001d8f6ae51aasm1535215plb.64.2024.02.02.04.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:44:17 -0800 (PST)
Date: Fri, 2 Feb 2024 18:14:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the X1E80100
 PCIe Controller
Message-ID: <20240202124412.GF8020@thinkpad>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>

On Mon, Jan 29, 2024 at 01:10:26PM +0200, Abel Vesa wrote:
> Document the PCIe Controllers on the X1E80100 platform. They are similar
> to the ones found on SM8550, but they don't have SF QTB clock.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a93ab3b54066..7381e38b7398 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -41,6 +41,7 @@ properties:
>            - qcom,pcie-sm8450-pcie0
>            - qcom,pcie-sm8450-pcie1
>            - qcom,pcie-sm8550
> +          - qcom,pcie-x1e80100
>        - items:
>            - enum:
>                - qcom,pcie-sm8650
> @@ -227,6 +228,7 @@ allOf:
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>                - qcom,pcie-sm8550
> +              - qcom,pcie-x1e80100
>      then:
>        properties:
>          reg:
> @@ -826,6 +828,32 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-x1e80100
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 7
> +        clock-names:
> +          items:
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: noc_aggr # Aggre NoC PCIe AXI clock
> +            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
> +        resets:
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +            - const: link_down # PCIe link down reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -884,6 +912,7 @@ allOf:
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>                - qcom,pcie-sm8550
> +              - qcom,pcie-x1e80100
>      then:
>        oneOf:
>          - properties:
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

