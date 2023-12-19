Return-Path: <linux-kernel+bounces-5492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D828818B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17D4B232F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417B1CA91;
	Tue, 19 Dec 2023 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRf06mVM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE381CA83
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703000137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p99ESQKY7iFMWcolC5b1pxUDyj4bwHXCNWig+NO0MP4=;
	b=dRf06mVMqliWV2NwQ76Mqfy8GvTA1wiAoLTz2btk7RkarQ9a6gk5r3M+0OW8pFQL+jkVS4
	/8c5dfrzMF9SbWOsC/45kZ7uKO704kBO6xLYPSPzVRKrimNq8knZrdrd028JKYSn8VObzQ
	+vVaNwa6h43ZO3vMTGNgEe82CFQDbWw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-XOa21xG9NUGIrkw_P_XI0g-1; Tue, 19 Dec 2023 10:35:35 -0500
X-MC-Unique: XOa21xG9NUGIrkw_P_XI0g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-553b57272a1so63504a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703000134; x=1703604934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p99ESQKY7iFMWcolC5b1pxUDyj4bwHXCNWig+NO0MP4=;
        b=LmBXe3+/ILgbu5FgcuCQyhYWXJMY2ICdk0BnPB5+PTrp18Fg0aXE0N002ryxbG1bLN
         Kj7QdCgnoDc0lNU0HRsAPlX4horhQeEpvLaFyffFmj0Cu6Ah+8zr4glFyea8J/EG4i7N
         mq03IdPfR4G10kz5wY3dCOWmneZ7lPegtAd3IMxAZ0MaPRg2HDaXP0S3mKaEQAOI8JTR
         RpC+HV1IS/fZ2ujKeB070HS+vb0sNFPwRJ/pqkdE0up8Z+A/+bOmDpcgh6CEbsm2c3WQ
         ikY5h0ul+XkMGClZy30d6qUK6ocsswD0O2EOD1mmQnpMs0oV5PZqvmQ4I+DX7IqLoQL9
         8iDw==
X-Gm-Message-State: AOJu0Yyyx+b7CFxcN8oVGNasjQqoaTYWKEB0swA8UMeQY/WJtb1kHnem
	E452XsTvYXB07wcvca5ghR0Ve6dc9u/PHLqfYsZkwzNcbaSkKMkryXOrVrXtvu/zeg7QMggS/1c
	bGod3KOwt5nIYQ9OpqqXUoQaC
X-Received: by 2002:a05:6402:1e87:b0:54d:9782:c3db with SMTP id f7-20020a0564021e8700b0054d9782c3dbmr9215040edf.84.1703000134414;
        Tue, 19 Dec 2023 07:35:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP76Za9ppm8rW8twFPzyF+1wYJU0pcIBQ3tT5tH0fSH39K2g7bfa64ib6HAvYJ+D1J0Gb7Yw==
X-Received: by 2002:a05:6402:1e87:b0:54d:9782:c3db with SMTP id f7-20020a0564021e8700b0054d9782c3dbmr9215037edf.84.1703000134095;
        Tue, 19 Dec 2023 07:35:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b0054cb316499dsm11626513edi.10.2023.12.19.07.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 07:35:33 -0800 (PST)
Message-ID: <bfd55a50-7bcb-4f2d-b960-27a61ddd6509@redhat.com>
Date: Tue, 19 Dec 2023 16:35:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] platform/x86: wmi: ACPI improvements
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218192420.305411-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231218192420.305411-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/18/23 20:24, Armin Wolf wrote:
> This patch series improves the ACPI handling inside the ACPI WMI driver.
> The first patch removes an unused variable, while the second patch
> changes the order in which the ACPI handlers are removed on shutdown.
> The third patch simplifies the error handling during probe by using
> devres to manage devie resources, while the next two patches decouple
> the ACPI notify handler from the wmi_block_list. The last patch
> simplifies yet another ACPI-related function.
> 
> All patches have been tested on a Dell Inspiron 3505 and appear to work.
> 
> Changes since v1:
> - fix ACPI handler devres order

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> 
> Armin Wolf (6):
>   platform/x86: wmi: Remove unused variable in address space handler
>   platform/x86: wmi: Remove ACPI handlers after WMI devices
>   platform/x86: wmi: Use devres for resource handling
>   platform/x86: wmi: Create WMI bus device first
>   platform/x86: wmi: Decouple ACPI notify handler from wmi_block_list
>   platform/x86: wmi: Simplify get_subobj_info()
> 
>  drivers/platform/x86/wmi.c | 143 ++++++++++++++++++-------------------
>  1 file changed, 71 insertions(+), 72 deletions(-)
> 
> --
> 2.39.2
> 


