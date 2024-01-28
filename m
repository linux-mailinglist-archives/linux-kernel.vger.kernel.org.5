Return-Path: <linux-kernel+bounces-42005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF5783FA96
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841F71C22373
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD78446C7;
	Sun, 28 Jan 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQfos9Re"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B26446C6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482742; cv=none; b=NyCplyAIeJA9IYq0mF0zdxMRipPCVNBDperz0f6aSK+Dwr5Dr7SdGDmvTxd/1EzJB0BUfXHgLEv4ud9t6/jlKEFndTCerJxNaOVGRtz6GGWymQ7KMV5NfIRM+gQmdxoeR1iwZh6yMp1emDxIyt38n3NS8uR6CMv/MtkYGzfJQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482742; c=relaxed/simple;
	bh=VJ691p0rG2lhrLQYWNJKiUWNgiR1RWZ14Y+uzUSDIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg4H/fH5PNDKX2OX6XNPJoyc3eeyuePPhHavg4ejBcKCjmrBfdRWpU+MlYjgi2RfpJfdGLIvNb8kdTDjHaVb+x/4HC10+qBimG2+IF/8LetjVqTSqJZiwHAuq/fAKnxfb3HDV/Kit6WnDercrPB81TTrspVTg+mfGxGdhdE4e2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQfos9Re; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a349ed467d9so212437166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706482738; x=1707087538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzna56o//MGsmfpwSmKQRj0hVm8wxi5OhfOIXFUcXf4=;
        b=iQfos9Re0X+54hByXh8LwuwPsJ7yYw7bFhJeiYuDTI+KUTP1WBTQh8X9kEkVZaS5Pn
         kN7yI/Q2iQS4q+tdq+SAWugm937VF+4LI3IEcrudkmykxqHYz/f3c+rrXQWiwhy3ITVL
         HI9R7sKH8zhKTE4ILy5qsobFip/3H+wQeveVM2bpJWDsznL9C9FlTIfQBccnebWWO85h
         b/ZwDwPtK6Av5Tl3oUa5nAtIroEfXlZm0CZrgLrvuLMMzPyLqV0k3I8gqLqhDr3IP8Kx
         RO5bFVEzejvBTVaBSyqnnnOxvDKfwb8S77zLIUPFxaNg07JBbY/Xo7dHc1Vkz6xJ2Nco
         z/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482738; x=1707087538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzna56o//MGsmfpwSmKQRj0hVm8wxi5OhfOIXFUcXf4=;
        b=vmfTVz+PYdsBqPbDMvVLtmm1taS7JZmG+/T6bOvT5UT2xp8xiy/J/bfTFDOCvb8wxR
         PeYrwm/GkTKlbAseo7gxFsSRGMc2ShXEyKWnKhn5bOzgiKUQWSapUh1Qcx9dyDCvHod9
         UtZUN2IDglDO8BcztAFZ3RSEv9oMZahmMDOrxlE+Q5U1ARATnvECPKpMhvsdQqQcJ/ny
         pLA+XzUi5OQolRq1s/FbdhoRe2P0aEIowAKLLnca/VoDtKw/QEk8htLgnGu7SaRYO/y+
         qq1dRLNItQtEPRsEemt/S9KXF3/lIOm4GngMPEamuj7mCubefyckZSn3VW30C4AvILcC
         VROA==
X-Gm-Message-State: AOJu0Yxu2Vw7DRclZByxoeK71wfGZvSCsu0RrCPY9G/bVoCqt93fmtze
	8z3o0u8Ia+h6o0bXRmPr7n36605hB0OnbeehtjtQRXekNwJ1JVhIAdx6RmkFG5U=
X-Google-Smtp-Source: AGHT+IGw24Mwj2tHUukeZIgkpkX7q8I0DbdvbOxzkMf4ibUg5qsi3PtOnr1aWhH1nOejHpqXEowI1A==
X-Received: by 2002:a17:906:1b09:b0:a34:a6af:22f1 with SMTP id o9-20020a1709061b0900b00a34a6af22f1mr3060423ejg.62.1706482738427;
        Sun, 28 Jan 2024 14:58:58 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906354f00b00a3186c2c254sm3250339eja.213.2024.01.28.14.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:58:58 -0800 (PST)
Date: Mon, 29 Jan 2024 00:58:56 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] arm64: dts: qcom: Add more support to X1E80100
 base dtsi, CRD and QCP boards
Message-ID: <ZbbcMFXdL/kmJ61v@linaro.org>
References: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
 <ui5a4sr2wa4nta6uvvlejtwuus7uuj54iirddretysd6hcgv3k@iabyr65abxhi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ui5a4sr2wa4nta6uvvlejtwuus7uuj54iirddretysd6hcgv3k@iabyr65abxhi>

