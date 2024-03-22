Return-Path: <linux-kernel+bounces-111111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0088680A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E93B220DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1E17597;
	Fri, 22 Mar 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Br2BceTo"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CA15AD0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095286; cv=none; b=NYLQLr5LxQY1V7oih0YakWbWmcH78wFQSKFwYMVpvtGZM/6NDEO4HD1l70Bno+ul51FfukWQoCn6vcZ5AjrTgxai8puosrjil+qSxw0CGFOCbjC5M1V6IKsP+olCKpPyt8bbG4YRuCNjNGj3NvaJA9SSR4SLK/aOBzyniQnlzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095286; c=relaxed/simple;
	bh=JFzNhkP5QLtkYpC2D1YDRejHvg7JEJlRfxAlH2w3BRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rob5wm8XHzB5yHUhy+lhrvZ5d6xlsH7bhRleciT2OC3FSm3PZ+s4ehYFmp8aHhVo3ncMFo5PXazAwhl8Dhrhz0PXN69SZgNRuIDXFSScnl4qHJGyMfeKshvmni+dCO7xvQSW4MIzZaPUJZo2XX5bxTxi68G5RQg1HPjl+t78kEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Br2BceTo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41412411672so14367595e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711095282; x=1711700082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeIG0pthg0gbWT+jSh1Vhdjz7oX1y5VPjP2QtnJca+s=;
        b=Br2BceTok8JRWsNodtS2A7oYZafx+CQUcfpZI8sOCgBu660RtRaJ5jECqGVr6ybOyG
         9rWRn7MfVyuWawm5bA5JxDmOMcnoyOXc79JUC5I2AQMbLLxeZbRQWZBlmGShdXaEmWsR
         +j2UrHVWArOy5M2Vt5XyfeZ4f/GwFt03mJXsSOgd/vKS0/GaUNAUpsJBF0xJ2kjQLYkG
         8zK9SDSV8d11T2lZMD7HvF5gU9HYBkQGTgt2d4LJTKE4cCArvupuyVkPe+JYQssxdQNK
         YA0rjD+aA0hwHrP5OSLmtvRgMIVw+sVLLFpavyGkKHL5mlpMBwrm4pL00KwZr34SYeNv
         qHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095282; x=1711700082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeIG0pthg0gbWT+jSh1Vhdjz7oX1y5VPjP2QtnJca+s=;
        b=V3rNijVHpkJQ8aj7slMMb7+7xmudScq8ihHUQcfCQjhXXq4tTCvhp28xZWhifkx/Z3
         T70lmYfKZ9kZg1imY94YMLUZziE1eLFP6O1MLs7cR8pZYKT7lMegMMcwaCdgvlxvpwNr
         cSfVBQ/jcFrHiW6ZTvOiCRT1QbCHeJycMiU+upK9pwcJsF0TJ1P/EoKQOZdxm4O4Vv7x
         q7UlTSgWiqIOrD6B92Bn3h39Gep6Uh1sO0XU0ZOoYjHGe1Ab0huIR1uyDPcWb2iVE3Sa
         xdi01/UTA0vIxT21iXlNGCfxNRzNWqM5eoLVtPgmalpzO+gQ/c85Gu0qywD9IF0l19bU
         +H8A==
X-Forwarded-Encrypted: i=1; AJvYcCWc4X1hsjSkzVtaIBBka4zu/WA1wiuswc06p03uFiUMpsVUiplIV0EYj65auQhvrbSjwaQqyz+etOoghArMNsUHaPxE4FkTFf3wZsjN
X-Gm-Message-State: AOJu0YyCF/dJo3bLI5oRBw2+d9PJfvgzGo1cyun3tL4U80RBpwN07OBd
	RArLpJuvFtDT/crjRspPPNRvtiUfaFBGnuyIgPh9V1fO60JmPak84Y2kdmyPxZA=
X-Google-Smtp-Source: AGHT+IGwPz6767RcrrY0790mUk4LkwVLzF/Op5LJewSUE4Y+wELU0U25oX+98+rlzwQTxKWavG11Pw==
X-Received: by 2002:a05:600c:5491:b0:413:e63b:b244 with SMTP id iv17-20020a05600c549100b00413e63bb244mr1043452wmb.7.1711095282555;
        Fri, 22 Mar 2024 01:14:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c45d000b00413f4cb62e1sm2303693wmo.23.2024.03.22.01.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:14:42 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:14:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: mkubecek@suse.cz, idosch@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <Zf097_S2K9uxGsR5@nanopsycho>
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322072456.1251387-1-gaoxingwang1@huawei.com>

Fri, Mar 22, 2024 at 08:24:56AM CET, gaoxingwang1@huawei.com wrote:
>Add missing colon in coalesce_reply_cb
>
>Fixes: ec573f209d (netlink: settings: add netlink support for coalesce tx aggr params)
>Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
>
>Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>

Also, please make sure your name is properly formatted. "gaoxingwang"
certainly is not.

>---
> netlink/coalesce.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/netlink/coalesce.c b/netlink/coalesce.c
>index bc34d3d..bb93f9b 100644
>--- a/netlink/coalesce.c
>+++ b/netlink/coalesce.c
>@@ -93,7 +93,7 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, void *data)
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
> 	show_u32("tx-aggr-max-frames", "tx-aggr-max-frames:\t",
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES]);
>-	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs\t",
>+	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
> 	show_cr();
> 
>-- 
>2.27.0
>
>

