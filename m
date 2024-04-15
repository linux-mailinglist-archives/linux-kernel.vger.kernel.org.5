Return-Path: <linux-kernel+bounces-145860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46458A5BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618161F22A79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1815667B;
	Mon, 15 Apr 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uC4jN2nQ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C11156655
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211506; cv=none; b=RhykK50LMYWfXeSxMnAL8gtGuvI01CcX67MRECJ7ZGYwLcU6+IjfIECWXQOTs9zyHdu/2KCshYewPVl+o9xi+/VX+H9W5ILpw4wCd1qXgfQ/S/uQXGTjdG+SngtWaraNwC2XLnOuNFKHY7qeksBdeLSIqEqF0+pxJa8J0pc3w/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211506; c=relaxed/simple;
	bh=nV/5Zy5i9dFykq8+Srtuq9aQoYYGfbts8T748v9Xj+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3mBqRLpqlh2M+Sg3DtasKHJsnZ5LotVF0etozDUedm4PR2ysF+etD9XpO5RcXsI+gcl94eLRt6H0yAtjfQiYOQmThyOZHapt/pq8qoRE2QblBPJd6xhO7JPW4ColULxgisuksPA4uUsTRN4sGNKlDd7lArJVTyoEAKs/99D7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uC4jN2nQ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ddda842c399so3852906276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713211504; x=1713816304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVkD3jsw1msmtxQF4rlyHtOM/X3ToEYL670E+U4G0es=;
        b=uC4jN2nQ1hgGZSSPU6ZZQ5nvKsHXISZFT9X0mUHfKxj9AfKJcn5MnuULTFs8OSpzKx
         UYNfr8tPyhl8Y83NlrTMIZ6gviJKVQnac0eJuiLcI8xuwxPAk3+Yz7Iq4Uo7Tm3WQFLL
         QHbABbJoeu6Tqt/nwGEJNFYYCWM4WJGdK4IfHyZ5b0218BIKE9HIE8KOD0gv3vem52gk
         KxKd4vP14H7RyPdVf60yqSGrSdw3aJ7jFPbN6TxY2iWzQcVde0VL/HHurvh2rHgZGP1m
         njB/KZeppUj9WueUe/9M4SK0GY10t9aVOkHBS9yyIY7HdDxWp5JOzcWeS5L6h3EnSRFW
         4s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211504; x=1713816304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVkD3jsw1msmtxQF4rlyHtOM/X3ToEYL670E+U4G0es=;
        b=gkQgP+Bdu7L5EsoTSg08uLeAyDC8NF9CLiMs2W5PlN2MLwgEv31F8cCErPQsEdqcl0
         jofPOcooaLniwRkg856If9QJtbwX89AhN6dxK/WB4q6YLDdgeuoSHjpAA5EZUPzqvJ2m
         +Su2fNJ7TwKyv7wTvmioQJ5NkCugzd+HLG0HlVD2FjIlU3woeFIbJI/J2pxfux/BUOuj
         O3yI0N8Zo0QSZX38zjioO8KhCWFdJOOcYSXshjsdd/chRUmR0yaWx5rqlomAVbraMIbx
         nKcjH9snUhBCCjOwGk4LYgjI6J2cLN/BJ2ZSCcbDYzvWlZK7Rpc+tVUkDY4hfxks7JzO
         I+vg==
X-Forwarded-Encrypted: i=1; AJvYcCVZnLpX/X7nK5uRqKUAGoXo1nerQJUJKKgHu3+jHYiVfPwuWUY5RWYHH58ANBBQOf3uXHLVelaqjNcOP95+6X4JAV/xEnW5Zhw+TaA/
X-Gm-Message-State: AOJu0Yw7NPO75jiwBqZ/ccGJvXu4b9txvXN0TJpmufFwLImKl1dAbEdc
	YMDWDVmvupeBteWT1zUeRz/LNdKJNXk7iUn+ZUix3bFyRF762W1oT3BAUlk9hjNrBrepBhhuPMS
	GLVhvHAwlJalg++vdbJPaXddLbG896fPjbYqXcA==
X-Google-Smtp-Source: AGHT+IF3Mae4SNhDlErp9j9yGTNWys2//EJwilymG79SRLAHm+Fa1djrn4pEPWZZFliwe11Jn8vFW2dJFT9lgX1FVfM=
X-Received: by 2002:a25:1942:0:b0:dcf:bc86:1020 with SMTP id
 63-20020a251942000000b00dcfbc861020mr10239771ybz.53.1713211504061; Mon, 15
 Apr 2024 13:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415182052.374494-1-mr.nuke.me@gmail.com> <20240415182052.374494-5-mr.nuke.me@gmail.com>
In-Reply-To: <20240415182052.374494-5-mr.nuke.me@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Apr 2024 23:04:53 +0300
Message-ID: <CAA8EJpqKWJBqDUacE0xTLzxny32ZTStiRgXsd2LBD=Hou_CRBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] PCI: qcom: Add support for IPQ9574
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 21:22, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>
> Add support for the PCIe on IPQ9574. The main difference from ipq6018
> is that the "iface" clock is not necessarry. Add a special case in
> qcom_pcie_get_resources_2_9_0() to handle this.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 14772edcf0d3..10560d6d6336 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>         struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>         struct dw_pcie *pci = pcie->pci;
>         struct device *dev = pci->dev;
> -       int ret;
> +       int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
>
> -       res->clks[0].id = "iface";
> +       res->clks[0].id = "rchng";
>         res->clks[1].id = "axi_m";
>         res->clks[2].id = "axi_s";
>         res->clks[3].id = "axi_bridge";
> -       res->clks[4].id = "rchng";
>
> -       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +       if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
> +               res->clks[4].id = "iface";
> +               num_clks++;
> +       }
> +
> +       ret = devm_clk_bulk_get(dev, num_clks, res->clks);

Just use devm_clk_bulk_get_optional() here.

>         if (ret < 0)
>                 return ret;
>
> @@ -1664,6 +1668,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>         { .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>         { .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>         { .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +       { .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
>         { .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>         { .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>         { .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
> --
> 2.40.1
>
>


-- 
With best wishes
Dmitry

