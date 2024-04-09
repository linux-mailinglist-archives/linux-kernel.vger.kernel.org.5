Return-Path: <linux-kernel+bounces-137095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71589DC53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312491C22E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F3130E4A;
	Tue,  9 Apr 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpnTAMiZ"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39567130AF0;
	Tue,  9 Apr 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672998; cv=none; b=fQbJl49eU4hJi+BbykUBQnAK6fnFQM6ukxeD3bwzdN0ur/A8rW+d2dvQqpfEJRSAkJKSUTIVZ8tXemWa/BKzkP4+I1mE/qwLDCQSY/v4mBYrbr4oNoBYKcRN5/Z3syKXywFrcJu7u6NkY0xtnOZa6mEMklTL4C762sEDD8ZJp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672998; c=relaxed/simple;
	bh=Ag5XnqNucISfEvIbIkrbr8gYzPOeP7XpP2zxkk7XaU0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cSHhj8ZBt/ysnmlnJ+08dqp1n2pw+xJfUHcfTGfnLbQ5DbBUUj7fQ8UPMYgud449G78ZbGbyZdZshuIBxC4AOSYnOm3y/mcjd/+cEy3kaLrUg4LruU8ikuHwCorTgPuRLs4o6yLf8Bi5q3NxwBWhHMsSv0lHjxOFl8ycE7c7D2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpnTAMiZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b236a942dso13135316d6.0;
        Tue, 09 Apr 2024 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712672996; x=1713277796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sM7X07lq+AmKzTRDmOr5Z6+b5U2BleqB4mAYHqNgns=;
        b=SpnTAMiZuqMtN3llmrDk+ExAmMKiXUDe37yeWS6sQqN1aLI1To6syuKUxh8dYWtfkA
         UVA8Nyprp+X9P3Y6UiN1kvi2bV/bNYKe3xnW8N2Y0FhY4NQBDs7w3FCB3w4hmUfphRaq
         WSocGMXDGH9ilMgjTlJP4lr0t8pvMXsPkY0ZBO0ND7+NtjD9V99+zyf0oq5iM+Wb4YEM
         KIJ54JhXop+xix50BJiis0RJ5cvbTyK20Dvc9E2Tx0f//9lHDlS5DN8Focf9NDvEbORw
         Hqjgl7wJ/DYsQSQXaBK3pNFuPoNmaApbGNywVQlO9rJ1S4faK6eCx6rB613WYBcMaheb
         mzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672996; x=1713277796;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3sM7X07lq+AmKzTRDmOr5Z6+b5U2BleqB4mAYHqNgns=;
        b=eungpY9T1r/OA/u3Qnoa/7HmMKnHUwUlwEqGiyXMNvzieI5fn5I8R2aKIx1cQEb1zw
         MqyAZWOMTSSURzWQhEtXyYOqTiG7sfCWYhHO2K/fe0PILEQcrPyG4QK6PDXjTS5dKulK
         SOMbq+ny66trsGyxxoUiaPXln/8GhyMPl0vM3inrvRvPGKJOJuT468XCBQG/nr9ftN4f
         w9jUv3+BrmQE+I0HYSjFGCy8Ll+UJoXPC3wS3EeKK6JB0J38EAnuba7Uwz3xjkZwVfz3
         ZqLJ8Tbqq2NOMvF//DkAMyJeB7VHTIwM10uiVNairsj0/cUtuaUo8jfKHK/1P53wmHSq
         Hd9w==
X-Forwarded-Encrypted: i=1; AJvYcCUFwlRsARLp/IPZoAoWt2g7H/HfwU9Fni84QvW9r9suQDLKNXHLYqI8zc9YYLh+rTY3+zgs4JEBhUviQFyRePRe5vi+6rzARykojSrO9Z3MHh2nqcXypZPlMjde6qzEV4lYeExQ
X-Gm-Message-State: AOJu0YxLcMO1ZbdWNq7OkvQOhXsJzaX4UpZRyGVpTRgkTELhVguLE0T2
	9vkx8GnSCbAvvWwgAQO0XmtVjR7lSPhDnvZ5YGfdNOD/zFjDpRvA
X-Google-Smtp-Source: AGHT+IFtf7pUtQ/+fTY5jgpISCKcKtpbNaZFOnKa4bZ1NAaudHfzimLYNq/KM1NHzbPQoEYP/6FV+w==
X-Received: by 2002:a05:6214:c47:b0:69b:1c3c:aed9 with SMTP id r7-20020a0562140c4700b0069b1c3caed9mr3899574qvj.18.1712672995993;
        Tue, 09 Apr 2024 07:29:55 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id c16-20020a0ce650000000b0069915b47bf4sm3963763qvn.146.2024.04.09.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:29:55 -0700 (PDT)
Date: Tue, 09 Apr 2024 10:29:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: John Fraker <jfraker@google.com>, 
 netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Shailend Chand <shailend@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Junfeng Guo <junfeng.guo@intel.com>, 
 Ziwei Xiao <ziweixiao@google.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 linux-kernel@vger.kernel.org, 
 kory.maincent@bootlin.com, 
 andrew@lunn.ch, 
 richardcochran@gmail.com
Message-ID: <661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240408180918.2773238-1-jfraker@google.com>
References: <20240408180918.2773238-1-jfraker@google.com>
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Fraker wrote:
> gve has supported software timestamp generation since its inception,
> but has not advertised that support via ethtool. This patch correctly
> advertises that support.
> 
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> 
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 815dead..99f5aeb 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -4,6 +4,8 @@
>   * Copyright (C) 2015-2021 Google, Inc.
>   */
>  
> +#include <linux/ethtool.h>
> +#include <linux/net_tstamp.h>
>  #include <linux/rtnetlink.h>
>  #include "gve.h"
>  #include "gve_adminq.h"
> @@ -763,6 +765,15 @@ static int gve_set_coalesce(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static int gve_get_ts_info(struct net_device *netdev, struct ethtool_ts_info *info)
> +{
> +	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_SOFTWARE;
> +
> +	return 0;

This device calls skb_tx_timestamp in its ndo_start_xmit: the
prerequisite for SOF_TIMESTAMPING_TX_SOFTWARE.

All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
net_timestamp_check being called in the device independent code.

To ethtool timestamping maintainers: It's quite unnecessary to have
each device advertise SOF_TIMESTAMPING_RX_SOFTWARE |
SOF_TIMESTAMPING_SOFTWARE. In __ethtool_get_ts_info we could just
always add those flags to the result from the callees.

        if (phy_has_tsinfo(phydev))
                return phy_ts_info(phydev, info);
        if (ops->get_ts_info)
                return ops->get_ts_info(dev, info);

        info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
                                SOF_TIMESTAMPING_SOFTWARE;

> +}
> +
>  const struct ethtool_ops gve_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
>  	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
> @@ -784,5 +795,6 @@ const struct ethtool_ops gve_ethtool_ops = {
>  	.set_tunable = gve_set_tunable,
>  	.get_priv_flags = gve_get_priv_flags,
>  	.set_priv_flags = gve_set_priv_flags,
> -	.get_link_ksettings = gve_get_link_ksettings
> +	.get_link_ksettings = gve_get_link_ksettings,
> +	.get_ts_info = gve_get_ts_info
>  };
> -- 
> 2.44.0.478.gd926399ef9-goog
> 



