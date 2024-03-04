Return-Path: <linux-kernel+bounces-90993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E6870822
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD9F2828BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A760276;
	Mon,  4 Mar 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNi2jmam"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0A6025B;
	Mon,  4 Mar 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572588; cv=none; b=s92+2Gkbv9FkNzeIERaDQG0sRyUxRDjNqzwWYmJtekyLTlJouI5Ti+ozw/MXWb0AXHBZmZY7/GOOi3A2ew1I8GX34CYEKrZRlMTfFukt9dzNEETPoUinmHoWJcLeaRAZeg7q9gqtMjM+5Q35H6Omp48jjZvfJhhFXO+jKoW7DOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572588; c=relaxed/simple;
	bh=m4aPM8M6KAN3usk2/26PJxZ518eFliLBsTOWT8kko9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ0NS2yXwRrt0P+2gL+JcWjP9OkmSvqSlluEfl1eQS/2IpnrL4WpmeqYeULCryESRj6nCcTLht8XkgJ5NAdmAI0eede8bsC3p6k8KgzbialH1ZKJDkr+X5dMC2E7E0ig/rethKJl61njOvuQYNDEcHJlgKzvbB3xpeEVO6cLluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNi2jmam; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4053186a12.2;
        Mon, 04 Mar 2024 09:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709572586; x=1710177386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GiGUTwcmS+sZMCMr3FUD76KaDTM9Y9RtqjrMO//bVwE=;
        b=jNi2jmamFhTSA3Q9UPcFSSwkGSG6Iw2Tqm7KMTgWRWMvZZ6JVxatYB92v44dT4IGgF
         NXJwEM+mWGdkW0hvV5kPU9G6FdD4xgN0ELfdKx5wKXyq3MnZCcFrDp/4+LnNt2SrzYTh
         bGFz8e2Ho8ad3ngAFRuYQ14ecC1igF+z3Eqv4HrYLbDdCHGUiMeblJ747j1STDSj2bT7
         ghVq0FEcWiS1b6UHOlAbUPyn4WyE5JEsKuCE1l2fi39qA49xDrkVp+mD6SxcRnZgt3Df
         MheGX+kTYuA0TF5QwRSISVbY58PKPTVvHkEYt8AcsZd/g/Z4vjXLnYkrrLEjp3ATdi27
         ZTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572586; x=1710177386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiGUTwcmS+sZMCMr3FUD76KaDTM9Y9RtqjrMO//bVwE=;
        b=Xv+0TatP7bx+rT7FBfhGOlWRn+vQ/lYTrlLWtNis63BTgPs9owO6DxlaW8/NqKVYoR
         9B3Wko9wmV/TBpl6eB6L1kXnuEURdSIvW8qs77VAYnzrnBWMeFVOhFcG041iAk6Uy6C4
         9U14qQSRbLA1KJ2HuZ3mlEFiLSHfNbX06/jQpus8xTx1kiHNVLMwuK8zjg4F6wby+Gxa
         D8jZTbxDb1ji86nNh+jQ6JQp4ZFftkhJI/Io7evXuM+pVc3XjWU1lqRR0ngnrBnsa7an
         qHLIL+KW28LCkk+5LHJuSAPkvTQjGk4Dc7+7G23MLMhaUCueDG7PeGdEd7Eht8PIC7Um
         1HTg==
X-Forwarded-Encrypted: i=1; AJvYcCWMdevwhHKRFValZXhLfSmuQIun0gaazhtFOrKhQWlW1U+6zkOywzrMFyxcRKCEvojKsva87yasl+Z93p6DoYoE9S5Hesxh8BNhDK8HZq/hAwFNcS6Ig5Lq6pXOL+qsSuAutcFuGLTFYDCaJ5HHObYFqEmX5O+jAwHF6NODFcD0G+foYNXqWAoyCLc=
X-Gm-Message-State: AOJu0Yy4jiOfu+R/8jYt2DUA5B6fxTQrFEcNPAycg6wrkhYnxmPdXXfn
	L1q2a6lWuuQlKhnzuqiR7i7TwKKCNubQA42xKHfl6xa+DMO0m0RV
X-Google-Smtp-Source: AGHT+IGuVXFuv6smouEpbKdN0FwHDvZTejuV/4+04n1oAt1D7900BVI3gEwpMEPYxt6tRHJMB294Pg==
X-Received: by 2002:a17:90b:46c8:b0:29b:1f62:6a3a with SMTP id jx8-20020a17090b46c800b0029b1f626a3amr7834956pjb.29.1709572585964;
        Mon, 04 Mar 2024 09:16:25 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id ta6-20020a17090b4ec600b0029a849e7268sm10345209pjb.28.2024.03.04.09.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:16:25 -0800 (PST)
Date: Mon, 4 Mar 2024 09:16:23 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-input@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] Input: iqs626a - Use scope-based resource management
 in iqs626_parse_events()
Message-ID: <ZeYB51RRw6Lg0XSh@google.com>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
 <ZeU8ENmnPj3sKxAv@nixie71>
 <ZeVOPSt0L1D4BxuZ@google.com>
 <e8a2b63f-4f9a-463b-b419-c5f673191111@web.de>
 <b91fe21-fe2-eac8-d1ee-ea8922a08861@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b91fe21-fe2-eac8-d1ee-ea8922a08861@inria.fr>

On Mon, Mar 04, 2024 at 11:55:23AM +0100, Julia Lawall wrote:
> 
> 
> On Mon, 4 Mar 2024, Markus Elfring wrote:
> 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 4 Mar 2024 11:40:04 +0100
> >
> > Scope-based resource management became supported also for this software
> > area by contributions of Jonathan Cameron on 2024-02-17.
> >
> > device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
> > https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org
> >
> >
> > * Thus use the attribute “__free(fwnode_handle)”.
> >
> > * Reduce the scope for the local variable “ev_node” into a for loop.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >
> > v2:
> > An other cleanup technique was applied as requested by Dmitry Torokhov
> > and Jeff LaBundy.
> >
> >
> >  drivers/input/misc/iqs626a.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
> > index 0dab54d3a060..86fcb5134f45 100644
> > --- a/drivers/input/misc/iqs626a.c
> > +++ b/drivers/input/misc/iqs626a.c
> > @@ -462,7 +462,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> >  {
> >  	struct iqs626_sys_reg *sys_reg = &iqs626->sys_reg;
> >  	struct i2c_client *client = iqs626->client;
> > -	struct fwnode_handle *ev_node;
> >  	const char *ev_name;
> >  	u8 *thresh, *hyst;
> >  	unsigned int val;
> > @@ -501,6 +500,8 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> >  		if (!iqs626_channels[ch_id].events[i])
> >  			continue;
> >
> > +		struct fwnode_handle *ev_node __free(fwnode_handle);
> 
> Doesn't this need to be initialized?

It would be better if we had a helper here, iqs626_get_ev_node() or
something.

Thanks.

-- 
Dmitry

