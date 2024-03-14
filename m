Return-Path: <linux-kernel+bounces-103781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB72B87C466
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CED1F223F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B176400;
	Thu, 14 Mar 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtShGde4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124574E21;
	Thu, 14 Mar 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449140; cv=none; b=cuRRx3fxvnNHvknIZCxe06TROYagTb5VEv+JVRu82TQyzeUg1NWBhmUhmrX/iLjqmzpNfAYVXdNJoskHI7y5MVDEnkuz6xV+a5Wylpx+iQO6X1Doo/7mf9m9aqb3QUAPRZ2xgue0g2lr/voaR0JIE4VDsxuEpKi2O+6ouv6SzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449140; c=relaxed/simple;
	bh=/wT9frV/hX7PE8jYRX5Wx4I3/dpgvF58kgRs2lTo14o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYoTFLmTbA7ftYSgmMd6/X2L6XWZ3l9P/I1aMwuVTpQGMmE+GeCbojENpGqUR3hsFLJ5TzVFSPMlBsno3WUkvmpyYaQhfArfRFDUM3jAGDRTe7AlIMe0GGnazivf6JNbs/SF7JlJbmJB/Rky/RTF11OmLPSnH8+LCQMvdRCns+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtShGde4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd8dd198d0so10629355ad.3;
        Thu, 14 Mar 2024 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710449138; x=1711053938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnMrBa1zsNDJ8SxKjGn0mlGSVNeZ/wwefGNUMZ4JI0c=;
        b=GtShGde476bOdiXp18DjLo7oUmkqXwggsEfNunputQzVZnU32fULk93D9W/5Kcs3Xv
         BoD2izfUpWqnBOgu3C1X8/J5zLhUHjFLnaypO6A1sSD/ir8qn8tzRBWrWEEsGgZvBsam
         9XgZGVcfbjs2aeSW3RVRs87R4vt1mKV6lBU+F4kb20PYoqubVoDSjT+stOXJW1JyeUAR
         hgwhI4W1BUsCJhJbdtIT9h6HLlB4y/fBVW3Ffw+i3EX0cVQ7MeOmfUj+1rki4+1WF4/P
         m4MYpOXL2hX0mcJYOI+9BTVwVivVs953uAHUP3eEtPF8soJjas7ifwh46+Uwxl/aq3GJ
         PdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449138; x=1711053938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnMrBa1zsNDJ8SxKjGn0mlGSVNeZ/wwefGNUMZ4JI0c=;
        b=d1hqok4UTrMTLb+Cipey9GH54U/4LM09ptnCkOIBv7KAJBGqJ2SqDXBlQF+o9gQCFB
         ozdAkf/YivdevmhlAaZBpUtSi+9X2ixAFnSiJXx00I72kCHpZUtjqzGRD7gdnvBMqc40
         oHBDRsA9Dy5sLFuaOPYv6QGUqAVj9tp4c3p2eOnboUYOeSHQ69FPbpIs2SPlYsaCHZgV
         0JPdOBJZ+hxY390irDQAHsly8O/op1kOBcAkQf0i4e2W9qh/Wg0K/8F0BH7rv2n6vMky
         BuAEHu6fnGRN095PQjXzIMgsFyYycgGaAn6YLOJSbcN6PnwS+GyxP92wldAZdQW/bFvU
         EOxA==
X-Forwarded-Encrypted: i=1; AJvYcCVnk2rGkZcfbj6JNbwyNOTnrFRc0xdw2WUhGTbV3Elz55xlVgI5sytYtyrq3iYR+kXj3q/zg1124Vc+DBMOrxzdkGrODSDaioMCt6Wa5xFFBD6COagCEBISokbF4yyb+Zt2oSah
X-Gm-Message-State: AOJu0YzY8JfluEgXl75sSOLsvACOqjQfDP1ZC7qBoElMs0okXk3edF9s
	uInUHlcidzMclYWQl+fPoy2fT7AJoBiEOF7VUNX6SFCGiOdeZzzYm66qHoDbLUE=
X-Google-Smtp-Source: AGHT+IFdldRN4ysuGqhWosfpH5e5PWI3G6+kz2OSNsUOGetxsFlTjgUiIcLuVLcJ1USKUW+GMx7hsA==
X-Received: by 2002:a17:902:7488:b0:1de:dd0d:69e with SMTP id h8-20020a170902748800b001dedd0d069emr1291794pll.35.1710449138563;
        Thu, 14 Mar 2024 13:45:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ki3-20020a170903068300b001dd02f4c2casm2186991plb.164.2024.03.14.13.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 13:45:37 -0700 (PDT)
Message-ID: <571febef-186e-45f3-a894-26a6c5d7116a@gmail.com>
Date: Thu, 14 Mar 2024 13:45:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163957.615276-1-sashal@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 09:38, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.82 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


