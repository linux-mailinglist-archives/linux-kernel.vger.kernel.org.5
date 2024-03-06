Return-Path: <linux-kernel+bounces-93860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25088735F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD63285754
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A417FBBB;
	Wed,  6 Mar 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1a20u7C"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D722D7B8;
	Wed,  6 Mar 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726194; cv=none; b=C+EtAlfy3xYk3H3i8FBMoGwe0l9V6VIIlONmIpK9u54+En8x+bOHcb9OkAxz68aFnfXMjDkBFBNs8zDg+ug6kvPU/suNJu+2gFnjSbeksaZt9e0BcSAYneDVF4moRR91elb3YTkwou8VfGij+ckbgiWPJROHbzPGeIhvyWP1xaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726194; c=relaxed/simple;
	bh=UrapeRk4i8gmM86Amitnr2+Q6gX/VbewF7zIepiz7V0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn8HoYw1Td/N3Yne7bh45hwclctSWdIdTF2cUueBxE4uaJHMinsxTCGmM2mlbE7KtXy8aT4f0vg75jJPK2GVxBsvs0wxYHpR4mPqU8YJAvrV6T0GnLP+tI7KajQgAYe+r0MWjbup5z3isUI2h0JpG8T+58lXJauh4Z4Bit6E7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1a20u7C; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso5912833e87.1;
        Wed, 06 Mar 2024 03:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709726191; x=1710330991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NeF0Ei8m8d4A5gmCE/VG9m7laohctkjiFtIiDyy/jY8=;
        b=g1a20u7CzsbxBLJog6hqstP9wSrAckNkjnOF/iI3TmJa+xYi4Dxf9WUI3NM63DXNgy
         N+9W46jzYn/yE96LTMXkzb1MvNBadHQwo8dD2GP/O+ZIByX0EN6r8c9YXivE8BZGhOp5
         5+1coLV4ty2RTrygiJXUZdNQ1w4nnHvB2eSk33om5ybWWiT5zfzQ9pylA+84YGfFy9ng
         jSLZYSERTJrkKcfW9Uh5cnW9qZASzCepaVdW2jAkHg7MYIE6WcvjER3lXvssRv08Zx9V
         vSVokmsKb1o7xAflqElHVT7uMxMeSWGDeTZH5VoSH7tFT4UNPdAP/OIrjc4Yq96rmFOZ
         kMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726191; x=1710330991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeF0Ei8m8d4A5gmCE/VG9m7laohctkjiFtIiDyy/jY8=;
        b=dk9JVDJMa8hVb51CmhTLKFge5DZkIsX31AofYwSClTkTAML8mcoeFCxEakwjbzju3X
         KCc99QJ1f0+qCW86PpMWaNJMPz8f4KCx7eqPk27WXPflxVh53R2HFOWXxt9GvVfkvM94
         n9cM9WrpmWHxqjv0jx/1av1UbOJsd8uA8v0pCkDKOBowEmq33iObXpgZ8zhTIsimFWO6
         WecyEDlFTOD5EE2th7i0CjGrq4Zr16kuW70AKAi6FZqSXctdf6nTzKugrC8E0QO/HzD9
         KE0GG/tqtAWGxdGue7xbuc1hTchkzo54Sc+JACEmGfLurawBGypiGkOFQ0EEi5nR/sNd
         5Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCX6XCHfF8p5sR0oztQ3gqQ9i2GjksZUck46CfnrPHAUL6eOhrqgO3SwOWpKHVQh8QlsHdeAcjKNHJfHgfiWyH4gwOVZN9/U/bWQNxx1obsWTGnKRrmJWAglm/SwRAl3EGlV
X-Gm-Message-State: AOJu0Yzuf3YnOuiOMgEQWBMH4bnTTvJqbj1BJxE83uJDRpJouz+IIIwc
	lI9dwv7BN5JYiC+iWWnkOdprmL+NULpj9AXMWDdnMxiPDEr+lHFQ
X-Google-Smtp-Source: AGHT+IE5EdoAhOmujbMVYbxHEmDr76Ukr3iG9OZB+oZHA66WY7PakFMZ2YN4KlQ6EOYiGzQhttTq7Q==
X-Received: by 2002:a19:690b:0:b0:513:5bdb:10f8 with SMTP id e11-20020a19690b000000b005135bdb10f8mr1113142lfc.48.1709726190957;
        Wed, 06 Mar 2024 03:56:30 -0800 (PST)
Received: from pc636 (host-90-235-1-20.mobileonline.telia.com. [90.235.1.20])
        by smtp.gmail.com with ESMTPSA id u26-20020ac25bda000000b005133b2d1acasm1855509lfn.50.2024.03.06.03.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:56:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 6 Mar 2024 12:56:28 +0100
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 2/2] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
Message-ID: <ZehZ7Ef3DW2mT9fc@pc636>
References: <20240305195720.42687-1-urezki@gmail.com>
 <20240305195720.42687-2-urezki@gmail.com>
 <CALm+0cWiOfKR=Gci0dj=z4gT4vSbZ=ZzMfo+CxLZCFQzL1bjfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cWiOfKR=Gci0dj=z4gT4vSbZ=ZzMfo+CxLZCFQzL1bjfQ@mail.gmail.com>

On Wed, Mar 06, 2024 at 10:15:44AM +0800, Z qiang wrote:
> >
> > synchronize_rcu() users have to be processed regardless
> > of memory pressure so our private WQ needs to have at least
> > one execution context what WQ_MEM_RECLAIM flag guarantees.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 475647620b12..59881a68dd26 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1581,6 +1581,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >  /* Disabled by default. */
> >  static int rcu_normal_wake_from_gp;
> >  module_param(rcu_normal_wake_from_gp, int, 0644);
> > +static struct workqueue_struct *sync_wq;
> >
> >  static void rcu_sr_normal_complete(struct llist_node *node)
> >  {
> > @@ -1679,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup(void)
> >          * of outstanding users(if still left) and releasing wait-heads
> >          * added by rcu_sr_normal_gp_init() call.
> >          */
> > -       queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> > +       queue_work(sync_wq, &rcu_state.srs_cleanup_work);
> >  }
> >
> >  /*
> > @@ -5584,6 +5585,9 @@ void __init rcu_init(void)
> >         rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
> >         WARN_ON(!rcu_gp_wq);
> >
> > +       sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> 
> Why was WQ_HIGHPRI removed?
> 
I would like to check perf. figures with it and send out it as a
separate patch if it is worth it.

--
Uladzislau Rezki

