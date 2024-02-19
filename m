Return-Path: <linux-kernel+bounces-70659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC454859AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B61C20FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2F20F1;
	Mon, 19 Feb 2024 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OtRgshy8"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70235220;
	Mon, 19 Feb 2024 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708310390; cv=none; b=UsDiOQurzemlbkBKr7RQCfFhvQ5ZMjnpYhB/Z/s1y5UY7qNfXEs7GFfzz2U3zd9PETFSK52VBpctlUlgWphydawXh+4GIcJhnxaj6GbilKT9eDtndXTPRYuPW0G04COqg/T6PVQBZ19aQ5SzU4rIiH/YHKRXf5uAi4EZuFjqCM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708310390; c=relaxed/simple;
	bh=9+xo2zaRwmyqIG/KcG72WcTIbFb/AQNcCcaqkzX/i3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaJhB5alvBuKoXaX41T+4zSnib8bc8nAY+eGLQCMFEAn9lnMquqINyWgK/gNNvg1hGJH9AA6A5m35ZT6Y1xx2VwtcW0M4gEQywAWzUSAP/E33PKmAigGeW7vpWZ1bZ6hOhUZv6akzyxBsH0o+3nhHTTCCd/WHVoCoPve9Y7GmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OtRgshy8; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.172.69.54] (1.general.ikepanhc.us.vpn [10.172.69.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9BB9A40ECB;
	Mon, 19 Feb 2024 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708310385;
	bh=k/b69OpV3ks4THLHdlq+Zzsdc+UxJzsw9Pq1QvTtppc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OtRgshy8bvsiIskAGifZ5LyuCJbK263xRfDe2VvjXDuV/UZn7fG280f/j8GQpLDAS
	 PzyfLKBbsPD9s/Ndcid/rlQKjlYDvG6lBRF/c2DN+wItIpxAgIeWxpOo5MaGB0GX2G
	 fiDWEqNB1m/UqIZQJJR3tbiBbh00Sb7RRQ9juYBM83e4RyRjg9THqTTegCyBWoPQXe
	 1kFkQy+mKf3jp+f2BKsZhMH0wogkEc0uNBzXnc+lpvQ4s8gwDATdEwbf1hRXY8au2R
	 OIHtx+50TfUNCKYjZAev35R0PMQ780AAJDcN9LBctJHpWys+IWRX+6NiWTnqiqZITo
	 ZSIx5gkwNBcog==
Message-ID: <3b6a7bba-47a5-469c-aac1-5574ad78dadf@canonical.com>
Date: Mon, 19 Feb 2024 10:39:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ideapad-laptop: support Fn+R dual-function
 key
To: Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0cdbc0e6eb65e160384ae0ed152e7de3ded1d9d5.1707604991.git.soyer@irl.hu>
Content-Language: en-US
From: Ike Panhc <ike.pan@canonical.com>
In-Reply-To: <0cdbc0e6eb65e160384ae0ed152e7de3ded1d9d5.1707604991.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/24 06:51, Gergo Koteles wrote:
> According to the manual, Fn+R adjusts the display refresh rate.
> Map Fn+R to KEY_DISPLAYTOGGLE.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 88eefccb6ed2..4c130957f80d 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1091,6 +1091,8 @@ static const struct key_entry ideapad_keymap[] = {
>  	{ KE_KEY,	0x07 | IDEAPAD_WMI_KEY, { KEY_HELP } },
>  	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
>  	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
> +	/* Refresh Rate Toggle (Fn+R) */
> +	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
>  	/* Dark mode toggle */
>  	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
>  	/* Sound profile switch */

Acked-by: Ike Panhc <ike.pan@canonical.com>

BTW on which ideapad we need this patch?

Thanks.

--
Ike

