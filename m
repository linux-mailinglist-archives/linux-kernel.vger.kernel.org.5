Return-Path: <linux-kernel+bounces-7794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6981AD12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFD91F2486C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11D4419;
	Thu, 21 Dec 2023 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Lb02DA8y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E15249
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20418dd34e3so37775fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703128267; x=1703733067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmEy/1G532CwG4AT34Q355aJksdu1DlJSbYzFg/dkLY=;
        b=Lb02DA8yI0ZzNiZMrd7deVBNfSO1uEPUEQkNKQ37Rxprq1KJqCeqNEK5PXfhy4RRLX
         mr4X/xbtZLv7tTbnm7eRRgWIMQDP+QE8t6O8V8Hfh1XsO2oW4nBOX7gDSFOH4ixA+Q/E
         o4X3tRH4Ic8d+TKvH5cvP4LaI43QBn0DwJCRGLa52H9ityQQyeKUykYnfKMF1EUgvdoa
         +YKz+959qzQMrpchlsVLfR1UloI8GTMrF0OpVqmaH4Q/Qr9f6IN8J1Py5cYqMyI57Nzf
         63HJiWUNmhvf9bHiGE20lNPSGbegNlYVOaXECz6Jtrcqt3/x3V3bWogwz5vd9MtYmoiS
         XAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128267; x=1703733067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmEy/1G532CwG4AT34Q355aJksdu1DlJSbYzFg/dkLY=;
        b=ngQJazHRpj9NKblAR3oxw/tQ7ihQX7PS+3J9RXGEkoLqEec4BD0P/WoXToSHbtXal8
         1Fex4EJEkOxrssi4l3JHwNH2ZUimOEiwVlBut7Mak+Wb9jhX7SqcGw4lBZiY6job53O7
         sGADbwFMpR5uxVEo14/oTQpskBMn4c+FD/Xvmyhb7sBJxBb6Oy/w2Q2xCiUteciFGoNE
         gmmUxc1I7+F66J+eqN6sBTJbRSdH4oQA35UaW+XEURmpj1e15zuLSEp7up6hjEhYvzFv
         uI49j6OzhVwwKkX/AJ+jXxHtfOkIWnt7k3BxDh/XAzxkt5GBDe/W7VKM5pN0mkh1Vawf
         RqMw==
X-Gm-Message-State: AOJu0Yw4JF1c7ntfyFMacbze0EZkbQKEE24royy44GnNKob4Im7le6J1
	zENm75RkPoSPQcoH7YXeCJ39vgNmlgBinPZ0YPrygQ==
X-Google-Smtp-Source: AGHT+IFDsk18QMxGkQpEbC1aT1ITuGrkbqfiR5rv1/05sf2oXeBRRGrXZKdrnOA470/dBajOFYhwOQ==
X-Received: by 2002:a05:6358:5284:b0:172:d475:20b0 with SMTP id g4-20020a056358528400b00172d47520b0mr14803788rwa.3.1703128267299;
        Wed, 20 Dec 2023 19:11:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00124300b006ce39a397b9sm476306pfi.48.2023.12.20.19.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 19:11:06 -0800 (PST)
Message-ID: <afa3550e-f522-4243-a7ef-da171628c345@kernel.dk>
Date: Wed, 20 Dec 2023 20:11:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231221140124.16418659@canb.auug.org.au>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231221140124.16418659@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 8:01 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "disk_clear_zoned" [drivers/scsi/sd_mod.ko] undefined!
> 
> Caused by commit
> 
>   d73e93b4dfab ("block: simplify disk_set_zoned")

Oops, yes that's missing an export. I'll queue on up.

-- 
Jens Axboe



