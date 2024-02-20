Return-Path: <linux-kernel+bounces-73691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08085C604
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C44C1C22370
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D614F9D6;
	Tue, 20 Feb 2024 20:44:28 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8141FDB;
	Tue, 20 Feb 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461867; cv=none; b=pllSomz8G/rFHlASi+XSatoUGNCMo9hA99BkYwal1BRc+7swCiDecMWeFU3L6rz736WuXGaLrB7mQHUh+XDQI2IGVBiK2dJAITjU8JeoedombzrMe2VNUvl8jbtYhu8ymzoPB1nuOdrFZ7VeSQTko/Q8xZhMvw5+QoWnOQFCxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461867; c=relaxed/simple;
	bh=+NpirNdlapHEfcSl96xe1oRXZz3bdX/1ki2AhBoKygA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmt62F7qfCMDJxJRonS7RM4aZh+aSoao+MkcsheyGAqwAMIjL+FYawh1WYBdn11IRcMcgPA3QBanO6Z6nfEFBQObDAVT4qkzGMxDAakxDMAh3DkoPOiHYU7Q0IJcdaW1d3K4sPSdh+tQjhIMBb5DqHh6WeOJaJezVCOVGRM1iH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e47a104c2eso813581b3a.2;
        Tue, 20 Feb 2024 12:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708461866; x=1709066666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Trult/QkhUE0ZEVtyLMGE83zvxu+D5mSE1btytOTGTA=;
        b=qjjwwbAfO2ur8OuxV4s0jUUxsB4i+KfOpN2SCkFZ9nOv+WWTDBbo1Pgmpt+xbh+43s
         l30HvdFoLrIS7fnAGzPnA0V5azKPZ+/l7VasxySf/JzK3WDwundlB9XTNDlBdDD6S46/
         fiV0vCXui8kWtEChw+5anb4U9BCwxJYPSBHjrcXoDv6yFNZu9+w7hcU4azKfaRioOWTM
         NAt3KgT5IVfvtAdRykri7J1RD+QYEIZaedJyhmoD927iP5aE+KI6RLcrWlE5YGCKI4Cl
         8ZH045fQxQlPJ9ZY9IjAS/aiHxk8rKmNBzQUXljZuxv1OHPug1noV/i/iZc0ACVAzBYJ
         b2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUS35MEk8/Irxv7YW7NtkVr96GS58fiMoJUHp9sImDFTjFd664HFKKGDYSWmQUsS0oIARGAEztZ1N8ehMjgKJwT5kgrluJXgIk0B7HvtxwKnzc+JWfNh8lr/JRRpJpCdxex9lGyuU6NmA==
X-Gm-Message-State: AOJu0YxVSXriXQuN7JIiYqAQnBj/N7lBUQ3ZaSMatAaQLD2IfYxwGx+m
	POwfRMbutlo2ZjeWNRRSY6nPmOTiDTc7ZQN/ZnIeUzawZmS6OmOS
X-Google-Smtp-Source: AGHT+IF7Lq4fTsX3Vjo2i1kWCMxa9K5Ldv0gUwRwtaxSKmAHVW/U9jHLJbN+Xh0BvQ3lfguf0isFgA==
X-Received: by 2002:a05:6a20:c90a:b0:19c:ad6b:e1c2 with SMTP id gx10-20020a056a20c90a00b0019cad6be1c2mr17347405pzb.12.1708461865534;
        Tue, 20 Feb 2024 12:44:25 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:d74f:a168:a26a:d7fe? ([2620:0:1000:8411:d74f:a168:a26a:d7fe])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e3f09fd6a7sm5932938pfg.85.2024.02.20.12.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 12:44:24 -0800 (PST)
Message-ID: <cd427067-8768-4f87-8573-8f9c944fef68@acm.org>
Date: Tue, 20 Feb 2024 12:44:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix mcq mac configuration
Content-Language: en-US
To: Rohit Ner <rohitner@google.com>, Can Guo <quic_cang@quicinc.com>,
 Bean Huo <beanhuo@micron.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>,
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Can Guo <quic_cang@quicinc.com>
References: <20240220095637.2900067-1-rohitner@google.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240220095637.2900067-1-rohitner@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 01:56, Rohit Ner wrote:
> As per JEDEC Standard No. 223E Section 5.9.2,
> the max # active commands value programmed by the host sw
> in MCQConfig.MAC should be one less than the actual value.
> 
> Signed-off-by: Rohit Ner <rohitner@google.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 0787456c2b89..c873fd823942 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -94,7 +94,7 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
>   
>   	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
>   	val &= ~MCQ_CFG_MAC_MASK;
> -	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
> +	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds - 1);
>   	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
>   }
>   EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);

I'd like to hear the feedback from the UFS controller vendors about this patch
since the UFSHCI specification of the MaxActiveCommand controller field is
ambiguous. While the example shows that 32 should be configured as 1Fh, this is
not documented in any other way.

Thanks,

Bart.

