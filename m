Return-Path: <linux-kernel+bounces-43972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A76841BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C09428A442
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DEA3839D;
	Tue, 30 Jan 2024 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiCQ9Irg"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083338396
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595076; cv=none; b=on5Cpvaot/Sl15siPby33oFJ4F/IpV2j6seJ/zSlKkk8qdwcnzaVwIPGD7hWeyr2We56mCQXOzpmGzco2WlHcPuBZjAQq8ZOG/OIxwfIFAwxsEj6cVUuaDbHzf/zV1gFzvA1sW54XN0iSakYBT4GYXT3XVO1LrtN0mcsJpfR9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595076; c=relaxed/simple;
	bh=xOea63INGOSG465h0CfnONEMeWR4NZ/xHm0T3eI1GNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmgtsbh0LDf/sVrxv7vOT2L/bk7MWXHT4vXAGzqaVv47iRntF2gzZabsugsn93tsXyvlBRX60AyHag2Fl24abk4tNTksd3FjiqO2ISrrg00KdUFAyrFPXhJa0bInezKqfQHie/vYyhkTR6MhRbSDypwHkYbL4vDEBxZt9VxMROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GiCQ9Irg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1817221a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706595074; x=1707199874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypr/6L0QoG7N6GIlemwTnozF/H7mKp62EyexXYwz5pA=;
        b=GiCQ9IrgMVPbmdtdFVAeUN1n4D6V7cxsZOK4HhmuQU0eKV84YBAqrxEwHlvh/tjvJs
         5jjVL5BXDDvVFO2BwPywJy1jVBoxufJZSpoaz7qjMF2hO/TJHFddloz8Z4kKIF9Kdboy
         oemECYg8ZmWSjScIBbOMn6TeD9qbygpDCW5El+lkpgW4jKQYvXVlj9YAyouO+2XasUj+
         W6CUEj3l4Pdnd46ng88xbV8IjYuhrEbxGyrHTNgfwWP6Jm8Fev8AczEoD98k/8nD1vcW
         CLNT00EXXg8SX5Fw03D0o+nVT/fSmBWGyfzQazrt8za2H6GQeJfoJfnZYHYEHGHTgITm
         GuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706595074; x=1707199874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypr/6L0QoG7N6GIlemwTnozF/H7mKp62EyexXYwz5pA=;
        b=h+l0z0g6iXg368vpYdHBeJsH7h0+vW4fiUhWzu1/SBPnIWum8RCqdQzQoo2pvWW/68
         ZNvIRKl1EZJwq5OrtQ5xd3FQgqrXvGejvHEZe+ii66jRDUPHD/XtodMBmcSzIxEy87wV
         QRFvl7ur4Nem3pmZOWjpOUgxP6Y7vzvieY6p6au4fll51mC7sGh4ymwDKUe+hkvp0fQO
         yDA3oiO2FWWpBbDT8NQGRK1klf0wInHnhPNJZgZtdOCcnZMv+th6vwj0iC2lEk8HBAow
         z6gw8YGnMdmUBQYaE1WDkiw+1fpmXf1VGSeolD7vqvIeFN1NI0UaGdLB270HZFM4jmkr
         g+Fw==
X-Gm-Message-State: AOJu0YycBBAsbs9lp8anoOgyYBID3pqPRw8KFgeR6zHWG7XRoIYTfy4J
	DdKILW4WAlZQtFnMKA8TIWjGN6u+wy0AXEqLAlIE9EqbrTEKtpSrnfX07tBlJ4Q=
X-Google-Smtp-Source: AGHT+IFXCiqNz56YhR8ZeAD95eE8xtQBHXRFokosutQyCwkchVIu/T59v2/TzAC66N+peWYD8bpDLw==
X-Received: by 2002:a17:902:8f97:b0:1d4:79b7:b8ce with SMTP id z23-20020a1709028f9700b001d479b7b8cemr4631604plo.44.1706595074065;
        Mon, 29 Jan 2024 22:11:14 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id jg17-20020a17090326d100b001d8fae3220fsm1447045plb.73.2024.01.29.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 22:11:13 -0800 (PST)
Date: Tue, 30 Jan 2024 11:41:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129160420.GA27739@thinkpad>

On 29-01-24, 21:34, Manivannan Sadhasivam wrote:
> On Fri, Jan 12, 2024 at 07:52:04PM +0530, Krishna chaitanya chundru wrote:
> > PCIe needs to choose the appropriate performance state of RPMH power
> > domain and interconnect bandwidth based up on the PCIe gen speed.
> > 
> > Add the OPP table support to specify RPMH performance states and
> > interconnect peak bandwidth.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 74 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > index 6b1d2e0d9d14..eab85ecaeff0 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -1827,7 +1827,32 @@ pcie0: pcie@1c00000 {
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&pcie0_default_state>;
> >  
> > +			operating-points-v2 = <&pcie0_opp_table>;
> > +
> >  			status = "disabled";
> > +
> > +			pcie0_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> > +				opp-2500000 {
> > +					opp-hz = /bits/ 64 <2500000>;
> > +					required-opps = <&rpmhpd_opp_low_svs>;
> > +					opp-peak-kBps = <250000 250000>;
> 
> This is a question for Viresh: We already have macros in the driver to derive
> the bandwidth based on link speed. So if OPP core exposes a callback to allow
> the consumers to set the bw on its own, we can get rid of this entry.
> 
> Similar to config_clks()/config_regulators(). Is that feasible?

I don't have any issues with a new callback for bw. But, AFAIU, the DT
is required to represent the hardware irrespective of what any OS
would do with it. So DT should ideally have these values here, right ?

Also, the driver has already moved away from using those macros now
and depend on the OPP core to do the right thing. It only uses the
macro for the cases where the DT OPP table isn't available. And as
said by few others as well already, the driver really should try to
add OPPs dynamically in that case to avoid multiple code paths and
stick to a single OPP based solution.

-- 
viresh

