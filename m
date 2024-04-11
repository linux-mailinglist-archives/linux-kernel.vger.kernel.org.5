Return-Path: <linux-kernel+bounces-140098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E08A0B68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC17A1C22706
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E481448CE;
	Thu, 11 Apr 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JWIXirOD"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6C10A11;
	Thu, 11 Apr 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824562; cv=none; b=L+mLPgqSkx1xf3YQlQoMiOHyFaFGQjt6LqLqsYqEauhCLZdZuaRryo6N0/QVaEpmmFIip8rPs82jyeebBd6chkpmRBpaArQpAbWThC8hs14HQIvVrDaXmd7KLyOY0ce4EuS4fxtks5p81r9/zOqQEs1QtY7zwWrHa4rAV0vUmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824562; c=relaxed/simple;
	bh=ieaVROucabkX/elO9QC0KMUJebDy7cP20PNCU7hAKsg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t5miCa0dnCMLbfhtgMTgMi1NTGgIJ3YIStVPGL3vHhcW236vKnQDTM2OWz3GWShzwEdkesWyOPu2ZCbdQ/1jtd5dmJ78lZ5pHNkR4Menb9Z5cr06ErhHNeQaLYKVp7TF83enbQD6PC0WGt4WVTnioR9JebJtd+M/wsI7kchLCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JWIXirOD; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50FBC1BF209;
	Thu, 11 Apr 2024 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712824557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1p7NHgdFRFW4BhKFxkt0bpU+PZz8Mug1imRTclDT8UQ=;
	b=JWIXirODoESQAgnqT43QvK+1ct3jUYCegnJvrN7hxW5xFqom7zT1woRDlqCMF0/3JyrUe0
	itYvrO3TgfEfm1JkPJ6PX2qZSJ34SYUx5631ox3QI8hr0YyPRRHhBDYcsGAjARL+n1ZdV2
	ec0J9zSlIUkxE7XUHSHJyKVyLuHKEjTfxcPsi8dbTaP6Bpenq2qUxojj5S7C41XJL4ZBoH
	hOgAK8x/UpYuhgOoZsPbzbIJKzL4vbiAQbMqnp6V7ncxwRlcOCRhpGPtjUzhGv4Bn79DRj
	Yqf+XAxM+0bFNxomoiJMoBn3nCSLz5SmX1jpq688FiaDxcKFc9omxyko62nf2Q==
Message-ID: <5fdda638-21ba-4fa7-b666-33cf2fd69dda@bootlin.com>
Date: Thu, 11 Apr 2024 10:35:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board device
 tree
To: Jisheng Zhang <jszhang@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: michael.opdenacker@bootlin.com, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240409-prevent-deepness-2d22bf009b16@spud>
 <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <1514d28a-5e96-4531-a972-894e41902efa@bootlin.com>
 <IA1PR20MB4953CA04D33EA0C7902DFA3ABB062@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZhZo0iJFSn1te-6d@xhacker>
Content-Language: en-US
In-Reply-To: <ZhZo0iJFSn1te-6d@xhacker>
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Jisheng,

On 4/10/24 at 12:24, Jisheng Zhang wrote:
> setting the correct bus-width is necessary for better performance
> no-1-8-v can be removed, but it doesn't harm anything because
> the board doesn't supply 1.8v
>
> no-mmc and no-sdio to make the probe a bit quicker

Many thanks for your advice!

However, whether I apply these changes or not, 
git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git is now broken 
for me:
Error: arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts:32.1-8 Label or 
path sdhci0 not found

I was previously testing with linux-next, but it's now broken too, 
though in a different way:
[    1.306811] /dev/root: Can't open blockdev
[    1.311200] VFS: Cannot open root device "/dev/mmcblk0p2" or 
unknown-block(0,0): error -6

Shall I submit my updates anyway?
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


