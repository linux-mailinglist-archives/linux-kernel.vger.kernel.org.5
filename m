Return-Path: <linux-kernel+bounces-95538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72894874F14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03551F22556
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7F286656;
	Thu,  7 Mar 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0pv4Zcq"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8B1B59A;
	Thu,  7 Mar 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814708; cv=none; b=DL9TQMCdlOB5Qbc/WYHi/Jxd7sPgRtHAEK4+wu6G1avJPIoR7zx5M7hLpOBeslX2vU8S5WgjZnPh1+AAb/zwQ1WiE/14+8LH47ftlMMcXUX5M8rVKdydcBTUoX1Hwq2P1GjOcg3AdjplxOngx+ybWr+/00UAUC6DcZMQyvbbPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814708; c=relaxed/simple;
	bh=0sX4QpEatvSeLaUqxVm3mD5gZWSjYFm08pcwRatwDD0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1Lcpuwa06fFA/4N1IVkOyv6etDT6ewpppaEo6bmgbs7OP3QzUuozkVya6DDxVRKBmCbPx5e2YRdgq6ow1du3XVhTTeeMYunWNI6CFI5L8tXyfm8m+Z4LW8rK7gO34AbJC8Z7OPhGnXvRD2aFp3SAjE7ODehBv7p1M0hERCc/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0pv4Zcq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5131f3fc695so860821e87.1;
        Thu, 07 Mar 2024 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709814704; x=1710419504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4jcyJaQg71M083FEUx+YxTYHlbADoVNPEMpfefeqgc=;
        b=X0pv4Zcq8kHpZAq6jq6uHVxFc/ZzB9K3L6Tlb5EbO+p18F3w8utpDjVIkN5cV/oouW
         AbWz2LtHjY/98dBKE/4Y9Ewyk+elIH2J1hckYzOW6ZvM05eiiRuvPbGpd4zQVT+5/NV+
         8ZD5hhRygEprJB6/F2BLe0x/2P0fCSFuRhkPpmRi7rRRSWbSp+i6I7ioEVTkeGQboL95
         cC8W4TG6R/x3dKHjUjAhY21ZSn5NLWVuixFwXInWVhq7vrBmNAk5tP81Etxb2Ch2hKbN
         8P6wAK52l8/a2thpku/AFGPPLp5ACOF8ht7nOvt9GHzP1gGO+SW/ksX5pFlRD8W0pVJR
         yniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709814704; x=1710419504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4jcyJaQg71M083FEUx+YxTYHlbADoVNPEMpfefeqgc=;
        b=MkAo3Rh6fCEitubUXR0OlRnqF9PjZ4Q/DUy6Wpm1MKynLHhOZDGURlyo9Vn7SK44PZ
         FAxi5TYfHuksst0ePPJwFwxjbPEAtOxcf2qFGdrVerKWQrtXx0yLajSKQVCjWaVh3Sa4
         /ew8FZ+bUDJ4P2Rnc8gzHgRNzYz6lqOfizNZVL9oLuONyQCXNVMFZAhtTV971CCUohGg
         49UnYOXqf3vEP83fyRU5F2xTYmneSV48uoiDnrjXfBlzIRA+v8svxFCpsXO2Qeb2bNfq
         4Y3bqqbdp8aLT+4MZBHV1TZ7AzA1qLIer0soyCRIq4dhifAtbTHTifU6BYXf8mSQcP7d
         tOrA==
X-Forwarded-Encrypted: i=1; AJvYcCURH2rUL+JdP+W5py6HpLXRwwF3gDc4HCp86sRJ4DcdctjcsBkdVOIHdvLObrkrJC63zQgpSF3OPLjfO9XGiEApaO053tj8LQUmV1QUYml4SoUpAelEs2glOqoXzFcvcD/r
X-Gm-Message-State: AOJu0YxjokgIdGFUo5SiAGJmICjbpWUA5wzodGwCY/jVnZT4VlvhuFql
	zXp2d2L8mMANnNA5EmtwUrN+IdlDM7KUPd8ul6qtISpVlAExyvkw
X-Google-Smtp-Source: AGHT+IEYM9RD7+tvU4yieVedd01QaxUkapUQssBr5Ka+8bdo3pTb9foob0p/bexsS5rYZzRJQCLZHg==
X-Received: by 2002:a05:6512:224e:b0:513:1853:4369 with SMTP id i14-20020a056512224e00b0051318534369mr1971534lfu.49.1709814704123;
        Thu, 07 Mar 2024 04:31:44 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id c38-20020a05651223a600b0051333070666sm2597034lfv.299.2024.03.07.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:31:43 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Mar 2024 13:31:41 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Message-ID: <ZemzrXfN7PUGiETd@pc636>
References: <20240305195720.42687-1-urezki@gmail.com>
 <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
 <14ab5bd4-d7b8-4233-9389-f21884986671@joelfernandes.org>
 <648f31c5-e67c-4605-9ebd-7450e96a2dbe@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648f31c5-e67c-4605-9ebd-7450e96a2dbe@joelfernandes.org>

