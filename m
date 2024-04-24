Return-Path: <linux-kernel+bounces-156212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D28AFFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12649285D74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065B13AA38;
	Wed, 24 Apr 2024 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ti+9iZ2b"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9F13340B;
	Wed, 24 Apr 2024 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929459; cv=none; b=Ljq6sndsozzbgj2Zfe8XvcLXhzGDVQ7HKLOz04AMtIqRzQpKYlTXOGCKCwNaTiaIRcGCVyVE7CKifrD2yf6rY2Z/BZzKqRdQof79FN7MWiYLWj8joXOZ4zHrHFuV89bTAJbamSRtCCTTj2cKUrb0y7usWoGyMfg2tCaw49/Jts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929459; c=relaxed/simple;
	bh=rKi6NN48wepECtBpXiA7bU1rkNQhpJjd3bV4sNW0FT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oayst/9mEd7ELbpWnmGrXk87ogmImp8HKT1quEfsp4o28K7suQzZ3sCK2/c0n71QefnWgMHeNM0l8vURqBmINONAWpvuxBCdC6XL83GTWj76t+XdzvTsjXdx4Z6E+K9x/BSQnlKJZiF5aZHRxuvtgZZ91jj9qccq+t4RrrkfWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ti+9iZ2b; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713929454; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RAITW8Q5G1SlFKuL2iNYgoTd3KgsFZ6WJdYB4NCuFC4=;
	b=ti+9iZ2bA6B9Huev8dpdGwNDZf+NL0ixy4jp7fJkSJnzsV3oCMN17SQSZiyqzHJwZR0FZ7JDo1raq2fAZPoVO1BxO2wrF2CnGn7wv4DfWJUJcxccnG5NrHvBV8LFZItcaUC7+AlfSiGZO4iGReGFkMgjndlXTq3wQbsk4DQKSOk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5AojMt_1713929452;
Received: from 30.221.128.184(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0W5AojMt_1713929452)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 11:30:53 +0800
Message-ID: <a4d38a49-9629-4ee0-9eba-4d45abace30d@linux.alibaba.com>
Date: Wed, 24 Apr 2024 11:30:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ocfs2: remove redundant assignment to variable
 status
To: Colin Ian King <colin.i.king@gmail.com>, akpm <akpm@linux-foundation.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Heming Zhao <heming.zhao@suse.com>
References: <20240423223018.1573213-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240423223018.1573213-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 6:30 AM, Colin Ian King wrote:
> Variable status is being assigned and error code that is never read, it is
> being assigned inside of a do-while loop. The assignment is redundant and
> can be removed.
> 
> Cleans up clang scan build warning:
> fs/ocfs2/dlm/dlmdomain.c:1530:2: warning: Value stored to 'status' is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlm/dlmdomain.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
> index 2e0a2f338282..2018501b2249 100644
> --- a/fs/ocfs2/dlm/dlmdomain.c
> +++ b/fs/ocfs2/dlm/dlmdomain.c
> @@ -1527,7 +1527,6 @@ static void dlm_send_join_asserts(struct dlm_ctxt *dlm,
>  {
>  	int status, node, live;
>  
> -	status = 0;
>  	node = -1;
>  	while ((node = find_next_bit(node_map, O2NM_MAX_NODES,
>  				     node + 1)) < O2NM_MAX_NODES) {

