Return-Path: <linux-kernel+bounces-111109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A81886805
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094EC1F251C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E2171A6;
	Fri, 22 Mar 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PFgdmLpd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5011CB0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095240; cv=none; b=TMCqThvlv2h/f63ULZccLq/p4mgBC7oMvU9rnJq6oEV9zuEYEpfGzuC6/FRyHGYlfr0Gl8P/4LNvpzbeuRf6qYEbXD4lOX8u4Z1fSgAdG25anjvoGV33jHL5+ObRdu1BzGuaacO2r0d0def9LiPnJ3aIPeYN/HDM/60rjoEsFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095240; c=relaxed/simple;
	bh=WfjmEuuKCN3xsHqH7dLGCnA6wCbMjmd4BRcdgA7BHc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHCJh48we0Vx6IRdtcdcVIC514BYDMhvgWW3FfhZ91/VlZPQO2JbiERf8oqHjrNrv9qvdHyTCUTObNK6J7P4H8AfHFYPuEC62Fdkt/89RQgfIl6Suu+fP7DpMMMu+OaEK0BOGX98evKMCLJHVPxli0oJ97UbNk935SB9Dmq95t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PFgdmLpd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4141156f245so13309425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711095236; x=1711700036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyqAEuiGYY1fZnxN3qvRC88gt7+sHxYQlEaYtT4i3Js=;
        b=PFgdmLpdjKNc1GW95EyWlOtdvKmNGSxTZKgCkmkyidIBdiXrRmPnX3qzD8pceFRhCy
         lY1YHXPXDQEFZ0kvQKW27BMeOgAIiCXlNI/o8ikrU6IpyTGNyYLetZVxZ6UdDfbW59o7
         gcdZgx4eCDWFJpSYFu7XHFuBL50cjXiEyyrnRiPZercBSYeL3Yu3ARCp/o8/s9jtyy+l
         QYSIyH4A90/jZwI2i4JicV9JYaRGRNUVwk90S+OvdxmCE1G4NcC+k/LYN1evnZ8x6eIG
         XseaWpF2t94IM8Qnvet1UIqvYYVDj3SiM+LZ3A33NA8xEg8le8245bo7+WnRCJzPrB6K
         QZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095236; x=1711700036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyqAEuiGYY1fZnxN3qvRC88gt7+sHxYQlEaYtT4i3Js=;
        b=iIph7hl+L8kOZ+6gCEY5DLuGINwYOhq/Z8Bwh6ix3PO5SqtPB/GVquytpcDvQd/2RR
         hS6RZGIsORa9CUOuMZ7yN1suF6bEYZXnWh/ti6HVQYGjJ7AdbDqOA27TorA7Sq8djvTY
         Zy6Di6mdixeIReQAXV3EtCjLfl3kqqGmeX/2ZOGLMpvayTSUuONSIGeRV8TcQLiUMNk8
         o4X0A8emQ8A3MAMe0c9GeBT1r70kkEZQWMAmu6Tlr9mcq4AAlxo8GBRJ/rXW1Lk3MzEr
         Ihp7SgUjWkv0xRZDDIrTVSGZ7x9UUE8LHWnczf2zHF6k9Nj8huiqscYyzCitaSzIh3oz
         Xb3g==
X-Forwarded-Encrypted: i=1; AJvYcCVQbzPAOFAId1WFa+/vS2olHHdyqaAdOqF3lkrBSuxLmdTNHgK5o7u2VGxWDmRGOAtz0lQ3peIr0U8a7ydyQ+MfxxQ3e5d8rXJ1BmqO
X-Gm-Message-State: AOJu0YzSZGCYQtaJSe0KjJnnsDddq++RUvrvIbuiplchrYdYdg5I2+nH
	wfRYNh9l3u3oG2NXFCRHl8bd650pJ4GkvLLrcML5CpGMUB9ViXysXF+rDeZEl7Q=
X-Google-Smtp-Source: AGHT+IFCo8RGcn/AtPX28oGcoH6zEjuFTQbeGnBIiBNB2w0Mnp2lXH+BhehggEZzTuZOoRjtsaaXtQ==
X-Received: by 2002:a05:600c:3b92:b0:414:63c2:8041 with SMTP id n18-20020a05600c3b9200b0041463c28041mr1084209wms.32.1711095236275;
        Fri, 22 Mar 2024 01:13:56 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00414612a43a9sm8068942wmq.28.2024.03.22.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:13:55 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:13:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: mkubecek@suse.cz, idosch@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <Zf09wW36JcpObTPC@nanopsycho>
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
>---
> netlink/coalesce.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/netlink/coalesce.c b/netlink/coalesce.c
>index bc34d3d..bb93f9b 100644
>--- a/netlink/coalesce.c
>+++ b/netlink/coalesce.c

Please make clear indication which project/tree you target with your
patch by putting appropriate name in the [patch NAME] brackets



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

