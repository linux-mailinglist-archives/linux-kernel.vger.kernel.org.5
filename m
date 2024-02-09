Return-Path: <linux-kernel+bounces-60055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1F84FF4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2903A28215F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4B2135C;
	Fri,  9 Feb 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Viou+F6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5F18B00;
	Fri,  9 Feb 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515754; cv=none; b=lyD56a1X4HyeKNsOlmqYf4BwdFMU0QZJGFrE1sunn7f7dn+oVWJfT6WqpIXD9bLM9m7rQx9Ol/38wLKGvF69bXEsGwkT1anuC2cavVJ2EhZCe5LIL8PBv0PagkZCnRGRxm7E5sLgKMpQjQdMb3xqncqfbrXJ4mWLson8ZPIrheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515754; c=relaxed/simple;
	bh=VaagvheN7saZUzKsPo7gmknjWK+wFtrvCmdNycGk3jI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blLmVJGH1WGgrwMSXMsWg0LbwWtZgkJsStzg6qGD4+rUBWjTMv8rphminQTYSG45kEXbLFuCP15KtiT1G9M7HkauTcgYiZUi9JFrTJ+HqwsuFVeDvLBHddv2b8r2NMrOKwQ4AC1IPLd05GdoLWXyh2xoR42L9yXEKdZyCJtRnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Viou+F6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E519C433C7;
	Fri,  9 Feb 2024 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515753;
	bh=VaagvheN7saZUzKsPo7gmknjWK+wFtrvCmdNycGk3jI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Viou+F6co0PZLLGEreODXZ7F3Gs6bvwvX4PPUhvxlq4pXi1A5yHNAgIRJaoIxZ9mD
	 ZKceOR9IIjO3II4h5NMVZAYIapkEwoWJm/8pFIuvXVOEMjI7rS/x9mS+iKfwHl/Dzy
	 Y+VjNLHLI9cq18IfqEtx/acM0BZDsbb3wvKRtLQhSWMDEHkdyadAbrhA2BojMHzQmb
	 +LZvBJBIloMbgLP46qdR9vlP/J8S6MxRtUgJa4tBscZ6abLH+OogbxK+1WUNG7qKFH
	 7pe2AsEE/ZOD5xfYSao6asCJ3sZvTQjHkenz8WGYrIzT/QC5cxXe8Gb/zzHZko99Gl
	 K9CitYygs0XlQ==
Date: Fri, 9 Feb 2024 13:55:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ventura <david@davidv.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Xiongwei Song
 <xiongwei.song@windriver.com>, linux-doc@vger.kernel.org (open
 list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list),
 netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6])
Subject: Re: [PATCH v2 0/2] net: ipconfig: remove wait for drivers
Message-ID: <20240209135552.239c5590@kernel.org>
In-Reply-To: <20240208093722.246930-1-david@davidv.dev>
References: <20240208093722.246930-1-david@davidv.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 10:35:53 +0100 David Ventura wrote:
> Currently ip autoconfiguration has a hardcoded delay of 10ms.
> 
> Make the delay configurable via the new `ip.dev_wait_ms` argument, and
> set the default value to 0ms.

Does not apply, you'll have to respin:

Applying: net: make driver settling time configurable
error: sha1 information is lacking or useless (Documentation/admin-guide/kernel-parameters.txt).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Patch failed at 0001 net: make driver settling time configurable
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

