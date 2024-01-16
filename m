Return-Path: <linux-kernel+bounces-27264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15282ECE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B77284E73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65A175A0;
	Tue, 16 Jan 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRnd5mkz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E14154BA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705401950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjqxTDHvgQy8aJf03PgKJjSLuMp8HhWY4sERlhF8row=;
	b=WRnd5mkzUgOq9u2HC3T0QcsfVN/Ia88+c6/LIUDElmQA95RvxbEZXawoUzOtzjG+XJxf4s
	2VnHJfqaCIZAd72bWGTJbpGeASIwalXGyFrzj/A5+O1Cp3KLXWnqxj0hjHEKTTwOfpzjO/
	oBy23Powqofg4DHsf18CHLumk57hODw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-5soBPydpMZy4HsQV-PNJAw-1; Tue, 16 Jan 2024 05:45:48 -0500
X-MC-Unique: 5soBPydpMZy4HsQV-PNJAw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2cb0d70d6cso192888166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401948; x=1706006748;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjqxTDHvgQy8aJf03PgKJjSLuMp8HhWY4sERlhF8row=;
        b=VZizRpAqmyl3NPzgJzYGlQCYMGHgDJfAkK0HAQlR/k5tErciW/GHMrq6pYofCrc4QO
         7cr49k2qnOcrYna7yp066rh3f+nx6rK+8r6RMb8YaYRyHJwoJpVWtIhm1EuvRnkVb8EM
         Y4oz/tTrKqGBy7j0Bt6FGtJD6thn2NCmqmVO0xsZW63mra182ZTjHD1Ju6oKyansKLy4
         3ypihbAoDGKIOoDnfVx2eKUjTw0GNkOxmadnHrggAXMU7TLKDGiO4U+I2uNqgLhnjIJR
         azYrd0fLnrcBjQkInv9N/kTSkdC7zuVgsy4DCoo57AobneJw0wuAM9m78p5/k+/LxVQs
         saqQ==
X-Gm-Message-State: AOJu0YweUUwfigeHSR3kgnmAYOHM/hp/mrhfPYlI6ZurYxs+4cZM7iBA
	2+3Z4/+GHHYodzQNYYbf75ZV0Kbtv1Nb5XAu/BgRCVbQDWDUbOUpwEB6UqN1LTX5VD1dxvQIoHa
	+SCp/SO554bGtRM0kL2Pb1JN9UnE9VTAk
X-Received: by 2002:a17:906:1c56:b0:a2b:299:2e3 with SMTP id l22-20020a1709061c5600b00a2b029902e3mr2882756ejg.146.1705401947885;
        Tue, 16 Jan 2024 02:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6FVV4MuXv1lla/czKKt1oAO2fwOEap+YW0g8LZflc9afhjEtSmkDaFYruOii/YXsyNY5spw==
X-Received: by 2002:a17:906:1c56:b0:a2b:299:2e3 with SMTP id l22-20020a1709061c5600b00a2b029902e3mr2882745ejg.146.1705401947612;
        Tue, 16 Jan 2024 02:45:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709061c4a00b00a2b9bbd6d73sm6320836ejg.214.2024.01.16.02.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 02:45:47 -0800 (PST)
Message-ID: <da062d7e-c06c-40f8-b2ad-9dd5e82ff596@redhat.com>
Date: Tue, 16 Jan 2024 11:45:46 +0100
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
To: "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
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

heh there is a typo there that should be @ljones.dev ,
I have fixed this up now in my review-hans branch.

Regards,

Hans


>  L:	acpi4asus-user@lists.sourceforge.net
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained


