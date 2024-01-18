Return-Path: <linux-kernel+bounces-29651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5A483114F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C533C285CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949998F52;
	Thu, 18 Jan 2024 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu4use/V"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0768BF6;
	Thu, 18 Jan 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544128; cv=none; b=j3fal/X0CzPWbWNL4Ga9xptRqXkql/AfacCKSTY0aFcFLwByGSHp34PEU4l2VnLO15dC85kLnditsmpMCfzzvbYV6505djz29uO/RZDISTqQpSzYsIsaeycJcIaKQi1HjQM5LiX+i4GfCFLCC7FiZoYcZxRulpV2dZApimY/qVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544128; c=relaxed/simple;
	bh=DmLnccCCoxyQwBpmEDQfi1onFlv4+6SD5xVpXzQjAg0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Description:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To; b=UdXEksJKyOtSV+IQV18UyLhZGa3DoBRcXBBT4wJMyQXjVo9MTHl8Ebz4Gys83cDktCciK/8tzRfew+PtFV2rfzqnYjtUa++VMN4ZZH/Mn7S6Lo4EARvh/lX+HqLhjTZJspRDXtUCSCere7Xngq5Pj64bjg7AYrDVKJuyINbifKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu4use/V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d480c6342dso89068995ad.2;
        Wed, 17 Jan 2024 18:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705544127; x=1706148927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-description:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RlbOMoNm8u1JVd08G+KTTjYjGv5ptqZNhnHGA2jRKvo=;
        b=Wu4use/VGrX3rzucCzoD/ZlG0rj70q0LMOybOwx+2RaDHxsOSmGczNr9mx60qpM9kh
         J03swaX+lrgQHCGJLgmBGa6UonnYCX6lkqVZP4TiqlE3YWhtB5NUNhPwYks4Ytg++bYD
         SESfyle9Mi8ly8yrF6TmSlNgDeS4D1NRdPvAaLk7f49ZA0Nd1RW9mk+zbSLvr9zlfuOA
         uS/XiwwQqXQra/3KAd3/VuNGc2CFWmwdFvHRCL1/GYawinVeQ8+rgOsOLssWKm4Zyxtt
         bngaBBckql7XkNouQ866FTGS3oACNkank+jR28v6qfPAowUAWr/Vl8EvGA5gy1cZBs18
         TmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705544127; x=1706148927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-description:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlbOMoNm8u1JVd08G+KTTjYjGv5ptqZNhnHGA2jRKvo=;
        b=dmkVLlsvk0NSbZMFqx5kVFg5JpY+KsB5BheWT2StjH7zV5HowUM85lxTYw8KuzVQgT
         HYdLsVpM5ir8unx0tx1Fphq3+FdrAWlFaLZ7kRFNvEN3Cxwvet065UOfeUj5qBJBHwkO
         npyVW/VIipafJAGd8K2RxAJiQTSxOnOgQ3jPKF5SkmVacCdLkewhRlGNwV4M2MlER1WF
         W/P/abn4TZBGyUz9M0Xo7LbtVClXaObYyhTbOAwzmWElfia50ny46IgacEnLmgSVof5T
         czEwDGp/IsZzEIthaFN8Ww8AoYXS6hwLOvZvVczcrIPmN2AsDyMjlVtGKGaEnm6ue3bv
         55fw==
X-Gm-Message-State: AOJu0Yyb/iS4u4xRYILmXWF3jQ7jZ9PSDV/5xVea7/Eoq/WCk4oihjy5
	6jj+OP4luGFQT1L1c6CtUGJj6JO+zqDQqBM6mK6QcEd0KKa0wI6x
X-Google-Smtp-Source: AGHT+IEV+yFCqU9E6FVphOhzgk2FRVyfvnc8yOD8KBsFYttVAxG0EkKOf/kaxPWijYQRrzbL0D6xPw==
X-Received: by 2002:a17:902:654e:b0:1d0:acfc:a653 with SMTP id d14-20020a170902654e00b001d0acfca653mr232223pln.84.1705544126886;
        Wed, 17 Jan 2024 18:15:26 -0800 (PST)
Received: from pkf-toy ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709026b0700b001d494f3d9d4sm293022plk.220.2024.01.17.18.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:15:26 -0800 (PST)
Date: Thu, 18 Jan 2024 10:15:08 +0800
From: nai lin <ayano2023th@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
	Li RongQing <lirongqing@baidu.com>,
	David Howells <dhowells@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: fix potential race issue in
 netlink_native_seq_show()
Message-ID: <20240118021508.GA18638@pkf-toy>
References: <20240117083715.7800-1-ayano2023th@gmail.com>
 <CANn89iKjRpfDY=7CVdudHp8hMveqnq4zrQGw_AXhAcnPheOZBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Description: 
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKjRpfDY=7CVdudHp8hMveqnq4zrQGw_AXhAcnPheOZBw@mail.gmail.com>

On Wed, Jan 17, 2024 at 11:28:24AM +0100, Eric Dumazet wrote:
> On Wed, Jan 17, 2024 at 9:38 AM nai lin <ayano2023th@gmail.com> wrote:
> >
> > Access to the nlk group should be protected by netlink_lock_table() like
> > commit <f773608026ee> ("netlink: access nlk groups safely in netlink bind
> > and getname"), otherwise there will be potential race conditions.
> >
> > Signed-off-by: nai lin <ayano2023th@gmail.com>
> 
> OK, I think you forgot to include this tag I suggested earlier to you.
> 
> Fixes: e341694e3eb5 ("netlink: Convert netlink_lookup() to use RCU
> protected hash table")
> 
Sorry I forgot to include fix tag, thank you for pointing out my problem
and thank you very much for your work.
> > ---
> >  net/netlink/af_netlink.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 4ed8ffd58ff3..61ad81fb80f5 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -2693,6 +2693,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
> >                 struct sock *s = v;
> >                 struct netlink_sock *nlk = nlk_sk(s);
> >
> > +               netlink_lock_table();
> 
> netlink_lock_table() is heavy weight, appropriate for contexts where
> we might sleep.
> 
> We could instead use a helper to acquire the lock for a very small period.
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 4ed8ffd58ff375f3fa9f262e6f3b4d1a1aaf2731..c50ca0f5adfb9691e6df37b4ac518b95c2d7908f
> 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1136,6 +1136,18 @@ static int netlink_connect(struct socket *sock,
> struct sockaddr *addr,
>         return err;
>  }
> 
> +static u32 netlink_get_groups_mask(const struct netlink_sock *nlk)
> +{
> +       unsigned long flags;
> +       u32 res;
> +
> +       read_lock_irqsave(&nl_table_lock, flags);
> +       res = nlk->groups ? nlk->groups[0] : 0;
> +       read_unlock_irqrestore(&nl_table_lock, flags);
> +
> +       return res;
> +}
> +
>  static int netlink_getname(struct socket *sock, struct sockaddr *addr,
>                            int peer)
>  {
> @@ -1153,9 +1165,7 @@ static int netlink_getname(struct socket *sock,
> struct sockaddr *addr,
>         } else {
>                 /* Paired with WRITE_ONCE() in netlink_insert() */
>                 nladdr->nl_pid = READ_ONCE(nlk->portid);
> -               netlink_lock_table();
> -               nladdr->nl_groups = nlk->groups ? nlk->groups[0] : 0;
> -               netlink_unlock_table();
> +               nladdr->nl_groups = netlink_get_groups_mask(nlk);
>         }
>         return sizeof(*nladdr);
>  }
> @@ -2697,7 +2707,7 @@ static int netlink_native_seq_show(struct
> seq_file *seq, void *v)
>                            s,
>                            s->sk_protocol,
>                            nlk->portid,
> -                          nlk->groups ? (u32)nlk->groups[0] : 0,
> +                          netlink_get_groups_mask(nlk),
>                            sk_rmem_alloc_get(s),
>                            sk_wmem_alloc_get(s),
>                            READ_ONCE(nlk->cb_running),

