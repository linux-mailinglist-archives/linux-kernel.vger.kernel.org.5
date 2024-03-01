Return-Path: <linux-kernel+bounces-88740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C85486E5FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A01F21FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30565C158;
	Fri,  1 Mar 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BgAs5u5J"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0D4C9C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311177; cv=none; b=h4pXz0FnTiLuMznjagR399YeXjp4pMheFgch1kHtqhOxf6DK3G+HVmM2MePS/ozncz1YYmlIB+cy3FO5F3Xaj/B6g+ymdGw7g7lAgtyBqvs2S8lmxZOr4hLcCp3UOSmI9I9dlXTMkZLHh8WwmW+mXM0jk1u1fgnz3fliNMG5TI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311177; c=relaxed/simple;
	bh=4LCWmAiman5r71J5/XB8evn4nHCvsyVvo6RCk/szjFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efOyMSfgi3G5+RpiemLsFoUKUkdV2hhArO2uZKL+97LFsd/Q+0eKeqZa+rX+JxXjBNGPYxVECc1nYYOa4KEcEGy2Li+uHENqHkgcpdgB7efaBTNJu2Yl2VjXpsqfqd0ORslxzvHAahiaHFWohBFwVzb1WoVrr3s+y4LJ2q9ZngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BgAs5u5J; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id g5utrzXJF9TLjg5uurqagy; Fri, 01 Mar 2024 17:39:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709311166;
	bh=RN0U8d0tLa6K7dQm1uz+etryBFOWXolWyCXCTbp29Xc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BgAs5u5JiucHRHyG36DPlbfHDTpaH9GYNXjVbAyrtDqgAsWeQixQlDa52jAj/vZyt
	 PJoc0ZSd1Qmbw3Cskch4mFqBQ3gBNWM4DqAm41gjROvQMOhCE8MO6u8R9jNQCZ4F3L
	 pWAjeljun8RB/RiiyoBUet3QhosyKgbqqHG7Bsg1grO8j7C8dROxORtjjyy++nRMx7
	 HLLbcXGx7iGSxhSTCxF7Mly/e8hGbSANoyFBynDUtZWXPFX9j9tbIX7CPNkQfcZo2l
	 snQ7UkRUucD8xh9ydtYFCaIQJznQ3trlz65yJ4sFc+iRUdqJdRuli3c1sPpkH4m7KX
	 TFwKlgn/Y0XjQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Mar 2024 17:39:26 +0100
X-ME-IP: 92.140.202.140
Message-ID: <5a0172a7-1a02-47d4-86c7-f5fd22e9767c@wanadoo.fr>
Date: Fri, 1 Mar 2024 17:39:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: lpfc: correct size for cmdwqe/rspwqe for memset
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
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240301144434.2809483-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/03/2024 à 15:44, Muhammad Usama Anjum a écrit :
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

Hi,

maybe even:
	memset(cmdwqe, 0, sizeof(*cmdwqe));

Same below and in your other patch.

just my 2c,

CJ


>   	if (phba->sli_rev < LPFC_SLI_REV4) {
>   		rspwqe = &rspiocbq->wqe;
> -		memset(rspwqe, 0, sizeof(union lpfc_wqe));
> +		memset(rspwqe, 0, sizeof(union lpfc_wqe128));
>   	}
>   
>   	INIT_LIST_HEAD(&head);


