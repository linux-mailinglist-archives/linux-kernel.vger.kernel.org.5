Return-Path: <linux-kernel+bounces-60882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E573850A90
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9F282AEB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3305CDEC;
	Sun, 11 Feb 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="TDjYzCt4"
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4985B681
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707672627; cv=none; b=pAtLFUpvCOKvmco9XCnCpLWMck1iMQ2M7NP1qf3eA8DzyprChZ7eb3l9CyyZgPKj6qFAQKeAi1eapIckY8k6Sj+hhwQVlmJi/TK/yU52Jt7g9wm1q2kVRBiOxfh81HvGN8mj1OrqPOlwVebYwv3OIoNrgc8gceVVTGHk83+A2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707672627; c=relaxed/simple;
	bh=r55Ri0PF4R8/e36BiD2ImyC+X6kPvh5lUYq/2k9xvoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eble1qdfnQfz4mJs5fCANqslGYZlMWEmQLt1r5qxlHJ/1qjoPYAbQzjw+MQdR0gy2Ete/pFawjcCDAQGtkvPaig01dYQP4AV+WNr1LyAwdI4yJxI0Zpo7B6RT4E3PRkAJOEPKVHGOprFePwswjKR6Fv1NQzlpjTob0ggb4YdoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=TDjYzCt4; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1707672278; x=1708277078;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=hpRo1l53+3UJrUmq4UdLNyJbdET60xEc63
	/mQjUiDP4=; b=TDjYzCt4PyRpNS6io4wOVgHTnBsp9ur4snAGfGsotJjqGdHjXb
	ivzTtE5yLJT+twnfnPwgvM8F5b86ytUiK4UNBmDoMZde3FVjQlIOnWFMOoA7dlD0
	qFMavb9aoBJkDvlCFcJXTu4dl2riAPIT/xUsSW6fK2bT2hIjqAa11rr8E=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Sun, 11 Feb 2024 12:24:38 -0500
Received: from [IPV6:2603:7000:73c:bb00:a536:e7f4:fea8:4638] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.2) 
	with ESMTPSA id md5001003800186.msg; Sun, 11 Feb 2024 12:24:37 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Sun, 11 Feb 2024 12:24:37 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:a536:e7f4:fea8:4638
X-MDHelo: [IPV6:2603:7000:73c:bb00:a536:e7f4:fea8:4638]
X-MDArrival-Date: Sun, 11 Feb 2024 12:24:37 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1771484435=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Message-ID: <735172b1-1267-43e7-a2af-8596d849760a@auristor.com>
Date: Sun, 11 Feb 2024 12:24:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Increase buffer size in afs_update_volume_status()
To: Daniil Dulov <d.dulov@aladdin.ru>, linux-afs@lists.infradead.org
Cc: Marc Dionne <marc.dionne@auristor.com>,
 David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240211150442.3416-1-d.dulov@aladdin.ru>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <20240211150442.3416-1-d.dulov@aladdin.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com

On 2/11/2024 10:04 AM, Daniil Dulov wrote:
> The max length of volume->vid value is 20 characters.
> So increase idbuf[] size up to 20 to avoid overflow.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>   fs/afs/volume.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/afs/volume.c b/fs/afs/volume.c
> index f84194b791d3..9d0da38bbcf6 100644
> --- a/fs/afs/volume.c
> +++ b/fs/afs/volume.c
> @@ -302,7 +302,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
>   {
>   	struct afs_server_list *new, *old, *discard;
>   	struct afs_vldb_entry *vldb;
> -	char idbuf[16];
> +	char idbuf[19];
>   	int ret, idsz;
>   
>   	_enter("");

Thanks for the patch.

The commit message says idbuf[] is being increased to 20 chars but the 
patch only increases it to 19.

Should idbuf[] be 20 or should the commit message be altered?

Jeffrey Altman



