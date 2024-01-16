Return-Path: <linux-kernel+bounces-28312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E482FCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D33280DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FB75FDC7;
	Tue, 16 Jan 2024 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLx02xLs"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AC35F03;
	Tue, 16 Jan 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441085; cv=none; b=rELVKzj8r4HhwDWm0rWjrHg99OPufdyMI2j0DGDUs/KNc7WxRfo2nE2teax+NNxUpGFccjjiuje7zxl65Ad4T/r4okJJrdNDciU8nH3etoeO4OXdDz363UpylKOKRjeyyxrR62vg9yS+mqdiM9+NUm4SnqI+2xJrDSaEeNW7e0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441085; c=relaxed/simple;
	bh=Y/E4DSPhCGQwod2MxGfu/zAJG00FRP/drC0qA9lcfVU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=MBZgIueAM8pu27F5a1i4hf66VRKCy0MS8Nsw5uxeRdofSZbe6iBZi9dWD834G/+LoU+V7O/6bB3MfJMQBxRDd0p/zkarrpmnro2XGJpdp9qfX3Twk+ONFnogwWFIgd8E6D5/sDBmGzM1kThCc364sD40yMsTn/NmCA1hkzu670k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLx02xLs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b050e88cso5792766b3a.0;
        Tue, 16 Jan 2024 13:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705441083; x=1706045883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqRPOFeNao0i7ZbF0Cd/T0E9SrjM9ty6IYml6ss+0UE=;
        b=hLx02xLsn0pw/dEqq5qsFoIivmOuh2HzYqZs87/CNueYMZ142ecK3GIKRz7AakRUpe
         VnMdqPh/45qwDPCN2N2JHaA3SkCMiRwWbfMmXz6Bwo3z9zCPwhlapCO0GtQGflut6N4H
         ing/s7AEk50Ap4psJpWvY9LzlzVTLb9CATRtVYJ7nr3RMf/riPVQTVVb3vioiO9SIXYz
         3ELG6xmWdh0vQod84vSg/l+E6qicn2xWlyQNcHscwsdGckZ4fGjqShjO1i3CiXzWhGAy
         F2q4e7D2vBNzDPrn58o0+weZRBLmkIsozhBrmAl+5rZZTCYWhNl7Zwj7PEs8N0M8np5F
         HAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705441083; x=1706045883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqRPOFeNao0i7ZbF0Cd/T0E9SrjM9ty6IYml6ss+0UE=;
        b=sCs6dDnXS8Nu56DTZ9enPQ1jdwJsbPbripaG0xA6QfaO6NwjE7P+O+u7/ECfj5hBdT
         pmg54PmqcCm+BqDcfrAovNaCQ4vjXMbXaeC31Xp7Q7Nlma06i3D1mrOt8T8ZWtAjZ74z
         Vn8bd4NUpUf+QDKI7hsNb9DGUVVvXYtf7Jh/Rhlgzq1jkw0lOJ++eMzzc6iJA+7xeAn5
         1aKlVsHNmdtpTmyYf5qVH160BRr49gweC0BtDkzBEH3bV+qP8pQFupjFc/TpZaiKd+ti
         1BRCpNps+CMT4V+3arp3kTd8ovOSVpwEgy3EtQSS4Mo/eJBxYYifrJILSz2/n0vM1oCo
         JXRA==
X-Gm-Message-State: AOJu0Yxax/22goTDD41RlGZXonpdaumOVYphhso7k3gJsb/lPnSc3nkm
	LfshR6vY2b1N1GStsMrYly5pCBMem9k=
X-Google-Smtp-Source: AGHT+IFXf5o+kuqoq4WCaI99Sp9ISYaTPo88bvEfj86wrtLpICa2GS2gzaj62IwTl6iKekIdN7IROw==
X-Received: by 2002:a05:6a20:94c9:b0:19b:4545:74c with SMTP id ht9-20020a056a2094c900b0019b4545074cmr1143672pzb.93.1705441083232;
        Tue, 16 Jan 2024 13:38:03 -0800 (PST)
Received: from [192.168.0.228] (c-24-20-51-242.hsd1.or.comcast.net. [24.20.51.242])
        by smtp.gmail.com with ESMTPSA id h13-20020aa79f4d000000b006d92f081d9fsm52031pfr.31.2024.01.16.13.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 13:38:03 -0800 (PST)
Message-ID: <c9112997-d2fd-4974-985b-7b96e41f4f7c@gmail.com>
Date: Tue, 16 Jan 2024 13:38:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/42] drivers/scsi/ibmvscsi_tgt: Convert snprintf to
 sysfs_emit
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Michael Cyr <mikecyr@linux.ibm.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-24-lizhijian@fujitsu.com>
Content-Language: en-US
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
In-Reply-To: <20240116045151.3940401-24-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/24 20:51, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
>> ./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3619:8-16: WARNING: please use sysfs_emit
>> ./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3625:8-16: WARNING: please use sysfs_emit
>> ./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3633:8-16: WARNING: please use sysfs_emit
> 
> No functional change intended
> 
> CC: Michael Cyr <mikecyr@linux.ibm.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: "Martin K. Petersen" <martin.petersen@oracle.com>
> CC: linux-scsi@vger.kernel.org
> CC: target-devel@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>


