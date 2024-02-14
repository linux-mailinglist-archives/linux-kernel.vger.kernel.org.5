Return-Path: <linux-kernel+bounces-64836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AAD854375
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51011F23EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F511731;
	Wed, 14 Feb 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvD8tMpJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DE111B0;
	Wed, 14 Feb 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895931; cv=none; b=UpnaaXtWV4xMowq4d/B0Is01cDTzgIihlfdL3CnMCx9UMyfnMWfSjtBSVJ2JjunQbtlzlaBSFKGnE+sLTwk2hxAjDWGcxihyv2qD2a0rlQM3eR+ZJxHIgpxWakqOJ2xNYD45fyCaJ6jLtXe38o/iKbdm9taMGbSlN1+oChqXL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895931; c=relaxed/simple;
	bh=LM2IB9SElIQ6+pEyWjXuf51qCFqbWgrTmsGtpFnwYc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9c6CWDek6dndJfckSyco7LkiMf/xvFvK6cTkYxTKi3J7FuwEGfm6Ku49NuEM2KO6azNbML2OiByQKbR8QApG73g1Q/E4BZnGLoGKz3KSYEg1Y6LnW9ZckmP7JyY427ME7oZJVWwARsFn5aIzVWKMFRmIeDSj8Uk9dllUtDyQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvD8tMpJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so7116833a12.0;
        Tue, 13 Feb 2024 23:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707895928; x=1708500728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=49aOrJr7B4Aglez3Lo4lLfv0gxXRG3P37YvD5FawF18=;
        b=YvD8tMpJcgEyJ9M8D82CwOgCiVZHy8chFbIkkKBbgLQzgFSwJT87+qxjQRj59R0p/c
         zTrVxIDxDvr48IIvuvRnPKVliL7kj+qArgbXgTkk7OPeo71YMhnJ4xiJkp21K2Gy+JTs
         0Ti123Y/GfRm/mqJa1D/R8z9ZmTuzC8HXb//OAgwt8emoAbjA6DPbGNT/z3nm395IXNW
         mivH4bX1StdKdwQgl5YJxv2pS33jBe2GhwX/5Ykgce36IAgrXY8SL2RyNGrloLOm15kp
         DUHkkA8F2Hs6sSdqStEyEuZOJL1AU3Ie2WFDE2pfOYU92ukXKuKemLdnP3AS9OGrKqtH
         aT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707895928; x=1708500728;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49aOrJr7B4Aglez3Lo4lLfv0gxXRG3P37YvD5FawF18=;
        b=sA6Br8BQ6BLzra1u85wZFBn402pXUS7vil+m0zyhFqJ5C3bohLcKMuB31Yzm3cx8h4
         IdDL604qmZrQi37i5e1+VDbnzuLbwOXCwqb9Oz7UocWc2u6JWnb92C1nsfhpt1fqaf4c
         24jEwQxvYhJu0lDWy6y8F9T9fqsYPx4wWnleMvhi92nfOBxk6UC9DUSo0kAvGwrwiW3x
         7limP+d5VggBwdku+sgdWB/yoqARXvNwUgH7DUSgChiiQKkdl5WcO4WbaIOWMoIlFULi
         nhTl8sIjQ3IrqKtlQpMqJfw0553be9Z0IW8wrjWQ2TCezzWojRLUHG4h3b73V4o0lZfK
         /byw==
X-Forwarded-Encrypted: i=1; AJvYcCVidRiHAF2jUi4FeDA3mDbQWKweffjoalpbpNmcUN1dVMlxaHJEKm+rDRWBjXHcVJ8Agxx6OYTv+lnsdt/oK7Vqraxc17U0ivPaUjAv1knU53w0eoBnstBxJZJUAwBcM5qbxoNf
X-Gm-Message-State: AOJu0Yxp9/FI4fvBoUR+8IJskKDX8JJGHRoJY7mGc9mRXKrJFoVPAfY3
	M6ZO9KciXWXg3V5lLWt55WnFIqNi+aZBbrb5zP0oJdQXlFXSNFQJ
X-Google-Smtp-Source: AGHT+IG3c6h9gyn4zyta5HN/CDiYJ41kXKHipVWz4BRzIAxUsh2cMOT4IpKPdTSIawoEWC2bI1r/Sw==
X-Received: by 2002:aa7:d4cd:0:b0:561:fec0:cd44 with SMTP id t13-20020aa7d4cd000000b00561fec0cd44mr1529856edr.27.1707895927439;
        Tue, 13 Feb 2024 23:32:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsqEbnnEjEjvZGKZNSrCi6lK6tY2EY20y1CAj5okthGZgfgt1sTEfTUDyZCXGFr9MVn1mandx9pHGo29ntYpHNAso4TnvqtBt66IvIK+4UbtcTLS1DGyoX8bW+XlZjCyUmyefrX1YeczRTyu/nA+bpaSHJlQVhruHUJWBjoYct5zZ/J3hFn+brnto4A8ivspG06H+x/BY/QUjuwagx9+Q0u6S9KqMI8WDvM5bUaAo+x6t0xrRXmSO07FHUJjyPcEDoOw6XEjP0cLWjQODQiS/jGZwZQNDrYjWoVMp/RBWiO7xaMgKgRR/FBxszeVOjmCkdU5E6bhz+4KIl1Bf/zP/y
