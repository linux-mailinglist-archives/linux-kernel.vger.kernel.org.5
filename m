Return-Path: <linux-kernel+bounces-60981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A521850C21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCA22819FE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1A17545;
	Sun, 11 Feb 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgxC2R3h"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20642171A0;
	Sun, 11 Feb 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693208; cv=none; b=WBAuQLXis32Gmx7tRHg6VS2I3WzSzZHzL7WH0+tW1ZcJO+ftXEKpMjZupj85o9VRRHFYjqyO9aG00aWFC3CrtEpFJ3soBjYvya/SyhK6LFae3viwDlrpvtp2/v0ApYwjFlMcHvEX4jr15gLt3kd26zr1Qw4heMWVqBNsndBbiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693208; c=relaxed/simple;
	bh=xo36J8fOakG6knpNeZV8/mzbGVFedPF8ijEDpOEf72s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTB9unHKY9EvXyL+R6vf9k8TcDSJ39m9Vnq2sbENtg+oW9eNuVk/ckCG3x7SDH8VBRiM6nEKYqQL2juk/01v6jfdsbZDcRtd4t+NS029A8YvLxzfbn2OCUFr36b2w6It3VgGElblVCcEJj1pEt5B/40Ch0+q9BXBIjeZKto76Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgxC2R3h; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2055156a12.3;
        Sun, 11 Feb 2024 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707693206; x=1708298006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xo36J8fOakG6knpNeZV8/mzbGVFedPF8ijEDpOEf72s=;
        b=JgxC2R3hueZDHJbOxoEuuASfd5pe5iirvkuCXACdjKDNEPIum37YiG1io+l9fH+Mvz
         J77L2XdHHFVTHeC5DVWSuWx4jsL4DJ+HtEqCynqKdF/6NRcpCVZFaN2rUtTnr0RhVX32
         yD9iNU2dvMrVrfcBUaCYTSuUgHw+AMtmj9E9FjUpDRcYe5Jh+kxEWYP9PNgAnYXop1Jl
         F9ikaawaQmhfRUpFs2VyZUTDn4Z+EtIWFc2qqSqKGqXM8D05O1bA9IxzB1gKMiXMUdZI
         +kqBMHoyagiv+aeEhn9heJ9qAWiL4j5M3bTIj5IoeKbwzxiaJBDlNnw2yNKluLSMpdet
         ndlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693206; x=1708298006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xo36J8fOakG6knpNeZV8/mzbGVFedPF8ijEDpOEf72s=;
        b=pCP4qBMjkkVJ3h0koEEnm50CYGOOxA+h7XG0kpcv+SMr7LRDMUK0d3dNPsJWKo8zYQ
         nEpOylFdFyFSbIEUzgFoQq1DWjPeeF6IzTtl7vcXoWcm4GtLbr4RyD6g+fv4AYj3nhjx
         PoOljuWYlTL3muvIXwmfPXm1xOu6GjHcldo9GAbe54vTrfngSofJyxlN1C5fY4i9Hd1F
         J0IN+RGUitCSk4oAsbX//ixzIUeMIW9HPMjtpS+fZSAuK5G5UaAM1yPnEOcvtVu10XkK
         73SbxuSjK9WbQMTBND3+/1MCqUHW8nGKsc6R06o0GUoTkGWVlNPCCGC6Tc4rwca7HXaj
         pM2Q==
X-Gm-Message-State: AOJu0YyqI9H2vYLW7Mcz00sf0ds1FVLNZIX0bOueNUMPoSCP3dmRhrg6
	Etdq9WCNejocpVzFt8YJFnE21iDNFzquGfEMMwktAfMkdLFgHlCQ0vtpUAzt
X-Google-Smtp-Source: AGHT+IFJB7u7GBig2yjHLhYLgy0Et2ZOVa+6freH6tpfiY3NWud7Q9tkbVEXq4I9V542ozOQtnp5ag==
X-Received: by 2002:a05:6a21:150c:b0:19c:9418:c396 with SMTP id nq12-20020a056a21150c00b0019c9418c396mr9012529pzb.31.1707693206175;
        Sun, 11 Feb 2024 15:13:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRMLniCuV7IK/HC741OJMM6skLyxVJ7uAatLpihFlwBF5sM1zz+OttMQNeQVApPTIJjVpns0xBthygEBShkOuPv1040TJxPNNuEi0KzuBiAdD8EoHWWVyRfT7FHxm/Lq6mrPIVj5SggS7tCFKrMRicaTEsYPuQ/KQ11MiCGe/daojbNCE=
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id a21-20020a056a000c9500b006e03927d123sm4227082pfv.202.2024.02.11.15.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:13:25 -0800 (PST)
Date: Mon, 12 Feb 2024 07:13:21 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
Message-ID: <20240211231321.GA4748@rigel>
References: <20240211101421.166779-1-warthog618@gmail.com>
 <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>

On Sun, Feb 11, 2024 at 06:58:14PM +0200, Andy Shevchenko wrote:
> On Sun, Feb 11, 2024 at 12:14 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > The documentation for default_values mentions high/low which can be
> > confusing, particularly when the ACTIVE_LOW flag is set.
> >
> > Replace high/low with active/inactive to clarify that the values are
> > logical not physical.
> >
> > Similarly, clarify the interpretation of values in struct gpiohandle_data.
>
> I'm not against this particular change, but I want the entire GPIO
> documentation to be aligned in the terminology aspect. Is this the
> case after this patch? I.o.w. have we replaced all leftovers?
>

Agreed. Those are the last remnants of the low/high terminolgy that I am
aware of, certainly the last in gpio.h.

Having a closer look to double check...

Ah - it is still used in Documentation/userspace-api/gpio/sysfs.rst -
not somewhere I go very often.
Would you like that updated in a separate patch?

Cheers,
Kent.

