Return-Path: <linux-kernel+bounces-2442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12799815D40
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15660B230D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3760EDD;
	Sun, 17 Dec 2023 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="e2GvSiRi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE61845
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso18503665e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702782457; x=1703387257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/RuGYS3SCPgIBzvHBZan0KQQ4ZutFeSAz6/su3faF0=;
        b=e2GvSiRiF7O01YBojchwL8OC1sAYGjzyPxiB+xKaRUcMa5uiaC9un/4jSOma9QG2bA
         OaepH01DLwuNRev7yk//F2LXPylRFJsHZOek7ItWxwK8HVPmtcLV0jwq3CsbGVDMojHI
         PN8opE693B0+NaYlw0IALEmQ32tWNE56NZk2FugXFMVVr57k6tFv2yKPP+YCXtsTBnB9
         apai2NKNADsHSxc8U4zvg2Msy9is5y4cvYFqszQT8KMYz7ekayrw7kQ2stBRdvbmiWmi
         6npcwasrKy6+/2BIKx53fB0meVASQ1Ge3UasF4Zh0nLOSH6966/p4Fq2lFLi/RmQOMLz
         ikmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702782457; x=1703387257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/RuGYS3SCPgIBzvHBZan0KQQ4ZutFeSAz6/su3faF0=;
        b=oWSUFNf+O1LvXoJrNmV1qOSNunm+6RqfGA04frHQhbFwtfa7DEW4XwyGhegpMxxRGN
         3QtTEdRhCynvxkReE16YgToODhuZSrg+u4cjLJvNVzCQLO4cVnecEBmm0ZGKkX66Djsm
         w2+DP6m69bWQ22Na4GQ0jf1CvbUfkQ/TkSNn9vWUP4o/Q6PEgW+wing988MM+xsNy3uP
         kyqibN7jBQ43oo39rA2vrWa+zFhVFJP9oH8hd5WMB2juokB2+UTJA4+nR221k8GKvZVp
         sUhu/hV3KAfBf6r8368xMwCSrgobCjDBkHfibNaMLEYzFVz8iVk5ZGekS+lbvZnenBm0
         9tgg==
X-Gm-Message-State: AOJu0YwHoSzOq2b79ClS/rQ7k0ITEh7kkiV/Namlo71Bw82zqPJ7iCx3
	iDhWHqIhO2Lqfq+yS4XaZ+19JQ==
X-Google-Smtp-Source: AGHT+IGZIlMhiLPqDdi0cn/iZ0efx31K2IUjGTELgWKjmvr//Mjd9eqzRybnGYv+piVMvMg0e7vt/w==
X-Received: by 2002:a05:600c:4a12:b0:40b:5e1c:5c21 with SMTP id c18-20020a05600c4a1200b0040b5e1c5c21mr7062605wmp.54.1702782457030;
        Sat, 16 Dec 2023 19:07:37 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040c57e4ea28sm19115626wmq.17.2023.12.16.19.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:07:36 -0800 (PST)
Date: Sun, 17 Dec 2023 03:07:34 +0000
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
Message-ID: <20231217030734.ty7isyjyzgcix7er@airbuntu>
References: <20231106193524.866104-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>

Hi John

On 11/06/23 19:34, John Stultz wrote:
> Stabilizing this Proxy Execution series has unfortunately
> continued to be a challenging task. Since the v5 release, I’ve
> been focused on getting the deactivated/sleeping owner enqueuing
> functionality, which I left out of v5, stabilized. I’ve managed
> to rework enough to avoid the crashes previously tripped with the
> locktorture & ww_mutex selftests, so I feel it’s much improved,
> but I do still see some issues (blocked waitqueues and hung task
> watchdogs firing) after stressing the system for many hours in a
> 64 cpu qemu environment (though this issue seems to be introduced
> earlier in the series with proxy-migration/return-migration).
> 
> I still haven’t had time to focus on testing and debugging the
> chain migration patches. So I’ve left that patch out of this
> submission for now, but will try to get it included in the next
> revision.
> 
> This patch series is actually coarser than what I’ve been
> developing with, as there are a number of small “test” steps to
> help validate behavior I changed, which would then be replaced by
> the real logic afterwards. Including those here would just cause
> more work for reviewers, so I’ve folded them together, but if
> you’re interested you can find the fine-grained tree here:
> https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v6-6.6-fine-grained
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v6-6.6-fine-grained
> 
> As mentioned previously, this Proxy Execution series has a long
> history: First described in a paper[1] by Watkins, Straub,
> Niehaus, then from patches from Peter Zijlstra, extended with
> lots of work by Juri Lelli, Valentin Schneider, and Connor
> O'Brien. (and thank you to Steven Rostedt for providing
> additional details here!)

Thanks a lot for all your effort into trying to push this difficult patchset
forward!

I am trying to find more time to help with review and hopefully debugging too,
but as it stands, I think to make progress we need to think about breaking this
patchset into smaller problems and get them merged into phases so at least the
review and actual work done would be broken down into smaller more manageable
chunks.

From my very birds eye view it seems we have 3 elements:

	1. Extend locking infrastructure.
	2. Split task context into scheduling and execution.
	3. Actual proxy_execution implementation.

It seems to me (and as ever I could be wrong of course) the first 7 patches are
more or less stable? Could you send patch 1 individually and the next 6 patches
to get the ground work to extend locking reviewed and merged first?

After that we can focus on splitting the task context into scheduling and
execution (and maybe introduce the PROXY_EXEC config along with it) but without
actually implementing the inheritance, etc parts? Just generally teaching the
scheduler these now are 2 separate parts.

Are 1 and 2 dependent on each other or can be sent as two series in parallel
actually?

Hopefully this should reduce the work a lot from continuously rebasing these
patches and focus on the last part which is the meaty and most difficult bit
IIUC. Which I hope we can break down too; but I have no idea at the moment how
to do that.

Merging in parts will help with giving each part a chance to soak individually
in mainline while the rest is being discussed. Which would make handling
potential fall overs easier too.

I don't know what the other thinks, but IMHO if there are stable parts of this
series; I think we should focus on trying to merge these elements first. I hope
you'll be the one to get this through the finishing line, but if for whatever
reason yet another person needs to carry over, they'd find something got merged
at least :-) I'm sure reviving these patches every time is no easy task!


Cheers

--
Qais Yousef

