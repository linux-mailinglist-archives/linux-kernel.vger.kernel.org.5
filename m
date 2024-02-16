Return-Path: <linux-kernel+bounces-67932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226C857338
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2127B22D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD1A14012;
	Fri, 16 Feb 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXydQAG7"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB8944E;
	Fri, 16 Feb 2024 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045775; cv=none; b=joD+pnMu0unuqUZfuCy3kYGfOKsytEb6QqKJCgCk6bTJOnq1VRR2lnLyn/nztA4KGJpNzz0h6dR4ESG17LqEtk3dgVhl4RzYsYMuvqRElCpqcqLdQZh5KpZAEjQNmSN/knYTzP2uxvxBGglbr6zXlVuYTh0KaJ9dDmuTYnAFPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045775; c=relaxed/simple;
	bh=MEXwRTRItH1f21LdLAhXHSyx+uvBdLLPuakRRV/+COQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHIze6KYNdNLwkkNj/BOZwuI+3Dil7X3tBgWqyZvrfcItrQqAMfbzg1Y5Y8steooW/cgBHia8HKnKeOzH+bF/cJtbHNPnvZw8Hi0kmJZRn1vlyxSxVJBkfxNznUx6/FJSYT13bsBknbbLax9n21qiQtOtTopijcExvuW994EAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXydQAG7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-411ef179d2eso1238465e9.2;
        Thu, 15 Feb 2024 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708045771; x=1708650571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27bke80ddywCazlRmoOHCwP+7wweeSQCMa6vpRUkpOc=;
        b=TXydQAG70b9AJxEH1s1k8B9+k5aq5hsIAsWG89xox3Tfwi3FHABbU2R0I7IdRrv+3f
         jbAqob6GxDW/uwY/5J1IfNAlBAL120cKmsi0Sk36vsFvgvu7dzAZj3ZKphsDFpny3+hC
         xnTEbh2Pn7cOD20f+vulDwFISa72nK/FlHbNNCutk74Fm2j8lcR5cZHu/Z9Iu2dtpcsd
         6+mCSY9O8uZaSQQhrvS7lXvPbfEuJYDLb5tsTPSoZwyJqlhOtVHxQ6STo6PsI+Jf97du
         ex9julLodFUms5YSdXPf4OtQqw6JeATy4ZbElCpcUFNo9vq44iqFOmuS3ro5lNgryngn
         dh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708045771; x=1708650571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27bke80ddywCazlRmoOHCwP+7wweeSQCMa6vpRUkpOc=;
        b=HnBH+lbCYaAaZWRqb8oBJsHMwio+oF1mDUENp7F2v4o+xqOHY2EYR0OfM3T32c5hww
         zwb77v6fG4p+vSdJ8dGLFvJhgavWfrYMnZrM7z8tAUMfbi0tAwShKUBm1L1qlJAhlnrd
         7YgIOws2EjOTdld8eYiASxWoF9ZVPnu4PFevb+olraoLx3T9TPxPbFyPjMLDBruW/Aah
         eHJQK+S+NE+RG/cAYR83iUKX3laKNNl+9p3ffVQbzji+8+tTsLccNO0MTnDYYMpKuimN
         T0y1+AZuqOJHyT2iG85L+X9dB+JzXE+pykbuJM2FHT7fC6NVxpdCVWlrOkuaMm4CAqlk
         Mkpg==
X-Forwarded-Encrypted: i=1; AJvYcCXrjbLiXT/S3y09XrvGH/wh4ZKHSIIK4Q8aI8gYQdTH/AX3rx4QVfN/DidaT3zvBqy85GyO8fXSKDT7WPJR25XzRUdLL5Uks4ILK4fAMKM9eh8xNX1uwBKJEI9gUOavTWAuVMBq
X-Gm-Message-State: AOJu0Yz7qKrOPV3OCnFYw0hehUzwY6x08Lzqrwa1ru6VgiXXkyFbii05
	mM8rK4BihJY9MqaSNAfbuRRYsfFonHQa50qhpYrhPblst/GXvAL9HrKb6K15yj0=
X-Google-Smtp-Source: AGHT+IENGeTt5VvV45navm4htJQYdSKkxercirQUs63cl9s+PjCLaxDycb3HezB/VSu6KLG8QeiiAQ==
X-Received: by 2002:a05:600c:602a:b0:412:19cc:ef65 with SMTP id az42-20020a05600c602a00b0041219ccef65mr2401141wmb.29.1708045771467;
        Thu, 15 Feb 2024 17:09:31 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b004122b7a680dsm708559wmq.21.2024.02.15.17.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:09:31 -0800 (PST)
Date: Fri, 16 Feb 2024 03:09:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helmut Grohne <helmut.grohne@intenta.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 18/18] net: dsa: microchip: Check return value of
 of_get_phy_mode()
Message-ID: <20240216010928.6gb6abjf5j356f76@skbuf>
References: <20240211150804.3893-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211150804.3893-1-d.dulov@aladdin.ru>

Hi Daniil,

On Sun, Feb 11, 2024 at 07:08:04AM -0800, Daniil Dulov wrote:
> of_get_phy_mode() may return an error, so add a check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: edecfa98f602 ("net: dsa: microchip: look for phy-mode in port nodes")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index e3c338624b95..faffce6ea1e1 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -434,8 +434,10 @@ int ksz_switch_register(struct ksz_device *dev,
>  					continue;
>  				if (port_num >= dev->mib_port_cnt)
>  					return -EINVAL;
> -				of_get_phy_mode(port,
> +				ret = of_get_phy_mode(port,
>  						&dev->ports[port_num].interface);
> +				if (ret)
> +				    return ret;
>  			}
>  		dev->synclko_125 = of_property_read_bool(dev->dev->of_node,
>  							 "microchip,synclko-125");
> -- 
> 2.25.1
> 

Not all functions that may return an error, and that error is ignored,
must be fixed.

Here, if of_get_phy_mode() fails, dev->ports[port_num].interface remains
at its default value (0, or PHY_INTERFACE_MODE_NA). It is a valid value
to the rest of the driver at least in some cases (user ports connected
to internal PHYs). And since device tree is ABI, you are proposing to
break something that may have used to work, by making a previously well
treated path now cause an error.

Sorry, NACK even as a matter of principle, do not even bother to resend this
without a more careful analysis.

