Return-Path: <linux-kernel+bounces-85443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9E86B609
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99411C2141F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162715A498;
	Wed, 28 Feb 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhUeOiJx"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950C3FBA2;
	Wed, 28 Feb 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141546; cv=none; b=ICVug/ajFT+KMryE0Y4T+5P+NMn3LgLIW26fnLUiTrUOvGeZexBduGyE4odeb/gL08eyANXjb9n1+1hK4LRBn1cLBopxdNr57CY8BWF6BdRKClEP7aXWSNUuYqvuIFLtAycAG+V6HOUHCyu7u7C2lnqpekTnCKjHPid9iuxwvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141546; c=relaxed/simple;
	bh=Di1LPZZculjhkYlyZeqG4jRqHH2/9Y04HKYM7VRwqTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0bAJg30UJRu7tlPtWOjg4eRNCFfr4b8hd+CtaQK5GSX0o0G1ZkHcJDRQRFipg+E84E060CFJ1KK/hfmQTkAyanGZw4zuEQgW9fh7N9qgRGNxE32LzMC1+vlITHwriWod0BrIHyz0rdSE0QY02H0cN1L4OZkbspZffJDexNlC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhUeOiJx; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-787bc61cb69so380074585a.1;
        Wed, 28 Feb 2024 09:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141544; x=1709746344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2p3N5b0ScPGv0PAJy8f2OEufbcAe7rsvEvf1A8xZmn4=;
        b=ZhUeOiJxfPOHziYjmP9ZXxRrKartJIJ7eoE4toAE1Yg61JkfJXhv7qOTU6PqCylDvo
         wGOMEPiQWbAW3ZVy1PKJ9s8ZBlzBougoQSUZ0ucnEPZVOqYOwL2argO1WGv7DYWQWK3x
         FIc4EYat+FafCbnxhKQY5xbHiBMnBRnKn7GtZnp38WD3ho7E/gJgXgr5bJCyynafLzMc
         bpoCThSnPNMmjM56Wrg3ifdRmGodunKEKkbkdRiAhAJj2d3WAgPInY+bZfDfxC+6+GJK
         3Bwc92BhmoJ7ZSU7zShKna35ngGH5y6SDVT8kbwosWf48B2jBSUMhEIKZ0DDD0uWCpl+
         SL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141544; x=1709746344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2p3N5b0ScPGv0PAJy8f2OEufbcAe7rsvEvf1A8xZmn4=;
        b=fHw9rDRwcaOdN7QD//DkOAufmJNE2H+5LvwgAWEWGCUUE8LTBHcOoUJLthE5E+luwz
         4dX+OHNxIPyBYoH+Kd+1sChMp2Oq8+4cdoOjGVtgB4QvOSDPZ0NOVL9/T6/ciwwxmfeC
         KGHo8gVADdmjHmwGAqkbMKfbZig3cBlGTO6vMT8BMC2miUe1+H15mQigRiWjxPnTYoVI
         uUB0g5U/uhcBVRnFLTd5iYmRAQcwBZHfOWpb7pkGB00VWVn4JqAAghcZiS16QC67uLj2
         3+Q+KydOIYRuk1xmgRgU2FST6r13unXeNSINF+9xuiGXvYC5IibmfoPZ4GpO24NJ+4FX
         vohA==
X-Forwarded-Encrypted: i=1; AJvYcCVjy7hf6SVmg60TFMhqtwhJwCyqUpfg/fl8ylyCaPVtjM6acUwe45OLvf2nxUvfMDgUjVdHezB+ELbRxZ1UGrOUC0rrt4TEl0MmFgku1NxRR/l7x5x4LqBZsPYpCwXuC6DQlbOKVJgR
X-Gm-Message-State: AOJu0Yysod5FZyAfn+1esMEG0IGa60JNoma0tex5NOZ5vDnl9YqXLTYQ
	/704SbuBadBst7FW/aQDjVr1rOPmhfFUFIDXlnvVemdb8e6U0J3I
