Return-Path: <linux-kernel+bounces-45771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF8843612
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7CA1F2492E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBAD3D964;
	Wed, 31 Jan 2024 05:30:02 +0000 (UTC)
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net [46.105.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFB3D550
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679001; cv=none; b=UQRkudfCXlkkAbJ9iYOrByVEr4bBbYl+Cc3kfOUCxbt7rGHZuibK1wk+lOVF8ojHS4xpBueADTuKpnxVpF/jEguP7Qs+mwi+Y2x0DvOAKxJeXQl/fPPFRiWT1oZIiwmObK7KfO0b3Bj40pnLDoMkCIrSi1o1yeCbMsykLpY9ZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679001; c=relaxed/simple;
	bh=/xxCLaYufNFbE2C9ZKm3WjJqcCufD+y6RDZet2SDfiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clj6SA9isKJzJMNpA64phdzWS3XlqPR7f7idicgLaAmGgUI1N8HQnqOi4GZKhZOYerESqYdj7KLZalhwV49jfTq2h6pOKhqzA95AEP0oTEAqcz3mwrlTq/1zGVx+vkd6b4y0d3jaW/S+KBfQGFkQ1T2Whdv7a4+3vEkGFe5Kbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; arc=none smtp.client-ip=46.105.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.176.72])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 88AA027AA0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:10:53 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-4ps8g (unknown [10.110.113.119])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C79CE1FE0B;
	Tue, 30 Jan 2024 21:10:52 +0000 (UTC)
Received: from milecki.pl ([37.59.142.95])
	by ghost-submission-6684bf9d7b-4ps8g with ESMTPSA
	id vxk6K9xluWV91gEAOrHdXw
	(envelope-from <rafal@milecki.pl>); Tue, 30 Jan 2024 21:10:52 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G001b2353eda-26b4-4e23-bfca-ffff08e380ec,
                    247E30736BCEA492ABCB1DC3D73798F611B73BDA) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:31.11.218.106
Message-ID: <3292ae5e-07e2-49df-81f7-74e1b5e8dfb3@milecki.pl>
Date: Tue, 30 Jan 2024 22:10:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmem: u-boot-env: improve error checking
To: Nick Spooner <nicholas.spooner@seagate.com>,
 "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Evan Burgess <evan.burgess@seagate.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <CH0PR20MB38183679A4F4229A419A9EB29C7D2@CH0PR20MB3818.namprd20.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <CH0PR20MB38183679A4F4229A419A9EB29C7D2@CH0PR20MB3818.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7340022971110828923
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeegkedvgfelueetledugffhuddvffejkefhheetfeevgfegleehleduueeivdeujeenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht

On 30.01.2024 20:42, Nick Spooner wrote:
> Coverity scan reported CID 1575482: error handling issues; this patch
> addresses this by adding error handling to u_boot_env_add_cells.

I'd appreciate description why do we need this change other than
addressing some Coverity report.

Should a single nvmem_add_one_cell() failure result in not registering
NVMEM device at all? Why?


> Signed-off-by: Nick Spooner <nicholas.spooner@seagate.com>
> ---
> v2:
>      Fix whitespace issues in previous version
> 
>   drivers/nvmem/u-boot-env.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index befbab156cda..c15de5f7fd99 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -95,6 +95,7 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
>   	struct device *dev = priv->dev;
>   	char *data = buf + data_offset;
>   	char *var, *value, *eq;
> +	int rval;
> 
>   	for (var = data;
>   	     var < data + data_len && *var;
> @@ -119,7 +120,9 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
>   			info.read_post_process = u_boot_env_read_post_process_ethaddr;
>   		}
> 
> -		nvmem_add_one_cell(nvmem, &info);
> +		rval = nvmem_add_one_cell(nvmem, &info);
> +		if (rval)
> +			return rval;
>   	}
> 
>   	return 0;
> --
> 2.34.1

