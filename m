Return-Path: <linux-kernel+bounces-25448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3982D068
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746AF2820B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735522107;
	Sun, 14 Jan 2024 11:04:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2BF7E;
	Sun, 14 Jan 2024 11:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E7C433F1;
	Sun, 14 Jan 2024 11:04:03 +0000 (UTC)
Message-ID: <fd143cf8-5e3d-4d80-8b53-b05980558e45@xs4all.nl>
Date: Sun, 14 Jan 2024 12:04:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a,
 c)
Content-Language: en-US, nl
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
 Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
 Anton Sviridenko <anton@corp.bluecherry.net>,
 Andrey Utkin <andrey_utkin@fastmail.com>, Ismael Luceno
 <ismael@iodev.co.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "open list:SOFTLOGIC 6x10 MPEG CODEC" <linux-media@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
 Andrew Morton' <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig'
 <hch@infradead.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Jiri Slaby <jirislaby@gmail.com>, stable@vger.kernel.org,
 David Laight <David.Laight@ACULAB.COM>
References: <20240113183334.1690740-1-aurelien@aurel32.net>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240113183334.1690740-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Aurelien,

On 13/01/2024 19:33, Aurelien Jarno wrote:
> This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the solo6x10
> driver. This improves the readability and more importantly, for the
> solo6x10-p2m.c file, this reduces on my system (x86-64, gcc 13):
> - the preprocessed size from 121 MiB to 4.5 MiB;
> - the build CPU time from 46.8 s to 1.6 s;
> - the build memory from 2786 MiB to 98MiB.

Thank you for this patch.

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

I'll pick this up as a fix for v6.8.

Linus, if you prefer to pick this up directly, then that's fine as well.

I was aware for some time that something had changed elsewhere that caused
the solo driver compilation to take a lot of memory, but I didn't have the
time yet to investigate it. I now see that this was discussed in the thread
from the Closes tag. Note that it would have been nice if that was CCed to
linux-media, since it concerned a media driver.

The use of clamp() is definitely cleaner code, but it is rather insane
that max(a, min(b, c)) takes 2786 MiB over 98 MiB for clamp(). The driver
code looks perfectly innocuous, and you won't see the problem unless you compile
on a system or a VM with a lot less memory. (I only noticed it myself when
compiling in a VM.

Perhaps sparse or smatch should be extended with a check for nested min/max
and warn for that with a recommendation to use clamp instead? Although right
now these tools skip the solo driver since it takes too much memory :-)

I even found a min(max(max())) case in drivers/net/wireless/ath/ath11k/mac.c:

        nss = min(nss, max(max(ath11k_mac_max_ht_nss(ht_mcs_mask),
                               ath11k_mac_max_vht_nss(vht_mcs_mask)),
                           ath11k_mac_max_he_nss(he_mcs_mask)));

I wonder how that expands in cpp.

So while this patch is a nice cleanup, the underlying problem remains.

Regards,

	Hans

> 
> In fine, this allows this relatively simple C file to be built on a
> 32-bit system.
> 
> Reported-by: Jiri Slaby <jirislaby@gmail.com>
> Closes: https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com/
> Cc: stable@vger.kernel.org # v6.7+
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  drivers/media/pci/solo6x10/solo6x10-offsets.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/pci/solo6x10/solo6x10-offsets.h b/drivers/media/pci/solo6x10/solo6x10-offsets.h
> index f414ee1316f2..fdbb817e6360 100644
> --- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
> +++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
> @@ -57,16 +57,16 @@
>  #define SOLO_MP4E_EXT_ADDR(__solo) \
>  	(SOLO_EREF_EXT_ADDR(__solo) + SOLO_EREF_EXT_AREA(__solo))
>  #define SOLO_MP4E_EXT_SIZE(__solo) \
> -	max((__solo->nr_chans * 0x00080000),				\
> -	    min(((__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo)) -	\
> -		 __SOLO_JPEG_MIN_SIZE(__solo)), 0x00ff0000))
> +	clamp(__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo) -	\
> +	      __SOLO_JPEG_MIN_SIZE(__solo),			\
> +	      __solo->nr_chans * 0x00080000, 0x00ff0000)
>  
>  #define __SOLO_JPEG_MIN_SIZE(__solo)		(__solo->nr_chans * 0x00080000)
>  #define SOLO_JPEG_EXT_ADDR(__solo) \
>  		(SOLO_MP4E_EXT_ADDR(__solo) + SOLO_MP4E_EXT_SIZE(__solo))
>  #define SOLO_JPEG_EXT_SIZE(__solo) \
> -	max(__SOLO_JPEG_MIN_SIZE(__solo),				\
> -	    min((__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo)), 0x00ff0000))
> +	clamp(__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo),	\
> +	      __SOLO_JPEG_MIN_SIZE(__solo), 0x00ff0000)
>  
>  #define SOLO_SDRAM_END(__solo) \
>  	(SOLO_JPEG_EXT_ADDR(__solo) + SOLO_JPEG_EXT_SIZE(__solo))


