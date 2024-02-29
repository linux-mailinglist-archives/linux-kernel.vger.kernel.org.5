Return-Path: <linux-kernel+bounces-85999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4B86BE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417AFB21C20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2462E413;
	Thu, 29 Feb 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ELJO8Bj9"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253F17554
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170589; cv=none; b=D5Q/WdHZ+92kyKAPJWC4FWQPZs36auHBj164gHP6B9wCxqrrQefXvKiEKoR0kUIS/t49mjF2EX/7riEB/QZFFx6DAh+abZOfSPmZ20YisfHBNF8gF+3QPh2nG4tVhD2vpSknAjP3tqNbwkvpe7g8yYxD6LuJbh/mzUXHLx+0xys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170589; c=relaxed/simple;
	bh=+q2AytV+UscXohFfoUnQzX7SS5YtqNU5pYoLOmw3iMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4MyBFZsWc/YdCylCGkzlc10vu/9/l4+g6ZYTivoXFMqi00PSapZFx6lxob6eIXlSlx3togLYhZA2Ua/sFYwKeJXnWquLXXBIQmNQWRunWmea4zCQ4V5DSPAkDBS7RkzF9zQNtYpUR50hCEK2r7st4zf/2wPQevyZfa69FiY0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ELJO8Bj9; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id fSS6ru3fntf2QfVLXrZnS5; Thu, 29 Feb 2024 01:36:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fVLWrRBaHpZ2hfVLWruoIh; Thu, 29 Feb 2024 01:36:26 +0000
X-Authority-Analysis: v=2.4 cv=EZvOQumC c=1 sm=1 tr=0 ts=65dfdf9a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10
 a=kwRZLr0jWMAg0_Wj33cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iICL8pgfW/eValc0KcsgShjcYjIIkOjZx3q+9YTL2YU=; b=ELJO8Bj9iMneFv7JC7NmH7UfR+
	g3TzcaAOp/fsvnRTc0nv6FPuxXS1rmofZjAgM9xgiqmDJbxCRVeT7z4+baskZePZ5zAGQtgXwgHQu
	JpUd4pr/VhZ+kJ7GI3K6iYAyeoPdAtuevqTXNuCNgUcY77pw2nZlDUlNd5N4gjcNQwEsDEqG5XKGQ
	v+lCm6CmYcGG1ilpML1wGXvZYFSTc3fZhNlLZS+DTF2vbrRFYwR9/fBstubGpRgqQkbXWlwdLFVCF
	EkuimUCvI7CTu+JWTBXZU5tyNGxXGwZFlqF6/BNo3duYtIOpN/De+o3hBnbkGy4+XX6pGfM6koybY
	nKqEsKDA==;
Received: from [201.172.172.225] (port=34076 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rfVLV-002v75-09;
	Wed, 28 Feb 2024 19:36:25 -0600
Message-ID: <126f4cb7-7164-43d2-bf0e-1192d1438338@embeddedor.com>
Date: Wed, 28 Feb 2024 19:36:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook> <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
 <653bbfe8-1b35-4f5e-b89d-9e374c64e46b@embeddedor.com>
 <20240228165730.3171d76c@kernel.org>
 <49f55b02-ce21-40ac-a4cc-02894cd5eb8f@embeddedor.com>
 <20240228171509.4eeb5519@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240228171509.4eeb5519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rfVLV-002v75-09
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:34076
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE3kDWldOfuUSzFT8eDwHtJ9EpS/4JTEXOy2pbp9KYZQs82QUVrn6q3TTW0osT2IJX+ILcOxiUUUVa9F9D+l1nhsFgM7F6OjgbR3iZhY2wiVbDRDqFdi
 qBThToDWCghe6b8YJ4oiLnQOXSTTIgfqKB3rliEsBZfxn6Bf4zxbpcTf9IyeI/tixx68u9nBYeOrTdAFUwyI7QBQQ0ECItRPvHMqbMyGIktKWNM5Uhig0qt9



On 2/28/24 19:15, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 19:03:12 -0600 Gustavo A. R. Silva wrote:
>> On 2/28/24 18:57, Jakub Kicinski wrote:
>>> On Wed, 28 Feb 2024 18:49:25 -0600 Gustavo A. R. Silva wrote:
>>>> struct net_device {
>>>> 	struct_group_tagged(net_device_hdr, hdr,
>>>> 		...
>>>> 		u32			priv_size;
>>>> 	);
>>>> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
>>>> }
>>>
>>> No, no, that's not happening.
>>
>> Thanks, one less flex-struct to change. :)
> 
> I like the flex struct.
> I don't like struct group around a 360LoC declaration just to avoid
> having to fix up a handful of users.

That's what I mean. If we can prevent the flex array ending up in the
middle of a struct by any means, then I wouldn't have to change the
flex struct.

--
Gustavo

