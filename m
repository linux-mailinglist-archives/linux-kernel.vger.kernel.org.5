Return-Path: <linux-kernel+bounces-139104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B8F89FE90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CFD1F242EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E0317BB35;
	Wed, 10 Apr 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y7zAhBKb"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FD17BB11;
	Wed, 10 Apr 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770398; cv=none; b=Oh1pMwrMJjtkZrC/8y8V0EB+4yLbpgMFcEzas57G7yE5uCrWjD3iKqCTHroxDM8LA3KqOnYagIeauawtzXYMa08wl6Zx7LoUMcsgPAdTBgG/m+V2Mp/qOKLQ3FuPcycgL1P4nLQObrKHxqMqVzFdLWC5IOTs+tDYhYxgDsdbY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770398; c=relaxed/simple;
	bh=7DCCoIyxsXacknpZFdopPKDgHWQ9x05lFhZzasgtMS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icu8vuCMtBhugieqVS+adsza22QC7CPZ63eaazxDbITqOnrm7GVh9gzsrufSmL4AYb8jpnMAbHxwXNzI7aHOT1tIus3Rt6IAXBe+Kno0OUkN2bVg2OVdZDD8vl0/+ft8o5StAqP9poGO+t8CIotuagokv6zJd3VY/E7vH6Z+H0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y7zAhBKb; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VF90C5lg0zlgVnF;
	Wed, 10 Apr 2024 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712770393; x=1715362394; bh=rqxi/coHGo0Z4+SzPbCxYqpb
	cGK9u0kiEw9R4geXub8=; b=Y7zAhBKbHP6IiQYTSQpgBmcfWU/3s/uaG46h4Qch
	XomHgRSiE/gGhKaz0WecgL2EQkanQR/se2w1NvKUtdTTYXvJe3k1U+L0WrzFyeH8
	hs46hMPUExOlYukFcyyH+sonDb/VOgpL6qKoW3/G4v+qZcjNxAOPgCjXC4pEt7ED
	g/kzf6+y9ZQFktiEQ4qB18DQtZdRHbbBO/XMo7aF8KPKh7S/xxtgvqr/7fw3n/3L
	QUWTKmp2BkhEjMYPCUXvZFegLQc1ErAb0RqEHwAcJZ8qAhkBz6SzOWKD4ex+hz7v
	EuhJ4iIU5x6vwE/XsYEjvokrEDDeXprDTjiZPbTk0ILq4Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id skNfnrtP5XgF; Wed, 10 Apr 2024 17:33:13 +0000 (UTC)
Received: from [100.125.77.89] (unknown [104.132.0.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VF9075wBhzlgTsK;
	Wed, 10 Apr 2024 17:33:11 +0000 (UTC)
Message-ID: <142b9606-8871-445a-afa6-6b056b82654f@acm.org>
Date: Wed, 10 Apr 2024 10:33:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] scsi: ufs: Remove support for old UFSHCI versions
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240407060412.856-1-avri.altman@wdc.com>
 <20240407060412.856-2-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240407060412.856-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/24 23:04, Avri Altman wrote:
> UFS spec version 2.1 was published more than 10 years ago. It is
> vanishingly unlikely that even there are out there platforms that uses
> earlier host controllers, let alone that those ancient platforms will
> ever run a V6.10 kernel.  To be extra cautious, leave out support for
> UFSHCI2.0 as well, and just remove support of host controllers prior
> to UFS2.0.

"leave out" probably should be changed into "retain". Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

