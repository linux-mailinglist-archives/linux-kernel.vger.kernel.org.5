Return-Path: <linux-kernel+bounces-95517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD1874EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BAD1C22449
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A6312AADD;
	Thu,  7 Mar 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfdLttA8"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC612A167;
	Thu,  7 Mar 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813817; cv=none; b=QHki6XAIHXai2mTYIUvCOZNr7qV1cNNsEGo88DCsSkYqkr7798fY2QenWrnwPnoB0W9BaiiejHzUYIVr9JoT+givW2tHwnyHq178/JlKRHW7yt6SD5dsnT435YFcwZh1YdfWsw87e8iFteFXQx4o3qGmtn2RmK8GmKOcNaqhJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813817; c=relaxed/simple;
	bh=iRKY8wKUk68xCXhEXnEYk1hAgKsjfXk0yjfRyq6eKJw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edPuU340BJcbgfWPOsfGRSdy3bnr7r8MVXOjpCPhp3iaJRaLmrdPt1ddJEOVDhi0pjmJwJVwPzH6JC+CxnjynkK3823YEH992DvYtZwTUwa/sl0TXrkuEICQ5QAetfE5iWMlANUj5BFiIdc4c/vhFogZ0Q1YpZ3wDO+J86tAqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfdLttA8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51380c106d9so541248e87.3;
        Thu, 07 Mar 2024 04:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709813813; x=1710418613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANChfcOUAyC1oxqb32wfMbdGmCMLOuk7/FLsEGcXcAc=;
        b=IfdLttA8P30s+BpoJ6bb35XH+MPnJnCz5mk4U0e1qM3GzrjKQEnxw/EgUxzkt+yqJM
         BEeIVyDbLyxFyhu9COJzKhjVx0pOJEsVy1Lp67ta5YQO4Eesq6cSIbVyQ07/4N475EKm
         wVyJKrsp88C0VZJLTG++V4ekiLF8umoXGFWrdL28uHhTLVArqSIgbvX4UR36OlKk4HSi
         f6zBpLvQ56SWhnICJ2wWtvqTT2pacz1834BkRLs5wfg4X8vjYOr1Jx7RAa+LJKF5E+kC
         XFJ2ykHkbblfjUMSaEp9cEyP6zAg3K+OPd+Auys0+maFJg9akSm8I6Hz7cag7RX9cJSb
         e34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813813; x=1710418613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANChfcOUAyC1oxqb32wfMbdGmCMLOuk7/FLsEGcXcAc=;
        b=J0Ha2ZHVrPZJm7TzCGz1MehhStBFBeV2R+1GfQWa71a2y4oT+dhulOSIaIsItWmrJc
         WF2XwwXuCYib36j8qWg+q6HsvoP3pc4cX/3Rheuhtfpm9aMV2a2X8wsJudupPQN4JGtz
         NtnzqAJxYiW6jrXisJPprSpXOghda4y+4Di8UTnDGOQvLGoH8XokR5KZdEi/78mX/Ylu
         8BS2SILfFP16jILkZtJcy7uVLrcLDZxfWCjiuqk9HMPYz7GSNo5mEFrHG35vb+1EOz1w
         XngxIW30dXt9OAsE5LhwGSASEdgfcr/NHXoohm+XbBxEfWYvQ74WlELZ6tgUo+FMOVZW
         hc/w==
X-Forwarded-Encrypted: i=1; AJvYcCWWlOYO6gta9ZB3xbyUo6iTBc6XA31ASntofzKUYbnFjO5i9YzdBU03VT4QK2LJMDVYEzCFHe76qcFkKiN0ZnG9YQ4K3gjcjFEZfu+kl6nSWKYkswc/kXEzf3sG0lz7hu45
X-Gm-Message-State: AOJu0YzOdqeev/7iLoTDZV7wC37G5K1DxDNEgEOkPBEOFWCYCUOmT7LX
	M6N2embDfhxcwNSSdGFQyr2aLjHzP7N6F+q/Y4vqYXB1u5086sCc
X-Google-Smtp-Source: AGHT+IG/RiMHXVR2V8E27VB26r9q2Bs5SQecc6B335hPWpfU9UEjaV6P+pTnvMyqSPc/kbiB4/PQPw==
X-Received: by 2002:ac2:4c41:0:b0:513:5cbe:71f5 with SMTP id o1-20020ac24c41000000b005135cbe71f5mr1592920lfk.0.1709813813140;
        Thu, 07 Mar 2024 04:16:53 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id t12-20020a056512208c00b0051349ce52b3sm1640876lfr.15.2024.03.07.04.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:16:52 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Mar 2024 13:16:50 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Z qiang <qiang.zhang1211@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 2/2] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
Message-ID: <ZemwMo1Ca1BQumQ7@pc636>
References: <20240305195720.42687-1-urezki@gmail.com>
 <20240305195720.42687-2-urezki@gmail.com>
 <CALm+0cWiOfKR=Gci0dj=z4gT4vSbZ=ZzMfo+CxLZCFQzL1bjfQ@mail.gmail.com>
 <ZehZ7Ef3DW2mT9fc@pc636>
 <ae0475d7-fcfa-4d6f-9bb0-03479e6bf83b@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae0475d7-fcfa-4d6f-9bb0-03479e6bf83b@joelfernandes.org>

On Wed, Mar 06, 2024 at 12:57:25PM -0500, Joel Fernandes wrote:
> 
> 
> On 3/6/2024 6:56 AM, Uladzislau Rezki wrote:
> > On Wed, Mar 06, 2024 at 10:15:44AM +0800, Z qiang wrote:
> >>>
> >>> synchronize_rcu() users have to be processed regardless
> >>> of memory pressure so our private WQ needs to have at least
> >>> one execution context what WQ_MEM_RECLAIM flag guarantees.
> >>>
> >>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>> ---
> >>>  kernel/rcu/tree.c | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>> index 475647620b12..59881a68dd26 100644
> >>> --- a/kernel/rcu/tree.c
> >>> +++ b/kernel/rcu/tree.c
> >>> @@ -1581,6 +1581,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >>>  /* Disabled by default. */
> >>>  static int rcu_normal_wake_from_gp;
> >>>  module_param(rcu_normal_wake_from_gp, int, 0644);
> >>> +static struct workqueue_struct *sync_wq;
> >>>
> >>>  static void rcu_sr_normal_complete(struct llist_node *node)
> >>>  {
> >>> @@ -1679,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>          * of outstanding users(if still left) and releasing wait-heads
> >>>          * added by rcu_sr_normal_gp_init() call.
> >>>          */
> >>> -       queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> >>> +       queue_work(sync_wq, &rcu_state.srs_cleanup_work);
> >>>  }
> >>>
> >>>  /*
> >>> @@ -5584,6 +5585,9 @@ void __init rcu_init(void)
> >>>         rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
> >>>         WARN_ON(!rcu_gp_wq);
> >>>
> >>> +       sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> >>
> >> Why was WQ_HIGHPRI removed?
> >>
> > I would like to check perf. figures with it and send out it as a
> > separate patch if it is worth it.
> 
> I guess one thing to note is that there are also other RCU-related WQ which have
> WQ_MEM_RECLAIM but not WQ_HIGHPRI (such as for expedited RCU, at least some
> configs). So for consistency, this makes sense to me.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org).
> 
Thanks. I will update it with review tag!

--
Uladzislau Rezki

