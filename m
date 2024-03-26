Return-Path: <linux-kernel+bounces-119574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52BD88CA97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C1321720
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42211F60A;
	Tue, 26 Mar 2024 17:20:19 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5351CFBE;
	Tue, 26 Mar 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473619; cv=none; b=XIoZFclbYhOyb4eNI8r12kZO8F/XWj7c4SiM6dVJsrAAyXNwFXENYljkiS7Aw8XOWvlhwP9vx4M48iCqYE0VH0yzaQwzx7jX68EyGq7luruQsFtJaCDSBM+Dyel4wPuZ6Ru8KcSzUzN5C2b8k6WWW0JZQqX8Egl7bJ4/2Tbegr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473619; c=relaxed/simple;
	bh=/huKw7ViAy6g38hrNx7+yDRc9pJYIk/yrmClf1PG/58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hep9L3Yv3Gqy1Dr76iLfXHhNBornusHT2+vkD7CHMowkjWvNEOkYEdw77B3VQ5t7d4H9ETeqLEHQKZUM3rj78WN1dbseoT7K9/edkJI4acYL43DMWbAuTXbuFa0tnfqMmU/dt0bQ0Lqap9wy1fKmN3YtpIWH+uao2decHwyA+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0f2798b47so180185ad.1;
        Tue, 26 Mar 2024 10:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473617; x=1712078417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKgLRyiSy0uyYPuLscwuldQkrYE4HLy9xAc3JR+7cIQ=;
        b=lWdSU0xex6VcVB+71CCObP/o0YziU+NLxISvb+sDhf0c9ecaSYU0TIr8PEnNnvMX4m
         hdch8qbKsUZ71TLGfSkHYe+3wOcl37QF1TZA26UCfXDYGwWyrX6KAiF6DY20mAKryZai
         JUFX14OoNKsxXXAFQqcfpXiupky1mR4IBE9ZvwfqA7t9N+whgRAWdjO7izThAOVectng
         wadJ+EKn2DzY6PBdhshpKBarJNLOUL8Dy3IJ9NRyIumFtNP4+f5JxT0gPQ7hAJujJH0A
         f0paEHACWIOvoydqlze76cmYv8IqxlLH2E+VjchkZiz2daPmDsvHmnkmy/XvgvVmD/ml
         551A==
X-Forwarded-Encrypted: i=1; AJvYcCUhl0yG741G+zGaJj9bRoAsASB9knHuOhTLWQfqeo4K8ZWz1+vPFo9p8PTjdBSzT+CT7T2sa7zct8s0YyubA1KpQGTkummSyabtBr3CElSZu3gEogBsqCRSHOkSSN/ISAN0Gbkf84fI0g==
X-Gm-Message-State: AOJu0YybkwnvlPya7E6JKpQAc6jJoxTkhUGM9L/xR3vCk490s8BdXco7
	FOm4LCEW9XJJfAhqq0fIQqohcIQ4NwyaUCmyq1leKthCk0U/jbPHi33WRsMx
X-Google-Smtp-Source: AGHT+IGE8uLd0YcCa0rMe3fy5UcdFxusTHZjXsRiI+Ap3qHzmCXsorvZDAqIiBQFlm5AulYDMkHHyw==
X-Received: by 2002:a17:902:d4c1:b0:1e0:1bf6:1f89 with SMTP id o1-20020a170902d4c100b001e01bf61f89mr3067574plg.0.1711473617176;
        Tue, 26 Mar 2024 10:20:17 -0700 (PDT)
Received: from ?IPV6:2620:0:1000:8411:262:e41e:a4dd:81c6? ([2620:0:1000:8411:262:e41e:a4dd:81c6])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902f69300b001e0b78aff69sm4928535plg.246.2024.03.26.10.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:20:15 -0700 (PDT)
Message-ID: <7d3a83b5-6dc7-40d2-8a2e-bd5157a3f8ea@acm.org>
Date: Tue, 26 Mar 2024 10:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: ufs: Remove support for old UFSHCI versions
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326083253.1303-1-avri.altman@wdc.com>
 <20240326083253.1303-2-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240326083253.1303-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 01:32, Avri Altman wrote:
> @@ -992,10 +976,6 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
>   
>   u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
>   {
> -	/* HCI version 1.0 and 1.1 supports UniPro 1.41 */
> -	if (hba->ufs_version <= ufshci_version(1, 1))
> -		return UFS_UNIPRO_VER_1_41;
> -	else
>   		return UFS_UNIPRO_VER_1_6;
>   }

Please fix the indentation of the only remaining return statement in
this function.

> @@ -5565,15 +5524,13 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
>   		ufshcd_release_scsi_cmd(hba, lrbp);
>   		/* Do not touch lrbp after scsi done */
>   		scsi_done(cmd);
> -	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
> -		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
> -		if (hba->dev_cmd.complete) {
> -			if (cqe) {
> -				ocs = le32_to_cpu(cqe->status) & MASK_OCS;
> -				lrbp->utr_descriptor_ptr->header.ocs = ocs;
> -			}
> -			complete(hba->dev_cmd.complete);
> +	} else {
> +		WARN_ON(!hba->dev_cmd.complete);
> +		if (cqe) {
> +			ocs = le32_to_cpu(cqe->status) & MASK_OCS;
> +			lrbp->utr_descriptor_ptr->header.ocs = ocs;
>   		}
> +		complete(hba->dev_cmd.complete);
>   	}
>   }

The above is a functional change that has not been mentioned in the
patch description. Please undo the functional change or explain in the
patch description why this is considered correct.

Thanks,

Bart.


