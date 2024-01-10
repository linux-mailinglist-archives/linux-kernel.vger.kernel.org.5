Return-Path: <linux-kernel+bounces-21892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F5829621
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675A7B24DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F373EA7A;
	Wed, 10 Jan 2024 09:19:13 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6123EA6D;
	Wed, 10 Jan 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2a1a584e8bso387532266b.1;
        Wed, 10 Jan 2024 01:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878350; x=1705483150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d54gLTRIUhxQmAyd3Y0D+5lpnbD9pU1y8y4VXzOVS+I=;
        b=etbj9V6H6Y5smMl1rryfFQhGw2xKBjya2Tu1h/DDCp0+uLU9RDU2dhtGp1zMkpuuNL
         rFICrmgd8phKfB7bzyJ9VyOuTHYcrXzpTVgC4AFzx0OE5QCWZfWQ9jcXBnpEWxSjBCFf
         TsxaJUAv0+eyvfrr44dMCLsoxOz8+VQ8M0hdjo6VJ/ff+KOfOYttZfl9AjDp0SAEZe3H
         bZgc0pN+n1WJ4IWf0n2kS/owTgKRe0b4Y8+7W8UKnvbIglnOEwAPFSCLsIL1+sgjZfkd
         0EIFWvIxZdTPZot8hszr01U/0a47/FYZ27lVFBXadjAUjloFJwMMgs8WGwbIcSjYeJQu
         OtGQ==
X-Gm-Message-State: AOJu0Yxt0SllZwg8iF1MBEe6xeiGCeaReBsIMKJOsvatvbrQQFmRw4T+
	0MDig2sauedIPNdSESNE2/g=
X-Google-Smtp-Source: AGHT+IEzsF8UjIovugDbKuXSrbkdmWWxQOLjiU1IVWHL5k0JilfiUilfpm6ulNaIWqvJIXUXctTuLw==
X-Received: by 2002:a17:907:96a2:b0:a23:49d9:7e9e with SMTP id hd34-20020a17090796a200b00a2349d97e9emr451172ejc.12.1704878349869;
        Wed, 10 Jan 2024 01:19:09 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id mf25-20020a170906cb9900b00a28fa7838a1sm1924229ejb.172.2024.01.10.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 01:19:09 -0800 (PST)
Date: Wed, 10 Jan 2024 01:19:07 -0800
From: Breno Leitao <leitao@debian.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexander Aring <alex.aring@gmail.com>,
	netdev@vger.kernel.org,
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-bluetooth@vger.kernel.org>,
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-wpan@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 07/10] net: fill in MODULE_DESCRIPTION()s for
 6LoWPAN
Message-ID: <ZZ5hC5SGiUIEZPdm@gmail.com>
References: <20240108181610.2697017-1-leitao@debian.org>
 <20240108181610.2697017-8-leitao@debian.org>
 <CAK-6q+jy-0+bZRUKhRsB2RMtpJ=Sw1A5qHk+rpnYaOzV8WFD5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+jy-0+bZRUKhRsB2RMtpJ=Sw1A5qHk+rpnYaOzV8WFD5A@mail.gmail.com>

On Tue, Jan 09, 2024 at 08:04:47PM -0500, Alexander Aring wrote:
> Hi,
> 
> On Mon, Jan 8, 2024 at 1:21 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to IPv6 over Low power Wireless Personal Area Network.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/6lowpan/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> > index 7b3341cef926..80d83151ef29 100644
> > --- a/net/6lowpan/core.c
> > +++ b/net/6lowpan/core.c
> > @@ -178,5 +178,5 @@ static void __exit lowpan_module_exit(void)
> >
> >  module_init(lowpan_module_init);
> >  module_exit(lowpan_module_exit);
> > -
> > +MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network module");
> 
> Here is a nitpick as well. The correct acronym [0] is "IPv6 over
> Low-Power Wireless Personal Area Network", otherwise it is okay.

Thanks. I will update.

