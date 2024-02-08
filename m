Return-Path: <linux-kernel+bounces-58500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1F84E735
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88C628EAB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8D84FA3;
	Thu,  8 Feb 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="A8vOG/KP"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1A7EF0C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415091; cv=none; b=XXqow1q8MhF06Iv9OuK9EO3oIWflCqK36k1y5EKZS48ZKlHovRlR67GxVEFR0kUX/m+6223udgFTd5haH9MIhsCt6a0XCuu0p9SroxJgqeOhhMNW8fngJhfH17D5C09WRFGMas4/SWbkwd7Xw1gAl3bwFVcDAxdgkaB+/waoXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415091; c=relaxed/simple;
	bh=BljVYhmqzxYmEca+envNVs4ji1R3FjdjRhTbfglmoDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GltWPML+6v1n33d+9ToKsf99WwHLZ0/8l7LF7EjBfNgRoMQLIcaB4xwCC85CLgMH9RmbTkrv46srue5IkY4PnNySKzNW6wMS6udRqJrtyc+x4uvMaqziu9KR63F1bUIAT7398OpGmKROKDQyWec0LNVloYU9jYPes2TLGWMA+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=A8vOG/KP; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Y8eLrzbSOF1QfY8f1rnOlk; Thu, 08 Feb 2024 18:58:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707415087;
	bh=SUiKKH4tpPPUKGCw9wCMBwYqXT0j4dANGt0PyM91ApQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A8vOG/KPXwBErCe2/79QYD6IL+R75SPpC3y2enYgYQH2g9bw+W5D2sDUU68ETkVXX
	 LUC9roH5U6WSkwUPkvNTkUccAR9M6uzzYD9L5V3dG1opYlJqpFtkPCt7Tg1mFO2lXw
	 m140D9+lL+BG83qOJOu9h3rtiXZOmrka7uKOLWpsfR4ce/YrXrwjK8/h5S9XrXEKmn
	 dVu7SUpwH++T31AREuMfFurZ6wmwSQthcsjSLcxMwrJ2Dn7u/qmoZiNdvD7fRpHrlB
	 xf0C8ZQ4VdEgPnyYjQWjNw4LrvO1LLc6i1fnQdlVfsZprVq3vIVUkZVqbWw4apCoZs
	 p9aDl5JvOY9bw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Feb 2024 18:58:07 +0100
X-ME-IP: 92.140.202.140
Message-ID: <a1af20a9-951f-4a5d-8a60-04ded8d6f9a0@wanadoo.fr>
Date: Thu, 8 Feb 2024 18:58:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: sony: Remove usage of the deprecated ida_simple_xx()
 API
Content-Language: en-MW
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-input@vger.kernel.org
References: <19b538bc05c11747a3dd9fa204fde91942063d52.1698831460.git.christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <19b538bc05c11747a3dd9fa204fde91942063d52.1698831460.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/11/2023 à 10:38, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/hid/hid-sony.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index ebc0aa4e4345..55c0ad61d524 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1844,8 +1844,7 @@ static int sony_set_device_id(struct sony_sc *sc)
>   	 * All others are set to -1.
>   	 */
>   	if (sc->quirks & SIXAXIS_CONTROLLER) {
> -		ret = ida_simple_get(&sony_device_id_allocator, 0, 0,
> -					GFP_KERNEL);
> +		ret = ida_alloc(&sony_device_id_allocator, GFP_KERNEL);
>   		if (ret < 0) {
>   			sc->device_id = -1;
>   			return ret;
> @@ -1861,7 +1860,7 @@ static int sony_set_device_id(struct sony_sc *sc)
>   static void sony_release_device_id(struct sony_sc *sc)
>   {
>   	if (sc->device_id >= 0) {
> -		ida_simple_remove(&sony_device_id_allocator, sc->device_id);
> +		ida_free(&sony_device_id_allocator, sc->device_id);
>   		sc->device_id = -1;
>   	}
>   }

Hi,

gentle reminder.

All patches to remove the ida_simple API have been sent.
And Matthew Wilcox seems happy with the on going work. (see [1])

Based on next-20240207
$git grep ida_simple_get | wc -l
38

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/

