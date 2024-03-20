Return-Path: <linux-kernel+bounces-109436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18588191F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E8F286A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06AC8595F;
	Wed, 20 Mar 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHDL3pog"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356B1DFC6;
	Wed, 20 Mar 2024 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970305; cv=none; b=ED0F3SkjTX+0RBrsdVm3ZAHqX6muZSRDkztIJSBpayMblsEdCtsAI9HkHyd63g495DgNFDqxYUt80LvhWuQfI7WQALCEmfV0W6EZNAwRcb9ZteHdhqWiO8oa8tX/4W+wp7MfCNAWzj/lLJmu5VN+DkVwd58JjA42RmxrFOxj1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970305; c=relaxed/simple;
	bh=zZkPNzov1U+2g3d3e8PS0S63IwHAgOpyM3LsJwAUW4M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+AkXQK/f0PFOSQDuH31sNn9szpIaQNGCtLEoA2qj5or5bwe/zqtKSCoJ0QHqAMPofL718CnLvHNjXzn+IiyR+372SncaHBbkAKj9YGnVyFfdhJWn3X4ApiCthLk4ZVJgDWgICRa95qegvSudqsLZFuxh3uR41U9dOGYcblDYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHDL3pog; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56b85146589so620043a12.0;
        Wed, 20 Mar 2024 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710970301; x=1711575101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YkXNsWFyS9IroqdDegvv78No9qBhWM69YWkvvWKZWwc=;
        b=aHDL3pogjfF7PHFtc/yEuyJKnhugPFOSWNXh3099/AVbrfoBX8QV0/UMdwjxaDqU+9
         mX9MStVHal+HXK6pX2uUwdo/knwAdKC1EB9qs0Xnx4VT0MrHeourB3Tg28rxOaLI/6yB
         1GqFBP6Fzb6TTCLbm9uPpuETkES6gXpHuRkaPvVTxGQF6liC/c7Ogix4QkvgIEhVp3xx
         7+wpEEsxa3Qegc8RgW5xzuUa5zbLEy7ZDNYDa2DYSGusvTGYUgH8XSfoShi4QQSPKDMX
         2rfbmM7kv3nHfpwk4Di9YSQGp6UfDvXuchlYL0vTk0lLxB6OPSDy9xOA9x2QT7eLLg1h
         LPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970301; x=1711575101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkXNsWFyS9IroqdDegvv78No9qBhWM69YWkvvWKZWwc=;
        b=UoH000rFJuGcoDWDv+muQahJZL64odn9C1uEeq/pDEsqydVNeMQe9suWn5XdanvNQV
         1IQDVPZddGXDLie0vmABvrn2EhKxaV+iOP4wL6pI9P5rcK8U/4hmP8uUm8dbTSBlyGXk
         anReYzPNdSfXOWTvftNE5ROMwjCuAiRA48AzYH89lRKz6bYWtM7KVwlGHu01TbYaX0Pq
         M/VhJtJOaOVS2kX3zPydlkKBwJJbd2AV/XoMh/vimIiMzR/Xy/qg1Ez+S1PVd95O5sWY
         FhB4IUY4UePkjrhYQoOc/U862lUljN928/PwwxgMXv1k7uT6sTFwqzN8+k9uBPlXjEVf
         v20w==
X-Forwarded-Encrypted: i=1; AJvYcCUKXkqJ+bRXxj+SlrV+NTkhSk11XhdRi2hbq2fUj03lcp2h9jUsUCv1ju23LCwVF8msT6LnamCybsAazVNeZCG/AzlAN37EA79/mMYqztVwvN8SFxxLPH1sdkMEnW8zFT7hvY1hjGK1
X-Gm-Message-State: AOJu0Yyj9CqVKjpLhuz4aJ/XRPmQ9t38hKVEgyAebByaGDHZcx3Dg4sK
	DxTwgWNeZGD9K7PFYaf0V1KNTn6pczD1+cNgrzvOBCMOpv7rzMl+
X-Google-Smtp-Source: AGHT+IGJARAIaj/QFlDOhPInMMiZr7TxIYCf173dV4SXkMAh9bXCeF5fke/WV0h4Cqs55mY9jawm0w==
X-Received: by 2002:a50:d5d3:0:b0:568:d6a2:716 with SMTP id g19-20020a50d5d3000000b00568d6a20716mr772925edj.7.1710970301353;
        Wed, 20 Mar 2024 14:31:41 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9be1:7bef:ff5c:57fc])
        by smtp.gmail.com with ESMTPSA id l8-20020aa7c308000000b0056b7ed75a46sm3263658edq.27.2024.03.20.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:31:40 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 20 Mar 2024 22:31:39 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro, phil@raspberrypi.com,
	579lpy@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <20240320213139.GA52721@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-6-vassilisamir@gmail.com>
 <ZfrDW1ESxnFg__od@smile.fi.intel.com>
 <20240320184516.GB36450@vamoiridPC>
 <ZftJK3cqFNU9-dCG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZftJK3cqFNU9-dCG@smile.fi.intel.com>

On Wed, Mar 20, 2024 at 10:38:03PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 20, 2024 at 07:45:16PM +0100, Vasileios Amoiridis wrote:
> > On Wed, Mar 20, 2024 at 01:07:07PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 19, 2024 at 01:29:24AM +0100, Vasileios Amoiridis wrote:
> 
> ...
> 
> > > > +enum bmp280_scan {
> > > > +	BMP280_TEMP,
> > > > +	BMP280_PRESS,
> > > > +	BME280_HUMID
> > > 
> > > The last is not a terminator, please leave trailing comma.
> > > 
> > > > +};
> > 
> > What do you mean it is not a terminator? In general with the enum
> > variables I would write:
> > 
> > 	enum var { a, b, c };
> 
> This example is different to what you used. I.o.w. _this_ example is okay.
> 
> > Why in this case there is a comma needed after the BME280_HUMID element?
> 
> It's pure style issue that helps to avoid the unneeded churn in the future in
> case the list is getting expanded. You can easily imagine what I mean.
> 

Ok, that definitely makes sense, thank you! In general, should this be applied
to structs as well?

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

