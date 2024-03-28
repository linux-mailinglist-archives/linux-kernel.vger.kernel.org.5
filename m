Return-Path: <linux-kernel+bounces-101658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478FB87A9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA4D2854FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECDD46441;
	Wed, 13 Mar 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3LQq+qn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEA45942
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342172; cv=none; b=gZEBGBKNtVXCA3RN2VbMUwkj1rqPEz0qBZlSSJhUfBcmhXkQOrGHr7tjPmMECXfJrlfK1lTo4WZTNTH5cAsQEMXBvlNtQc6HAMmGqFWERJ72AbNdh/rS7qhtRFkcG0O/AP3rHZu7O2DftOkwt+mbf0rblwOdmfBuwxw99hWZ2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342172; c=relaxed/simple;
	bh=M3rZB2mfjzbY+mEbtIQebEVLPHXxIpa8VoDp8iBqC8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usrthd2jG8LJJ89GtlSU7xa4sVuWl0Z3GNvdNR1LS0p1vVl55PwsRDtZPWnbiBbyqNVZ/JY6yUl8Ve0EUXo7ckS4GJz+a0c754DZCE9jJNBFQ7aHKpFKT0aWm117GqMix3vAhYQKt6OfflxIb3UdG1Ml2Zae7kzOFwf0ZTBPIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3LQq+qn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd922cbcc7so28490555ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710342170; x=1710946970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jfij9dXHIDj9rmOGh+MeYJy8++dhkqBgca6X7NgY2Qw=;
        b=b3LQq+qnZ8wxX/YLZnHbVcqYflHqf5B/sGWSI5IrYMTMREPif+taM9ryzKZLCHV/Y2
         29beR6KI02s6L1j/cEIA2oO0eIz86IjFwbxRbaWyphk4PgWcwkZ+YepVmKeqhi63bqx0
         w5eSOvrfaQgK1rJffRfg0h3hs19CBq6xAgl1JDXyaSLrzc2PGzr1JfKo2orKINJeVYYr
         ebglrikTSqs2DbJIjxFhw4CXB7TGvminx2Qqeuw3/QAzJNaW78Vti9Q0M1VTWV1r2ux8
         IkaIpjKN0WBO+FErqLNHeazsZyIpVfN+GI6neficQTs/Q7naIyqMKL+L93CKdYU2HaPF
         wtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342170; x=1710946970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfij9dXHIDj9rmOGh+MeYJy8++dhkqBgca6X7NgY2Qw=;
        b=TtugQKfvY+rv2JQJV/qXKmmAT5Deca96HeOun/cNLaU1uW9+ZO9cvNTbI1C2n4WSp3
         GHx8jz3HnIKpzMbRGRyvmM07kDMzCq0rSOy5yxc4i/kaOu2XRI5KBEXSR4G3wUnI8YZs
         nQqor2wpJuemzwJ7zX4Wz+pXaDy8w+NN/Z5HSdDEKYfwiWmra/Vji1Bp6sYhTwrtdN/F
         wt76pfozOl8/pNDSUb1SEv6qGOrnG4JIn2LiLUlh3ZvHhQwqlUz7SDaQqKXpjqADOUUp
         gPLwbUZpU1qcUsEwQRU+XozR4wBTqihdUkI9fU5Vet9mcAtOUDcA8pV+VNpkembHZvcm
         +qhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1tdTjD5Z1HF0deITdGpbZpFSDPR4p7lxQKsOEJ76LfZBHiHhBJeuGpZGQDKqFvVKkUw6j+KWiuEkvWA1rElG2Me09/O+kV48UFf33
X-Gm-Message-State: AOJu0Yy4L/7FvsT28+52HovbB2I8Sag5HU9+img+loc/6eWTCsUNfjFe
	63n2iSUi73CCrjW5Z7Nhr+u3T+RKt1X4jA+c1XMTozoU0mhgrB5sgDdOupZD6w==
