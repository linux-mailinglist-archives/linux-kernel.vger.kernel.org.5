Return-Path: <linux-kernel+bounces-14358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BEA821C10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB021F21B46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D1FBEC;
	Tue,  2 Jan 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kruVvTAG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7572FBE2;
	Tue,  2 Jan 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7288a6e1so7540350e87.2;
        Tue, 02 Jan 2024 04:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704199950; x=1704804750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//ww/Jb9sHnrlzsCP9KHmUv5MLBgpX9vZDWkq7HUeRs=;
        b=kruVvTAGpS2SwInCWKhG+mDmNqKb4yNg+1rugGz05ILxB/Izui7wtsL6UsRdl3SMQ7
         3xEyk0jEI0ocNuFWkWco+fyHQblZdmpshyvKmneH1qZjJseNh2e3k+B1K8Qgm/9OqNhD
         gJ/oSNyTdSmkUo0qP5WSEZq3ViQdReYkS9G0iPDZrmo2k4at1UN3cGXrIgoSQNtWqEGM
         AbGfYlCvPajDSat/bDu1R03Ksnpq+AGkidrmDHMMDycQWfo9q5iwFxoviHyK9DHA10L+
         pKUWVrydnXa2T8GNtARzECPc3Aa1S6j5XLC9eED7ZrlgbUbxiXeOvTa4U1PdWtev8W7s
         Qj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704199950; x=1704804750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//ww/Jb9sHnrlzsCP9KHmUv5MLBgpX9vZDWkq7HUeRs=;
        b=Oc+fCeraZg7oZn5WGqrUbWRdhzj55gPC6ikqvVFrv1zqwwTRORm6RiMD1KfHk4cizK
         TudQ61gPXwam237bWJ+9b3ZWqAxYLeAbs/HkgCxNmDbYp+7CJR1xJRMJ9zs/O6JFAQkp
         f8BL8AwWDZLRGye13WKNX2i+k3B8Vu2HtyTw6nfLfj1h8/Sz3GJyDm4kIeJgPZNpGbNY
         Plim1eAQWyYoqhYfmCGdsfDpiKO9QV4/9215Il7tfRsY6qfC8sB8KY2WTO0t94fauZa7
         S8fBlJh7TgiT4b3F437uEi91vQb1aFRe2EIVV1HxGOvHiTCANbsqquXlRiqteV7P15zn
         0YpA==
X-Gm-Message-State: AOJu0YyVHRYQkZ5YMCKvsHxO5xrv04pYkb/1O4pJJDMTyI21bdzZ6eNm
	od6mOEDEGSTwoUL0A5NiI2M=
X-Google-Smtp-Source: AGHT+IGCoIr5USLc5chCci8hEWYkpQ64lzQlJEvsDkseRRuyz1e/a7v+OGh/4QESBCd6SzjRGPmtAQ==
X-Received: by 2002:a05:6512:482:b0:50e:6a70:24fa with SMTP id v2-20020a056512048200b0050e6a7024famr5720533lfq.6.1704199949476;
        Tue, 02 Jan 2024 04:52:29 -0800 (PST)
Received: from pc636 (host-90-233-200-64.mobileonline.telia.com. [90.233.200.64])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b0050e564cabbfsm3645798lft.231.2024.01.02.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 04:52:29 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 2 Jan 2024 13:52:26 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <ZZQHCrGNwjooI4kU@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
 <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
 <ZYVWjc65LzD8qkdw@pc636>
 <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>

Hello, Paul!

Sorry for late answer, it is because of holidays :)

> > > > The problem is that, we are limited in number of "wait-heads" which we
> > > > add as a marker node for this/current grace period. If there are more clients
> > > > and there is no a wait-head available it means that a system, the deferred
> > > > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > > > 
> > > > That is why we need an extra grace period. Basically to repeat our try one
> > > > more time, i.e. it might be that a current grace period is not able to handle
> > > > users due to the fact that a system is doing really slow, but this is rather
> > > > a corner case and is not a problem.
> > > 
> > > But in that case, the real issue is not the need for an extra grace
> > > period, but rather the need for the wakeup processing to happen, correct?
> > > Or am I missing something subtle here?
> > > 
> > Basically, yes. If we had a spare dummy-node we could process the users
> > by the current GP(no need in extra). Why we may not have it - it is because
> > like you pointed:
> > 
> > - wake-up issue, i.e. wake-up time + when we are on_cpu;
> > - slow list process. For example priority. The kworker is not
> >   given enough CPU time to do the progress, thus "dummy-nodes"
> >   are not released in time for reuse.
> > 
> > Therefore, en extra GP is requested if there is a high flow of
> > synchronize_rcu() users and kworker is not able to do a progress
> > in time.
> > 
> > For example 60K+ parallel synchronize_rcu() users will trigger it.
> 
> OK, but what bad thing would happen if that was moved to precede the
> rcu_seq_start(&rcu_state.gp_seq)?  That way, the requested grace period
> would be the same as the one that is just now starting.
> 
> Something like this?
> 
> 	start_new_poll = rcu_sr_normal_gp_init();
> 
> 	/* Record GP times before starting GP, hence rcu_seq_start(). */
> 	rcu_seq_start(&rcu_state.gp_seq);
> 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
>
I had a concern about the case when rcu_sr_normal_gp_init() handles what
we currently have, in terms of requests. Right after that there is/are
extra sync requests which invoke the start_poll_synchronize_rcu() but
since a GP has been requested before it will not request an extra one. So
"last" incoming users might not be processed.

That is why i have placed the rcu_sr_normal_gp_init() after a gp_seq is
updated.

I can miss something, so please comment. Apart of that we can move it
as you proposed.

--
Uladzislau Rezki