X-Google-Smtp-Source: AGHT+IHOCJEsVLG0SH4MCO5uUhMA1VmZkdxhrLcPJxyi7AOAttj/k9DjX1WeAlN4qnHHs6nnBM7sig==
X-Received: by 2002:a05:620a:10ab:b0:787:a4aa:4e1e with SMTP id h11-20020a05620a10ab00b00787a4aa4e1emr5222435qkk.55.1709141544218;
        Wed, 28 Feb 2024 09:32:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id xy12-20020a05620a5dcc00b00787c142ec1fsm4763499qkn.110.2024.02.28.09.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 09:32:23 -0800 (PST)
Message-ID: <77497701-3bd2-4f5f-9404-b32d9e91683b@gmail.com>
Date: Wed, 28 Feb 2024 09:32:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: netconsole: Add continuation line prefix to
 userdata messages
Content-Language: en-US
To: Matthew Wood <thepacketgeek@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228172948.221910-1-thepacketgeek@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240228172948.221910-1-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/24 09:29, Matthew Wood wrote:
> Add a space (' ') prefix to every userdata line to match docs for
> dev-kmsg. To account for this extra character in each userdata entry,
> reduce userdata entry names (directory name) from 54 characters to 53.
> 
> According to the dev-kmsg docs, a space is used for subsequent lines to
> mark them as continuation lines.
> 
>> A line starting with ' ', is a continuation line, adding
>> key/value pairs to the log message, which provide the machine
>> readable context of the message, for reliable processing in
>> userspace.
> 
> Testing for this patch::
> 
>   cd /sys/kernel/config/netconsole && mkdir cmdline0
>   cd cmdline0
>   mkdir userdata/test && echo "hello" > userdata/test/value
>   mkdir userdata/test2 && echo "hello2" > userdata/test2/value
>   echo "message" > /dev/kmsg
> 
> Outputs::
> 
>   6.8.0-rc5-virtme,12,493,231373579,-;message
>    test=hello
>    test2=hello2
> 
> And I confirmed all testing works as expected from the original patchset
> 
> Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>   Documentation/networking/netconsole.rst | 6 +++---
>   drivers/net/netconsole.c                | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index b28c525e5d1e..c2dec12f6060 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -197,8 +197,8 @@ Messages will now include this additional user data::
>   Sends::
>   
>    12,607,22085407756,-;This is a message
> - foo=bar
> - qux=baz
> +  foo=bar
> +  qux=baz
>   
>   Preview the userdata that will be appended with::
>   
> @@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
>   
>    echo "This is a message" > /dev/kmsg
>    12,607,22085407756,-;This is a message
> - foo=bar
> +  foo=bar
>   
>   Delete `userdata` entries with `rmdir`::
>   
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 0de108a1c0c8..ffd3e19406b5 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -43,7 +43,7 @@ MODULE_DESCRIPTION("Console driver for network interfaces");
>   MODULE_LICENSE("GPL");
>   
>   #define MAX_PARAM_LENGTH	256
> -#define MAX_USERDATA_NAME_LENGTH	54
> +#define MAX_USERDATA_NAME_LENGTH	53 /* 256 - 200 - 3 (for ' =\n' chars)*/

Could we take this opportunity to define MAX_USERDATA_NAME_LENGTH based 
upon MAX_PARAM_LENGTH - MAX_USERDATA_VALUE_LENGTH - 3 then?

>   #define MAX_USERDATA_VALUE_LENGTH	200
>   #define MAX_USERDATA_ENTRY_LENGTH	256
>   #define MAX_USERDATA_ITEMS		16
> @@ -671,7 +671,7 @@ static void update_userdata(struct netconsole_target *nt)
>   		 * checked to not exceed MAX items with child_count above
>   		 */
>   		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
> -					  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
> +					  MAX_USERDATA_ENTRY_LENGTH, " %s=%s\n",
>   					  item->ci_name, udm_item->value);
>   	}
>   	nt->userdata_length = strnlen(nt->userdata_complete,

-- 
Florian


