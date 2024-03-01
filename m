Return-Path: <linux-kernel+bounces-88191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64186DE5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EDD1F281C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3416A8B1;
	Fri,  1 Mar 2024 09:35:51 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F816A354;
	Fri,  1 Mar 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285751; cv=none; b=BuS8B0cG0d77O0EOBDtcaNqFoaZ1hdjHnVEObLHEFnuQESxVS72/e8QihArcDQ92ILADlIj5qxdKn1Rxdzi0VCy+YA1f6wVwydqx7xhlIXQxg/IVDyvHcI9sFCEWz9URiaNCFKxfdJNVdJWTyKbWqGoTVdAqOHX+1Fgn7W+tUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285751; c=relaxed/simple;
	bh=8bNhQxbcCbIomd4dt6eew7xOLqapH0ekcPWsALbORUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCyJesxh9n05Ov6rKtkRTa9Yq8T6jGR/jAOfYOcKiIXDlHF2BIx42W9ORpqDtSynPCspYqlDVfyhFEj/hnI9MxkM71GfBpbEd1ovNpWXpLpioe9jdOm2srgQXFF0HVWUkAS0wqBeTRJvtjLEoUux3lGjYTku21Z00EOcFEPKU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412bfacd146so8595005e9.0;
        Fri, 01 Mar 2024 01:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285748; x=1709890548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gjhUQtfjcW3P/Ik/3eAaSYAXs9I9SaEMNpWMrhksnk=;
        b=V3wlWE9A9SjUqw0U9Dy/QqJm1wzspZv+ebCUApw2ayNwUmvlP/YEkQbfcHXdngSMai
         nnxfkOvkghXCW5jdq59Yd5Urv7wCMVbdsOt2SLaya8NDVdjNXVSa7xV7Pzfo/STVV4vI
         ONgweYrd0ggtsCe9JOkX8XWDEHmn11tfhlgUIhTBzfHeuNlRx/KdzL1GNpTFVIO4k/T0
         9T5yCCNlSEPbwNZqZziyHclu/CgLB6I1rNEj5KoLJAa8rRZ/z892KM2ZvhHWcv9al+X9
         MoEblBnW2fgezQ88tIBRq8z7gc0zckhDJUqLi5LuuDXi2pj6ah4FyLveOULL4Y2sK3UG
         fklg==
X-Forwarded-Encrypted: i=1; AJvYcCWxPjUkIo49xcvq2/2gYPzMFmG8NE1s5ReW+7EVc/IRDicjYaVxnHKFjqu9RvgA7DPR23SAkdd8NHVD+VrbuIDmY9BkJ8DXFJOaXj+DaKC88oYw/wsM+vrgpH47PKP1WKbwoLN3BmL6gwj/h+QYGy2jZm0TB0MXUODWibJdJUAo
X-Gm-Message-State: AOJu0Yw2ejJZf3VYwmNTGlCXInLsX8aAuQTIyFoODWKXn3X9VA/osxM7
	a4AjzlScfiXUnSX6xtCqdpHaRPqqzqG3NA8LQS83YnBV8/eGUQvGydQCtXIn
X-Google-Smtp-Source: AGHT+IHJDI/TzDartf8NY/ZhFuVhtyIPZkGhPS1hZ/O9GtvpENuTyWbmh0D26/bAjBhR+zHpTBrJoA==
X-Received: by 2002:a05:600c:154f:b0:412:bca4:6a00 with SMTP id f15-20020a05600c154f00b00412bca46a00mr1546337wmg.18.1709285747492;
        Fri, 01 Mar 2024 01:35:47 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c024100b0040fddaf9ff4sm7830123wmj.40.2024.03.01.01.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:35:47 -0800 (PST)
Date: Fri, 1 Mar 2024 01:35:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: netconsole: Add continuation line
 prefix to userdata messages
Message-ID: <ZeGhcN/C7h1KWcTO@gmail.com>
References: <20240229183602.321747-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229183602.321747-1-thepacketgeek@gmail.com>

On Thu, Feb 29, 2024 at 10:36:01AM -0800, Matthew Wood wrote:
> Add a space (' ') prefix to every userdata line to match docs for
> dev-kmsg. To account for this extra character in each userdata entry,
> reduce userdata entry names (directory name) from 54 characters to 53.
> 
> According to the dev-kmsg docs, a space is used for subsequent lines to
> mark them as continuation lines.
> 
> > A line starting with ' ', is a continuation line, adding
> > key/value pairs to the log message, which provide the machine
> > readable context of the message, for reliable processing in
> > userspace.
> 
> Testing for this patch::
> 
>  cd /sys/kernel/config/netconsole && mkdir cmdline0
>  cd cmdline0
>  mkdir userdata/test && echo "hello" > userdata/test/value
>  mkdir userdata/test2 && echo "hello2" > userdata/test2/value
>  echo "message" > /dev/kmsg
> 
> Outputs::
> 
>  6.8.0-rc5-virtme,12,493,231373579,-;message
>   test=hello
>   test2=hello2
> 
> And I confirmed all testing works as expected from the original patchset
> 
> v1 -> v2:
> - Calculate 53 byte user data name from: entry length - formatting chars - value length
> - Update docs to reflect 53 byte limit for user data name (director)

I think the changelog needs to come after the --- below, but I will
defer that to the maintainers.

> Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>  Documentation/networking/netconsole.rst | 8 ++++----
>  drivers/net/netconsole.c                | 8 +++++---
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index b28c525e5d1e..d55c2a22ec7a 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -180,7 +180,7 @@ Custom user data can be appended to the end of messages with netconsole
>  dynamic configuration enabled. User data entries can be modified without
>  changing the "enabled" attribute of a target.
>  
> -Directories (keys) under `userdata` are limited to 54 character length, and
> +Directories (keys) under `userdata` are limited to 53 character length, and
>  data in `userdata/<key>/value` are limited to 200 bytes::
>  
>   cd /sys/kernel/config/netconsole && mkdir cmdline0
> @@ -197,8 +197,8 @@ Messages will now include this additional user data::
>  Sends::
>  
>   12,607,22085407756,-;This is a message
> - foo=bar
> - qux=baz
> +  foo=bar
> +  qux=baz
>  
>  Preview the userdata that will be appended with::
>  
> @@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
>  
>   echo "This is a message" > /dev/kmsg
>   12,607,22085407756,-;This is a message
> - foo=bar
> +  foo=bar
>  
>  Delete `userdata` entries with `rmdir`::
>  
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 0de108a1c0c8..46e447ea41b8 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -43,9 +43,11 @@ MODULE_DESCRIPTION("Console driver for network interfaces");
>  MODULE_LICENSE("GPL");
>  
>  #define MAX_PARAM_LENGTH	256
> -#define MAX_USERDATA_NAME_LENGTH	54
> -#define MAX_USERDATA_VALUE_LENGTH	200
>  #define MAX_USERDATA_ENTRY_LENGTH	256
> +#define MAX_USERDATA_VALUE_LENGTH	200
> +#define MAX_USERDATA_NAME_LENGTH	MAX_USERDATA_ENTRY_LENGTH - \
> +					MAX_USERDATA_VALUE_LENGTH - \
> +					3 /* ' ' '=' '\n' characters */

This is not beautiful even for my standards. I think something like the
code below makes more sense, even if checkpatch is not happy.

/* The number three below comes from ' ' + '=' + '\n' characters */
#define MAX_USERDATA_NAME_LENGTH 	MAX_USERDATA_ENTRY_LENGTH - MAX_USERDATA_VALUE_LENGTH - 3 

