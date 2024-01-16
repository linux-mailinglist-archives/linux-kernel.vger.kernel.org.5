Return-Path: <linux-kernel+bounces-27389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3874282EF28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BED4B22E78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF411BC35;
	Tue, 16 Jan 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4E0x2/z"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3411BC23
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so11466806e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705409203; x=1706014003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMMK603BNlIEEZJUYkcunPxxylAFdPV/GfQaa6sDygU=;
        b=I4E0x2/zXOh8KtgdMO3s1SfN27ptXFxWboyVMMIVHI5Nv1HOLVLOXjhaKWQDyGY573
         lhb+uuJwEQDPLSWkthHxLWDd0OI6ih0xCaa+/z3XyzJpQ056gh5aCpW2/PiwelJ0C0Of
         8tYDC4fiU7gCZSOV3nkN0mn3Hy1MKx7qpqNYaYAuQzLlYHYZ3sYviFh4SnL4NGrs/TYX
         JE/pIKIwkHCSyj4KCi2bzNFnJB0v5uUR+jDmutDSvLz85VBsHsLEVH4BUSxNp6CJlNgT
         UU7zKpgMzkuuSRF1l0PThdIYgP4PjTygI8f5EhBmXzuaeHpjftQsTRAJpJieWqHE2EN8
         2bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705409203; x=1706014003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMMK603BNlIEEZJUYkcunPxxylAFdPV/GfQaa6sDygU=;
        b=GR5roE/FSx/i1vRjnhZG8hUDol3s/w79Y4f+4bv9B3tcp+MgA+cru9Q8Ru/WnSBR2D
         6yAvLYdRKiV7+122rztMG5geFNYrJfsLxhWLHKOpfwznO0UfcMkCVrCi8YeRIC4zDMmI
         le15uvzEhmnT7FOIWxqYyXXJQdK2aDwiSMjan2NM0r83Efn6qN11q23IU7+j8eali1Ky
         3e0NkP+uf94gLNAj5iA4ntdpjNmUDqqn6D4FzXLjbQAd5BpJy+aXslvVcqTVyKuDyV6T
         XFoW39vtYH5A+A9I/z/Hm0OzrZVLO5QcoG1A1zdwL4DjlSk0yXBAMa4oWa4q473b4t58
         eeSg==
X-Gm-Message-State: AOJu0Yy1mOFbNineiX+CDGoCMnd48/ypsAFtvxIvBJA0fjXWPhq7wHZY
	B+3XywMBiIle1fgnGpEfLP8=
X-Google-Smtp-Source: AGHT+IEuMbGxlweNrxsaG17em4c0wJiTTuH99nyDWYG+V5oJe8aEAZeHRG1dl7cm5aVXf7DI4jIz+A==
X-Received: by 2002:a05:6512:3f0a:b0:50e:a6f8:aac0 with SMTP id y10-20020a0565123f0a00b0050ea6f8aac0mr4409869lfa.20.1705409202807;
        Tue, 16 Jan 2024 04:46:42 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::3? (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id dw13-20020a0565122c8d00b0050e76d9498csm1751661lfb.51.2024.01.16.04.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:46:42 -0800 (PST)
Message-ID: <e3e16af2-7f8d-4776-9726-f6282128a766@gmail.com>
Date: Tue, 16 Jan 2024 14:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] regulator: event: Add netlink command for event mask
To: Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20240116103131.413205-1-naresh.solanki@9elements.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240116103131.413205-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Naresh,

Thanks for working on this! :)

On 1/16/24 12:31, Naresh Solanki wrote:
> Add netlink command to enable perticular event(s) broadcasting instead
> of all regulator events.

I think this mechanism for limiting events being forwarded to the 
listener is worthy. My original idea was to utilize the netlink 
multicast groups for this so that the regulator core would register 
multiple multicast groups for this family. User would then listen only 
the groups he is interested, and multiplexing the messages would be done 
by netlink/socket code.

Problem(?) of the approach you propose here is that the event filtering 
is global for all users. If multicast groups were used, this filtering 
would be done per listener socket basis. I'm not sure if that would be 
needed though, but somehow I feel it would be more usable for different 
user-land appliactions (cost being the increased complexity though).

