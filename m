Return-Path: <linux-kernel+bounces-25907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAA82D7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C706C282407
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9618E00;
	Mon, 15 Jan 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgQ8wfML"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC01E865;
	Mon, 15 Jan 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabd1c701so10387604e87.3;
        Mon, 15 Jan 2024 02:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705316261; x=1705921061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrIEIVQ0TBrRPvuwtl5pM5zpIBQQMtqiH1n/HgWgNXE=;
        b=AgQ8wfMLvbxuGAZWuXvayMu/lOt4Mg5apEt2j6FreqLve93gdLRisRtOvmiYWy8SKX
         xmmrQ7qb4Ix1V4JfubGAm0arcsKh1/RQ0j0vzk7Ez67dTbMRvDnxORo30ehl2VBjTHop
         vUGj8wDC0lc+7vk3pkul8Stv9VHF1tVDzds+W3uIfBdTyhdWiaSc2DAek/CS2WuSPGRY
         ys19cy2ceruNm9GTKTN7KQkqAXf0BzuPrjWBSd3N/tdyqHM3KwAJHlvyW4VV/Okt+Xgv
         giPmVn2F6aHa60tPqU4msw6NXd2l43ICsLfwbfzhe+GWPxZI9pzfSbDQtUW4Pocl0ZBq
         kjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705316261; x=1705921061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrIEIVQ0TBrRPvuwtl5pM5zpIBQQMtqiH1n/HgWgNXE=;
        b=iL8h2yALHDyqJDfcY6MRL1AgGI9w6kPABLZiHMR1aQ+Fa1En0RM+FUBhsOGzlpA+DC
         cZyY8FQ68XK84sZwwyI5tvezDn2NxKONxer3Cvii6XMV8lp0Gg5FycsvLVJSp2Frl0u3
         f7jdVWYAgOnvbuodxWAanMdkLUkh3Ijngc8jMG+bBZKXDXCPOLaPEseCds092tplOMPV
         tCuk52q+rvx5X6AZRDi/kUBClRZ7dJWTXLEjVwEDxKuyOuogU115CFhD+eTLCyagraY9
         psHa/oh4Q/d9sJCmqicCJ9IBLrINlfUHcVvchtgmxEA1URoC/pvX6WuRBnzIglvpM7D4
         2d0Q==
X-Gm-Message-State: AOJu0Yzowt417OqNU8jhG3I+qAvoF37sOVsTMarKuDmR2IErjOd7dQOw
	XqapiMQ+ioipa3SBlxkuUto=
X-Google-Smtp-Source: AGHT+IEa0v5VEciA8p40cqffWLy5aX9mFUxDYt5fIXN7BFhA3Lpz818bnUfp+4fe2fFbd348aoRTvw==
X-Received: by 2002:a05:6512:2247:b0:50e:a15c:6b61 with SMTP id i7-20020a056512224700b0050ea15c6b61mr2696333lfu.116.1705316261487;
        Mon, 15 Jan 2024 02:57:41 -0800 (PST)
Received: from pc636 (host-90-233-221-202.mobileonline.telia.com. [90.233.221.202])
        by smtp.gmail.com with ESMTPSA id q12-20020ac24a6c000000b0050e7e304238sm1440881lfp.19.2024.01.15.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:57:41 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 15 Jan 2024 11:57:39 +0100
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: Z qiang <qiang.zhang1211@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 4/4] rcu: Support direct wake-up of synchronize_rcu()
 users
Message-ID: <ZaUPo97uzZlGkNdY@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-5-urezki@gmail.com>
 <CALm+0cUM=5bg0eKQ4D-mm7ZaAnQbf+2NjetUYnqHOLq5uR0w5g@mail.gmail.com>
 <ZaUNCJyYREsw7O3h@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaUNCJyYREsw7O3h@pc636>

> Hello, Zqiang.
> 
> > >
> > >         // concurrent sr_normal_gp_cleanup work might observe this update.
> > >         smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > >         ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> > >
> > > -       if (wait_tail)
> > > +       if (wait_tail->next)
> > >                 queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> > >
> > 
> > I'm testing these patches :) , one question is as follows:
> > Can we use (WQ_MEM_RECLAIM | WQ_HIGHPR)type of workqueue to perform
> > wake-up actions? avoid kworker creation failure under memory pressure, causing
> > the wake-up action to be delayed.
> > 
> I do not have any objections in not doing that, so we can add.
> 
> Thank for testing this!
> 
I forgot to ask, is your testing simulates a low memory condition so
you see the failure you refer to? Or it is just a possible scenario?

Thanks!

--
Uladzislau Rezki


