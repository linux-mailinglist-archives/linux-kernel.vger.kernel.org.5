Return-Path: <linux-kernel+bounces-74587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F25485D66E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35C01C226CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35053F8CC;
	Wed, 21 Feb 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="smYDr6/n"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB99523D;
	Wed, 21 Feb 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513450; cv=pass; b=g2xGib6FMuGzoOUtbtEhMx2a3TeDLDLub/sJUDt7oW1hXlNEn1iwnqHObVsMrAy2bFctEFGGmtKh8Lub4En17YDp/wb5ECqNJ3PLBKndXAW7uAwYs6KQnmgAmPJRyNNpVyp0m1x5Xs29kUUGXq2eNzXYaNYchWbc+306wNdVGQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513450; c=relaxed/simple;
	bh=rtlDGn0L2qfmAFjQSQW5Jgc5ZYLnl1rCo0+bj014TNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP+x0N/lvc9meZuStKWqBqJygwoGKPBVIUhOcW86tCZzY4azHaTxi4xnfAFB0F/Ej7wAicL29QUoCPqolByZpSKSwmRXnu0FLU37VGOumDu2w4Fsd/umNK1kLXf5Y9SMpuDjgJ9TJDHa834WqgrpL/QyKQhrYDrV7wh+7ppGdzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=smYDr6/n; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Tftgn688wzyVn;
	Wed, 21 Feb 2024 13:04:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708513445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EG2HxwcbqWIH33ppNrbAfpfTSGk1WUofkhCL91CbaS8=;
	b=smYDr6/nQt09D2u1w0hMnKiYe8qcML8iJE08YhvRWFiI/U242roEkMx+GL6ZZUXy4bhRyY
	r5DUgD2+AHQusPC42qn2vOS94+4wa89wU0u32rPOjNxHKGNOVfF0Hhyk47SxVTs2qYyQVb
	fYN81Ncry4xC8R5B0qGPtvG1P137dyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708513445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EG2HxwcbqWIH33ppNrbAfpfTSGk1WUofkhCL91CbaS8=;
	b=LSNtxpQErUjwKnPOJOg621QXNvlvKZbCEcq5FsqzwSXfzPyOiEdEZ35VqmBreF8tkhMJfZ
	YXLvqjwFezyg946tfsvWGKEw5PGBfep0HhoZoj3EYEaDoaUdLogxklpP0TQD3Bw7sD1Bth
	FbbVeR8OChkbYAcFBk9fzmSoSMniARw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708513445; a=rsa-sha256; cv=none;
	b=SaOCbokch7GfO1SCxcRag7ngGcpjtNJGy+FfIYSgcWg3nqukrtbgnXYiM79u71gXV2QNEg
	IfJIbtTpdu5Ml6fehc+XSIxweqG32HSaFNyMUIe7t4JGRd84CSw3hHl1NpfNc1K8CmkRQZ
	l8tu4+g8uTP8rGRlcTFABo/TXez7QJo=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 504DE634C93;
	Wed, 21 Feb 2024 13:04:05 +0200 (EET)
Date: Wed, 21 Feb 2024 11:04:05 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 3/4] media: i2c: add MAX96717 driver
Message-ID: <ZdXYpc2csVnhtZH9@valkosipuli.retiisi.eu>
References: <20240111130349.2776699-1-julien.massot@collabora.com>
 <20240111130349.2776699-4-julien.massot@collabora.com>
 <ZcZEQyCb2FBsmbsK@valkosipuli.retiisi.eu>
 <e09ea4d3-361a-4892-a098-98de8da80e65@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09ea4d3-361a-4892-a098-98de8da80e65@collabora.com>

Hi Julien,

On Wed, Feb 21, 2024 at 11:34:38AM +0100, Julien Massot wrote:
> Hi Sakari,
> 
> On 2/9/24 16:26, Sakari Ailus wrote:
> > Hi Julien,
> > 
> > On Thu, Jan 11, 2024 at 02:03:48PM +0100, Julien Massot wrote:
> > > This driver handle the MAX96717 serializer in tunnel mode.
> > > All incoming CSI traffic will be tunneled through the GMSL2
> > > link.
> > > 
> > > Signed-off-by: Julien Massot <julien.massot@collabora.com>
> > > ---
> > > Change since v2:
> > >   - Use CCI helpers instead of recoding register access
> > >   - add missing bitfield header
> > > ---
> > >   MAINTAINERS                  |   7 +
> > >   drivers/media/i2c/Kconfig    |  13 +
> > >   drivers/media/i2c/Makefile   |   1 +
> > >   drivers/media/i2c/max96717.c | 956 +++++++++++++++++++++++++++++++++++
> > >   4 files changed, 977 insertions(+)
> > >   create mode 100644 drivers/media/i2c/max96717.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 675e5d63a25b..a64a7932fe76 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13039,6 +13039,13 @@ S:	Maintained
> > >   F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
> > >   F:	drivers/staging/media/max96712/max96712.c
> > > +MAX96717 GMSL2 SERIALIZER DRIVER
> > > +M:	Julien Massot <julien.massot@collabora.com>
> > > +L:	linux-media@vger.kernel.org
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
> > 
> > What's that "f" for? It's in bindings but not in the name of the driver.
> > Not a typo I suppose? :-)
> 
> Indeed that's not a typo, the Maxim's GMSL2 chips are available under
> multiple
> variants:
> - MAX96717 which supports GMSL link speed 6 and 3Gbps and CSI lanes up to
> 2.5Gbps
> - MAX96717K which supports GMSL link speed 6 and 3Gbps and CSI lanes up to
> 1.5Gbps
> - MAX96717F which only supports GMSL link speed 3Gbps and CSI lanes up to
> 2.5Gbps
> 
> They have the same register mapping, so we should be able to add support for
> the other variants in the future.

I think you should probably do this for the bindings, too. I'd thus drop
"f" from the file name.

-- 
Regards,

Sakari Ailus

