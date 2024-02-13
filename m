Return-Path: <linux-kernel+bounces-64450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A12853EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3632B2B41F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952D6215D;
	Tue, 13 Feb 2024 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh0zY8kZ"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FD6168F;
	Tue, 13 Feb 2024 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862758; cv=none; b=IVZ2+uKv3jpkH8hO/CcddliVX85y/jTMy5YNOSXUbmcLH7bNVmi9IzfOL5LJ5YkpywYlYih9OO7rRhcc4cEePJp0gT+yp0PIJe7L9TBMD9C3WcYmOpe9ksGwKMeg35oeFOBnBETzUJXQR/DO18RD7W6FwUqNrftcJNls7axgyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862758; c=relaxed/simple;
	bh=fTJeE/0vTi3j4ZDncZgiJFys8r51ebCtKQPYxoUm5CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCwSFRgN5O1OzUH3tAYOqxiMQT1kGd7Y53RX5zQ4c07NQLJ/EuomjxeNEeSpUSoX8I90FI3z7WjhVbp/Ak1luyz7O2Taif+fxEp0bqF2YjOTTh5dsrfULtEZuzf+mzm5D9XUPSUf8/E++4m4eU2ceIPSCezrET8U3bgErCK4d4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh0zY8kZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783f553fdabso14195785a.0;
        Tue, 13 Feb 2024 14:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707862756; x=1708467556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOwk/2w2eY60TLURHPvbKuNQvYKfknP+nGTPYSp2+GU=;
        b=mh0zY8kZ2gqGEQYVweLUgjuVKK0zbaGEVOUbCm2VDCNsxrxr4c1iSf22/4vBaBAw3Q
         k9SDOjeDGWC9eAI8e9dYV0rCZFhKVTfxMgI6xlF7pyTpopkbGpTSnYQs2oaZlmqSPvcu
         r6x1rKcLU5WcK+vWpzCvRfdRUqlCrDHUC4JlPvb7aNGCvm8qhpAiduugGv0oTmmPkTae
         6XCMjniXKvbozIEvjgZtKAw22UTVX1yL06SfHC5K5l658NpOdc/3WsKj0QeKefpKm8E1
         P0kub8kf1pkd8ijWsOsTXiL+hWHn7118/qVRSwKeZVfXLQoFmDiLPc2g1pQUNaJJ86Es
         40kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862756; x=1708467556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOwk/2w2eY60TLURHPvbKuNQvYKfknP+nGTPYSp2+GU=;
        b=m5vk+Y2GNwlXy4LdKi5/W3KEM8lVxQErqI8WebhQMFHjwRVP9i+WECWVY6p2YY2ZN4
         zVs/FHUDJWdWltcQvBG5wjerJ4k3i3Au3CddRlJfzpl/63/lEp99h5vjT5rKBKkaUa5q
         RwulqFhSxoXaSnFH7zFPfv7DSGGoEjKyOx4PrRYIi8SMqzGyAxvRWT5SXaXm2mLMzVgD
         CFH7VOsQ+2eBR9EEpZk9hRg4DF1mXK96cmOrvQWDQqoyGKYnf7H/R1Lo//Mkxs7Gp/QR
         X38wNesXiiuDrVptI+mQb2Opf0jkmZM5aKA/m7ZMWlQZdtWefbZnb75NSmSvVbTqjKb1
         1I4g==
X-Forwarded-Encrypted: i=1; AJvYcCV6+elGfbaBdfcfVz0d9p+rUtJKHmVkxuFuOzGATRYxtLsUmQEeACOknnjPeSLzpPVGEd9kDuQYrDyMf+/eFSsfufzqQNKaXVwiUqh+rw5d1LXnDRBaAdM94nmmgqirPaYiZ9dL
X-Gm-Message-State: AOJu0Yxw48tQ8PjSB5CHbAGeAkUSCwfHnV0PhZXBDNWe9gS/+G8M7QJI
	ytjJGXCoSHmRxWoX4LVFIlLeEH4svk1hJddob3CvnnucoeelBa85
X-Google-Smtp-Source: AGHT+IHGHrykYSlNOyjcS/UZ6V4dNHsB1WQ6ZHMxk3R/TLseCIBbsBNj5CZuJv4DpukvlbxrMZDZEw==
X-Received: by 2002:a05:620a:9c6:b0:787:18b5:f56b with SMTP id y6-20020a05620a09c600b0078718b5f56bmr305955qky.34.1707862756217;
        Tue, 13 Feb 2024 14:19:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQWEXelBgT9oVykeo4eUb5AO+sFg5/aRwKxasJIC9ql0n+08RV5wwSQteDqeZJKuXvu3Qg3T0TmXGKycuzb+o8bpeTeeojh9w7381pktWRSaj1hidZhDJErIils6+ExmR4BJtsD5Hzt4u+jQtqx20JjbsfcFlGZz3koKLI7snxS71tg7Ej+4jgR3FZQyjxxgaWY15Lcv9zbN4mH3T9YbKyDUdGYLLWL6XuBMdu3OXRv+AdgErqK4pPcmyFHF/DqEnofsRC9mzsC0lh2xCYJw5iW41d6ZNbYgEthTtPZgzbWcbMC09ZVYPP7IwKrytZ01exUluV5pvs4Oe0yFpoJAFV5JCgfiNi8zhqIN794NRF8pNWwnZPWfPbkj70f3XvlgrJRAanyAqQehNmZ3DjZh+t5wjXgq+ykRAjcaGk6Tc89LIUQhLMt69STQ8v22/7qJgSQW435DXaYzMEQ0ds59IRxQXeUPH5kwNyQBqS4SrAuh/2NQ0Rxm5SkqOJiZIzRJJilhlxiR+g
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05620a166900b00783f1e600aasm3282430qko.38.2024.02.13.14.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 14:19:15 -0800 (PST)
Message-ID: <ff048126-fc13-46d5-a77d-d7ccd21578fc@gmail.com>
Date: Tue, 13 Feb 2024 14:19:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/124] 6.7.5-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240213171853.722912593@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


