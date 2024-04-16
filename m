Return-Path: <linux-kernel+bounces-147458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18F8A7478
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D3C1C21CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB215137C39;
	Tue, 16 Apr 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fx8QpHx7"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6F137921;
	Tue, 16 Apr 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295117; cv=none; b=S01ohVwhoBBwkz7vS9i6Vx7WnsJNVB77Eh6qNpk1joubxZOL2Yj6LGZiuqTUnesDjNCMe8YEnlz+dd88+YbIKRMRdq98B4HAVCRAFxe7ERy/SfGe7qbVdR6I/gfU3jmKPoiKB/KjhqLURKMx+bcDFbUXeOP4aol0nK2JwlSRRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295117; c=relaxed/simple;
	bh=eFsQnwS6PGFtgDcFaHJVKvrfFzDGNqbI1upRmAGSdUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zefl1IMeAE2ZuHJIeYFuQlsuTAt8gL/UQwhKNwiKc5XPZePJLrXefg7Unh3acPFLjOhbxGXKbpYXpT+RHT2OTo71SwG9SPXg6ufg+eEhbyCpZjfcA0xYaK2KawEJEdiux+bG3uMD6eWsf+tacV0Q0XNI/BGbvL03S6/pwHxwgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fx8QpHx7; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VJv2s5Ty9zlgTHp;
	Tue, 16 Apr 2024 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1713295108; x=1715887109; bh=eFsQnwS6PGFtgDcFaHJVKvrf
	FzDGNqbI1upRmAGSdUs=; b=fx8QpHx7MdXz4DWNF5sKx2pET/oKMw17BAId9stL
	5lzAFPohxQeKZACWn35Z8lu+Ne42NFD8qXLHVetH5fTj1WFay6FH1Gfn/XoYRCKx
	kEYjzppO5JLFiPFgqOIcYv1hRVcxoy+yoL6LB9e8FQT8QgyxCPb8qFiv2vo0laLq
	/+sX5Uc/C0O7KWaFLCidfxjTC1Xu2wpCB1soWkDo6WptScusk9a38o+3Zf90YLEu
	HOBCLE0o5RKQaDzZ/SnkeEumTTSmZliH1sY2f5G7OSVCbTZfBi4umZWPkczglsW9
	Pr7t9qwMb1oSjIo5s0agNOQYGEhfWupQHcPtSrFWZEl31g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gvqFSUSqaQat; Tue, 16 Apr 2024 19:18:28 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VJv2q3mZZzlgTsK;
	Tue, 16 Apr 2024 19:18:27 +0000 (UTC)
Message-ID: <0b031b8f-c07c-42ef-af93-7336439d3c37@acm.org>
Date: Tue, 16 Apr 2024 12:18:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] scsi: ufs: core: Make use of guard(spinlock_irqsave)
To: Avri Altman <avri.altman@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416102348.614-1-avri.altman@wdc.com>
 <20240416102348.614-2-avri.altman@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240416102348.614-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 03:23, Avri Altman wrote:
> +#define SERIALIZE_HOST_IRQSAVE(hba) guard(spinlock_irqsave)(hba->host->host_lock)

Something I have brought up before: what does the host lock protect in
the UFS driver? Rather than reworking the code that acquires and
releases the host lock, all uses of the host lock should be eliminated
from the UFS driver. The host lock should be replaced with new locks of
which it is clearly documented what member variables these new locks
protect.

Thanks,

Bart.


