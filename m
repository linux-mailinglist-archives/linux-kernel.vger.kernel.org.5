Return-Path: <linux-kernel+bounces-97654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 654AF876D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29E2B20A36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2D39FC0;
	Fri,  8 Mar 2024 22:32:15 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718191DA4D;
	Fri,  8 Mar 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937134; cv=none; b=bF5gGV/5DFraMEZ0YO/PIYVvsqd68bT2lgQBgd/90nv2wXj8tZmOJRu9U0dhnXDvFYwEYPo/W68pvjUp/iujDvEs8f+UAm4rmYxiQ8Wflrsxe9sKF27mTKj7w8O6nB1UMhZ/6rfiD084wZWQC4EQPXAFxpo63Pn/Hz4yey0R4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937134; c=relaxed/simple;
	bh=ssGP/sKIDd40DWkEnGb8v8pNLmQIx5G0esCNsJrdJlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWcg3MOc4emhGcXxu4CMEa2X8uaVsQQ1rFpfUDVi9yyy+LLOa9wN0fUc4KT1LU3KFv7nqj7s+CrlOWlQ7q9bogKW9jG0AyAbjqeVWBmskOr+PMxBRjyd659bIIAoHlls9olsUUXGijRIyQekb+Y+vJKdraCANXEYWqHpn3sKmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2092124a12.2;
        Fri, 08 Mar 2024 14:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937133; x=1710541933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwOes60SqhGmD6fZ45p3rXPhDx2zuEPddRLFEizjnLQ=;
        b=DRopFoS1ac+Hb2qnqDZD7eBGb/IBPg3DW8nk3bZS5XB2X3alW9vhVD8OuQa/8qYYbM
         SYnBcuR2+ne0QcBXub4jO03NhZRnuxeuCLInT8f61w/K9pBbYDMHwhgAKvLlHcsGydf3
         /UUJs/JtcL7dltlv6KI+rAap/t7dhOlvLF+oCl05/ziX0z62CNsBf+2QnHORmNu7TfJm
         MLV/s5FXTZUy8yulUSZWxm8EqSXG1Eo3n1hrwGpxyWm8ANNjzhEcrgFasZb8/hFZ2M3x
         Q8iGED+aL1P6czui0WG8X+J0HCqc3GmXpfEEbw1p8aqqLC4eSCwZelo9YN/fys855bPA
         iCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwMdwT4ul3ewIWVcOoXfpzRAsIKJD+jC+9OnT4CeBeTy/801U+gkGQi9H4WcushNbG9AWz0fT9C5DcH/v/D+4Ydc9+MRmQ5CkaJ6WWyun4HawWnJZnE2fBSwcnNwwUlcTySpUU2fot1g==
X-Gm-Message-State: AOJu0Yy38FkXklME2ozaO5QBU0yWBCCfDt0unA3QmyNVsGG4L/S46h+v
	npwiUzQwEyjj/70KM4LcOSZwSN9VLZL31S1mrcZqz5NdODx78VKG
X-Google-Smtp-Source: AGHT+IEofjUYiuTHZodgC8kisAUsnNX/Pl05xaom5ZZLvFQn7Ie0Ci/J9NbNpfyb98BUf5hbtIc2Zg==
X-Received: by 2002:a05:6a20:daa4:b0:1a0:eea4:c612 with SMTP id iy36-20020a056a20daa400b001a0eea4c612mr70027pzb.11.1709937132754;
        Fri, 08 Mar 2024 14:32:12 -0800 (PST)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id f49-20020a056a000b3100b006e4dad633e1sm191350pfu.177.2024.03.08.14.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 14:32:12 -0800 (PST)
Message-ID: <b21751d5-21e2-45c8-88a2-b148ac335637@acm.org>
Date: Fri, 8 Mar 2024 14:32:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] scsi: ufs: Re-use compose_devman_upiu
Content-Language: en-US
To: Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240305210051.10847-1-avri.altman@wdc.com>
 <20240305210051.10847-5-avri.altman@wdc.com>
 <6826cdb060609f81c970fc21b2050535f7c5a810.camel@gmail.com>
 <DM6PR04MB6575AC3761F84B308EB0633DFC202@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575AC3761F84B308EB0633DFC202@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/24 11:26, Avri Altman wrote:
> On Tue, 2024-03-05 at 23:00 +0200, Avri Altman wrote:
>> Why not directly pass UTP_CMD_TYPE_SCSI or UTP_CMD_TYPE_DEV_MANAGE
>> instead of using below ?: logic?
>
> Thanks.  Will do that.

While making that change, please keep the version check inside
ufshcd_prepare_req_desc_hdr().

Thanks,

Bart.


