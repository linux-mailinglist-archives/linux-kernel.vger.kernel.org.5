Return-Path: <linux-kernel+bounces-43700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED68417F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6042846BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827662E821;
	Tue, 30 Jan 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjeY2UZ8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4A22075;
	Tue, 30 Jan 2024 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576263; cv=none; b=FJbeeew2TRpQYLl9b+Odb0m5OgyuRqYfIKHxOz+wfi2nP59hcLCW/2jariezHAQJyf9Zbg9GR01KC9skBZfp6dJukhL9gvPsVBA84IXnrtrBjsUUJ9EAk88v038DEq42q+rVuCiEj0YYvzfJvvYRK3QWkbRujzYbr24JJCOwUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576263; c=relaxed/simple;
	bh=X9IYwZ0wAz7/0IuN+ro/CjSDJW1m3SVnz6v4s6j8Aho=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYDeiU6vgQSGzgZR9lNDAhhJMCA10w4o/R0HFiobiaH1jErxcoR0i+wpr3SAd5N40Uy7DEeVhH3QEAE5DVq+LNA8l4TFUYkz3AMI0RcqWNmcBdgpEQOs6O/qvAEMxgkz22ZotIkAeyIehIlizc6AH9IsHHu6mRWFaWOTR8VCQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjeY2UZ8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so40236615e9.1;
        Mon, 29 Jan 2024 16:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706576260; x=1707181060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GpsTXIvTwqLCIz6H2ZuuyCkCgL2s3BPFwpWqSogrCVY=;
        b=bjeY2UZ8kOz+tGvCQM19pm0alERktC2PJayuwiX28ht1K4iX2Yi1LNWHWuB+vEuaJE
         rS6OOgzHWLVTaQeTeI+mn36CF5lF1g/GwzOrIjsOJO6em0ZHfxyiqpPLPHkpZ6ux28aB
         xIi0RgpH9f048UYJ6bVTyKDVfS6BNMvG67gtHb9O4nBVdiTnL82x9sMAwg06zISpVjRO
         4ou1y8kjAaEoFc1hjOZLNMrhtj6NPeuXyAAInNEN/08lsfAcX87j5T1OBOIE96v0rfjk
         5+I+Qn7bObN2g2JLHwimMjGew9bKQBA87+gWWIzMAo3YgyioIb2B6jTOSqJ3/A2HzEiI
         hb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576260; x=1707181060;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpsTXIvTwqLCIz6H2ZuuyCkCgL2s3BPFwpWqSogrCVY=;
        b=J9tJjN05/OThpEty4SmAFn7d8q/fHE9wdHjiMJSi/sePG+mXYZVXB/TBJnJ4Bsn9pi
         RB3Bi6o0X65a+eNxnV3YqzLXdyw+g4CjT3Heq2oVM75c0lnLGJKWbm/E3QuxSaEeyqKW
         sz0+xZ5VS1gP4ejNXYMQaz0M6GdL6sHMWRMMYuWwh1NyNa3rHqpfoSv8kP9Ok1lNWfgt
         Yh86ak2KFihSy4i07UD3IFytIKObJJXZWvnaBeB5MVpkCSsY5wbkeuf9Evf4SRhx+7On
         Z6s/DqgxkMih0V2CMnNwR+l25FbAdzk0+7YACXrcSiBbhuCMlYKbyDxVEGNZK+JYs7m4
         pl8Q==
X-Gm-Message-State: AOJu0YzNhBrBN6OsV00jnyjQoFXc46TKfNVKtgjivMMoSIMHT4pOzObq
	voCHfATloz+c6jssMErPfvfFb8iiswWNzpioQPVHBF2Ij9Y0Bi+I
X-Google-Smtp-Source: AGHT+IHNuWBvwe8RdtKWNm8iCzcE9pRwvjZMjE7snN8+YxvT2uoynXJ9A+bnnW33Zax6Z3tzVhIkRw==
X-Received: by 2002:a05:600c:3547:b0:40e:fb50:94d8 with SMTP id i7-20020a05600c354700b0040efb5094d8mr1886121wmq.8.1706576260105;
        Mon, 29 Jan 2024 16:57:40 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c138700b0040d8ff79fd8sm11499241wmf.7.2024.01.29.16.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:57:39 -0800 (PST)
Message-ID: <65b84983.050a0220.e1700.35fd@mx.google.com>
X-Google-Original-Message-ID: <ZbhJgAI9pMeSGm4E@Ansuel-xps.>
Date: Tue, 30 Jan 2024 01:57:36 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Subject: Re: [net-next PATCH v2 3/3] arm64: dts: qcom: ipq8074: add
 clock-frequency to MDIO node
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
 <20240130003546.1546-4-ansuelsmth@gmail.com>
 <b1ff77bc-0833-493a-b099-884c727f0341@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ff77bc-0833-493a-b099-884c727f0341@lunn.ch>

On Tue, Jan 30, 2024 at 01:55:28AM +0100, Andrew Lunn wrote:
> On Tue, Jan 30, 2024 at 01:35:22AM +0100, Christian Marangi wrote:
> > Add clock-frequency to MDIO node to set the MDC rate to 6.25Mhz instead
> > of using the default value of 390KHz from MDIO default divider.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > index 2f275c84e566..08ddfeece043 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > @@ -264,6 +264,8 @@ mdio: mdio@90000 {
> >  			clocks = <&gcc GCC_MDIO_AHB_CLK>;
> >  			clock-names = "gcc_mdio_ahb_clk";
> >  
> > +			clock-frequency = <6250000>;
> > +
> >  			status = "disabled";
> 
> If we merge this via netdev, is a merge conflict likely? Any other
> changes expected in this area, given the changes which might happen to
> GCC soon, etc?
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>

Honestly I don't expect much to change here in the mdio node.

If it's a problem I can submit in a separate patch in linux-msm.

-- 
	Ansuel

