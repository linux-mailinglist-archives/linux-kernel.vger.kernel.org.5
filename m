Return-Path: <linux-kernel+bounces-66957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27164856413
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D747428935E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9912FF7C;
	Thu, 15 Feb 2024 13:11:33 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9712DD94;
	Thu, 15 Feb 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002693; cv=none; b=PaXZfiYwJpH7LVami/yACRAsi7r1t3y1J2LcijQt70Ed7JvYWMx9uDKkzHrz6tUKI2by/nXIINuChOMbdXpzj+scvEnEDe2K/wwlktSDVF2QE9162q4mX4ZEYsW8XI90ZoCWuvdn9pExTF70nq17+FzsT9pii264exSHzv9HoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002693; c=relaxed/simple;
	bh=tbB/4QiOlvvPtd2y3olhwseCsrt3uAhoP4iM4iRqcyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYF0D7VjH58xbVcKO4gzmac4ox7MCwqm1cATFsEOklNDDwjUhd8z3wCBBXTYei10ohAnnpyYkzHAXaXyT3pu6bTSZDgW5KUn3Qb2L+wqDbKWofK+eTEU6sBdeTYWmp/auSILl+RzUlE6/9xDrdJOx9opcyVGJGGK0YwZBTHssXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a271a28aeb4so107763566b.2;
        Thu, 15 Feb 2024 05:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002689; x=1708607489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTN0V/irgSTue4IosxzP+3wCkLDzPMCaW2GK0otDsjo=;
        b=NobMHdlu5d40W5tgHYVqPqv/mS0Orj+4cGn8RhXMIqZwHHjcKeF5U573SEI+LrxlyL
         l/X1jp+TQ0s+qWBiQzF46dOzEshwkTwJxyVsqrNgWwX42Bv2hkE52wc8EZnRjDqgv/zB
         33GKUafb3mCIVa5Au9VrghoFYbBtAGQ6L81gOLQQ1Mi7Ndne/7+6f92taHqo1cCWk6Wc
         rIwrPwKmsg8vPhd16c2f1jYTpsr/NDkv4XhWeKWph2sk4C3DLbPI2dp1uSlkeVqX4tG6
         icRsMI6dWyh2XxUVyjpmTkOab7U3LxOGbdL9my5vQSL5yYC2QIKIKsySBS6mtbfo4hRH
         1RQg==
X-Forwarded-Encrypted: i=1; AJvYcCVnngBo7aw8jzBOcacauzZo/4sY6RKc0IPZofBKrLFn94RS4EyQk/Frn2YVcpDs44woopt6qUNU4TomS3Mn6xOltx2ZQVztGsB/qdqE+qYgYZHpoBmqpRxB0DZWS29D7ywa7nZA
X-Gm-Message-State: AOJu0Yw3D6RpyIXMphz+uOe4YC8UGkzyqrbT+Ev3c5jbttK1UfR8oT7w
	KsynNkoGnA6kBeA7opFWisJd+w7QFN/lT51u/acLZK/Z2fFJs9QQ
X-Google-Smtp-Source: AGHT+IHbpNnN/8FhmZM3cnRZi1DrVy8wnMYoOX5sIcEwDpGjmGH3ys3F1rdDDXvWvGlRXQik1NcPIg==
X-Received: by 2002:a17:906:b2ca:b0:a3d:8f2b:528d with SMTP id cf10-20020a170906b2ca00b00a3d8f2b528dmr1395220ejb.62.1708002689117;
        Thu, 15 Feb 2024 05:11:29 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id oq25-20020a170906cc9900b00a3cd41b3c19sm522822ejb.199.2024.02.15.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:11:28 -0800 (PST)
Date: Thu, 15 Feb 2024 05:11:26 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, Johannes Berg <johannes.berg@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [PATCH net-next] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <Zc4NfrT3qEOMPAPP@gmail.com>
References: <20240215112729.1778958-1-leitao@debian.org>
 <CANn89iJsdvjsbcYv_Re5HHvmY=P7Sq6ewV_sdQuWTAFtOPoKbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJsdvjsbcYv_Re5HHvmY=P7Sq6ewV_sdQuWTAFtOPoKbw@mail.gmail.com>

On Thu, Feb 15, 2024 at 01:47:47PM +0100, Eric Dumazet wrote:
> On Thu, Feb 15, 2024 at 12:28 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Creation of sysfs entries is expensive, mainly for workloads that
> > constantly creates netdev and netns often.
> >
> > Do not create BQL sysfs entries for devices that don't need,
> > basically those that do not have a real queue, i.e, devices that has
> > NETIF_F_LLTX and IFF_NO_QUEUE, such as `lo` interface.
> >
> > This will remove the /sys/class/net/eth0/queues/tx-X/byte_queue_limits/
> > directory for these devices.
> >
> > In the example below, eth0 has the `byte_queue_limits` directory but not
> > `lo`.
> >
> >         # ls /sys/class/net/lo/queues/tx-0/
> >         traffic_class  tx_maxrate  tx_timeout  xps_cpus  xps_rxqs
> >
> >         # ls /sys/class/net/eth0/queues/tx-0/byte_queue_limits/
> >         hold_time  inflight  limit  limit_max  limit_min
> >
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/core/net-sysfs.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index a09d507c5b03..c79bc11a0347 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -1417,6 +1417,15 @@ static ssize_t bql_show_inflight(struct netdev_queue *queue,
> >         return sysfs_emit(buf, "%u\n", dql->num_queued - dql->num_completed);
> >  }
> >
> > +static bool netdev_uses_bql(struct net_device *dev)
> 
>   const struct net_device *dev

Thanks. I will update and incorporate it in a v2 (that I am planning to
send tomorrow).

