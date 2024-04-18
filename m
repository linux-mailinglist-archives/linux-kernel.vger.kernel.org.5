Return-Path: <linux-kernel+bounces-149613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6138A9379
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235AA1F211A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456356462;
	Thu, 18 Apr 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTD5MRAQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514952F86
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422776; cv=none; b=eW03LY/q6K0o+oMSXy+t6k6NjodZ8RJaAsfarGCrRpR/bcVLy44inqsCgFrfosuKrOlageFq0dNkgwU3p6MTu3PaiN/tZ3L3J3k6LNWH+2WRIki1MQEPmAAM79lfgE4j57wP551SqXi+nFXukNGbcGpH+NrDRJjRiiHGE6yC+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422776; c=relaxed/simple;
	bh=2iicvfBJ14haF0z4MlgN0sCfropwn459k86+iV+26Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flUx9Wrx/+OhL2cenO7pQgoWEH0LSYUQ+ihVEWFTeNcEfVQBpQnxSznDY3HIn7qSmF+qq61zZY35N6U3peWuGVLgG/njO0Hp2AiCmQNsUoRZ2victyb0uRmknOpZr3v3ZaEs7qZa0/oUOGV/j9YtdWf99VRcAl8ZXfSVcRuHOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTD5MRAQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed627829e6so655588b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713422774; x=1714027574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X3PCJ8oWEN4XTlqP9Mrd76yonyPYEOnddtJpcolQuiQ=;
        b=gTD5MRAQtL27f38e/H0wvtqO7Gu590JtiQ96Yuc7nBmWf9Xl9l7f/topjiDQwaOFhW
         GIDrD5shZkpfERwyASspOHcgrTrFTijhA26qKatTvyeEvHu7dr5xAUzFPN5Lu7yvvC7K
         y/dB8NBN2SCRGmZgSfQGTFbjqR/4+OnH4z7+VMHacoAGXkMjbDzzb7OgJxYsfQsY/bNC
         xPugv8LdMc/0IG6qGLOKWqjuKaRAwNJmV6s0bUobgWz2nJ/muCycMEEJ0bgZE78vMmPa
         Av9QjqJuF+YHe0q93eB/4wOK3RjiZbhITZR/gtswTWrdppmjOSeIU1KseJMUKNzRMoZZ
         QQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422774; x=1714027574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3PCJ8oWEN4XTlqP9Mrd76yonyPYEOnddtJpcolQuiQ=;
        b=AkAsOuWX/L9fOkAlXP1AP8Pu6C8OS/tiC6WHSXF1xbByM/xWIaeQm65a4WUkhrtxML
         sQzu1xq50nAuc94qowwy/Qw+gmp5XjJZb/JidC56oAjbBvG7VcJkEa23wzLch6Qi/Ekd
         Sf+hZ86Pa78flB2Dw9yFQqe8xp8M3cikwUH0WrwokK8kPgLzoKK5uj6Mjg73BWZieNAz
         Fp9Xe+F32gIC0UW01MH+zzZZ3ae4LCsLix9qLsOr6RVZPvLvcup4dqwqv7Pl3TvSvSx3
         h/5DU2zCaI7VPW/fczrOTsu7jOWDUAHFDmG8nyZwMFDauHmhiW8WDHTz0S1Or5PKTwXQ
         YrQw==
X-Forwarded-Encrypted: i=1; AJvYcCWvHtDJ++rz764Ii/IFlTuttWhs8We0kIIFtJ1Bf1Mi7tN7S1spEfjCyXUnOd26No7rIpQSi6iYOPfugs/pm5zjLWWMgkUsGcfA3TQw
X-Gm-Message-State: AOJu0YwAXgbCyzkV6583i8CIo9Lthrxo7P6X/5vmDLHQqmCvvBR0yayP
	vj+GDL4apJSH8yVsZd8BxACRCkO4K5yiRGVP9OZOPO3lo7EQ/IZOL4/kvEaqhg==
X-Google-Smtp-Source: AGHT+IErIqcWnCwFDCXU2XNuAS5mw68F14w7Ox0Xh6/c+FP9VMngm+XN6I+b5z3vrGagpyTKzVAaOg==
X-Received: by 2002:a05:6a20:6a0d:b0:1a3:6fbb:e31f with SMTP id p13-20020a056a206a0d00b001a36fbbe31fmr2824885pzk.4.1713422773881;
        Wed, 17 Apr 2024 23:46:13 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id f33-20020a056a000b2100b006ecee611c05sm752862pfu.182.2024.04.17.23.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:46:13 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:16:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
Message-ID: <20240418064609.GF2861@thinkpad>
References: <20240412095031.256163-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412095031.256163-1-alexander.stein@ew.tq-group.com>

On Fri, Apr 12, 2024 at 11:50:31AM +0200, Alexander Stein wrote:
> With commit 5779dd0a7dbd7 ("PCI: endpoint: Use notification chain
> mechanism to notify EPC events to EPF") the linkup callback has been
> removed and replaced by EPC event notifications.
> 
> With commit 256ae475201b1 ("PCI: endpoint: Add pci_epf_ops to expose
> function-specific attrs") a new (optional) add_cfs callback was added.
> Update documentation accordingly.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

With the change mentioned by Niklas.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v2:
> * Separated paragraphs by blank line
> 
>  Documentation/PCI/endpoint/pci-endpoint.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 4f5622a65555..3961ff4e5beb 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -172,8 +172,7 @@ by the PCI endpoint function driver.
>  	 * bind: ops to perform when a EPC device has been bound to EPF device
>  	 * unbind: ops to perform when a binding has been lost between a EPC
>  	   device and EPF device
> -	 * linkup: ops to perform when the EPC device has established a
> -	   connection with a host system
> +	 * add_cfs: optional ops to create function specific config attributes
>  
>    The PCI Function driver can then register the PCI EPF driver by using
>    pci_epf_register_driver().
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

