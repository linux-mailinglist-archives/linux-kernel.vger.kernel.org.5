Return-Path: <linux-kernel+bounces-99284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4F8785FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4CB280F55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B34AEED;
	Mon, 11 Mar 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="e9Thx9Sm"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D14AEE7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176753; cv=none; b=GA1zQJGLcOvh8ewdf7d9Lr4Az6Zkxni8QqL2HIepZtnO/W3xaybvvYl7DlNtNIHFC24iwaLZOSnnTtrd6OsNlVYwpmJxQqP0VLIKkwNixbW9blukjfma1ueBaC/MYH8Qpi17RSbSd3X4st/5xkbeJgDraBdAm/WuowtrAE41+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176753; c=relaxed/simple;
	bh=t1f3oyUTHtqPVyIGHgNS0PwdQP2/tIhGDk5qJE/dCz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hmlf/tLlY7VdgGQoFD+VptjTmn3as+W/KiVRAoj5PHlF3Acpuw1FDuT8Z9IdSQK7DXB7EmV4TVlgxM8/JNOyjBjjf7bR5kOB1NuZLN6u7kGuNBk6yoGTGJ+3/euDqq1Eh7nzsQjkDUP8XqVP2asMDHMVAbkDiHyk02UqWheVZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=e9Thx9Sm; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HTU3RiG+jE1pjwyja6yRPq5p0dcESnWZEFQp5b8GO44=;
  b=e9Thx9SmsX9YQuJpwdSy2vDT+Kw01FDItelYGKiqWq4O2m9w0FcfyeqD
   WBy8+mDMyflttwloOo+fATgcp5cCWJOQZCBNuzIZDH38pyHXzBBoEL9Bp
   LVyxK/H38vRlmxQUoTylMbSxevwnmSQApMjA52Ryp1i39/TH5Ns9WQ3e5
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,117,1708383600"; 
   d="scan'208";a="156088553"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 18:05:41 +0100
Date: Mon, 11 Mar 2024 18:05:41 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
    outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: cfg80211: Remove parentheses
 prism2_get_station
In-Reply-To: <Ze8LBf6xSjCRt4rd@MOLeToid>
Message-ID: <4936c555-2c53-d421-126c-48804a26887d@inria.fr>
References: <Ze8LBf6xSjCRt4rd@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 11 Mar 2024, Felix N. Kimbu wrote:

> Remove unnecessary parentheses around 'wlandev->msdstate != WLAN_MSD_RUNNING'
> in static int prism2_get_station(...)

You don't need the name of the function in the subject line.  That
information doesn't help understand the patch.

julia


>
> This change ensures adherence to coding style guidelines.
>
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 471bb310176f..7451fd2bb580 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
>
>  	memset(sinfo, 0, sizeof(*sinfo));
>
> -	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
> +	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)
>  		return -EOPNOTSUPP;
>
>  	/* build request message */
> --
> 2.34.1
>
>
>

