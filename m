Return-Path: <linux-kernel+bounces-153526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E52A8ACF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19982282BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB21514CA;
	Mon, 22 Apr 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vYgUh1sN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7FF1509A4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795544; cv=none; b=q1AT4rOcZxlwdbH496Ie3hwUN/sm7QOce0OYJKObn+q5mj/DDw0lqjCBwn843giHdzvF3wOi+Z2SlkxZMrpu7IMQdLWgB9sylrRblyyzhbVYQEFvZpKVDmRP2ok9o1sHKaSJAL+kf5x1fJRGi4ORg/dIM45n8g3mTF2xRd60kEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795544; c=relaxed/simple;
	bh=AiuxBPh2cWOttXetfkOvjTeTNBefriCBNsLwGKfRSOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbAMVtWMYeOJ3CbbMpqvWZkaQp3C2Ev+Egm2Uo1vzowU+GrTWOuzEwcx7mI0CBcK4WHpEJrESBOQbBMlz8XjVBdwQPfTLP2CnSDR2e0gOOIX/UoM+hhn+eY7otppVvSEtSDJMb6smsnj6ntLb9jEXIGgDbwWej4aLq5qwd3QS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vYgUh1sN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51addddbd4so439375766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713795540; x=1714400340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6x0t+W0EiSlEO0rKZIWSrQC6VoY+Vp+8NR6a2w/aIo=;
        b=vYgUh1sNPLm8Fu+aWEYgm85WK+PhCik4VXUucxqinDlheCGZYV3uX0xK6HqkIGUqoK
         5x2hqrhigSCSCaNsX/87Biy9RHfohMq0dygJpOTJUh0ZTae7G5HhJQ0YQtblIa/Qc5dG
         OVYoTb5KmJkyO+ytyAd3PI3V2lnv9+8IFZloNu5GGHPo3dCdwzyHWvxMocgfDG2ruM3E
         CNiXLVansQIiA6puQjRqCN0zis6xfiAmjnMh3FL8tFBfPs+18m/HF2p/hmx2Il/SfHeA
         E2+bKMPpx/8r/M0TLyQsMPB4oB4BIS817hNfD2gMez3otCkvucpqODbT8ewiaOvhrzUe
         C3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795540; x=1714400340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6x0t+W0EiSlEO0rKZIWSrQC6VoY+Vp+8NR6a2w/aIo=;
        b=qYDa1FF4QrwolrUhOVxgRnWXsS1O552KjYW8Zh5Ota/gixbyd1kGyp3J4XLOnjbbDb
         3bI4VWAeb7L70FzVXc1Rlg266gONqhAZUcDo1rQh2E9h5z10ZF/J+fq0djjgjP/2NtWv
         4A/YTLyOUL0LgUEZHyx59whbd/1yRwTJe3MVfdiOiS+v6F7XmHTEaitiqNFVqh/AVYpx
         TKuBRkpsYc4VZS7cNAlT8UcMCYPoPJWRu75UhGTHUhTzh2neh9RycIBu5ye4R6sHAo51
         BmB/NfFdshrw/VZ9y6MP1DUrDU+Kjb54q1T+DadLRu1t8Ap77LO3udNsyq+qIwDFcD7a
         injA==
X-Forwarded-Encrypted: i=1; AJvYcCUOZ/T9fTLuMwlyrzKX0FdTdAsRsmM9JCrPI6pTCUkN/WhRlvw3diErTqwScctYwv9B2F3iLdUfTKoSBNEn2Qg01hItBUpmFueIMGKh
X-Gm-Message-State: AOJu0Yz3ZILeqYZdrrwo9yaoAqUp5Y8J1MqyKJEktxcw/pQzlo3vP9CT
	EjreE5Uh3/PP3KoRBSBhaN1GBnkUBVBNeZ4ysHLjaEv1gnvzZO+GdwYopDfOFNg=
X-Google-Smtp-Source: AGHT+IFb2r1Ao8A/J8LHWX/DDwptGf8gqwhSEuKkDRF+57W2nyzvfzT5B1bEOJm6YhGh1x6d/HEynw==
X-Received: by 2002:a17:906:c242:b0:a55:61cf:f859 with SMTP id bl2-20020a170906c24200b00a5561cff859mr5683751ejb.1.1713795539487;
        Mon, 22 Apr 2024 07:18:59 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id rn2-20020a170906d92200b00a55a67a81c8sm2278910ejb.126.2024.04.22.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:18:58 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:18:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 7/7] net: hns3: fix kernel crash when devlink reload
 during vf initialization
Message-ID: <ZiZx0E5NlSL7nuLE@nanopsycho>
References: <20240422134327.3160587-1-shaojijie@huawei.com>
 <20240422134327.3160587-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134327.3160587-8-shaojijie@huawei.com>

Mon, Apr 22, 2024 at 03:43:27PM CEST, shaojijie@huawei.com wrote:
>From: Yonglong Liu <liuyonglong@huawei.com>
>
>The devlink reload process will access the hardware resources,
>but the register operation is done before the hardware is initialized.
>So, processing the devlink reload during initialization may lead to kernel
>crash. This patch fixes this by taking devl_lock during initialization.
>
>Fixes: cd6242991d2e ("net: hns3: add support for registering devlink for VF")
>Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>---
> drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>index 08db8e84be4e..3ee41943d15f 100644
>--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>@@ -2849,6 +2849,8 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
> 	if (ret)
> 		goto err_devlink_init;
> 

Hmm, what if reload happens here? I think that you don't fix the issue,
rather just narrowing the race window.

Why don't you rather calle devlink_register at the end of this function?


Also, parallel to this patch, why don't you register devlink port of
flavour "virtual" for this VF?


>+	devl_lock(hdev->devlink);
>+
> 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
> 	if (ret)
> 		goto err_cmd_queue_init;
>@@ -2950,6 +2952,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
> 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
> 	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
> 
>+	devl_unlock(hdev->devlink);
> 	return 0;
> 
> err_config:
>@@ -2960,6 +2963,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
> err_cmd_init:
> 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
> err_cmd_queue_init:
>+	devl_unlock(hdev->devlink);
> 	hclgevf_devlink_uninit(hdev);
> err_devlink_init:
> 	hclgevf_pci_uninit(hdev);
>-- 
>2.30.0
>
>

