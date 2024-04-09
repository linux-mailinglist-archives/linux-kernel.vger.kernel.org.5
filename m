Return-Path: <linux-kernel+bounces-136504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2089D4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCFEB21745
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3930D7D094;
	Tue,  9 Apr 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGyFYf0q"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2C182DA;
	Tue,  9 Apr 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652577; cv=none; b=RjvJ8rh6Npptd0m7g59rVAUsMwGg/qUxkBBqUuL2yo60DLxMngVUqtaFtnc7tL4l1D+436+1EvBwKfNf7vU/1vjIGNuIqAxoTMr7e/WqFcP0j2A/zr4Xxz3klxW2sjzQBVfthz4JsVu5M7Rq4kcyby9Le7dqFJ42fDO3fPXW/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652577; c=relaxed/simple;
	bh=5e48eejQZK6FOt/mMCt57syL94/27zQykmcYhHebQFc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+ClH/MRTd0O0ahJbchc5riRICKJbpN2AxoD7Y9a5ay6eHez0Ju17z+G6XmbOXI2YQWJDPfhfrrCFIaaX+WGuegathKEzVHd5QW5jWyKUyIl4Cg9wuNjN2EOudVSd1/5QhrcaNsa4YZwlAeKl6EC3Jupqr1SBvsV0ELffZVjCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGyFYf0q; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d0162fa1so6341397e87.3;
        Tue, 09 Apr 2024 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712652574; x=1713257374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cfFaUeVcG6kokR+BF13mldCWzTlngHtffGZuZFNsyB4=;
        b=BGyFYf0q5E6Rycp+2eVA4IEtdLtciUllWWrstHm7TYLUuLeDSRw0A7JIhGZBX2UQQ7
         fprsFLGD3FUsIoz3n4plpNRMKlD+N5L1M5YNzCEnct1dbKWuatEbbMshaiC9NpsQmfR4
         Z0DeQSHizCDTHzt55i3BeyAEcpqkBUDj9lB6NfFnoQAre70PlPrtoldUgn4RouqxkhZS
         W1LybIPPw9ysMonuWI2BJqga8eFuERZFAiKDq6agOm6ujr/eL0KS46IOdbzd3C3cVGuK
         4gFNOalSCd12+ri98r0Ouo4AOk0q7mktqgve1+IR3s+35a/3sJQzlDuUrnLQn2mbyU6O
         /TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712652574; x=1713257374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfFaUeVcG6kokR+BF13mldCWzTlngHtffGZuZFNsyB4=;
        b=E7SKYFlXtN+Kc/5Rkq9C/9KTk+tJdkJsjdalVXMflVUslzmJUznP+QYWBNUeDCk562
         D0rgeqfr5m5XRvBvauj9v6Llk3CKJajHGIKQ+FlS8wM4Q7DtwzGt4qPAa25cqGYsdlFw
         uC7TsRiHxYUGBOxbX3LI5ACNejvvADu1vocANMKPJNHxpY6vRO7rYtzw4FVtQfkTbb5A
         kXGpCw/sBTuvoWk0iUPe9v4sUz5ZpZYMWuGyIh11olaYZi/WeajlgWxse4OocEH8dC1L
         y+tgfLeWmrJrBJdCzBpqjMlr70/3Wqo8DhCq0dAr8j/pQ8YnQf8Nqap09/hEct6xz3pD
         4EYw==
X-Forwarded-Encrypted: i=1; AJvYcCWsCNX6Px1y4xNERu8U2ukHDO+f+88wjkIhQpOA7hNVAJz6rbo3c8z38T8qkxdgkYSI0nrM/qqLMDfv/fA21ToP7Y7kJs0XAOXR5yZK1zi7Q4wZgTd6b00ZnBsRzPJYHjig
X-Gm-Message-State: AOJu0YzhWSo5iDoNtusBVNW2Hx6rM/nsAtLIm62kAukQDZzxsyXtrkcb
	K3LDTpWDl4tSYDkeeiNEsDbliEcI3roWpwAX88rga2YngDMSbb6n
X-Google-Smtp-Source: AGHT+IFWrxPlTbCKC9q0gRfnujtk6qz2r/ccWDQQVZf4AHUpF3qXCJXeajsRSf9XkE6uG7qzhKIoqg==
X-Received: by 2002:a19:2d0e:0:b0:515:9ee7:ce45 with SMTP id k14-20020a192d0e000000b005159ee7ce45mr7870477lfj.49.1712652573620;
        Tue, 09 Apr 2024 01:49:33 -0700 (PDT)
Received: from pc636 (host-90-233-217-142.mobileonline.telia.com. [90.233.217.142])
        by smtp.gmail.com with ESMTPSA id e10-20020ac2546a000000b00516a21346e3sm1476697lfn.218.2024.04.09.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:49:33 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 9 Apr 2024 10:49:30 +0200
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, paulmck@kernel.org,
	joel@joelfernandes.org, urezki@gmail.com, josh@joshtriplett.org,
	boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() delays when all wait
 heads are in use
Message-ID: <ZhUBGkcab10QM_uU@pc636>
References: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>
 <Zg8ezv2vzylVwg2q@pavilion.home>
 <0fae21aa-d9a1-48d1-85e1-ad746edae361@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fae21aa-d9a1-48d1-85e1-ad746edae361@amd.com>

Hello, Neeraj, Frederic!

> 
> On 4/5/2024 3:12 AM, Frederic Weisbecker wrote:
> > Le Wed, Apr 03, 2024 at 04:22:12PM +0530, Neeraj Upadhyay a écrit :
> >> When all wait heads are in use, which can happen when
> >> rcu_sr_normal_gp_cleanup_work()'s callback processing
> >> is slow, any new synchronize_rcu() user's rcu_synchronize
> >> node's processing is deferred to future GP periods. This
> >> can result in long list of synchronize_rcu() invocations
> >> waiting for full grace period processing, which can delay
> >> freeing of memory. Mitigate this problem by using first
> >> node in the list as wait tail when all wait heads are in use.
> >> While methods to speed up callback processing would be needed
> >> to recover from this situation, allowing new nodes to complete
> >> their grace period can help prevent delays due to a fixed
> >> number of wait head nodes.
> >>
> >> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > 
> > Looking at it again, I'm not sure if it's a good idea to
> > optimize the thing that far. It's already a tricky state machine
> > to review and the workqueue has SR_NORMAL_GP_WAIT_HEAD_MAX - 1 = 4
> > grace periods worth of time to execute. Such a tense situation may
> > happen of course but, should we really work around that?
> > 
> > I let you guys judge. In the meantime, I haven't found correctness
> 
> I agree that this adds more complexity for handling a scenario
> which is not expected to happen often. Also, this does not help
> much to recover from the situation, as most of the callbacks are still
> blocked on kworker execution. Intent was to keep the patch ready, in
> case we see fixed SR_NORMAL_GP_WAIT_HEAD_MAX  as a blocking factor.
> It's fine from my side if we want to hold off this one. Uladzislau
> what do you think?
> 
I agree with Frederic and we discussed this patch with Neeraj! I think
the state machine is a bit complex as of now. Let's hold off it so far.

--
Uladzislau Rezki

