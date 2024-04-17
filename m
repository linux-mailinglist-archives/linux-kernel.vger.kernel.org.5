Return-Path: <linux-kernel+bounces-148789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572898A8776
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8341F23E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35891474DE;
	Wed, 17 Apr 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="b3s48av5"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC6146A78;
	Wed, 17 Apr 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367438; cv=none; b=OvUc6QESSwP+XtlHEKgypV9sRa9h71TLPLlcIbrxg2AeRmQ37DHCJR4SqwjrtLfEV5XjwoNI0HpjhzcBtK7lvBzVvJyMCQ0YOPHULOZeZBpL0YOUKKtJ7z+iMd+hwMtNPkERHTNEPUJkHNj8ZAQS5eB5HKN9KE/9z4D+G0pyZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367438; c=relaxed/simple;
	bh=lBxDXYbHQaraSNFYRXGNQ1zCz31iJvZpUYUEZ/hpAo8=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tzIxXDNYkN0S0Ton4cc5uVN293kTA90NzhwH2ZhwK3yV+0/EOqfU6HzRRqZGqjUCI9HmTFoNGo5bNGbBxZ/nhvmPrCAAofl7/1u2XRsGd3Ejp3NoQYKwZ4y1exYgjKW3U/iyjGXVB5Aeo2k9E0X3FD5VbTG3VvJOwirSmPhoZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=b3s48av5; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713367436; x=1744903436;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=lBxDXYbHQaraSNFYRXGNQ1zCz31iJvZpUYUEZ/hpAo8=;
  b=b3s48av5HHDlmEGUXUmHdEgD5wPaNU0vpAnMEfKHeDCmIbvsbUumMgF7
   nGu0JDtzExRUj1rAYvnVii9KhYmIau2lSQY+IrnoOBdyBP8Zr6hZFvxx9
   /aUPA8kWGzZmbOfakHTvQ45KKayWJ8u1ihYi6bWoJc18A+IAQnfGogipk
   8=;
X-IronPort-AV: E=Sophos;i="6.07,209,1708387200"; 
   d="scan'208";a="652635136"
Subject: Re: [PATCH v6 4/5] dt-bindings: rng: Add vmgenid support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 15:23:54 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:13019]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.146:2525] with esmtp (Farcaster)
 id 4ded3555-bd22-47dc-8c6a-e4aa6af82997; Wed, 17 Apr 2024 15:23:53 +0000 (UTC)
X-Farcaster-Flow-ID: 4ded3555-bd22-47dc-8c6a-e4aa6af82997
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 15:23:49 +0000
Received: from [192.168.27.23] (10.1.212.9) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 17 Apr
 2024 15:23:43 +0000
Message-ID: <1c48bca7-611e-4270-b403-71c7c9074b4d@amazon.es>
Date: Wed, 17 Apr 2024 15:23:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <tytso@mit.edu>,
	<olivia@selenic.com>, <herbert@gondor.apana.org.au>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sudanl@amazon.com>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
	<dwmw@amazon.co.uk>, Alexander Graf <graf@amazon.com>
References: <20240417104046.27253-1-bchalios@amazon.es>
 <20240417104046.27253-5-bchalios@amazon.es>
 <a9f1d643-f171-4b41-88c5-bd9bae0f8200@kernel.org>
 <433a026a-352c-48c1-84cf-e538bb30aad7@amazon.es>
 <CAHmME9r647g++mOuG7DGz27pwaVKyc-HrbH2Z2nmHXA4ko6h-Q@mail.gmail.com>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
In-Reply-To: <CAHmME9r647g++mOuG7DGz27pwaVKyc-HrbH2Z2nmHXA4ko6h-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

On 4/17/24 15:20, Jason A. Donenfeld wrote:
> On Wed, Apr 17, 2024 at 5:19 PM Babis Chalios <bchalios@amazon.es> wrote:
>> I will re-create the patches with correct authorship, my SoB and the
>> Reviewed-by
>> tags I had received in previous versions and send a v7.
> Please don't bother.
Hi Jason,

I am ok with it, if that's fine with Krzysztof.

Cheers,
Babis
>
> Jason


