Return-Path: <linux-kernel+bounces-16057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239B82378E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B851C24694
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262011DA4E;
	Wed,  3 Jan 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQgtpQwW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247681DA3B;
	Wed,  3 Jan 2024 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=fHwQ56i97OHIXttecD026MYSyAw2rlXnCq/U+o4NtQU=; b=TQgtpQwWC4q+uBbxLsGIu9TdMR
	A1JMSyXBnIMP0z1jFR3+80MOnElOPNCfoV8Ar1xrBtaxE+GR50TysDT35s7Nv7qkGPpp554QbQ5ji
	2Ce0EEGf8NBuN4a+FbV5WgaGxPPuCtDqVDreR2Cf0tR9okTRrwkB8mNrGeCA1UPV3EOS+vpiyLt/O
	uJ+lMmAbXQgb1x6wPtzGmoInRuhGw1fEhoATgHtY3EGDH3cPt876igUx0ae0/BDzdBUkxk+Tv17vp
	uioPCfzrK1NVkArGYtNJL5Fw7NSFc6bbEoU+p+UJuyVCmy3sjBhDyajVDQR7PchvBGVwEpBSBu2A6
	9vTL2mOw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9U9-00CEYx-2Y;
	Wed, 03 Jan 2024 22:13:13 +0000
Message-ID: <3466355c-dc30-4638-9bbe-a7433477340c@infradead.org>
Date: Wed, 3 Jan 2024 14:13:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/11] Documentation: driver-api: pps: Add Intel
 Timed I/O PPS generator
Content-Language: en-US
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
 giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, pandith.n@intel.com,
 mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
 <20240103115602.19044-11-lakshmi.sowjanya.d@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103115602.19044-11-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 03:56, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Add Intel Timed I/O PPS usage instructions.
> 
> Co-developed-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/driver-api/pps.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 78dded03e5d8..cb1e4d814d37 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -246,3 +246,25 @@ delay between assert and clear edge as small as possible to reduce system
>  latencies. But if it is too small slave won't be able to capture clear edge
>  transition. The default of 30us should be good enough in most situations.
>  The delay can be selected using 'delay' pps_gen_parport module parameter.
> +
> +
> +Intel Timed I/O PPS signal generator
> +------------------------------------
> +
> +Intel Timed I/O is a high precision device, present on 2019 and newer Intel
> +CPUs, that can generate PPS signal.

              can generate a PPS signal.
or
              can generate PPS signals.

> +
> +Timed I/O and system time are both driven by same hardware clock, The signal

                                                              clock. The signal is

> +generated with a precision of ~20 nanoseconds. The generated PPS signal
> +is used to synchronize an external device with system clock. For example,
> +Share your clock with a device that receives PPS signal, generated by

   share

> +Timed I/O device. There are dedicated Timed I/O pins to deliver PPS signal

maybe:                                                  to deliver the PPS signal

> +to an external device.
> +
> +Usage of Intel Timed I/O as PPS generator:
> +
> +Start generating PPS signal::
> +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
> +
> +Stop generating PPS signal::
> +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable

-- 
#Randy

