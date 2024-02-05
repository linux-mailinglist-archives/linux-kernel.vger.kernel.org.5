Return-Path: <linux-kernel+bounces-52774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9419849C86
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73EDB28428
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF82374E;
	Mon,  5 Feb 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUGTWMmG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9C28DD5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141702; cv=none; b=C/H9W1zUxDYDn+0ut0CpREUEwiS1fZ5uf3nwa5o44BedBIUo26qGTh6YzJDrhrf8YZyzPlQVGGBXm1kIFNJRSro8rfs3rPdiKDPLSx2l/7UnKAqz0E7e2y5gGQfP+nAnfzG3694Pnirfbfo+8+BCkgYs9815WCZ125WNjpgDGTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141702; c=relaxed/simple;
	bh=MyTVmMBQT9yymCwADUCyBGvNYezZ+M55ItXy/0ugLZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szXG50qo1So7Ic5LZIH7GGkL/LnRNG63Ete/tuWwFgBAYqCr2b7oh3xctc+WG/N94m1yqS7ZyQBCY5abrdj+FmZppyHn2qT5oI4INuNQyEuxTCGXfSmUHCfvjmcGRI8wpraQCo0AMD2PSQjjFkQ6u5Q8ObNlccZLWP6A5kiSEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qUGTWMmG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d74045c463so34245125ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707141700; x=1707746500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i3rlc43mBAmmIKSu5xBLrJwDwD6hK6gTpzaGPsgcsxg=;
        b=qUGTWMmGNBPoB8i9rTw31wfFMWYrAeq02bK68paGUH/CVdiha3qvKTcz/mByhsAm5S
         7lOVKQhVi7frm1OEW+0AcUClFhAKBVkE+E/wYNXQn+9hmCPL+j9oLSkGG6c6pnzURkfp
         PdZFBueXfXeWRi/8QgHVwBV/qPtqHcfl9uBrh6NxE63kIQmLK0gQRHTvh8R8Uwdaiul9
         TShHfY5S3ZBV+IBM74jhn2E+mTJNi0fdz3aZeqyXN7hcZ8r9Q4kYUOkTOUG3uRnb9WK5
         9IcsDR1wsZqKo0Yl/bpuXdG8EkT6sUcXovAG2u/c2nvjBYUvhuTxhdgmsgKlg+pkioyG
         34QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141700; x=1707746500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3rlc43mBAmmIKSu5xBLrJwDwD6hK6gTpzaGPsgcsxg=;
        b=X/Sie5sJNLJf3UKiX7nEfeEsmJTJszL4xfHTllRV5WGLFQIlAt64GfvoCCjdmj8eLl
         AuUSmYe5KhDurpwJmypw9aVbcMBmibEflWTJAnGx8yTx4bTIB3xFXZX2KQ7Aunk+BCEJ
         k9CKAQb94kg2VVJAFqmpwukDbU8qY5oXEzxDSB6QZas/EtQzRLMMxBATScwjkoNLqUcN
         awf/R6HSu2AYGM8PU4IS1lY+F0mDNu4XPjfvmJGkhQVBb2/3Zpu+xPBuq4pZCLyjrySY
         a1xIbna7qyeQUGRW2d0p5XP8X19y/mho8U6fciwgTZKCCbMNm7CCANKD10KOjxh7zS85
         LYgg==
X-Gm-Message-State: AOJu0YxiCfTFmVYSz9e5FpyyRyCHvrv5UAtAvq/V0jxTkUXHOE2vvgaS
	JUKUrovhTi7fd0zsCU5MYZthbzcaMGkEpB8cy0A8KnLQYrqm1khw4Yg/zuatjw==
X-Google-Smtp-Source: AGHT+IGkD3eNo22b10rbAKAEVpZrr9NRYYGZtbsfRgoJbeWb7EKAAMIWc9ujJ7xFK40zBZ7wNKqtrA==
X-Received: by 2002:a17:902:e981:b0:1d7:244e:531e with SMTP id f1-20020a170902e98100b001d7244e531emr8689792plb.25.1707141700327;
        Mon, 05 Feb 2024 06:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfHNwuYa8MJRPrOHempccXKIzbSidWB3DSkhZaf9iZkwjtK1uCNRodO6SV8a/drGuCro1p6/P1EW33Nl1ufCyCGuFJJuCvil5GGiLzRdydeqxf9kq/byI6Z4OJWbGLuSBMPkX17pPmQ6qUu/LslFIFx4KXxmTe08C2aar9LIyFELU1/64zfkBZi0KEKM5viadAvAMxtl6hw5ovumdtzmUju6BZn19LfxqMu7X3I1AXHdvDCUuskjWjRg==
Received: from thinkpad ([120.138.12.228])
        by smtp.gmail.com with ESMTPSA id ju15-20020a170903428f00b001d75c26e857sm6349179plb.288.2024.02.05.06.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:01:39 -0800 (PST)
Date: Mon, 5 Feb 2024 19:31:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pci: endpoint: make pci_epf_bus_type const
Message-ID: <20240205140135.GA9617@thinkpad>
References: <20240204-bus_cleanup-pci-v1-1-300267a1e99e@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204-bus_cleanup-pci-v1-1-300267a1e99e@marliere.net>

On Sun, Feb 04, 2024 at 05:28:58PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pci_epf_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 2c32de667937..bf655383e5ed 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -17,7 +17,7 @@
>  
>  static DEFINE_MUTEX(pci_epf_mutex);
>  
> -static struct bus_type pci_epf_bus_type;
> +static const struct bus_type pci_epf_bus_type;
>  static const struct device_type pci_epf_type;
>  
>  /**
> @@ -507,7 +507,7 @@ static void pci_epf_device_remove(struct device *dev)
>  	epf->driver = NULL;
>  }
>  
> -static struct bus_type pci_epf_bus_type = {
> +static const struct bus_type pci_epf_bus_type = {
>  	.name		= "pci-epf",
>  	.match		= pci_epf_device_match,
>  	.probe		= pci_epf_device_probe,
> 
> ---
> base-commit: 1281aa073d3701b03cc6e716dc128df5ba47509d
> change-id: 20240204-bus_cleanup-pci-f70b6d5a5bcf
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

-- 
மணிவண்ணன் சதாசிவம்

