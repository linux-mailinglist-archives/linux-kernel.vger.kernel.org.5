Return-Path: <linux-kernel+bounces-96393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE1875B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F6B1C20AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BCD63BF;
	Fri,  8 Mar 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNfdZGew"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDC1CD05;
	Fri,  8 Mar 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857834; cv=none; b=pjMNTALJYqVUg3MsWruX8dV91pTFT9mJSKzXCs+oCJ1Gh/UEtS+j0BIIqQc8W3os8BmIc+M3GtSsSu3QG5DxOY0/EHAXwhB207p0SFsjOAoUbLIkjpaXDE/NFv6NTB3mdECRtzir8VAg74KMGnSMy3KqFrwOLH/sUhkLGFiBs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857834; c=relaxed/simple;
	bh=FmvtmuJp4iYx2xKCfdfNDhv1ZPTAAFS9Pxa5WePHlRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbXsbbwWBdBCbWOLuZ+oLdtao942+dgTcvTvnxE8uH1ivrKKNmuWK3xrZ3VdSfUAFO1J+p90SLdfrgk08YRXYigaAjNNErp7WeiYBUGH5XarNzGNnAs5k3gVC2XFHsSuaDiND93g4O+3Je9TCSuyGPqEsdhigRwxMXbKDoOIHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNfdZGew; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd10ae77d8so13383985ad.0;
        Thu, 07 Mar 2024 16:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709857832; x=1710462632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0xyP0tGi6BBQc8nNMKqV9IiFVbJf3kyiqu5hveyj5c=;
        b=CNfdZGewyrYibi0jR8GJuQDZrxbFOVmcKhrJ/KKphQk80dDO/1Qw9ULYdexxagL61I
         ZyJrZBtXk++LHn9kV9NWUb1traFfp7KseBLvTmdY+vo0KBYAgF/fr1xLv8dbHYSM7ho8
         c37l0VDFs2blfWTB/VO1md+qBfTFfvHnnuSuGj4z52MtbMz+iNei5qLqJoQHr7I77dGG
         NQFuiDPxCZjroazbpw5lZmfEHXeEwFMvIiNUw8MOoNckpYmY53aySW9SZEQyWRj77Vej
         K5owAXF5iIEVItsbsgmiJJWJ43rkCFlS2Qv6IoUaamAPlZE99di4t+krx5zWyO9kPoRL
         6DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857832; x=1710462632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0xyP0tGi6BBQc8nNMKqV9IiFVbJf3kyiqu5hveyj5c=;
        b=Ncaj2HYk8MEOpmCpFlnprP0Vdyi7JPKA/mjQtBHSX+Aw6ie5YmpiljNxzmQ6JlL8jf
         wLS7d/+Je9e5g9MWPN88jXtp/IHzfSiTM2iD5NEWMKeN1N8DK6ts6gFevVykqrPs6YMx
         q3AZ2avmIXFaUgR5dMdAXp0aNA9f/lXOUVmc3TeE+pLGQ2xHkt7cCzzuiRbLUiJuGy7s
         yD+BvZXJGlmH4Ud2oow2cvcxyLpNVcgJSXmC4d7NZsdvd9o5kvjpo+hN5LHR4BXAFjps
         R4pG8pGILpJymBUBHg2rDtEO2xpr7HJZp44NMP2BKldDaOHDPrhKTxAOTzhODlphRfcS
         kOcA==
X-Forwarded-Encrypted: i=1; AJvYcCUhXUpO5jmkiGDSEJ0DDdTXCZuQv85e7AsaBqtC5E7RU+xL5OZGKyZ4oh4enojU2K1LcJ4OVHzttZ8xObqp3M2H+XZ12KimPc7iE9cPBJJ6IkmGdkY1Dbo9EVyMj7FdhDa61bBw/dLyfvY=
X-Gm-Message-State: AOJu0Yx2BeLeaZecKMGhWFDueyfohRIumZA89+3ZltArSjiJyXL0l7af
	maT7xM5OhzXAaQtjhSA1/crdUiGFVJ6MQ7rfWOd363kN22Lars4X
