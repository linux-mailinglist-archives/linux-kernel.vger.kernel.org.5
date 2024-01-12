Return-Path: <linux-kernel+bounces-24805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8582C2CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307DA1C219CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AB66EB66;
	Fri, 12 Jan 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSEqMrNr"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606EF6EB57
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5fa4b03f3f5so36911967b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705073620; x=1705678420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0J+mgh+Zx+BAS24mdFPK/hF26M4UfTo4a+waDKfwV38=;
        b=xSEqMrNrtva8qJE+8pN8jfCKWt8b8fSN89Ls0r5uAyTiH8DZr0S1n+KbOGjWcD7qi4
         oDTaPwfPQFKIxNGVU6TbSRfLZ40aqXJ/FLEzXos0jKJH5p+qlsdd5ioDuH+q4qI+DSH/
         F7Qs+CqvLzczbLRehW4Mv5kLQLW0Sm7L8h9sZ39OYIf1bpOZcItk+YTgW090zhV01VFU
         /1VbVqK48srVk/YAOo1tB/Hi+NEh39HCHGZWwOgiNxSdsYNcqBXSkCrsYtVGFPc1E6H4
         Ok+Wbcjy2mHeQgdjtlqvm5XExyOirh35OzJ/9Gt/UcXDy3SWJ47U/q5SnfTr85Hio38b
         EH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705073620; x=1705678420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J+mgh+Zx+BAS24mdFPK/hF26M4UfTo4a+waDKfwV38=;
        b=tCO/YPusIlNRvaPXjEgxNUvAVl8POo++PaOjnQaQ5TSVq2hhdpRdKCCXaPvihMokeJ
         r1LFZPyqUoBIc6Z5nnhefdV/mNTUb+Fjb6XX2u2DEK9nocc3QgAkORxbo5NKKM89dACb
         cQ6BYfkEZz9z/q5RXlBTuNEV7jyPfiRa+fRz8F7EupQ8XN+YU27zt4rqoUva1oEFzVA7
         +CH0x5eT+ciZLq9aphWeOEDXRSHQDt7Rwva2qrI/XS0nAEiMjcZiopnNneHRpP7KM8fu
         KI6i7UqUxtvB4ia1TtNqpuGgHK1VmNPchRhIqCsYKtMZeeyvtsUTHwHWs+fJNQ0U6Fbk
         6oig==
X-Gm-Message-State: AOJu0YwYsE6EFKaIKVnl38671QTj9z9hm8EKPjouAYqHn0cIynl/5HMy
	zNn71n2xQXrvQgsU5AEbiP0b1TXLBTSc4wxJm/TjFPtnVeyWtA==
X-Google-Smtp-Source: AGHT+IGHEFK/VO2iCL3+a+f40HQuY1B4l5ByHYvCrVdLkznfELnIJyvNlwXygCRWvzwslHJ2QXGBP8yc4cCPvTndIvI=
X-Received: by 2002:a0d:d507:0:b0:5fb:bfa4:f6f7 with SMTP id
 x7-20020a0dd507000000b005fbbfa4f6f7mr1325370ywd.78.1705073619964; Fri, 12 Jan
 2024 07:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com> <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
