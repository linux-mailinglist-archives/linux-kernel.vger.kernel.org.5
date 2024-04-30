Return-Path: <linux-kernel+bounces-164481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF38B7E10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E49B247A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256C1A0B1E;
	Tue, 30 Apr 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5yP3jf7"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981817F396
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496376; cv=none; b=oCRRBE0DiJW2x7C4ThYLbp+2s9NM9iM/JLpFDK5q8mb8gZQfq4+VNyyDhR9QTZW7M9QWo6jPlPobCv5CZM6GQGuj1t08sihCrojiKCTOuoTMIOCLoy/013JjfXTIZAzODGQJSheYMKIrEFpLM6sJPps7PcWXbB9bBl6tpVU02Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496376; c=relaxed/simple;
	bh=R+EEWTKUw+xnpu64p6u8Ohkc7r7mBLTm2yumZi8kM6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBkwoFGGQo9T7XUPLPvBbsZC4CapploVDezeASUThloDDOUadPVU5M2Q6TN39y1eWmZFFM+Ec8TxbhN6psgHQtl1W8kX4xFn5rLxNQZYbpVj8SWgqZNz4yyZDoppOamQx7zvoPqe+L5/yGTz/zqNTB4IYPcbNIcdIhFo3rTCxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P5yP3jf7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso5300946b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714496375; x=1715101175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCCS2R2FR9/FAipUn7TWN7sN6TdN7DchzvkmF3EICv8=;
        b=P5yP3jf7IlN8+DN2tuob11AnX8Pl5j95Sa9CNAs95SG/yz1fsRUh6NeKgFpBtIKg8X
         5UInm8iAMtcZl7Mvuzk3kKmpUMYVL1pLRNpb+YlhLjTo+worzgvSWn7kGSxsSo22nysJ
         7Nk/i9g+JIN/WLyiDBlGhq8Uae7SAhV2+u3Agew2p/Hm11b9kjYqZkCoa4g3H9+EIJsU
         6EdDCw3m4SllM5TTuwDR77PXV1I9UAPkC1SHwRc7nIHYx55v+GAy9WekXdHPOBx3qgRJ
         kCLFRd3AozCSJNBCZRFuVOINkDHTl/wdwNHIFhICP13ttQjrsOyYNTNU+9wCz9DkGi59
         p4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714496375; x=1715101175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCCS2R2FR9/FAipUn7TWN7sN6TdN7DchzvkmF3EICv8=;
        b=WbQ2s9SOdaHZlIdz/JuwHwUHn7W3p3+ffXxtk0sELe2bj9CX6iUrHNsgU4Qd/ALWwU
         k7ngy0L4URo1QnvX+5sYa+0wNRuTQTHKKDHp9q8sk2XAQzPsF4oH46zroJqCgto/JT7n
         vIxAHzR7EfALX3A8ak2pa65DLEwTJynwj+NFCVrPMie0/xid0+kpJsEVBTIZBgZo1TKT
         LXCVQaXyFOtsAVvyQAnkf7KwPT1OgOw6xB7oDyd0mrXj49jIkBZrCkvRN+eeA88rRRl7
         8qdB+RCWtb6equME7ak+eMh5ehliNsZ1eQ5b4IQ/7h1ErxLCSk2CQKl1Z836I0lOXLqc
         5MCA==
X-Forwarded-Encrypted: i=1; AJvYcCVDegrNpG6M0rVGIADl7eB/OcnkkrnK8Np/3f3TyqjmnABpFBZNgdcP7BrJtO2bfJNGND99I/CtTxHFK9BmwB7VQ7wqyV4SU/MVtE0B
X-Gm-Message-State: AOJu0YxUdxFaCZEXrYuFyX1WZKRVlRG/D7V1433jNC+MVuSJGk5T/VjL
	UtMMm4qHqQqMLlPK2OduuYrNA4NC8fAJDlxhS46W51PoZAsW2TsKnH3HPHW+HCfemj+r+Lggzqd
	t
X-Google-Smtp-Source: AGHT+IGrgXXLXiCPGKlyYF/HhFyTUcDK+n3kbkIyjbNRzYyB3tH48qTUfmS21rhv5eklR0G4DqTnEg==
X-Received: by 2002:a05:6a00:2448:b0:6ec:f712:8a69 with SMTP id d8-20020a056a00244800b006ecf7128a69mr261943pfj.29.1714496374481;
        Tue, 30 Apr 2024 09:59:34 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2e09:6862:d789:2631])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm21266353pfo.126.2024.04.30.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:59:34 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:59:31 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, s-anna@ti.com, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, nm@ti.com,
	devarsht@ti.com, hnagalla@ti.com
Subject: Re: [PATCH v3 0/2] remoteproc: k3-r5: Wait for core0 power-up before
 powering up core1
Message-ID: <ZjEjc9kUaGuXYy12@p14s>
References: <20240430105307.1190615-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430105307.1190615-1-b-padhi@ti.com>

On Tue, Apr 30, 2024 at 04:23:05PM +0530, Beleswar Padhi wrote:
> PSC controller has a limitation that it can only power-up the second core
> when the first core is in ON state. Power-state for core0 should be equal
> to or higher than core1, else the kernel is seen hanging during rproc
> loading.
> 
> Make the powering up of cores sequential, by waiting for the current core
> to power-up before proceeding to the next core, with a timeout of 2sec.
> Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
> for the current core to be released from reset before proceeding with the
> next core.
> 
> Also, ensure that core1 can not be powered on before core0 when starting
> cores from sysfs. Similarly, ensure that core0 can not be shutdown
> before core1 from sysfs.
> 
> v3: Changelog:
> 1) Added my own Signed-off-by in PATCH 1, specifying the changes done
> 2) Addressed changes requested by adding comments in code in PATCH 1
> 
> Link to v2:
> https://lore.kernel.org/all/20240424130504.494916-1-b-padhi@ti.com/
> 
> v2: Changelog:
> 1) Fixed multi-line comment format
> 2) Included root cause of bug in comments
> 3) Added a patch to ensure power-up/shutdown is sequential via sysfs
> 
> Link to v1:
> https://lore.kernel.org/all/20230906124756.3480579-1-a-nandan@ti.com/
> 
> Apurva Nandan (1):
>   remoteproc: k3-r5: Wait for core0 power-up before powering up core1
> 
> Beleswar Padhi (1):
>   remoteproc: k3-r5: Do not allow core1 to power up before core0 via
>     sysfs
> 
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 56 +++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 2 deletions(-)

Applied - thanks,
Mathieu

> 
> -- 
> 2.34.1
> 

