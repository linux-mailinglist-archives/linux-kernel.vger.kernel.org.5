Return-Path: <linux-kernel+bounces-13171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528848200AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E701C210DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4512B75;
	Fri, 29 Dec 2023 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1U6Vteg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AF12B6B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68015293aa3so18837846d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703869818; x=1704474618; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bn7Ypr1yINWIrF1HsU+9Oaoc2yoSbevJLsQCr58V/sc=;
        b=Y1U6VtegJF6D5UfqzdCATQZHq+jDXOJOXMRW9iNHWTiHJmeigFHD4IObfLCnMSEFGZ
         BbxASrfi9jrDomb2C2u+mXBMV+ZoFVuy0wQYu3ys8Deyi0Gr54xkiOiJyw5Ob/zepOpj
         yRw8N6lcky5+6LVm8utLMF0VnTdyN8KusGYijwZXxN4uAvwqGqcxtlhlKta6fjyRdCP2
         0irugM5uBUop6gTBuWiZwsgRs/Fn+KTeL0URihIEKsX4oBWO0rAEm/nz3noEXtCyFz8v
         Qnz+PaD9XostiIHP4B+d+6Cd1FIRwHzt4M9Hf4cafDwojTBy32Aj3saVaLMI9aKlsxu0
         KdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703869818; x=1704474618;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bn7Ypr1yINWIrF1HsU+9Oaoc2yoSbevJLsQCr58V/sc=;
        b=jPYeHFQ1kFo2JgIi+11TjHE8Nxu6f83jRxgwvKizl/6Yjj3vB6cGkcGSwL7I87pLL1
         gHGwdjWJ8Cyeax6jlhvGZ7nrF9clC98nUigGcyiEEFLMzD2Gz/KY70OkHZoqIqN0CPHA
         I6D3R40Gy/gKngGzgqr2nByhtK7L0vYWcn0t9lntfcuQIF4syW1TjFiP4lAGlPKoHMqm
         9QTDgfv8vksgNUtRsT1pDCI3BTOzG6YHSGqOUJyGK6dUv6Mkm5wPh9+T/vsg1QgFZo16
         OUTyyFfE9f3so6y4bqDBcMtGM9MxoDbhFZ3iABpnAxa1T5rZKkeYTbLLMUffH7Qb3Zz3
         P24g==
X-Gm-Message-State: AOJu0YzF9372Xm917BeJW68GTZBpKDGqpnr4iQ85zcGqsjMegJMuET2b
	GUrN9PlQx66AIBu7k9Wb8dsHQxW3NVDm
X-Google-Smtp-Source: AGHT+IFOtfZk5ygOqwlXAAgl64auJMA1fyIe+Ru1+46ug74bAuW5Qg0DbNqPe5nRjj9BaEWs7QXTtQ==
X-Received: by 2002:a05:6214:a51:b0:67f:cf88:9912 with SMTP id ee17-20020a0562140a5100b0067fcf889912mr6376835qvb.107.1703869818571;
        Fri, 29 Dec 2023 09:10:18 -0800 (PST)
Received: from thinkpad ([117.207.24.172])
        by smtp.gmail.com with ESMTPSA id t7-20020a056214118700b0067f80a27790sm7161516qvv.37.2023.12.29.09.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 09:10:18 -0800 (PST)
Date: Fri, 29 Dec 2023 22:40:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Correct USB PHY power
 domains
Message-ID: <20231229171008.GB9098@thinkpad>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>
 <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZY7DEpaIgvfL_A11@hovoldconsulting.com>

On Fri, Dec 29, 2023 at 02:01:06PM +0100, Johan Hovold wrote:
> On Wed, Dec 27, 2023 at 11:28:27PM +0100, Konrad Dybcio wrote:
> > The USB GDSCs are only related to the controllers.
> 
> Are you sure?
> 

Yes, that's what I was told by UFS and PCIe teams and some of the internal
documentation also confirms the same.

> > The PHYs on the other
> > hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.
> > 
> > Fix the power-domains assignment to stop potentially toggling the GDSC
> > unnecessarily.
> 
> Again, there's no additional toggling being done here, but yes, this may
> keep the domains enabled during suspend depending on how the driver is
> implemented.
> 
> If that's the concern, then please spell that out too.
> 
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> 
> May not be needed either.
> 

Fixes tag is indeed needed on this platform and all other platforms too.

- Mani

> > @@ -2597,7 +2597,7 @@ usb_2_qmpphy0: phy@88ef000 {
> >  				 <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>;
> >  			reset-names = "phy", "phy_phy";
> >  
> > -			power-domains = <&gcc USB30_MP_GDSC>;
> > +			power-domains = <&rpmhpd SC8280XP_MX>;
> 
> Johan
> 

-- 
மணிவண்ணன் சதாசிவம்

