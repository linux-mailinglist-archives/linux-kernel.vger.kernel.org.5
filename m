Return-Path: <linux-kernel+bounces-107671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21287FFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E5D28486E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861085CDC0;
	Tue, 19 Mar 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFINu8Tl"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4B2628C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859600; cv=none; b=YBHuj7O/I9vLCrqvidZEgZ0JMfbxslejIqYqkL0BCvzAES16kVEvVeJYERuIgyWB1gBoQcYZujG3KLfaM+ETfpMDE6TIMomHJQAyT6U37ynzUHQzYenRsLYorQ9J33pE6aG+oCiegPVUh84WvAK9zEBp0+e3RsZ5qwNrR+mYjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859600; c=relaxed/simple;
	bh=0YR4vaEHHbGNKE8eA6vzC7Rt66ToMX193XLYwIpixJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt/rIZXCLa0tlMczwb6M/SzOq68SvPFxTbs0NBIRFWSglTnLbZGC0zfaAN00NpOdMbO7KL/aDtUmqJH2Q46GgCr7ZoxgJM2zapemGnkZGClcyZchqiN0/3Ei26OrnkKzajfB/JGzuA/tv299oqJF6RckJ4RJFAfzixD2PV28zOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFINu8Tl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609f4155b76so58999607b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710859598; x=1711464398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPlNhua1WaqcSnRpkvhSs0yu6N7jGpn1fD8XUmo6+sY=;
        b=bFINu8TlLEZzIWgg8fE1snYIgL2xpP/hGgzP9rs4DBJIZqbSa43p6XBco+1wbwx2RB
         cnMk2Ok0KI2D+zP2u4DpWFS5xo98wYixFM2d9VWIdhraRwrLhngL5cRg0pDattKzeMpw
         PTFHW4abmt4hkZjU2iuGqe0dwb50pqVefjTEeonSh6npMcucVJt2lkPm52dzgIHN7Xbe
         V93mtCvjGsxRLdGsFgHXe+p+eEwKE6i4LnnmTCfpsczgOO6DkHFxPvHXSrDm8gL8l6g9
         tbhne8oxU0WiqFy/CzJGtO5PrWZlK6kqbF0ZUVnir/BZ+bDstCRCMlDCpZLaI0PP9Cih
         BE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710859598; x=1711464398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPlNhua1WaqcSnRpkvhSs0yu6N7jGpn1fD8XUmo6+sY=;
        b=ZFwEDSdlro0bKTPN4qa0fI4UVaY8AO41t4oUxKW3uekuEvFBJtUCh7hXXviFpPl+nh
         j8WPGLrnxiDmVyDpEmGFGG1SsIj4kTLu97PKj0hYeSK7CXF7iGjKDVkauK+lL6fIr+YM
         TTpCrIEcrbsK1vYwvJ5Pr8EtaVIByr4MCMcZAetp7bF9p+POduilALIfrNIQCrxt+YiM
         9/Cz8Ui6LmKnjKK4gzSWdWcWWOAic31shM4M1xs5Vp40Z2+ogEbM+AC5IEmJxMtM1FlP
         o2upp+f54yxngYJTHjT1sfC+ZKraxp4I182sxv/j1dal2HPhR3ZZLqolwMht2B+EIRy8
         78Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUtW4kzICC68YsVRtIji7bSQbomima7L9Ww49lvAQM51fKEjgmPyhOf1khlRSRlUND2mtvfmr2+lqY857Y6Elsp0lG4GhAMrzcRScQY
X-Gm-Message-State: AOJu0Ywt7Alatwz0eIH54RlQMf3YHWMul5zZxW2IYcy2L+AjWZJ41VWf
	gOAj1neUUoQVybI+h4nWdFrGJiHybY7H85q7ReUW6x1wMvmFb3DlrCiZJ99fJ/E9LT1Gqr5xf62
	/4uklz19C5RzoInP50wPY0wasyFdl/NBFAsDpfg==
X-Google-Smtp-Source: AGHT+IEXyzVQEjMGPIvQmFR8INOGeXXHEcno7tcbTIIT/p8RjF8ofE3sSYVPzm7Iah6+/YLpDlP+7Vd8Gk7/89u0Xjk=
X-Received: by 2002:a0d:e943:0:b0:609:efe8:2bfc with SMTP id
 s64-20020a0de943000000b00609efe82bfcmr2947995ywe.27.1710859597965; Tue, 19
 Mar 2024 07:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
 <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-3-926d7a4ccd80@linaro.org>
 <CAA8EJpoJ0rUd8aY6xpXyL3Obg66XtOebso_AUUxKmg1CWNykJA@mail.gmail.com>
 <85d67f3f-2b01-44c0-ace3-5e7cb48a9431@linaro.org> <090e306c-0bfc-4374-83ed-e883d73a0f0a@linaro.org>
