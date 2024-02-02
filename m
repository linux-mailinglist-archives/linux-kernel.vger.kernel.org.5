Return-Path: <linux-kernel+bounces-50469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E784797D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476B11F27578
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40215E5DA;
	Fri,  2 Feb 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSuhIC8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053815E5A0;
	Fri,  2 Feb 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901145; cv=none; b=eKKqD1TYfPz/ClCLOUy02RgN7LxnJOHSJlSDqihOKeznkk9VMCSAJT8oDUUIQUjwAU+k/WnkP41XnndoYLpbzkpsUdlR7RCHlbwlzOamNsJrpTa+3k37s3gbgyCR6Z6sF9S9ezXj2agHoqPDKD8P5+nzxQl1ncm5u4D2g90/iBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901145; c=relaxed/simple;
	bh=hMIwEqns72Iujj9luJhjhuqzqBxbP9VSa+d1KRGXpT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daZpY/9x0CRaylLfiSIOMPZUMaRKXH+ve0Py9bc8OHbUw9w+nqyfzAro4Ni9VASU1Pz9vFHlcMln/dUXJRUEmdi4pycYkXkYUwxXbZQ0wjQO4tBh3En3+YhtoU7UTQgvPUJXtGzi6/HHyBHZ1ynkoreHWJ1F3VJsZJtxULAH4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSuhIC8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F46C433F1;
	Fri,  2 Feb 2024 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901145;
	bh=hMIwEqns72Iujj9luJhjhuqzqBxbP9VSa+d1KRGXpT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSuhIC8VVQ6atOvmR/wsOQ+bYAF+rtmOZgFQ6kLJNiIykN6l79Rw4rEQsy+nz6PmO
	 DG8sPKH+rsYAPRK5mdx83JgfMLy+FSpl8J9Ldb1t7f+g0pilhT4r7XKu3ts3FAILbT
	 e8haFZmvlZajaiUbWwZS+l+K65nV5IF7BDtkuJ1X295JI94/8QbcHst+iv9cZAMw7D
	 +L0nWPAHoVYrI9EAUhye4dz/5cMeVr/p1Ejs8EmkRIo5NJVhIaUxESPbKUme1PCTTQ
	 WQraiiX6rfWXdMzcgwPv2nfpRmXHz7t1ewHVWeC1uAqQzZpk3ywtbzYxWvZgOMjool
	 A5nAFoEWuUILA==
Date: Fri, 2 Feb 2024 11:12:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: George Guo <dongtai.guo@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, George Guo <guodongtai@kylinos.cn>,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Modify macro NETLBL_CATMAP_MAPTYPE to define a type
 using typedef
Message-ID: <20240202111223.2e0c7db8@kernel.org>
In-Reply-To: <CAHC9VhS2F8LkjRNQv7=x1DyRqDjatpuHJL5QNjqz7ru8-0Y1_A@mail.gmail.com>
References: <20240202034448.717589-1-dongtai.guo@linux.dev>
	<CAHC9VhS2F8LkjRNQv7=x1DyRqDjatpuHJL5QNjqz7ru8-0Y1_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 10:31:37 -0500 Paul Moore wrote:
> > Modify NETLBL_CATMAP_MAPTYPE to netlbl_catmap_map_t, which is more
> > readable.
>
> I'm generally not in favor of minor rename patches like this unless
> they are part of a larger effort (code churn with little benefit).
> I'm not going to block it if the netdev folks want to merge this, but
> I can't say I really support it either.

FWIW the netdev (or should I say my?) policy is also "don't take it
unless explicitly acked by the area maintainer". Looking at the patch
I'm not sure why the typedef at all, not just use u64? So whatever,
I'm tossing this from pw. Not worth expending brain cycles over.

