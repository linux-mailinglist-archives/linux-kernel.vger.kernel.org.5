Return-Path: <linux-kernel+bounces-12969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BCE81FDC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70091F22D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A33A6AA8;
	Fri, 29 Dec 2023 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrj481SG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F57472;
	Fri, 29 Dec 2023 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5947cf2a4f6so2678607eaf.2;
        Thu, 28 Dec 2023 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703835732; x=1704440532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=belYaZw7nnlF1duW1TrklCfu9FOKWDv8WHvDDxzeUJc=;
        b=nrj481SGXZSBjlF7AKoJ43fmiu3e73Oj6p8uXAJBXsKn8QjcRbM4psCtL9bx+qbjUA
         XiG2l43elCb9rOOOY0khl7e485KStLjdpisbZWpbCoKgYekvwlfCn4kUV69l6Lwm8z5P
         T4gJaN907m4dZ1ejWXEjwhDcJnOQLzaHRJCRYBVxZYOoY3JTxsgE/9LLAR0J3KSJ4IjB
         fCZXMZJHA6PfQLXJy/sIeflLvLAgFS54xxF06YPqx8wAh1dND7Hx11b2F7H4cDLs2SzG
         bD/et7v3zieNMHzAmGyaLyPF/bewUh8A1UBc8s7LqTWw1BU7UiO8uOEorVS6p0EPpZ1K
         9jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703835732; x=1704440532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=belYaZw7nnlF1duW1TrklCfu9FOKWDv8WHvDDxzeUJc=;
        b=k0LMyZGHHC5+6yCYQeF14pLys/4UVHbufH3xxdbfNtSZDoie5S02AzvI/QsYleCxH1
         ddSYAmtjSacLZQufEkNMgByNonpuyOA38OpM4HRk3XKox1hR5+YYdfrUWw419zGwZ/Et
         qcC95bmQ8wzbQnNTaanR5JBNlL5yODXDF1/wyv5ARsFNaAzrIsINNs0rMqAGYB/6qnCo
         vkqDlkcXVxtMspPYC/geJBUG/SNQRam514ZSwPjUqgbxS47CQ1IoX00lVza2d1qAsa4E
         UgD4rF68sOq60qDsgRFSfl+zuhVUxFURAEjc8sFIavotecinefb7QMgN2VdrlArLzRE9
         0YkA==
X-Gm-Message-State: AOJu0YwhNFlyypEcX58ibwlHqspNJbX+t+aOvsFgKsvB8PDUObR9tiTP
	4QQw4qRQG1/UHbxDtEKpPVw=
X-Google-Smtp-Source: AGHT+IEOnqTVZ1gPw9ajScbpZJ1Avm2rUUVUMeKV1/mi5nzQdguVdREReXdaWJ4QvZ/w7zAipfoY4w==
X-Received: by 2002:a05:6358:3419:b0:174:df41:a412 with SMTP id h25-20020a056358341900b00174df41a412mr10684026rwd.40.1703835732252;
        Thu, 28 Dec 2023 23:42:12 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1995:632f:ef1e:946e])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a784800b0028be9f86701sm15080059pjl.38.2023.12.28.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:42:11 -0800 (PST)
Date: Thu, 28 Dec 2023 23:42:08 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] Input: usbtouchscreen - Return directly after a failed
 kmalloc() in nexio_init()
Message-ID: <ZY54UDosMHwj6D3Y@google.com>
References: <9365c845-baa1-44d1-add9-ec8ca4d365eb@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9365c845-baa1-44d1-add9-ec8ca4d365eb@web.de>

On Tue, Dec 26, 2023 at 09:08:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 21:00:25 +0100
> 
> The kfree() function was called in one case by
> the nexio_init() function during error handling
> even if the passed variable contained a null pointer.

Which is perfectly valid thing to do, like free(), kfree() accepts NULL
argument.

> This issue was detected by using the Coccinelle software.

This tells me precisely nothing.

> 
> Thus return directly after a call of the function “kmalloc” failed
> at the beginning.

This is simply a matter of preference, the original author preferred
that style, I see no objective reason to change it.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/input/touchscreen/usbtouchscreen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index 60354ebc7242..1873c7918a78 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -977,7 +977,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
> 
>  	buf = kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
>  	if (!buf)
> -		goto out_buf;
> +		return ret;
> 
>  	/* two empty reads */
>  	for (i = 0; i < 2; i++) {
> --
> 2.43.0
> 

Thanks.

-- 
Dmitry

