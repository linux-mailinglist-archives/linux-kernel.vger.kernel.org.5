Return-Path: <linux-kernel+bounces-133119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0E899F21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C834428181E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80016EBF1;
	Fri,  5 Apr 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvs6eKQi"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033016D9CB;
	Fri,  5 Apr 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326290; cv=none; b=aS41w3NOChJVNGWQ79PA/KRG+AliuhslCijSunnCGkNwxUZWXlhFgRXBAPtCGyPEV7tnZsnQ9t5dCWPqYLkjOkbWmQZlWWtYfD2cRY2r4wSvdrgbYa+DZYi9IAqZOKwFZ8q+wM0FqklwK5v1rr1JwJhNqoxX5rM4AbNgDopo+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326290; c=relaxed/simple;
	bh=5yZFTVxPj9WohAyyVh4FnZgcBEYU2viQYh+3SyX+0yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoPyLdIGv4sD8bfnPb95NATP24AqnRjWGvKoNJ9kgps+nl4TTb7Ex5QPyGHj16FQntjCxOlJBUi/niDYeJu2uVkYl2W51gOgdwybSrizS+pGIwHlFQMk602GcQrdR8sz0Ol5/5pKv3N8AIpBjZLsAoS+eJ0hchb6v2S6wrgFHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvs6eKQi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4162f7ea4d0so3856605e9.1;
        Fri, 05 Apr 2024 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712326287; x=1712931087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rX3Zd1uGycqxks8BkgoQUkcminCKAtXLjmui8Qs7dLA=;
        b=Hvs6eKQisRV18+55mfC0HXdsg33GAlAYbrxVNmmAVsNd6+U22csR3lxIQw2TirSevK
         9y9PkH/0W9kFndHWPvQp6t5LnhubqVxWWZx+iGubty45WuxvuGrWzwNb1eOXjZTQguHw
         vMHDAW7zPCvg86AgBB7JJTRpDRDLcp32OdUL59bnFFFroYAOn9i79TfI5e3dpzCUuHbO
         VjTQ+TwxlMR0waETOgjpzqmyWxYoDs4s01bLsubzXBv6FwkPh5/i8fX6kl/da/CBDziY
         NPRYBvgCV+UJMqgQrE8zR7w1HKkm/gUfitHqxZmWbII9QnN14uT/vMRop7I54OErjy44
         bIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326287; x=1712931087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX3Zd1uGycqxks8BkgoQUkcminCKAtXLjmui8Qs7dLA=;
        b=TlH2wWLmJHrZUg8k8Q4mN4YcYUempPygmCnTEkzogLS3f9hqDXkdd0OxB8j7RCMMn1
         PFMT2tznBg2FwrHJwuBJRQAqVXAayuLO3i5ih5nD9xCz0xfhBhvLvQlBMnnTDCrdRqWU
         aVG386FQIUXiw83+YtqrXK3nMS1TIR16Zv2Ps1C3oIbnT2oUqO97lH2kZY9v64M/DJfQ
         x04P14edKgkHhSTqz/mutQWHH8H/lcxwqdQdkzZKFZfUNCiGvzCsxd1c2KfYvaj7nPyi
         MtJKsltof88CK8ACFbdHksnbZaAyfPyWruh1HXjkkdhIyUreXIv2ut9gRi59tf4ZYsqU
         Wo7g==
X-Forwarded-Encrypted: i=1; AJvYcCUrFiLMdnozx8gmhgFHwVBMIohGhBz0580ck18i+PFRRiaPr2uSEiIpTe6FvgmRWBmUeUA2dOikokseNPf3K6aJOIleKuohFiy4/Iju1KAq7ZQPYOHJC5t1F8cjyeH+rBvJcCDuz8Sw1bBwDXuxqSTxvcz5/t4q+43ZBKKmH98tWYVeTc5F5iW8tci+auY9QL+BYBs+0wUIwZclI1CIhUOw2Gw=
X-Gm-Message-State: AOJu0YwrdK/XE5S1aHHmQprIdhJ8cNwxLjf7A/YXZ4O3p5V2IQxksKGn
	wSmMY0PGPRzUoU/xxUBegaWFAiUVVzh8EjbfJ/oAKCG8ny+GQY1M