Eg, I am thinking users could enable receiving multicasts for events 
they like using:

setsockopt(..., SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, ..., ...)

Do you think allowing setting the 'filtering' this way per socket would 
work or be beneficial?

> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> 
> ...
> Changes in v2:
> - Update attribute to REG_GENL_ATTR_SET_EVENT_MASK
> ---
>   drivers/regulator/event.c          | 28 ++++++++++++++++++++++++++++
>   include/uapi/regulator/regulator.h |  1 +
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/regulator/event.c b/drivers/regulator/event.c
> index ea3bd49544e8..181d16f54a21 100644
> --- a/drivers/regulator/event.c
> +++ b/drivers/regulator/event.c
> @@ -14,17 +14,41 @@
>   
>   static atomic_t reg_event_seqnum = ATOMIC_INIT(0);
>   
> +static u64 event_mask;
> +
>   static const struct genl_multicast_group reg_event_mcgrps[] = {
>   	{ .name = REG_GENL_MCAST_GROUP_NAME, },
>   };
>   
> +static int reg_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	if (info->attrs[REG_GENL_ATTR_SET_EVENT_MASK]) {
> +		event_mask = nla_get_u64(info->attrs[REG_GENL_ATTR_SET_EVENT_MASK]);

If we go with just a global event_mask (not per listener) event 
filtering, then we might need protection/barrier for this write of a 
64bit value(?)


> +		pr_info("event_mask -> %llx", event_mask);

I would drop this print, or by very least, make it dbg.

> +		return 0;
> +	}
> +	pr_warn("Unknown attribute.");

I would make this dbg as well.

> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct genl_small_ops reg_genl_ops[] = {
> +	{
> +		.cmd = REG_GENL_CMD_EVENT,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = reg_genl_cmd_doit,
> +	}
> +};
> +
>   static struct genl_family reg_event_genl_family __ro_after_init = {
>   	.module = THIS_MODULE,
>   	.name = REG_GENL_FAMILY_NAME,
>   	.version = REG_GENL_VERSION,
>   	.maxattr = REG_GENL_ATTR_MAX,
> +	.small_ops	= reg_genl_ops,
> +	.n_small_ops	= ARRAY_SIZE(reg_genl_ops),
>   	.mcgrps = reg_event_mcgrps,
>   	.n_mcgrps = ARRAY_SIZE(reg_event_mcgrps),
> +	.resv_start_op = __REG_GENL_CMD_MAX,
>   };
>   
>   int reg_generate_netlink_event(const char *reg_name, u64 event)
> @@ -35,6 +59,9 @@ int reg_generate_netlink_event(const char *reg_name, u64 event)
>   	void *msg_header;
>   	int size;
>   

Barrier/locking here too?

> +	if (!(event_mask & event))
> +		return 0; > +
>   	/* allocate memory */
>   	size = nla_total_size(sizeof(struct reg_genl_event)) +
>   	    nla_total_size(0);
> @@ -73,6 +100,7 @@ int reg_generate_netlink_event(const char *reg_name, u64 event)
>   
>   static int __init reg_event_genetlink_init(void)
>   {
> +	event_mask = 0;
>   	return genl_register_family(&reg_event_genl_family);
>   }
>   
> diff --git a/include/uapi/regulator/regulator.h b/include/uapi/regulator/regulator.h
> index 71bf71a22e7f..2a0af512b61c 100644
> --- a/include/uapi/regulator/regulator.h
> +++ b/include/uapi/regulator/regulator.h
> @@ -69,6 +69,7 @@ struct reg_genl_event {
>   enum {
>   	REG_GENL_ATTR_UNSPEC,
>   	REG_GENL_ATTR_EVENT,	/* reg event info needed by user space */
> +	REG_GENL_ATTR_SET_EVENT_MASK,	/* reg event mask */
>   	__REG_GENL_ATTR_MAX,
>   };
>   
> 
> base-commit: 94cc3087aac4103c33c6da84c092301afd783200

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


