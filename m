Return-Path: <linux-kernel+bounces-142494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8D8A2C46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3657B229B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E79C54750;
	Fri, 12 Apr 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="p/vnKPTa"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5E54650;
	Fri, 12 Apr 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917541; cv=none; b=J8eI6hvb7AHhTNK4smCjfCRPUq7/vfADU3Evds3jL++qh6xTAaBa8+IVmEIznKs9iBfc8+O6bklRPoWo8GZ7zrpJLAA0/FhkSAL+pim5xlNmwJF38c4536IXBVuRjUPAT3kNHyOuXS5IEeEpGIb4jAfGLgE84NPoxAcm2TEZbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917541; c=relaxed/simple;
	bh=jTmsjeOHZ301XTyRNyKPCHgoOUQGTv0qyrMDlzlNzuA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZHwnQBlkXlPzSoO3i3S1hF3Q4k8v/Jq9HiRlkwozSYG8tV4pX08ZjjwYdMELvdbr25I+lv4BRN7bRsa0Viz42ONCIZ0nOh98V72kAF6WF2MIrpeFdsWNktvLfCLo/nLmSrQHxuWs+qjCXxim6yWedSO380+2GBYLqJnD4OuvNeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=p/vnKPTa; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 83E37600A2;
	Fri, 12 Apr 2024 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712917535;
	bh=jTmsjeOHZ301XTyRNyKPCHgoOUQGTv0qyrMDlzlNzuA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=p/vnKPTaneiS5E+gwOfvJspIFeBLgCjcr0ScVD/pvORMUguZzdyA4aFQBq2qBYsvc
	 8M+VezCjM2I46cLugoXG/5udxKhcIfyNKbMwF6UAUg1t8uTorS1GNRSxZdTMTeKyA7
	 4hBt8uOsgzc9Y3f3NM2UjbG8TPH+3yJ3AkHK7M+kyo4JdwZ+WX9tShEAfHh/GwBFPI
	 8H3UvBRNgVlFaw+Ea6uSElC7im0gltt8mPtQgMRlr0j34uA7zFgFoVDg9TywpewkJd
	 XETvw3Vymi2YU3IuwMnfmN97lS3fmHNDLlM4V9zPKKAVrCi/0P8C/SBEzA3aJX8xyh
	 migEHFHEtBBtg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id EB6E2200B1B;
	Fri, 12 Apr 2024 10:25:30 +0000 (UTC)
Message-ID: <235918fc-9b9b-4efa-8258-69bd5c7d40d4@fiberby.net>
Date: Fri, 12 Apr 2024 10:25:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
To: Suman Ghosh <sumang@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>
References: <20240410134303.21560-1-ast@fiberby.net>
 <SJ0PR18MB5216D2276BA11D5C5E31D6A6DB042@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <27ac48c0-b19c-4104-8ec9-08232e3f42f6@fiberby.net>
Content-Language: en-US
In-Reply-To: <27ac48c0-b19c-4104-8ec9-08232e3f42f6@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

On 4/12/24 9:01 AM, Asbjørn Sloth Tønnesen wrote:
> There are therefore 3 possible cases:
> 
> - `tc flower ...` (no ip_flags frag or nofrag)
>     (match.key->flags & FLOW_DIS_FIRST_FRAG)  is false
>     (match.mask->flags & FLOW_DIS_FIRST_FRAG) is false
> 
> - `tc flower ... ip_flags nofrag`
>     (match.key->flags & FLOW_DIS_FIRST_FRAG)  is false
>     (match.mask->flags & FLOW_DIS_FIRST_FRAG) is true
> 
> - `tc flower ... ip_flags frag`
>     (match.key->flags & FLOW_DIS_FIRST_FRAG)  is true
>     (match.mask->flags & FLOW_DIS_FIRST_FRAG) is true

I was a bit a hurry, to get the reply in before a meeting,
so: s/FLOW_DIS_FIRST_FRAG/FLOW_DIS_IS_FRAGMENT/g

There are therefore 3 possible cases:

- `tc flower ...` (no ip_flags frag or nofrag)
    (match.key->flags & FLOW_DIS_IS_FRAGMENT)  is false
    (match.mask->flags & FLOW_DIS_IS_FRAGMENT) is false

- `tc flower ... ip_flags nofrag`
    (match.key->flags & FLOW_DIS_IS_FRAGMENT)  is false
    (match.mask->flags & FLOW_DIS_IS_FRAGMENT) is true

- `tc flower ... ip_flags frag`
    (match.key->flags & FLOW_DIS_IS_FRAGMENT)  is true
    (match.mask->flags & FLOW_DIS_IS_FRAGMENT) is true

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

