Return-Path: <linux-kernel+bounces-11719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D2081EABF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD7B22095
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2A9F4E0;
	Tue, 26 Dec 2023 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vtgjSBSr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236055662;
	Tue, 26 Dec 2023 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3H/1RRd1XOIP8CyxnN2rk2DU6zvL5/M+2Ri29BKwNJ0=; b=vtgjSBSrCl8feTLHRbFNkyT1EF
	Puh3gh/rf4win03QkjnardFOxjGgamazIIFpBK3NJzkq50duh99JBIajgECht70ldjotE+uEJbRNE
	eQlnTF87dqgqolSc3gyrZsLFKY1s90LPz+oCt2Qah/7shB+21KRGfZw+IaqR1FN+CxIDVA1VOY4wl
	v+uVvivSWA2B7DtumJUX5BPzjInOjW7/mJwYCf6VN3in3nGj4rN05gdHf2GBVmnHmTVVbuaKD8uox
	shyvuGLV7iE5STpT0WHZOfOzxSH87AysV9EVkcOPXAUSzXxjGs/uP8M6qjs36fNyRmzZ0KP2Mestz
	X5wE9nZA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIGjD-00DesX-1H;
	Tue, 26 Dec 2023 23:20:51 +0000
Message-ID: <fadeaa0b-e9d2-4467-97ad-63ba8f7d8646@infradead.org>
Date: Tue, 26 Dec 2023 15:20:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xprtrdma: removed unnecessary headers from verbs.c
Content-Language: en-US
To: Tanzir Hasan <tanzirh@google.com>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20231226-verbs-v1-1-3a2cecf11afd@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231226-verbs-v1-1-3a2cecf11afd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/26/23 13:23, Tanzir Hasan wrote:
> asm-generic/barrier.h and asm/bitops.h are already brought into the
> header and the file can still be built with their removal.

Brought into which header?

Does this conflict with Rule #1 in Documentation/process/submit-checklist.rst ?

> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  net/sunrpc/xprtrdma/verbs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 28c0771c4e8c..5436560dda85 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -55,9 +55,6 @@
>  #include <linux/sunrpc/svc_rdma.h>
>  #include <linux/log2.h>
>  
> -#include <asm-generic/barrier.h>
> -#include <asm/bitops.h>
> -
>  #include <rdma/ib_cm.h>
>  
>  #include "xprt_rdma.h"
> 
> ---
> base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
> change-id: 20231226-verbs-30800631d3f1
> 
> Best regards,

-- 
#Randy