On 24-01-27 20:36:33, Bjorn Andersson wrote:
> On Fri, Jan 26, 2024 at 12:00:11PM +0200, Abel Vesa wrote:
> > This patchset adds every node necessary for both the CRD and QCP to boot
> > with PCIe, USB and embedded DisplayPort.
> > 
> > This patchset depends on the Disp CC and TCSR CC bindings.
> 
> I'm guessing you're referring to the patches from December, which has
> review feedback from your colleagues?
> 
> Please respin the clock series.

Was trying to figure out the GCC_DISP_AHB_CLK pm_clk_add()-ed to the
dispcc. But as discussed off-list, GCC_DISP_XO_CLK falls into same
category and I'm not sure what it is tied to (yet).

Anyway, that should be a separate patchset as it should fix SM8550 and
SM8650 as well.

Meanwhile, here are the clock controllers:
https://lore.kernel.org/r/20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org

> 
> Thanks,
> Bjorn
> 
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v5:
> > - Added Konrad's R-b tags to patches 1 through 4 and A-b tag to patch 11
> > - Changed the clock of the usb2 HS PHY to TCSR_USB2_2_CLKREF_EN, the USB1
> >   SSx HS PHY seem to be sharing the TCSR_USB2_1_CLKREF_EN
> > - Prefixed DISP_CC_MDSS_CORE_* gdscs with MDSS_* to be more in line with
> >   SM8[56]50 platforms.
> > - Added "cpu-cfg" icc path to the mdss node.
> > - Marked all USB1 SS[1-3] controllers as dma coherent.
> > - Re-worded the adding TCSR node commit message by just dropping the
> >   "halt" word as the halt registers are not part of this region. The
> >   TCSR offers more than just a clock controller and therefore called it
> >   generically "TCSR register space".
> > - Link to v4: https://lore.kernel.org/r/20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org
> > 
> > Changes in v4:
> > - After a discussion off-list, it was suggested by Bjorn to split in separate patches.
> > - Addressed all of Konrad's comments, except of the clock-names one for the mdss,
> >   which there is nothing to be done about as all non-v5 do clk_bulk_get_all.
> > - Added more support to QCP, to be more aligned with CRD (except touchscreen
> >   and keyboard)
> > - Added a patch to fix some LDOs supplies on QCP
> > - Link to v3: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v3-0-c4e8d186adf2@linaro.org
> > 
> > Changes in v3:
> > - Reword the commit messages
> > - Link to v2: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v2-0-5a6efc04d00c@linaro.org
> > 
> > Changes in v2:
> > - Reword both commits to make it more clear nodes that are being added
> > - Dropped comments from interrupt maps from pcie nodes
> > - Replace all 0x0 with 0 in all reg properties
> > - Moved on separate lines reg, reset and clock names
> > - Dropped the sram and cpucp nodes
> > - Dropped pmic glink node
> > - Reordered all new clock controller nodes based on address
> > - Dropped unnecessary indent from touchpad and keyboard TLMM nodes
> > - Link to v1: https://lore.kernel.org/r/20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org
> > 
> > ---
> > Abel Vesa (7):
> >       arm64: dts: qcom: x1e80100: Add TCSR node
> >       arm64: dts: qcom: x1e80100: Add USB nodes
> >       arm64: dts: qcom: x1e80100: Add PCIe nodes
> >       arm64: dts: qcom: x1e80100: Add display nodes
> >       arm64: dts: qcom: x1e80100-crd: Enable more support
> >       arm64: dts: qcom: x1e80100-qcp: Enable more support
> >       arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J
> > 
> > Sibi Sankar (4):
> >       arm64: dts: qcom: x1e80100: Add IPCC node
> >       arm64: dts: qcom: x1e80100: Add SMP2P nodes
> >       arm64: dts: qcom: x1e80100: Add QMP AOSS node
> >       arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes
> > 
> >  arch/arm64/boot/dts/qcom/x1e80100-crd.dts |  222 +++++
> >  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts |  175 +++-
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 1368 ++++++++++++++++++++++++++++-
> >  3 files changed, 1758 insertions(+), 7 deletions(-)
> > ---
> > base-commit: 853dab01a34378871b37a5e6a800e97a997fe16c
> > change-id: 20231201-x1e80100-dts-missing-nodes-a09f1ed99999
> > 
> > Best regards,
> > -- 
> > Abel Vesa <abel.vesa@linaro.org>
> > 

