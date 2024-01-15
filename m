Return-Path: <linux-kernel+bounces-25730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776BD82D50C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280DB281495
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0647482;
	Mon, 15 Jan 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYzKJjCB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA47468
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705307248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pehUlh5mpGQ5TGIbBN/xVKuXzozmXoCM9xJyPY4GLE0=;
	b=GYzKJjCB6Ub9oM6AtPeKHLpid/ui1SptJbxTTFAtSQ3M1VeiwdaNT57zqRK+c1Fsu87sgJ
	ljsdxlwWWkTum+hmOyHsNyP9VunlMBEOIafr8IXaoyuTjUOBb++uUH8KxHth1xr7n3MnJy
	ABBpGtF3jEJpwzRORyFYMDWxyOdzW/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-AitCi57xMACQSGLA9mevzg-1; Mon, 15 Jan 2024 03:27:27 -0500
X-MC-Unique: AitCi57xMACQSGLA9mevzg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e41740b6eso74763755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705307246; x=1705912046;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pehUlh5mpGQ5TGIbBN/xVKuXzozmXoCM9xJyPY4GLE0=;
        b=RzoxswpDloNDa8nCVTSrVh813ycyUmzmuQ8nWv2CSSsl51clL371upUqiOv5An0iie
         kSKVf0tDUajADmOSdS0mdzim+q/EDSxVeIc/eKfXCV3Je3ZwkAKJMouS4rj5uZnSZqkp
         hC3atwEEO20YunhPPlr6UiUz1/WHwowk/t+eNafuRjo71cAhlMllc3STrO5ZtmmvMwcP
         yRcSHaC6sQyfYxqwQbT9JIIEoUczny+4WzjMkIbPwFSA2VfZZUR8tfztz6s9p0QdXuoN
         5JiECYyVPPPmouzKZNaJH1XdhYbs6D0j2iQtNHDzNlNavA917ZQqZkY/OcVqP7yyF4mH
         B84g==
X-Gm-Message-State: AOJu0YycJnQOaOVBj+nHtKSssMORwlAVU6k409Lopt91lLuJ0eLOORY0
	ZFUaovCmKGIJsMLYf4W9mCfj/HJP2tc+9PcW9nIpo+IZBiPtZPbHTbGpRoS1vVvZ78/BPl0lSB2
	Ie305FIWyreIjbYEDsKnGzzqFIH6ANhdu31ln8SE6
X-Received: by 2002:a7b:cb93:0:b0:40e:6792:ac08 with SMTP id m19-20020a7bcb93000000b0040e6792ac08mr2081311wmi.14.1705307246020;
        Mon, 15 Jan 2024 00:27:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2x/nlsctM6zk5v7GGg1IXQBdJ9MByR0vhFREzXeFeH6SHdHa07Hl7vvvScqLoCtW0k+RoYA==
X-Received: by 2002:a7b:cb93:0:b0:40e:6792:ac08 with SMTP id m19-20020a7bcb93000000b0040e6792ac08mr2081301wmi.14.1705307245688;
        Mon, 15 Jan 2024 00:27:25 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g7-20020adfa487000000b00336e69fbc32sm11277592wrb.102.2024.01.15.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:27:25 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Lee Jones <lee@kernel.org>, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v1 4/4] backlight: hx8357: Utilise temporary variable
 for struct device
In-Reply-To: <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>
Date: Mon, 15 Jan 2024 09:27:24 +0100
Message-ID: <8734uzovbn.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> We have a temporary variable to keep pointer to struct device.
> Utilise it inside the ->probe() implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


