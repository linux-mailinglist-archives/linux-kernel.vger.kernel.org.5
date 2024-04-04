Return-Path: <linux-kernel+bounces-131644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A7898A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1328C487
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E11BF3A;
	Thu,  4 Apr 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="btrL0Hdf"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A61BC3F;
	Thu,  4 Apr 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241994; cv=none; b=jyafSa0sUgxrI2Y3iptZ/t8zW7zG+MGfToxBOr/Q0OZbTrGW4IBWXoNTi7W1PswedVN8ALbhBl+RRuFYRqVz9Xs0Q+XcTG7y3vnaQ/TpCrB4WH16/Hk3JTLop3GU07du3SDi9dZHcZ09aLu04QGUR/eOi3e4QaeugFY4Plm+lOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241994; c=relaxed/simple;
	bh=H9LwAnAlR1s3cnX8NQpC928+ZbKYlx1Vcabhv3XjSG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0YsXgFjNfq1almN9oAY6EIr3dgupVcZfBwjDrZhwA7KKY2z72i45nX8b8q5QUEyKiqFMeAEWTBBD72596yNdkIHW1RIBlxM5vUXyqqxOvW8ipofw0QF2eKa3bS8akZr0Vpqqohym6ebokPEXEkMtg7wZxw6etwS4UnH9+zIvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=btrL0Hdf; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712241958; x=1712846758; i=w_armin@gmx.de;
	bh=u2RRwremyrYLfAgIcFOQ0P9YXMEq91At7nkmHlm85gM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=btrL0Hdf8J/CDszJWSacoGtJs1vbSY5+W5xnpErLrM8ORb8c808YJxEe7myWoWT/
	 o/WRtgc0BAjGnBPUB8GomvYzBv7/oLlpe23cjian7LY4nb8GbW6uGA1rNTvOlK2J6
	 TRgwNyL/cwjOdI2ZISbHh54NvSyFmQuXa5TJYXJVvMhZ/hhGf47QlYqy9rDPtmeGE
	 /jR14GcC0JcEm6Zx4ZLnTQUAX9IVwdTkoWYqvFfBRzrPLQqNcjN9pRMP+na1y7PY6
	 Qd7W0Vo3LgwYgw1C/l/uevV+nQXFuEixmZGOZs12ZJD/wbpZZpS6Pz1TXCpK1/Qur
	 2W3jDDLUJveZ6B9Rig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1soqYF04OD-013Nwj; Thu, 04
 Apr 2024 16:45:58 +0200
Message-ID: <091f53a0-4921-46c8-987a-3b11a499e46f@gmx.de>
Date: Thu, 4 Apr 2024 16:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: fix Kconfig selects
To: Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Henning Schild
 <henning.schild@siemens.com>, SungHwan Jung <onenowy@gmail.com>,
 Ai Chao <aichao@kylinos.cn>, Robert Joslyn <robert.joslyn@redrectangle.org>,
 Henry Shi <henryshi2018@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404123435.2684819-1-arnd@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240404123435.2684819-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ge7Yo0tsLcqXgoYDFU5J7P83kmLSK/RB3QOHXEDHH78KwXlEAat
 vBLY6RnN2S2Zkl0qrm0WyNjy0x0hKWdcO1Clx3VrbiqCbegjix++01B2ateCNo4w4VNlwxY
 buQ2BrS8n7ii0mhsfHtOA3+xui6zqX9qm2z48RS2M6ugmdVp53Yia5PtfHA1JQynfu69qLA
 ApvN59luzYQkTzKGNG6sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OsAq2A0ZZXM=;fse40cX9dYkNcfET9Da8iPzm9DO
 yAhnjkLyyRe6Dymh9q1jegZ0G5WDgXjill2yepsl/zMWltNUZ2nJQQHvMuMbz2zoFniEWVHpA
 /i8tkk+b1Dlbre7q2TgAXXnYBMzjx57lqDvd8I38pn6q+9F7f8kH4aCzgLXTbFYa03v6RgXql
 2qtj/uV29AdGe8dm9aOp2A2SeRs69chLQ4u26Tdk7VQVkMx6qYhkfm0ZyEfyVRRoLDTWWCW8/
 oUecoNkiyf/tcjRhk4W0LCRkCxVq6fnQtGpvR4VIiT437b9wRzkroWU3aVJK2Ocj1F9bx/ICb
 LDqWcX1zuQrrmQj8MctEoQk8m5kndd8s45dyyhtIOOOH07i92Bu4SlUa8LM7E2LWnWpyTZgDv
 O/MPd11NZNzleHKZX0PLlpphZuFc6I7i2XADMjTk03LZpK3Y2uZQI8KlU34FKWUtYqOQkJ5Wk
 mYJa2mev6I2+t6vu16su/6bhoIirPzNmUK2D5UA0H9sjdFAY5UVTNeSNyvz2F5GxPiaqXD0M4
 p6xaIlqfSK3ppjNN3aNij25+es8LjrkX96xrpB9C96CUwOPkbMbrIwIPGNqj3ZYkKqztTgEs1
 bNw+4JmLymnPo9o8nlW9BEwuuuuYZhNZgNrjjgcBzWSxSJ3R1o4QBdrvS78vdBGbSl9j00isI
 YxQkvYN7e0OXLX0j5iq1hFTFvVH3nd4rFgA+2AU7K6SbmCder8OVotqVwRnn0m3ItYj3dbEtm
 zXyiYCzVjbHLnbFJNB9O/H81xhyCvfsQH9B41W/0kirqda283mmslzSCDQnkgg192nGXeFaUz
 S2U6/yw/CaRreAVCaW6GdnUVjpEjyu+Yn/IRz7Wwa90w4=

Am 04.04.24 um 14:34 schrieb Arnd Bergmann:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The new driver Kconfig entry has a typo that causes a link failure
> when CONFIG_INPUT_SPARSEKMAP is disabled:
>
> x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_notify':
> quickstart.c:(.text+0x96): undefined reference to `sparse_keymap_report_event'
> x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_probe':
> quickstart.c:(.text+0x1da): undefined reference to `sparse_keymap_setup'
>
> Select this symbol instead of the incorrect INPUT_SPARSE_KEYMAP.
>
> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/platform/x86/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ba88a7f259f1..21a37f1b73ab 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -647,7 +647,7 @@ config ACPI_QUICKSTART
>   	tristate "ACPI Quickstart button driver"
>   	depends on ACPI
>   	depends on INPUT
> -	select INPUT_SPARSE_KEYMAP
> +	select INPUT_SPARSEKMAP
>   	help
>   	  This driver adds support for ACPI quickstart button (PNP0C32) devices.
>   	  The button emits a manufacturer-specific key value when pressed, so

Reviewed-by: Armin Wolf <W_Armin@gmx.de>


