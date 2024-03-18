Return-Path: <linux-kernel+bounces-106786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F187F3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D2A1C215A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A55BAF1;
	Mon, 18 Mar 2024 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQbOEn/j"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419A5A7B6;
	Mon, 18 Mar 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803057; cv=none; b=l1mhmEuCJ+LtcW+hFMGoeGFWmi8/iTW0mai2OYwW115SWmbOGDdZ2mqOrEvwZabgCYYjdaHh+RnIwINayB/Ll1B6IK0xydUyP/o7iwLQN0ysj9KaTZe/uNpECnEpiTnRK+cZbM/WGAUP+m68XmIozIW6cegx+HsPYycNLj4KAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803057; c=relaxed/simple;
	bh=eGsUvslhaYw+yM+ZZ/EMxm+K11SBPq7cbdAEVqB6o88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b40mJleYhWqaxM7Y+IGwSIKWGLj2BhSFeufJwVzhxWfwERtKYS5aQhoyq/9dbO9F4NjVCBbTsIkM1JL7dmPgoOKDyl+KeRiLcXtV7oiEcG7kmCQlbXevfhMTcUc3pDXSxSegzVCjAiCnGMO7KxoeRZ68pUdyFpNR7YDAvM4iO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQbOEn/j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd10a37d68so39929835ad.2;
        Mon, 18 Mar 2024 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710803055; x=1711407855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VMG8bK9JHszRqVjcG6xG0bVfN3vKXTlzIQNbDmTiu+U=;
        b=RQbOEn/jr4dnrTQUc+mjkE0CBSGCk0oiGAz9bBZznderJXob0BPfyne5DsdkJhiT0p
         PbOO6fSn6amyma1Pcs4HgBQd0oxklOLyKaFZN3JKJJkKyZx8qIGK7IYFO4Rvh4vDOjiG
         3ihMW6RJhhM6MJfgL/8qLofJWpywfLZ6tlVpB8dOY9Q59lgtNOe6iMSd9Fb08TIBtnTg
         usw1/co9rYc3XENb353h9UWLmF2Rt/AGQKHGakGwZo5uqRiGkqPqbNcPEWog2bSJdvFq
         BKfnW5c//NL7B6NQBGCDGJxBUAG5edTD3aHXGazC6bZyXYhntG+/qfC7UxvIwUU7S/VW
         PCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803055; x=1711407855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMG8bK9JHszRqVjcG6xG0bVfN3vKXTlzIQNbDmTiu+U=;
        b=M7yps60mb/B43r7zb7QCicNBQ/AhxyMUz4Wb838znenUAxMprc9+XND2XvAr1pAhYO
         BWt+jJTqYPe1sXISew9Kjwg1VaMjD7TjVt7ta+glD5yzRvhtA+L0BfpCI/IcUnUDligw
         nLJTmoDq2K88jfPT9b/sOQGADhocmDpVzh/7PUDWrJkFB9d3WNY0TxJ+ewLK+g/aG6gP
         PuC3GJSDUuZRD9N+YG0EW5Z/FomqcQogPJZIPOx+Lta1vF00WU4Vjo6zuHzkc94JFv1S
         Mr1XAIuExqStDrmwOBJczQ1I5BWyRu+IfA1YJsMCzmKWTX+81guhbIFOVS9Rc0dJTlTU
         dK6A==
X-Forwarded-Encrypted: i=1; AJvYcCXhVPbUjPPOijibzPP4qAJGRtXWsxN8K2sG/eaUz3QoDglQFLkavKbyxsWynIx9ffYbVDPd6zpwDrWepXdPhEbt3RUGYslxBwiPTTAM6mnqiRmBE4x88TixseVOCPqiXH41eAfIAgFw1S4=
X-Gm-Message-State: AOJu0YwU31uTPAlQ6cYhCqdk6FOqwYQaab607A9WZ4rcp5T3n8VZV/g6
	NK7YJyNAO6Cz9UOsVyQh/HZJTOXMt8u3noWcuDgKXaHeygbntzxCqzHlqgNS
X-Google-Smtp-Source: AGHT+IG08iV06qo8R9/du0gQps+Yfe86bbBjDluM8aHwRtNVPP7KVLmyWm5NhAe3SBVeJfXxmdFvGA==
X-Received: by 2002:a17:902:6803:b0:1e0:3df2:cc3 with SMTP id h3-20020a170902680300b001e03df20cc3mr1088116plk.55.1710803054719;
        Mon, 18 Mar 2024 16:04:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s20-20020a62e714000000b006e4d8687f44sm8464256pfh.102.2024.03.18.16.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 16:04:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d167915c-e55e-4c2b-b7dc-6f4bda2f3a34@roeck-us.net>
Date: Mon, 18 Mar 2024 16:04:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] hwmon: (hp-wmi-sensors) Support autoloading
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, james@equiv.tech
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318215732.322798-1-W_Armin@gmx.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240318215732.322798-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 14:57, Armin Wolf wrote:
> Currently, the hp-wmi-sensors driver needs to be loaded manually
> on supported machines. This however is unnecessary since the WMI
> id table can be used to support autoloading.
> 
> However the driver might conflict with the hp-wmi driver since both
> seem to use the same WMI GUID for registering notify handler.
> 

I have no idea how this is supposed to be handled.
wmi_install_notify_handler() is marked as deprecated,
suggesting that the entire driver structure may be outdated.

> I am thus submitting this patch as an RFC for now.
> 

... and, given the above, I have no idea what to do with it, sorry.

Guenter


