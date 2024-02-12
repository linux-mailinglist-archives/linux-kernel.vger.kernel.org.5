Return-Path: <linux-kernel+bounces-61665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D1851521
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037CA1C21F11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDB3C473;
	Mon, 12 Feb 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKqs7Zx2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D5F3A8E3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743762; cv=none; b=DB0SDwED/pYfdNWrQGRf47GRGjQh1fFRYKsqJS0oUPzc8BvjKy5fiQ7o9I2mGe3qokK1YL+xiRUGhBZPWYODztu0Xug4OJ2+YvyuVn3GJE2OQt3m3+D9CRaP7F2tK4DcYLQPbSLdErrphtUDJ68RhgUqEF5OvJFM+CpyJAOp90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743762; c=relaxed/simple;
	bh=54HbHFwCCbg3M+0SBKCgliN6Fh7ZVO5xk5OXJIIAeL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDAXolv6yj9joRFSY3KAwu6OVM056iDUCkxeERoD6f3mxyIFe/qDrmv1UPpmcME0PjdGk7ffUHT+SJC8NJlrhoFMzAvmg2aUAEcHghUvlTHsywTJ6Jl+T6AFup2ust8IJ298iXAPuhw+ax+oMD/g4QX6tUHnSU7viKM+aJ0a+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HKqs7Zx2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0a9e9df2dso569093b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743759; x=1708348559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OeXYUde/gNeerB7H1YgPniVL9J1+gk3sOmdNHfWxiOI=;
        b=HKqs7Zx2UPHK7N7T7o+TILjKcFQ/dWsOJJM79yiXosfgDMt29amrtIoeBUvLMAmoLC
         SzfvmiGUDqfwgmsPBH8RBpQgGgGwZpgXDFMyM7SF+KVBeibJkxuuwrAnhp0ix0pZIrK3
         9ztUrigwfrU0rrEkKi+qzogmpdw2tfq+Yg5P47sj0EexSnl+8KHu7ZbZxautSu/mrwps
         wAyszKHBZQZ2s6RMliP1pnbTLdjiL07xPl23SPpA6etEE/+SuYo8mmgrycye2hti24jA
         UYnvEvWhWRjMZttVkS6UwMzKVg7MW5xBifT6iJn+XQTtynAEC40Qdj7zERFxQoOE9f5T
         gEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743759; x=1708348559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeXYUde/gNeerB7H1YgPniVL9J1+gk3sOmdNHfWxiOI=;
        b=SK4j/Hg/d6XdZTZ/1Mmt7pEI8HdrZEgL8q7KZJVC8qMMifgJCAsAIG1FqiY+mk5V4B
         JNT/zuJjSfNlEuEpDnYayvp40Drvuv/sxjJ/KXpUpv29qMrZtprmaLuNQGpYH0DP3AgH
         hkK8fP1f79xgSM5x6RhRCUDIf4mQ86kvB2w5rc32ToOrkD8WAarZrU+UhY9lZSGSCTAE
         iSUhnqs/ifZC7An7M+GtcRaKabyJxGb+4DK3vQKtyOaZiRUmzbm4PsACdDuXx45ol0ez
         rZpbCr2uIpsW1rcYYp1KyOieL8SeI5E8tbgns3HcqnYBjPDTEHQgYehckh8baruMnOfa
         d4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqiNXpudNQ/+w9+NW4odtIAXdwGEdshLbLRpOLi4BEUSaXU//V0qEn2Mskj+2WP/vRbb7O9FSuA1e0pPFP2RnDUQmQkvGa3nMAMOFp
X-Gm-Message-State: AOJu0Yw84ze5BO4Fq9Fp2cXYfLugNKThagMU32mMRYCWGwu7I1FaIwdQ
	1tEXfdW4rMfcQ/FNKlykHj5aERi+sMPfG7z6ZX00SufSuZxeT+lgDrFgX6hteg==
