Return-Path: <linux-kernel+bounces-164565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D008A8B7F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837171F23298
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D5181BB4;
	Tue, 30 Apr 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ateFuP6V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2E180A78;
	Tue, 30 Apr 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500063; cv=none; b=a5tByTAjhtywVoQk7BXT1bN9rOkNmpd0MtpSxvRfk8nN7VUMjXkhb5YTNjATmKg+M05bvA9SBkMYoOF7P9pQPunm/Ya87hRWmaPartHPdKLNIPmhL3LvSs6wmaIMvKiKWx3ey4pkxPCnDCVO0qohG1b7cJ0Rv7hdUMGUiOVwAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500063; c=relaxed/simple;
	bh=3bRPnQ34aY99+yhzYatAGLiBy0BE0BuQk68stzWKZuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNuraopNNhEtbrL0BJVvi6LMFxU4ROPd0Pt32aM/6ufXdbHGm/EKOUBA9x9aNjXNgd9JVZihb9l/XCaYKDTR/Wmc2w5k58oZp586nvWCG5hJchQ2bjQeCHFLJvuFUgE2E8kBKO1FhxPdBkbvjZaYmyRqTL+kefzAOlO7L44PPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ateFuP6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A96C2BBFC;
	Tue, 30 Apr 2024 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714500063;
	bh=3bRPnQ34aY99+yhzYatAGLiBy0BE0BuQk68stzWKZuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ateFuP6VrNvXPzZf2Zahc6e12pJcGMDQBMIM35vWJHrcnS0dgLoCo9UhhAy+HvxaV
	 DFXTtMAOyf/AjqWZyO9dLNLG9rmIAizodq9HXEegq+rNeCepAfJ42d6HPYMkqpnwD8
	 GmtrYn6u4yz4DfUfcWKUNukoIIjs3kQHvk58rcK5m7+0oUwmLNjuAyqupXboF8AXLh
	 TA5IczgRuNie6rP7g+/Jyo9yIXjQ0Fd7l4GQOOkmi9AnRdmKUfRf2rdBPJEUdI4Pm0
	 lY2+JYvwzIUpFQ4orBWA9/AYqMhHG11NoyaXMyj7sT1EDgwFYWVyb9S9y/LVWBAml7
	 CuahIocj8/7CA==
Date: Tue, 30 Apr 2024 19:00:57 +0100
From: Simon Horman <horms@kernel.org>
To: Shi-Sheng Yang <fourcolor4c@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
Subject: Re: [PATCH] mptcp: subflow.c: fix typo
Message-ID: <20240430180057.GB2575892@kernel.org>
References: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>

On Tue, Apr 30, 2024 at 06:50:33AM +0800, Shi-Sheng Yang wrote:
> Replace 'greceful' with 'graceful'.
> 
> Signed-off-by: Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>

Hi Shi-Sheng Yang,

Elsewhere in the same file 'earlier' is mispelt as 'eariler'.
Could you consider fixing that too?

Better still, could you consider running codespell over
net/mptcp/ and fixing (the non false-positives) that it flags?

If you do repost then I think an appropriate prefix
would be 'mctp: ' rather than 'mctp: subflow.c ',
as this follows the pattern in git history.

And I think the target tree should be net-next.
That is, the patch should be based on net-next and
it should be designated in the subject.

e.g. Subject: [PATCH v2 net-next] mptcp: fix typos in comments

Lastly, please keep in mind that 24h should elapse
before posting a new version.

Link: https://docs.kernel.org/process/maintainer-netdev.html

..

