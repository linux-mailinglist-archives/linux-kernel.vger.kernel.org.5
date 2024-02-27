Return-Path: <linux-kernel+bounces-83877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B5869FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BC11F2ED59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907754F8B1;
	Tue, 27 Feb 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exwa89re"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497F1E894;
	Tue, 27 Feb 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060326; cv=none; b=LCS3jI1q0IOQevhIBuiZpoSL6yaM0Wyjhd+vWuQd7nJdxZ2YIyJV42p1MaVcvuTpgvHPZzzDxXsUoYZzQeVQ2Fi0oauXSYSCl9+HgB7rISlkAvwQs9GPpHwuBPxR0wEvqz0v7bWPdYFnyGsAgpbXJ9rb2he4boaLgsazfQ6fVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060326; c=relaxed/simple;
	bh=Zs76+O63hWdcrw9stSfkc95Kxt2nX61aPPSt8OGVGIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDzA5NQ+CYUQdwPz9r7LSmphQ+c9nuo6LVEAcCxoadkEumcu/oV2oucVWmVcvR1JABCP3oosSVvaXFFLvFG5wbsiOWnOmnTclkURS5sddlmSSNra+zvFARERQHv5ZECBG9zlk9BmjAXYdv9W19KF41DzZPVeEr4ssCY8iDUfk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exwa89re; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e8ea2caedso10844231cf.3;
        Tue, 27 Feb 2024 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060324; x=1709665124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+K4Qa3o+E8D+LDjXO92NrOsZYJ4mnIsJi9fWR3KCCs=;
        b=exwa89reGe+s1Smf1re/bsP29Dzy8Ga9xtU63wFTW927DDkMM2RAZRexFcgIQeyMB3
         51IufLQPdcTPD6i/BNIDwcA2DoPBKNwWeRbjOK/Rz2tVC365elKifZXXvlmTtY36/Fkd
         bLTC4yi3WLgfSfJmnVWNvmjzOlt3ujrwCTHEfOYEJ2cdQnQbX2/LdlNZrpIaNY5iZmX3
         enzMTu2gDwSpuJ+1gy9SPnZONpm2hbxE0s2YtWzXWKWA3RHCtNR6zsuKBcqLbOHw+HIV
         KOwVG33kbpkUdd230F8ZVb1Z2rFjRFnrscCx/uzPnp/MTBDV9l61/n9s8L7qz6oKGdwT
         Tp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060324; x=1709665124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+K4Qa3o+E8D+LDjXO92NrOsZYJ4mnIsJi9fWR3KCCs=;
        b=LuhEFHnVxAEzyVrm9Y+WaQxkcINY1xaYSWRxw/H62PUbCT57C8ceJb3LYRdiPHMEK0
         vDkDo5WDvQhGsBh3A9V8zpVlrHOY2LX7SuPQKuoiU3gGvcJnht3PFlYibPJh+dnwF+aN
         kmg2jupI8PUFobHewAm9dqPPFlTKN3olLAhJe8FRE9DhQVwshwf2gdPegczgk9JZpYPr
         bwR5tp/+RqY9Ue6pFz/XshmLyu6b8i1+IeN9ybey31QIc8MgkE9yOer/H9lUsTQFXVxs
         356jqV2i7X7r/aOLxMfqGjIOWBGlJO8pBDUv8LjjFwhQWKgNQiAYrJ4b2bHsI4zpjHoo
         qdSg==
X-Forwarded-Encrypted: i=1; AJvYcCWNEpCpkzUL7vR5CVhrdHOGNkGZPZ+zf7SGs8LoJwau2GdVJ8wjdPjYqPVNzHLSA7UHIFCoMe4Q5GAKcL6/DcTyScYsEhHPbdQmWKYTRqYmlHb0GLqc1acssW3Z4Kpt/icIccI6
X-Gm-Message-State: AOJu0YzLQseCqrcY0J8TCWMKKfgc3oQNSSratzBHsfsLHNq2SZ/SOnpX
	xVz92lcdK7WDHfatsQc4zvR4X8m1EPOOBryF6wcL8pCTrIRlfmcq
X-Google-Smtp-Source: AGHT+IHOBBtm+y6Xvne+idIykd5zAmxoipMES/7eQNeUSWqu7AW7Hu/sFYLt2Cug3EoyhvuTfhH4EA==
X-Received: by 2002:ac8:5f92:0:b0:42e:8f05:97b9 with SMTP id j18-20020ac85f92000000b0042e8f0597b9mr5649563qta.46.1709060324481;
        Tue, 27 Feb 2024 10:58:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d20-20020ac851d4000000b0042e0620d2afsm3816973qtn.72.2024.02.27.10.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:58:43 -0800 (PST)
Message-ID: <cfaa0f4b-f9ef-459e-a174-3062b2d3b514@gmail.com>
Date: Tue, 27 Feb 2024 10:58:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240227131558.694096204@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 05:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.211 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.211-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Same warning as what Daniel reported for ARM 32-bit:

In file included from ./include/linux/kernel.h:15,
                  from ./include/linux/list.h:9,
                  from ./include/linux/module.h:12,
                  from net/ipv4/arp.c:74:
net/ipv4/arp.c: In function 'arp_req_get':
/include/linux/minmax.h:20:35: warning: comparison of distinct pointer 
types lacks a cast
    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                                   ^~
/include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
       |                  ^~~~~~~~~~~
/include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
       |                               ^~~~~~~~~~
/include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
    45 | #define min(x, y)       __careful_cmp(x, y, <)
       |                         ^~~~~~~~~~~~~
net/ipv4/arp.c:1108:32: note: in expansion of macro 'min'
  1108 |                                min(dev->addr_len, 
sizeof(r->arp_ha.sa_data_min)));
       |                                ^~~

-- 
Florian


