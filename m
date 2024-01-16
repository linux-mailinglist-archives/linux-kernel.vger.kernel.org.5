Return-Path: <linux-kernel+bounces-27035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5A82E972
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220921F238C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082E10A17;
	Tue, 16 Jan 2024 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amf2rWhL"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7910A01;
	Tue, 16 Jan 2024 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28e718874e1so228763a91.0;
        Mon, 15 Jan 2024 22:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705385986; x=1705990786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BtPgpHD29V6EL14MEPmiAO57qgLbXU9vw9VJiILh/Cg=;
        b=amf2rWhLTgL/XKyDzii4NU4e4sKIrejPY61gWsw9PMf+GbKCf8gJSSomUQq9wLAEiQ
         R9+L7v/0E2uaHTZJICAgW4vJp/CY0tJBolpeqdS6fipCs4s8pVzhGo3bAOZsELL+7SBh
         T4LsBT9lgvy2eDmvht6H9qOte3btkrpWWw/yv2R/bcRtIXJbZZTpeHYBZDXnQS9RdVsQ
         3IL7/zSNlapsITxUmi2MZab+Y11wSOVBGNA8tuRSbmdYF1TlJeOUtFEYPr4L5pp2vl4X
         qO0i6zMLn9miw21BCOEQya11FB3LB4cfQfZL62FZUCvehMSoMcq4+2EKeYyyRISOEBjK
         TVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705385986; x=1705990786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtPgpHD29V6EL14MEPmiAO57qgLbXU9vw9VJiILh/Cg=;
        b=eTX8SUFaixQb9SbL0zk6fe23/eqxHXkw1zwdlJjGvQ1QnC5DiLF1EIaz/v4dyAI2AC
         gevFqTgwIGWyrsFk+0AJwbECoGXSoZ/q0u5/XSHquaw+XilDFFBEOmZxpnWkjoFwUEhr
         6MpYd1NdAgDtH3ZmBUAGz9nSzVgMj63AaGtX0WBex/5YiEbrRp9IS84TMr0xGCL6EQgN
         HqOOJ87/vQhJkdo8DYhUi9SAcnZGVTpw/bYQjWj1rjwvgyt6s1DOixqxvnDCzTjv1NEX
         4mELJTglA552/cHGSfyhD4QbusDQIdX3GGzCtCTmiFIXsywdCHarAiQ7NukXkvIVT9C7
         uSeA==
X-Gm-Message-State: AOJu0YwyN0iAiYpCoGq3n++RnPYTiPUPN5Amo//RVaGBeMfNlq3jmLPD
	9HeJL7vUW0A4iCGKYGs9mI7WlFlWYO+AUl+SiIM=
X-Google-Smtp-Source: AGHT+IHmkrNvhKDKFHox3ulCebL+np3+W4JM6eg+SHAB+VouWyI94c7i/NMcdnCogXRsl+VEQRyUj1tISPHk6lzCyDk=
X-Received: by 2002:a17:90a:c797:b0:28b:e57d:9710 with SMTP id
 gn23-20020a17090ac79700b0028be57d9710mr3306050pjb.6.1705385986020; Mon, 15
 Jan 2024 22:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104162510.72773-1-urezki@gmail.com> <20240104162510.72773-5-urezki@gmail.com>
 <CALm+0cUM=5bg0eKQ4D-mm7ZaAnQbf+2NjetUYnqHOLq5uR0w5g@mail.gmail.com>
 <ZaUNCJyYREsw7O3h@pc636> <ZaUPo97uzZlGkNdY@pc636>
In-Reply-To: <ZaUPo97uzZlGkNdY@pc636>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 16 Jan 2024 14:19:34 +0800
Message-ID: <CALm+0cWVJPis4c6VhGviXaHF90+njEVXvOjVZ-COL43dJFgNbw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] rcu: Support direct wake-up of synchronize_rcu() users
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Hillf Danton <hdanton@sina.com>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> > Hello, Zqiang.
> >
> > > >
> > > >         // concurrent sr_normal_gp_cleanup work might observe this update.
> > > >         smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > > >         ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> > > >
> > > > -       if (wait_tail)
> > > > +       if (wait_tail->next)
> > > >                 queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> > > >
> > >
> > > I'm testing these patches :) , one question is as follows:
> > > Can we use (WQ_MEM_RECLAIM | WQ_HIGHPR)type of workqueue to perform
> > > wake-up actions? avoid kworker creation failure under memory pressure, causing
> > > the wake-up action to be delayed.
> > >
> > I do not have any objections in not doing that, so we can add.
> >
> > Thank for testing this!
> >
> I forgot to ask, is your testing simulates a low memory condition so
> you see the failure you refer to? Or it is just a possible scenario?
>

I'm not currently testing this feature in low memory scenarios,  I thought
of this possible scenario.  I will test it in a low memory scenario later and
let you know if it happens :) .

Thanks
Zqiang

>
> Thanks!

>
> --
> Uladzislau Rezki
>

