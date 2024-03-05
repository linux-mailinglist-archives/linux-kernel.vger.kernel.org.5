Return-Path: <linux-kernel+bounces-92877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA5872757
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F20728AECF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB236250FE;
	Tue,  5 Mar 2024 19:13:31 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EA17997;
	Tue,  5 Mar 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666011; cv=none; b=oQHklxSNAlCdANS3tpXeLkBYNJp81aZqN7ez9xdLiHe2jg22IC9Na8q3RuUF5KS7G+uxV5NlHsoZncTrYjxoUEcmcKAaOh/exAvvOtpDw//DyG5JHqELIcAtV1jwUIbaIfXH3/5P1CNVYu93i+20MpsweYBSE8Wlrje6LdMdG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666011; c=relaxed/simple;
	bh=gzgtKjWP1JYavwUyqlhKMBo4vCJrjbcRQavXveXaf+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QISBgpNuDlmQWVqfbWRRbkSY6m/WTmi9vX14wJ0wTRLDS69NgVcPPWCv2uMG0s7KLKjn7iOM9ky3KznjTW9DoEqaPMOxvDwGwUGBLfEsNUinit66RNuL9aJ08ZlrH3rzz1lNB+Ft/ClGXuaCnAadQVHq1XBd2J2a3Hub5MLLT+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc49afb495so1399095ad.2;
        Tue, 05 Mar 2024 11:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666009; x=1710270809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkmcELV9/Z+0zf8moaf3PWgp6rA+i5CSpO/M4X6/tsw=;
        b=V6bmt71D8RCnIe7JrqJmgEAD2iCstUlTAns9MM0nLGeWZ+UPqwkSrVVUEP38FeccIS
         Ve6uwt1viF9lQFvjwr8/COnFSHPidx6JW7wk72H7SQa3R4Ah2JBzb8YPjEec7uBhatqz
         ugjC8kAND8+pLDrwObYjoXIt7A9vXWkDT8o890sRLChS4I2SSQN1xs6ANcGhaXvWeiOU
         c56YO+X2TkdzB0wejZi2HpQ+zVYuWqqFbuKGtGAoND7sqxNRR7DkERsKl3ljE7HUZKUK
         27QLcTQTybxSkcLViKgJAo6ZvB5qmhQ++izomtgFkJa4lL3fXdXVK9UCT3dNF+9XfcEL
         s2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWKuzS998i9Sfh83gxEt0kbhl+wfINdAm/aXkfS3HO5UHV/oZ+ZbY3M4FX72oeKjrUuVPbV7bY0PTH1UcCOetRyRf3mO0cyU+XySFkrq8ply4LPkPxSQfkFcDpAlDiV0zIcIw4QHJlhdQ==
X-Gm-Message-State: AOJu0Yzsx++jjf/5eSBsaNYXtA6o9OmtsAKxoj7+bGIACfj4V8N/nO5N
	9SYf54R8KCm43aqWBsFDPTEQJXa9sIFhgBk9odBW6/FFLnci5/+F
X-Google-Smtp-Source: AGHT+IGWc03S+ftQIgQVxnMD2xWMvGqcPjhNhGOMHAkOaqW77YDvxcqlWPrYpHdWCUoJAe/f+poJVQ==
X-Received: by 2002:a17:903:230a:b0:1dc:fb9d:402d with SMTP id d10-20020a170903230a00b001dcfb9d402dmr3373244plh.58.1709666009503;
        Tue, 05 Mar 2024 11:13:29 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3e11:2c1a:c1ee:7fe1? ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902e19200b001dc95e7e191sm10923530pla.298.2024.03.05.11.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:13:29 -0800 (PST)
Message-ID: <436cb819-f1f4-40ce-8e6e-f70e7f99513a@acm.org>
Date: Tue, 5 Mar 2024 11:13:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] scsi: ufs: Re-use compose_dev_cmd
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-4-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304092346.654-4-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 01:23, Avri Altman wrote:
> -static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
> -		struct ufshcd_lrb *lrbp, enum dev_cmd_type cmd_type, int tag)
> +static void __compose_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
> +			     enum dev_cmd_type cmd_type, u8 lun, int tag)
>   {
>   	lrbp->cmd = NULL;
>   	lrbp->task_tag = tag;
> -	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
> +	lrbp->lun = lun;
>   	lrbp->intr_cmd = true; /* No interrupt aggregation */
>   	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
>   	hba->dev_cmd.type = cmd_type;
> +}

Please chose a better function name than __compose_dev_cmd() and please 
make sure that the function name starts with the ufshcd_ prefix.

Thanks,

Bart.

