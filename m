Return-Path: <linux-kernel+bounces-38532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5183C11A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456261C244F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676C50A96;
	Thu, 25 Jan 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSqj+YfC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404A5731D;
	Thu, 25 Jan 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182614; cv=none; b=uL+vNXcJYbPyx26PUxc/enJgqIXNqXBv9DVyhcK3gIxghRVbnz8q9ZHdVbpA0a/9pGbcZGrnQr3OK7mp0sjUpqihYgF5qrDW/UUITydS2KTXAw6l374IlVnTwSFHrGbfbMW2kH/OZie9RYSZ+e5XkDrj7NVTJE/E1I+W4XmywmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182614; c=relaxed/simple;
	bh=9OP2AYCXD7CTzXDDBNhR6z28ox5cvhSWUThScGzrt+w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bog0JRlwdCPUSVbuAXDdv39qB2Zu0Kc7gudh39RlLYC3h04vYNGGH7Ft8bAPobjNStoMmtMYWlkAw5EfhSEioESQCjyjjkp/kg+xun7iqFtdH/vcy8ojGsdwad/nRr06DhYNxAe0H/oFQDb7FMLoK1lXW2PY+pUozWFyvDOvI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSqj+YfC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso68137195e9.3;
        Thu, 25 Jan 2024 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706182610; x=1706787410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DYXWEmKQIsLe7nv5ynnIoPrTMyRKUKUjaFaattLgh4Y=;
        b=PSqj+YfC4dKUf3TITfNWqC9Y/OljlkLJ+hVYL0FhM/Dcot19NQxX5Bl20+5m+CbCZr
         pkehB2n3JmKF1Orw3gmWgclhwkbtAP32k5jqNSZZR6LQzKHO+RzG2oij1r4OI9pilDge
         3/A+HSO85uK/vA5IFoLokw6mDrRwoRZx8yeRheNPugJ2i9cKQ74vxLMQP1kyK7wnk3Zi
         Aw3l1Ra0SMuAm09HX7g8FMpG57Wz4vuzU9g7MMQJ+tnajXF6loO0k/S72c3DwJSHRYxh
         geu3YQVrUTWQ5ACxTXHsnpFhEORbR/uU+jkDboj1ZHfDf/HrSLMsla3QJXxatpEyoCYY
         iBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182610; x=1706787410;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYXWEmKQIsLe7nv5ynnIoPrTMyRKUKUjaFaattLgh4Y=;
        b=Qqyfdg3L0749d8eo4FDiphObPWzp4qLABYAKRu25lmiTfi4N+A+z+HJXmSgQr11n5C
         82Opv8eDtwOP7wCwXKtt6Y5XP3G9LLw1oqTxmNlwic7gA7uC2InwLJuaCcVn5XV1WCoD
         X+5HYW4z4YYlik5/EVvof2bGk/f0kFPrYxzxKZ9TSHEdGtTALzSgt0lo4BEANaTgor+O
         HNlH+Anpr0LHNRw17cPIVQrKuXkdnLuNacHFQOJyx22wVUY7O0pvqay/Vy+7yBHzrnBV
         HF/h2sMX65LFgyBo8WToVLvO+Y9KKs2eevvz1jtP2L+ToaWxAlA/r2m48+gquvrjDbRG
         z9Gw==
X-Gm-Message-State: AOJu0YxEpIzX1bWFJU6caXg8FfRuo/Nw8R79LSsdyOSYk1ZNhh0DX+0F
	vjHdFQgn38AwKs+hyCHRTo3Y84hVvAj2BPX1pLtIUiofILhmFb+6
X-Google-Smtp-Source: AGHT+IH+/n86D85sKsgvGlpJ6zoWcRtr5Zg1ujyeXp+NnFo+8QR08EJvB11lYtfkWyctEvjXABh0bg==
X-Received: by 2002:a05:600c:6a90:b0:40e:5aa4:44f8 with SMTP id jl16-20020a05600c6a9000b0040e5aa444f8mr405862wmb.216.1706182609563;
        Thu, 25 Jan 2024 03:36:49 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id bl1-20020adfe241000000b0033935779a23sm10153265wrb.89.2024.01.25.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:36:49 -0800 (PST)
