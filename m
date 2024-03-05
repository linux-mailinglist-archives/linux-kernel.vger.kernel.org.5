Return-Path: <linux-kernel+bounces-92878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A25872762
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D5C1C249DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C138FAF;
	Tue,  5 Mar 2024 19:15:37 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0022F0C;
	Tue,  5 Mar 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666137; cv=none; b=CXtAaMMP6cmjN9FNUBCOe7IE6FSPVl13tu2V8FUJsrrq0EN+QNRl+KFGYU8SbzyYRi587JYe/w+Z0mfmMp3664Nx5SXZE7ap7PRAFi8mviyO3L3fVSMMKf06AIMemXz3apEmr6Gj6gFi4QFeP8jWpv5BHnd1t4ILCc3n9cVIUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666137; c=relaxed/simple;
	bh=q+ztNtFvfKQ9hq+M/YvKvcctrTchDNPkgWnn+oztkYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBWGMQdMVRBbPmPBoN/+PzsPOLwuuKmTmUGMcKgPD+1T1eEmRz9JNeN13C7guQLaSLf5vD7fS31cHZn0buiyB50ixQvlfNnW/+XvYNW9MO2SBtWKFWJenE+mxYJCkQ0VMMLz9SMGIeyt4YEs2ZWwHJMrqQjvywYs3UL7WIFpLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc49b00bdbso54732275ad.3;
        Tue, 05 Mar 2024 11:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666135; x=1710270935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fGMOBv3EJ/8KyNhVETcyV7O4e5ShcJePbc3rjazADM=;
        b=BfFdxEur7wDeIrDcnejurlltMXlDO8v+Ygi6o1I9TGA2Q71y7ap8E1Q2QX+nDHhAYA
         x8dpq7iaxVenyaUEuey5TCuKj80PJvnAhjqaqlDa/g0meRjRhY1dwSajkeqFBYb4956u
         61X6pAhQe/mTgIv1ce4Bk3etcsHtF8S0pEwJg5tuUaVkWVgVBZOvm1RbTM78H1U8SKKq
         5XSJEp+cofvlkhoxYtqhdkHVVKkIJTkDtc9kj+NVW/SbHORh/IZgN8yXzbWeIqcZcwvz
         YT56XaHEn7RTbh86ULxZPxURsbaxSIBgsOGYkbT5xexYzo7mWinJIFPsKIuZSat6CUDv
         VlhA==
X-Forwarded-Encrypted: i=1; AJvYcCUq6cG2LUfosdOnjWbIsLH4MMBi51AzuXCxuETZ4dytVokkJkTFEW9k9G8U5d5C2DC9j2xnJhbrHX/OBcaEOss+jB6NSQlyOSJnWK2aS1HBBc+4M/boc67nGTIfn+x8rMNDO614TO9b6g==
X-Gm-Message-State: AOJu0Yx9OJHrPYQgSjZitZiWOC/Ap9NZa8PLowh0ClcybS7bQiz6MVyR
	wPV3JLVWaFEwi9nWryGVNjZ/wocOz0juR7uQzpRP2+ZtPCU9+dA7
X-Google-Smtp-Source: AGHT+IFqjmg65FENs6jCedy4peDcSuxPDgIGq1cxbDX1vLubXUmRD6MD5jUd4nz1y8SzKCO29AIjPQ==
X-Received: by 2002:a17:903:1209:b0:1dc:4199:a31d with SMTP id l9-20020a170903120900b001dc4199a31dmr3115815plh.53.1709666135385;
        Tue, 05 Mar 2024 11:15:35 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3e11:2c1a:c1ee:7fe1? ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902869800b001dbae7b85b1sm10916399plo.237.2024.03.05.11.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:15:35 -0800 (PST)
Message-ID: <b28bed87-161c-4086-b6de-5844d012a090@acm.org>
Date: Tue, 5 Mar 2024 11:15:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] scsi: ufs: Re-use compose_devman_upiu
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-5-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304092346.654-5-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 01:23, Avri Altman wrote:
> +static void __compose_devman_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
> +				  u8 *upiu_flags, int ehs_length)
> +{
> +	if (hba->ufs_version <= ufshci_version(1, 1))
> +		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
> +	else
> +		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
> +
> +	ufshcd_prepare_req_desc_hdr(lrbp, upiu_flags, DMA_NONE, ehs_length);
> +}

Please move the above if-statement into ufshcd_prepare_req_desc_hdr() 
instead of introducing yet another helper function.

Thanks,

Bart.

