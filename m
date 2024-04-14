Return-Path: <linux-kernel+bounces-143988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3018A4073
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D24281E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D097E1B813;
	Sun, 14 Apr 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iy2qiJFm"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A3EACE;
	Sun, 14 Apr 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713074211; cv=none; b=qyJb/IF3Vq9XSlizzxxJw+4pVdQbHE0pCdIN5w8uiaQ4pc9coYaM9O4+AXtMvbCZHqPdDAaJU1RRMxbIlBx7zLbFat4lVcfR+SgfmeQdHb7Xb1tlnPAaGEyBVVBEvpE3+m6FFHVovUw0S/VyCI7PA0dkVEjnP56A7Qw77xRGEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713074211; c=relaxed/simple;
	bh=KivgbTn2TjsrPo2ja4uzg/5/ZT38YQ1cHGsT0X9kVes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6p4AOIOs98NiXCnqgvHw6I0NUqB1YMRz3M62kE2XtwWO8F+eV6B7BhBOrxULU15FywBy0OcEFUygjwWyILC+yCe6YDJnqzBLj863LkoEwsBImdCmGu19Y9xdeTynVTs75YyJyMlIDCFP6Z/kIy0rh7j2LJYNA0wPCrxIL5/1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iy2qiJFm; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8745920002;
	Sun, 14 Apr 2024 05:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713074206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahOKYxBn7JZUHImIDt0FCgSBhZDBBJgrqm5xrYRKkWE=;
	b=iy2qiJFmK21YvMN0hZOOobn/LeF21mvLEm6Zk3j8GVB+vYIpE1rDSCDaTkxyAWgr0kLDdi
	56z8HgTXbA0Aplo13lOU/St+OUTJ0xDHEbF5jkl+2hZlRj+CZzHjZcNcprle4idD8rV+IB
	6rcMYIsjlfThfC4W2iAqvwCf/pTwtHTbH7bWlw+XfgbNxdLOKnRmTwmiUvLr+7RdnecIYI
	EpT7JdyASLX71WhZKbv+Z5NiAj99zziCgN41YOKe7sX32IeoXaMU+C4/aLxC1LBT31I5z6
	75MeNwc3L7A98cRmcgeIJpa7qlZARUuZX3Lf2zMetTgxFBU/A3lTPOqKbcdp3w==
Message-ID: <2696c0e0-0f15-44d1-ba40-dcab4be802d2@bootlin.com>
Date: Sun, 14 Apr 2024 07:56:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v9 0/6] riscv: sophgo: add clock support for
 Sophgo CV1800/SG2000 SoCs
To: Inochi Amaoto <inochiama@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E5E78F930EE25A86EE1CBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
In-Reply-To: <IA1PR20MB4953E5E78F930EE25A86EE1CBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi

On 4/11/24 at 09:38, Inochi Amaoto wrote:
> On Sat, 9 Mar 2024 17:01:21 +0800, Inochi Amaoto wrote:
>> Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.
>>
>> Changed from v8:
>> 1. improve code.
>> 2. remove default config in Kconfig.
>> 3. merge patch 2-4 of v8 into one.
>>
>> [...]
> 
> Applied to sophgo/for-next, thanks!
> 
> [5/6] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
>        https://github.com/sophgo/linux/commit/bb7b3419627eb34f3466022d1f4b3c942c09712d
> [6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
>        https://github.com/sophgo/linux/commit/18e8c6d2cced6c57d62813f49b57eeb8ee02f984

Oops, for your information, this last change
([6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC) 
breaks my Milk-V Duo S board when I boot it with cv1812h-huashan-pi.dtb 
as I believe you suggested.

I don't know whether the board actually boots, but at least I don't get 
any more output in the console.

Has someone tested this on the real Huashan Pi board?

Cheers
Michael.