X-Google-Smtp-Source: AGHT+IEUBRSfm5jxLzMUkvJnOZ0wxVinWuUhkiXEaLkjXUOM1flKmlbWFV8LK6g2WXaQLj7Cuw1ToA==
X-Received: by 2002:a17:902:d4c5:b0:1dd:90ce:4e43 with SMTP id o5-20020a170902d4c500b001dd90ce4e43mr13804843plg.11.1710342169628;
        Wed, 13 Mar 2024 08:02:49 -0700 (PDT)
Received: from thinkpad ([117.213.99.94])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001dd8e1db1b1sm7135187pla.175.2024.03.13.08.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:02:49 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:32:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback to properly
 reset the endpoint devices
Message-ID: <20240313150242.GA2656@thinkpad>
References: <20240313-pci-qcom-shutdown-v1-1-fb1515334bfa@linaro.org>
 <20240313143614.GA916555@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313143614.GA916555@bhelgaas>

On Wed, Mar 13, 2024 at 09:36:14AM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 13, 2024 at 05:39:22PM +0530, Manivannan Sadhasivam wrote:
> > PCIe host controller drivers are supposed to properly reset the endpoint
> > devices during host shutdown/reboot. Currently, Qcom driver doesn't do
> > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > getting disabled at the same time. This prevents the endpoint device
> > firmware to properly reset the state machine. Because, if the refclk is
> > cutoff immediately along with PERST#, access to device specific registers
> > within the endpoint will result in a firmware crash.
> > 
> > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > delay of 1ms, thus allowing the endpoint device firmware to properly
> > cleanup the state machine.
> 
> I guess this 1ms delay is the PERST_DELAY_US hidden inside
> qcom_ep_reset_assert()?  I assume the refclk disable is done by
> clk_bulk_disable_unprepare()?
> 

Yes to both.

>   #define PERST_DELAY_US 1000
> 
>   qcom_pcie_shutdown
>     qcom_pcie_host_deinit
>       qcom_ep_reset_assert
>         gpiod_set_value_cansleep(pcie->reset, 1);
>         usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);  <--
>       phy_power_off(pcie->phy)
>       pcie->cfg->ops->deinit()
>         qcom_pcie_deinit_...
>           clk_bulk_disable_unprepare                         <--
> 
> Is there a spec citation for this delay requirement?  If not, how do
> we know 1ms is enough for whatever the firmware needs to do?
> 

Both PCIe base spec and Electromechanical spec only mentions Tperst, which is
the minimum time PERST# should remain asserted. But there is no mention about
the time, refclk should be active.

So I used the existing delay post PERST# assert in the driver. I do not know if
that is enough for all the endpoints out in the wild, but atleast satisfies the
requirement of the endpoint I'm working on (which is another Qcom SoC in EP
mode).

We can change the delay if someone reports any issue with the existing one.
Atleast, that's the best we could do in this situation.

> Do other drivers require similar changes?
> 

Most likely yes, but that also depends on when the drivers are cutting off the
refclk. Not all drivers are implementing the shutdown callback, and even few of
the ones implementing, do not assert PERST# since it is optional.

- Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 2ce2a3bd932b..41434bc4761a 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1618,6 +1618,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static void qcom_pcie_shutdown(struct platform_device *pdev)
> > +{
> > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > +
> > +	qcom_pcie_host_deinit(&pcie->pci->pp);
> > +}
> > +
> >  static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > @@ -1670,5 +1677,6 @@ static struct platform_driver qcom_pcie_driver = {
> >  		.pm = &qcom_pcie_pm_ops,
> >  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >  	},
> > +	.shutdown = qcom_pcie_shutdown,
> >  };
> >  builtin_platform_driver(qcom_pcie_driver);
> > 
> > ---
> > base-commit: 51459eb30f88651d3688b9e95fed0f97767ececb
> > change-id: 20240313-pci-qcom-shutdown-d86298186560
> > 
> > Best regards,
> > -- 
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 

-- 
மணிவண்ணன் சதாசிவம்

