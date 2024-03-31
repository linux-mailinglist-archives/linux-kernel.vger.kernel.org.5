Return-Path: <linux-kernel+bounces-126249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF2893439
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B88B237C0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BFA15AAC8;
	Sun, 31 Mar 2024 16:41:34 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E7015A490
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903293; cv=fail; b=sqaBDR+nxchmOROlufaOXp6kPJfTWRX7UYiYE9nQc655Gmav+B4f1+Jjy8zLLnrgn2yL+pXftnm2Sg0i/e111jwCf8Rgq5hwYORyx6b6jpK5pLnE2NfOBbLcIrq8SkGQauN2PEFnT96XBe9vaOjImcJ6hE5qSkOYu+xUg9p7xNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903293; c=relaxed/simple;
	bh=rGn4vL9+asmP70dMTI/LIUbfHclY24B3bM9CP8QSGHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUgEdjqYugDBi71Pn84ZiATAQ2r+C8uksNSW1mnXLTq9htV83v00X0qdN8pBKfE8748T3MLFvMSBVn+4F9oP83dKfEWOMY5NN002Q3FAGlJHwxljJTPDc6iUb9Mn91o53mVcJhwTuchYakdYBr5pkw4a94qPuEX0A2/bfkCp+zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=fail smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sina.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C31B9207D1;
	Sun, 31 Mar 2024 18:41:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bcG-KYukr1Ph; Sun, 31 Mar 2024 18:41:24 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 19F6B208AC;
	Sun, 31 Mar 2024 18:41:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 19F6B208AC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 0CEEB80005E;
	Sun, 31 Mar 2024 18:41:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:12 +0000
X-sender: <linux-kernel+bounces-125968-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoA2XEFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 8028
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125968-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6F3A3207FD
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711866372; cv=none; b=LaqTbeno/fnzT1OnBSfQjhnHN5rIUFN0SkZP3DJ0m+MOGApZ3XtpgYhDSprXAn2PUnwY+UtR8t2hlOZBDpqox+nOFKQH+SPy0O+26ofWbGxPMCSfUlBn244EVgPa3NNXKWKkHMZJ0enWoP5zYTF9bjf2UN968ILnoBoG+BAHjl0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711866372; c=relaxed/simple;
	bh=rGn4vL9+asmP70dMTI/LIUbfHclY24B3bM9CP8QSGHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWCR86RLbU9TQesl2oCZ3cVCRcv3o+Lci5z3/cXmZ8+fF9mEKmiAiwPsKvFslLfLWmR5AS+B7ZN9qa3xmDqKWPI3uJAmNlXEBj/XvPa8FKSEs6SGt+T/Y7/KFnG7mRug4UKVoY6Zx64+sfKoc45O68F0xOIJ4yRNdyDI0Ss5Aec=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 29318145089346
X-SMAIL-UIID: F8131F5289424113AB8638F7DD5264EF-20240331-142331-1
From: Hillf Danton <hdanton@sina.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>, "Alexei
 Starovoitov" <alexei.starovoitov@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Date: Sun, 31 Mar 2024 14:23:14 +0800
Message-ID: <20240331062314.3394-1-hdanton@sina.com>
In-Reply-To: <ZghSHWexmBHXpyA-@pc638.lan>
References: <000000000000f2f0c0061494e610@google.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, 30 Mar 2024 18:55:41 +0100 Uladzislau Rezki <urezki@gmail.com>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d9642dd06c25..8867aac3668c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3467,19 +3467,19 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	 */
>  	kmemleak_ignore(ptr);
>  
> -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		schedule_delayed_monitor_work(krcp);
> -

This is not enough at least WRT run_page_cache_worker() [1]

[1] https://lore.kernel.org/lkml/0000000000007a44120614e27cb7@google.com/

while the reason why syzbot failed to catch the zone->per_cpu_pageset in
setup_zone_pageset() in mm/page_alloc.c is trylock [2]

[2] https://lore.kernel.org/lkml/000000000000a5ee4e0614ee586e@google.com/

>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
>  
> -	/*
> -	 * Inline kvfree() after synchronize_rcu(). We can do
> -	 * it from might_sleep() context only, so the current
> -	 * CPU can pass the QS state.
> -	 */
> -	if (!success) {
> +	if (success) {
> +		// Set timer to drain after KFREE_DRAIN_JIFFIES.
> +		if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> +			schedule_delayed_monitor_work(krcp);
> +	} else {
> +		/*
> +		 * Inline kvfree() after synchronize_rcu(). We can do
> +		 * it from might_sleep() context only, so the current
> +		 * CPU can pass the QS state.
> +		 */
>  		debug_rcu_head_unqueue((struct rcu_head *) ptr);
>  		synchronize_rcu();
>  		kvfree(ptr);
> 
> 
> --


