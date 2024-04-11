Return-Path: <linux-kernel+bounces-141479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB58A1EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73A51F2A60A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670C3FBAA;
	Thu, 11 Apr 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="29zMudxn"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A92E648;
	Thu, 11 Apr 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860379; cv=none; b=Ys3htqDW5hn7/Ps2VLe1dHqWq/XgB/yb56o1ixn6sfnOtutTuCnFsTk8lPmcPNisNsmG9WW7EWp4pm/AII7fLgHSndfiEKFCrhrTxFD4uEgukslTa7rxAckCh993GNRro+RZfBISIrLCpMBUlJM9chqMsQYeHGGpqLbWmPeRzyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860379; c=relaxed/simple;
	bh=PD4Rq4W481XE02wN1L8egVrSphLnZDE/5wUQV1tuxoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gphOh7uOLlE7QmNh8W3qLTmLn4Q1kdHFMl541pObQq6neYBe3U4Tf9zR3BDUTJfDSZDqJ+Da5AiwXZNTAuG9H7P7kz+/+ZDfTKqaSCFfuBIc27SaPuMMmugnCDxDyiT8QgkrM/1V9ylmdIEpZy183kHQNGkHtgqje8QINq+EJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=29zMudxn; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VFpGd0Y7Rz6Cnk8t;
	Thu, 11 Apr 2024 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712860374; x=1715452375; bh=joEZF4PZ/4PCQq6e7Lo+KVIu
	C23IHujteHggRqCxv0s=; b=29zMudxn/gxyq7ijpfFZeUBn8zAKy4MAF6VTdxoI
	YVEJdtR4DsiWGaCtphgyjWIHGEfs4b7nCT4+kZsoJf0m5Q4GIlm2mOFxwu1RDW/5
	aaGvOCLJ7GolNI3H90J13zkjPvVcNeVGZVOLqR79g9/qV4KncGwykWM0wsVyqRU3
	8ZnZKeSC/FBti+3BtsFhD9LxdYsqq2TedtFdXTUTH+BiPlOcO0970+6+1VGFI5zF
	G8Jz0nZ7eMwVKRTTgMjBQfZlL4Nad6sVRVqtcoFa1KXqLxD4A3kQR/UgLPFwoOx5
	zp0z39M97qUwQSDZGcoySiRiLTuDyRbuOrcS9r45/LVNUw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id q49H48TrprJT; Thu, 11 Apr 2024 18:32:54 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VFpGZ08t6z6Cnk8m;
	Thu, 11 Apr 2024 18:32:53 +0000 (UTC)
Message-ID: <df5244be-f4de-451a-8bef-e2816ab6660e@acm.org>
Date: Thu, 11 Apr 2024 11:32:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] scsi: ufs: Remove support for old UFSHCI versions
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410183720.908-1-avri.altman@wdc.com>
 <20240410183720.908-2-avri.altman@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240410183720.908-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 11:37, Avri Altman wrote:
> UFS spec version 2.1 was published more than 10 years ago. It is
> vanishingly unlikely that even there are out there platforms that uses
> earlier host controllers, let alone that those ancient platforms will
> ever run a V6.10 kernel.  To be extra cautious, leave out removal of
> UFSHCI 2.0 support from this patch, and just remove support of host
> controllers prior to UFS2.0.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

