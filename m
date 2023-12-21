Return-Path: <linux-kernel+bounces-8419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5281B6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84AF286052
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C277638;
	Thu, 21 Dec 2023 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMKNMqt2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBA7762B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703163667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSrs7/svZn5FyDVozgzuvd4svF0FH5b5LzWLtfD8wtg=;
	b=DMKNMqt2Vc4LZ7dYgxVSe6Lnhm9xCSU+nPgFSzLRmHeAqi1U4R0BplzHnddFY+68+lJsln
	McAEx66sDutn4zsdaZBuIvX0Iq8ndxVKD7LuZXGZZHLau7Pnb66hNAFsuZJdRzWJoe6asg
	NcsgO6GefpFv7uxTGJvQAf0X1Ua8ca8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-KfvwqGA1MW6iWhzb4DaIQw-1; Thu, 21 Dec 2023 08:01:06 -0500
X-MC-Unique: KfvwqGA1MW6iWhzb4DaIQw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1fa0ed205fso36299066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163665; x=1703768465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSrs7/svZn5FyDVozgzuvd4svF0FH5b5LzWLtfD8wtg=;
        b=JLudo7zMuepWOFCDHhzbAwDiJgomF8BdsU2hxXI1Lm9Qt1b3G/7vh+VU3Ij7xfsjDv
         77jDfexb1BVMmdk5YKL+l+lHQs60PAk3HwqQMmnHVq/1gktDGW6aoASzU/aix++lbzYq
         fvBFExe3gbBcBc1cpzKDrZiAZqcQ+EIHt5gbC4NspNoV/2PIxJdiL36uJHHbJhfQXi+k
         NPyzRzMFmbM1L/wcdl+VUznUqnShDb7clHf9mB3USEsTa9dXFeyZk24BkSpv7NpkQyOA
         iEebbXb0yBu/nX5J72tFKrCrRvqti/MrVoX4X1GamEpw6fFfvaVo4vTdxvjLM99pBNgQ
         OHrw==
X-Gm-Message-State: AOJu0YyWuAY73tiaXzXQN5b4ldiMvIAGsvfkG+ZsUI7sFDeT77V5oaXj
	fm3gLEqUJaYis8/zT0EMRC/7bE4PyK/Dlzvv5CCOabbg/rnt63eG1GDNXwz31o75VlukT1dTIsP
	ugAWQavsI/5ZzoleHpMCtBMpI
X-Received: by 2002:a17:906:5346:b0:a23:6d4c:bd8c with SMTP id j6-20020a170906534600b00a236d4cbd8cmr2839376ejo.134.1703163664886;
        Thu, 21 Dec 2023 05:01:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJImFd8MXe5rmGBjMTD/ZwZApQxB1DQTaZVVPVOh4LTsFWaqB0s9oZiTqtOknlNnxG2sVOlA==
X-Received: by 2002:a17:906:5346:b0:a23:6d4c:bd8c with SMTP id j6-20020a170906534600b00a236d4cbd8cmr2839370ejo.134.1703163664562;
        Thu, 21 Dec 2023 05:01:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906135600b00a235f3b8259sm915647ejb.186.2023.12.21.05.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 05:01:03 -0800 (PST)
Message-ID: <7c77b863-95c9-44b7-a039-19e9fd5f690b@redhat.com>
Date: Thu, 21 Dec 2023 14:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: move driver-api/dcdbas to
 userspace-api/
Content-Language: en-US, nl
To: Vegard Nossum <vegard.nossum@oracle.com>, Jonathan Corbet
 <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20231221124816.2978000-1-vegard.nossum@oracle.com>
 <20231221124816.2978000-3-vegard.nossum@oracle.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231221124816.2978000-3-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/21/23 13:48, Vegard Nossum wrote:
> This file documents a sysfs interface that is intended for systems
> management software. It does NOT document any kind of kernel driver
> API. It is also not meant to be used directly by system administrators
> or users.
> 
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Thanks, patch looks good to me. Here is my ack
for merging the drivers/platform/x86/dell/ bits through
the Documentation tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
>  Documentation/driver-api/index.rst                     | 1 -
>  Documentation/{driver-api => userspace-api}/dcdbas.rst | 0
>  Documentation/userspace-api/index.rst                  | 1 +
>  MAINTAINERS                                            | 2 +-
>  drivers/platform/x86/dell/Kconfig                      | 2 +-
>  drivers/platform/x86/dell/dcdbas.c                     | 2 +-
>  6 files changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/{driver-api => userspace-api}/dcdbas.rst (100%)
> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index b1b82ac1063b..b38f81836118 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -78,7 +78,6 @@ available subsections can be seen below.
>     backlight/lp855x-driver.rst
>     connector
>     console
> -   dcdbas
>     eisa
>     isa
>     io-mapping
> diff --git a/Documentation/driver-api/dcdbas.rst b/Documentation/userspace-api/dcdbas.rst
> similarity index 100%
> rename from Documentation/driver-api/dcdbas.rst
> rename to Documentation/userspace-api/dcdbas.rst
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 277b7a40ca91..74bc0716432e 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -32,6 +32,7 @@ place where this information is gathered.
>     futex2
>     tee
>     isapnp
> +   dcdbas
>  
>  .. only::  subproject and html
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b6d2dbe4f1d..aa9c4c7ebe71 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5901,7 +5901,7 @@ DELL SYSTEMS MANAGEMENT BASE DRIVER (dcdbas)
>  M:	Stuart Hayes <stuart.w.hayes@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/driver-api/dcdbas.rst
> +F:	Documentation/userspace-api/dcdbas.rst
>  F:	drivers/platform/x86/dell/dcdbas.*
>  
>  DELL WMI DDV DRIVER
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index bdd78076b1d7..e712df67fa6b 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -37,7 +37,7 @@ config DCDBAS
>  	  Interrupts (SMIs) and Host Control Actions (system power cycle or
>  	  power off after OS shutdown) on certain Dell systems.
>  
> -	  See <file:Documentation/driver-api/dcdbas.rst> for more details on the driver
> +	  See <file:Documentation/userspace-api/dcdbas.rst> for more details on the driver
>  	  and the Dell systems on which Dell systems management software makes
>  	  use of this driver.
>  
> diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
> index 76787369d7fa..a60e35056387 100644
> --- a/drivers/platform/x86/dell/dcdbas.c
> +++ b/drivers/platform/x86/dell/dcdbas.c
> @@ -7,7 +7,7 @@
>   *  and Host Control Actions (power cycle or power off after OS shutdown) on
>   *  Dell systems.
>   *
> - *  See Documentation/driver-api/dcdbas.rst for more information.
> + *  See Documentation/userspace-api/dcdbas.rst for more information.
>   *
>   *  Copyright (C) 1995-2006 Dell Inc.
>   */


