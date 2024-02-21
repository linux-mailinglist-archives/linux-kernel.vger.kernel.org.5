Return-Path: <linux-kernel+bounces-74594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181A185D685
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4851C22A92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B033F8D1;
	Wed, 21 Feb 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+2fWVu+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F13EA87
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513835; cv=none; b=um7gVnDpv4Ms9Nj8Vb7LBZoei6l2TIuJu7eGueyB9sfNB8wY78dT2YscXlFphOh+u++cLg2+Sb3JWmBPl9iq6e/8q4/WspbaPbu/NKARQeZvzRMPVdJ0LrvvXdM277ydaLhxf2B3FVbZv+kYDu7e9Z+tn33TyiKtyCSbVSWidzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513835; c=relaxed/simple;
	bh=yYwOfjmiT5pxQ2sOc334eJUjQ4d60tVUqL5jOyR3Ajk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODKZQTV68eYND3Uz68s0kBnlLfog8zqOhUytL+jeB64znSV+WBLQMZA3wKd9o4NUZxs/UPjJajKH2v213/NT85ErcGis8ICTEA7vSZqrJzXE48n6rkUFPxpM4XE+iIhAiEr48E3S2iexSur5GumSTAWX/pv477ZZg+vSqyghqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+2fWVu+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so888294266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708513832; x=1709118632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5L9NoyuwvA4Gf7LYh90rqEBr7lWC8KBnH4p5IN+MFQ=;
        b=D+2fWVu+7PjUx59LJn4ht5s+r3cnBMz3esyFQVkAP5nx5nphKUWZb3qglKZtMobDrS
         HbUGPaV+MAcjXPPCN05K+uqpy0kuZylOVA/Smtz3zE1uvm+uZSN6kiJnNUi/ul7IEa1I
         a6ndT+UJYSCsEiOseOIx5NQNqyn0yrLqp8QOqe2mGY0s69k0C8EpZBTHBNpLctR5IxLt
         pbjP2ZaIEEW3KTkCS0JR98Z5injR772i8O7I295k+U4A1XTZxVweCMtN3Y1vPJIqbiwA
         RG3WC3ODR0Y8/GxCaYMO3QX3OZzpARoy2VfBnPcXnKRSFBFGfoh7y0KN2WY1t8pgxUYu
         En8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513832; x=1709118632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5L9NoyuwvA4Gf7LYh90rqEBr7lWC8KBnH4p5IN+MFQ=;
        b=RtRXmhWNW2AV3DloFw6bvS6EHnRWdwpAAzrVKd/a1mK9phQYEAqX1/Fb9sBAHE/swP
         hah933uYZDk6Hdo7RVgOmlc8iJhUv+8HSAX0lIGzE8qWFi11Mf891/c9HhG+BBojHAij
         0EV1JKmhMtX4RIpJOmOmx9OqkKcsA9u6xnKDcT1qFCi0PgWCDuBkSpI0jRTYrLEkixly
         A4QGyyUhhvlTHUCDLCwV+zeHEfnipPGgXevmscRNJgcIe+HfdasF02wTAQRWxBB71MBp
         pGlcc/RWCIRfAKjHfIGWb4zvW35Yivr4XBx0Hb/Bq0JDOiUiV9qIDaWE973m1vd1ya/y
         Zj/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbed4S9/0BETNzwnvkSPGRUCsSGAuVMqcJBT6+GVGW+kwyjo2cUpAKXx3e7REd9a3VdVPQzozs7cbQBCPV41F15Xdg8Q3hyjKn4o8V
X-Gm-Message-State: AOJu0YwuWQ5y0bTf6tQhvlqa9l2gCaJWK4ntv4o0K4+WKKfsBNgTdd5/
	tE33ol5gKa6LLvQwVIll5ZtWdeaPAGdSzP8x9f3gYDKCMNyEYWGuXNUjH6CtPgk=
X-Google-Smtp-Source: AGHT+IEHmqJXiGEszWIcBJwOe1/dTMQWWMygFC3Y1juPap31hfiRJ/+P0zYCmXOXO8UIXslmCNRgjw==
X-Received: by 2002:a17:906:3bd0:b0:a3f:45b7:3af0 with SMTP id v16-20020a1709063bd000b00a3f45b73af0mr605988ejf.71.1708513831729;
        Wed, 21 Feb 2024 03:10:31 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a3e0119b4a3sm4958240ejc.140.2024.02.21.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:10:31 -0800 (PST)
Date: Wed, 21 Feb 2024 13:10:29 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add X1E80100 MDSS compatible
Message-ID: <ZdXaJQ5AfOiki1l5@linaro.org>
References: <20240131-x1e80100-iommu-arm-smmu-qcom-v1-1-c1240419c718@linaro.org>
 <20240213131952.GB28926@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213131952.GB28926@willie-the-truck>

On 24-02-13 13:19:52, Will Deacon wrote:
> On Wed, Jan 31, 2024 at 02:35:16PM +0200, Abel Vesa wrote:
> > Add the X1E80100 MDSS compatible to clients compatible list, as it also
> > needs the workarounds.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index 8b04ece00420..5c7cfc51b57c 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -260,6 +260,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >  	{ .compatible = "qcom,sm6375-mdss" },
> >  	{ .compatible = "qcom,sm8150-mdss" },
> >  	{ .compatible = "qcom,sm8250-mdss" },
> > +	{ .compatible = "qcom,x1e80100-mdss" },
> 
> I think this needs adding to the bindings Documentation first.

It is documented here (once it gets merged):
https://lore.kernel.org/all/20240220-x1e80100-display-v4-2-971afd9de861@linaro.org/

> 
> Will

