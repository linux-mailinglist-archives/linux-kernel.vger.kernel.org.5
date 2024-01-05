Return-Path: <linux-kernel+bounces-17365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05E824C51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0A286971
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7491C02;
	Fri,  5 Jan 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVK2FYJC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF480185B;
	Fri,  5 Jan 2024 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so814925a12.1;
        Thu, 04 Jan 2024 17:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704416663; x=1705021463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSpoTLEcYmpyrX/0zTXHzhfPiHX5R9Z55hnkfOsGChU=;
        b=NVK2FYJCmCArOKAXn4YWvuTs7vyjTNwfLzZygdPGsNkySZNqTPDjGjHIgCImrjC7Bf
         Xy+w/k9DmCRM9Yy8txzT06vHrNL2qBgtb0/SRXsbXSjm41R7LjfE7OgVGIXj33xWE8Wo
         Y8SI8y6tOy3y7xwiG8e1JuJiwoaxfNW0ib2iKQImeYtceKwh2irhoGuhRYpaGYjoQV/6
         UrfghuqBY5Yq67jjDE0PESugwaQV01ViXKKqD40Ho8lsoVGRU7O4V9KCDfeHYDpzCtED
         O6JBLfpfyvvI9t78ebSi1hJDU5vM2s8W96J91u8/HoMpZWNnOZLt9snE+/eZO0RLHtv4
         mWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704416663; x=1705021463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSpoTLEcYmpyrX/0zTXHzhfPiHX5R9Z55hnkfOsGChU=;
        b=aARWRVyRipQxfq1G+e+6TBnRD17OhPsXQTxkc5HQa+9zWaGIzMNrpceSNoDNfWC5Vt
         EGfBH76Bdj+qa/jXelRobGYFabJhHAQSz/VTkbX0Vc9p1U0px+ikSBxounwEXLKF90ud
         h5OTl5m5lJNlgO0+L/NteosJpLH9IsmppbYKiOmhUN7oGf2JcP+3lf2d8LOBtLM4slKp
         N4CoJ5oYhnnGZxm5YxJCowCFm06Zx0y9TwVzW4fWsCs85/gpTGrfstdkCx3qvUW52ahv
         IyuWblgEv5Dn4hHnCstcUGZZ/1P24lA8ZiBEXmDq7Wsa1b+h0pEntXd+v+3rFrxmbkAI
         s6lw==
X-Gm-Message-State: AOJu0YxUmBY3bZaibDuEKVOECkBS8qVxr1ORNCShEL/9M/kh0pdhaZtI
	bkQxXOtDXnSD/iThIWNdBKY=
X-Google-Smtp-Source: AGHT+IEjoco8dNn6aF8qBueTRAQIlsxisBb1d/K20aYhgpVZYzmWsUww6P2XFJbrOiojGC5vOxT2fA==
X-Received: by 2002:a05:6a20:ba98:b0:196:373a:554c with SMTP id fb24-20020a056a20ba9800b00196373a554cmr1266804pzb.82.1704416663305;
        Thu, 04 Jan 2024 17:04:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a0026db00b006d9ad29b108sm258078pfw.202.2024.01.04.17.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:04:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Jan 2024 17:04:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Message-ID: <57c3c7b3-97e3-4288-abf4-b875cc04cb03@roeck-us.net>
References: <20240103164834.970234661@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>

On Wed, Jan 03, 2024 at 05:55:20PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 545 pass: 545 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

