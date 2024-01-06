Return-Path: <linux-kernel+bounces-18731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EE8261F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30011C20EB0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0F101E3;
	Sat,  6 Jan 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyHC0XZo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC104101C6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 22:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ED4C433C8;
	Sat,  6 Jan 2024 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704580567;
	bh=ckR2gvsPOohrzx4qONPTGIUubf2rdPJv4FWckTwwXrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyHC0XZovGu3K7VqaYHJPHx67RgbT8bAAPXqOglLOPjO3VRpxn8i7LwaXFvrLZoGa
	 Hqa0lYdIXVeHA1aV+49JNQrf+Xd6yeEw5SOYCSPy1gssGB6JES5bMe6TjNwKshXm1X
	 fUmcHmlR7Y5iE65LgHgFYCStbioZt4u+oZ4OEjKr5yJFqHRuUy0mM1FqVo/BpMx85A
	 ANPEi+gKHlJf+X3h5VOhYGOTpeHUhg/7WFAKuZjWgUrtt07z8FqY9TIz4Ob5K5YlL/
	 0hoYOrjgqhRJ8mKzmMTdh5AvcA4lZCP7Qu6UIh1xT+OsoqbI6WxbTTUqg8/q+WHVaY
	 Vdiz8qdnc4ZZA==
Date: Sat, 6 Jan 2024 23:36:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prototype patch to avoid TREE07 rcu_torture_writer() stalls
Message-ID: <ZZnV0xt9ZhAu-vUh@localhost.localdomain>
References: <a40344c8-a260-41f3-bd7a-6a63d8660489@paulmck-laptop>
 <ZZiIQvu+2CGufvOL@lothringen>
 <3da2e014-ed54-4b2a-9fde-99d6eef3e897@paulmck-laptop>
 <8c135e1a-5f66-42ae-9749-71a65f86dcbf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c135e1a-5f66-42ae-9749-71a65f86dcbf@paulmck-laptop>

Le Sat, Jan 06, 2024 at 06:55:14AM -0800, Paul E. McKenney a écrit :
> > Is this related?
> > 
> > But then the system picks itself up, dusts itself off, and goes along
> > as if nothing had happened.
> > 
> > Maybe a long-running IRQ, NMI, or SMI?
> 
> Or, based on a recent bug chase of another type, high contention on
> an IRQ-disabled spinlock?

Before checking the guest's dmesg, I should probably have checked the host's.
It seems to report some softlockups, perhaps due to too many instances
in parallel where memory is not that generous.

Let me try to run as much time (250 hours) but with fewer instances in
parallel.

Thanks.

