Return-Path: <linux-kernel+bounces-142560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07958A2D29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AD21F22DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9B5466C;
	Fri, 12 Apr 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="eQ5UPlU0"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3C3D3B1;
	Fri, 12 Apr 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920758; cv=none; b=jgov2BuN8ZPP4Kj4oM3x7xDk7TBlWErb2dX4ABCnvOSWxxmzgZZspCo7CB4xRTGGqD7J61klwiKBScrRWMmOdh86AmdZd9cDl+1uqmGZEk6zUKq5DjbQr6zZ5XKdgONJFBJYSZULoJnnfOCR0auUoivFXtSZYZsvHHsnKZTmGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920758; c=relaxed/simple;
	bh=8/SKetfBZBy2Kh39R7Wd6mztgC+n9WBxP1ZOYm7Roz4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vGbEwEumwi0kASCvL5FWm0z85i/48I5YMo9EFudHYO1YU5k/3Yb/R0Ycj0iIPB4uttb7j8RHpae81gakpmO/FBQSfa8kin523Uy4u9AepJNdhOcY+fAllQDnHtuJ/HOmor5SdW2yTl0TCpSe0duHzB9ssKjs01cvQnFKXMZvypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=eQ5UPlU0; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4D8FC600A2;
	Fri, 12 Apr 2024 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712920747;
	bh=8/SKetfBZBy2Kh39R7Wd6mztgC+n9WBxP1ZOYm7Roz4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eQ5UPlU0Il6iUiB9lA5UENtj+dwdRTE/O0z9PasN3FZrzEAn2nMd7Q0SIM0W8/aQ8
	 jqcI4bdEm1dSfagbMh1rjAvhVmWpErHcW3JP7pxa2UM2I7IuC699JrkXOlynPP4lyj
	 xoUwOeL7in/J+GKlDIr+4EbgsvhmPvziZTqh9jaPy8wFcfBBC9Jqu43SCy2BTf9YJl
	 KvSecv/IU+n9XY/S/rr1rd5JJsQ362fxXcUs6bbqRphun3oGWWfSfM4xwXEM+uIDDC
	 ccRoFVz7V/tR0ChVYf0PMa/x49KA1LKZPFOj8thumXZ6DSIehuSae8dXginPsdjZv/
	 nkVgVSEZES+1Q==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id F196120106A;
	Fri, 12 Apr 2024 11:18:59 +0000 (UTC)
Message-ID: <5fb7638c-e70a-49ea-94d5-6b7f3e953255@fiberby.net>
Date: Fri, 12 Apr 2024 11:18:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Suman Ghosh <sumang@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240410134303.21560-1-ast@fiberby.net>
 <SJ0PR18MB5216D2276BA11D5C5E31D6A6DB042@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <27ac48c0-b19c-4104-8ec9-08232e3f42f6@fiberby.net>
 <235918fc-9b9b-4efa-8258-69bd5c7d40d4@fiberby.net>
Content-Language: en-US
In-Reply-To: <235918fc-9b9b-4efa-8258-69bd5c7d40d4@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi maintainers,

On 4/12/24 10:25 AM, Asbjørn Sloth Tønnesen wrote:
> On 4/12/24 9:01 AM, Asbjørn Sloth Tønnesen wrote:
> I was a bit in a hurry, to get the reply in before a meeting,
> so: s/FLOW_DIS_FIRST_FRAG/FLOW_DIS_IS_FRAGMENT/g

It was just a fix for my reply to Suman, so I am a bit confused
why the patch itself got marked as "Changes Requested" in patchwork [1].

I can spin a v2, but the only change would currently be Jacob Keller's Reviewed-by.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20240410134303.21560-1-ast@fiberby.net/

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

