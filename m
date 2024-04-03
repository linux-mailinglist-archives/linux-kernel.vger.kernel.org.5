Return-Path: <linux-kernel+bounces-130504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68B897906
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33091F25701
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDED1553B8;
	Wed,  3 Apr 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEp3oq3a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71F136E1B;
	Wed,  3 Apr 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172709; cv=none; b=WbaAtFvEBWguZsb/1N0u2pq0gF3eAAqnaKD6XacvSiJ8z37IeIVxMW9YOByoHG20/fyty6qLsj3o3kOlxJ4gwQfvcvwZNGbDGX/6FHu+s32bFxF3LUXhqsxfk4otElyL1Bha14infF/UJX75bj8VKegurU5DAF1b94wEeiDabmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172709; c=relaxed/simple;
	bh=49hnf8eNd26JAJN5gZr216K6nvdSTCxEep8HR+2CMrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nx5rhtbvae+UaAepfqFIPySucdEVNjx/b/cFrqzIb5BLuRNQbIz/k5zJ2FN1/RLyQv5EDL4Iha968OtlXokgCGO2PrNMEvPJ5eBtsz+4/YXSUi/8Gh3RmxHqrT18RFmti7YUdWkBVNZ9DjAk0ttgEnP69La+idLfw5Iq0VWuSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEp3oq3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADC2C433F1;
	Wed,  3 Apr 2024 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712172708;
	bh=49hnf8eNd26JAJN5gZr216K6nvdSTCxEep8HR+2CMrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qEp3oq3a7S2UpwjWu3xh9U7cO7WKeyoQUuqJ5j4JMMeDS4R4+OpuA/wJKcPER6x5c
	 SGIe75/PLLWU/9q1K2gvx382Lm4GbsIZdZzJPbo/UX/FhuchNDNRwvahtyuVNXJyZX
	 73d9O+6HuZ9tM63O1P0EW26mPfKQD/9rdN0sCRguPqMA/PEHDYvRndNDXTSXpwp9CX
	 cAt02IfR4bssUEdtVbO23p/RL01G2aH4HhLpY7kRT/Z49AQfqCM05ZF/Bf2aZDVrLl
	 JvSmk5cvO1kZRPUBGr5Oo31zvhnW8ViQNzyfiEc4OWizhwhjZrMQCvpE7rLiILhcSg
	 FQwnJ2vqo5M4g==
Message-ID: <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
Date: Wed, 3 Apr 2024 13:31:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240403190012.GV11187@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/3/24 1:00 PM, Leon Romanovsky wrote:
> On Wed, Apr 03, 2024 at 01:26:50PM +0100, Edward Cree wrote:
>> On 02/04/2024 19:48, Leon Romanovsky wrote:
>>> On Tue, Apr 02, 2024 at 05:32:44PM +0100, Edward Cree wrote:
>>>>  you're getting maintainer pushback.
>>>
>>> May I suggest you to take a short break, collect names of people who
>>> participated in this discussion and check in git history/MAINTAINERS
>>> file their contribution to the linux kernel?
>> Whether you like it or not, Kuba is a kernel maintainer.
>> And thus, semantically, a Nack from him is "maintainer pushback".
>> That remains true regardless of who else in the discussion is also
>>  a kernel maintainer.
>>
>> If you had an actual point, feel free to explain to me, without the
>>  veiled language, what was so 'inappropriate' about my posting.
> 
> Language, tone, and content of your email were inappropriate:
> 
> https://lore.kernel.org/all/0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com/
> ...certain vendors whining...
> 
> ^^^^ Language
> 
> ... possibly they thought devlink params would just get rubber-
>  stamped — and now they're finding that the kernel's quality standards
>  still apply. ...
> 
> ^^^^ Tone
> EVERYONE who participated in this discussion knows about kernel's
> quality standards.
> 
> ... Patches aren't languishing for want of reviewer resources; it's just that it
>  takes *submitter* time and effort to bring them up to the quality level
>  that's required, and occasionally the vendor has to (shock! horror!)
>  tell the world what one of their magic knobs actually *does*. ...
> 
> ^^^^ Content
> This paragraph alone shows that you completely didn't understand the
> discussion here.
> 
> Thanks

+1


