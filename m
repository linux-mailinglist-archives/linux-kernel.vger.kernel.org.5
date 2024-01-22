Return-Path: <linux-kernel+bounces-34150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1F837478
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EB9B2677C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E940BEE;
	Mon, 22 Jan 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHwwFqog"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2247A6F;
	Mon, 22 Jan 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956493; cv=none; b=Z7VwSsB9qqpl0qUGCTuKJPnRyhndizj0fzUjsP/ZYxDAqfbqynSbvhvQaHqYOZeGObXkur+DwA9v4z6GDvWm2VwfH5JePZQZUNZxWWwc+TX5hevhuHoVnnur6faTdAVihh1iM1VADwZwPz6nE2LVbXWE1HZoWQR78nUO9X+I3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956493; c=relaxed/simple;
	bh=8XRvpSquamu132UqFZuWHKJ8p5Euo14fp4Ytri8iSd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctt0Via0zKoT6nRTDSijMN+y64BWfZYGZUbYBcoI8V0P3yWOJgBxDuEMok8MDGzCIX4Yt0Ccq1TBxHEGJ1Se6DWumz78kdDbyOXlpuFNCc6tSKVxH9U/WnRzNpbaorjQIEq33oyAyhMgWr3EtbEkIRMmAcCug2/O5oyiAsLSf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHwwFqog; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78313f4d149so351601785a.1;
        Mon, 22 Jan 2024 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705956490; x=1706561290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDi9GcOQS8eCYkI2DpVwexR5G2dm1+2pPXZXYYh/dT8=;
        b=fHwwFqog0t0OvN7ww7EQlwkNxx3lyxU5poi1oc19J1JOA6smI2Sz5A6W0hqfBEhB/X
         d/8C2I4FsQfY7csMPYRW+475zJzUFh2BBCVNJkwpqh0B3kYcu2XvrciKS/ceaxcKOWAZ
         IRrMXYOUN295ljOvfuE/b5b7F8awaeY53Zm8VVeObSCus9jfll7vdTNFd2Dn0oczDQWL
         IzKxCAoE1qi2aGoChw3wGVTswHiOOxo5jir36VXJMNsQ8URL1Lwjevl1Kg7vL4U5cAQa
         tkv+kgufGutEJDB2S44SwsAYERoxh4rbfckN6MY7IQnd9gDvCLHGHFYXjWt1WQdF00B6
         dK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956490; x=1706561290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDi9GcOQS8eCYkI2DpVwexR5G2dm1+2pPXZXYYh/dT8=;
        b=KJSiGWolnIz+oZQOkLFC7h/MfbqbGoUerIAQhEaAz8cFhDSb7BdN8YLmDB/GHBS3EH
         dLEdeqv096pYjf/ZwRbkvrVMjPxQXZ7iLMadULy1swWkQlkTsb0qdizcNZplNNwMWo7Z
         2IEXd6ldqsBNQE6AWme9UDSJe03uf3TirMTpM6PeHK9TAY0iVixrpo8m0ss/31qeN6HJ
         NArR+d43xSBvarXD0+0Wg6owtPCGrfrv3HxKXlAczhJM8pzzyPOIJSOLOj37cphcWCQH
         JsPgWNy/r59YcXCWgYgxjUFgjhOIj5SkdjAVGZkp6U0PRExMZIv9kVp06XC9OuuktaKe
         6ZGw==
X-Gm-Message-State: AOJu0Ywas5cwiDioWjbYDpFk0ALD5EnXgB2F+Iu8q73Qt/bXVSeEVK8c
	HAz45IC4CofBTpqrv2x8W2FlZ3tg20l8cNx3BzOUwKCy667sU2hW
X-Google-Smtp-Source: AGHT+IHODYDLocg6BOZ3+ciCSlGghq/llOd9vS1/pgnYtr1Ncp9xWFC/Blj7nzHcnzYTn1MnpjfHjw==
X-Received: by 2002:a05:620a:494b:b0:783:24fc:d09b with SMTP id vz11-20020a05620a494b00b0078324fcd09bmr6272645qkn.106.1705956490265;
        Mon, 22 Jan 2024 12:48:10 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id qp16-20020a05620a389000b00783574d5017sm2440577qkn.19.2024.01.22.12.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 12:48:09 -0800 (PST)
Date: Mon, 22 Jan 2024 15:48:08 -0500
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>, dsahern@kernel.org,
	weiwan@google.com,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 11/22] net: fill in MODULE_DESCRIPTION()s for
 litex
Message-ID: <Za7UiPIebizfbmQn@errol.ini.cmu.edu>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-12-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184543.2501493-12-leitao@debian.org>
X-Clacks-Overhead: GNU Terry Pratchett

On Mon, Jan 22, 2024 at 10:45:32AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the LiteX Liteeth Ethernet device.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel

> ---
>  drivers/net/ethernet/litex/litex_liteeth.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
> index 5182fe737c37..ff54fbe41bcc 100644
> --- a/drivers/net/ethernet/litex/litex_liteeth.c
> +++ b/drivers/net/ethernet/litex/litex_liteeth.c
> @@ -318,4 +318,5 @@ static struct platform_driver liteeth_driver = {
>  module_platform_driver(liteeth_driver);
>  
>  MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
> +MODULE_DESCRIPTION("LiteX Liteeth Ethernet driver");
>  MODULE_LICENSE("GPL");
> -- 
> 2.39.3
> 

