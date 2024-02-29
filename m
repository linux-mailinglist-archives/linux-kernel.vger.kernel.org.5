Return-Path: <linux-kernel+bounces-86785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C086CABD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E4F1F2177A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C812A179;
	Thu, 29 Feb 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Owc2hXTe"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9C127B5B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214856; cv=none; b=ZTResVCPYiLOZdHEqnVMx35GrgWHwv3VCCDREpvLRomuLVlWubLFGNVngXs8EjKFcy9KyZ/BlWGW0OPWjBO52raRMsTtK3Outzf8eIZiw/5aponZ9yO+Xz1J3XXMkwlUqsI9qwibiZwGcFz5RswjzOKLGW+fXFP3hOsp9h7orGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214856; c=relaxed/simple;
	bh=v7AgUbrbTmOdYPgovbts9D0RiAJ9tLCiiQRNel8KPYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbuj+pbdOv8SOT8nzFhFfFNRUrNNK/vBT9o/ZaFT3jNwb879g8A/JsRnLyL/XFRiy3hokrYv5y0WlR6Gu3XR7N1lKhRAtu8zxWwNZVQ0D/NMUCQXPSNanFGSQL75ZDzpPaLx9N5s/SY29Nlmb7oi9BfAK2bB8eXvWPnDE+SOnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Owc2hXTe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so7640615ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709214855; x=1709819655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFi6owlquWpJybLOnBr0GE/gVglg7A135XAv9MGMZ48=;
        b=Owc2hXTe60+izH55CjRTO9K5aSUe3JuxD9OZJ8NjdfVgwMV45B1Oz0/+qXqqDxZ2Z+
         lEZklQlNx0rmhyUZ9RV/rWIdZu650LThYHt8hlvLIq5Lm+TlMinxoQHnI9NnoH0uoTbf
         UKkPPsFSerWzwWmuw34xCccLCeh5GS4Fvezjsk5SciTYI2i7ikmGWce5Np6xVRp8ROKb
         TpGZuTyyo0xOGvDWkt9ac+OEHIV90irQFUbG1jlEXvuH/UM5rPV3XefJeLo8x0MxIKU1
         g7k5a+4Qx2ZcKYgc3q9HSpzN2Hed1qbebTUfkz8Tl+r5FMmoaZX9oSb5VD50tKL7xAYh
         tzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214855; x=1709819655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFi6owlquWpJybLOnBr0GE/gVglg7A135XAv9MGMZ48=;
        b=gJUwJ3nz5Nz9DX+YwQrnyVwvUkfXWcifyDENteStd56DnKJeONU6Wb78fT3sRvwaRD
         ittukq+vPsfk041fjZ6fCDXpPRI/hzsSEmjv+7fnugD6V6bS4sW5Uo5YLoRPK+iYW3gH
         NsS3Sv1gqFzWWzMd3Oyyegp4nZUfYTMH5e/Mub+MvreOs/rIY6mae/8CQ0jl3aVdEQaW
         4mFEiUO+qIwpYrkyXrpAgsw2w18F9vu4m9RHCNgznwiPp8k8VJyPV3u2QL+/KG8ShmsX
         QmJjkAA2hiilTq5rNTkXkSQNtQlnQmP/AbfpsBWa2rJQLOsvTFTuM+xKoMaT4wINGYXL
         CxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzXgMox/0rvaSnaoo5TSyadLXSZW5qGFMgsFns5CuK8+4PTIZzC6XcABBxqdPppVwUyfM5TlIm8o15pL2n66CoK/IkOCv2wnLrycRS
X-Gm-Message-State: AOJu0YynN+Xq/hn3d5x5VYK30zsjzxqWTBnVw1psneHXap9Xacp2nPWc
	ojn7xaJ9SAt1SoUSMklyfDsadgzwyRCA8CbITwtOuTvGWuPW2CAbH9imvb7MfA==
X-Google-Smtp-Source: AGHT+IHXl1bXWdS83nD1wqmxu04C1/sqKau8el88o5dRrtYuWLXqrfk+s6o/thw3Tq79HKdbJHBzhg==
X-Received: by 2002:a17:902:c406:b0:1d8:ab27:d76c with SMTP id k6-20020a170902c40600b001d8ab27d76cmr2414876plk.51.1709214854696;
        Thu, 29 Feb 2024 05:54:14 -0800 (PST)
Received: from thinkpad ([120.138.12.68])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001dca9a6fdf1sm1484066plj.183.2024.02.29.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:54:14 -0800 (PST)
Date: Thu, 29 Feb 2024 19:24:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <20240229135407.GE2999@thinkpad>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
 <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>

On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:
> On Thu, Feb 29, 2024 at 05:54:16PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Feb 29, 2024 at 11:25:48AM +0100, Johan Hovold wrote:
> 
> > > As I mentioned, the 'required-opps' binding update is needed to fix the
> > > missing OPP vote so blocking the binding patch would block merging the
> > > DT fix which could otherwise go into 6.8.
> 
> > I agree that the fix gets the priority. But some maintainers perfer to merge fix
> > patches _only_ if they are fixing the issue introduced in the ongoing release.
> > But if Bjorn has no issues in merging these for 6.8, then it is fine.
> 
> It also depends on the severity of the issue and to some extent the
> complexity of the fix. These binding fixes are certainly low risk. :)
> 

Right.

> > > The 'msi-map-mask' is arguably a fix of the binding which should never
> > > have had that property, but sure, it's strictly only needed for 6.9.
> > > 
> > > And Bjorn A has already checked with the Qualcomm PCI team regarding
> > > ASPM. It's also been two weeks since you said you were going to check
> > > with your contacts. Is it really worth waiting more for an answer from
> > > that part of the team? We can always amend the ASPM fixes later when/if
> > > we learn more.
> > > 
> > > Note that this is also a blocker for merging ITS support for 6.9.
> 
> > I got it, but we cannot just merge the patches without finding the rootcause. I
> > heard from Qcom that this AER error could also be due to PHY init sequence as
> > spotted on some other platforms, so if that is the case then the DT property is
> > not correct.
> 
> I've verified the PHY sequences both against what the UEFI firmware (and
> hence Windows) uses as well as against the internal Qualcomm
> documentation (with the help of Bjorn A). And Qualcomm did say that such
> errors are also seen under Windows on these platforms.
> 

Well, sometimes the init sequence published by qualcomm could turn out to be
faulty. That's why they publish v2 sequence and such. And I want to rule out
that possibility in this case.

> But the fact that the symptoms differ between the CRD and X13s, which
> use the same Atheros Wi-Fi controller (and the same PHY initialisation)
> also suggests that this may to some extent be due to some property of
> the machine.
> 
> Notably, on the X13s there are lot of errors when pushing data
> (e.g. using iperf3), whereas on the CRD the are no errors when running
> such tests.
> 
> When leaving the CRD on for long periods of time with the Wi-Fi
> disconnected, I do however see occasional correctable errors.
> 

This may be due to hardware design that I agree (possibly influenced by driver
defect).

> > Since this is not the hot target now (for Qcom), it takes time to
> > check things.
> 
> I think that based on the available data it's reasonable to go ahead and
> merge these patches. In the event that this turns out to be a
> configuration issue, we can just drop the 'aspm-no-l0s' properties
> again.
> 

Well the problem is, if you are not sure, then adding the DT properties is
certainly not correct. As that implies a hardware defect, but it may not be.
So let's wait for some time to find out the actual issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

