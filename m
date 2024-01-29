Return-Path: <linux-kernel+bounces-42924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A18408A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FAF1C2030E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9A1534F4;
	Mon, 29 Jan 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGak3gxO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B4152E10
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538995; cv=none; b=f0tR9CS0CEJ/DAKCWejIzLN8D5U4ekt4lS/7kU/+ax5mSiFXDc76IhbzbkE6cD+MqhFZ3aS4ijL9xZTEpZc0zdlf1vLC34oLY1cJDPUwWht5nqKf3zkgyvOA39LqgajapCiG7fI4qTtnTm+IYsO2BL13Tjna1LHojJMG8EnsMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538995; c=relaxed/simple;
	bh=mQz79aQlYRR6nrY8Z1ZbdTEyN+L9YfuNpdQ1leoB84U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCjFee9RgyqUUdj/F3pfzb9vY9Q0rkMJCGtwqadBK3tb6vAAtV0ChQvj9sHYgLAWrf3aNoLya5Rdu24+bRb91N1FrDdhY6LDXJ2CdPXq9Z7l9EvajGQgxPfTkDujaoNmbFhkKnnLaToIbURzlW9PEloG0FRtJefgMzeSsTnAsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGak3gxO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so313501666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706538991; x=1707143791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dybJHVElyPmYmx4bcLz0bdWXp1ScZmWQPVLksWb3RYs=;
        b=EGak3gxO3UYw4xCexNMpngBtEgh1f/MVVcOdHPJ6XDtQmEPaY/rbZZ/hf9j3Cfw2WZ
         JP8dGx2O7WRgO9mY+e+3qtyFzb5RWhUVOl0S1u42fUCe2ziXgkvFKbhG4LBKnZJ0OzG/
         PFOF6tVOX2AEmkcdT3rYZqyWd0zSY//+Wv/Y3OAPfSGhaK4QljY39meJYIpx5PQawaHp
         7dBRhfun4guhC5q0sd86BRcGFbinHxY3OM1qYiHBENETNN2xzTtT6F+9ElH9z/xYaz+E
         jca34h1EKVNacvJ3s5Zg/haLPVuCDEgw85MAEZiCQlEPTkfIJ+hlPYqybBTDtCv1BCky
         HORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538991; x=1707143791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dybJHVElyPmYmx4bcLz0bdWXp1ScZmWQPVLksWb3RYs=;
        b=XF5o+n/5f57E4n/ZiP4UlZOmgSoxw5310llevB6XF20fknSklMZWljTtx7JgD6Gu74
         nUBcwH5OTECf1ZYabDm3SPbb6DKgqAYA2/ClqUDfUO44Tabw7GictPWCZL8UFnSRdrk1
         WxONDhzrQ2WybWUCRnE20LD9md4Hjn3oPOR78HePBWKYqkCrZoeTzDUs8u/Dj2gMHsV3
         SuW528rpNZtPi7il8Ruf3QJzHYpJvTr6BeEAvWQDzN0v0jqBarU2pJJdUdMX81bRDn0U
         /XKbLj/AtjllcRVWNeIm1E8jXn2hYS8TTZrczFtceC4aWfLRlnqTLVPXZVpdZNsg6pXh
         ue+A==
X-Gm-Message-State: AOJu0YzM2wbXaQQ1qB7OasOIiSumRsth2fUAZ7d3AdKpGPTIVaMgttV4
	qfIk/DdnvGkS8TsOd6Qg2gkmbCJA2pv1zZKWVziUc+bOmQmE+9jpw9N5MRfUoaY=
X-Google-Smtp-Source: AGHT+IG06zxGFooOARP8WyUROQtl40mgpcuuSrve+Nx55DSoyQP/qoT2UYg2hAS6K5e2DP0BfjW90g==
X-Received: by 2002:a17:906:b805:b0:a35:e525:b265 with SMTP id dv5-20020a170906b80500b00a35e525b265mr1091147ejb.41.1706538991382;
        Mon, 29 Jan 2024 06:36:31 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vb5-20020a170907d04500b00a351d62309esm3325380ejc.39.2024.01.29.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:36:30 -0800 (PST)
Date: Mon, 29 Jan 2024 16:36:29 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the X1E80100
 PCIe Controller
Message-ID: <Zbe37Rr8LRNxEurs@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>
 <3aa071cc-32f2-4228-bd32-6dc2375a4c2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa071cc-32f2-4228-bd32-6dc2375a4c2c@kernel.org>

On 24-01-29 15:19:46, Krzysztof Kozlowski wrote:
> On 29/01/2024 12:10, Abel Vesa wrote:
> > Document the PCIe Controllers on the X1E80100 platform. They are similar
> > to the ones found on SM8550, but they don't have SF QTB clock.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts_getmaintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, use mainline), work on fork of kernel (don't, use
> mainline) or you ignore some maintainers (really don't). Just use b4 and
> all the problems go away.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.

Oups, forgot to run "b4 prep --auto-to-cc" after I added the bindings
patch.

Sorry about that. Will resend v2.

> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> 
> Best regards,
> Krzysztof
> 

