Return-Path: <linux-kernel+bounces-58068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD384E0D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469B91C22759
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BCE762D5;
	Thu,  8 Feb 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oTLW0/Aq"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10866EB4B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395977; cv=none; b=L5EE3RG+KxapS00Q7plH3POIeXd8FdkmrwF5yVsQ+y3sduYfSSGCo8ykCJA1Xw7T6DVO5vsCSdNGiQqhe7mK9xmp1UJxfRBqQvJClNt82q5N+7fEO1QDhbm6ZfwSdaEcbvGB8OVxQhISDWv/W1jSx5hJVSrWYna+T1BWd2RjLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395977; c=relaxed/simple;
	bh=OzNXrJ5+9OpNuA9ipO7wxu3F9ctAhrYZRnDK/Tv67Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opwNG/Z6pwQIKfZaYVFdnQDlWr6JiW7yZrZ3ULEPNeyaXgXY7q0TM+sWdz1gISVJCTAvphkCuLHcnpUrB0kwauWMosxsirvd6vUDcJlsiYetWc8E7oINQZdwKOJ3tj5Abm96UZwyOef5PwZurMM7WBz7xLe2QW0B9lBrmh7WdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oTLW0/Aq; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f39d8e56-9ac1-42b4-bb2c-1bc97a0f43b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707395973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcrQZM6hkz9cDN50WEOYiQeKHL6phEi9SN4MfmJRdz8=;
	b=oTLW0/Aq6yHNneUku49o4IepEiehnecTWP2EMLydr8ex5Tc/6dqzt/twNlK+IciP7YecPB
	Xz9JGKnUYMlk4rdhscKtrauZD5jTUWmMJU927GHxHcZz2DBX3o4hd+6/2vKepOu/Lonv2z
	k/D0wWHf5Du7W8a05MQiXR/JdnNpNi4=
Date: Thu, 8 Feb 2024 12:39:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] drivers: net: xgene: remove redundant assignment to
 variable offset
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208122012.2597561-1-colin.i.king@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240208122012.2597561-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08.02.2024 12:20, Colin Ian King wrote:
> The variable offset is being initialized with a value that is never
> read, it is being re-assigned later on in either path of an if
> statement before being used. The initialization is redundant and
> can be removed.
> 
> Cleans up clang scan build warning:
> drivers/net/ethernet/apm/xgene/xgene_enet_cle.c:736:2: warning: Value
> stored to 'offset' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/net/ethernet/apm/xgene/xgene_enet_cle.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
> index de5464322311..8f104642897b 100644
> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
> @@ -733,7 +733,6 @@ static int xgene_cle_setup_rss(struct xgene_enet_pdata *pdata)
>   	u32 offset, val = 0;
>   	int i, ret = 0;
>   
> -	offset = CLE_PORT_OFFSET;
>   	for (i = 0; i < cle->parsers; i++) {
>   		if (cle->active_parser != PARSER_ALL)
>   			offset = cle->active_parser * CLE_PORT_OFFSET;

It looks like more refactoring can be done here.
"if (cle->active_parser != PARSER_ALL)" is static, no need to check it inside
the loop.


