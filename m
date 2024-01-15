Return-Path: <linux-kernel+bounces-25956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2882D8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A7D282464
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961062C69E;
	Mon, 15 Jan 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPWzZQFH"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818B2C695;
	Mon, 15 Jan 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd8bd6ce1bso42132911fa.1;
        Mon, 15 Jan 2024 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705320886; x=1705925686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bi4Uj5858V6ni9HWJRDgfoHLGkgl98d9toR5WWB7mEY=;
        b=IPWzZQFHyY+nqLEag0nORJMqYA/bm2u6HQDpSUi146r9iG6TU/NDjv/u3LHGby8AiE
         z60t8xylsZ0NjkytHD01MXqJRfQSRq/qOqppCKTeLlK5+UZYkmt7ZP+KO8iEJvHWCUCQ
         BiCS7s8gHt6LphkpRp8mbx7NjfWnE65AHh7OWD26+Zzd4MCug+gjhvYQZ1X6ktkZh0ZP
         OvMR/nup6bSez683SvaOmMjE1/sRpwvIUjcUtkjbOWCeeZFvljLRJsYlegnNUdZP9p5f
         G7HuQs7y9A7TowuX3EFK7naNOfr7DhjD5+ifdVqIVmldjDEFgjVib5H33Nzp8MfZuh8T
         yq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705320886; x=1705925686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi4Uj5858V6ni9HWJRDgfoHLGkgl98d9toR5WWB7mEY=;
        b=vpKSxYTeNl27OoYJks+H+UB8ekBSgMZRhtBHqpOEPiEvkUBF7iLO3GnzynVh5lpGpy
         rKDxjEjlyXibHnYCtPpl+Id6mEY/wP3f6aLj32Az+X4H2gJ6tHI4WNNRdHZF7q+NBAqC
         IGFGv+3kfiN+RjfjV7ps5NAU2vg4LtL010J5NffJGpS/4tZPqp9EVbDY8284/MoELRZD
         ZdDemDieRUrsLbXNsjlBS1nEa2uMkGZFSVuzk3D0tBWMBH0MMGcu70GDHl24AdhGDx/k
         iqaQDYttp5w+aicwECOvkjBdnDTuARESEIYdtbJJaLIjE4hevsbnGmIe4iIOoseWWtYA
         uM3A==
X-Gm-Message-State: AOJu0YzxcaDOlVzVwASPK5IcW8xzF4oybvT947i1K2Cq1pCFw60I+mlf
	bvzNy4UPaFFJj7FGy07O9ahb1huM3LY=
X-Google-Smtp-Source: AGHT+IFQ+zqKbiT42sn0c5ASgJ30jOaTuPieb+Xk5W186fMGU2/QmYtnDJh9NESMJ9zdjuyPwDZCUw==
X-Received: by 2002:a2e:3e19:0:b0:2cd:ce2:496e with SMTP id l25-20020a2e3e19000000b002cd0ce2496emr1519246lja.37.1705320886141;
        Mon, 15 Jan 2024 04:14:46 -0800 (PST)
Received: from pc636 (host-90-233-221-202.mobileonline.telia.com. [90.233.221.202])
        by smtp.gmail.com with ESMTPSA id i19-20020a2ea233000000b002cd057bbf67sm1398055ljm.133.2024.01.15.04.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 04:14:45 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 15 Jan 2024 13:14:43 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 2/4] rcu: Add a trace event for
 synchronize_rcu_normal()
Message-ID: <ZaUhs1ASJUzkiAt6@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-3-urezki@gmail.com>
 <ZaHJLmsoY8OTvQB9@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaHJLmsoY8OTvQB9@localhost.localdomain>

On Sat, Jan 13, 2024 at 12:20:14AM +0100, Frederic Weisbecker wrote:
> Le Thu, Jan 04, 2024 at 05:25:08PM +0100, Uladzislau Rezki (Sony) a écrit :
> > Add an rcu_sr_normal() trace event. It takes three arguments
> > first one is the name of RCU flavour, second one is a user id
> > which triggeres synchronize_rcu_normal() and last one is an
> > event.
> > 
> > There are two traces in the synchronize_rcu_normal(). On entry,
> > when a new request is registered and on exit point when request
> > is completed.
> > 
> > Please note, CONFIG_RCU_TRACE=y is required to activate traces.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/trace/events/rcu.h | 27 +++++++++++++++++++++++++++
> >  kernel/rcu/tree.c          |  7 ++++++-
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 2ef9c719772a..31b3e0d3e65f 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -707,6 +707,33 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
> >  		__entry->rcuname, __entry->p, __entry->nr_records)
> >  );
> >  
> > +/*
> > + * Tracepoint for a normal synchronize_rcu() states. The first argument
> > + * is the RCU flavor, the second argument is a pointer to rcu_head the
> > + * last one is an event.
> > + */
> > +TRACE_EVENT_RCU(rcu_sr_normal,
> 
> Can we call this "synchronize_rcu" instead? So people really know what it's
> about.
> 
I will update it accordingly!

--
Uladzislau Rezki

