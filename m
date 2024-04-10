Return-Path: <linux-kernel+bounces-138834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C289FAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F628908B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044D16F0D8;
	Wed, 10 Apr 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="B98UCzIO"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957416E883
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761177; cv=none; b=b/dkgdP0yYCmRmQSNUBhoWCLwGGXLaTvsVmUF4jtrbhSMxfPc+yk5M8wH5X0MVIpOLLc26VgQybNUoRQSCgDvtrmo2zW89OfiBxHon87EvvepOkFjjKed6wL4IOQgq6drNibFqTMF1lVf/jGtq+gv1eABCZfCXz3D5ckbLJjH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761177; c=relaxed/simple;
	bh=eEElfM7ms0vW3GITIqHnuPQ0BbQKAd12SZvcqVWQgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um2GBR69gXfJCQPsvqFdxXk35Pf7UlIpNesjZuso+hhbVr1dS0uNJdH8J48poEXgawvwkX6o9gNugwdqPOVMATg3GfRt97F+bhyVwIBzzIPSFUcJOSIXHiINaqjL+jCWs1M2LcZrC66yHxtACtdtIA/UGOO2TMX7O3/zSJRPKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=B98UCzIO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343d6b55c42so4883737f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712761173; x=1713365973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZZ8Qzl07ggsrvxvKNXqPw1lCm8hvKS1T4p91mFK23k=;
        b=B98UCzIOwOGQs9TaK90e1Bh2v6JOYoDtbvPHtBvxt8filiL5jMo/CYuQIdMEpLgRxx
         ouf2WkTFBtf5Z54tK4zGw7/qMLZ7RZWjQ5Ubyp806gUPi9iKfKap3r8Klu8x//GoAI9e
         u8cw9UvelhNIhEhc1WOnTQNTX85OAtaxF4DtPfRtNVBLuiNXFfNPWKzC7QJX0WXopedI
         8ClnLpiX+WE2PcwbOqJCB88hjug7/BCSDLlaXETkgNsmhhNuF1q7NWln0HaDAs2tPNix
         iePr99+HmELXvWFhk0pI9BnYr/PccO7swB8DIcHUpjapeE1QXZk/zrIxSXL+Lv3XOJXP
         YjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761173; x=1713365973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZZ8Qzl07ggsrvxvKNXqPw1lCm8hvKS1T4p91mFK23k=;
        b=N2pSjDQ4tvup9EWegIB4WpSoPCT3C1GTnBBCDjmIwH+B3mlgB+2ZOPbbfCwrrwL5j2
         snUdW6ESvU7Se7IUH0xHcQR8vOaAHEZxII3JYJDisU1bvmS+ySuiEhJwlHxGzXNGlYzq
         ZM9wHRUu9TE7wKNygbByvfvD6l09/AguypU7IZNMpb3lglmIUmwM7hNtPAISI12GXOu1
         brrV9F1RCQQroal75TS+NHkfMn7zUGixPhERkCBCv25Icdi1r47B6G99fwgKBEqFguPd
         n+yH8KLTnNdONVdg45ZdjmnSG71TJV7RVPGoIgxg/SM6SkmLBMigzpu2juncJEz6Ivf/
         ipCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU95d7QJNBJc0C9423+WgttO8BaOT3Jxir7pt0RsfZ9UhaVN720Z6Xk8gv01TNgyjDVRJsPU0QX1JVnIFwkbokLxnBLlT74Z28YQtkp
X-Gm-Message-State: AOJu0YyQfHVgp2SBuve28USZ0w6/AVUCHt6UyjKvAr0nA0OEWstiANGd
	68jPG3f18zB8XFv2JSlJ5ISrRv+CgiKCDw9qAeHM47yEhlk4AnOLCPBK7b7zDIQ=
X-Google-Smtp-Source: AGHT+IHUHFWXIPMwpItWqkGkjM5+39g7zm1g+XQ63hnRVbmyCLE+0EbyeQst1gtlWHG95EtoCBLyhA==
X-Received: by 2002:a05:6000:2c2:b0:343:ef1b:9f68 with SMTP id o2-20020a05600002c200b00343ef1b9f68mr3933554wry.50.1712761172805;
        Wed, 10 Apr 2024 07:59:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x1-20020a170906134100b00a519ec0a965sm6978557ejb.49.2024.04.10.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:59:32 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:59:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, rkannoth@marvell.com, shenjian15@huawei.com,
	wangjie125@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
Message-ID: <ZhapUja4xXiJe4Q2@nanopsycho>
References: <20240410125354.2177067-1-shaojijie@huawei.com>
 <20240410125354.2177067-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410125354.2177067-5-shaojijie@huawei.com>

Wed, Apr 10, 2024 at 02:53:54PM CEST, shaojijie@huawei.com wrote:
>From: Hao Chen <chenhao418@huawei.com>
>
>Add support to query scc version by devlink info for device V3.
>
>Signed-off-by: Hao Chen <chenhao418@huawei.com>
>Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>---
> Documentation/networking/devlink/hns3.rst     |  3 ++
> drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  9 ++++
> .../hns3/hns3_common/hclge_comm_cmd.h         |  8 ++++
> .../hisilicon/hns3/hns3pf/hclge_devlink.c     | 44 +++++++++++++++++--
> .../hisilicon/hns3/hns3pf/hclge_devlink.h     |  2 +
> .../hisilicon/hns3/hns3pf/hclge_main.c        | 18 ++++++++
> .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
> 7 files changed, 82 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
>index 4562a6e4782f..e19dea8ef924 100644
>--- a/Documentation/networking/devlink/hns3.rst
>+++ b/Documentation/networking/devlink/hns3.rst
>@@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
>    * - ``fw``
>      - running
>      - Used to represent the firmware version.
>+   * - ``fw.scc``

What's scc? I don't see it described anywhere.

