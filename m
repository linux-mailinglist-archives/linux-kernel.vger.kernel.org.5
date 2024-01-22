Return-Path: <linux-kernel+bounces-32743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEFB835F93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C802818F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77783A8FA;
	Mon, 22 Jan 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="gLK1//++"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0183A8D7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919000; cv=none; b=M/8Ohb0di1CzPw6nKEDjvXo1xEOycANdgJrTQEugZKTRw4TGrNv8qQVGzCpbN8Biu6ZQDyolUGz6t02mWFn/d8p24z9ZMbx3VjLltef00Bu3ScmvHl+0ek6ebEWJiAJY4hBYdKecXCCL7XGyYSp+qWiVhSg8YnOyEI9ucyt8Zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919000; c=relaxed/simple;
	bh=1nl8NNffj7gBgklScyo7sCid0QnwTusAco83gT4kcso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoLxeeFiVq+MVc5SLX24jSqEy+cY2jU0KvVbpngiLt4q/SXW8TbbfHDAejzsXD9qY/4FrQyiuw1bzmUijWJbUKFrKLRbbH816/9sgmkMg/NTH+Ku3vB/nvyqNZL8d5IlHqAYFCprzWHehrN/IXFqoRoJkjpG7GraxpqOFBonfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=gLK1//++; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d75c97ea6aso2701965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705918998; x=1706523798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zsw9D72/oK7Gb2jEPYtIpfRuueJTHbctWbHrOu0MdQM=;
        b=gLK1//++/HbXhc+A4fhECLh1Z57oJ6nqR8gjGFTl0Z8WQor8D2G2Fh9lT5aEezrxac
         wXVctvys2Mh1wISgyIKRN2RiOugkmAtKCAuJi0WOfayevLE7L48OQa2VkkBrWeoGFnNw
         gT1mOl0i2KGdouwMcgf0/hxZBOZy5nw7nywQTXYbknI57Wo7VFvMgvNI+TAvjrPEPqLA
         pxw+pSJWgCrEv+fH46Fe8gYIKXvxjX4fUkgmRvC7utCe6s6UxmqrGuG8fHbzhOythEee
         lrZ3AI6lKAjCfjSSdjUkYEI8hJuSocXHJHEObd7bzVoy2yCFJXDAcnQ1j9CncsLJcEyJ
         uP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918998; x=1706523798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsw9D72/oK7Gb2jEPYtIpfRuueJTHbctWbHrOu0MdQM=;
        b=f+7vdPDvTz0Ipz0Mlxd4q6uLt3yML8B7TOYGiyreL7lbFxqW1wBiiadX2U5exuqAQG
         t8PzmvxRUALBd60RphsjgjGLivV+0IuWGh168EJlg25Hg2hWHkMxUQ4WCyArfJi1UppH
         2bEeeer4vwVOz+sRxcwg7N7diOd86kogmuauF26zCMMDRoPqWdx7S+kMjnp6IQMkJLy9
         1XxmBbVIJGgegggHTafEPPWGW7hy19dnYrD+cintfoEpK3Ae5Jl5MDBzHcsJNyZnhrYy
         aKNz3wLcyBWl0jHcZvATnvxx/TtIXnNxvc8bHfO4bKMYnR+w0DibmWTx55ENo90ubgMy
         E7bQ==
X-Gm-Message-State: AOJu0Yw34XvUGfwjQfhSlYrjstONkdUEyl9Cx38EtpWpw/3K8iL28PN6
	Jxut9Zb4Dp1ADgJ4n0gsps7KLM7D6n+qHxHCcQniVJ0/RmcDFDSPcLHtcUN3LYY=
X-Google-Smtp-Source: AGHT+IEkzu4z/5nbFawwFDvLxa23mN5c9eYljIYcJP35J8LlKOQGKSQLkaPwsURDvl6TePb7HfQhdA==
X-Received: by 2002:a17:903:2596:b0:1d7:284b:9450 with SMTP id jb22-20020a170903259600b001d7284b9450mr3695041plb.29.1705918998453;
        Mon, 22 Jan 2024 02:23:18 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id kj15-20020a17090306cf00b001c407fac227sm7005442plb.41.2024.01.22.02.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:23:18 -0800 (PST)
Message-ID: <3b134590-2878-4a05-84e0-a3aeaecbc730@tweaklogic.com>
Date: Mon, 22 Jan 2024 20:53:11 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: light: Squash APDS9300 and
 APDS9960 schemas
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-2-subhajit.ghosh@tweaklogic.com>
 <1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/1/24 20:20, Krzysztof Kozlowski wrote:
> On 21/01/2024 06:17, Subhajit Ghosh wrote:
>> Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
>> file and removing the other. This is done as per the below review:
>> Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
>>
>> This patch series adds the driver support and device tree binding schemas
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> 
> Also, this is one commit, not patch series. Please write commit msg
> explaining why and what you are doing.
> 
>> for APDS9306 Ambient Light Sensor. It was pointed out in earlier reviews
>> that the schemas for APDS9300 and APDS9960 looks similar and should be
>> merged. This particular patch does the first operation of merging
>> APDS9300 and APDS9960 schema files.
> 
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
>>
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 
> With changes above and what Jonathan asks:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> ---
> 
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
> 
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> 
> Best regards,
> Krzysztof
> 
Thank you so much Krysztof for the useful resources. Although I got the working knowledge from
"A Beginner's Guide to Linux Kernel Development" course offered by Linux Foundation but there are
gaps in my understanding. Time to study more.

Regards,
Subhajit Ghosh

