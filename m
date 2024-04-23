Return-Path: <linux-kernel+bounces-154585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225468ADDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B41282D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762F2BCF9;
	Tue, 23 Apr 2024 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ExTkTY/x"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE71CAA2;
	Tue, 23 Apr 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855834; cv=none; b=TvEQeZeKc7TMil9F9DAOnFlQfNOm5lwj0M7FbFWRDFypWAiEusYjGELUQdURuxhClaPJnbcNGiwfDerWuk8rsco6+JgUuCbU0Mi6pQLTwWKe+e+8jPCgk0EnzcCSbjb+mnugVlF7BSimgCZcho/oISkt6Nyd4lGr/33DKtVRr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855834; c=relaxed/simple;
	bh=tVTZ5nQJo5oHxZUca5K3elVZSIgFpNkbGGo8ceYB9f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqtzWuNdHRqi5LM1RvTKOrGiQZo0hjpf+pXUIC+mse5Svv4d7zbgnVSLCWd+I8suhbOCKBxr9Z78i53h8GZRkUqL0YyTi6Nt9LFIyIrTF6XRNiW5tT1b9dojwvFMAzjt3YlcfsMDGbfk7TqEt6nkJq+TkyWCow+t7kb9BQ4L3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ExTkTY/x; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3640440006;
	Tue, 23 Apr 2024 07:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713855823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8E7P5Zqt1WBHXhfCqOyC3CG6Kfg8g4HjwwCfyhGTYVQ=;
	b=ExTkTY/xveFxw6CwaKo9MJhLRiQUF7mtxrm48Z8Qye4LU4vhnopXPYdBBdK0Or+igGvFKM
	GZqwHOkMvNCKPMbmSW52+6PD+UWQ2vSF+FDRDZ+7rkAYnL+Ja7q8BiA52svX0vt+YjIWv0
	3HswJBBUx6orFPPsjRmpheuEw+pptn4nti0JnVU9jDlzE9Pjgd3eZLfp4wL4uj9Oq3osIV
	GO7v8cLLOdSiivaa1hhPFl9K4qumIyVnjRG3oZQp7oLspWqPST7rnvOwCRcHjHIZ9rK+8q
	lDvZGgLLp1ac3uCAhridgy2mmZPzFxrn8utQn6J9eiOG07kTScDwYr03ejI/KA==
Message-ID: <c59348dc-2f14-4d09-9ab9-36d1c25408f4@arinc9.com>
Date: Tue, 23 Apr 2024 10:03:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Document ASUS RT-AC3200 and ASUS RT-AC5300 and add
 device trees
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
 <0395c3a1-1211-4962-bafd-fbf20be98ce4@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <0395c3a1-1211-4962-bafd-fbf20be98ce4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 23/04/2024 09:24, Rafał Miłecki wrote:
> Hi,
> 
> On 19.04.2024 09:22, Arınç ÜNAL via B4 Relay wrote:
>> This patch series documents the compatible strings for ASUS RT-AC3200 and
>> ASUS RT-AC5300, and adds the device trees for them.
> 
> I was on holidays and couldn't reply earlier.
> 
> This patchset looks good to me, thanks for your work!
> 
> Bot warnings come from .dtsi so they are not directly caused by your changes.
> 
> Nitpicking:
> Try to put "reg" before "device_type" in future.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst?h=v6.8#n112

I'll address this in v3, thank you.

Arınç

