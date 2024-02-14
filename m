Return-Path: <linux-kernel+bounces-65551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27294854EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B98B2D152
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2109660BB3;
	Wed, 14 Feb 2024 16:31:23 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFE604B8;
	Wed, 14 Feb 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928282; cv=none; b=pOpxfj8EgsRA9gun+EYx39HFfUyhmP4lXJJB8BJKuZko25XcHD+msTyGqT5fiDwwM5ALu6FCYF0I2WujPif+eZEf16t3btcVcQVYc66Ac6WLPf56us1ZetcCSITcXrnR3TaHwXAd6caiJv0HIokHkBsmWxvPe2qNRTt4LLMfOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928282; c=relaxed/simple;
	bh=iHDYIb9UHjCSSNfMCliMcUWqNNZ4loQFG/WQmwW7OiM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bf2lajx2l8RD3ydpKzW/H9ETVmcJIdAclqaxduZa7zPmtZ1qqzYCbLsl/ykfB7ATVWAsUnF7TOPetOZ3CPe0TcLdWJJRyqRx2L2Q6Z4cmazXpuXNYc3WpvAqzrHWYm+lRxez4/aUFOHm5sUWdykI5gmkCFUwLSWYfyC9fbSEtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZkBb2wd1z6K6gH;
	Thu, 15 Feb 2024 00:27:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CDA621400CA;
	Thu, 15 Feb 2024 00:31:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 16:31:17 +0000
Date: Wed, 14 Feb 2024 16:31:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
	<icenowy@aosc.io>, <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for
 Voltafield AF8133J
Message-ID: <20240214163116.000031b5@Huawei.com>
In-Reply-To: <i2q2vntbhilrpwppzl367ndoetbyd6guyti4t4n7vtg5pwq7bi@tjkio7zpwrfw>
References: <20240211205211.2890931-1-megi@xff.cz>
	<20240211205211.2890931-3-megi@xff.cz>
	<20240212114738.0000535b@Huawei.com>
	<i2q2vntbhilrpwppzl367ndoetbyd6guyti4t4n7vtg5pwq7bi@tjkio7zpwrfw>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> > > +
> > > +  dvdd-supply:
> > > +    description: |
> > > +      an optional regulator that needs to be on to provide DVDD power (Digital
> > > +      IO power, 1.8V~AVDD) to the sensor.
> > > +
> > > +  mount-matrix:
> > > +    description: an optional 3x3 mounting rotation matrix.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg  
> > 
> > Any power supply that is required for operation should be listed here (even though
> > we can rely on the stub supplies if it isn't in the DT).
> > I used to think this wasn't necessary, so lots of bindings upstream don't yet
> > have it.  
> 
> By stub supply you mean dummy supply created when the *-supply property is not
> specified in DT? Or something else?

Ah yes. I got the term wrong.
> 
> Because DTC_CHK prints a warning if I make the proerty required in bindings and
> not specify it in DT
> 
> arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2b.dtb: magnetometer@1c: 'avdd-supply' is a required property
> 	from schema $id: http://devicetree.org/schemas/iio/magnetometer/voltafield,af8133j.yaml#

Provide one, or don't worry about that warning. 

Various discussions have taken place on this over time and end
result is bindings should require them to differentiate from power
supplies that are actually optional.

Jonathan



