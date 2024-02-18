Return-Path: <linux-kernel+bounces-70283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C44859591
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F90D2820B7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8BF4F5;
	Sun, 18 Feb 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Jq//bwLz"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179BC3229
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244283; cv=none; b=l11n5br61eumHUWo/D175ddthEZhUXrjo5aBdHdLtBHm5hKh0HF3HQjA8njaXNtN34kG3uHtFv/S6oFui2rKLuafzz5Y35GbNwPXLp/I25T6pbZk5na1JX86XDNPRVouz1KwxbmxCeeTO3enmVr8AZ3mtcNqu98jfpwqnAYGcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244283; c=relaxed/simple;
	bh=jxB5mtxUClEyeYhl6ALYiu3s4Ee9DZ8cHj61SqjPJGg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qh5mBMdgvKie1AggvWS5kqBY3pQguXHYpu1bzYv/CqsFbNbNljpvweaEWAJaMxVC9ovGa4Be3EkGf7NxOU+G2eoj5rB+SVgo3MZq0AxUTwo3y4+M17OpUcnATh1Gee9TikVKgG/eFre+655KaUXHU8z3vV+hTTytr4CI5ZSIuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Jq//bwLz; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TbmdbBSVviIHkden+8PwXOmL2cJJEkvmat341wz5Mec=;
  b=Jq//bwLzhgBvbsqBjUGJY9ON/bmAoi0QCjuyyOEyyK5SEAdZWt9+vR83
   UTjE/qMsY1YB7Ufzcu060MEMNWM30E/+FY1YiPfdAOKAkXEDxmPQcTg1H
   XJ5wBI5Vsrxwt7KXbysrEooLeq+XO58wisnJeqwLgbeJUjMz3CCtIIXNC
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="79934373"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:17:53 +0100
Date: Sun, 18 Feb 2024 09:17:52 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
Subject: Re: [PATCH v2] coccinelle: device_attr_show: Remove useless expression
 STR
In-Reply-To: <20240218080054.719008-1-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2402180917060.3095@hadrien>
References: <20240218080054.719008-1-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 18 Feb 2024, Li Zhijian wrote:

> Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
> simplifies the patch case, as a result, STR is no longer needed.
>
> This also helps to fix below coccicheck warning:
> > warning: rp: metavariable STR not used in the - or context code
>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Fixes: ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied to my tree

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

