Return-Path: <linux-kernel+bounces-153445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F098ACE34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0748BB21551
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885CD14F9D4;
	Mon, 22 Apr 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="fSkW9QUU"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4914F13D;
	Mon, 22 Apr 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792616; cv=none; b=OSVW3FUj4eiJfTw/EOvFktb86/xGq02HP2qEgil0VAV+nyljm0A9wOAobqLKjdRk+ZNvsQWQO1F0Xgff7JNYzQuby0FRcSiR1N7SSjEZcHN/cWcXxDjg6XijJ2o90eOQiExgEiC6WNSZJ11Qm9cgJnK18JOw9i8tydsx/BrCYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792616; c=relaxed/simple;
	bh=WSq4KvJwk8NL6hUKtmmVHgfMxxCPeJRTm4KJa5lx3fM=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=mlWhX9yenC0bJmuq3PFsAQzVFJY2YvlhPR7Zt3VWcTKFpJbt+Ae/xEXDsvFebd0A3cGlev9vzPD3AorBaUcQio5qBzaItoIeQgiCMT0X46falIX4fq70mASLHMASRYjAIZS4g3l+J6xTzRwTyTYpWaMHIduT4rHYErXIdAKAmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=fSkW9QUU; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713792615; x=1745328615;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=WSq4KvJwk8NL6hUKtmmVHgfMxxCPeJRTm4KJa5lx3fM=;
  b=fSkW9QUURp1suTtpKq3dwmnBq/+5qEn7w+g9Ce6snQAkN34wKrgqvPSe
   txTftwBo8SHer8TXhwE2kZgtUNZ13IeYIDi0jRfnA4mT5xRN5CNPfYTVL
   xiw6qy7blHKZ3RX+kfO4U3+T2sLqGt+BsTCrnjSm4DBogLnnglJD5sHvV
   8=;
X-IronPort-AV: E=Sophos;i="6.07,220,1708387200"; 
   d="scan'208";a="628228523"
Subject: Re: [PATCH v8 0/3] virt: vmgenid: add devicetree bindings support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:30:11 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:9336]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.210:2525] with esmtp (Farcaster)
 id a1489158-2bb6-44ac-9697-4248b95dcfa0; Mon, 22 Apr 2024 13:30:09 +0000 (UTC)
X-Farcaster-Flow-ID: a1489158-2bb6-44ac-9697-4248b95dcfa0
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 13:30:08 +0000
Received: from [192.168.4.123] (10.1.212.29) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 22 Apr
 2024 13:30:04 +0000
Message-ID: <ba8e850c-756f-4839-b3d7-db8873f83392@amazon.es>
Date: Mon, 22 Apr 2024 15:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <tytso@mit.edu>,
	<robh@kernel.org>, <krzk@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sudanl@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
	<krzysztof.kozlowski@linaro.org>
References: <20240419224020.780377-1-Jason@zx2c4.com>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
In-Reply-To: <20240419224020.780377-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

On 4/20/24 00:39, Jason A. Donenfeld wrote:
> Changes v7->v8:
> - Remove Kconfig depends statement entirely, instead of ACPI||OF.
> - Check platform_get_irq() return value against < 0 rather than !0.
>
> This is a cleanup of Sudan's OF vmgenid patches, simplified a bit, but
> still with the same intent and mostly unchanged. I'll take this via my
> random tree, but Krzysztof, I would appreciate having your ack/review on
> it.
>
> Sudan - if I've mangled something here, please let me know. I verified
> this still works with ACPI in QEMU, but I don't know about your private
> firecracker OF branch, so please pipe up if something is amiss. It's
> basically the same thing, though, so I suspect it'll be fine.

Hi Jason,

I also verified that this still works with ACPI on Firecracker.
I also verified that the OF part of the patch works with this:
https://github.com/sudanl0/firecracker/commit/f382e09a9b1e4453d2b231232d89bcb85296ac87
patch on top of Firecracker.

Tested-by: Babis Chalios <bchalios@amazon.es>

Cheers,
Babis

