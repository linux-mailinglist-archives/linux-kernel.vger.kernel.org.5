Return-Path: <linux-kernel+bounces-65585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DEB854F16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDABF1F2394A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C5604DC;
	Wed, 14 Feb 2024 16:49:35 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D584604AA;
	Wed, 14 Feb 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929375; cv=none; b=PPs7ywMcH0X4/1V7YmJgXQoYCEbp0jc1dlpi8fDRbWkyw3EVuy9g5bjum0/7/x5JrvgYi0MOf93D6hiUkNgzmaMcyNhWvLRtCTkluCjm2qRyhN3M1MrSYVxWGMlMLz3iSFvSRKzdbiJ3j6XBKda9sIqk2ZTK1YT2QvTLhHWtEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929375; c=relaxed/simple;
	bh=wLHjf5vRxcUwPOIopH3TL7sPSadv97SOrvzzkNBKq9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL1AYWsYoPPiz7JxrgDXDQDMHLRm7LLz7EIwSj2JBqoXKRCG8Drl28/0H/9pRpYQ7Jj7LTwSQ/8ibpt9E0WtvyL0A3gpTwDFWaXNET2P5DiK4scX8odsF4ckgLT57rAp9YNRPIqYN+5zgUsegeCKliu26zl/kqbMpuN2Ro/w4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2a17f3217aso734903666b.2;
        Wed, 14 Feb 2024 08:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929372; x=1708534172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj0aHWVxiSiwAuNoveJS6T0pPxpFlEgeoZZflLMqL+4=;
        b=ZOUTriPAZwKvpC39ZcRNxaA5cNZoOS1lgdJbiAlvS6RJtM8y2Q0jwEqlyOAZ0DwA4v
         ExIcVWVpJv/uceiCTkplIzOsO4F2GJod6A7YHXho9qWvlFMN98yeZ78TRAoUzTfOplAK
         9FbB8ZXnZzWyVmP6FhXmFCX8hAz8hP/UBogOz7EM2pg5strEhGOtuTGeI84ZjuLjQ/56
         qZ+Ty/8Nw5H5JfjiKcNYRA3GrMcGizoVjC8ZkkSBCqVH8iCPpNR/IMLnEKv7l16FXExf
         V6Notx8DyY43yIArT1LpQlWZ3+qlSeISUKXSn3+00BFgG8PiZQs5ebQGHwN1ELaZ3zKR
         BQkw==
X-Forwarded-Encrypted: i=1; AJvYcCUZCBsJocpbbItQqaAP0hWdVJwKj3YurbwfMsfQmaZV6ZL+9ylNGxm7yL0ypVsuQCJ4NRSppLgJWjOrysAHaOvd1+xKj2oS6iZWfwmTzH5fS1in38RGWDxyUnTIeokENs/zYKzLf6Sr2LdpyyD9nAQCQJOT16qIUXbjnBWIWFsWxqpx0EKxt3X7
X-Gm-Message-State: AOJu0YzVpbgzawvXhY/EhK8yOCarUu/ZuHioJHkTVh+hZtsXNBRDBm7K
	f62/k5tak8C7JkNIsBopxMznfRrrnRTcvX15VrlDVtSNe3G4t6bkDFW8dyrq
