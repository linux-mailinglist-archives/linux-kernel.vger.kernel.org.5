Return-Path: <linux-kernel+bounces-25898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E1882D7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F131C2188A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191841E523;
	Mon, 15 Jan 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm6pMYfA"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9867E54C;
	Mon, 15 Jan 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so9692693e87.3;
        Mon, 15 Jan 2024 02:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705315596; x=1705920396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=juHn9YHI5BJWefTaNGWxRPjBm81wcum9lPgwzlsZd+A=;
        b=dm6pMYfArz8YBARa7ZXOsnpRUETZY5GnxrfQn4qdWX4gnrQF/QrdfsUe85loApPHph
         x6qVWOOGWI1t7VVAO551NxY2x3Qp02a7XyfcIgYF+8eWy2NgdwDgfNMxJ4bOfnVnb+G6
         P9TQlXsCnlE5XhqKok2/JyfJN7ElG3EtR3reWjLCGm+yJ/mQYdbZMk2Gwso8x0OZ4k+s
         VD3pEhzlciRV4NCI/FjBhGlY1qBD6qOhikjcxKSHyyQGQktjNB8dU7pnGSz5X3TOP568
         NqQbIbQDf9fFLPZCppYqA1l7dXKFHqo8BuSjrEHbyAzHpf9BgBLMSedq+W3ebt2zdLly
         SQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705315596; x=1705920396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juHn9YHI5BJWefTaNGWxRPjBm81wcum9lPgwzlsZd+A=;
        b=luwhUUzx8PlLE0/Z465s6N/D+8PU9rHh+vy0d1H9o/UaVHVd8tu5DvrconLmXoGqAg
         2yE8iFl8Mm7t1uagLK6FfSUYzq84sBlgSHEbOgVRrpq95JKIfSBK+h6w8a+kgyl4wKeO
         VZdyLfL7hZdKlLFGUPxoDy01WO4HjHvcdMSw9dgOWaxqqrAMpnLfflML0c9WmU+Blktz
         alVk2bR5ltLrdllxHKEqUtzqX4WljD7t3CM9pLIh4VzXh7RXO5nqjDgBc5oYmtIfawFL
         PJlOdNEb6nhPymcj/s1ltg0VjgKR1qbNPWeJ+1OsfFskT/3hr5/hSEpNrGoXE7Fc195B
         n3XQ==
X-Gm-Message-State: AOJu0YyM5ojL+jVPZJBtYiNv2Pkh7WfKUZPBLGcCYciDTdcd0PlmHIo/
	q49+4gGg+Jy9quQtljRHjOcyEHIbh74=
X-Google-Smtp-Source: AGHT+IFtKO2sD1f5WuvFhkT1INzIL0OFjBllVqZjxhLrAjosY4V7F+6aksjKuOw6jXcTA2bZXJluLQ==
X-Received: by 2002:ac2:520f:0:b0:50e:78dd:ef53 with SMTP id a15-20020ac2520f000000b0050e78ddef53mr1372411lfl.89.1705315595589;
        Mon, 15 Jan 2024 02:46:35 -0800 (PST)
Received: from pc636 (host-90-233-221-202.mobileonline.telia.com. [90.233.221.202])
        by smtp.gmail.com with ESMTPSA id bi40-20020a0565120ea800b0050ea9d5b667sm1399048lfb.278.2024.01.15.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:46:35 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 15 Jan 2024 11:46:32 +0100
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 4/4] rcu: Support direct wake-up of synchronize_rcu()
 users
Message-ID: <ZaUNCJyYREsw7O3h@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-5-urezki@gmail.com>
 <CALm+0cUM=5bg0eKQ4D-mm7ZaAnQbf+2NjetUYnqHOLq5uR0w5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUM=5bg0eKQ4D-mm7ZaAnQbf+2NjetUYnqHOLq5uR0w5g@mail.gmail.com>

Hello, Zqiang.

> >
> >         // concurrent sr_normal_gp_cleanup work might observe this update.
> >         smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >         ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> >
> > -       if (wait_tail)
> > +       if (wait_tail->next)
> >                 queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> >
> 
> I'm testing these patches :) , one question is as follows:
> Can we use (WQ_MEM_RECLAIM | WQ_HIGHPR)type of workqueue to perform
> wake-up actions? avoid kworker creation failure under memory pressure, causing
> the wake-up action to be delayed.
> 
I do not have any objections in not doing that, so we can add.

Thank for testing this!

--
Uladzislau Rezki

