Return-Path: <linux-kernel+bounces-65287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F572854AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C47B23D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F754BC9;
	Wed, 14 Feb 2024 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oOckCedo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730D29437;
	Wed, 14 Feb 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918092; cv=none; b=VTxOXRfJsv7/JiB0rz2bzn2e0W5UCdzONQi6C2uC59Kc2ueCcrPGFpaNhkBM2tDrfslDpZGb0iTMe/GKi1IhRW3MhSLGYDfOMnkBg12YkAxvVHSyIZdyvKsX6WwpoMGv+N7Qde3zx00/6gTAN8yeMNn6+cPGjDCFAoZb3qZzAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918092; c=relaxed/simple;
	bh=6AYHmBMfwJFBuyKVUjQPKB7rmm80y2Erjoou1j8rLWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK+PYTBf9ICMkmu0ANZitfJJqFjWvqbs1vMOY+0RUvagKkcQSo5TxzP4aO68NL7Xej+mbmxnD4QickCfQFNp62zpGuhj6njDJw1NKRsnukYdtI4UWc1joMjCLMUfWUsnE2Pr0nMcF5k30s2QB/nLFP2Sk0FnUyvYUqQsJ8Ift4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oOckCedo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B39CC433F1;
	Wed, 14 Feb 2024 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707918091;
	bh=6AYHmBMfwJFBuyKVUjQPKB7rmm80y2Erjoou1j8rLWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOckCedomc8CwHd3vnKGdNcyRi9z6sJxG7XwJmL/qg8OR5P3996wAtv/vf5k49TLV
	 ry1KpOrZNhycswhDbEl73Y0wr39ctjtDfTjLl7at/qfY6ctPwR4ZLsYVCY6/WVzxZ9
	 S0H5D74HR2I0FP/9uTCNuDi8Jo1Hwurn/hNbvJSE=
Date: Wed, 14 Feb 2024 08:41:26 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, 
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <20240214-swinging-indigo-koala-a56069@lemur>
References: <2024021430-blanching-spotter-c7c8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024021430-blanching-spotter-c7c8@gregkh>

On Wed, Feb 14, 2024 at 09:00:30AM +0100, Greg Kroah-Hartman wrote:
> +A list of all assigned CVEs for the Linux kernel can be found in the
> +archives of the linux-cve mailing list, as seen on
> +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> +assigned CVEs, please subscribe to that mailing list.

Since the archives page doesn't carry any instructions on how to subscribe,
I think you should link to https://subspace.kernel.org/subscribing.html here,
e.g.:

.. please `subscribe <https://subspace.kernel.org/subscribing.html>`_ to that
mailing list.

> +No CVEs will be assigned for any issue found in a version of the kernel
> +that is not currently being actively supported by the Stable/LTS kernel
> +team.  A list of the currently supported kernel branches can be found at
> +https://kernel.org/category/releases.html

Can just be https://kernel.org/releases.html

Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K

