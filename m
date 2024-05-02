Return-Path: <linux-kernel+bounces-166880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1F8BA14E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DDF1F20FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC920180A64;
	Thu,  2 May 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRpPrpwh"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6117F392;
	Thu,  2 May 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680264; cv=none; b=lFe3cIqZfge6GlMYmZ2ejTvYSrAZZsQEEgK8oc4lYld5pFkQDltxrgozuX8HXInGHqqbQqIVnxclpq7H06scF7LWL8NMm9WDxCUdksdwL6rICTMWhi3UhMSTafOp7bYjPAGOLWD2bEidTjGZAYINmmbXN3J2SmK1wC+TdUz3PQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680264; c=relaxed/simple;
	bh=nor+bUdTZpenDOOB0gH0oUo/sRPxvu81TTs6pFEY+30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twHFO/rhon9EBbVEaOTBqPcPEGOlCpt/VP7fx0Uj+xEelkCQhBsqhxCUMOqMIkK70x1AbnLCMcC7JPivBkFxDVo3XJEWRSNrBp2z32nSZO5LYU1ysU1Gw/MAY3RyspFNao63uewHfye7I+4idnXCuMzQ3XoEQQMMANDHVwOG1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRpPrpwh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34da35cd01cso2513613f8f.2;
        Thu, 02 May 2024 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680261; x=1715285061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulSjU9GfGLv0P8sU1qM3nPIYsYwQKSONUaoPceIchHY=;
        b=gRpPrpwhQKneVBOtQG7L3d1eEd4MvAFJtk5dVsezK4KMsSN5sxreYGflfmSOVU4+ey
         6Htfw0Sq4wt6bPbBZBYOHQl/gaIN2Wuue6rvtdC6U1+Pkn347GIY58eebOnquduB7muL
         isat5FgP2Pl1hffgXHrZOm+lT5eP/enrJSDMVTyhkGGgaGi6jI0vZGPF4BRl9x6K+hKw
         1G0fUjd7F38IlPu0Q74Dl8T70zMpwDMfdO+0smMP3CI81e0t91I1AcHjxxCPsSRmhWMU
         sA4XP5CsFo47Jo4qOYaq00ElVTOfPVsEBVUCEAz+n7rbfgAzDtadUZ+MyL3PtaLZvxTZ
         1AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680261; x=1715285061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulSjU9GfGLv0P8sU1qM3nPIYsYwQKSONUaoPceIchHY=;
        b=NPzjLUdJKblzgVeumO0miA8V/qIqe0xgMVNkciPKvQbH3XP6ZOEurmjeo+A9+9KwUl
         CeFdMApcef6cOGHQeHS8PCC+ZWH2RCBZ1ExfSYqtyelcWMxcnD3/1mgQD/IKD/ZGDa+I
         8UBWbf95QyGpx4us2JYwA7MIBcZXfoGB9n/lZMD9bEqqdptlv0nl2ZaE82clolKpl0ML
         ige9XZFqAbrrjKQmbPmXZoMxJ8WcN84vpIhzYqEJj3Z1K3ckQhiA/s1j+MFIwmqHLCSj
         7ACh1TKneZJnq8RmPpkSmUgmRJytHVbP1A9LhN0XML7/DduPjvQugDeVQ4zeanu4C/Sj
         STcw==
X-Forwarded-Encrypted: i=1; AJvYcCUQQpNYGCI1E/SDbzlMAQdEZMpXsmesYRRShKG57suE7diAV76niGqrZBdUYAJ6K2o0aidZmGHzhtRUaEGROwo+FvUOD3XyPCW2CDnmjIr4jCaO/bXWf/ymNQ/8h3tEIj5JEafkckSAjgWm2rWeXAdDWmCdpuWovlTSThjzMJS0uaVsMN4lvN2Q0q2oxzrP
X-Gm-Message-State: AOJu0YzlE7UYziCbCxZjhjbJKcBsiTw9IcziPfZZQCR35GujS41USKl2
	LBQqXUucswje2Fo2bDpHr2ttuE9bInyr8ptpkOPE+7l9msShKZSp
X-Google-Smtp-Source: AGHT+IGZKSgOlNei0rpgNveHrT43WRIBnm9qwiwslhu65heJHbCAenXHCVVjlXogkMpHlHjfncHqNA==
X-Received: by 2002:adf:fd4b:0:b0:34d:a518:ca86 with SMTP id h11-20020adffd4b000000b0034da518ca86mr779191wrs.46.1714680260762;
        Thu, 02 May 2024 13:04:20 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d6a0c000000b00347321735a6sm1990894wru.66.2024.05.02.13.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 13:04:19 -0700 (PDT)
Message-ID: <49804eb4-7560-4d9c-a87e-74dc05ef2e9a@gmail.com>
Date: Thu, 2 May 2024 22:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
To: Ivor Wanders <ivor@iwanders.net>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, platform-driver-x86@vger.kernel.org
References: <97d0f68f-63da-4f72-ae8d-89fbf9aadf62@gmail.com>
 <20240416213456.3214-1-ivor@iwanders.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240416213456.3214-1-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 11:34 PM, Ivor Wanders wrote:
>> Ivor reverse-engineered the interface calls to get the sensor
>> names and wrote the vast majority of this patch (I only changed some
>> smaller things and gave advice, hence the co-developed-by). Therefore I
>> wanted to give proper attribution to Ivor for his work and not squash it
>> into a single patch.
> 
> By all means squash them in the next patch revision to make things simpler
> to review, I don't think it's a large enough piece of work to worry too
> much about attribution if it makes review more difficult.

Alright, I will do that then.

Thanks Ivor!

Best regards,
Max

