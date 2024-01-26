Return-Path: <linux-kernel+bounces-39754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D783D5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08FB28A55D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9476E2AA;
	Fri, 26 Jan 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+JeTIhF"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A71427E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257127; cv=none; b=Mg8uOLlHlHbwcvJMPSWN+W0KuBMEinvjmKGEXnJlyrZ+ayujH0/ZOoRMR75weAus8hQyXDKWMKdw8Nfl7z0F+nBU3lVJpLUALNKBKiWjZn5aYKzlwJdN+yiiy33VXgrKDR1FkvZQ2i/7KmTXF/vERn8gpucmSkn0Ou8qey7UsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257127; c=relaxed/simple;
	bh=1v1p0jrAJR50Kueh7YF9CPLO/I/oXE+euJsb8wrKQ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8W//ZMov3IXShrJHXlPI93PxnNtj4Ovcn6Alg/JA4OWhBaBpcW+FXgvfN5JfFwYta4eTrsNrzj8kAn3P0YdDskbK7tdXvB81JL83iF4iWJehIFxMhL0S0Xn755HN5B5PzcSq4Z2gZdy+pAYUi6XxFmBTe0wPjgqObRvbzphSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H+JeTIhF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a90b2b554so113931a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706257124; x=1706861924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eKbQ9dPSaynT5h1DWbytWa8cizVUJhYOPdgPpMBlYw=;
        b=H+JeTIhFKdgDE97RUL23Y7vt9Hab569XLsLp7NT00I2ZZ74HeOAnxqIgK9P//DwNIG
         iengf9mXTH1kjZpDsMV97EfQMnViFr+2XiOieFlOKYEm37MRjy3bgOuJf6d+4LmHx+Hw
         QSR3yZCf3Xzj4LbZmJCYc54l63C/qrRMqqppr+nfT5a+mXSYQR/klx/C6og0iacysYVw
         q5QYVXfazGNnbgmsK7E8w5pezGWsHdGaJbv6NoMapvfzJNKuR4zWTo+jvraxBOiC9uGr
         1ONZj/FMDRb/dREzmF0rpo0ywp/nYHT7XfSsbyiVvGPaFfO1vwCnWO6aPOIZL4eQFXPn
         de+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706257124; x=1706861924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eKbQ9dPSaynT5h1DWbytWa8cizVUJhYOPdgPpMBlYw=;
        b=XKHLh+JCeDeWk7Q9JRlgLtpLlK8+lmRCVeaQFTEKT06l4ybDg6RuF9CvQHYewcKxgR
         JU6iv2hiAFmnTZwFL746Odk18LNiBb11mg+sLskFp4Iih5sWGuaQDfU4c+FDDj23g8n1
         BBTen3YskWMFWrqyoG+VuxnYtZltm1asIBr0m+XDHxlHf5QiG60RpSxQVwKqK8NFzwTy
         7fXC4Pm9QyBqHerhBFOhkfZunjKYuc0lo7o+Q8Z0kOR4ipjlAtf5WkeB81guVhUvyOlj
         4gpesjXmKEQ7DxjPf7+9j80Nc4lYZ3y6/Ql77k1ITcpVPXHZlIcbVo5B33T884p8eh2D
         +jrg==
X-Gm-Message-State: AOJu0YyF3vcTExqdhlxftjB6KOsxNn2Yizo+mtqexl7jYWhMfGctMlvF
	6dOLKOKR9rx5kc1kaIj/aJ7qV+1wnSq7ocAg6cuhyORkr2s4oDY5SKczEZ5z+jBrYVkbo13Y+EB
	a
X-Google-Smtp-Source: AGHT+IGAHjYbYuhhbEn3hJ2jgzKambyOC27Tkan/Yq9Qzl1vlpSHYnZRuSY3GbgR8HYC+EhmgrcwyQ==
X-Received: by 2002:a17:907:1751:b0:a30:ec79:25f3 with SMTP id lf17-20020a170907175100b00a30ec7925f3mr893519ejc.42.1706257123688;
        Fri, 26 Jan 2024 00:18:43 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ck5-20020a170906c44500b00a31930ffa7esm358242ejb.153.2024.01.26.00.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:18:43 -0800 (PST)
Date: Fri, 26 Jan 2024 10:18:41 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] arm64: dts: qcom: x1e80100: Add TCSR node
Message-ID: <ZbNq4b813348ZiV8@linaro.org>
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-5-072dc2f5c153@linaro.org>
 <b0f4236a-c87e-4d50-b1a0-42ed5b015b86@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f4236a-c87e-4d50-b1a0-42ed5b015b86@linaro.org>

On 24-01-23 19:09:37, Konrad Dybcio wrote:
> 
> 
> On 1/23/24 12:01, Abel Vesa wrote:
> > Add the TCSR clock controller and halt register space node.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> The former - yes, the latter - ?

Hm, so halt register space is at 0x1f60000. That would be in the mutex
region. But the mutex region is 0x20000 short, even on SM8650 and
SM8550. Need to see why is that, historically.

Either way, the tcsr node region still contains the regs needed by the
SCM driver to enable download mode. So I will rephrase this accordingly.

> 
> Konrad
> >   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index be69e71b7f53..2b6c55a486b2 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -2606,6 +2606,14 @@ tcsr_mutex: hwlock@1f40000 {
> >   			#hwlock-cells = <1>;
> >   		};
> > +		tcsr: clock-controller@1fc0000 {
> > +			compatible = "qcom,x1e80100-tcsr", "syscon";
> > +			reg = <0 0x01fc0000 0 0x30000>;
> > +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +		};
> > +
> >   		gem_noc: interconnect@26400000 {
> >   			compatible = "qcom,x1e80100-gem-noc";
> >   			reg = <0 0x26400000 0 0x311200>;
> > 