Message-ID: <65b247d1.df0a0220.12334.efd9@mx.google.com>
X-Google-Original-Message-ID: <ZbJHzSCj8oGm-OJ3@Ansuel-xps.>
Date: Thu, 25 Jan 2024 12:36:45 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC
 rate
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>

On Thu, Jan 25, 2024 at 01:57:20PM +0800, Jie Luo wrote:
> 
> 
> On 1/25/2024 5:36 AM, Christian Marangi wrote:
> > This was a long journey to arrive and discover this problem.
> > 
> > To not waste too much char, there is a race problem with PHY and driver
> > probe. This was observed with Aquantia PHY firmware loading.
> > 
> > With some hacks the race problem was workarounded but an interesting
> > thing was notice. It took more than a minute for the firmware to load
> > via MDIO.
> > 
> > This was strange as the same operation was done by UBoot in at max 5
> > second and the same data was loaded.
> > 
> > A similar problem was observed on a mtk board that also had an
> > Aquantia PHY where the load was very slow. It was notice that the cause
> > was the MDIO bus running at a very low speed and the firmware
> > was missing a property (present in mtk sdk) that set the right frequency
> > to the MDIO bus.
> > 
> > It was fun to find that THE VERY SAME PROBLEM is present on IPQ in a
> > different form. The MDIO apply internally a division to the feed clock
> > resulting in the bus running at 390KHz instead of 6.25Mhz.
> > 
> > Searching around the web for some documentation and some include and
> > analyzing the uboot codeflow resulted in the divider being set wrongly
> > at /256 instead of /16 as the value was actually never set.
> > Applying the value restore the original load time for the Aquantia PHY.
> > 
> > This series mainly handle this by adding support for the "clock-frequency"
> > property.
> > 
> > Christian Marangi (3):
> >    dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
> >    net: mdio: ipq4019: add support for clock-frequency property
> >    arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
> > 
> >   .../bindings/net/qcom,ipq4019-mdio.yaml       | 10 +++
> >   arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  2 +
> >   drivers/net/mdio/mdio-ipq4019.c               | 68 +++++++++++++++++--
> >   3 files changed, 75 insertions(+), 5 deletions(-)
> > 
> 
> Hi Christian,
> Just a gentle reminder.
>

Hi Jie,
hope you can understand my reason.

> The MDIO frequency config is already added by the following patch series.
> https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058
> 

Wasn't aware of this, as I said in the cover letter this all comes by a
problem we notice in the Aquantia firmware load that was slow as hell
and we just notice the misconfiguration of the divisor.

The feature in this series is really a simple one and almost ready (I
already have v2 ready for the request from Andrew to follow 802.3 spec)
and we really need it ASAP as we are trying to move our ipq807x targets to
upstream driver and finally start using the integrated firmware loading
for Aquantia PHY.

Also I can see some fundamental difference between the 2 patch, mainly
in how the value is applied and setting a sane divisor by default
instead of using 0xff. (probably Andrew would have pointed out the same
thing in some later revision to your series)

Looking at the linked series I notice there are still some thing to
polish and to clarify with DT and driver and I think it's only
beneficial if this feature is worked separately as it's not only needed
for ipq50xx but affects every user of this (ipq40xx, ipq807x, ipq60xx)
and it would be a pitty to wait the entire ipq50xx series to be handled
just to fix a long lasting misconfiguration on various SoC family.

Hope you can understand these reasons, it's all for the sake of making
this driver more mature quicker.

> This MDIO patch series will be updated to just keep the MDIO frequency
> patch and DT document for this MDIO frequency property added.
> 
> For CMN PLL config will be moved to the CMN PLL clock driver and the UNIPHY
> clock config will be moved the uniphy driver as suggested by
> Sergey's suggestions.
> 
> Thanks.
> 
> 

-- 
	Ansuel

