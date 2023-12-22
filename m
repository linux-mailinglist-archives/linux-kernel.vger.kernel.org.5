Return-Path: <linux-kernel+bounces-9727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A96781CA46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE501C21289
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9CC199A1;
	Fri, 22 Dec 2023 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ+z9xnr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644818624;
	Fri, 22 Dec 2023 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d4006b251aso15984595ad.0;
        Fri, 22 Dec 2023 04:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703249353; x=1703854153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8zZt4WN4jUldW1IhbtAqlFHddSRBTBboS3+40U4jk4=;
        b=LZ+z9xnrqytr7i8Kby9aZm5nCNIcwl4BeNGuguIfACiug5HdMXOcWqBaoPfE7JkHBj
         34MAa/8CH0Qj8uf0r/R0/zsZ/AarToVJyG3n/o2PqVv/ShGMZWhCo9W2b7Rd7VG0GEbi
         TUBD0P5kERqWn3R+rPVAtlI0FWnPb6uEnUQwYc2GlqP/Pe80wp81jK+jRgXBU1dOCFFg
         FmAx1aFYCrYkB+k0zFdpZymRCcYBcuesNIGs9PbTiNw4ST4/4nCqsaRDmhNJCA/2gSJH
         srfyjXmtCrgGA/RIYDaMub3lPAxu7TMK6U6LPnqcWqvcKV8IUr20FhQxW7uok3kILjLl
         1Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703249353; x=1703854153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8zZt4WN4jUldW1IhbtAqlFHddSRBTBboS3+40U4jk4=;
        b=kt+d4y3fjQOzwi5SxpX786DBb1D48/E0yOlTgDsr90c3O7uvzHwB9HyBEjrP/ia0XM
         3hbkZMgLTV1Xr47daP11rH16x1ebUpAw5VJLbRVPsP0GStaePyczEPvliVK00FAbAdfI
         hxsE13vUv/g82zZx/RRR0/4mnxD4PUlgar2LOUwWXLAWFC2hdonCJGDMxqFYCiEqLViq
         cf9Wk5jjfTpZ6TUEANBbko7wfedxnAsw26NXLcmCX5upti26fIGXaofhv2IqNanehpUz
         pcarNAR+pc8vzZ+x7KdS28fV8Xi7fiUMMqG8aMIGQVbFY7MMaN0Mk7Em6DHq4RWQ73FK
         PkWA==
X-Gm-Message-State: AOJu0YwlB+uOc2dm7Nm7RcU+L51SjMVvybddW0X53CUfpI0rHuWcbgXl
	4+DHOqIfJHsUkPTLun2cKok=
X-Google-Smtp-Source: AGHT+IFShtK0BHRAkNgoyW6+jDiOQcTsJ4kBSQ80gkb0zqFcsvjyhatz11/c7kJJsY3p9mi5iVZrAw==
X-Received: by 2002:a17:902:784c:b0:1d0:69dc:954e with SMTP id e12-20020a170902784c00b001d069dc954emr1122024pln.24.1703249353031;
        Fri, 22 Dec 2023 04:49:13 -0800 (PST)
Received: from localhost ([2804:30c:160d:b800:be05:2c5b:24c0:12aa])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001d1c96a0c63sm3388448plb.274.2023.12.22.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 04:49:12 -0800 (PST)
Date: Fri, 22 Dec 2023 09:49:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/11] MAINTAINERS: Add MAINTAINERS entry for AD7091R
Message-ID: <ZYWFwVzQN4vU7FdG@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
 <4247e653354f8eb362264189db24c612d5e4e131.1703013352.git.marcelo.schmitt1@gmail.com>
 <20231221165947.6c64b2c5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221165947.6c64b2c5@jic23-huawei>

On 12/21, Jonathan Cameron wrote:
> On Tue, 19 Dec 2023 17:32:59 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > The driver for AD7091R was added in
> > ca693001: iio: adc: Add support for AD7091R5 ADC
> > but no MAINTAINERS file entry was added for it since then.
> > Add a proper MAINTAINERS file entry for the AD7091R driver.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Hi Marcelo
> 
> The series looks good to me now. However timing is a bit against
> us because I won't squeeze in another pull request (unless the
> kernel release is delayed for some and Linus strong hints at that
> this weekend).
> 
> What I'll probably do with this series is pull out the first 2 patches
> as fixes to go in either at the back end of the merge window or just
> after, then pick the rest of the patches up for 6.9.
> 
> If I seem to have lost track of them in about the 2nd week of January,
> feel free to poke me. 
> 
okay, sounds good.
Also, will do the change to ABI doc in a separate patch so this set doesn't get
blocked by the mistakes I will make on the ABI patch. :)

Thanks,
Marcelo

> Jonathan
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4eddc4212f2b..3473cfbac826 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1126,6 +1126,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> >  F:	drivers/iio/adc/ad4130.c
> >  
> > +ANALOG DEVICES INC AD7091R DRIVER
> > +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	http://ez.analog.com/community/linux-device-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
> > +F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
> > +
> >  ANALOG DEVICES INC AD7192 DRIVER
> >  M:	Alexandru Tachici <alexandru.tachici@analog.com>
> >  L:	linux-iio@vger.kernel.org
> 

