Return-Path: <linux-kernel+bounces-90415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9D286FED8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D3AB233A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1078241E3;
	Mon,  4 Mar 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fy+hoh8u"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87191225A6;
	Mon,  4 Mar 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547528; cv=none; b=qzobJnn3lYXqkOwZbaXMh+soH6z5LyoYN78iqjMLvEtBQlDVdukOBffEnUb0H1wLvf6/oZ6941ADnlH9KdkluNsA7LNCce1q2xZLLsKJGkxwz6DApCEPO6N/PO/8Juu41naTacq0tHa4ZypAynC6ibLstytBUFj4ES91Rwfq3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547528; c=relaxed/simple;
	bh=PJtcCbs756j5oFqV8d7Qq7eKfaIJxwawRk/fSYxEiHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYbbknxhqZ+7/RU0ucL1UadXorpDEz9wxd2VFG4Nstkoa7aI7WjzG6fF/itOTRTEs3RsxgsgMU9ZPK+zb1fAkP53Jw8Euk4hIE3E3Im83z1ZBSeP6LyccTNCD3ovdbcAGoPGROKa6edPDXgS5t+6rX1XnR5G0uZUv6vIsl1GDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fy+hoh8u; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547524;
	bh=PJtcCbs756j5oFqV8d7Qq7eKfaIJxwawRk/fSYxEiHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fy+hoh8uZ7q58A/cmDJN4kWCBUlXzQ98FWQRHMfPBPX0SrMV77ruFj0BztpL4vZ1w
	 hIBZTxwopsvzdNQzjUYlvBasvauZuIykcHJgD+yAgnsAXnvWnKcsTXGwFH9m1M2Ria
	 1qez2bz8ULvhcxQ/K1ZZ7VqjmaGoxBt8zY6F2eTNSiPdAawtEsvTd9TA3zktMkdlvT
	 eIPv8j6DTBAxGyrfMCCh1lkxXAxGP7RVFhd06Us07/mgPv4xsw86dDubcDJ7NtcGFf
	 kshlX6Pppcd5porjPYRbfBbTfR+QmK4tFB7eBwss5ribf0iyfG1iGM/77Mw/vRasKf
	 +UxC5YPpScNgg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F02FD3781FE3;
	Mon,  4 Mar 2024 10:18:43 +0000 (UTC)
Message-ID: <1244daaf-4b02-4dd1-915d-0e50ef638b6a@collabora.com>
Date: Mon, 4 Mar 2024 11:18:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: lpfc: correct size for cmdwqe/rspwqe for memset
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Justin Tee <justin.tee@broadcom.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240301144434.2809483-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301144434.2809483-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 15:44, Muhammad Usama Anjum ha scritto:
> The cmdwqe and rspwqe are of type lpfc_wqe128. They should be memset
> with the same type.
> 
> Fixes: 61910d6a5243 ("scsi: lpfc: SLI path split: Refactor CT paths")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/scsi/lpfc/lpfc_bsg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
> index d80e6e81053b0..8caf54aa20391 100644
> --- a/drivers/scsi/lpfc/lpfc_bsg.c
> +++ b/drivers/scsi/lpfc/lpfc_bsg.c
> @@ -3169,10 +3169,10 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
>   	}
>   
>   	cmdwqe = &cmdiocbq->wqe;
> -	memset(cmdwqe, 0, sizeof(union lpfc_wqe));
> +	memset(cmdwqe, 0, sizeof(union lpfc_wqe128));

memset(cmdwqe, 0, sizeof(*cmdwqe));

Cheers,
Angelo


