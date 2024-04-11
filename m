Return-Path: <linux-kernel+bounces-139662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29A8A0618
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156151F2498A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67613B29F;
	Thu, 11 Apr 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZJd3cY/"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABB53E22;
	Thu, 11 Apr 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803500; cv=none; b=drt40FOWFpGuUqe/9WeM/ZwZA6/i53P3geviRHWVgV3YksG1qDv+O2g/yFuXFFrOpbmYUhXaFVpS0IbPjs88PahBR9OcbuAQmvmdwV2v+h2/wQCW9vpjHGikmExukqwPWlhGE3lskpE4rCR9AsdFlBele269nf/3KXIXo+ZDzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803500; c=relaxed/simple;
	bh=+snlzPi37L30h9+Et4ccL1soWIQ5tawzfM+/S5eTLSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBjYsAOk5/FMWMLX+gV3E1DxetzXvbLQhTBUqsSMyCdSv6KcBcE0op84FMe9EuoFF9u8y5syORhzDOpR4Qf2CnOheUuB70wO5ceo2fmjxSF9U5POPXTrbbck7zPF7rZvn2eS2eWHOnTaGJ0/6w5w5ActUNBD9QRpRD9Ax9aLk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZJd3cY/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e220e40998so48321685ad.1;
        Wed, 10 Apr 2024 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712803499; x=1713408299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxeKZky29m/Yl8zWqwSaHE2GGyVpGyAaXJSZ2cyLZys=;
        b=eZJd3cY/SBhgwNeKXQBFZ6fc2Jj9bP++leGZEppi6dQBkC22lxMjxSE+QefRvb39iC
         k++ulvXBywyk5cC+dr2i2MmeU5+AaSYkqkITr5bkLTsCt5AhYvMNh2sM8jZOAVu9Q90O
         Zu/E+Jkr0pHy/tWb4lEPI0zZxb1wJYgL2ZN54cWUdfBNqNUPxo7g6AtkVmNQC4BF9hEm
         EC9jpupZ2/aa5wd9ukigUWB6miR2tT2d39Lei8RYk0ZP2wpQHrzLxHfippYfXxMhLTtl
         064K9gQggX1qHJj/yqelk000SDrnytsG3n6DM2yEXKghDZVKJbYnls28QWd8C+8vlrOT
         f3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712803499; x=1713408299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxeKZky29m/Yl8zWqwSaHE2GGyVpGyAaXJSZ2cyLZys=;
        b=oU+30QukHWMNlADLsv7J8+bpk8gZ/HmxdZ/N8NKRVhQnpkJlbR2h8ZyBzhWAObp5kz
         2JA3yW2RVsYpg8YZA/WFaWwdP+YsYpvb+YZPyYyaZ6Vz1E/88YAPdagEn8ylf0i2TCaT
         WSXMMcLd1nB+srxli/75hsyJZbzR1nWXO6zqHIHI1Rcp4m2405KGGJmoy6jpLsvBFmp2
         YzyJ7RX5ZUCsbPJWPCmm5r/21khk45d24RK2thmjWeoMrac9M5I1DFds3NLXQoEMkqHS
         EfiMn5VKTvP4DnZWcjkkja87hESaI6gYBopwbOu8zf30yoB0tadkQlIqKnKNJiSwe/Vw
         aOMw==
X-Forwarded-Encrypted: i=1; AJvYcCWrW0YdgcSlBUV0WH17k6cYpmvK6s1tuFVmRaEvGSCy3yvwZ/KYCC2nk1frSgwfOADhJ5okecJE/C68g8H24p1epES4HJdAnkbjIULn1mJqP0TcYMTF49tWH6X98LZZLh3UAtc3
X-Gm-Message-State: AOJu0YzL9pPm4WbNUxOkJg32tGGVFcH13Gk96FAv4gar4/xVN0BeeVvs
	C3KBhEMlXcswadyc8PX6U+iyI+0GAgFowFjHJLk8hNDeGGvIY2vW
X-Google-Smtp-Source: AGHT+IGdAs9MIjn1uBrSN8ODixTr1Uz+/WN96Ydwd4xqMsVR/3rlReSaOtOi/Xce+7sh4tCoxy/g7A==
X-Received: by 2002:a17:903:185:b0:1e4:b16e:7f10 with SMTP id z5-20020a170903018500b001e4b16e7f10mr4450841plg.33.1712803498658;
        Wed, 10 Apr 2024 19:44:58 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001e3e081d07esm250775plh.179.2024.04.10.19.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 19:44:58 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:44:54 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching
 aggregator
Message-ID: <ZhdOpk5lCQC0_Xq0@Laptop-X1>
References: <20240404114908.134034-1-tbogendoerfer@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404114908.134034-1-tbogendoerfer@suse.de>

On Thu, Apr 04, 2024 at 01:49:08PM +0200, Thomas Bogendoerfer wrote:
> If selection logic decides to switch to a new aggregator it disables
> all ports of the old aggregator, but doesn't enable ports on
> the new aggregator. These ports will eventually be enabled when
> the next LACPDU is received, which might take some time and without an
> active port transmitted frames are dropped. Avoid this by enabling
> already collected ports of the new aggregator immediately.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/bonding/bond_3ad.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..529e2a7c51e2 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1876,6 +1876,13 @@ static void ad_agg_selection_logic(struct aggregator *agg,
>  				__disable_port(port);
>  			}
>  		}
> +
> +		/* enable ports on new active aggregator */
> +		for (port = best->lag_ports; port;
> +			port = port->next_port_in_aggregator) {
> +			__enable_port(port);
> +		}
> +
>  		/* Slave array needs update. */
>  		*update_slave_arr = true;
>  	}
> -- 
> 2.35.3
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

