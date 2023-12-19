Return-Path: <linux-kernel+bounces-5765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A542818F37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A02286609
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DE37D1D;
	Tue, 19 Dec 2023 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SZ9dj1nn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B737D03;
	Tue, 19 Dec 2023 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FeTdrw2ddb4TgFeTerlrH5; Tue, 19 Dec 2023 19:06:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1703009160;
	bh=bRe4uIB8VoeySe+3f/IWMRV40y9LM+iMuTk9Wv+fjso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SZ9dj1nnoJo0BiJSMqFkTD+KT3PwX9vSxqitdbCJS8sv2PyWeXf3qkGo5s2yUw7H3
	 ui5p3n2ElpGv9uPU5l5kZ3cqxxAPUkUKqHeHV1dl1b57lBnHaMkCn/+DHz3IIHcwtB
	 ik0vjNeeZ90ci0bcgq+In9ZXDnLDb/6lJCoyPH+OrhMZcJBBXjMFHDu0xkOnvz+ifm
	 WpidANTlEk0shqidjRyqiEcSG3OkNSwkkKs5FPJncQy/Cbgrn6mq8kcm9REL2fk8Ir
	 GqkMaIPAmxWP+AGDPH+5YjZcrmCP9p91zCAAR8xAN2e/uyeI46O0bcVngGlaBBpHxl
	 2ekLbIQstdl0g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 19:06:00 +0100
X-ME-IP: 92.140.202.140
Message-ID: <851d4638-970a-48d0-8f79-493a7ebcc0a5@wanadoo.fr>
Date: Tue, 19 Dec 2023 19:05:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: Remove unnecessary goto statement from
 ufs_qcom_config_esi function
Content-Language: fr
To: Chanwoo Lee <cw9316.lee@samsung.com>, mani@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
 sh043.lee@samsung.com
References: <CGME20231219082757epcas1p33bda4e0723d3d57552132054d3e5a3fe@epcas1p3.samsung.com>
 <20231219082740.27644-1-cw9316.lee@samsung.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231219082740.27644-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/12/2023 à 09:27, Chanwoo Lee a écrit :
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> There is only one place where goto is used,
> and it is unnecessary to check the ret value through 'goto out'
> because the ret value is already true.
> 
> Therefore, remove the goto statement and
> integrate the '!ret' condition into the existing code.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
>   drivers/ufs/host/ufs-qcom.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 17e24270477d..8cf803806326 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1929,7 +1929,7 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
>   					     ufs_qcom_write_msi_msg);
>   	if (ret) {
>   		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
> -		goto out;
> +		return ret;
>   	}
>   
>   	msi_lock_descs(hba->dev);
> @@ -1964,11 +1964,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
>   				      REG_UFS_CFG3);
>   		}
>   		ufshcd_mcq_enable_esi(hba);
> -	}
> -
> -out:
> -	if (!ret)
>   		host->esi_enabled = true;
> +	}
>   
>   	return ret;
>   }


