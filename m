Return-Path: <linux-kernel+bounces-151457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A4B8AAF31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B5A1C22170
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAC1272A2;
	Fri, 19 Apr 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="bWYGChA9"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455F19E;
	Fri, 19 Apr 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532797; cv=none; b=TR712nR2YJQ/Ip0vbMmI6XrhO105cK6CazcHNoNe8ucHBa5v5Z1J50QeDCH04ZuaAP5p/ECsU98s6K01uzqlOr4F/geijPRAaUySH3m4SMjrKpoxSZuDWH47qTWiyqLeUSwznI1iIWwhXo4BD7PCs2zeaDFvAdZnoT0gH9Hcx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532797; c=relaxed/simple;
	bh=YtNxjDr6ye0tfNkDHrO8NQs2k9s6SpkWez4dpC7SRbw=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=CRKxhATG4SLKoMuh7P7dhjvROZ9AG3zc+O/obDFB+YjbLEUKalyPkX38XqssgsY/V7z3J/fSheqoSaXkrmMnmFdLhtQC1mmaESNL2V+VQwxhWWw6DOhT41fdn30W+ZMsCs/Z/D3b7Ny3yuHPcH5rPGc2QZWQ9vZYLpwdgUxBHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=bWYGChA9; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1713532795; x=1745068795;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=ISutO2pj2s7Fy7875dgH0wvjUUVXcJi8DHrFYOiS41E=;
  b=bWYGChA9m/E6EcTxzeWS2rXiTWdwwP6igzsHTTzpU0QvZHB+jNmLTXLW
   d2ON7s4nlpaevVMtcQFzVhrsL8O05QhV3cqA8V5RFfehxo4KQLIxcT+uC
   qatSGULp9FDMAS0cfQtpDsp00X9n81TqtHXVZeUQFFDDkEIJWu6peusbj
   4=;
X-IronPort-AV: E=Sophos;i="6.07,213,1708387200"; 
   d="scan'208";a="82627423"
Subject: Re: [PATCH v7 0/3] virt: vmgenid: add devicetree bindings support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:19:51 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:23544]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.189:2525] with esmtp (Farcaster)
 id 1b5b2be0-81f6-477c-a1ce-ffec33c6ea87; Fri, 19 Apr 2024 13:19:50 +0000 (UTC)
X-Farcaster-Flow-ID: 1b5b2be0-81f6-477c-a1ce-ffec33c6ea87
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 13:19:44 +0000
Received: from [10.95.129.79] (10.95.129.79) by EX19D036EUC002.ant.amazon.com
 (10.252.61.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 19 Apr
 2024 13:19:39 +0000
Message-ID: <3dc70f28-b2cc-44b8-93ad-c5550d8298c0@amazon.co.uk>
Date: Fri, 19 Apr 2024 14:19:35 +0100
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
	<krzysztof.kozlowski@linaro.org>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240418121249.42380-1-Jason@zx2c4.com>
Content-Language: en-US
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240418121249.42380-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 18/04/2024 13:12, Jason A. Donenfeld wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> Hi Krzysztof,
> 
> This is a cleanup of Sudan's OF vmgenid patches, simplified a bit, but
> still with the same intent and mostly unchanged. I'll take this via my
> random tree, but I would appreciate having your ack/review on it.
> 
> Sudan - if I've mangled something here, please let me know. I verified
> this still works with ACPI in QEMU, but I don't know about your private
> firecracker OF branch, so please pipe up if something is amiss. It's
> basically the same thing, though, so I suspect it'll be fine.
> 
> Thanks,
> Jason
> 
> Sudan Landge (3):
>    virt: vmgenid: change implementation to use a platform driver
>    dt-bindings: rng: Add vmgenid support
>    virt: vmgenid: add support for devicetree bindings
> 
>   .../bindings/rng/microsoft,vmgenid.yaml       |  49 ++++++
>   MAINTAINERS                                   |   1 +
>   drivers/virt/Kconfig                          |   2 +-
>   drivers/virt/vmgenid.c                        | 150 ++++++++++++++----
>   4 files changed, 166 insertions(+), 36 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> 
> --
> 2.44.0
> 
Hi Jason,

Thank you very much for helping us with the patches. I am on a personal 
leave with very limited access to mails/system so Babis is helping me by 
taking over the task. Looping in Babis so that he can verify the patch 
with DT. I would also kindly request you to please loop in Babis 
(bchalios@amazon.es) for future discussion on these patches.

Thanks and regards,
Sudan

