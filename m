Return-Path: <linux-kernel+bounces-6226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA4819623
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E4028785D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33991D6AE;
	Wed, 20 Dec 2023 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2sUpsmY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46A1D698;
	Wed, 20 Dec 2023 01:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4F6C433C8;
	Wed, 20 Dec 2023 01:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703035039;
	bh=M1cxbURU5NPr6VgO63qT3H5qFCt0EpuVrN4VEWEB/XM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C2sUpsmYi+6ByjJ8iC9NMhYtPc24IoMHUe1rRgDCtixTolYHKVcOAzQT5QPKfgANM
	 vh3akZE7bRZN28x5PreCjQ50YTxRM/H4u9ul3jJHcD6a0RkdpH0gDVhmFHbEXbsEXF
	 3Tq/LWmiwLWfZHHQ6NFY/VdGu0qCjRiYe5HGVhjaatspAtBgA4VNyBeM2IcuIlSNse
	 n7Yck5TLL+wOPHr9jp31tEB6zrNw09PVT78M28q7r9Ydrk5UI3nA8IAaOIBPHCzQ+p
	 B26Is97BrEbNRtbXme1rXeESTbKbcK0F6WMPwuh71prYIMVfokgoAHyuZic0awIyUb
	 7u07vA54lnW5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5732CCE10DA; Tue, 19 Dec 2023 17:17:19 -0800 (PST)
Date: Tue, 19 Dec 2023 17:17:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 3/7] doc: Add rcutree.rcu_normal_wake_from_gp to
 kernel-parameters.txt
Message-ID: <1aa6e7a4-57de-480f-bc1c-5a1b28dd666b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-4-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128080033.288050-4-urezki@gmail.com>

On Tue, Nov 28, 2023 at 09:00:29AM +0100, Uladzislau Rezki (Sony) wrote:
> This commit adds rcutree.rcu_normal_wake_from_gp description
> to the kernel-parameters.txt file.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Very good, but could you please fold this into the first patch, which
is the one that adds this kernel parameter?

							Thanx, Paul

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a1731a0f0ef..65bfbfb09522 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4944,6 +4944,20 @@
>  			this kernel boot parameter, forcibly setting it
>  			to zero.
>  
> +	rcutree.rcu_normal_wake_from_gp= [KNL]
> +			Reduces a latency of synchronize_rcu() call. This approach
> +			maintains its own track of synchronize_rcu() callers, so it
> +			does not interact with regular callbacks because it does not
> +			use a call_rcu[_hurry]() path. Please note, this is for a
> +			normal grace period.
> +
> +			How to enable it:
> +
> +			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> +
> +			Default is 0.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> -- 
> 2.39.2
> 

