Return-Path: <linux-kernel+bounces-133861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FBC89A9D2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B6B1F21C8F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077DA22F0F;
	Sat,  6 Apr 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cp+0drnx"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D01EB3F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712394554; cv=none; b=uzEXKMa363huDMvzqY4Fu+DUeoNOHgQrlqdGvxOQ5+fJR72ExdhyxVdLpa41tP67tiY51FQgHr8Ps3MS+PexMZNEm4eC7goQjybhOuySPZdpQmXvqlhjtM04crtU2QmHiqLE/Hz2axhk/PZ/kgd3mDvHf5WujZyqJvcN1X8RWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712394554; c=relaxed/simple;
	bh=MGHIGmfwFNSNcn0c/t4VWCQduJ8fZ/WlM/mf+rzhQII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShzEKCrX4dWAn4OqzxYKsLBaWYocvj1OFldSVHayc8ucbUOTJmVOe9mwQkpnrFh5TF73f/yURGXeyr1fbCtrmHEA348sl5I5b8IhUA1vrauf2R1vJIRG6TGhAEmnHIM25ZSMK4vRTidXC4WrGLGCXJQtlNv4XlZbu7E2MXOq7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cp+0drnx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a468226e135so405879066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712394550; x=1712999350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jsux2xNdM5INUuabTGtcNgAbopGLxo1c/2XpNOGaEWM=;
        b=cp+0drnx6QYJJexf5+fc5r6RCcrMHdxx99hdBCY/ylBxc6+ctXJ0aVl1DGTqw5fv0q
         WKe++fjg2V+kBvb1Ac/3ZSu26CdjJ3NApvUH862RRNOqJNO3v8sPRA497xIQCtEUTiE1
         dTTRrw1u4FH8IADa3F2+HFB45riJ8zEU4e+WCCngoJX6gX0K4Fp3HF8MYcuk0G6lyA42
         3ggDW8etQPKDn+giWQ19r1oheCKu0RJIeMwPpoE4Yv5m5K2E9f37tWSSpQIi8HBRTyCO
         C1hAhzjKRrWZlTQgyD/enyrCT19Js7RRJsPlKs+0c/FB+bdqIGm6XmvN4zqH6MFAOHkB
         qsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712394550; x=1712999350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jsux2xNdM5INUuabTGtcNgAbopGLxo1c/2XpNOGaEWM=;
        b=n2mhZ6POnt60FMdtYBOvktnGs48CHJ81KygF7rb2lAfeB+AAvTeAvb3QNnmtx0tvSu
         d4voYkVeDE6inKVo5yQUIdFnGb6eZfyC59h4O9c5T6rjlAGHLVfKM6C25J8qANc7DkiU
         SOa+qbNpnblfFixm7J3OfDjC33tclChaqDvzZakHGKY/qSgdjuoiL5uy9+Rm8eI6uJnM
         d6Kcwpx3ajF2TzbZInvqOZzBVa5b3fLnG3gWJnb0TC0Zv7aKML/eiid1McUIzfFk1Hj7
         de30zuBLsP8dgjVGoiZjjNvhKTlNtBNEZc9UjsiJKnWL8F3M3AOV68W4gibGHHc8HA45
         46qg==
X-Forwarded-Encrypted: i=1; AJvYcCXlqEhlBxxtSyYD3LK4rbkbRD4zt3cI8T7Ht01dS5uamsdEsogDLpTnuN8Z3OXICEGb/Xab+YZ3w9GL9C4VKQAlHJ0iITKLXvPALQQx
X-Gm-Message-State: AOJu0YwDwlwT1NAT74qjZ7MBcCvjoMjdMnMCCsuzgjboQh0AyyEdjqeQ
	MohsOYME8BCFUAQKeO6HqjknAWb1ybe2AjB4v0DLenFx5JpmKjnbdeoXO3/Suho=
X-Google-Smtp-Source: AGHT+IEePUKy6Exi4dt9+UbvFkTbfuWJlF40HE36cWG7zX6sCHC690fGxSptBYpyD+e0u3AVoM6UgA==
X-Received: by 2002:a17:906:2e98:b0:a4e:390f:c6ce with SMTP id o24-20020a1709062e9800b00a4e390fc6cemr2533620eji.65.1712394549323;
        Sat, 06 Apr 2024 02:09:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id he8-20020a1709073d8800b00a4e57805d79sm1785409ejc.181.2024.04.06.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:09:08 -0700 (PDT)
Date: Sat, 6 Apr 2024 12:09:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jackson Chui <jacksonchui.qwerty@gmail.com>
Cc: Alex Elder <elder@ieee.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Clear up precedence for gcam logging
 macros
Message-ID: <5eb3afe2-da7b-4f98-aac2-bff529a02cea@moroto.mountain>
References: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
 <658e1f40-d1eb-4ba7-9ba3-0aa05a1ed06e@ieee.org>
 <ZhBrff8qkkmum4wc@jc-ubuntu-dev-korn-1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhBrff8qkkmum4wc@jc-ubuntu-dev-korn-1>

On Fri, Apr 05, 2024 at 02:22:05PM -0700, Jackson Chui wrote:
> On Thu, Apr 04, 2024 at 05:05:09PM -0500, Alex Elder wrote:
> > On 4/3/24 7:16 PM, Jackson Chui wrote:
> > > Reported by checkpatch:
> > > 
> > > CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
> > > precedence issues
> > 
> > I agree with your argument about the way the macro should be
> > defined.  But perhaps these gcam_*() functions could just
> > be eliminated?
> > 
> > I see 15 calls to gcam_err(), 1 call to gcam_dbg(), and none
> > to gcam_info().  It would be a different patch, but maybe
> > you could do that instead?
> > 
> > 					-Alex
> > 
> > 
> > > 
> > > Disambiguates '&' (address-of) operator and '->' operator precedence,
> > > accounting for how '(gcam)->bundle->dev' is a 'struct device' and not a
> > > 'struct device*', which is required by the dev_{dbg,info,err} driver
> > > model diagnostic macros. Issue found by checkpatch.
> > > 
> > > Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>
> > > ---
> > >   drivers/staging/greybus/camera.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > > index a8173aa3a995..d82a2d2abdca 100644
> > > --- a/drivers/staging/greybus/camera.c
> > > +++ b/drivers/staging/greybus/camera.c
> > > @@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
> > >   #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
> > > -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
> > > -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
> > > -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
> > > +#define gcam_dbg(gcam, format...)	dev_dbg(&((gcam)->bundle->dev), format)
> > > +#define gcam_info(gcam, format...)	dev_info(&((gcam)->bundle->dev), format)
> > > +#define gcam_err(gcam, format...)	dev_err(&((gcam)->bundle->dev), format)
> > >   static int gb_camera_operation_sync_flags(struct gb_connection *connection,
> > >   					  int type, unsigned int flags,
> >
> 
> Thanks for the feedback, Alex!
> 
> I thought about refactoring it, but I feel it is worth keeping
> the macro around. It acts as an apdater between callers, who 
> have 'gcam' and want to log and what the dynamic debug macros 
> expect. Without it, the code gets pretty ugly.

Another idea would be to create a function:

struct device *gcam_dev(struct gb_camera *gcam)
{
	return &gcam->bundle->dev;
}

	dev_dbg(gcam_dev(gcam), "received metadata ...

(I don't know how to actually compile this code so I haven't tried it).

regards,
dan carpenter

