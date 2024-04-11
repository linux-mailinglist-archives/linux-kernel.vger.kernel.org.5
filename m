Return-Path: <linux-kernel+bounces-141583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CEE8A2050
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74923B256C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018111C287;
	Thu, 11 Apr 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="mp6BwimZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AF18635;
	Thu, 11 Apr 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867821; cv=none; b=B04Gti6go0G76GRrgIK4BR1mrAfnhSer2YTyr1HiN8G67wm+IScMEquYKUUL9HH1scky/avgJbgGMzhTYKCS87oVRDms/p/4mG0bB9T09r0c0rG5XctKOHupQePSlTBXstNV9u4M6FYBz2xsuD6MLuZUY9hmKC+bJ8wZvqnMbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867821; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho0rW9wGaEDJeN7Ok1W45pYLDs8SAD2WQnwz/n3/VcYGdtUZqVQaCReLd0jhj/akxMSSTb9wgswcvkPHjpBo4UwpSZ0+tS2pnuMHlhh4kt8qKSrJ4hRaJSoCKmMjxf/VzgPyLY4B0Ul9e0TXCEdcvWdDy/ghP8bA+EaNtDXqIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=mp6BwimZ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712867792; x=1713472592; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mp6BwimZqRGf6PmrHL+K1TTIDteZ4vNehMgc2V6VnegPlyQc7WOClZazn1lJ6YOI
	 RGxgI/7ksEdmhylbs4WVdy0AlQsZuJkt30eZO2wwUTsDLZDh/9W+hPpGrxS5/BucH
	 uziqi75xXfEYVJo8tgYM/kJW5DWK/q4Ejmx205CHOhY/4Xv/eQBpqx9WZWLI+JXXw
	 8Dt87rRZKv+mciES3rFuxsW00c7WKYdY5/tS3mcy1/t9pgByBfUBmh2o+P1p1CGiC
	 w8MyZf8eQ2VvUzMqkLmEVZQzdEGyzTm8mOvSn6tfC67+3yzxoWVcx31Akmff1G/mI
	 N5OBYZYinJG9nazLUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.118]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1sOrjI1YXU-00h4IL; Thu, 11
 Apr 2024 22:36:32 +0200
Message-ID: <0cd9f4dc-3d11-4415-a818-f86f3cc90be1@gmx.de>
Date: Thu, 11 Apr 2024 22:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095420.903937140@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:W12SHJDXLS1ndPqcvEpZJieiHmxdRjGQWpVeZ06B8HJbZQVjlZj
 JdMAdOAVT7pWp4s/NvJsQFXjRrPGf07z926lQV7pioiRsvDiOLEjkwJSQRKqk0zu2U3G9Ft
 boEPqmWAwqYl80AkKFyrnV6s8n1vPdISR6+7PepLvoZVpoZQGkFRcccGcvvcqHqjLpvY0OR
 TaOhA3D7tbZD1iKlzcjtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OSNZYD1ohGk=;0/NShLD+wGhb/OqkpvOpte4DRhS
 nhUidjn8dt7jclpxpoRZ2aKA+eD8KsIvA2qTGknm3mjSvYPYi22gmhiinGBFwBguL7cNhGtng
 PkW6f3h9Z336uX4l0ymVcx5oos5RU+QsOvA2Bh+Lamy8Gm0qi0y7xmUEIq1VSWVcU3EyaqwGM
 y0CEj2faTsaO7L4dySlT5h5Minx7A7lFK1dkAe0y8+cwkAVAgo7WY+IpNcl+822JdCw6E3DZR
 zn7IyTX88fcErfSnKbuxMh2kTBDBL1FVmrBYrmh+jNKHxB7Wl0YfMynHPjqV3uB+QbB4dpPNY
 27w5IMkZSfjyUNzqF58BJP5Ovs3VplEKHes1YmcNDPEccchn8AhumHi9IAiAoT4CQOKWe+4GQ
 ttHYzoEiWK9WtBStnart4vn5v2jNgBJuUUriPg0/83cYn1QKXjj9Hdwe+RPFufjew7E7d/5HW
 c8S8pnKDzl4eYBTudOCVZUl/Og1tLBNKkiy6FyxoravEfN0P2WcVINISrx0NWF2kLZD7n/UEG
 v4N7YZz6/UiLSWII6QK+DljUUWoSQTNuZXK/+Ougg48crX+P4x6rIrFp+DmrMPReE2kN1HN+2
 Ae1Rv6xXCX5UTbq7yn/P3uy46NFnGt2DSLCnksa1Wb/CBHcIeSt3Chcp80zCsww3/5MD8/S5R
 a8eNMZxtARGqUoI11eD3WDt12710O3aomrxVK9ZmKKU+xPKuZEmVxwIPQP7OknEtoq9Yghtdn
 WdJuzBprX243NfET0lkKZ2cdLnoFOwP54k3KKtvz0tH7/VmLSIN51d9T44wdrPQFmbaQc/3hR
 N7tyhaxCfgJ783BZv9KAnFinyWorYML7hRkS5kx/HYfcs=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

