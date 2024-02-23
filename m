Return-Path: <linux-kernel+bounces-79319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3018620B7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05BE1C22BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D914DFEF;
	Fri, 23 Feb 2024 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ProDf81d"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419F14DFC6;
	Fri, 23 Feb 2024 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731789; cv=none; b=oczrhpnAWTBDroHpPJcRPdz9idZG0DWw5+swvVIRkBTon5JeXDcqHqBeKTcS8pqOFlm0IT3k6F+hCGAWRahBuTemtRWwG7l7qnBuu5YJ2lml9qaGgOz3J1yDPwDk5werqLddBhf43SbuV/noAUPCefN+P+Ykdc4MNqrQ4gwnciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731789; c=relaxed/simple;
	bh=yqdpYHfHFqw9BeQu7CM6p99+Ec8DqbbPN8QUcrJ5oVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTj6OJwz3KLYXTA9/sIvwSxS7+QJGK3H1MOtsflK+fmf883MB9HgrI2noG3gZfb/NE8yF8cAwHgtanrKX1amkqneH+aofsGKcQr0BX6bK+fgPHYD2kcGHULRRml3ND+Q31h9XF6XTPG6LuScXZixbnMuaJBqvbD9KCVoSVstNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ProDf81d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iN+Ry0ZlQG5XlAqHYqFp346OI4lr7dhIUmnflJV0Ov8=; b=ProDf81dNPvbZP7lSfBC/qAWSL
	04Xow+RgDW/4F1Oawy66u249WYRFZLDCGe6Gu8aZ6SQiIS/6AC/OuzRLJ/gdNlnsWEpHWpSeLomey
	hWhT8ii/HCkvEhJlU1eOCkKXlfngA87a4ZHxb6Y4/zUFJ1Qj4Vq5Vhmj+7Rp8+UfBS6qO4h5NT//F
	FAYX6slgyJU+BKOA8fr0jdE3BYwVufLsUTqBlCgPZUp12oGZKAopS8UExhkQQw4fUqhkzTdxygNuw
	FRl3q+x8koS1Ygbt1VRfna8rvFhcgDVV9BrXCvzErI+4ljO4fNZMh0ExS/v52qV6iP31fd3jkMAwm
	e69PBMvA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfC6-0000000BatW-2q5h;
	Fri, 23 Feb 2024 23:43:06 +0000
Message-ID: <59c60c30-fc4c-45e4-8c29-8344014f19c6@infradead.org>
Date: Fri, 23 Feb 2024 15:43:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 23
 (drivers/net/ethernet/ti/am65-cpsw-nuss.c)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240223154029.18368677@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223154029.18368677@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/22/24 20:40, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240222:
> 

when CONFIG_BQL and CONFIG_DQL are not set:

drivers/net/ethernet/ti/am65-cpsw-nuss.c: In function 'am65_cpsw_nuss_ndo_host_tx_timeout':
drivers/net/ethernet/ti/am65-cpsw-nuss.c:297:40: error: 'struct netdev_queue' has no member named 'dql'
  297 |                    dql_avail(&netif_txq->dql),
      |                                        ^~



-- 
#Randy

