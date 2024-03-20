Return-Path: <linux-kernel+bounces-109142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF10881535
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226D6285211
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5E54BDB;
	Wed, 20 Mar 2024 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XHgD0N30"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A34F1E5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950781; cv=none; b=CpJ3udvfnkztvHeCpfdIKgR+8GCa9lEXBD4DIvKHt4Wse3hkfE+7fKV6E5yl0+ZbtRNnT72j65uQDY8HuygVSeejQoIm96dTzbBEc3fGSYBmP7ZNBYtg9aaFwXuvGEI0ncieMVFYZZVcLuzkC9nuXgvbrkgWnLm8cD5DD/ohF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950781; c=relaxed/simple;
	bh=s6NQedUXfZwfZWCI8U68XDjk31dsNA/Vfqft+OrXjBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COReb05UzXDEk6IigptXXNBNNYb4Q9lr7+WoSwcm1hFz5MC1KhOov5IjSESgl2MvfHx/ITazh/sXz+7wRIn1LWm5GjEGfj6zgdZQDy6rk5xu13LIY4YIh7dDq5Svunx9oG54pbfJplcJjfi9iqAVAT+cposw9sSAjEV8h+yx1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XHgD0N30; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341950a6c9aso630401f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710950778; x=1711555578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8jmgWz3VAY8ZzreiulUbSiKLh7pUnFJyujK1sVIPS0=;
        b=XHgD0N30+56AvxO3Koh50UrU+fvuMVJzH5XHI66m5HQeHUc5XywJAHgdhcV/wQS2Qn
         48v6f+1G1pNAzO69QBv05Q1QDu3Nugs9TjZJxUB+v+MKYXdVUAJGmsF7Z1RS6AmWvdo1
         T8zq6vi/RXNdsyhG1ANCzCAPweApB2YA9rAOD0BBIdMyncuuff72vRp1QV06UMnRTAUT
         cRgMbeIXZWRUHAIpcNinepaiSUKbiXdxCD3gR/4CQIg8AayqHRarH7qCRAEPy6ZVusoc
         d0dMAeUpiaOFOr+srddJZRLpSMDdikuvjsz6fWfU8U2YymLz+dOxz0IO/lAAz8+Tq9Lo
         lWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950778; x=1711555578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8jmgWz3VAY8ZzreiulUbSiKLh7pUnFJyujK1sVIPS0=;
        b=G1WjzmR1f+yvd8iLRaCqyjd+1fLw4XlWYpSWVV9JUx0bAlCJH00lfPy4WQcZ0vQzl2
         J2c7zlZbxqOQiAjG8b/TXYD1koH1r7E3KvV9w9jnguIe+LXSgubGmksG7MYnIy8Kj3Yc
         ykeuohw3XHSqF04KGOsdu2wwoaPHLiZPhrl8iW/5rEXKjprEg83CXWVbQ/PBmYbhdaYj
         XH18eA7R6z5WTN62HYwwv/SPI2X1TnT9rJQt6+XznFoORdgr02Hi/HEucCSmalo3cORA
         dxhFZLBus5x4YgJ2SOFe6ewMF8AUw5CPQzXZ/JFHeNbntyFNlRKyK+AdiA62weCeLZ1Z
         v0gA==
X-Forwarded-Encrypted: i=1; AJvYcCX4mxrf22C50YM8OPGM198ghlbUHUdJa+lnDayK9ctfIZx9BcS3dQiTyudpVVL/2iohBHgVXlzhr2bhCLuyaaiagQCi/DPaSIBsW20L
X-Gm-Message-State: AOJu0YzLDwvcW+KZGyUFKaOYKJzOZTplI+C2qdJUybAFU4p2XBz45Wr+
	vf+03s7jPnkVrlBnCnMm4JfRzxNM4TNJfOCJGN4vTikb47n1JuyfGhW1JodYQV4=
X-Google-Smtp-Source: AGHT+IETNVMK8m1jhOjqYEXAI9aTcnCW2E/0idMKApIbeQQjKSCih1HznLYl7yI8UjVpUVh5TwQcZQ==
X-Received: by 2002:a05:6000:ad2:b0:33e:c7e2:2b64 with SMTP id di18-20020a0560000ad200b0033ec7e22b64mr11376760wrb.42.1710950778011;
        Wed, 20 Mar 2024 09:06:18 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id o9-20020adfe809000000b0033ec6ebf878sm14939300wrm.93.2024.03.20.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:06:17 -0700 (PDT)
Date: Wed, 20 Mar 2024 17:06:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: Claus Hansen Ries <chr@terma.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"wei.fang@nxp.com" <wei.fang@nxp.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"harini.katakam@amd.com" <harini.katakam@amd.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"wanghai38@huawei.com" <wanghai38@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ll_temac: platform_get_resource replaced by
 wrong function
Message-ID: <ZfsJeGf0uRgKxj-W@nanopsycho>
References: <f512ff25a2cd484791757c18facb526c@terma.com>
 <20240320152246.GU185808@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320152246.GU185808@kernel.org>

Wed, Mar 20, 2024 at 04:22:46PM CET, horms@kernel.org wrote:
>On Wed, Mar 20, 2024 at 02:19:15PM +0000, Claus Hansen Ries wrote:
>> From: Claus Hansen Ries <chr@terma.com>
>> 
>> Hope I am resubmitting this correctly, I've fixed the issues in 
>> the original submission.
>
>For future reference, the text above probably belongs
>below the scissors ("---"). But I don't think there
>is a need to resubmit just because of that.

Well, otherwise this will be in the git history forever :)


>
>> 
>> platform_get_resource was replaced with devm_platform_ioremap_resource_byname 
>> and is called using 0 as name. This eventually ends up in platform_get_resource_byname
>> in the call stack, where it causes a null pointer in strcmp.
>> 
>> 	if (type == resource_type(r) && !strcmp(r->name, name))
>> 
>> It should have been replaced with devm_platform_ioremap_resource.
>> 
>> Fixes: bd69058f50d5 ("net: ll_temac: Use devm_platform_ioremap_resource_byname()")
>> Signed-off-by: Claus Hansen Ries <chr@terma.com>
>> Cc: stable@vger.kernel.org
>> ---
>> v2:
>>   - fix accidently converting tabs to spaces and wording in commit message
>> v1: https://marc.info/?l=linux-netdev&m=171087828129633&w=2
>
>Thanks,
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>

