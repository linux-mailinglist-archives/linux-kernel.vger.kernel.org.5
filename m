Return-Path: <linux-kernel+bounces-25620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A416982D3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D6E1C20F67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29B23BF;
	Mon, 15 Jan 2024 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="2uJ4dNbi";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="yDnW9JeV"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227617CD;
	Mon, 15 Jan 2024 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id B4C4BC024; Mon, 15 Jan 2024 05:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1705294151; bh=jXnUWCVbqVo/RvrYFeI+Wf1Slk3T5yV1MYGKaV2qlw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2uJ4dNbiw0irKVDpmI4B/JsMLxK255fCg13x2wQPFNJCEKusYn5S5xyWeamJpSWyY
	 TUhX6q3ZuxTaU44l6hrVFU5vmR+oWOfEqPfrN1irYbjzLEIHvtanpQN7Uz0+STZCY5
	 zu0Tjnx1vKbT9VKNLLeoP81c+Dpi9PuKh7w7bJPO9G/Ir1zmKJQOWjywZojuUdEtS3
	 hz27zjXaljt/ahsg6qB2mcMyFrjkiv0HJEWIyvcDtbpldWq8SDxN15JzX3eHOB7rTk
	 FqX60+zcDik2CwTgDu5EB/yjqbNMkfyajPpnHWps3I7s5kojuZl1DFvZV9ASAAf2vS
	 oQYwrRgAFm10w==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id B2DC7C01A;
	Mon, 15 Jan 2024 05:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1705294149; bh=jXnUWCVbqVo/RvrYFeI+Wf1Slk3T5yV1MYGKaV2qlw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yDnW9JeV+qoXvo0Xh9UDdi/cux8BDalgikkSZLxrCCgCPXwzPoqhTH1G6ajYyrdb2
	 qdg/r54QNhjRpa20uCTpme6r6fs1sj+SieL2OTSEHRhHy5GMj80mTKHG2UTiVZPUO1
	 BAJk/2far164pni+ZS3iqcxboHPxLpRg6xbdfFLNnzF81Frqm7Ks9X47gnfVi22DwJ
	 THYXzV/ChcvHKQ2kQjkK89C/DqWxjPqwllb06Zva2zhzhqce/px5Ud+MkED4B3zFxt
	 ZRSajeYMLWlwtAVpimoz3M/tu8Ops5glAYIPApdJ6i1fWkGDMaMST73lLHKSe5kx4F
	 Bf9EjkovTQSvQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id bf16f1fe;
	Mon, 15 Jan 2024 04:48:59 +0000 (UTC)
Date: Mon, 15 Jan 2024 13:48:44 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/43] 5.10.208-rc1 review
Message-ID: <ZaS5LPFq0KQqOR_V@codewreck.org>
References: <20240113094206.930684111@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>

Greg Kroah-Hartman wrote on Sat, Jan 13, 2024 at 10:49:39AM +0100:
> This is the start of the stable review cycle for the 5.10.208 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.208-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 7884d82278ab ("Linux 5.10.208-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus

