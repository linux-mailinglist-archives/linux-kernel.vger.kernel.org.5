Return-Path: <linux-kernel+bounces-163132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E76908B6630
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D5B217D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F201802CC;
	Mon, 29 Apr 2024 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KToNGRgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3D335A7;
	Mon, 29 Apr 2024 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432924; cv=none; b=uOA3kQL5N8bZO0xdmondEkHY2vY0a8K47wwdJonLfal/5z3jp2+8FKNK4EpEOdP2W8VliCbIrsD9S/qgmzzuxn8mfz1S/lH1t6ThmZWXvxJgzzeP+ZrC6cy3Cftn+qsTWgzs62e3I3n3/05zAsOj/wvDCYHmj2RUgWGvESZBWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432924; c=relaxed/simple;
	bh=A7LMOLKCsAZ4qqkqFakSPa39jisM1x5hfA4rCg+XE3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGVc35UthAXFHYtOK8HZAaPJG+UCsm3STpGT51TSV6kcDgoum4bbQ13mtS1JZQDHUlIss74l5QT7iKiUELB8X9DRaGODyBy/wwu+GPdRcjaRVtFeKZODsqmgS8vkR92osOisSoZWMETftmoA4jreb9zslMs+SKGhXx0IyKVTPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KToNGRgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2F3C113CD;
	Mon, 29 Apr 2024 23:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714432924;
	bh=A7LMOLKCsAZ4qqkqFakSPa39jisM1x5hfA4rCg+XE3o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KToNGRgIxyv+sP1bfRfFXAlXElYZI5F6ubz8J6Zni/+vq+mAxjRqMW6HuvnzVBF7P
	 ORuw/ydLE8gyHm2/5rNVOXSdSxcMof3MsansVXePzWDiY8jm8i7K7+2W07E2qsnWoN
	 CwoBje7YvfXUST/oTzUIGknZYnSOfraYbU5oeUhKKCmNj9uGED0sXLrsnw4zsK+LJI
	 BDG5SpYhTgyv0Sb9REpRQsjmxWqsS1c6aQYkFaoAzTrdpi1+j9wmwu5jN1de/6lC/G
	 m2qbCOecn7w5j1uC4STdpzzFvMeFUpCBy1hI7d3cJfJSHThVuiFMb1KdgEDwHikD4U
	 8oFbQfgNO+t8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CB5B8CE0B6B; Mon, 29 Apr 2024 16:22:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:22:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	joel@joelfernandes.org, neeraj.upadhyay@amd.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org, lance@osuosl.org
Subject: Re: [PATCH] x86/rcutorture move CONFIG_HYPERVISOR_GUEST to
 kvm-test-1-run.sh
Message-ID: <059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240427005626.1365935-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427005626.1365935-1-zhouzhouyi@gmail.com>

On Sat, Apr 27, 2024 at 12:56:26AM +0000, Zhouyi Zhou wrote:
> CONFIG_HYPERVISOR_GUEST is a x86 specific kernel option, move to
> kvm-test-1-run.sh to avoid ConfigFragment.diags in non-x86 platforms.
> 
> Tested in both PPC VM of Open Source lab of Oregon State University and
> local x86_64 server.
> 
> Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

I like this general approach, but why not have something like a
CFCOMMON.arch for the various "arch"s that need it?

Better yet, I bet that there is already something somewhere in the
Linux kernel source tree that knows what hypervisor Kconfig options
each architecture needs.  If so, it would be most excellent to reuse
that information instead of maintaining it separately in RCU.

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 4 ++++
>  tools/testing/selftests/rcutorture/configs/rcu/CFcommon  | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> index b33cd8753689..75774bc70be7 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> @@ -68,6 +68,10 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
>  config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
>  config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
>  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
> +if uname -a | grep -q x86
> +then
> +	config_override_param "x86 specific option" KcList "CONFIG_HYPERVISOR_GUEST=y"
> +fi
>  cp $T/KcList $resdir/ConfigFragment
>  
>  base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> index 0e92d85313aa..cf0387ae5358 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> @@ -1,6 +1,5 @@
>  CONFIG_RCU_TORTURE_TEST=y
>  CONFIG_PRINTK_TIME=y
> -CONFIG_HYPERVISOR_GUEST=y
>  CONFIG_PARAVIRT=y
>  CONFIG_KVM_GUEST=y
>  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
> -- 
> 2.34.1
> 

