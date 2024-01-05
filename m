Return-Path: <linux-kernel+bounces-17364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A3824C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F29286942
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE2186A;
	Fri,  5 Jan 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbJfRe8C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015D1FAD;
	Fri,  5 Jan 2024 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9e62ff056so800654b3a.1;
        Thu, 04 Jan 2024 17:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704416632; x=1705021432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AF5mOrPVQJTnxk6z3d9Q3zP2VsO9TUGG8+GyWqfcL/I=;
        b=UbJfRe8CAqgBQQyZlWs27TMeO/SwCW00esQ289oD7YEob02RPmGHzsD/yWiyBPsDa8
         I01K0OUu5w1w70S3U1DERtiEG6VMTf0+6Q/GdLtpeGR9VanVqDO3O5wcdmvevJDHPFfz
         RjXvJDqU4RTyFpC5XB+xCkOAZnlgCtkWcKWOSFbXgsaIh1GBFeL8GhIQZJf7+qVFXw1N
         pURdRDaeNq4OQo8IgEXxHvpzcCruGYBbuHUua+safg3rNY4m7eC90ELCNTjZU9bQ2PQF
         h2pUDR4dM7DQqV12e7uiiffkyH1y4o3HzSVCiFrXqrC6d5fIw+vUwrV1GU+yJBP/KpPP
         a2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704416632; x=1705021432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF5mOrPVQJTnxk6z3d9Q3zP2VsO9TUGG8+GyWqfcL/I=;
        b=SyG9dyRwOhmUhktPrWXry/cMrmXdX0Nan9+qUnVDC/2M9Fzlxz76hb21rjoXLTDoQ0
         lRCVYBAeNu9EVNfLyOcbXeLmRMuEjef0loKuspIIc9mJp176Zt/b9jEJ7LpfKrpg6/6Z
         HfwYrKxnOnEjDCvDBj9l5Rb2Mr5UqjF21Phr8PECj67NN5URhvjjUnWF35yAAlkBxzuT
         zFtgrnd21FVkpS4KFSP60VqgEJAZSk63/zCKuYAaldk3SoC6GTZ9zT1m7WsHXel+5JPr
         gL58hBsF0sb5O55vzPXrHYe5iBJauOTTrhje39tO4UegS7uPsEggq/AbDS9QTBdKa1/V
         ClQA==
X-Gm-Message-State: AOJu0YzWGWlgWDYP4IeRt12SUAP7e8C7Xi4E8dzMHqptQVzGDj/SFdki
	pLR0xkEotJEFy1wZa2NavdvSHwUADSE=
X-Google-Smtp-Source: AGHT+IHRyurrmAk3Ckdt3blBP0l1JAdyrqQYwI+mxf+qTACSZFSpV2WKCLYYPvKsCkBoVkHywShRrQ==
X-Received: by 2002:a05:6a00:1490:b0:6d9:8adc:7891 with SMTP id v16-20020a056a00149000b006d98adc7891mr1596073pfu.36.1704416631903;
        Thu, 04 Jan 2024 17:03:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s12-20020a63dc0c000000b005c6eb4bc75esm288734pgg.35.2024.01.04.17.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:03:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Jan 2024 17:03:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/100] 6.1.71-rc1 review
Message-ID: <c3b37c99-4e34-43d1-ae40-41444103b1ca@roeck-us.net>
References: <20240103164856.169912722@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>

On Wed, Jan 03, 2024 at 05:53:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.71 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 544 pass: 544 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

