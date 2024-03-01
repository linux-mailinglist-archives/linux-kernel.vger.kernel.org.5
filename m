Return-Path: <linux-kernel+bounces-88534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075EA86E303
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC271F23008
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9A6EF1D;
	Fri,  1 Mar 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QGz6NdFg"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BC386;
	Fri,  1 Mar 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302175; cv=none; b=gzcfjZaVru3Lc4weCdj+B3mUwMnXvZmMD/QIYZBkUjHNyldTSkko1/Txsy4ap8Jt6R3cr8Egz1Y6i7jkf/E9GzvaCcnq385W8LU8hLqTUmw75ev9zTxDxmWzKm/vu2AYyfbUOc8GWRBTrzcrV9eGrkr/6JKRwH3mZIAN8Ix19nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302175; c=relaxed/simple;
	bh=RaYNpGmrVadiHjqa16S0TTjuebrAS0T3s84R9QGXsZo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U8TGNWD9U9JFyxQMNYLpUCk91BaiRCvbTT8qEc781HODSC9yiGM7WltVAjnzl4Ts2Bwaq0YQPl6GIR7NhJlwVWmTSLN1s3+OmpJnZEYFL6qSDEjL1Jr3m4T3+ClyKu0DWl/eLLxGf+0MsgWFKSQFS/dHYhKJbt1wra6Cw9fFFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QGz6NdFg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=M4txhvSoqzm+pQ0oJBM9dOgmsCgm4a9Qa3DtNoGHbl8=; b=QGz6NdFgYOJt6tyCh20RZL3OL5
	sEMIMP92ICXLgsQuF8pGcqbqEzKIjWJ0azwGAV2iTdJ9p5l85rBSdMYDxPtZlWMKZUXxJjxTF5qKL
	AJq0wBUBp5Fge74uA6laM8P+8u/yyUQFF2IRntQKDhCmXyoBbpKxOmaQNdloYfvX2Iit3eBhpZsd2
	Bhal+N9Z6PBwfMSkH3JFm+rw2n3fAA93Wq3TOWCDFWj/6pBGbCB6p/ndn9m0cZCinZooiLYYwvXN3
	EOgwkKsfUiVLoG/DjjtPpPkIREYdR0kqntuF6gTJXhUf219agrMAZd1nGtEUQ7m4bvlPPGrYs6Tqw
	jSADs/FA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rg3Zb-000B7a-Ru; Fri, 01 Mar 2024 15:09:15 +0100
Received: from [178.197.248.31] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rg3Zb-0009dA-36;
	Fri, 01 Mar 2024 15:09:15 +0100
Subject: Re: [PATCH net-next 1/2] net: nlmon: Remove init and uninit functions
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org
References: <20240301134215.1264416-1-leitao@debian.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <79d68292-6491-4664-3de2-b8ea6c21e515@iogearbox.net>
Date: Fri, 1 Mar 2024 15:09:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240301134215.1264416-1-leitao@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27201/Fri Mar  1 10:25:20 2024)

On 3/1/24 2:42 PM, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the nlmon driver and leverage the network
> core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