In-Reply-To: <090e306c-0bfc-4374-83ed-e883d73a0f0a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 16:46:26 +0200
Message-ID: <CAA8EJpovp1S9MYb3ByeoR7WmjPgUmqicqs_fQo_OoL5_NTNPJw@mail.gmail.com>
Subject: Re: [PATCH 3/7] phy: qcom: qmp-pcie: register second optional PHY AUX clock
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 16:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 19/03/2024 11:59, Neil Armstrong wrote:
> > On 19/03/2024 11:55, Dmitry Baryshkov wrote:
> >> On Tue, 19 Mar 2024 at 12:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>>
> >>> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
> >>> add the code to register it for PHYs configs that sets a aux_clock_rate.
> >>>
> >>> In order to get the right clock, add qmp_pcie_clk_hw_get() which uses
> >>> the newly introduced QMP_PCIE_PIPE_CLK & QMP_PCIE_PHY_AUX_CLK clock
> >>> IDs and also supports the legacy bindings by returning the PIPE clock.
> >>>
> >>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>> ---
> >>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 70 ++++++++++++++++++++++++++++++++
> >>>   1 file changed, 70 insertions(+)
> >>>
> >>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >>> index 079b3e306489..2d05226ae200 100644
> >>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >>> @@ -22,6 +22,8 @@
> >>>   #include <linux/reset.h>
> >>>   #include <linux/slab.h>
> >>>
> >>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
> >>> +
> >>>   #include "phy-qcom-qmp-common.h"
> >>>
> >>>   #include "phy-qcom-qmp.h"
> >>> @@ -2389,6 +2391,9 @@ struct qmp_phy_cfg {
> >>>
> >>>          /* QMP PHY pipe clock interface rate */
> >>>          unsigned long pipe_clock_rate;
> >>> +
> >>> +       /* QMP PHY AUX clock interface rate */
> >>> +       unsigned long aux_clock_rate;
> >>>   };
> >>>
> >>>   struct qmp_pcie {
> >>> @@ -2420,6 +2425,7 @@ struct qmp_pcie {
> >>>          int mode;
> >>>
> >>>          struct clk_fixed_rate pipe_clk_fixed;
> >>> +       struct clk_fixed_rate aux_clk_fixed;
> >>>   };
> >>>
> >>>   static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> >>> @@ -3681,6 +3687,62 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
> >>>          return devm_clk_hw_register(qmp->dev, &fixed->hw);
> >>>   }
> >>>
> >>> +/*
> >>> + * Register a fixed rate PHY aux clock.
> >>> + *
> >>> + * The <s>_phy_aux_clksrc generated by PHY goes to the GCC that gate
> >>> + * controls it. The <s>_phy_aux_clk coming out of the GCC is requested
> >>> + * by the PHY driver for its operations.
> >>> + * We register the <s>_phy_aux_clksrc here. The gcc driver takes care
> >>> + * of assigning this <s>_phy_aux_clksrc as parent to <s>_phy_aux_clk.
> >>> + * Below picture shows this relationship.
> >>> + *
> >>> + *         +---------------+
> >>> + *         |   PHY block   |<<---------------------------------------------+
> >>> + *         |               |                                               |
> >>> + *         |   +-------+   |                      +-----+                  |
> >>> + *   I/P---^-->|  PLL  |---^--->phy_aux_clksrc--->| GCC |--->phy_aux_clk---+
> >>> + *    clk  |   +-------+   |                      +-----+
> >>> + *         +---------------+
> >>> + */
> >>> +static int phy_aux_clk_register(struct qmp_pcie *qmp, struct device_node *np)
> >>> +{
> >>> +       struct clk_fixed_rate *fixed = &qmp->aux_clk_fixed;
> >>> +       struct clk_init_data init = { };
> >>> +       int ret;
> >>> +
> >>> +       ret = of_property_read_string_index(np, "clock-output-names", 1, &init.name);
> >>> +       if (ret) {
> >>> +               dev_err(qmp->dev, "%pOFn: No clock-output-names index 1\n", np);
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       init.ops = &clk_fixed_rate_ops;
> >>> +
> >>> +       fixed->fixed_rate = qmp->cfg->aux_clock_rate;
> >>> +       fixed->hw.init = &init;
> >>> +
> >>> +       return devm_clk_hw_register(qmp->dev, &fixed->hw);
> >>> +}
> >>> +
> >>> +static struct clk_hw *qmp_pcie_clk_hw_get(struct of_phandle_args *clkspec, void *data)
> >>> +{
> >>> +       struct qmp_pcie *qmp = data;
> >>> +
> >>> +       /* Support legacy bindings */
> >>> +       if (!clkspec->args_count)
> >>> +               return &qmp->pipe_clk_fixed.hw;
> >>> +
> >>> +       switch (clkspec->args[0]) {
> >>> +       case QMP_PCIE_PIPE_CLK:
> >>> +               return &qmp->pipe_clk_fixed.hw;
> >>> +       case QMP_PCIE_PHY_AUX_CLK:
> >>> +               return &qmp->aux_clk_fixed.hw;
> >>> +       }
> >>> +
> >>> +       return ERR_PTR(-EINVAL);
> >>> +}
> >>
> >> Can we use of_clk_hw_onecell_get() instead? I think it even should be
> >> possible to use onecell for both cases, it will look at the first arg,
> >> which will be 0 in case of #clock-cells equal to 0.
> >
> > Let me investigate if it's possible
>
> Ok, it would work but it would require building a clk_hw_onecell_data a runtime,
> while we could simply provide this qmp_pcie_clk_hw_get() and avoid runtime 2 allocations.
>
> I'm not sure it's worth it.

Single allocation (or even 0 allocations if you embed it into struct
qmp_pcie) for the sake of using standard helpers.



-- 
With best wishes
Dmitry

