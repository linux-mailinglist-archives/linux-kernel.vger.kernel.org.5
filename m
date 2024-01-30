Return-Path: <linux-kernel+bounces-44909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C28428F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5606A1F2746F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0D86AFD;
	Tue, 30 Jan 2024 16:16:48 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA186AD7;
	Tue, 30 Jan 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631408; cv=none; b=pQq+JPIexf6LWNvG2DLiJEO8e3aXPs/L2N+d2rF2nJKUiNCEP+8BHHExhGrT6D+QXYJYHMbr0JfNAHkjWdWzf6DWmCfzffMCDcfoGHsIYoD83cgayDFWoxV17INtTk7TZySfm95Cv6w3Y/zuYF7noTQokiwyyfPQ0ZkFfkMkJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631408; c=relaxed/simple;
	bh=wzWjLx78n+gNpGvxKMNzh4geP7TmALFgETAt/zZgYXg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueDzwRXsgEhAzZMkl/rl2a6UyzLZ6qpiROjQnMmhWL23Uwgcs/1sVfR4P7QrmAHLCcfRZ3pXOim1rmffh2nhOBpjJsXWBUZBCsEHSAcYEnC5gNfFNWUV/XRslMw1yej3YcNtFye/hWCbJCEJPjSxfl3fpKVijmE38X/Ob63YVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TPVb26kBjz6K99D;
	Wed, 31 Jan 2024 00:13:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 53ADF140C72;
	Wed, 31 Jan 2024 00:16:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Jan
 2024 16:16:39 +0000
Date: Tue, 30 Jan 2024 16:16:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Naresh Solanki <naresh.solanki@9elements.com>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, <mazziesaccount@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240130161638.00004cf6@Huawei.com>
In-Reply-To: <CABqG17g70GDU3_DbJbEnu4-9a3aJBSFFXuYKBEG8MJpVfOjMGg@mail.gmail.com>
References: <20240130111830.4016002-1-naresh.solanki@9elements.com>
	<49bb7b5b-4186-83cc-7e1e-4892c7e8b6ef@axentia.se>
	<CABqG17g70GDU3_DbJbEnu4-9a3aJBSFFXuYKBEG8MJpVfOjMGg@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Jan 2024 17:18:53 +0530
Naresh Solanki <naresh.solanki@9elements.com> wrote:

> Hi Peter,
> 
> 
> On Tue, 30 Jan 2024 at 17:12, Peter Rosin <peda@axentia.se> wrote:
> >
> > Hi!
> >
> > 2024-01-30 at 12:18, Naresh Solanki wrote:  
> > > voltage-divider is always an iio consumer at the same time it is
> > > optionally an iio provider.
> > > Hence add #io-channel-cells
> > > Also update example.
> > >
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > ---
> > >  .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > index dddf97b50549..09f10d7c4e02 100644
> > > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > @@ -39,6 +39,13 @@ properties:
> > >      description: |
> > >        Channel node of a voltage io-channel.
> > >
> > > +  '#io-channel-cells':
> > > +    description:
> > > +      In addition to consuming the measurement services of an ADC,  
> >
> > It doesn't really need to be an ADC. Anything with a voltage output
> > channel works (in theory). But sure, normally it would be an ADC...  
> Ack
> >  
> > > +      the voltage divider can act as an provider of measurement  
> >
> > a provider  
> Ack
> 
> Will update as:
>   '#io-channel-cells':
>     description:
>       In addition to consuming the measurement services of an a voltage output

That sounds like a DAC.  It's an input voltage to that device.
Just go with voltage channel and rely on measurement services to make it clear what
it is.

>       channel the voltage divider can act as a provider of measurement
>       services to other devices.
>     const: 1
> 
> Regards,
> Naresh
> >
> > Cheers,
> > Peter
> >  
> > > +      services to other devices.
> > > +    const: 1
> > > +
> > >    output-ohms:  
> > ...  
> 


