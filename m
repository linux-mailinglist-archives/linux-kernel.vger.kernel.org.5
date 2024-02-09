Return-Path: <linux-kernel+bounces-59447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D08884F73D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC22928E69A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEAD69960;
	Fri,  9 Feb 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="F8yub6xh"
Received: from ts201-smtpout76.ddc.teliasonera.net (ts201-smtpout76.ddc.teliasonera.net [81.236.60.181])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184D65BBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.236.60.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488776; cv=none; b=cogdIWHLwCsiOu6bFQxZ4uNdokSmTW7HdCJT/elRB76T27H0GMrXQ/7fs7COaJbuAalTO4C1PpF6vCUJ1uldq8b1Ok5W3V0L6A/8Vhk2cOm0x7GPbagi3bgEDNHMDjYG4GhUekWxr4AY8Anx3oA/1kwyVnBqxKb0VKCYqwWt7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488776; c=relaxed/simple;
	bh=DXr2vtxB5SZsRjIgAqXwHMetUZoBQEkwdE8sv+48QYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKARSeDUi7upc1kgtY19rOHnBn9wpO+8mgNAknmAD1bG1+rCZ9wbn+BhI5wJOkXeMhvtRRaoFH5MF0jb8JJFH+W9VKbxfv9aIaNUUiXEHbeDBB422j5X6owdYS5VnqYio6/5SctvpjzEJCBx/CTqETOquXVXQeUsoXLaCilpcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org; spf=pass smtp.mailfrom=shipmail.org; dkim=pass (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b=F8yub6xh; arc=none smtp.client-ip=81.236.60.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shipmail.org
X-RG-Rigid: 65C1E60F001D68D3
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffnkfetufghpdggtfgfnhhsuhgsshgtrhhisggvpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhhohhmrghsucfjvghllhhsthhrnphmucdlkfhnthgvlhdmuceothhhohhmrghspghoshesshhhihhpmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeevudffvdeufffgffdtvdeuteffueeivdekhedugefggefgudeikeelgeelieduhfenucfkphepkedurddvvdelrdejvddruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehmrghilhdurdhshhhiphhmrghilhdrohhrghdpihhnvghtpeekuddrvddvledrjedvrdduvdejpdhmrghilhhfrhhomhepthhhohhmrghspghoshesshhhihhpmhgrihhlrdhorhhgpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehffhiflhhlrdgthhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepjhgrnhhirdhnihhkuhhlrgesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhk
	vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtihgrnhhordgtohgvlhhhohesihhnthgvlhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from mail1.shipmail.org (81.229.72.127) by ts201-smtpout76.ddc.teliasonera.net (5.8.716)
        id 65C1E60F001D68D3; Fri, 9 Feb 2024 15:24:29 +0100
Received: from [192.168.0.209] (81-229-72-127-no17.tbcn.telia.com [81.229.72.127])
	by mail1.shipmail.org (Postfix) with ESMTPSA id 23B343601C2;
	Fri,  9 Feb 2024 15:24:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
	t=1707488669; bh=DXr2vtxB5SZsRjIgAqXwHMetUZoBQEkwdE8sv+48QYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F8yub6xhIMP8Nyqs479EcZBkbGDyqI++9hR1Dw1ygKuZO/Ayu7LOMsjMTznbFQv7r
	 ifm8YhtkDQv2KwHHbrAsI0lvI7UO4HC1qWS7/n+VJ0WvdIj2RW6pz0olcsNWb5oqEA
	 64XnBb2ceMIMRhPHlaY/XkTAB3qf6OcRGL2uV6/A=
Message-ID: <0df5a370-0f34-4d67-af10-5538e1a8908a@shipmail.org>
Date: Fri, 9 Feb 2024 15:24:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tests: mm: Convert to drm_dbg_printer
Content-Language: en-US
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jani Nikula <jani.nikula@intel.com>, Luca Coelho <luciano.coelho@intel.com>
References: <20240209140818.106685-1-michal.winiarski@intel.com>
From: =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= <thomas_os@shipmail.org>
In-Reply-To: <20240209140818.106685-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/9/24 15:08, Michał Winiarski wrote:
> Fix one of the tests in drm_mm that was not converted prior to
> drm_debug_printer removal, causing tests build failure.
>
> Fixes: e154c4fc7bf2d ("drm: remove drm_debug_printer in favor of drm_dbg_printer")
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> ---
>   drivers/gpu/drm/tests/drm_mm_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
> index 1eb0c304f9607..3488d930e3a38 100644
> --- a/drivers/gpu/drm/tests/drm_mm_test.c
> +++ b/drivers/gpu/drm/tests/drm_mm_test.c
> @@ -188,7 +188,7 @@ static void drm_test_mm_init(struct kunit *test)
>   
>   static void drm_test_mm_debug(struct kunit *test)
>   {
> -	struct drm_printer p = drm_debug_printer(test->name);
> +	struct drm_printer p = drm_dbg_printer(NULL, DRM_UT_CORE, test->name);
>   	struct drm_mm mm;
>   	struct drm_mm_node nodes[2];
>   

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>



