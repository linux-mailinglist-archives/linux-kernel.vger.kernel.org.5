Return-Path: <linux-kernel+bounces-12931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4DB81FCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514302853EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126DA63D2;
	Fri, 29 Dec 2023 03:30:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A666101;
	Fri, 29 Dec 2023 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rJ3Zo-00FGCD-Gc; Fri, 29 Dec 2023 11:30:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Dec 2023 11:30:35 +0800
Date: Fri, 29 Dec 2023 11:30:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: chengming.zhou@linux.dev
Cc: akpm@linux-foundation.org, chrisl@kernel.org, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	nphamcs@gmail.com, syzkaller-bugs@googlegroups.com,
	yosryahmed@google.com, 21cnbao@gmail.com,
	zhouchengming@bytedance.com,
	syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] crypto: scompress - fix req->dst buffer overflow
Message-ID: <ZY49WwEB/iAdaRB6@gondor.apana.org.au>
References: <0000000000000b05cd060d6b5511@google.com>
 <20231227093523.2735484-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227093523.2735484-1-chengming.zhou@linux.dev>

On Wed, Dec 27, 2023 at 09:35:23AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The req->dst buffer size should be checked before copying from the
> scomp_scratch->dst to avoid req->dst buffer overflow problem.
> 
> Fixes: 1ab53a77b772 ("crypto: acomp - add driver-side scomp interface")
> Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000000b05cd060d6b5511@google.com/
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v2:
>  - change error code to ENOSPC.
> ---
>  crypto/scompress.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