X-Google-Smtp-Source: AGHT+IGnPvnCFSrfZEpp/kUMddY/dDiC+s4YJr+o/MdQnJv2c435miTzy//IJuhXXzmhUXIjj2lfow==
X-Received: by 2002:a05:600c:4448:b0:414:8ffb:a6bf with SMTP id v8-20020a05600c444800b004148ffba6bfmr2324189wmn.18.1712326286773;
        Fri, 05 Apr 2024 07:11:26 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id j11-20020adff54b000000b003433bf6651dsm1326285wrp.75.2024.04.05.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:11:26 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:11:23 +0200
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Luis Garcia <git@luigi311.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v3 21/25] drivers: media: i2c: imx258: Use macros
Message-ID: <ZhAGi0X2wVOdsrSe@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-22-git@luigi311.com>
 <Zg2CirmwL3JfjA8s@kekkonen.localdomain>
 <df8c245a-40e9-4bf5-b870-7efe321d820a@luigi311.com>
 <Zg5Mz0QSqNDXzY4o@kekkonen.localdomain>
 <082190a8-7ac5-4240-9a16-6b9168c67d57@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082190a8-7ac5-4240-9a16-6b9168c67d57@luigi311.com>

Hi Luis,

On Fri, Apr 05, 2024 at 04:33:38AM -0600, Luis Garcia wrote:
> On 4/4/24 00:46, Sakari Ailus wrote:
> > On Wed, Apr 03, 2024 at 01:17:26PM -0600, Luigi311 wrote:
> >> On 4/3/24 10:23, Sakari Ailus wrote:
> >>> Hi Luis,
> >>>
> >>> On Wed, Apr 03, 2024 at 09:03:50AM -0600, git@luigi311.com wrote:
> >>>> From: Luis Garcia <git@luigi311.com>
> >>>>
> >>>> Use understandable macros instead of raw values.
> >>>>
> >>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >>>> Signed-off-by: Luis Garcia <git@luigi311.com>
> >>>> ---
> >>>>  drivers/media/i2c/imx258.c | 434 ++++++++++++++++++-------------------
> >>>>  1 file changed, 207 insertions(+), 227 deletions(-)
> >>>>
> >>>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> >>>> index e2ecf6109516..30352c33f63c 100644
> >>>> --- a/drivers/media/i2c/imx258.c
> >>>> +++ b/drivers/media/i2c/imx258.c
> >>>> @@ -33,8 +33,6 @@
> >>>>  #define IMX258_VTS_30FPS_VGA		0x034c
> >>>>  #define IMX258_VTS_MAX			65525
> >>>>  
> >>>> -#define IMX258_REG_VTS			0x0340
> >>>> -
> >>>>  /* HBLANK control - read only */
> >>>>  #define IMX258_PPL_DEFAULT		5352
> >>>>  
> >>>> @@ -90,6 +88,53 @@
> >>>>  #define IMX258_PIXEL_ARRAY_WIDTH	4208U
> >>>>  #define IMX258_PIXEL_ARRAY_HEIGHT	3120U
> >>>>  
> >>>> +/* regs */
> >>>> +#define IMX258_REG_PLL_MULT_DRIV                  0x0310
> >>>> +#define IMX258_REG_IVTPXCK_DIV                    0x0301
> >>>> +#define IMX258_REG_IVTSYCK_DIV                    0x0303
> >>>> +#define IMX258_REG_PREPLLCK_VT_DIV                0x0305
> >>>> +#define IMX258_REG_IOPPXCK_DIV                    0x0309
> >>>> +#define IMX258_REG_IOPSYCK_DIV                    0x030b
> >>>> +#define IMX258_REG_PREPLLCK_OP_DIV                0x030d
> >>>> +#define IMX258_REG_PHASE_PIX_OUTEN                0x3030
> >>>> +#define IMX258_REG_PDPIX_DATA_RATE                0x3032
> >>>> +#define IMX258_REG_SCALE_MODE                     0x0401
> >>>> +#define IMX258_REG_SCALE_MODE_EXT                 0x3038
> >>>> +#define IMX258_REG_AF_WINDOW_MODE                 0x7bcd
> >>>> +#define IMX258_REG_FRM_LENGTH_CTL                 0x0350
> >>>> +#define IMX258_REG_CSI_LANE_MODE                  0x0114
> >>>> +#define IMX258_REG_X_EVN_INC                      0x0381
> >>>> +#define IMX258_REG_X_ODD_INC                      0x0383
> >>>> +#define IMX258_REG_Y_EVN_INC                      0x0385
> >>>> +#define IMX258_REG_Y_ODD_INC                      0x0387
> >>>> +#define IMX258_REG_BINNING_MODE                   0x0900
> >>>> +#define IMX258_REG_BINNING_TYPE_V                 0x0901
> >>>> +#define IMX258_REG_FORCE_FD_SUM                   0x300d
> >>>> +#define IMX258_REG_DIG_CROP_X_OFFSET              0x0408
> >>>> +#define IMX258_REG_DIG_CROP_Y_OFFSET              0x040a
> >>>> +#define IMX258_REG_DIG_CROP_IMAGE_WIDTH           0x040c
> >>>> +#define IMX258_REG_DIG_CROP_IMAGE_HEIGHT          0x040e
> >>>> +#define IMX258_REG_SCALE_M                        0x0404
> >>>> +#define IMX258_REG_X_OUT_SIZE                     0x034c
> >>>> +#define IMX258_REG_Y_OUT_SIZE                     0x034e
> >>>> +#define IMX258_REG_X_ADD_STA                      0x0344
> >>>> +#define IMX258_REG_Y_ADD_STA                      0x0346
> >>>> +#define IMX258_REG_X_ADD_END                      0x0348
> >>>> +#define IMX258_REG_Y_ADD_END                      0x034a
> >>>> +#define IMX258_REG_EXCK_FREQ                      0x0136
> >>>> +#define IMX258_REG_CSI_DT_FMT                     0x0112
> >>>> +#define IMX258_REG_LINE_LENGTH_PCK                0x0342
> >>>> +#define IMX258_REG_SCALE_M_EXT                    0x303a
> >>>> +#define IMX258_REG_FRM_LENGTH_LINES               0x0340
> >>>> +#define IMX258_REG_FINE_INTEG_TIME                0x0200
> >>>> +#define IMX258_REG_PLL_IVT_MPY                    0x0306
> >>>> +#define IMX258_REG_PLL_IOP_MPY                    0x030e
> >>>> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H       0x0820
> >>>> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L       0x0822
> >>>> +
> >>>> +#define REG8(a, v) { a, v }
> >>>> +#define REG16(a, v) { a, ((v) >> 8) & 0xff }, { (a) + 1, (v) & 0xff }
> >>>
> >>> The patch is nice but these macros are better replaced by the V4L2 CCI
> >>> helper that also offers register access functions. Could you add a patch to
> >>> convert the driver to use it (maybe after this one)?
> >>>
> >>
> >> Ohh perfect, using something else would be great. Ill go ahead and see
> >> if I can get that working.
> > 
> > Thanks. It may be easier to just do it in this one actually. Up to you.
> > 
> 
> I've made the swap but looks like its not playing nice with my ppp,
> its causing a crash and showing a call trace as soon as it does its
> first read to check the identity. I went in and dropped the cci_read
> and left it with the original implementation and I'm getting a very
> similar crash with cci_write too so it looks like its not liking
> how I'm implementing it. Looking at the few other drivers that were
> swapped over to use that, I don't seem to be missing anything. It's
> a big change so its not really something I can describe what I've
> changed but I do have the change on my github here
> https://github.com/luigi311/linux/commit/840593acb20eee87ce361e6929edf51eefbbe737

I checked your commit to switch to cci helper.
I think you are missing the right cci regmap initialization.

Please take care to use: devm_cci_regmap_init_i2c

/**
 * devm_cci_regmap_init_i2c() - Create regmap to use with cci_*() register
 *                              access functions
 *
 * @client: i2c_client to create the regmap for
 * @reg_addr_bits: register address width to use (8 or 16)
 *
 * Note the memory for the created regmap is devm() managed, tied to the client.
 *
 * Return: %0 on success or a negative error code on failure.
 */

Check drivers/media/i2c/imx290.c:1530
Hope this help :)

Note:
Somewhere into the github commit you are reading 16bit reg and storing
that into 64bit val. Take care! :)

Thanks & Regards,
Tommaso


> if you can provide some guidance, if not I can skip this change
> all together and we can do a separate attempt at swapping over to it.
> 

