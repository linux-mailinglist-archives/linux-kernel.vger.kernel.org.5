Return-Path: <linux-kernel+bounces-27253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9758382ECCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4517A2843D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F9D11C81;
	Tue, 16 Jan 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZolPxPOB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B75818AE1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705401179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O106YIfnVWdh4mXjGyHTWPZx6xc/H9v5ma5I9J/+uJM=;
	b=ZolPxPOB6pb9jYj2IXYtfDIgWORSPPLYJHGLUMc10wTg9sKCxR+ovNWWq32MG+vJkEuoQX
	D9KkzOO4jDxtsP509QMuFDA2i+2y/IJnbDcwjlXy2MRdcHsubVqnoPFP+j/0fa1nGrMEKf
	tpErQgoRJa1k6Up/to6lsAtCOkCU47M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-XdP2eLFSMGSQF7bSrVhHTQ-1; Tue, 16 Jan 2024 05:32:55 -0500
X-MC-Unique: XdP2eLFSMGSQF7bSrVhHTQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2b047e8f9fso397577966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401175; x=1706005975;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O106YIfnVWdh4mXjGyHTWPZx6xc/H9v5ma5I9J/+uJM=;
        b=Ht94spSsq4AoxD2yEX8+jX1APjq7AYNUfVnSZtPwXywfvZZl4tdJPTzidZtuWBePku
         bcGpCjjCOXj1Q52ugJ9MqrhVdJ0WCYPnVCFWqGJk3WO0fGLo4ovbSB/Vd2QCv/EadNPl
         QcZ8Kt9pvQIXlRoG2rZ7WiYYG7YVXqPkb480JPYpQUauypjDNi9/bNNOylTB3TO3NrlK
         joNCMtmPjKDUf8rckVLSZYPdYPE7W3veuAA41/UaYuGxUwX6/7CHk+dpaLGNzW2/JrMo
         K5KCpQUwt4QRyRnEoUxImRFy83xcKIWkZLPrOSCRIMRWhfWgldb4dfRFOMnTebwX+et+
         VNew==
X-Gm-Message-State: AOJu0YwduhkMaVeq+sXVtBYl/7OdeWW8j6UGOHnddFuCXBlGRqJMtMNs
	O+Y5UXhCMUO7wuNN8iaI8zJJBMijrVCb1fwCCOYODjSxN6S9ULvJI5QgYqCqpEDeM26it0JfYhD
	cQTfBruyef+wps7Juv3PuqM6dGrhwTUlT
X-Received: by 2002:a17:906:260d:b0:a2c:72e4:efb1 with SMTP id h13-20020a170906260d00b00a2c72e4efb1mr3089067ejc.139.1705401174821;
        Tue, 16 Jan 2024 02:32:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLMR2PGM/GnJ+fk71EEYuew5GIcCNmIWxwkHlhcYHIOkV8jJ0XKG9Ii13NlH3XjKpYJvZBlg==
X-Received: by 2002:a17:906:260d:b0:a2c:72e4:efb1 with SMTP id h13-20020a170906260d00b00a2c72e4efb1mr3089062ejc.139.1705401174545;
        Tue, 16 Jan 2024 02:32:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kq10-20020a170906abca00b00a2e98f4c687sm76083ejb.164.2024.01.16.02.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 02:32:54 -0800 (PST)
Message-ID: <0b9b08a2-69c6-4068-a2cf-6aac1cc52387@redhat.com>
Date: Tue, 16 Jan 2024 11:32:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Luke Jones as maintainer for asus
 notebooks
Content-Language: en-US, nl
To: "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <20240115211829.48251-1-luke@ljones.dev>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240115211829.48251-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/15/24 22:18, Luke D. Jones wrote:
> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
> DRIVERS" as suggested by Hans de Goede based on my history of
> contributions.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f5c2450fa4ec..e7843beaa589 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3147,6 +3147,7 @@ F:	drivers/hwmon/asus-ec-sensors.c
>  
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
> +M:	Luke D. Jones <luke@lones.dev>
>  L:	acpi4asus-user@lists.sourceforge.net
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained


