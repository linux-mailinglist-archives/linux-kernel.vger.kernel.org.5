Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12039810E13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjLMJr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:47:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81716D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:47:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so8564956a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702460849; x=1703065649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aSgX3PAlQ/y9PwkGI1/S+nZD/MIWDoeA/FX6JGGY/aY=;
        b=aXEzd3AKoQfo3zLYGJCGtHuvriB0/yjj90mxcTq2CNtvBRvSbUyJtbtjvngT/yM1QH
         5ySKpWLXO1nZjf0Nk6OU8Euoq6ujw2dGTgaBVod0CPy1CuWCjiLgIlp8/gb6RvT4zsIe
         QnflA4C5ChqsSHt7CrtaDmMQDWdyX5kWGOfsfRmyvXhEFrEtla8jPCaS+v9aeW+g6DLp
         hWjPcIwE2bqvTVBQOVMH7Y1JavKk1bpTIKvHeXZN/ey7uq5YrigkYvpEMdDQDGZR+FRl
         UHgTEL28Jsfw8HkAKNU+3f+PfAIgE6IlF4lkNg9qIet17QN8bZ2ZZjYu5UC7Xy/K0bqn
         jttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702460849; x=1703065649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSgX3PAlQ/y9PwkGI1/S+nZD/MIWDoeA/FX6JGGY/aY=;
        b=Cp+IKppudkMLkI9OQPWazPyy+AkRwOFi0mpmgX71TjHK/usFPjE/3VN4IOnwMXblxw
         6JSfGPn9Y3F6xd+rSscrD+SNXRvdTnySBTAqSbDgt+tZAshTSdwu8R6Psj5JuXauYR6J
         bM+2DIUdPXabu5kbuOluVzwoKGKoKqYpikm85eutiDrvfU6PD9s9jcHQ5eKyPJKKvPzY
         cL52hb3Han33CNukOzqsjDKNU4WkXvC3F9aDfKNji3tZRORRUr4gSGCelN3v1D63BqSz
         CbmEVF3FMELL6+E5sZWRuZnq+WMPs9vlzl1rvlA3G/0WKiw4Eg++MgxpLEFY4xcIZ/Cw
         CS3Q==
X-Gm-Message-State: AOJu0Yyn4hN/6rhlEnyXSi5tWtloJVrotU0l2SME7E+SYf/urh/lhrtu
        ndZl5hOtCmy5dNP7LRt1Vtm1lA==
X-Google-Smtp-Source: AGHT+IF1a3/GekoPgQ+7ZrhVIzXjagRHGpaEFn7SdjzyCmJ1k1zS4HmcixgzuX3JjFjBkAtOMVKfMg==
X-Received: by 2002:a50:aa8f:0:b0:54c:4837:7587 with SMTP id q15-20020a50aa8f000000b0054c48377587mr4658455edc.51.1702460849026;
        Wed, 13 Dec 2023 01:47:29 -0800 (PST)
Received: from localhost (h1f2c.n1.ips.mtn.co.ug. [41.210.159.44])
        by smtp.gmail.com with ESMTPSA id j17-20020a508a91000000b00552148d00a2sm480954edj.41.2023.12.13.01.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:47:28 -0800 (PST)
Date:   Wed, 13 Dec 2023 12:47:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cdx: Unlock on error path in rescan_store()
Message-ID: <dacdee7d-48f7-44ff-a494-ef7d912338a2@suswa.mountain>
References: <8c79956b-bf8c-4511-97cc-a16833a0630f@moroto.mountain>
 <94c5f197-9459-40fe-9c34-06359779a51a@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94c5f197-9459-40fe-9c34-06359779a51a@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:53:13PM +0100, Christophe JAILLET wrote:
> Le 12/12/2023 à 10:20, Dan Carpenter a écrit :
> > We added locking to this function but these two error paths were
> > accidentally overlooked.
> > 
> > Fixes: f0af81683466 ("cdx: Introduce lock to protect controller ops")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/cdx/cdx.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index d84d153078d7..f4f9f0c88c09 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -572,12 +572,16 @@ static ssize_t rescan_store(const struct bus_type *bus,
> >   	/* Rescan all the devices */
> >   	for_each_compatible_node(np, NULL, compat_node_name) {
> > -		if (!np)
> > -			return -EINVAL;
> > +		if (!np) {
> > +			count = -EINVAL;
> > +			goto unlock;
> > +		}
> >   		pd = of_find_device_by_node(np);
> > -		if (!pd)
> > -			return -EINVAL;
> > +		if (!pd) {
> > +			count = -EINVAL;
> > +			goto unlock;
> 
> Unrelated to your patch, but should we have a of_node_put(np); here, on
> early exit?
> 

Let me resend this along with a patch 2/2 which adds the of_node_put().

regards,
dan carpenter

