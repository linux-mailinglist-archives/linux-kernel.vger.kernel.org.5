Return-Path: <linux-kernel+bounces-97405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706EB876A11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0571F21AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619AF381B8;
	Fri,  8 Mar 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvrtDxcE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040517745;
	Fri,  8 Mar 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919523; cv=none; b=gRemecGO56ddeQ+GbvhKHb/ia2EDwQVgeMW1q1zLICH0oNnJ4vJbKlmtqurqohuOe2gDh9q5YgHeBBGkWuU9vTZWH+2LK5kTY+SLvLrjK5NA/zox/IOf4Knw6GiWW+cRe18WQwnGoKL+SDi13UfIcRsin5jP+fP6XOEeKoa4ZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919523; c=relaxed/simple;
	bh=1szIdl0VmWroeZhI0oBtOtl53dj5u2E6xmup3CVyS0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1bJXCg6lqJxoUCjJMWcX8emUwCPVWD/MiOkV4dCZ5Bjl7Y+/dCAdFxJAkSuK6mB+QEBsP5hf7sccsFlyhwt7VLG/09UFkgendsKn6xX8V6p3Pqtc5K/nFcsMlRPJZAvyGV+GNCvKnGTFCpk/VVVlWoexoA2foLx/zXpxe3fvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvrtDxcE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51326436876so3143686e87.1;
        Fri, 08 Mar 2024 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919520; x=1710524320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=teOnFOTGOtl/bki2az6QKK97mdgDV3359/DGxszAbqU=;
        b=QvrtDxcEd309u/iN3ylg1nXR7CNXrhQomIpRGdoDL7MJzwH6brQaIav2sbGxggHQTQ
         iJt2wr+JlW4QtdMBPO2/rPHif3YOUPs74YRSZH/GHnto4e1nxtLz5kx+OnzfLd8rj37U
         KQ4dSN6Rvbz5tTaTtaVtcr0pkCkDK4k/AzCAbmDxT0IBAR/PpyZ2LPdFWsOIKYhpQhkt
         SfJaWvL1keMwWylL1onibe7Ucy6sjfi7GIuvpURxI34FCU4IfFriyHmcI/kWgQhQExPq
         t21MMwEUbgWzNxYX/vuu7bdK9ns8J4GN0xWE3UMzgvaZfQWjsDp7ZHLTibWX+NV4NJZ6
         bnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919520; x=1710524320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teOnFOTGOtl/bki2az6QKK97mdgDV3359/DGxszAbqU=;
        b=fM2zviIY827F0MKGFkr8CyIj9JKy3HRvfL0wyePiFO3MUF7Wh6eMEqkIwhFCSwsu4F
         TRbaLEDTsa+UWr/M0YCRjsEkqIZLzQzUXXFQyYrHJs3PIxX7hSg7QQXOzp37bWFJKrWz
         AaW0QapEQCjJ1OFZrpNI6J+xkzTyNJcPq63daXR4ysFMoBFOe8DaGPpZ5BaIh4mNH8/7
         fsD1JIg1glh7v4LwdViMVo8w5xwqONVg2wAX7Krpatx388P+5ZBDPTc4/wYgDL+61cac
         D8MAU5F/5uUq7OEVaixTQIRmSyUff7xuZ5McWl3NHYLMYsFHxb140LwTYAUQ04qNsUiL
         7FpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+I2Fj4HXeILmV6rZLvYE72cNT/DkGuzMhqCC+TPyBA2tetDUtPGjEldHdQKFFafM/zyYfz5OciP3aF59Nhw218BQNHLZB9QGFGlm9DrCTX0uEizVxd/+txwCba9PAbCFr
X-Gm-Message-State: AOJu0YxMVsGo+RvNq3ovA+3joz4mybFzJU7pI+9K5mFpmZ8Ob9s2fSsm
	oe8PfUyFe2A3ar3bJppdqFiiZhhYxCJuylac5h5zF1FeTwpYeDDpUG//m0CxsEI=
X-Google-Smtp-Source: AGHT+IErgUin4xbUmmcCRLMlupDKT7WIfme6ARjFcWuuueopTVYjK3BmlqsN4XoIxSpXY6ZacasNWQ==
X-Received: by 2002:a05:6512:200f:b0:513:3214:ae03 with SMTP id a15-20020a056512200f00b005133214ae03mr3182094lfb.69.1709919520080;
        Fri, 08 Mar 2024 09:38:40 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id q1-20020a05651232a100b005131cc57f49sm3524783lfe.194.2024.03.08.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:38:39 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Mar 2024 18:38:37 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, frederic@kernel.org,
	boqun.feng@gmail.com, neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
	rostedt@goodmis.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <ZetNHb6MrmHkQKJN@pc636>
References: <20240307234852.2132637-1-joel@joelfernandes.org>
 <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>
 <ccbdf4d4-6972-430c-a479-0d20b318213b@paulmck-laptop>
 <ZespK0CrkVFCu6_p@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZespK0CrkVFCu6_p@pc636>

On Fri, Mar 08, 2024 at 04:05:15PM +0100, Uladzislau Rezki wrote:
> On Thu, Mar 07, 2024 at 04:06:06PM -0800, Paul E. McKenney wrote:
> > On Thu, Mar 07, 2024 at 06:52:14PM -0500, Joel Fernandes wrote:
> > > On Thu, Mar 7, 2024 at 6:48 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > In the synchronize_rcu() common case, we will have less than
> > > > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > > > is pointless just to free the last injected wait head since at that point,
> > > > all the users have already been awakened.
> > > >
> > > > Introduce a new counter to track this and prevent the wakeup in the
> > > > common case.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > 
> > > Forgot to mention, this is based on the latest RCU -dev branch and
> > > passes light rcutorture testing on all configs. Heavier rcutorture
> > > testing (60 minutes) was performed on TREE03.
> > 
> > Very good, thank you!
> > 
> > Uladzislau, could you please pull this into the next series you send?
> > I can then replace your commits in -rcu with the updated series.
> > 
> Absolutely. I will go through it and send out the next version!
> 

Joel, i sent out the v6: [PATCH v6 0/6] Reduce synchronize_rcu() latency(v6)

Could you please rework the patch on latest tip once the series i sent is
settled on Paul's dev?

I have not sent your patch because it is not cleanly applied and needs some
review.

Thank you in advance!

--
Uladzislau Rezki

