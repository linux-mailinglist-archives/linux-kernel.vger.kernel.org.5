Return-Path: <linux-kernel+bounces-49502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C6846B2B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B3A295E02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F05FDBD;
	Fri,  2 Feb 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiUqHY7t"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A15FDB9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863700; cv=none; b=JFq3OdwUpae8b8WZC7/gRdliojQjB9hGnAJfOoyij9q2w2E+oRubIQz3X8sD4H4WXUNFQfUN1O7oIPCDXDqbXad0WNhIcoc7sbil80WBU7VcRhOSPV/pZ74OGPn/nId48iagkfoaCEGRzuhwyEadkImbIyCgjtrTWIGGStyziTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863700; c=relaxed/simple;
	bh=LiAej0P6H3lelIcHWT6MqNXG8GitRKn4IWPkqQrxu80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFZuojRyP4Awn/KALjwytbPYwuC8LWPTO01WEh3xPluM4nGc812EjOrSpLPv4k5+/Fzui+M6j1o++zsgVGsONqX/a4XtoE5pemd1QffQ4tVVvE2nCIXpH8uJXzA7EVc3/85DL6N4WSlD8VPSePpn/YlGWqAfPLXB/kA5PRVj16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GiUqHY7t; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a58ef4a04so992203eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863698; x=1707468498; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlJ0Q1eyYAeEt1iSF7yEYdHF92/78rgfCFmqlm7ymlk=;
        b=GiUqHY7t6ksByrPhVMZq4k2Nqy+d19xmKviC5GCE36FuWU+TLUbxb4ugf6oEUzHmVw
         jnW+nnvyiEgeUJaTkX/o8fZnFAZTke486laaPqoJYbLNGFfEROq9L4+hF5xcsbFN1scf
         FV3/GCtfPj+NGz5HRiFYqJ13pNSyCnxZsNfCgV3HZTJVHM4dASLluonO4H/qY9Y/TjUS
         SOeAwCkVoKQ1tQxNycTionJOGDBorkb5JpIYH862+wd49VyYYYANtazPsYjDU1IsFdcZ
         SjG0yPUvvsIqwDmiEjmEQTuVpWmt+PhburZV25XJV8/qdfWuyKQc07jKwes4Qakv/F+S
         UXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863698; x=1707468498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlJ0Q1eyYAeEt1iSF7yEYdHF92/78rgfCFmqlm7ymlk=;
        b=Evxc0+2tpV/2nHig0Dp/aJbgUUwspQdssdBg/oAKkfBiv2FQpLc8nZUjPuJzJTQe/g
         07flcdWe0swcdGTqjTnVPekmw7u6FvN/u6gPmeVwfsAAkbr67ztH1NQ8ar0IdN8Nxvtk
         2PAEXqs81EOEKETQPA9H/5CnYd2WLN4DkcXUtMeA4lETwTSCU47eSq8kVdBFUeuAjSgR
         zaEboLBjXZ7A4z7soEfKhRdPavqBVSht+wXmJyrzwhk3cQV52BF6qNd/bKmT1eB7jGWE
         9Sji62dZ2JirlIKmt72eN8eC66Fnqz1OhDmkZ9KvIeKVHEx44bFSsnFcXzat7MO0AtQL
         1sTg==
X-Gm-Message-State: AOJu0YzAkrO4oZw99vABIAUwzI5rHW4ZCGbBIr+66gKPx+amppXG38P6
	wakFmGQ8nTG9EvwrpTv64bst9vWtulebMHlZ6oBCwlS06n9ELjZqaJjQp2v/8w==
X-Google-Smtp-Source: AGHT+IE4PDm8o+AXey/Gd8FKV4mwvNH75w1LkrJJ3WwLZ8OPLToVszBQ0k9VkjHiOCfQ1gFSIpW0yg==
X-Received: by 2002:a05:6358:d094:b0:176:4a7f:8bb5 with SMTP id jc20-20020a056358d09400b001764a7f8bb5mr1548797rwb.1.1706863698223;
        Fri, 02 Feb 2024 00:48:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX6//Rl/NFEukCqVE5Wbpo16UIfbgJW1PzRJxb2gPR1eyzOgM6Ogqnjzj7fm5OrIxm8zp/ARM5LyfDNk+Eb1n+je7xqDtXm2ObbvLLoEMEpPD/zxF/1bDxLOeeovBh0WVeYHPfo5p1tLWl0rHSbsUrhcX2DpZyVutiJuRbZ3Q9+9Ensax0nw5Ti/sbotn/RlutRKK934e8eIEIAGI2BFoUHMn5H6pbf+yY9qaZPiADrfetMvkw0zKNhY7VZoQJUHUF5EjJWlZvgTWuVdzj1gcSrs20DdgOZ41l7G591tx7uXOQMyBU9fL0=
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id n4-20020aa78a44000000b006dd872c00dasm1107990pfa.96.2024.02.02.00.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:48:17 -0800 (PST)
Date: Fri, 2 Feb 2024 14:18:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <20240202084806.GF2961@thinkpad>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
 <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
 <Zbyqn5wnH7yCe38P@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbyqn5wnH7yCe38P@linaro.org>

On Fri, Feb 02, 2024 at 10:41:03AM +0200, Abel Vesa wrote:
> On 24-02-01 20:20:40, Konrad Dybcio wrote:
> > On 29.01.2024 12:10, Abel Vesa wrote:
> > > Add the compatible and the driver data for X1E80100.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 10f2d0bb86be..2a6000e457bc 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > >  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> > >  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> > >  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> > > +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> > 
> > I swear I'm not delaying everything related to x1 on purpose..
> > 
> 
> No worries.
> 
> > But..
> > 
> > Would a "qcom,pcie-v1.9.0" generic match string be a good idea?
> 
> Sure. So that means this would be fallback compatible for all the following platforms:
> 
> - sa8540p
> - sa8775p
> - sc7280
> - sc8180x
> - sc8280xp
> - sdx55
> - sm8150
> - sm8250
> - sm8350
> - sm8450-pcie0
> - sm8450-pcie1
> - sm8550
> - x1e80100
> 
> Will prepare a patchset.
> 

NO. Fallback should be based on the base SoC for this platform.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