In-Reply-To: <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 12 Jan 2024 17:33:28 +0200
Message-ID: <CAA8EJpqwOfeS-QpLVvYGf0jmTVxiT02POwK+9tkN03Cr4DgL+g@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org, vireshk@kernel.org, 
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 16:25, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the processors.
>
> PCIe controller can operate on different RPMh performance state of power
> domain based up on the speed of the link. And this performance state varies
> from target to target.
>
> It is manadate to scale the performance state based up on the PCIe speed
> link operates so that SoC can run under optimum power conditions.
>
> Add Operating Performance Points(OPP) support to vote for RPMh state based
> upon GEN speed link is operating.
>
> OPP can handle ICC bw voting also, so move icc bw voting through opp
> framework if opp entries are present.
>
> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
> same icc bw and has frequency, so use frequency based search to reduce
> number of entries in the opp table.
>
> Don't initialize icc if opp is supported.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 83 ++++++++++++++++++++++++++++------
>  1 file changed, 70 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 035953f0b6d8..31512dc9d6ff 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -22,6 +22,7 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/pcie.h>
> @@ -244,6 +245,7 @@ struct qcom_pcie {
>         const struct qcom_pcie_cfg *cfg;
>         struct dentry *debugfs;
>         bool suspended;
> +       bool opp_supported;
>  };
>
>  #define to_qcom_pcie(x)                dev_get_drvdata((x)->dev)
> @@ -1404,16 +1406,14 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>         return 0;
>  }
>
> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>         struct dw_pcie *pci = pcie->pci;
> -       u32 offset, status;
> +       u32 offset, status, freq;
> +       struct dev_pm_opp *opp;
>         int speed, width;
>         int ret;
>
> -       if (!pcie->icc_mem)
> -               return;
> -
>         offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>         status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>
> @@ -1424,11 +1424,42 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>         speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>         width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>
> -       ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -       if (ret) {
> -               dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -                       ret);
> +       if (pcie->opp_supported) {
> +               switch (speed) {
> +               case 1:
> +                       freq = 2500000;
> +                       break;
> +               case 2:
> +                       freq = 5000000;
> +                       break;
> +               case 3:
> +                       freq = 8000000;
> +                       break;
> +               default:
> +                       WARN_ON_ONCE(1);
> +                       fallthrough;
> +               case 4:
> +                       freq = 16000000;

I expected that this kind of detail goes to the OPP table itself. Can
we index the table using the generation instead of frequency?

> +                       break;
> +               }
> +
> +               opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
> +               if (!IS_ERR(opp)) {
> +                       ret = dev_pm_opp_set_opp(pci->dev, opp);
> +                       if (ret)
> +                               dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
> +                                       dev_pm_opp_get_freq(opp), ret);
> +                       dev_pm_opp_put(opp);
> +               }
> +       } else {
> +               ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +               if (ret) {
> +                       dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
> +                               ret);
> +               }
>         }
> +
> +       return;
>  }
>
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> @@ -1471,8 +1502,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>         const struct qcom_pcie_cfg *pcie_cfg;
> +       unsigned long max_freq = INT_MAX;
>         struct device *dev = &pdev->dev;
>         struct qcom_pcie *pcie;
> +       struct dev_pm_opp *opp;
>         struct dw_pcie_rp *pp;
>         struct resource *res;
>         struct dw_pcie *pci;
> @@ -1539,9 +1572,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>                 goto err_pm_runtime_put;
>         }
>
> -       ret = qcom_pcie_icc_init(pcie);
> -       if (ret)
> +        /* OPP table is optional */
> +       ret = devm_pm_opp_of_add_table(dev);
> +       if (ret && ret != -ENODEV) {
> +               dev_err_probe(dev, ret, "Failed to add OPP table\n");
>                 goto err_pm_runtime_put;
> +       }

Can we initialise the table from the driver if it is not found? This
will help us by having the common code later on.

> +
> +       /* vote for max freq in the opp table if opp table is present */
> +       if (ret != -ENODEV) {
> +               opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> +               if (!IS_ERR(opp)) {
> +                       ret = dev_pm_opp_set_opp(dev, opp);
> +                       if (ret)
> +                               dev_err_probe(pci->dev, ret,
> +                                             "Failed to set opp: freq %ld\n",
> +                                             dev_pm_opp_get_freq(opp));
> +                       dev_pm_opp_put(opp);
> +               }
> +               pcie->opp_supported = true;
> +       }
> +
> +       /* Skip icc init if opp is supported as icc bw vote is handled by opp framework */
> +       if (!pcie->opp_supported) {
> +               ret = qcom_pcie_icc_init(pcie);
> +               if (ret)
> +                       goto err_pm_runtime_put;
> +       }
>
>         ret = pcie->cfg->ops->get_resources(pcie);
>         if (ret)
> @@ -1561,7 +1618,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>                 goto err_phy_exit;
>         }
>
> -       qcom_pcie_icc_update(pcie);
> +       qcom_pcie_icc_opp_update(pcie);
>
>         if (pcie->mhi)
>                 qcom_pcie_init_debugfs(pcie);
> @@ -1640,7 +1697,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>                 pcie->suspended = false;
>         }
>
> -       qcom_pcie_icc_update(pcie);
> +       qcom_pcie_icc_opp_update(pcie);
>
>         return 0;
>  }
>
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry

