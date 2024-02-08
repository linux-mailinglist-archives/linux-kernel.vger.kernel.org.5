Return-Path: <linux-kernel+bounces-58323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17A84E4AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFB41F26A63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A082B7D410;
	Thu,  8 Feb 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHIrfpUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6A7BAF2;
	Thu,  8 Feb 2024 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408469; cv=none; b=jFNC/H9xfv1U6UDAPgYhLW8TC1C5M9UyzHe+t4EvdQdug0MRXbKQ2OS0BtXmXgUw7EH/l7uoU/fWxv0E5zI0j6rFBwFYs+gYLKW4HndbF7TR02ReKuXAq2AlEke15XSxEdCj63nlTYgmKYFIErP5XnsYkVbHAJuVzZDOglt8/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408469; c=relaxed/simple;
	bh=CRjMpS0bAfMxYYNlXJmgdiIasm53lsQPI3k7ROehHXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkQgsto0C4oTubOj5CVsktf5rO9Yg692Lov8/SPmvTQp5g3P+TcQiNeIlje4CBWTvpJNtTdKugFuXp8p4/X/VoNsMRquocBz9mXCELz1IwVRLkr9wabno3o+JoF6/40KFzZ/jCpS6D88/rcKIQhaBwRjJfYQdsBQrEIhBrqvLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHIrfpUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E73C433F1;
	Thu,  8 Feb 2024 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408468;
	bh=CRjMpS0bAfMxYYNlXJmgdiIasm53lsQPI3k7ROehHXY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WHIrfpUenoTLAuwIhS2jOSRpk0apgqlvcAcdnAes4RIIuO4XXuv1eiw3COMTMjw5b
	 jtJHJAPoX/B82IFJot6P5Xm8XAnp20pNDoSLnQ3qM8CYoxBVm6KpJV04NpKTiG/0CG
	 jS71KH3o4vMQYJ8SjyS3mJKHaM+8vTXuPa1bUVYYvVOBuNlJb46zqDzN1TpnmUyder
	 mvDSU5RRxz4RJ5XAsjOHLj3+kgfJoOMwp0IQTKq738jYnrz0Gjqn9BCdALvDTqtg7T
	 5nGenvIV83/aFrPqC2tjQ6jS7poDYg+Kk+tp/ySilII1MslnxfLzCtfynZKGzVFBMQ
	 B6Kg97KELzPpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AF3C9CE1ECC; Thu,  8 Feb 2024 08:07:43 -0800 (PST)
Date: Thu, 8 Feb 2024 08:07:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <0a24d1a3-449b-401c-ace2-475913b7d2f9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240208073919.39bc9af0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208073919.39bc9af0@canb.auug.org.au>

On Thu, Feb 08, 2024 at 07:39:19AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   cae00f2ab011 ("Revert "hrtimer: Report offline hrtimer enqueue"")
>   9addc18fe8cd ("Revert "rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks"")
> 
> are missing a Signed-off-by from their author and commiter.
> 
> Reverts are commits as well.

Apologies, will fix!

							Thanx, Paul