X-Google-Smtp-Source: AGHT+IE0vp5ntfkL3LjCRDntUZpnMVxAGr/YRqblfjC04ypXeHSC1N0Ok66hKK+cMJYBoWI87EAmwQ==
X-Received: by 2002:a17:902:6b06:b0:1dd:33:6efb with SMTP id o6-20020a1709026b0600b001dd00336efbmr9186927plk.30.1709857831807;
        Thu, 07 Mar 2024 16:30:31 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:13a:f30c:e020:9a13])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b001dbcb39dd7dsm15401221plb.125.2024.03.07.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 16:30:31 -0800 (PST)
Date: Thu, 7 Mar 2024 16:30:28 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Torsten Hilbrich <torsten.hilbrich@secunet.com>,
	Nick Dyer <nick@shmanahar.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brad Spengler <spender@grsecurity.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix use after free (more
 completely) -- but not fully ;)
Message-ID: <ZepcJAhn_JYJcz3F@google.com>
References: <e77756aa-c0f1-44a8-bcd6-a46fe954b195@moroto.mountain>
 <49c935cf-4bf5-456f-8bc0-d6dbf0f8cf0f@grsecurity.net>
 <61786e1d-35dc-4cf1-a152-fba363c94520@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61786e1d-35dc-4cf1-a152-fba363c94520@grsecurity.net>

On Thu, Feb 22, 2024 at 03:19:49PM +0100, Mathias Krause wrote:
> On 22.02.24 15:08, Mathias Krause wrote:
> >>
> >> The bug is that we must not call device_del() until after calling
> >> irq_dispose_mapping().
> > 
> > Unfortunately, this is only half the truth. We investigated this further
> > and there's another bug that got introduced in commit 24d28e4f1271
> > ("Input: synaptics-rmi4 - convert irq distribution to irq_domain"). The
> > IRQ domain has a UAF issue as well. I'll send the patch soon -- wanted
> > to do so this week, but, again, more urgent matters interrupted this.
> 
> Unfortunately, I send that Email too fast. Looking at the backtrace
> again, it's just the other bug that needs fixing (a UAF in
> rmi_driver_remove()). Will sent a patch really soon now!
> 
> > 
> >>
> >> Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
> >> Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> >> Closes: https://lore.kernel.org/all/1932038e-2776-04ac-5fcd-b15bb3cd088d@secunet.com/
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215604
> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> ---
> >>  drivers/input/rmi4/rmi_bus.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> >> index 1b45b1d3077d..02acc81b9d3e 100644
> >> --- a/drivers/input/rmi4/rmi_bus.c
> >> +++ b/drivers/input/rmi4/rmi_bus.c
> >> @@ -275,12 +275,11 @@ void rmi_unregister_function(struct rmi_function *fn)
> >>  	rmi_dbg(RMI_DEBUG_CORE, &fn->dev, "Unregistering F%02X.\n",
> >>  			fn->fd.function_number);
> >>  
> >> -	device_del(&fn->dev);
> >> -	of_node_put(fn->dev.of_node);
> >> -
> >>  	for (i = 0; i < fn->num_of_irqs; i++)
> >>  		irq_dispose_mapping(fn->irq[i]);
> >>  
> >> +	device_del(&fn->dev);
> >> +	of_node_put(fn->dev.of_node);
> >>  	put_device(&fn->dev);
> >>  }
> >>  
> > 
> > Acked-by: Mathias Krause <minipli@grsecurity.net>
> 
> So, forget about that one, sorry.

Right, I do not think this patch is needed. The "fn" will stay in memory
until the last reference to fn->dev is dropped. So the original patch
was enough for this particular issue, and Mathias' patch fixes slightly
different UAF.

Thanks.

-- 
Dmitry

