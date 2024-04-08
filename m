Return-Path: <linux-kernel+bounces-135174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C890689BC32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD021F229AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B164C61F;
	Mon,  8 Apr 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9Rd7gd3"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AD481DF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569536; cv=none; b=mUszU9JH6jJT9nIT53IGN0NRHuw/pC+dvYP+qWVZiD+nDQCiTlGfJTmp0IfkygMLt+RM8rizKcDwyKQoVCPfVs5Vc23kZC7xOsuxlY38qPjKw+VUwtYqbpj3ppApLCIe6KjHxvlz8wcDvyQdmlpBoQOwIR2ThHdasGmeGSR7fvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569536; c=relaxed/simple;
	bh=KY+DAHNx6+UCJpVv+nk+LdbiIGFKX8pqW1DulvmcSWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1cTKLTYTGdgpdLAcqHCMD8W3wFsDKpWi8kQIQVwDWn9GnH6zmWRaKbbWnf/lQ3h0mbucCS8ScGjMBc5kB9i/M/RAkP05A0PXpPPzkmRVO/pVpK7zgUdJl5m+UAeQ1zFnHikeeLCLD5YM+fOMisqdk6vTUZPDCXO1YcBwg1RoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j9Rd7gd3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecf3943040so2642413b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712569534; x=1713174334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjKlG7HFcBFXYjqt93Kouw6TrmHnSbztf52UQV+WNvY=;
        b=j9Rd7gd3HQNLtmkDH2+m16kpFYUxPEX781pCeZYWTowoJEnk1TnzNiUmcXuLj84eWz
         UoRcPEg3iAwjlMZEVTA4Nzl79OlTYuXYaALJPEmPEHwYOZ8tg8WSb54sKZtv4hCFuOTx
         f8pVrfRHodr5KdwYmJUX2cx0kc5OjLc4izYYapo/M5awN/8Rx4JIHcBQ78H4CJ1r9kdB
         gVThax/Nu1rnyZSqatnX34cPlEwBzChyRYgurzFLMZEtNOkRCj5SIBXfQuQiJM9xNMaI
         hsikzb/Jzbg+ow9iKGZbDB9Nj+DuuW6OipdYClZOVxgQi1ZQ151yhrmOvOmgvS1giExh
         LyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569534; x=1713174334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjKlG7HFcBFXYjqt93Kouw6TrmHnSbztf52UQV+WNvY=;
        b=mBCUXJ8rxxQ2rGFsgTDth3qdzOugYQnw7CCLc49kkie7Ok4F1mEMk3bqy+wInr/MKA
         r//FzFr7eUDw2OFpICTO9m0kLB/l1XhkSaYvvpJWTVoxKzbF8z9m4QE7qJoky4zaQ9tH
         FKVK/boZJxuEq8jU3mSStt320sqnBW7jsTsXy9OnA8y87+3d6uvJfa+Gg8Gdz51+l+23
         V7HdH21CHS6xkxjRP1Nrcq0TTYkTNa7RhmL7Ez0GdorNNSirN7lB6ka5ZMqzdc6l2TcW
         PB9fyOu4B24CLyf25Y41Hx7d4GS+zJ8BiVc5ulZ+L9soVkIS4ufVEb4Cwpo9kvs/9i5z
         ckAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Y4gEhI5k+mKOswN85PlfQqDFAkhK19yXHWhtWSFJSlvO7jiUDHBx8yPpTPGvBAa5535ubYIlTOAadVAykEyP73egAMrQKa4gV44/
X-Gm-Message-State: AOJu0Ywuc3YuYJP15rPdFphSGXvRD5pjgjNgnihq/M8R3/nOt9lrFR0U
	V0iQOPI6mrEi2cX7nnQyqT7UfTM058/mTsRqKByH1fNliF2aVuteUz8rvpu23w==
X-Google-Smtp-Source: AGHT+IEpuPiBFF2BDKbO8Rj7UX6Mr8oBg8nEkULvtOlVWNQJKZV0+AUoUnZ5PB8ldF3fIK+w/tzffw==
X-Received: by 2002:a05:6a21:189:b0:1a7:63ce:84d6 with SMTP id le9-20020a056a21018900b001a763ce84d6mr3117465pzb.42.1712569533467;
        Mon, 08 Apr 2024 02:45:33 -0700 (PDT)
Received: from thinkpad ([120.56.198.211])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001e23e8fd808sm6541055plb.217.2024.04.08.02.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:45:33 -0700 (PDT)
Date: Mon, 8 Apr 2024 15:15:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v9 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240408094525.GB5727@thinkpad>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
 <20240407-opp_support-v9-6-496184dc45d7@quicinc.com>
 <20240407150048.GE2679@thinkpad>
 <6e9b4379-5849-73cd-4d89-5e809b4c71a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e9b4379-5849-73cd-4d89-5e809b4c71a4@quicinc.com>

