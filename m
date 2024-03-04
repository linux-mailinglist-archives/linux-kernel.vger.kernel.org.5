Return-Path: <linux-kernel+bounces-90418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F086FEDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B07283B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C9381C6;
	Mon,  4 Mar 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OCgp2CoX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1936B1E;
	Mon,  4 Mar 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547570; cv=none; b=RDKdyAJ7yEq3X8crlzwUlm1WFnTeuKprkeuoyWRbgB1Y5/TK3vsqMCqCMs3+igDUGIRYDy/p7YtyxCy9Rcs0nHoKH1MlF/848rWtq6AbQ91jYl36UJOmRLwC6V+ZjA9Y25acXQNXPdacewRYSc/d0GjZ8VARDXgY/Qw/mV6wWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547570; c=relaxed/simple;
	bh=2tdXFc+wFoh0S61YBR4n4vOfCj58NEEN6Q6jc6GNThk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfavXTayAyn6kpuFRNaCw0fR+dbhkpTaEivDMlg0Pi8g+jPcw4ZRrZzZjQTbL2k3Q20kXlIlLhEpd9DTdjnx6LyanLv67l5ZXVIhB4+0Sf5X4qf2GbK+UAkOPTrgc3XeWPecdAgYV+7Gy9dKvLLuPN7GijSgzo6V26rPoE9fWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OCgp2CoX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547567;
	bh=2tdXFc+wFoh0S61YBR4n4vOfCj58NEEN6Q6jc6GNThk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCgp2CoXn9VBAcCUQ1SKG2JEL8s0SMWKGy24jlvKpb/dKePe4RKruvzpHXCG6z1n3
	 tOnEBCh6oxrM22tJlL1vSKzVJucsYlwj6Z3nkYtjje16hS/Mbsz/oOLhMJh6XQuE27
	 A455RHb/jX8N97Dnhw5mUq/+RqMxcgP+4U0B2mZP3pZU+pl0wCPdV/t9mrkMqgvurr
	 GYaYa0jGubL2Ne11YhMXUZQpkK/fmEty8jVglek+6LAPjG4GENJxpk9/Ff05V0lBWV
	 EvF1msgkmtALzclCYRpQAVl/yU/VA6T3qgzgpgVx4Ux6hiYG0XWEj96Q8QlzfhghR7
	 UD6eRH592kUhw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C7A8A37813CB;
	Mon,  4 Mar 2024 10:19:26 +0000 (UTC)
Message-ID: <9cb2001f-77d5-47c3-9e8a-588bd83b01df@collabora.com>
Date: Mon, 4 Mar 2024 11:19:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: lpfc: correct size for wqe for memset
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240301144458.2810597-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301144458.2810597-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 15:44, Muhammad Usama Anjum ha scritto:
> The wqe is of type lpfc_wqe128. It should be memset with the same type.
> 
> Fixes: 6c621a2229b0 ("scsi: lpfc: Separate NVMET RQ buffer posting from IO resources SGL/iocbq/context")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
> index 8258b771bd009..29bc6cd10fd69 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.c
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.c
> @@ -1586,7 +1586,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
>   		wqe = &nvmewqe->wqe;
>   
>   		/* Initialize WQE */
> -		memset(wqe, 0, sizeof(union lpfc_wqe));
> +		memset(wqe, 0, sizeof(union lpfc_wqe128));

memset(wqe, 0, sizeof(*wqe));

Cheers,
Angelo

