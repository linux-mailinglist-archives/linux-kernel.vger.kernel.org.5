Return-Path: <linux-kernel+bounces-138328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0DC89EFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAED9B22DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BECC15821F;
	Wed, 10 Apr 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1JIqt1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABC155300;
	Wed, 10 Apr 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745058; cv=none; b=LKgj5k/i8FHx4+ZFTIL8KqQDsKnOQM7fy/jyDPz0WLDtMxNBo+6LcrqbUj+OBL3fpMdHW8hUGCMDLHfUL8U7gsgAfV4Hyn1Da+JMmXNuIeGxRiPxHGKabAXmJs8HYrGRCTE/aUPSKj5ZM0tBjhr0OJagCjPVPh50FQfzHrPbAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745058; c=relaxed/simple;
	bh=4zuUE+4lnuT1tggaLbfb0fGKSWl4GwtjbvM5H87GdGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1P07yBi6h6iGorxPFxzEaNXZVTf34wUyPWJdDnntU8gSbd+58XOGjlJDLv+/hiO511W7F9rgNdoEdyJg98P6TluNKgmY0FI8KHTWD7qRMW2b9vN3ZdS7tpziLH7BZvqg5Y+YAV2hr8y+omfzeGqZpSY9s1uuGYyLU3juukCtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1JIqt1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4D2C433F1;
	Wed, 10 Apr 2024 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745058;
	bh=4zuUE+4lnuT1tggaLbfb0fGKSWl4GwtjbvM5H87GdGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1JIqt1DYu/EdX9xeaqocx0Ee4XY2rYzbMa07kVMga9FMWIqgSn0V3gAVx5RypX6Y
	 KDwK6xQmNHyTvCbQ3c7vPKe9WOSPZJlKvDJiXUFDiRPEysAmX6XTZq1QTbwPQU8j1o
	 Wad+4UCUk323tDaC20zdvVPwq6ECB6GCwS02zVoo9Tfc04W0vZK4285mTsBTidFzuf
	 HFdHRXc1lkdZA5Jo8r063Lv8buZ4+zOn76deLqCbYHFjxqq6FDHd7tLTgT4/dDBZvj
	 7uGxqGrbM8a4IIeG2Z2sNPe3JWEqeyKcnSpfNA9F6Cbn4CFa/dnFC+5/hpEIOp09fY
	 DNjOwSzBq7DJg==
Date: Wed, 10 Apr 2024 12:30:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 2/2] context_tracking, rcu: Rename RCU_DYNTICKS_IDX to
 CT_DYNTICKS_IDX
Message-ID: <ZhZqX0YqlzPoOK2b@localhost.localdomain>
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-3-vschneid@redhat.com>
 <Zg6tYD-9AFPkOOsW@localhost.localdomain>
 <1ef9d1f9-16a2-4ddc-abd5-6c3b7cde290f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ef9d1f9-16a2-4ddc-abd5-6c3b7cde290f@paulmck-laptop>

Le Tue, Apr 09, 2024 at 12:53:03PM -0700, Paul E. McKenney a écrit :
> On Thu, Apr 04, 2024 at 03:38:40PM +0200, Frederic Weisbecker wrote:
> > Le Wed, Mar 27, 2024 at 12:29:02PM +0100, Valentin Schneider a écrit :
> > > The symbols relating to the CT_STATE part of context_tracking.state are now
> > > all prefixed with CT_STATE.
> > > 
> > > The RCU dynticks counter part of that atomic variable still involves
> > > symbols with different prefixes, align them all to be prefixed with
> > > CT_DYNTICKS, as CT_DYNTICKS_MASK already is.
> > > 
> > > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > 
> > It used to be that RCU extended quiescent state and dynticks enter/exit
> > were coupled. But this isn't the case anymore. Nowadays RCU stops watching
> > some time later after dynticks is entered.
> 
> I knew that consolidation of atomic operations was too good to last...
> 
> > I wonder if we shouldn't take advantage of that cleanup for a meaning that
> > really reflect that RCU stops watching from there.
> > 
> > Paul what do you think? CT_EQS_IDX ? CT_RCUEQS_IDX? CT_RCUOFF_IDX? ...?
> 
> "After what you just did?  You can just RCU off!!!"
> 
> Sorry, couldn't resist...
> 
> I am having a hard time getting too excited about the name.  I could
> suggest CT_RCU_WATCHING_IDX, but that isn't exactly the shortest
> possible name.

I really like CT_RCU_WATCHING. It says everything. The _IDX isn't even
needed after all. What do you think?

Thanks.

> 							Thanx, Paul

