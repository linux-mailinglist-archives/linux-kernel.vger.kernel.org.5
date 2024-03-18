Return-Path: <linux-kernel+bounces-105704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9D87E30A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E550B20943
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957E21103;
	Mon, 18 Mar 2024 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibhkRK+D"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA4200C7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739493; cv=none; b=AevPKUcwziDQVkaVKEzsns5ldqU41wAKsK5n1w3wPLjNMk42ucFnpDkSF5RCauEko6YHoPPRFHq3RIwuLL0ipPgz1cobKtDZv8BSb97yUM2VTtTlg6tLxrA/B2iW6EZEo9kzl5cHmjkm9ZzzV9RG08i5ZWuO7rvSZ8T7bKkj1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739493; c=relaxed/simple;
	bh=c9fwgDZO7xfn/hMKmU58c2whfTr8AZ9eD7Cb7kprD1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1L5p3Q2+9dNS+d1+MgFB4hF/8nrxmkJGIDMi3cZTMxxNSB6QbyIo+6tvdU5/XLFRsKsQkOVA30pXrBhaASzrPxLOTmChUQLD6cVQlCgikgdehRw2p8EmqMZ2NOA0a8meVAHlZhbpLFbUsel2tZ3axvkvvdpya+hWkKaJdFChRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ibhkRK+D; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so2797842b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 22:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710739491; x=1711344291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CNcKGaj2BPeMdeJCJpbtOlfn5Jir2vsSeelgC2Tjobo=;
        b=ibhkRK+D349XU83rfxgMp5ZGQJHGG/dTaxURCyGIXmUDaQVZgOZB/E8zIJswo6KpPW
         3PDw/d7fAl7Kg9a8QHPZnImB8cYEM4FnVW07uFXXV6I1K1Z28Iev0S+RiMY/iv0S56Rd
         gK8YUwEAViwVYlJha1ZheX5t0pdBrcSMbJ7Y4BV16ODD6QG7ovQQQpGa3t24T9Sh/8Iw
         0LxrTQpOXv74QkWM28ZEeKEhzoRQMHTo+VRSTB9a34m12BH05zZaXGb1qybPW7OuRZbg
         WAQMOTGnHaXvEpq4dc7TCI4bx/VlEx5otPUQ7Q3o/YBZzZ1q4pvHvj938Sn0NLWgbZRX
         eE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710739491; x=1711344291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNcKGaj2BPeMdeJCJpbtOlfn5Jir2vsSeelgC2Tjobo=;
        b=n4bYP2TBs2Yk1C6ZeXSeggauT/75bQfTOdeApLJYtKaQ+sGFjKjBr81ZE4MPMz6u/z
         Ev8nvy4thYjYO9MzTympubXhHQuw2esDbVc3XIYezTuBXF2e7dj8Mgv+b5X3s0XKV/Sb
         t19z7hFzRdOrLv7mgXCarRlvRPEiqIZT46TYByIYP/iCuvT1+MNfgMAGPzv6Hk/KdKg5
         TpkbPfebXypoaj0hHwCQIRRMxn0MUNXtUt3Jvefbbp7eAIJ6/b8OAtZP5Ff/U/9gqNd1
         HN0kz6sNAk1we3GeWliuqX8PN3W/+Mj8kIuLNqd5VI1IQAU001/c5EzV6yNJavx1j5yO
         TX+A==
X-Forwarded-Encrypted: i=1; AJvYcCXODn6TyOmj6E1f668k2dFtzzqE+MakzDYuoj+DVtEpFW9ig/VzP2lh1dPDoL4ivWs9IAzC5vvxuJFQnshSv8Af3kKCVfTh7pTIbIrX
X-Gm-Message-State: AOJu0YwuthIyHDP7/esZ/DJSQGOa3507qRuPgrnIgT52T8v1j8Rjx7vW
	HsTAwL27SI2tB0uCFF47tzAKGKrURbgRUBvgDK8+8uUVFMJj84dD6ruq5C2miQ==
X-Google-Smtp-Source: AGHT+IEY0/weM55GDU4//9wjAP/vzWixUhDsmhWUpakPMojFH7eX0ympbiYT4z6suOMFHBlvvCiA4w==
X-Received: by 2002:a05:6a00:174b:b0:6e6:5291:1779 with SMTP id j11-20020a056a00174b00b006e652911779mr22226933pfc.6.1710739490721;
        Sun, 17 Mar 2024 22:24:50 -0700 (PDT)
Received: from thinkpad ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id v22-20020a634816000000b005dc26144d96sm6270417pga.75.2024.03.17.22.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 22:24:50 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:54:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/21] arm64: dts: qcom: sc8280xp: Add PCIe bridge node
Message-ID: <20240318052445.GC2748@thinkpad>
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
 <20240221-pcie-qcom-bridge-dts-v1-9-6c6df0f9450d@linaro.org>
 <9d6c617a-bc3a-47c4-a988-b41b804d8cfe@linaro.org>
 <20240222053958.GF3374@thinkpad>
 <26mic7smm2aez3enydiiuul2c5yru4kmx26n4mo63nvy4bscuv@jql4hhe3gia6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26mic7smm2aez3enydiiuul2c5yru4kmx26n4mo63nvy4bscuv@jql4hhe3gia6>

On Sun, Mar 17, 2024 at 10:37:15PM -0500, Bjorn Andersson wrote:
> On Thu, Feb 22, 2024 at 11:09:58AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 21, 2024 at 01:39:01PM +0100, Konrad Dybcio wrote:
> > > On 21.02.2024 04:41, Manivannan Sadhasivam wrote:
> > > > On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
> > > > for each controller instance. Hence, add a node to represent the bridge.
> > > > 
> > > > While at it, let's remove the bridge properties from board dts as they are
> > > > now redundant.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  8 -----
> > > >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 40 ++++++++++++++++++++++
> > > >  2 files changed, 40 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > > index def3976bd5bb..f0a0115e08fa 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > > @@ -733,14 +733,6 @@ &pcie4 {
> > > >  	status = "okay";
> > > >  
> > > >  	pcie@0 {
> > > > -		device_type = "pci";
> > > > -		reg = <0x0 0x0 0x0 0x0 0x0>;
> > > > -		#address-cells = <3>;
> > > > -		#size-cells = <2>;
> > > > -		ranges;
> > > > -
> > > > -		bus-range = <0x01 0xff>;
> > > > -
> > > >  		wifi@0 {
> > > 
> > > This doesn't seem right, pleas use a label
> > > 
> > 
> > Why? A node label is useful if we want to reference it at the root level in
> > board dts, but here it is not.
> > 
> 
> Giving the bridge a label and then adding wifi@0 as a child using that
> label in the dts is pretty much how we do for everything else.
> 
> I find this over-flattening hard to follow, but relying on child node
> names when extending the structure or adding properties have bitten us
> many times in the past.
> 
> As such, I think the desired result in the dts should be:
> 
> &pcie4 {
> 	status = "okay";
> };
> 
> &pcie4_bridge {
> 	wifi@0 {
> 		...
> 	};
> };
> 

Ok. Will change it in next version. I'm also waiting to conclude on representing
the PERST# and WAKE# properties properly in the schema [1]. Once that gets
finalized, I'll respin v2.

- Mani

[1] https://github.com/devicetree-org/dt-schema/pull/126

> Regards,
> Bjorn
> 
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

