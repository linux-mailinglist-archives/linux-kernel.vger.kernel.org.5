Return-Path: <linux-kernel+bounces-38094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C883BAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109B11F254AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740E134AF;
	Thu, 25 Jan 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewpgjkzm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936112E72;
	Thu, 25 Jan 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168452; cv=none; b=VEJQHKGSyScovlwGLRUSUyXQWI3F17hZ/zl1rhYW1vdnE3WhPM2mooLSebY09jENMScBX8q3cdl5r2gui3PpVDqeIa3bjblgzPdJbDASSfr6rUNBSDibsvgUip2ituuv4GuBeSJxXvR2WV5zYTxO0Htg9mPFRtItauEBZjGFHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168452; c=relaxed/simple;
	bh=yXQelfN362+ukD3pOJR6ut5MNMiIK+ENANaAWo8+P5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jt5AJRLSqp9XbpmwBj7EPbQo4H4pyu9xjJfN047+j8BI/w0fWrokPrN53iHA/QDHuH3QMCXP1dbXGRO3xearcxhABuGi3fj8nUSGjPg5rFuIEwB2ZgJrWyamgKMd4K1lSoX4MLpvgMiPVskWU5u7d1eLOxXOmq+FTfIOpJo9Dbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewpgjkzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303E9C433C7;
	Thu, 25 Jan 2024 07:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706168452;
	bh=yXQelfN362+ukD3pOJR6ut5MNMiIK+ENANaAWo8+P5U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ewpgjkzm4hE/BjB4G0nq4r5v5jVmiDo3H32oI/06QOJ0uXu2Z4WbWmMuHR2ntf32N
	 8h7UfZ0F4/3CIac1m/ndwbwEd4NnRHDnXplR+s+GwUupsUdKdx3tl7IVnVwkwUF4P/
	 WMacUVqCkbr6Sh1kD0Jq22tIzuffUF6eOblmeqndMUsSn+CJnkqhffZqQG7LZTuemy
	 RIl9C+P3dJqvDMPdKAl43gN6ar++ynpf+Npmqm0TVPot0+xuOlZTAXWzQm/ac5FeW8
	 iKXvvZ75yCJe9IkLRBtNV7QgQ60EFd6YXFqsMYhqBiYnYYnz7QDI9uCQuwp7W1sM55
	 mwYZ8dP/zltfg==
Message-ID: <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org>
Date: Thu, 25 Jan 2024 16:40:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
Content-Language: en-US
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Yu Zhao <yuzhao@google.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 steve.kang@unisoc.com
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 16:19, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Currently, request's ioprio are set via task's schedule priority(when no
> blkcg configured), which has high priority tasks possess the privilege on
> both of CPU and IO scheduling.
> This commit works as a hint of original policy by promoting the request ioprio
> based on the page/folio's activity. The original idea comes from LRU_GEN
> which provides more precised folio activity than before. This commit try
> to adjust the request's ioprio when certain part of its folios are hot,
> which indicate that this request carry important contents and need be
> scheduled ealier.
> 
> This commit is verified on a v6.6 6GB RAM android14 system via 4 test cases
> by changing the bio_add_page/folio API in ext4 and f2fs.

And as mentioned already by Chrisoph and Jens, why don't you just simply set
bio->bi_ioprio to the value you want before calling submit_bio() in these file
systems ? Why all the hacking of the priority code for that ? That is not
justified at all.

Furthermore, the activity things reduces the ioprio hint bits to the bare
minimum 3 bits necessary for command duration limits. Not great. But if you
simply set the prio class based on your activity algorithm, you do not need to
change all that.

Note: Your patch is full of whitespace changes.

-- 
Damien Le Moal
Western Digital Research


