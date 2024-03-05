Return-Path: <linux-kernel+bounces-92875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499AF87274F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6501F23924
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943F5C608;
	Tue,  5 Mar 2024 19:10:02 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07F5675D;
	Tue,  5 Mar 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665802; cv=none; b=TWt9LD9qAUg7eYfoQLBBbVjTqsZhQHBgB80vH1XUrATw0C48sc4jRyEy3XMw7PNWIzBFoU1YFZLfMd3GZHr5hbBdBMdVxgghXyuMhQsjKq6n6DnEgVbkr94n5QPCyhGIn4hKPhM7JycaAw/IQqFMLjCGkTX2XJWJElVXecf/SD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665802; c=relaxed/simple;
	bh=vAW542XaExMYl+325BYf3nuFTyXgKocZzWt6GFXShhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yeyy7Mgpkhps2gFzoRJ2T4wIwJn0qdicJRyGDsTal8zNDYEx6jBe1EiGeo6qBwzK1zZxzvwtNC2SkakRgmIgmzZAWKxWslIv623e0QBKa+Ki05C9qbtO95MyCShqql6D20kFT+LS6sZBHdZdRV4WChLqrfUPk2SHqboJzW5Yguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc49afb495so1367925ad.2;
        Tue, 05 Mar 2024 11:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665800; x=1710270600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlyfzi1bedUTFjTltnZYbp5WMwRfkAnAJgX8OA8/NEw=;
        b=KJIzUkE80EyNHW0ANsvqklgu999nUV+iSp6+zB+9T5/FkaaxH024pk28RG/6HPhU5P
         yWYnIzCIs0V3Rl2xGB2PfTkyGnasbW8C3w2+74YHvgCQiGoc3ZQqhRi4NOTLnU41cXIq
         fW2fBUlpwLuUDavfk+WiJ7offNuwOWVBhaEKh/ecK0bdmw1ugNt6XRbIa2WsScoX45Hr
         B3tgjpXQkQgtH3dGYKVUsp4q6RpL2EGnyaviSDfctfckJAZcLptxhv3Hpr0ici47BbzA
         Ffq0j21UimqNSX8NSp7pFZokrk6IM6ZlnqTniTcIPJc0D7FFRYrrDGcdANeEvyZK1+I8
         Mhvw==
X-Forwarded-Encrypted: i=1; AJvYcCWk73U9du7yEvtwXcm0Tt09wti/GTeX5Vctjzv8KmGhXTOvEX7WUAEydzmQCwGGUKpQgUhPEakEDR3IfU8MGuXSdcdS4N9WbUFqxHtlz/0brTXPvhNQHEDCW5sHYBUwXB8NgV8dJqP5ig==
X-Gm-Message-State: AOJu0YxvsGz79ySwP6qAckQUz0JuhF0vrAWUgvgeOjX+ntyykvaw7uXO
	8/mnbFcymCbu4vAzk4JZTs30FRYXOItnGnqc12a6r/VMRg/IH1Uo
X-Google-Smtp-Source: AGHT+IHYhPte6bVRTjzKxsRHVaPoesSV/jhZDeDwlDGMEsYH8yzU7oCozdIAALAVzMtCJvpoSuAsEw==
X-Received: by 2002:a17:902:ec92:b0:1dc:afff:9f96 with SMTP id x18-20020a170902ec9200b001dcafff9f96mr3348830plg.44.1709665800244;
        Tue, 05 Mar 2024 11:10:00 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3e11:2c1a:c1ee:7fe1? ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id kx3-20020a170902f94300b001dca40bb727sm10979922plb.88.2024.03.05.11.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:09:59 -0800 (PST)
Message-ID: <4f766df0-b1df-4e5f-8acd-31710ed4399b@acm.org>
Date: Tue, 5 Mar 2024 11:09:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] scsi: ufs: Re-use exec_dev_cmd
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-3-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304092346.654-3-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 01:23, Avri Altman wrote:
> +static int __exec_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
> +			  const u32 tag, int timeout)

Please choose a better name than __exec_dev_cmd. Function names in this 
file should start with the ufshcd_ prefix.

> @@ -3300,28 +3318,15 @@ static void ufshcd_dev_man_unlock(struct ufs_hba *hba)
>   static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>   		enum dev_cmd_type cmd_type, int timeout)
>   {
> -	DECLARE_COMPLETION_ONSTACK(wait);
>   	const u32 tag = hba->reserved_slot;
> -	struct ufshcd_lrb *lrbp;
> +	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
>   	int err;
>   
> -	lrbp = &hba->lrb[tag];
> -	lrbp->cmd = NULL;
>   	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);

Please restore the "lrbp->cmd = NULL" assignment. I don't think that it
is safe to remove that assignment.

Thanks,

Bart.

