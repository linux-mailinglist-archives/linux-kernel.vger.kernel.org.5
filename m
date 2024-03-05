Return-Path: <linux-kernel+bounces-92014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F88719B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E721F22103
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65152F92;
	Tue,  5 Mar 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzIPq2lG"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90817721;
	Tue,  5 Mar 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631487; cv=none; b=CuzvWSqKDN4JVo+DrO4lh9fL1ACNlvAQNCru/ZaeUVcnTKrCYbh+4Gm8XQzjqXXUWZtHHrCI6f6IwWSi2ot1BPvWNk6yd9jcI73YxGAOZV6AlddYnqtmRtDtPNRW8IwJkCLEgNV2X6yUgZXwL/RwyBj3zU5FDqdPAvKvWy0vFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631487; c=relaxed/simple;
	bh=z2SRACEdEYImPDxyXMgue7032HdKMaruPutWFf7+NUA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZiZQoA2fOOqoUl2rHsqnXxqxli+TS7HWH8PV2z3jflU82lv4nOhxyE6Xr5rHceK1JqsLODonWXYitgALGK6U72Zs3Ar6iMIQbIXqqywxFSineo2ivCxCwrozmXK6dzMuVKvnJo9hMiTdxEYVp8zHthsR9397y62FNstCJMNDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzIPq2lG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51340e89df1so2704431e87.1;
        Tue, 05 Mar 2024 01:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709631484; x=1710236284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J1b3HlBoJynNHCVhwrfJ1VhOag03u56s5IVuhmH3WmA=;
        b=MzIPq2lG1WnLVuHViJp81eGFKCXOwm0JYUqWExhk5GTHrOvinEfhc3ef2SoqZWTC2t
         sNrmog8xiE8xQTncXXYFlXrRiP082YHhLa2k+m0Gu4tqlZpq+JsZXAk14m1p2Rbv4o2T
         5vqJ1px6Ty7zgVSWs21piCPP6ORx3RiRnqVngNyRc1GytM6Fw77vPSFIhCVMw6IX6/RM
         ExrX+jHRiB09ZjRSHi2ic2M3DBlrmTPEL0EDVYOcdxm6uo5DG5+93HDsiz8JJ3zepztI
         ss2yxjF43jmpqQzWBrRFEj+Lfn5xiGuYxkQ7FKgKh07m4CcjZt59hqVIY+5ZLHresDM0
         3L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631484; x=1710236284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1b3HlBoJynNHCVhwrfJ1VhOag03u56s5IVuhmH3WmA=;
        b=tghtkpkWj1Db9c1B0BUT8j8JpOrbwUVLE6Bd4iWsxs0S1AlrkW1WCKoiXCpuNIlrSa
         onj8lNnCqTLyoAccA8Mtbe1CEGe8GJeJsVFjSrdSZ+qraCWmn0lgzEBJVWvatCYzOT67
         TZ/Y9pwDwPFtHzxzyDB1ASbJj/+K0DqTbmLx72fYDANACxF5gh3UfYdITrOsSgH8vJpF
         Jp5oZoPNpAnAxy6Bv5I1z/qG+Vp1h2SvcrBLtOSc9w0/FxZaqtmCynawzvm1WAS+W4iA
         P/6ZhxKGByUTPVy5R4ILgYdNTrbxzHxTuXX3ni4DagqIHUQRN02GT/foPGiLdH6V2fEk
         1rAA==
X-Forwarded-Encrypted: i=1; AJvYcCX30QNYqTYFlXGvnxTJVX0R2xC55JNus8YHYbGtVi2uN9XKjalUJSBW5BhCPzHQjKgB1guzE2acrFecbnzlpWTrovdQ7PD3T9nK38A4Tm336f+g1QIbtPsdHz+KcXALB3Dj
X-Gm-Message-State: AOJu0Yx+ifWG+HXc7oAJToEdt1TU2weTrZUETPCVT/jE+YKr6UD8lw0Q
	V8v1eUfb5sCKA8HU5IY0PlOf+d021BGtSCydYLSIJvy8tsfVrVyK
X-Google-Smtp-Source: AGHT+IFAvThuLy2EK+lFalsdnTkjoaOjDp5OXq7MA6J4HrllXtlhl8YZBFw1WcoTxHeDAFDM5W4zig==
X-Received: by 2002:ac2:5f49:0:b0:513:37a1:ae60 with SMTP id 9-20020ac25f49000000b0051337a1ae60mr749606lfz.34.1709631484056;
        Tue, 05 Mar 2024 01:38:04 -0800 (PST)
Received: from pc636 (host-90-235-1-20.mobileonline.telia.com. [90.235.1.20])
        by smtp.gmail.com with ESMTPSA id d30-20020a19385e000000b00513318e99a9sm1744744lfj.165.2024.03.05.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:38:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 5 Mar 2024 10:38:00 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zebn-MvZq7NkFjq-@pc636>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <Zd91pR0fjiCUZTtP@pc636>
 <ZeW2w08WZo4yapQp@localhost.localdomain>
 <ZeX1cXWKv2kirDXg@pc638.lan>
 <ZeZRk-1Kx-s0Nz34@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeZRk-1Kx-s0Nz34@pavilion.home>

On Mon, Mar 04, 2024 at 11:56:19PM +0100, Frederic Weisbecker wrote:
> Le Mon, Mar 04, 2024 at 05:23:13PM +0100, Uladzislau Rezki a écrit :
> > On Mon, Mar 04, 2024 at 12:55:47PM +0100, Frederic Weisbecker wrote:
> > The easiest way is to drop the patch. To address it we can go with:
> > 
> > <snip>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 31f3a61f9c38..9aa2cd46583e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1661,16 +1661,8 @@ static void rcu_sr_normal_gp_cleanup(void)
> >  	 * wait-head is released if last. The worker is not kicked.
> >  	 */
> >  	llist_for_each_safe(rcu, next, wait_tail->next) {
> > -		if (rcu_sr_is_wait_head(rcu)) {
> > -			if (!rcu->next) {
> > -				rcu_sr_put_wait_head(rcu);
> > -				wait_tail->next = NULL;
> > -			} else {
> > -				wait_tail->next = rcu;
> > -			}
> > -
> > +		if (rcu_sr_is_wait_head(rcu))
> >  			break;
> > -		}
> >  
> >  		rcu_sr_normal_complete(rcu);
> >  		// It can be last, update a next on this step.
> > <snip>
> > 
> > i.e. the process of users from GP is still there. The work is triggered
> > to perform a final complete(if there are users) + releasing wait-heads
> > so we do not race anymore.
> 
> It's worth mentioning that this doesn't avoid scheduling the workqueue.
> Except perhaps for the very first time rcu_sr_normal_gp_cleanup() is called,
> the workqueue will always have to be scheduled at least in order to release the
> wait_tail of the previous rcu_sr_normal_gp_cleanup() call.
> 
No, it does not avoid for sure :) I will add more explanation.

> But indeed you keep the optimization that performs the completions themselves
> synchronously from the GP kthread if there aren't too many of them (which
> probably is the case most of the time).
> 
> > I am OK with both cases. Dropping the patch will make it more simple
> > for sure.
> 
> I am ok with both cases as well :-)
> 
> You choose. But note that the time spent doing the completions from the GP
> kthread may come at the expense of delaying the start of the next grace period,
> on which further synchronous RCU calls may in turn depend on...
> 
That is a true point. Therefore we do it with a fixed number which should not
influence on a GP.

--
Uladzislau Rezki

