Return-Path: <linux-kernel+bounces-61851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333785176C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FEBB24480
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787803C47E;
	Mon, 12 Feb 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="onVHkagI"
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B83B794
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749818; cv=none; b=AcFIjMja0MTi6E4DtWABTeKaHSZfLsiOyXtjZvquiTn97EDwiSG9LZIZQtW8q5zN3ycYFEJ+XHTdWEl0K3Y6qy687kT5vOzxi6KNhnM1cwDhVUY9lnFNvrWLqcmy+FIaUjr8Us5d92g+mW55A6typWHoiBje5SbqqKoNotJz4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749818; c=relaxed/simple;
	bh=mIgH+62Czxn0zOGC90bP7jhU4ojrsunV2HH3ooIhVik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUUzNftqhiGRnK1VnurEYoj0QkrrJB7Gf25rALzL4WugoWsuj3WN2YNd1EW8TdX8zwP+OkkiH1OGBo6r6f/xhkIx3lclRrn+Px/b/xJwKn4Z/tVvgTIVXakgRAXzH81FbO/XFbWzfBi9FsrCibhARwmh6X3uFs6hcQNCqORymfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=onVHkagI; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1707749815; x=1708354615;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=4qSXVVeU29hJQju/8dYCIyz+nhki1n3Fml
	SUSu8iLeo=; b=onVHkagIPXYrYJtKmeMlYHAtZAOv2THxJmUuOzaD0kDGqSv5kA
	MTtrKoKWfZ1bWAidHntTsuJj6/neJwqoG0GMnTwzkBDbbwDJYKAykU+ZKW8pW54h
	0nUir8kwCdfqnJYxM0JnLx93NRk31E+cd8v0iDpTjU7l+OGG0YZO1+f/s=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Mon, 12 Feb 2024 09:56:55 -0500
Received: from [IPV6:2603:7000:73c:bb00:ad13:1ab2:8f50:ac1d] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.2) 
	with ESMTPSA id md5001003800600.msg; Mon, 12 Feb 2024 09:56:54 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Mon, 12 Feb 2024 09:56:54 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:ad13:1ab2:8f50:ac1d
X-MDHelo: [IPV6:2603:7000:73c:bb00:ad13:1ab2:8f50:ac1d]
X-MDArrival-Date: Mon, 12 Feb 2024 09:56:54 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=177267bb54=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Message-ID: <272e2048-85ca-4429-b3dc-b2434318dca4@auristor.com>
Date: Mon, 12 Feb 2024 09:56:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] afs: Increase buffer size in
 afs_update_volume_status()
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>,
 David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240212083347.10742-1-d.dulov@aladdin.ru>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <20240212083347.10742-1-d.dulov@aladdin.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com

On 2/12/2024 3:33 AM, Daniil Dulov wrote:
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
> index 020ecd45e476..d4a379bfd54e 100644
> --- a/fs/afs/volume.c
> +++ b/fs/afs/volume.c
> @@ -353,7 +353,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
>   {
>   	struct afs_server_list *new, *old, *discard;
>   	struct afs_vldb_entry *vldb;
> -	char idbuf[16];
> +	char idbuf[20];
>   	int ret, idsz;
>   
>   	_enter("");

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>



