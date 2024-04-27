Return-Path: <linux-kernel+bounces-160964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F139E8B452E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C69EB221A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920444503C;
	Sat, 27 Apr 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoqTZyHa"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763E43AA2;
	Sat, 27 Apr 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207712; cv=none; b=r7DU47kh2ywl68MrIrIVseTGo4yu4As9KH+yqd8z/RcUIgOXi6K1yoQNb0ZHxIVDrTKUJpibl32IxVb9B0KXZjidSjsg5qFY+YP9Ga/POp4H5l2bWHflAz3t2PxbI7yADyzJtmSo3XdeBgbY/Tlnv8Nf/zM7hz7T/E+kFlN5DJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207712; c=relaxed/simple;
	bh=V4NpDnxzjqlT9WYru8l/dQpMschafKVu3wR/Hiqueg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwAUkzzkcAxzD3ntTBOAX6z7jXzYM74n8hyoU3TlpLfo5pM+rpzXvn00dTxxjva9HZAhCSfgTLmNWo2US1D+jfYNVUQT0foAISUzS1wh3Oc/1uS6FHHVfumnN5i3GONPPX/8IjU93wKK6G3Sd6a5Y0E47xT7cv2WGiDTbiDdJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoqTZyHa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so2120997a12.0;
        Sat, 27 Apr 2024 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714207710; x=1714812510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXHIbNFrUZ3oIq2rhdb5p0syCAenZ2Q/nUC+x14Dlxc=;
        b=eoqTZyHaawkjybYL58tlGgfVGMVFyvn+c667tURGccLvW6bhWkw8UoGEtKieUfBFbN
         umhI+9FZygiEoaop1r6xZwedYGwDxiW4lEkSUyKYp0f/+Ef92jVBY+tBfgicjIwSoQ4X
         ZuHJ0kDXBml0+RMmuGO/TQtC1ZQC6VhQfSwrBTTT3EgpvCMNbuOCpCryP2D7qnRlvedz
         Cf09WGMCx6rxHzemuHu3jGA3Bco8O0JjX98jUJnP/cTcpHior0gwaOmurzPh6h+FLHet
         eFpVsBh4qAKdNeh176B1lDb+HX99hcVnxmNmNkRuSWcZjlHnO9L1R8mlYglES2UvScu5
         Iu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714207710; x=1714812510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXHIbNFrUZ3oIq2rhdb5p0syCAenZ2Q/nUC+x14Dlxc=;
        b=usB14MyTbh6eUGEDZGcZcOdD+i90uI8laZEnzPXyPcDI1BKK1DVMRz/wIkWyOucilB
         rPbSprzijxyjzbkPK2V7nX399p3MARiDGOWkuPcfy2tc4BB+ZGS1PRDQ+MDYn/x27fiW
         Ik51ZpyBeFH4UK1tZswsgEq5cQsdP3cQbPs2MRXUW2dtnt4En9OQrQ2RvUUA/rnpCEei
         mcKkXzTyT1qke5581kPi97f22jI8e7dOy+/s5nrifFzYGDpQ5Oh1wkLyc1iDwMnngPFh
         m2EcHZsOZXdCwk/ly9y/iQYF+iVVDnVIhyQJezcT5+tV7Yp0XMji9qgxYXDFSx8I1azi
         xgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqu4ev7fEr4NhPYKQ5KLPOOvUotrFh7U+uRFvQkZHFfHruWfdXTsgONRgP4OV7Bu8ml/bxotHaZukccKJL4Cry6fCz3p0T0M9LseMoOdcY50mkeBoR3QtOs8GCPaiiEcU/sHBWVFZV
X-Gm-Message-State: AOJu0Yyjxm7+mze/lsVefDDuDuZelwHo0KT8a/WI4uI19KX46PFYbGc5
	hBXjh3+8LSSYrhFjNBsxoi6UXsJKlNATvnj75pkWr8GeAnRJWBQO
X-Google-Smtp-Source: AGHT+IHR5tbH6MWsLG0qWRbuZ84BDJigIemtA0Lf+Sj/Ld57wPUYzXI0snSmQFCm8kXNUnvTOpHeqQ==
X-Received: by 2002:a05:6a20:3954:b0:1a9:8251:41ba with SMTP id r20-20020a056a20395400b001a9825141bamr5582525pzg.51.1714207710369;
        Sat, 27 Apr 2024 01:48:30 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a590100b002afd65ff881sm3946516pji.44.2024.04.27.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 01:48:29 -0700 (PDT)
Date: Sat, 27 Apr 2024 05:49:18 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Fix temperature reading for
 negative values
Message-ID: <Ziy8DsMCeAGK79E7@debian-BULLSEYE-live-builder-AMD64>
References: <20240424185913.1177127-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424185913.1177127-1-dima.fedrau@gmail.com>

Hi Dimitri,

Interesting patch this one.
I think this does apply, although, the cold junction register has for sign bits
so I think we could also have a mask to clear those out.
Some code suggestions inline.

Regards,
Marcelo

On 04/24, Dimitri Fedrau wrote:
> Temperature is stored as 16bit value in two's complement format. Current
> implementation ignores the sign bit. Make it aware of the sign bit by
> using sign_extend32.
> 
> Fixes: 3f6b9598b6df ("iio: temperature: Add MCP9600 thermocouple EMF converter")
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/iio/temperature/mcp9600.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 46845804292b..7a3eef5d5e75 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c

#define MCP9600_COLD_JUNCTION_SIGN_MSK GENMASK(15,12)
..

> @@ -52,7 +52,8 @@ static int mcp9600_read(struct mcp9600_data *data,
>  
>  	if (ret < 0)
>  		return ret;
> -	*val = ret;
> +
> +	*val = sign_extend32(ret, 15);
	if (chan->address == MCP9600_COLD_JUNCTION)
		*val &= ~MCP9600_COLD_JUNCTION_SIGN_MSK;

>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 
> 