On Thu, Mar 07, 2024 at 02:09:38AM -0500, Joel Fernandes wrote:
> 
> 
> On 3/7/2024 1:21 AM, Joel Fernandes wrote:
> > 
> > 
> > On 3/6/2024 5:31 PM, Joel Fernandes wrote:
> >>
> >>
> >> On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
> >>> Fix a below race by not releasing a wait-head from the
> >>> GP-kthread as it can lead for reusing it whereas a worker
> >>> can still access it thus execute newly added callbacks too
> >>> early.
> >>>
> >>> CPU 0                              CPU 1
> >>> -----                              -----
> >>>
> >>> // wait_tail == HEAD1
> >>> rcu_sr_normal_gp_cleanup() {
> >>>     // has passed SR_MAX_USERS_WAKE_FROM_GP
> >>>     wait_tail->next = next;
> >>>     // done_tail = HEAD1
> >>>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>>     queue_work() {
> >>>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >>>         __queue_work()
> >>>     }
> >>> }
> >>>
> >>>                                set_work_pool_and_clear_pending()
> >>>                                rcu_sr_normal_gp_cleanup_work() {
> >>> // new GP, wait_tail == HEAD2
> >>> rcu_sr_normal_gp_cleanup() {
> >>>     // executes all completion, but stop at HEAD1
> >>>     wait_tail->next = HEAD1;
> >>>     // done_tail = HEAD2
> >>>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>>     queue_work() {
> >>>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >>>         __queue_work()
> >>>     }
> >>> }
> >>>                                  // done = HEAD2
> >>>                                  done = smp_load_acquire(&rcu_state.srs_done_tail);
> >>>                                  // head = HEAD1
> >>>                                  head = done->next;
> >>>                                  done->next = NULL;
> >>>                                  llist_for_each_safe() {
> >>>                                  // completes all callbacks, release HEAD1
> >>>                                  }
> >>>                                }
> >>>                                // Process second queue
> >>>                                set_work_pool_and_clear_pending()
> >>>                                rcu_sr_normal_gp_cleanup_work() {
> >>>                                // done = HEAD2
> >>>                                done = smp_load_acquire(&rcu_state.srs_done_tail);
> >>>
> >>> // new GP, wait_tail == HEAD3
> >>> rcu_sr_normal_gp_cleanup() {
> >>>     // Finds HEAD2 with ->next == NULL at the end
> >>>     rcu_sr_put_wait_head(HEAD2)
> >>>     ...
> >>>
> >>> // A few more GPs later
> >>> rcu_sr_normal_gp_init() {
> >>>      HEAD2 = rcu_sr_get_wait_head();
> >>>      llist_add(HEAD2, &rcu_state.srs_next);
> >>>                                // head == rcu_state.srs_next
> >>>                                head = done->next;
> >>>                                done->next = NULL;
> >>>                                llist_for_each_safe() {
> >>>                                 // EXECUTE CALLBACKS TOO EARLY!!!
> >>>                                 }
> >>>                                }
> >>>
> >>> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> >>> Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> >>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>> ---
> >>>  kernel/rcu/tree.c | 22 ++++++++--------------
> >>>  1 file changed, 8 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>> index 31f3a61f9c38..475647620b12 100644
> >>> --- a/kernel/rcu/tree.c
> >>> +++ b/kernel/rcu/tree.c
> >>> @@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> >>>  
> >>>  	/*
> >>> -	 * Process (a) and (d) cases. See an illustration. Apart of
> >>> -	 * that it handles the scenario when all clients are done,
> >>> -	 * wait-head is released if last. The worker is not kicked.
> >>> +	 * Process (a) and (d) cases. See an illustration.
> >>>  	 */
> >>>  	llist_for_each_safe(rcu, next, wait_tail->next) {
> >>> -		if (rcu_sr_is_wait_head(rcu)) {
> >>> -			if (!rcu->next) {
> >>> -				rcu_sr_put_wait_head(rcu);
> >>> -				wait_tail->next = NULL;
> >>> -			} else {
> >>> -				wait_tail->next = rcu;
> >>> -			}
> >>> -
> >>> +		if (rcu_sr_is_wait_head(rcu))
> >>>  			break;
> >>> -		}
> >>>  
> >>>  		rcu_sr_normal_complete(rcu);
> >>>  		// It can be last, update a next on this step.
> >>> @@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>  	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> >>>  
> >>> -	if (wait_tail->next)
> >>> -		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> >>> +	/*
> >>> +	 * We schedule a work in order to perform a final processing
> >>> +	 * of outstanding users(if still left) and releasing wait-heads
> >>> +	 * added by rcu_sr_normal_gp_init() call.
> >>> +	 */
> >>> +	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> >>>  }
> > 
> > One question, why do you need to queue_work() if wait_tail->next == NULL?
> > 
> > AFAICS, at this stage if wait_tail->next == NULL, you are in CASE f. so the last
> > remaining HEAD stays?  (And llist_for_each_safe() in
> > rcu_sr_normal_gp_cleanup_work becomes a NOOP).
> > 
> 
> Never mind, sorry for spewing nonsense. You can never end up with CASE f here so
> you still need the queue_work(). I think it is worth looking into how to free
> the last HEAD, without queuing a work though (while not causing wreckage).
> 
No problem at all :)

--
Uladzislau Rezki

