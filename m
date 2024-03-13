Return-Path: <linux-kernel+bounces-102451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAED87B24E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971B5B24A70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BE64CB38;
	Wed, 13 Mar 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/JwIhze"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F384AEC7;
	Wed, 13 Mar 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359477; cv=none; b=ZvBAJ2zHR1fdphstxaLUlyxzQokPnYiAQRjP3g7sO2qEGeiTDEE2N/w15MjZW4BYerz+AG20EdQtCR4qL8WTvil4f24O5LfGyKjFR3WlaF39YIl3P1tTE/KzHei1TYPJnLnU05NKaipewSowk1MzJV7O6GVL08OMNEFW9Sq6AVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359477; c=relaxed/simple;
	bh=Xnwo+DzSvFOSfVaLDCLc86ChPoxbfxtMcxSbaI6/hD0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNgMX2dPOEwv8xQQ26D2NY7REYA/39fG/ZbwYflpr7zUPbUiTBBCyy57A1wuPSc2h7ro4dSAveIIcNF4qpa6ObJKh1jk9QU1OBkNHL10C6RPcz/diXk8bgufuRvs7DzMdGrb+H3wPN8VYrmW4yYewNrDOhQjiik9UxSlPJfiDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/JwIhze; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46623ed901so29759566b.0;
        Wed, 13 Mar 2024 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710359474; x=1710964274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auh595R//W28Gpao1Uu3VvAA76w9MD+VidzjUQx78lA=;
        b=l/JwIhzehJWcq58UOI/35RaSUGf5//C1KzH52I/KRpcOoVpMx2W+4P1O0u4IumGSif
         X/oR8e8K88PK4S3AEK+eeL+fWFV0kAn3Vz2RivCCW4CbcNNv33AqCTj3ChLBZZqpXK3Q
         wzleZY3MP5GRZmaW/VWLi1C5zuLWF7gYlu1fqxF2u8hOQO6ijjVyE65dTp+MQzYKIBkq
         Ph5a91ugWJoiCoDC6cWlWAKMGmfpCYoRiJWd4UBbZ5EdlCCQw04jDUIGYaCShIQrD/rz
         O456rPVNDr5onXneqSweH1DOt6oyhwBkjZItA+QRnNYZgHq6dt0gZ7VcR8LGLPGAEoAB
         66Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359474; x=1710964274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auh595R//W28Gpao1Uu3VvAA76w9MD+VidzjUQx78lA=;
        b=wNW9E83GENi2uT+zRQsiFHMGxg9Xez3EUX9/7kKvK5yGFnnTIo1UIOReDoVaaXIFQX
         Vvg2zlay0uy9YmPSbWMF+pyle3CX1rlo9AYKl9n8sR+iziNrWdOLmJ7vTVB+O+KUk1QI
         5oVD+aszukOQK21Nv4vFpBsz5cvpn1vP7feRWzd6DovixoXVCKmYj40WL8Lb0jL7thOB
         zopKVVI2Dhv3V9UVrJkAXtlnOnSkPQgVycXo+Z669PwPMebVpV9tBeMsdzM0xvgpX7qz
         v90wvMk6QuQtYOuLLPqkVY6li1BehqZT82o+Lag7MVd+sYRpwbUsxLPe54pHPrQQA3df
         xM/A==
X-Forwarded-Encrypted: i=1; AJvYcCW9lR618RRXehRRRJCEpJ9kxzfWaqd5PpyfJF9uvPP1UkczVpOwFRBnZbz3kdAJdhM7PMCkCVvcU5MXZ9JnAYyKPjD2gxYKJDLey+ZBg58RKyWtmSzH7Zluh3v1BYJG4lMFFYklD6Nb
X-Gm-Message-State: AOJu0YxSdEsgj1LUK0a1YGOSy9ZgmFBtnHwaVdOBREcgWeVLFdnM/9kX
	UjSneBr3NTuD7IHHjP3IWTKN14IAZr0BaBG9Ua9njlO3lhsSo/YK
X-Google-Smtp-Source: AGHT+IHcxiPHPG+zx/cQSJztq+yvNF5MHiJattFwFU7RA3w5EaVD5xECZ/O7EJRTvhqzrD8NUrttvA==
X-Received: by 2002:a17:906:6a22:b0:a46:2a79:6425 with SMTP id qw34-20020a1709066a2200b00a462a796425mr8048538ejc.22.1710359474025;
        Wed, 13 Mar 2024 12:51:14 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b00a44ef54b6b6sm5091061ejb.58.2024.03.13.12.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:51:13 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 13 Mar 2024 20:51:10 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <20240313195110.GB1938985@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-4-vassilisamir@gmail.com>
 <ZfH4bET-HX0e3PO_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfH4bET-HX0e3PO_@smile.fi.intel.com>

On Wed, Mar 13, 2024 at 09:03:08PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:
> > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> > able to calculate the processed value with standard userspace IIO
> > tools. Can be used for triggered buffers as well.
> 
> ...
> 
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_HUMIDITYRELATIVE:
> > +			*val = data->chip_info->read_humid(data);
> > +			ret = IIO_VAL_INT;
> > +			break;
> > +		case IIO_PRESSURE:
> > +			*val = data->chip_info->read_press(data);
> > +			ret = IIO_VAL_INT;
> > +			break;
> > +		case IIO_TEMP:
> > +			*val = data->chip_info->read_temp(data);
> > +			ret = IIO_VAL_INT;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> 
> Is it mutex that prevents us from returning here?
> If so, perhaps switching to use cleanup.h first?
> 

I haven't seen cleanup.h used in any file and now that I searched,
only 5-6 are including it. I am currently thinking if the mutex
that already exists is really needed since most of the drivers
don't have it + I feel like this is something that should be done
by IIO, thus maybe it's not even needed here.

> > +		}
> > +		break;
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Vasileios Amoiridis