X-Google-Smtp-Source: AGHT+IFx2bU7kb7bF79qJannuNFleEh92fqeRBaFnMU41WmOB0rVr1FOwMQ6/fxnr4f/shsPm3fAzw==
X-Received: by 2002:a05:6a00:10c9:b0:6dd:da40:948d with SMTP id d9-20020a056a0010c900b006ddda40948dmr6719847pfu.25.1707743759476;
        Mon, 12 Feb 2024 05:15:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXV+xO1Brck8IFlcfDhCO5DPss2bxQv9p2ySYPe0AWoUymv5Nbfko/WfjN5j5WANkzLIbkvWkeJneeqVgUaX7RxaX/NmpAoeM43meCmgnMTIOZlVYWy9bU0EjtPl0AR97uiH9h6uxbBjjHBdobffkgzAKYL7IzgZXUIjwbSCxW0hiVz0sgjes6CL55lMau+/k0d/6QlyesUbOU+mxk9CGa52hvSI5sHkq+EbForMesAIv5ojZGsfQYdHtAgjs6neLt9Rp+KHO55GKH2LgN06D8SsnwpOb/jD7dasJeHghXbE7Daq36CjcRFczIjNKX9M317AzFrNZL1Gh6kwL5INGfDFQuF3k3nR35IQxjJMJzegu755I52ajUa8rvXP5YpGLTFkRw5PwCI1vl7kUKA+uMjR6AatGYaTL7xPqPn2tKJdZW8FAUBIigqf2qfMlSjLS7MzEfESV37OexI1aIShARvowhJAl9mEF1GaM3ilVkCnAtavp7npxoDuY7Ubp9lLXMifo7rRU4=
Received: from thinkpad ([117.193.211.169])
        by smtp.gmail.com with ESMTPSA id w12-20020a056a0014cc00b006e03c68ae9asm5665844pfu.16.2024.02.12.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:15:59 -0800 (PST)
Date: Mon, 12 Feb 2024 18:45:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
Message-ID: <20240212131551.GA74465@thinkpad>
References: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
 <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
 <dec2976e-6e1e-6121-e175-210377ff6925@quicinc.com>
 <CAA8EJprsm5Tw=vFpmfEKL8fxS-S+aW+YR0byfyL=v78k75TGEw@mail.gmail.com>
 <3ad77846-b4a8-80ee-e9e1-d5cbf4add6d8@quicinc.com>
 <CAA8EJprRF0tVFZK9c=MT8bSRcBdRvcugBaeEzpX5-wfRyNgc3Q@mail.gmail.com>
 <c8be2bbf-a51c-a38f-6e6f-a88801f953d5@quicinc.com>
 <20240209075716.GA12035@thinkpad>
 <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com>