On Mon, Apr 08, 2024 at 02:32:18PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/7/2024 8:30 PM, Manivannan Sadhasivam wrote:
> > On Sun, Apr 07, 2024 at 10:07:39AM +0530, Krishna chaitanya chundru wrote:
> > > QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> > > maintains hardware state of a regulator by performing max aggregation of
> > > the requests made by all of the clients.
> > > 
> > > PCIe controller can operate on different RPMh performance state of power
> > > domain based on the speed of the link. And this performance state varies
> > > from target to target, like some controllers support GEN3 in NOM (Nominal)
> > > voltage corner, while some other supports GEN3 in low SVS (static voltage
> > > scaling).
> > > 
> > > The SoC can be more power efficient if we scale the performance state
> > > based on the aggregate PCIe link bandwidth.
> > > 
> > > Add Operating Performance Points (OPP) support to vote for RPMh state based
> > > on the aggregate link bandwidth.
> > > 
> > > OPP can handle ICC bw voting also, so move ICC bw voting through OPP
> > > framework if OPP entries are present.
> > > 
> > > Different link configurations may share the same aggregate bandwidth,
> > > e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
> > > and share the same OPP entry.
> > > 
> > 
> > This info should be part of the dts change.
> > 
> ok I will move this to dts patch in next patch series.
> > > As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
> > > is supported.
> > > 
> > > Before PCIe link is initialized vote for highest OPP in the OPP table,
> > > so that we are voting for maximum voltage corner for the link to come up
> > > in maximum supported speed.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 72 +++++++++++++++++++++++++++-------
> > >   1 file changed, 58 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index b4893214b2d3..4ad5ef3bf8fc 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -22,6 +22,7 @@
> > >   #include <linux/of.h>
> > >   #include <linux/of_gpio.h>
> > >   #include <linux/pci.h>
> > > +#include <linux/pm_opp.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/phy/pcie.h>
> > > @@ -1442,15 +1443,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> > >   	return 0;
> > >   }
> > > -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> > > +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
> > >   {
> > >   	struct dw_pcie *pci = pcie->pci;
> > > -	u32 offset, status;
> > > +	u32 offset, status, freq;
> > > +	struct dev_pm_opp *opp;
> > >   	int speed, width;
> > > -	int ret;
> > > -
> > > -	if (!pcie->icc_mem)
> > > -		return;
> > > +	int ret, mbps;
> > >   	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > >   	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> > > @@ -1462,10 +1461,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> > >   	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> > >   	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> > > -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> > > -	if (ret) {
> > > -		dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
> > > -			ret);
> > > +	if (pcie->icc_mem) {
> > > +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> > > +		if (ret) {
> > > +			dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
> > 
> > s/failed/Failed
> > 
> > > +				ret);
> > > +		}
> > > +	} else {
> > > +		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
> > > +		if (mbps < 0)
> > > +			return;
> > > +
> > > +		freq = mbps * 1000;
> > > +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
> > 
> > As per the API documentation, dev_pm_opp_put() should be called for both success
> > and failure case.
> > 
> ACK.
> > > +		if (!IS_ERR(opp)) {
> > 
> > So what is the action if OPP is not found for the freq?
> > 
> There is already a vote for maximum freq in the probe, so if it fails
> here we can continue here.
> If you feel otherwise let me know I Can make changes as suggested.

You should just log the error and continue.

> > > +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> > > +			if (ret)
> > > +				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
> > 
> > 'Failed to set OPP for freq (%ld): %d'
> > 
> > > +					dev_pm_opp_get_freq(opp), ret);
> > > +			dev_pm_opp_put(opp);
> > > +		}
> > >   	}
> > >   }
> > > @@ -1509,8 +1524,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> > >   static int qcom_pcie_probe(struct platform_device *pdev)
> > >   {
> > >   	const struct qcom_pcie_cfg *pcie_cfg;
> > > +	unsigned long max_freq = INT_MAX;
> > >   	struct device *dev = &pdev->dev;
> > >   	struct qcom_pcie *pcie;
> > > +	struct dev_pm_opp *opp;
> > >   	struct dw_pcie_rp *pp;
> > >   	struct resource *res;
> > >   	struct dw_pcie *pci;
> > > @@ -1577,9 +1594,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >   		goto err_pm_runtime_put;
> > >   	}
> > > -	ret = qcom_pcie_icc_init(pcie);
> > > -	if (ret)
> > > +	/* OPP table is optional */
> > > +	ret = devm_pm_opp_of_add_table(dev);
> > > +	if (ret && ret != -ENODEV) {
> > > +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
> > >   		goto err_pm_runtime_put;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Use highest OPP here if the OPP table is present. At the end of
> > 
> > I believe I asked you to add the information justifying why the highest OPP
> > should be used.
> > 
> I added the info in the commit message, I will add as the comment in the
> next patch.
> 
> > > +	 * the probe(), OPP will be updated using qcom_pcie_icc_opp_update().
> > > +	 */
> > > +	if (!ret) {
> > > +		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> > 
> > Same comment as dev_pm_opp_find_freq_exact().
> > 
> > > +		if (!IS_ERR(opp)) {
> > > +			ret = dev_pm_opp_set_opp(dev, opp);
> > > +			if (ret)
> > > +				dev_err_probe(pci->dev, ret,
> > > +					      "Failed to set OPP: freq %ld\n",
> > 
> > Same comment as above.
> > 
> > > +					      dev_pm_opp_get_freq(opp));
> > > +			dev_pm_opp_put(opp);
> > 
> > So you want to continue even in the case of failure?
> > 
> I wil make changes to fallback to driver voting for icc bw if it fails here.

That's not needed. If the OPP table is present, then failure to set OPP should
be treated as a hard failure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

