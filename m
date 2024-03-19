Return-Path: <linux-kernel+bounces-107449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071E087FCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935A01F233A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DD7E775;
	Tue, 19 Mar 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R2lHCizn"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379E54BF6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847079; cv=none; b=SpugGnpdm3mVhntE00wPw2movglc/xpNnrUZcjl7OYDPXlLxH+ZJ62HVfABmujAyxuB2b65nkd8zwScz7ts0EmVlQmmR3ng8tS/8VCCF6SIPW/S1k1lgu+KVbNKYefnopSjnjvQWK+mTfxQwd3UyGGmS/IgNaO85sdgG9R2FEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847079; c=relaxed/simple;
	bh=qbS/Fq6/ZtBC6Ftwa7pn2jPBmoaqXs1RyTvJMpw3UQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek03O7/A4IIKefvR8CdtWgHsjnUvz7xGfIcLMCkW8oZp0qcxF8SvAhbjQ+tfgp5DX77tBkxOT1ZlWVMQsZ9oQFowaybmFDwtj/ShAKwdfMyfmvLW0UvhRMyn+vlD0IzdfOeWTuoVBak6I6dTuMQmbqZggzmEyEd6ATauA9mM+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=R2lHCizn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4146172fb7eso10885555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710847075; x=1711451875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcvCGlMHRwj9k6ByHHyaeay4OtVn7NmyScS9HG65Uco=;
        b=R2lHCizneRB+LKYuLEQfSKd6olc5CnyhRIx8n8NRaba+xTEup6yMpkvwRsAIhY44rA
         6BRgwTEkeHNp1ZUFx6Wk9x6nTqT0FXhC/UvJSMJE8vyIUtTTuL9GDy1qJrpoBwTaD1r5
         Rx4ruZR07vVF99oIFV/o45tVb+UPQfYrKfxNeELy5z187biUT99KXuQQomZiPtvNY0Fd
         xA0RiLsdlcN0odBR75YnU2qKVa7KWMZCv89mDdHhsVDOz6tjPsK66j3/fh85FpADghEL
         XRRvH+7P1UsrzFMjsrrPhVi7oJeOa9EGCIkIouAY0vsKaadmxHjhL4sYN5tIDIiy3joe
         /ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710847075; x=1711451875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcvCGlMHRwj9k6ByHHyaeay4OtVn7NmyScS9HG65Uco=;
        b=lRad9BJ6iR8PrMr0iOpEsb/TiQUihqEWXGOATijnM6QaPj7K6zI3LDc5bS9MVuxq8t
         vGBxuLcvbIKQvNeCOsZSEemWIn4aNQEfqzWFGuzYAPk/EVvDJFUWiJvcbW5ZAChXtWXo
         FBbMUQ/5PJVLJtHk7nRbEZWYYJfuFEJQIqDztmSf8bFIX9kE5jj7fQHNMeLchqHBxsVo
         P0HrKL8VciUbaKVCOA3HVJSiz5ybmXclBOzyY+hqi+COkPBX8H7CzMW+DSF5wLD+fr6A
         Rit+vZvSMqwn5rAkHsyjJc0CgnhbJ67SLzsRrFmc1bRRFosEupZUFM0gJoRWaM9Wr9MR
         rRqA==
X-Forwarded-Encrypted: i=1; AJvYcCXf5htrNEqJAhtHZShQxaPexEbf5pgueDDfUPyYb+CjrW9QQPiEMclQMonSTf3fNRYwWf1pRM2M3TMDGpz2GQThDXMPzIGYSut8aTSH
X-Gm-Message-State: AOJu0YzHTOvbGiTL7Vc0S/CagOWSK7pO+adEdioOlfnkRUZI9Pjj5ZNo
	svNVld8GqK5DY4FB6WzEq7/gfSVF5u4vFJ0ZAO1QnHFXukLHJsdX8NLLgjIs4Hs=
X-Google-Smtp-Source: AGHT+IE4g8Wl2ZoiP7Nozc66zsCnp4nObAKcwAoSyvr4KFr0lJ/nsG98UjxjzFxXlsaHKFuKlZZy9Q==
X-Received: by 2002:a05:600c:3556:b0:412:beee:36b3 with SMTP id i22-20020a05600c355600b00412beee36b3mr10520229wmq.7.1710847075115;
        Tue, 19 Mar 2024 04:17:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b0041466d8e33bsm1183307wmq.27.2024.03.19.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:17:54 -0700 (PDT)
Date: Tue, 19 Mar 2024 12:17:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, rkannoth@marvell.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net 2/3] net: hns3: fix kernel crash when devlink
 reload during pf initialization
Message-ID: <Zfl0Xz3vNNH_3Mfo@nanopsycho>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
 <20240318132948.3624333-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318132948.3624333-3-shaojijie@huawei.com>

Mon, Mar 18, 2024 at 02:29:47PM CET, shaojijie@huawei.com wrote:
>From: Yonglong Liu <liuyonglong@huawei.com>
>
>The devlink reload process will access the hardware resources,
>but the register operation is done before the hardware is initialized.
>so, if process the devlink reload during initialization, may lead to kernel
>crash. This patch fixes this by checking whether the NIC is initialized.

Fix your locking, you should take devl_lock during your init. That would
disallow reload to race with it.

pw-bot: cr

>
>Fixes: b741269b2759 ("net: hns3: add support for registering devlink for PF")
>Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>---
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
>index 9a939c0b217f..80db4f7b05f6 100644
>--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
>+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
>@@ -40,8 +40,9 @@ static int hclge_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 	struct pci_dev *pdev = hdev->pdev;
> 	int ret;
> 
>-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
>-		dev_err(&pdev->dev, "reset is handling\n");
>+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
>+	    !test_bit(HCLGE_STATE_NIC_REGISTERED, &hdev->state)) {
>+		dev_err(&pdev->dev, "reset is handling or driver removed\n");
> 		return -EBUSY;
> 	}
> 
>-- 
>2.30.0
>
>

