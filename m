Return-Path: <linux-kernel+bounces-46815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC158444A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA51C20F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B312AAF4;
	Wed, 31 Jan 2024 16:35:27 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BB1EB2D;
	Wed, 31 Jan 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718926; cv=none; b=rZsfzgycoUSgyJq1MGBnqVNz6sa6DxzRZPUiLm0MC8U1m5hMcaICjWPBrW6kRwDlboJ9QnYSHlXCbLcwKD7XTd5aio6tKD5oVg/5YhFnTe/uV6/rdzTGDzEQefPDMQjoPYOGhs+Frzq69f/WiDRA3w7vgjslidRxcpr2G/erHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718926; c=relaxed/simple;
	bh=VSpwdDp/WkYXU24sx0R69NnqFerIpT2TK02WiSXU7AY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8q3RSx689sASnIdEa5HYd2O+P5FZqEpsS9TFawa8fd7IBrq/YFIaDxJ0DzqCBws0nh1wrN8JFMyCk57EU+3YD9OdO7BFOd/1gylAvANxYsmOq/hVV9mGjK7jHqffIHV2i5pD4Db+GfVo/CyWHaHFaZVIpMrsBXG05ZX0/d92g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQ6yJ68Z9z6K5Xs;
	Thu,  1 Feb 2024 00:32:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F4D0140B2A;
	Thu,  1 Feb 2024 00:35:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 31 Jan
 2024 16:35:17 +0000
Date: Wed, 31 Jan 2024 16:35:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Naresh Solanki <naresh.solanki@9elements.com>, Peter Rosin
	<peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240131163516.000043df@Huawei.com>
In-Reply-To: <1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org>
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
	<1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 31 Jan 2024 09:29:59 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 30/01/2024 12:56, Naresh Solanki wrote:
> > voltage-divider is always an iio consumer at the same time it is
> > optionally an iio provider.
> > Hence add #io-channel-cells
> > Also update example.
> >   
> 
> Fix
> wrapping
> and
> proper
> sentences. Each sentence finishes with full stop.
> 
> ...
> >    output-ohms:
> >      description:
> >        Resistance Rout over which the output voltage is measured. See full-ohms.
> > @@ -75,12 +82,17 @@ examples:
> >              spi-max-frequency = <1000000>;
> >          };
> >      };
> > -    sysv {
> > +    p12v_vd: sysv {  
> 
> No, drop label.
> 
> >          compatible = "voltage-divider";
> >          io-channels = <&maxadc 1>;
> > +        #io-channel-cells = <1>;
> >  
> >          /* Scale the system voltage by 22/222 to fit the ADC range. */
> >          output-ohms = <22>;
> >          full-ohms = <222>; /* 200 + 22 */
> >      };
> > +    iio-hwmon {
> > +        compatible = "iio-hwmon";
> > +        io-channels = <&p12v_vd 0>;  
> 
> The same question as for v2. Drop unrelated example.

Conor requested an example of the device acting as a consumer and a provider.
Might have meant in the patch description?

Conor?
> 
> Also, remember about rule of posting only one version per day, so people
> actually have some chance to look at your patch.
> 
> Best regards,
> Krzysztof
> 
> 


