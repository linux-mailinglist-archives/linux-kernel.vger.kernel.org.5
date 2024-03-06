Return-Path: <linux-kernel+bounces-94689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B4874395
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7011F272B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A181C6A5;
	Wed,  6 Mar 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRHDqAwp"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4E1B299;
	Wed,  6 Mar 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766774; cv=none; b=XdBZB5+tPbg/nKFCQqr1shfEEiPl0jKuR/zjZuo9lgFg/+iV4JxnMkbskVepoEZpF3KX0ya741SCeIX/V7oW01GNG1OhGrN8rV3JecEThD1YtrJw2zknvQQ5jUKgPFMf4rkpkjNY+eIVVENjvQYBao9LK8rEWBcyvmRnf4Bkyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766774; c=relaxed/simple;
	bh=sstFOImg+mIZZeO6YTA82ZGkIqfGG50up4ahrfPW+lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLeHUHiEmrepwJEOHUbGNe5OvSkZHeR7KIIFu+aIwB732xZAXLU4ZtphTb0DTvbCEE38D8XLf56f1A4sZtjuW4OqWFPFjEgUV3gVVUayKQD5Bw0ubj/kv37Bheejnqt/R+j7NZPFvrkkmgHQJ005BG+/uOs2eDw8s8K3ebJMZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRHDqAwp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2997cb49711so103227a91.3;
        Wed, 06 Mar 2024 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766773; x=1710371573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAAZ1TKs5DPhStds0Wt4vCLnpYfnvVYbANe/i6k/0oQ=;
        b=DRHDqAwpK+2k+fbIq+X/19+9XGgpOFSJ9LwoTvKpBUFCI/02th7prbJblRuBxfmK46
         dyNYngWGQJcQBeQ3Kq+5WvLxED45ZmgqSgbMXXl4Pbz1h8k3M6+hvoTHuPDWU0pDc/re
         88IpxqQDBoKdua6a3AHi+Dud7CS81uD061S8LswDlpbtZePhiZFtKBwNaxcVC6ICmFZq
         MLeON1aS/B6tHGdRqX/pcWE0x2egvCz+SSivemVSjNak+YJKbu4BedPTYusoa7vtGMB/
         OhnNDVG9yE7i7Ym2IvhFn44X49mToF1QWJrzfgwzGES2rPdYVEETe/00tFOjwEEB0ntq
         b/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766773; x=1710371573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAAZ1TKs5DPhStds0Wt4vCLnpYfnvVYbANe/i6k/0oQ=;
        b=g3WIXmtNn5to3yg5zPPkww4Vk/6ZOQWwe2CAwegbayDEetP8nCuosrAqSNzKISSlm8
         6tZUiDgRdi6R+ZzHTpFZ2D808nlRaqu2o+qu6XHwwQluv53jI8xBMTBhNv+3V+GZd/Py
         Gc8n47aiO3hG18Yr8rFQEINH4Tpr6Sun7iDUEh0qoGB7a/uWC2agguRJ0xFCmPaNs3T3
         tR2TRHZ49IpDRtlaJ8SP6gb2ymhq3c4Zx5mjwyuKDNKkBMt5k3ZLULb61V6ese47w7A1
         BB0UKKqx8HK+OpfPOnrxVNyKLuc5ZK3mFgsZR8H8Sj/C1mfAC687rObj7EJulRw8dOCk
         R6OA==
X-Forwarded-Encrypted: i=1; AJvYcCWnvfxXK3aithqPcvDmeLa2QhCsOSf3Nk4njK8yQtTY6804TRBLWFjjDLKj7NVDu1F8Bq1eoNrgmxmKxOvvz0uT3kgoPftuAzEHq/EvFCU46389+AbTIctyNS4BxtDdxnyDRkD1
X-Gm-Message-State: AOJu0Yyhe345VnYARqDgoPTPpFpQmcZsA2wrv9ZLmMzu3ir429EhwIwm
	HD009pzqG1wshbrqSe22sTS29IwLjNSydutDolSh75+LxHRY1nJE
X-Google-Smtp-Source: AGHT+IGNATbNa8k+USdScMr8d12d0Wm5aPjFMGLlNsT3aYggRqPJrx2gNpy40NOwLNJYBU+Ky6G7DA==
X-Received: by 2002:a17:90b:11cd:b0:29b:8118:9822 with SMTP id gv13-20020a17090b11cd00b0029b81189822mr1412110pjb.17.1709766772807;
        Wed, 06 Mar 2024 15:12:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ee13-20020a17090afc4d00b0029a8d207010sm257560pjb.54.2024.03.06.15.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:12:50 -0800 (PST)
Message-ID: <b9a0117e-3a0b-485b-b92d-81ab18e7d2cb@gmail.com>
Date: Wed, 6 Mar 2024 15:12:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/16] net: dsa: tag_sja1105: refactor
 skb->dev assignment to dsa_tag_8021q_find_user()
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-12-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-12-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> A new tagging protocol implementation based on tag_8021q is on the
> horizon, and it appears that it also has to open-code the complicated
> logic of finding a source port based on a VLAN header.
> 
> Create a single dsa_tag_8021q_find_user() and make sja1105 call it.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


