Return-Path: <linux-kernel+bounces-68991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38252858313
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695D71C2243C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC3130E4F;
	Fri, 16 Feb 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMRdlQnU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271E130AFB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102456; cv=none; b=dDHm55/I3VKn2U2KULwAqDMFSBzD4N4rvbhAiZgDR89cDWghfn0ye35Tmi2qUtbcfbEcbHxIWZLYvMikex0+r2vXP+/6W/xN+QPL0SRqYjCJDQvT6Ab9S66Pck7qGjr/urpoDi+nPwMWK0n+lowo+A5pt3GbR6pB15KZyEo/3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102456; c=relaxed/simple;
	bh=Y91UWNzXuH8p9y2IvbH82XnOrZASUCU2q9704Gj6jR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgvSNbc7fSBhTLgDUKosdxBBHluCdiLemvTIPNUIZBzxYjY3o84s4JhQ4g8yRQqI7/WmvpPr9Te10UZzeGjs1VDwCCkPR5sz+J/W/Crx0Yp/KiJNL04cdst72ayTP0VnGknddd6eEBT8VeksyXwiRuJIQUgwsjk0gVmwkwWZqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMRdlQnU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da202aa138so1668749b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708102454; x=1708707254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=br2N/R8PHJEVGm+jIHqD2c6+5tUx5kxjgFiSBw/i4S8=;
        b=SMRdlQnUiv+6LrQ2ehvig9k9l5PaWzqQsSAhpqnhg3jFBuukeqJ5KBl3oiNaUC6/nA
         30CJEXE6F7rc4/CTEfQ1I2L7c0BvVKXKj2d7cHIW+lvbJoXWstUhW3vsgS/sw1C+V9wZ
         0IrIuTx8B3KBVaM1A5+y1yTn4WMhHpqKOuG+XxFQx6CShjM0JdC2FQOsiEXvDUr3Jw5d
         X/SOeJBnQlvBN76yMw2miOxyssUgDnFG7TaT474zko52/yM9D1D/7PRZB0rOS2CXtZg1
         3KEDx1XWENcW93LB7jz1J+3Ssr7BpqYnx7CH4bnioOowhSN0xJbT3ENUzYyn1IqcQJqf
         qJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102454; x=1708707254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=br2N/R8PHJEVGm+jIHqD2c6+5tUx5kxjgFiSBw/i4S8=;
        b=iY/HcEP15pnl6bBAaO62VD44hjTC8RAQw15LtGm0yQHSs9yejI81fIc5eDZPhPl72e
         ZauqhSJGpBWTX5w6jf5wFmBeWvXlOSTGrriQwbihwWuAs8hzJ8jVeFEw1UswdA9DduVF
         9lWexsXXJ/TxFj+YRY41cNnj6M0Py72HiprYpir7HtwMU0mr4W1WIWQi9dL2tRR6ILNe
         9GZFq96PWRMSg9adN3sOD3E/mXX8ZHWqeIn0dEA6t04cjKVbN2IWCReBOhLHT1hhgATj
         Atg3V9kTfE0k+mH3TKELwZF2IGWrHs6UL3NAFjVrUiMoA5gbeib5mQRHhbOPpWfaqLNh
         cDcw==
X-Forwarded-Encrypted: i=1; AJvYcCVPTXUJCIGbIAHS+waxoi64FnbAzBUUCZFDH+lpde0pR5i9JRVZwvEVr/kPUeRCXYTjjAmcrxXRUBv74BjnSgM0S1ZWr5GanTqI4dsl
X-Gm-Message-State: AOJu0YyP8HUgEDrZ+gu8YPMCWEVb6zJLhdaMWsTkJC1hgeF3uTE1sVcH
	D+namfo8LvjKPjuwsrqrLyiuBFNdno6OdrODUv7ljXJ7mRLAikmsQKG/iWWTxw==
X-Google-Smtp-Source: AGHT+IEg7nBZgAV6mmmXqEFA0ksN6sm799MQHapgL/DdyvYAzH6BOQl3qC6EYPbvT0oVYUmjTjUyCg==
X-Received: by 2002:aa7:8a56:0:b0:6e0:f2a6:abde with SMTP id n22-20020aa78a56000000b006e0f2a6abdemr5363330pfa.5.1708102452975;
        Fri, 16 Feb 2024 08:54:12 -0800 (PST)
Received: from thinkpad ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id gu8-20020a056a004e4800b006dde35245d8sm173857pfb.58.2024.02.16.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:54:12 -0800 (PST)
Date: Fri, 16 Feb 2024 22:24:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require
 'msi-map-mask'
Message-ID: <20240216165406.GD39963@thinkpad>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-3-johan+linaro@kernel.org>
 <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>
 <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
 <59bd6e54-0d5d-4e1a-818a-475a96c223ff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59bd6e54-0d5d-4e1a-818a-475a96c223ff@linaro.org>

On Wed, Feb 14, 2024 at 02:38:57PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2024 13:54, Johan Hovold wrote:
> > On Wed, Feb 14, 2024 at 01:01:20PM +0100, Krzysztof Kozlowski wrote:
> >> On 12/02/2024 17:50, Johan Hovold wrote:
> >>> Whether the 'msi-map-mask' property is needed or not depends on how the
> >>> MSI interrupts are mapped and it should therefore not be described as
> >>> required.
> >>
> >> I could imagine that on all devices the interrupts are mapped in a way
> >> you need to provide msi-map-mask. IOW, can there be a Qualcomm platform
> >> without msi-map-mask?
> > 
> > I don't have access to the documentation so I'll leave that for you guys
> > to determine. I do note that the downstream DT does not use it and that
> > we have a new devicetree in linux-next which also does not have it:
> > 
> > 	https://lore.kernel.org/r/20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org
> > 
> > But at least the latter looks like an omission that should be fixed.
> 
> Hm, either that or the mask for sm8450 was not needed as well. Anyway,
> thanks for explanation, appreciated!
> 

msi-map-mask is definitely needed as it would allow all the devices under the
same bus to reuse the MSI identifier. Currently, excluding this property will
not cause any issue since there is a single device under each bus. But we cannot
assume that is going to be the case on all boards.

I will submit a patch to fix SM8650.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

