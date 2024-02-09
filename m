Return-Path: <linux-kernel+bounces-59096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFF184F125
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D839328713E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211565BBD;
	Fri,  9 Feb 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0go47K/"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF565BB3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465448; cv=none; b=tiMgXBfBOEDN8iCOYHiBpatxViqSybsv5F8HR8OypB91gBhqq8AKDLClJzlLzxoHkO42WiKCruCuEJk0T2pSW+nXPEk2pmLW31Ue0IlY3af+jkyRZZos+rtKzSl9zLfvyxGuDd0gc0Zqco4u3dRyvIK/so0C9PX5Ezf79oIDs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465448; c=relaxed/simple;
	bh=R3TPFYl9JnN0O5JQPQt+57zKgdCpwZ0UWmhjEurGDVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuErsJW8O20o6c15HtjPzA4IWtvrpvRjs6AGnOO5yjICIiEciEPK+tbdAPzzb4791gWpF7YuV3MhZXADhqKJ/YAd+4+dzHFolb9VBgZhFGi7Ki3v3iVeVVPStiIwtS5l+vKp+GHZupschGjjlU5X3dM2fEan/xL2CESLJ1fQWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0go47K/; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be6df6bc9bso394277b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707465445; x=1708070245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NTsSpZ+Q4moS2/xYpioyKx9/LTDwSkxGcwtDw/u67gA=;
        b=f0go47K/KBi0GICubFFt8bZeKstTac/B0RS/VxQi4pDQjcsHWaqu2EC9s0j+8qGha2
         iY1H1XBtr2eaTIg3nU74wYDfHptHP9Q3n2Ke7QgvfqimOp9UHyb+7PCHSHjhDfs7KDSQ
         4WzVlAAGJ5HtLVFKhnhaGiUlrFQKJdFU1n5+mKrHHcr6+UwzHud91JAIlA4wle66cGFp
         5rz4oKl/tW2e/NvC8KAxZ+btdJHmopCRw9jOtsEu0cg+lM16aJVea1QcscAhdyElJwnS
         P0BzL0ekzXbs5u/+nFoS9GFIbxfBtw8iju9sNiL+Gymu1/IO8MI2cbe2WxGkuL2EY+iW
         ZJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465445; x=1708070245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTsSpZ+Q4moS2/xYpioyKx9/LTDwSkxGcwtDw/u67gA=;
        b=m/98glAhce44lTCIKMfZO4a5i0gxqj0KNgwzg0pwT7s3ZeUKE8G+knle8nKhK3mvnY
         Eebl6kBdPJIMX4gjez+Zprha8p3ttUpQYZyTowmcNQOWhquHLS2VtA22Sp/uXxT28fAM
         vIrpOtVUHOZJfVjmEMxw7lPJee1PHkWROvfo7ez9V04bxlpV6WdsHfBGefSVNJ09Ftyt
         flRYrL0ZrvyWOzH9TLqDkHoNPLQTzOoWWKuXx5+z/fYbkedj9lnPw1bpPDwhDykTsvJ6
         1MapFr2YfZNHZjGF9gdutOPkNiN1jBvbQEI9lL8eboxV2DzuCSnu7QTs2TXGoSc+ZQJ+
         acQA==
X-Gm-Message-State: AOJu0YysMDcNvnKr6lfcIg7y1K1t//3kO7N9fzul94/59pZZvPdxGT+8
	/JOpCgk1pxiKqfgOkL4uplDlRhjP9u73/OCHyW/RjRqUbszfKqpkGU8VTdW8kg==
X-Google-Smtp-Source: AGHT+IHXWWzzttXZr2Rov3isq3BEliwHjaZoG7/Hp6w9AJndt6/+D9EO3yZKo2qHf84wX7ydT+UBTA==
X-Received: by 2002:a05:6808:13c1:b0:3bf:f420:477e with SMTP id d1-20020a05680813c100b003bff420477emr1155527oiw.12.1707465444918;
        Thu, 08 Feb 2024 23:57:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/4Yhd4QO/toKTVokAGcHJnZBTy3wunruP0PDSiPq4qIJz1P8hiHWqXPgFQ0eHHmNT6Mf5jNyNCvFUEDsw1Sj+bWl+HpcXeGlBRwHjpSXcAv4Etowyeys6L2uThSq94coERI4Ot0Tl8OwZxrGGmwkPqtJxpXWG3VWMV5Y7mVPupaSsK1vCm8TTXGNIkvqdwKx1pVWuLdyY5f++ZwHhLSXlSCafD6Ds59o1o5k9N/1bWIAclT4+fh0h0pNM8jebOzcmsnj/9+FmXLGQupxha/sOpuPjp8vqP+UU5mSKr3d3pEfkKKCtw4NHfBaXEmIMbWE1D7BrCsYRqYfqUCvgmjtoHCMCN5b4vvGaoyHkEc6o58v+HcBzPfclVKcXSSD7VpCHEZ62PxvHYQf767ug38Sj7ILF8J5qpmmto0IUjAYeRJd847OHoYMm/Cx52DiNQvC9c4LfXsB2PfAHiYTrl+ZhgUI0+4pRIPwRDyzCX8h7o0k4ePfM6ASWuDpIIUuuu9nZpJefSpg=
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id fa9-20020a056a002d0900b006e037ce7cb8sm1035839pfb.0.2024.02.08.23.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 23:57:24 -0800 (PST)
Date: Fri, 9 Feb 2024 13:27:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Message-ID: <20240209075716.GA12035@thinkpad>
References: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
 <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
 <dec2976e-6e1e-6121-e175-210377ff6925@quicinc.com>
 <CAA8EJprsm5Tw=vFpmfEKL8fxS-S+aW+YR0byfyL=v78k75TGEw@mail.gmail.com>
 <3ad77846-b4a8-80ee-e9e1-d5cbf4add6d8@quicinc.com>
 <CAA8EJprRF0tVFZK9c=MT8bSRcBdRvcugBaeEzpX5-wfRyNgc3Q@mail.gmail.com>
 <c8be2bbf-a51c-a38f-6e6f-a88801f953d5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8be2bbf-a51c-a38f-6e6f-a88801f953d5@quicinc.com>

