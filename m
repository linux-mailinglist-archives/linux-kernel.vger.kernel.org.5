Return-Path: <linux-kernel+bounces-54355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6484AE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366A7B23CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F478B78;
	Tue,  6 Feb 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVrHILVe"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE60745D1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707197585; cv=none; b=rRNfgnSB5g66VLzrI07VhITVOlY6hTtf3W0AFCvNG0YRHm9RijUbE5VhDftHJL4J6GQcu35PBcnEbi30XHWUTvT/ZvcImtpOZ+Ach9mgfquhFqHjITVcoJ6kKrsonxYhKld+ozQ916fWQGze2LEidMYlA91luEIGSKA6s9HQWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707197585; c=relaxed/simple;
	bh=Ui+JUqgpTROVByU1PNqr7sknWrjQ+hS/sSnSZVf0fhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzBMUIINJEzbL7UzIO7Pz3NvzbAkstNwJgKz/zBZyGYc6HY4dlBQsx5kaMj03uAEBR6gUh7uMTqISK1S6kYqxnKMo4j85yBE0a0Mw7Lq/w+PmFRsloVsAV2McPDsypqtHYakWJe2h3haODaKTBQD1ux9GUyT1pxMWxujHh7/3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVrHILVe; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bfcf606936so1483731b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 21:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707197582; x=1707802382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ydU6BbxwzhKtYby2dXMvJri2N0Iv1xyu+D32zjFW9Fo=;
        b=hVrHILVeJ+JF1zUONEv6gQu+YgcRtL5Dy/sMogpI3zMzmAjoPAVGvQnCr7Zt8XGMJd
         ctF8OSa5wcvP6cYEOU6ujcQX3Fu731eeJEtbDmMcXzcRm2l8nBYSMZMu4SOYIT0BGss6
         MpK1/IOg2hXglbQcOl39uJsBzyqVhXKCNKpFjK+/4UBK/2gfrFwIF6JJ6gD5LGXwbtRH
         OL86u3w625T/+eRBPSfcakxDtVmUJNPDp3peESL7qORRYHv343ZIY8fwZ1uclwQi9oVY
         csoB5GIuMAgGwXLJEsdEIsn8quZjnRjn3/d7Lrb51VEhAmwa3aeRdcfBMxnE1GEQhvaI
         G7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707197582; x=1707802382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydU6BbxwzhKtYby2dXMvJri2N0Iv1xyu+D32zjFW9Fo=;
        b=Hrk1myXj//AcfCLCe8gGPFDHyr4dfTWEJUuZjFb8KP/E+SO9OgJP2HNA5xwvtcK1cf
         xOPpFNyO/ApuI8t0F2vkLXsqnPRinZgIu7LKlbae2jO6xOxhGT2jV4aLR+wTWiNl5em5
         PH/iEr4YR8T3P7jnqTzUkHb9MmMzWXt7AkXf1+hBIWdCTzC6/vc0jz7J4s2pMi6/c/a0
         4NQHUbYhxH6+9LxX0VZDYnkfSAFS/TllrvU+R6sd55vwrbxcZhxLS5/rfmKN0uxk7Ivz
         YrDzemPssh7MIL8UBEU597r/pim0adqbl1X3lVQJweqkOIMQmN0XxBFUV0oUhpBKnRXv
         HKLA==
X-Gm-Message-State: AOJu0Ywrdp3EB7LUme/kHXXAP+XEoG8MAgI9tYCDhUrlmxdGAXKmHqx4
	HYO4V4C/A8l0Ac9njKVHkDuUWK+ka8vnyJQmZydPkavmLTiXAOJsa5QxmzRuiA==
X-Google-Smtp-Source: AGHT+IG3C0afHDBZwdkrvhFt478xwoB+XQ/Bi2elhj/RlkQqEjBD3zrZSRKNEhbEZ38Dzl5IL9OEpA==
X-Received: by 2002:a05:6808:f8e:b0:3bf:e451:2c05 with SMTP id o14-20020a0568080f8e00b003bfe4512c05mr1077265oiw.43.1707197582466;
        Mon, 05 Feb 2024 21:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/IZHrFGLasi2jG1XOdy47tNQMPT7dhgSZibT+eZ1lfXCBvG5rp9H+wgyZ9f2ektNGqOKGC//wkDZHQaTO38vku+DRl6MiTuwXcgm3ngsTmM/MPUGjv24nx7KJ64g/E3KvwooCKI2pN57wgf0X5szf6L/A3EiNimTiseA7ptYJVpxpw0M7k1zjEYXU3v3+wmSUSnssVvht49WlkiRb6mHMIrBtf7heBv/Y4/rgOsNGHRaqP/Ofjv133g==
Received: from thinkpad ([120.138.12.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a62ae0e000000b006e0472fd7d1sm863952pff.130.2024.02.05.21.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:33:02 -0800 (PST)
Date: Tue, 6 Feb 2024 11:02:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pci: endpoint: make pci_epf_bus_type const
Message-ID: <20240206053258.GA3644@thinkpad>
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

Applied to pci/endpoint!

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

