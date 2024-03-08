Return-Path: <linux-kernel+bounces-96505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80269875D32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9BC283417
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E842E62B;
	Fri,  8 Mar 2024 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG6sTqAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221882C857;
	Fri,  8 Mar 2024 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872527; cv=none; b=ZbyFwqzuWwJac3lhyFoMSbETwRgdZzZkT3TeZL9wCLrO5ePmO/sUyvr0oP9iJX39Hwh+SRBC7gzSHPTBCNKsnVVmFmzIJf79BLt31NEeZfmg5sbSyn8/IDdZqTjKD6kNH9oALp/PDs5ZXeNp25jhRYbfyBJDoOhk171i1USsZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872527; c=relaxed/simple;
	bh=yWj8/hJqPE2pqJgHPZirhlHTQyI5nLVSmlITFRiJKhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kn+4Yo/l4sdyK2JOqJhSmxsBZ4vZSu/NjNfx2pROCc+nwgyZGCWJetPT4e7XTrYzWxg55rz81a1xtH1rN7bPcEg6J98WjcY6D04GCWtIQDLLnjJCF0jXMlABg24CMbxXh8/TzmV2dqdqhB6i/DNbRrOlz2NFtn1VLWyX/B93Yk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG6sTqAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A2CC433C7;
	Fri,  8 Mar 2024 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709872525;
	bh=yWj8/hJqPE2pqJgHPZirhlHTQyI5nLVSmlITFRiJKhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KG6sTqAVccTzyQVqJPgFwKf0HZaMVOmfOGKHO+x0y/KO68MOCkch9Wk/trnPYOZZK
	 5fJl/XO5ILc2Na3wEuDfy2AOO6gA0/DZpS6IUyFX8J7/a4vFsiHm61KnuPyuS7fDiX
	 KilQSjdLr/DI+1KTpCiDcAlU5WnwLRAYo3fJWWhpwhxprAjWsoQptsF6FJ1UUvcT1i
	 sRo9IBoyXEmus+NX9WEEWLtB+Nx/T/0rst7n7qf62GhJ3X09UgrzJ2Nllr7n+YdWYW
	 g1iMgN6hCJQNFnF28ZqL9Y/AmEL8UuCF1JJV18IKJuw9c77JLy+2f1eprEE1VOGXKW
	 TNnS7dQGmsDkA==
Date: Thu, 7 Mar 2024 20:35:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] Doc: netlink: support unterminated-ok
Message-ID: <20240307203524.34895501@kernel.org>
In-Reply-To: <20240307070106.1784076-1-liuhangbin@gmail.com>
References: <20240307070106.1784076-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 15:01:06 +0800 Hangbin Liu wrote:
> Subject: [PATCH net-next] Doc: netlink: support unterminated-ok

I'd use this subject:

	netlink: specs: support unterminated-ok

> ynl-gen-c.py supports check unterminated-ok, but the yaml schemas don't
> have this key. Add this to the yaml files.

> diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
> index c58f7153fcf8..7094d619cbb6 100644
> --- a/Documentation/netlink/genetlink-c.yaml
> +++ b/Documentation/netlink/genetlink-c.yaml
> @@ -208,6 +208,9 @@ properties:
>                    exact-len:
>                      description: Exact length for a string or a binary attribute.
>                      $ref: '#/$defs/len-or-define'
> +                  unterminated-ok:
> +                    description: Allow the string to not use terminator.
> +                    type: boolean

Can we expand the doc a little? How about:

	description: |
		For string attributes, do not check whether attribute
		contains the terminating null character.

Also maybe let's leave this out of the spec for:

	Documentation/netlink/genetlink.yaml

that spec is supposed to be simplified, supporting both string flavors
just complicates things.