On Fri, Feb 09, 2024 at 12:58:15PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/8/2024 8:49 PM, Dmitry Baryshkov wrote:
> > On Thu, 8 Feb 2024 at 16:58, Krishna Chaitanya Chundru
> > <quic_krichai@quicinc.com> wrote:
> > > On 2/8/2024 12:21 PM, Dmitry Baryshkov wrote:
> > > > On Thu, 8 Feb 2024 at 08:14, Krishna Chaitanya Chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 2/7/2024 5:17 PM, Dmitry Baryshkov wrote:
> > > > > > On Wed, 7 Feb 2024 at 12:42, Krishna chaitanya chundru
> > > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > > 
> > > > > > > Enable PCIe1 controller and its corresponding PHY nodes on
> > > > > > > qcs6490-rb3g2 platform.
> > > > > > > 
> > > > > > > PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
> > > > > > > connected. For each endpoint a unique BDF will be assigned and should
> > > > > > > assign unique smmu id. So for each BDF add smmu id.
> > > > > > > 
> > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > ---
> > > > > > >     arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
> > > > > > >     1 file changed, 42 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > index 8bb7d13d85f6..0082a3399453 100644
> > > > > > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > @@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
> > > > > > >            };
> > > > > > >     };
> > > > > > > 
> > > > > > > +&pcie1 {
> > > > > > > +       perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > > > > > > +
> > > > > > > +       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
> > > > > > > +       pinctrl-names = "default";
> > > > > > > +
> > > > > > > +       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
> > > > > > > +                   <0x100 &apps_smmu 0x1c81 0x1>,
> > > > > > > +                   <0x208 &apps_smmu 0x1c84 0x1>,
> > > > > > > +                   <0x210 &apps_smmu 0x1c85 0x1>,
> > > > > > > +                   <0x218 &apps_smmu 0x1c86 0x1>,
> > > > > > > +                   <0x300 &apps_smmu 0x1c87 0x1>,
> > > > > > > +                   <0x400 &apps_smmu 0x1c88 0x1>,
> > > > > > > +                   <0x500 &apps_smmu 0x1c89 0x1>,
> > > > > > > +                   <0x501 &apps_smmu 0x1c90 0x1>;
> > > > > > 
> > > > > > Is the iommu-map really board specific?
> > > > > > 
> > > > > The iommu-map for PCIe varies if PCIe switch is connected.
> > > > > For this platform a PCIe switch is connected and for that reason
> > > > > we need to define additional smmu ID's for each BDF.
> > > > > 
> > > > > For that reason we defined here as these ID's are applicable only
> > > > > for this board.
> > > > 
> > > > So, these IDs are the same for all boards, just being unused on
> > > > devices which have no bridges / switches connected to this PCIe host.
> > > > If this is correct, please move them to sc7280.dtsi.
> > > > 
> > > Yes ID's will be same for all boards. we can move them sc7280.dtsi
> > > but the BDF to smmu mapping will be specific to this board only.
> > > if there is some other PCIe switch with different configuration is
> > > connected to different board of same variant in future again these
> > > mapping needs to updated.
> > 
> > Could you possibly clarify this? Are they assigned one at a time
> > manually? Or is it somehow handled by the board's TZ code, which
> > assigns them sequentially to the known endpoints? And is it done via
> > probing the link or via some static configuration?
> 
> There is no assignment of SID's in TZ for PCIe.
> PCIe controller has BDF to SID mapping table which we need to
> program with the iommu map table.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c?h=v6.8-rc3#n997
> 
> Based upon switch the BDF to SID table will change for example I had two
> switches with one switch has 2 PCIe ports and other has 3 ports one
> embedded port which supports multiple functions.
> 
> For the first switch the BDF's are
> 	- 0x000(root complex),
> 	- 0x100(USP),
> 	- 0x208(DSP 0),
> 	- 0x210(DSP 1),
> 	- 0x300(endpoint connected to DSP 0),
> 	- 0x400( endpoint connected to DSP 1).
> 
> For 2nd switch the BDF's are
> 	- 0x000(root complex),
> 	- 0x100(USP),
> 	- 0x208(embeeded DSP 0),
> 	- 0x210(DSP 1),
> 	- 0x218 (DSP 2),
> 	- 0x300(embedded endpoint function 0),
> 	- 0x301 (embedded endpoint function 1)
> 	- 0x400( endpoint connected to DSP 1)
> 	- 0x500(endpoint connected to DSP2).
> 
> For these two switches we need different BDF to SID table so for that
> reason we are keeping iommu map here as this is specific to this board.
> 

I don't understand why the SID table has to change between PCIe devices. The SID
mapping should be part of the SoC dtsi, where a single SID would be defined for
the devices under a bus. And all the devices under the bus have to use the same
SID.

Perhaps you are missing iommu-map-mask?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