X-Google-Smtp-Source: AGHT+IHp+Q5QUi8vR/HrB271uoeEA4LI4MRHiC8PFYlclXVxsFY2+xfCdUHZUB41MAfUEZgGWl43Ew==
X-Received: by 2002:a17:906:d93c:b0:a3d:605b:f54 with SMTP id rn28-20020a170906d93c00b00a3d605b0f54mr1168319ejb.58.1707929371543;
        Wed, 14 Feb 2024 08:49:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhELNXmdDEzlFnJsSi+DfnFs0gk+OMs8JD8oJkHtx6EBWitz8GRAmwxjGHtIvUQKsSkj1X59CEAzlNt57dPS8jARjUmWMcVXlZZIbuP467Swv5+GJMrjES9YQkIAhK7SRdmgh6qb5NQR05wU6x/OyF6HECu8XUeIBmzdCjbCVQDzxK1J2CuacYQuYbN7Obx2+dMWUy/6NA892geynj5swVYI+eS3mmQtOQXbpy7BaZMW5hFn1olEO3bDV82gTmPdtXfwitZQu4GFUgPyMhteOUr8wjTgk53H5IYRenr5GJTjXkU4fJfXxRMKmPg8RVwK18NqU6XQ348WjTlvaF7EL9sX9iaeo8T2LQ5EDy4je+ZIt7fjQVktkLZrQ9JuVeXclT1YxqPujTVyIluwO5C/cZ/ZupbuRLoSO/P9em80Wh6D7PUv0PD6INxY4wD+CpxnrPPNzQ5Phlb28ZSv538vKJhn+c8Ueb9xZWxBmNWa/YUiVO7aswnzf+EVP8J9DABneqqjI9qY/X+R7w/QazB3QC7BlMlTp2AmE63dSZR5pa8nYXnn01
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a3cf5450b28sm1995938ejc.189.2024.02.14.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:49:31 -0800 (PST)
Date: Wed, 14 Feb 2024 08:49:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	pabeni@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
Message-ID: <ZczvGJ90L7689F6J@gmail.com>
References: <20240202165315.2506384-1-leitao@debian.org>
 <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
 <20240213100457.6648a8e0@kernel.org>
 <ZczSEBFtq6E6APUJ@gmail.com>
 <CANn89iJH5jpvBCw8csGux9U10HwM+ewnL1A7udBi6uwAX6VBYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJH5jpvBCw8csGux9U10HwM+ewnL1A7udBi6uwAX6VBYA@mail.gmail.com>

On Wed, Feb 14, 2024 at 04:41:36PM +0100, Eric Dumazet wrote:
> On Wed, Feb 14, 2024 at 3:45 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > On Tue, Feb 13, 2024 at 10:04:57AM -0800, Jakub Kicinski wrote:
> > > On Tue, 13 Feb 2024 14:57:49 +0100 Eric Dumazet wrote:
> > > > Please note that adding other sysfs entries is expensive for workloads
> > > > creating/deleting netdev and netns often.
> > > >
> > > > I _think_ we should find a way for not creating
> > > > /sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  directory
> > > > and files
> > > > for non BQL enabled devices (like loopback !)
> > >
> > > We should try, see if anyone screams. We could use IFF_NO_QUEUE, and
> > > NETIF_F_LLTX as a proxy for "device doesn't have a real queue so BQL
> > > would be pointless"? Obviously better to annotate the drivers which
> > > do have BQL support, but there's >50 of them on a quick count..
> >
> > Let me make sure I understand the suggestion above. We want to disable
> > BQL completely for devices that has dev->features & NETIF_F_LLTX or
> > dev->priv_flags & IFF_NO_QUEUE, right?
> >
> > Maybe we can add a ->enabled field in struct dql, and set it according
> > to the features above. Then we can created the sysfs and process the dql
> > operations based on that field. This should avoid some unnecessary calls
> > also, if we are not display sysfs.
> >
> > Here is a very simple PoC to represent what I had in mind. Am I in the
> > right direction?
> 
> No, this was really about sysfs entries (aka dql_group)
> 
> Partial patch would be:

That is simpler than what I imagined. Thanks!

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index a09d507c5b03d24a829bf7af0b7cf1e6a0bdb65a..094e3b2d78cca40d810b2fa3bd4393d22b30e6ad
> 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1709,9 +1709,11 @@ static int netdev_queue_add_kobject(struct
> net_device *dev, int index)
>                 goto err;
> 
>  #ifdef CONFIG_BQL
> -       error = sysfs_create_group(kobj, &dql_group);
> -       if (error)
> -               goto err;
> +       if (netdev_uses_bql(dev)) {

for netdev_uses_bql(), would it be similar to what I proposed in the
previous message? Let me copy it here.

	static bool netdev_uses_bql(struct net_device *dev)
	{
	       if (dev->features & NETIF_F_LLTX ||
		   dev->priv_flags & IFF_NO_QUEUE)
		       return false;

	       return true;
	}

Thanks

