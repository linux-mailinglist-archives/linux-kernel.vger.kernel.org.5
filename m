Return-Path: <linux-kernel+bounces-65291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D3854AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9E6281307
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54154F8B;
	Wed, 14 Feb 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrpSExJf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEC535DF;
	Wed, 14 Feb 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918228; cv=none; b=REAmkXg+G43Ltg8bxVklkpn7xy360cgJxtw4rK/oJ/uQo5g1Bs6w0zymaQC4w1S4inNhQVlmoKXWPhM/bZj4z/e0v0TXkLLhev04tZuczgdsZO+4rRzasAffHGn07dU2uAl83Ja11fJtUW7Ovkz23NufewSf7o4d0jeyIlBhpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918228; c=relaxed/simple;
	bh=A5U30lVQU5Bf8CXCoXAd7N45t7rDRYfwSnibM+8yemw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lXu5jz+y0WCNvLCGCBy1zYehiBxhfiknOZ+mG2olobwuYV9HEh+aziUe5e0Nblx4549dadQkks7MotH5gtVL2I/IF4p39EjzfzgBbRaCIqMi0grlx/ReASEUd0a7JOSFsmhxjFqwnJKwFuRQ4tjSPNO6gI2D+32DCzVPpQKkxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrpSExJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22481C433C7;
	Wed, 14 Feb 2024 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707918227;
	bh=A5U30lVQU5Bf8CXCoXAd7N45t7rDRYfwSnibM+8yemw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RrpSExJfChBfAvLG7VcKN+67USgDKv4Q9tLGmAlv4OteLwQVP067IDPT99HaWIhY6
	 IayVxJcM5fRswd6K3qXm8jYtTXCmySKRC8ZveLBp84YTi4keH8jcxWyS9Ip6VeNlHC
	 Zhp894g6NslistSBNYF3V7QpjwVYJXTShUn5zPnNpreszc5dPBA3QWdhx1xOo1ffhU
	 qHuaDmDAM6FS1a2GjC5tAD5UksYQqD1WKhIdedsw2/y78V2/jcsus4CmpZZqGHOsO2
	 b6LWMBvTlg7Wio84TT8Hnjre0l0BXuGk0hA4DzM++ZUL+C8tKalwyiW9kOL5ASS5g4
	 1uN4jZReOM9hQ==
Date: Wed, 14 Feb 2024 14:43:48 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, security@kernel.org, 
    Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE
 process
In-Reply-To: <2024021430-blanching-spotter-c7c8@gregkh>
Message-ID: <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>
References: <2024021430-blanching-spotter-c7c8@gregkh>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Greg Kroah-Hartman wrote:

> +No CVEs will be automatically assigned for unfixed security issues in
> +the Linux kernel; assignment will only automatically happen after a fix
> +is available and applied to a stable kernel tree, and it will be tracked
> +that way by the git commit id of the original fix. 

I think this needs way more clarification .. how exactly is this going to 
work?

Do I read this correctly that *everything* that lands in -stable will 
automatically get CVE assigned? If so, that's just plain crazy. Just took 
a random peek on the topmost -stable changelog ...

	ASoC: codecs: wsa883x: fix PA volume control
	ASoC: codecs: lpass-wsa-macro: fix compander volume hack
	ASoC: codecs: wcd938x: fix headphones volume controls
	ASoC: qcom: sc8280xp: limit speaker volumes
	drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'

Only the last one can *potentially* be considered a CVE candidate, but 
someone would actually have to take a *deep* look. Most likely it'll be a 
functional issue, but not a security issue by any measures.

So I hope it's not the case, and someone will actually be doing some 
triage. If that's the case -- is this process described anywhere?

Also, how are the CVSS-like scores going to be assigned? There are no 
details whatsoever about that in the document.

In any case, by making this change we are going to make security theathre 
industry super-happy (they will have a lot of expensive nothing going on), 
and all the distros not basing on -stable very unhappy (we're already 
drowning because everybody and his grandma wants to become famous by 
publishing a CVE for something completely irrelevant). If this is the 
intention, it should be spelled out loud and clear.

Thanks,

-- 
Jiri Kosina
SUSE Labs