Received: from ?IPV6:2a01:c23:c153:4a00:1137:dd85:a3c6:eb6? (dynamic-2a01-0c23-c153-4a00-1137-dd85-a3c6-0eb6.c23.pool.telefonica.de. [2a01:c23:c153:4a00:1137:dd85:a3c6:eb6])
        by smtp.googlemail.com with ESMTPSA id bd28-20020a056402207c00b005613194b260sm4463721edb.9.2024.02.13.23.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 23:32:06 -0800 (PST)
Message-ID: <f640ed12-3e72-481e-a2bd-4c6ccc092532@gmail.com>
Date: Wed, 14 Feb 2024 08:32:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [net-next v3] intel: make module parameters
 readable in sys filesystem
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jon Maxwell <jmaxwell37@gmail.com>,
 jesse.brandeburg@intel.com
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20240213222344.195885-1-jmaxwell37@gmail.com>
 <926b5031-47d2-42d7-938d-01fc4ebc9dc0@molgen.mpg.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <926b5031-47d2-42d7-938d-01fc4ebc9dc0@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.02.2024 08:22, Paul Menzel wrote:
> Dear Jon,
> 
> 
> Thank you very much for your patch.
> 
> Am 13.02.24 um 11:23 PM schrieb Jon Maxwell:
>> Linux users sometimes need an easy way to check current values of module
>> parameters. For example the module may be manually reloaded with different
>> parameters. Make these visible and readable in the /sys filesystem to allow
>> that.
>>
>> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>> ---
>> V2: Remove the "debug" module parameter as per Andrew Lunns suggestion.
> 
> Please mention this in the commit message, why `debug` should not be exposed.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
>> V3: Correctly format v2.
>>   drivers/net/ethernet/intel/e100.c             | 4 ++--
>>   drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
>> index 01f0f12035caeb7ca1657387538fcebf5c608322..3fcb8daaa2437fa3fe7b98ba9f606dbbb1844e58 100644
>> --- a/drivers/net/ethernet/intel/e100.c
>> +++ b/drivers/net/ethernet/intel/e100.c
>> @@ -171,8 +171,8 @@ static int debug = 3;
>>   static int eeprom_bad_csum_allow = 0;
>>   static int use_io = 0;
>>   module_param(debug, int, 0);
>> -module_param(eeprom_bad_csum_allow, int, 0);
>> -module_param(use_io, int, 0);
>> +module_param(eeprom_bad_csum_allow, int, 0444);
>> +module_param(use_io, int, 0444);
>>   MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>>   MODULE_PARM_DESC(eeprom_bad_csum_allow, "Allow bad eeprom checksums");
>>   MODULE_PARM_DESC(use_io, "Force use of i/o access mode");
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index 4df8d4153aa5f5ce7ac9dd566180d552be9f5b4f..31d0a43a908c0a4eab4fe1147064a5f5677c9f0b 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -202,7 +202,7 @@ static struct notifier_block dca_notifier = {
>>   #endif
>>   #ifdef CONFIG_PCI_IOV
>>   static unsigned int max_vfs;
>> -module_param(max_vfs, uint, 0);
>> +module_param(max_vfs, uint, 0444);
>>   MODULE_PARM_DESC(max_vfs, "Maximum number of virtual functions to allocate per physical function");
>>   #endif /* CONFIG_PCI_IOV */
>>   diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index bd541527c8c74d6922e8683e2f4493d9b361f67b..9d26ff82a397d4939cf7adea78c217e4071aa166 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -147,13 +147,13 @@ static struct notifier_block dca_notifier = {
>>     #ifdef CONFIG_PCI_IOV
>>   static unsigned int max_vfs;
>> -module_param(max_vfs, uint, 0);
>> +module_param(max_vfs, uint, 0444);
>>   MODULE_PARM_DESC(max_vfs,
>>            "Maximum number of virtual functions to allocate per physical function - default is zero and maximum value is 63. (Deprecated)");

I doubt it makes sense to expose a deprecated parameter.

>>   #endif /* CONFIG_PCI_IOV */
>>     static bool allow_unsupported_sfp;
>> -module_param(allow_unsupported_sfp, bool, 0);
>> +module_param(allow_unsupported_sfp, bool, 0444);
>>   MODULE_PARM_DESC(allow_unsupported_sfp,
>>            "Allow unsupported and untested SFP+ modules on 82599-based adapters");
>>   
> 


