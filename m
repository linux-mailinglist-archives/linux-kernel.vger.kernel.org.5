Return-Path: <linux-kernel+bounces-32389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D581E835B05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB661F210AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E77EAF6;
	Mon, 22 Jan 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="XeCbHbFw"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF0E544
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905225; cv=none; b=AFZ/pn8y4PmCQzBLIpL2yB2nBaJ+0TI/bJan15ePQRXHosayrpJT6HaM6Gy0QX6CiwwjbrbKrpgsTSiX6bgXai1NS5zFxUIRKPt5x2yxotpAkNaINL7SXSOwKqoq6i5qR1j+gek9cxbXJU0DktjXcfv2tLV05R0fQ42+K27UgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905225; c=relaxed/simple;
	bh=URm7XNtebHDVin5MzCs9Rd9Gaj5B8wqpTs6Eg3ZkQBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t+wjwmVayXmWWeuBbSUqzLlwQT5n1diHVT0oRkiuFw7vFdHJtARV9sQsbPA90BJR7VFTH76B+sDmJcpvT8AEnIPuoGsn0+Ru1oIZQItTKhcQ9XyK1HOUY1lGpvUU/LqiaNY7+XTNEiNvJoqFGJ3wIjr6jdY8qW0vN3jsI5BgfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=XeCbHbFw; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nseMvP+PR5N4h48ZxlM/LviieiNOXZd2CDGHxfRIQ38=;
  b=XeCbHbFwZutEiqKfoV5iqy/y3Ru4pIvvAuPvroGFbOe6fnV/FCtBusSz
   Ks+vv9riwnbpV0w6p8vJHW3tLBF282/YGTE4jge3tr3jHcHogIGhhSZ/6
   kEDWVPLcdRqTXNp7ZrN3mNwz2Oi4hgH1fWgw9icxIuq1z/EwdHIaGlu2Q
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147837845"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 07:33:39 +0100
Date: Mon, 22 Jan 2024 07:33:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
Subject: Re: [PATCH] coccinelle: device_attr_show: Remove useless expression
 STR
In-Reply-To: <20240122032800.33026-1-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2401220729490.3204@hadrien>
References: <20240122032800.33026-1-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 22 Jan 2024, Li Zhijian wrote:

> Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
> simplifies the patch case, as a result, STR is no longer needed.

Oops, yeah...

thanks,
julia

>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> index 550d1d2fc02a..dfcf9304195f 100644
> --- a/scripts/coccinelle/api/device_attr_show.cocci
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -28,7 +28,7 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>
>  @rp depends on patch@
>  identifier show, dev, attr, buf;
> -expression BUF, SZ, FORMAT, STR;
> +expression BUF, SZ, FORMAT;
>  @@
>
>  ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> --
> 2.29.2
>
>

