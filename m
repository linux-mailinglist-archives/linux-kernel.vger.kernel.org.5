Return-Path: <linux-kernel+bounces-119135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37188C4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03E91F80931
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCB12CD84;
	Tue, 26 Mar 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="vDz/dElL"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E980041;
	Tue, 26 Mar 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461928; cv=none; b=LPKgeu+KKjtuwg7WMixKadEgjt66kweASHYGVXTvh3c5eXpGQg+5mRJpDBrwrKo+Qqwkg0epgu5E81dFO70WAFwbgtlCHQyZpuyDKTvcSYurApiy95utAx2D+U6wrGhhMkktQ/m1Q5j/rI13+aVBPDyj28j4lrULIgj7jxaLPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461928; c=relaxed/simple;
	bh=N3kss6PrGo5tc5VrZLQwv/+ImijnuKSAdKcXE3KeeMA=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FwgRy2b7fYt/nReWgdaH1BOjcfkwDp+FHCF4zpuw35Kw9ctJUOrEBLhLj0DYfGnZrc2OYHzImRQF0J7Gu8cU61VXFQyxibYWxYmOU/8ujyjB/Df6hqD+Pj8wyMeL6r6I/ZacSgzGgdJxrIALrEWuu5/OrYXsZkE25zVWMPzLPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=vDz/dElL; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1711461926; x=1742997926;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=3XwGW7dl6z5Ju7WwHMpRk8zOsGdEdnYbJH7m56E2TAY=;
  b=vDz/dElLv1GVOPcg5h2zB1Su2cvZxWE5Nhoqwv3lFaArqjX7/Utx2V8L
   vOKiTA1zkRegAjjJ88wJkxXJDROng54zne8PA+0XZHTQnNPMsDSWwLLw4
   wEmdHRE/kE13y4p5qrKDJ5nVjXFcD9mnzK7krV2TO2OSX96o6TKjyjS0O
   w=;
X-IronPort-AV: E=Sophos;i="6.07,156,1708387200"; 
   d="scan'208";a="76291474"
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:05:22 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:24611]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.129:2525] with esmtp (Farcaster)
 id 20f00147-80a5-4252-8699-a08fdd204313; Tue, 26 Mar 2024 14:05:21 +0000 (UTC)
X-Farcaster-Flow-ID: 20f00147-80a5-4252-8699-a08fdd204313
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 14:05:21 +0000
Received: from [192.168.18.216] (10.106.83.18) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 14:05:15 +0000
Message-ID: <b8029b57-a33c-4305-ad27-5848f0702053@amazon.co.uk>
Date: Tue, 26 Mar 2024 14:05:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, kernel test robot
	<lkp@intel.com>, Sudan Landge <sudanl@amazon.com>, <tytso@mit.edu>,
	<Jason@zx2c4.com>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <graf@amazon.de>, <dwmw@amazon.co.uk>,
	<bchalios@amazon.es>, <xmarcalx@amazon.co.uk>
References: <20240325195306.13133-5-sudanl@amazon.com>
 <202403262047.aZVjmDY5-lkp@intel.com>
 <727c3a30-d704-4d28-af40-a01e28ca042e@linaro.org>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <727c3a30-d704-4d28-af40-a01e28ca042e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 26/03/2024 12:53, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 26/03/2024 13:48, kernel test robot wrote:
>> Hi Sudan,
>>
>> kernel test robot noticed the following build errors:
> 
> ...
> 
>>     134                ret = setup_vmgenid_state(state, remapped_ptr);
>>     135                if (ret)
>>     136                        goto out;
>>     137
>>     138                state->irq = platform_get_irq(pdev, 0);
>>     139                if (state->irq < 0) {
>>     140                        ret = state->irq;
>>     141                        goto out;
>>     142                }
>>     143                pdev->dev.driver_data = state;
>>     144
>>     145                ret =  devm_request_irq(&pdev->dev, state->irq,
>>     146                                        vmgenid_of_irq_handler,
>>     147                                        IRQF_SHARED, "vmgenid", &pdev->dev);
>>     148                if (ret)
>>     149                        pdev->dev.driver_data = NULL;
>>     150
>>     151        out:
>>     152                return ret;
>>     153        #else
>>   > 154                (void)dev;
> 
> So this code was not even built...
> 
> Best regards,
> Krzysztof
> 
I built it with CONFIG_ACPI and CONFIG_OF enabled but missed to build it 
without the CONFIG_OF flag. As mentioned in the other mail I'll make 
sure to run all required tools and check for all combinations before 
posting future patches.