On Fri, Feb 09, 2024 at 12:56:18PM +0200, Dmitry Baryshkov wrote:
> On Fri, 9 Feb 2024 at 09:57, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Feb 09, 2024 at 12:58:15PM +0530, Krishna Chaitanya Chundru wrote:
> > >
> > >
> > > On 2/8/2024 8:49 PM, Dmitry Baryshkov wrote:
> > > > On Thu, 8 Feb 2024 at 16:58, Krishna Chaitanya Chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > > > On 2/8/2024 12:21 PM, Dmitry Baryshkov wrote:
> > > > > > On Thu, 8 Feb 2024 at 08:14, Krishna Chaitanya Chundru
> > > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 2/7/2024 5:17 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Wed, 7 Feb 2024 at 12:42, Krishna chaitanya chundru
> > > > > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > > > >
> > > > > > > > > Enable PCIe1 controller and its corresponding PHY nodes on
> > > > > > > > > qcs6490-rb3g2 platform.
> > > > > > > > >
> > > > > > > > > PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
> > > > > > > > > connected. For each endpoint a unique BDF will be assigned and should
> > > > > > > > > assign unique smmu id. So for each BDF add smmu id.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > > > ---
> > > > > > > > >     arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
> > > > > > > > >     1 file changed, 42 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > index 8bb7d13d85f6..0082a3399453 100644
> > > > > > > > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > @@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
> > > > > > > > >            };
> > > > > > > > >     };
> > > > > > > > >
> > > > > > > > > +&pcie1 {
> > > > > > > > > +       perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > > > > > > > > +
> > > > > > > > > +       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
> > > > > > > > > +       pinctrl-names = "default";
> > > > > > > > > +
> > > > > > > > > +       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
> > > > > > > > > +                   <0x100 &apps_smmu 0x1c81 0x1>,
> > > > > > > > > +                   <0x208 &apps_smmu 0x1c84 0x1>,
> > > > > > > > > +                   <0x210 &apps_smmu 0x1c85 0x1>,
> > > > > > > > > +                   <0x218 &apps_smmu 0x1c86 0x1>,
> > > > > > > > > +                   <0x300 &apps_smmu 0x1c87 0x1>,
> > > > > > > > > +                   <0x400 &apps_smmu 0x1c88 0x1>,
> > > > > > > > > +                   <0x500 &apps_smmu 0x1c89 0x1>,
> > > > > > > > > +                   <0x501 &apps_smmu 0x1c90 0x1>;
> > > > > > > >
> > > > > > > > Is the iommu-map really board specific?
> > > > > > > >
> > > > > > > The iommu-map for PCIe varies if PCIe switch is connected.
> > > > > > > For this platform a PCIe switch is connected and for that reason
> > > > > > > we need to define additional smmu ID's for each BDF.
> > > > > > >
> > > > > > > For that reason we defined here as these ID's are applicable only
> > > > > > > for this board.
> > > > > >
> > > > > > So, these IDs are the same for all boards, just being unused on
> > > > > > devices which have no bridges / switches connected to this PCIe host.
> > > > > > If this is correct, please move them to sc7280.dtsi.
> > > > > >
> > > > > Yes ID's will be same for all boards. we can move them sc7280.dtsi
> > > > > but the BDF to smmu mapping will be specific to this board only.
> > > > > if there is some other PCIe switch with different configuration is
> > > > > connected to different board of same variant in future again these
> > > > > mapping needs to updated.
> > > >
> > > > Could you possibly clarify this? Are they assigned one at a time
> > > > manually? Or is it somehow handled by the board's TZ code, which
> > > > assigns them sequentially to the known endpoints? And is it done via
> > > > probing the link or via some static configuration?
> > >
> > > There is no assignment of SID's in TZ for PCIe.
> > > PCIe controller has BDF to SID mapping table which we need to
> > > program with the iommu map table.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c?h=v6.8-rc3#n997
> > >
> > > Based upon switch the BDF to SID table will change for example I had two
> > > switches with one switch has 2 PCIe ports and other has 3 ports one
> > > embedded port which supports multiple functions.
> > >
> > > For the first switch the BDF's are
> > >       - 0x000(root complex),
> > >       - 0x100(USP),
> > >       - 0x208(DSP 0),
> > >       - 0x210(DSP 1),
> > >       - 0x300(endpoint connected to DSP 0),
> > >       - 0x400( endpoint connected to DSP 1).
> > >
> > > For 2nd switch the BDF's are
> > >       - 0x000(root complex),
> > >       - 0x100(USP),
> > >       - 0x208(embeeded DSP 0),
> > >       - 0x210(DSP 1),
> > >       - 0x218 (DSP 2),
> > >       - 0x300(embedded endpoint function 0),
> > >       - 0x301 (embedded endpoint function 1)
> > >       - 0x400( endpoint connected to DSP 1)
> > >       - 0x500(endpoint connected to DSP2).
> > >
> > > For these two switches we need different BDF to SID table so for that
> > > reason we are keeping iommu map here as this is specific to this board.
> > >
> >
> > I don't understand why the SID table has to change between PCIe devices. The SID
> > mapping should be part of the SoC dtsi, where a single SID would be defined for
> > the devices under a bus. And all the devices under the bus have to use the same
> > SID.
> 
> This sounds like a sane default, indeed. Nevertheless, I see a point
> in having per-device-SID assignment. This increases isolation and can
> potentially prevent security issues. However in such case SID
> assignment should be handled in some automagic way. In other words,
> there must be no need to duplicate the topology of the PCIe bus in the
> iommu-maps property.
> 

Yes, address space isolation is the primary motive behind this patch. But as
you said, we should not do it by hardcoding the SIDs in the board DTS. It won't
scale and is not a proper solution.

Instead, the issue should be addressed in the IOMMU layer by working with the
IOMMU folks.

It should be noted that we _cannot_ use any arbitrary SID for PCIe bus. HYP/TZ
will fault the transactions coming with different SIDs than the ones assigned
to them. So we still need to pass that info from DT to IOMMU layer.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

