Return-Path: <linux-kernel+bounces-103526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0B87C09F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8266B22640
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DC7316A;
	Thu, 14 Mar 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPzhtKkE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F370CDE;
	Thu, 14 Mar 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431319; cv=none; b=q6e17FLbJtwHBV2bZ4WpKPnWGA+PISfmb45oGrffeVdwq0aV2nXQN2Nsmtq19sZiCGVACeDwqf3W88MKQp8bvU6eluHsYNEgzmZzZ16r3mrChHdqEjBlIJQIdKpDVW5Cvf5S96j8CLuIRfc8T4iepjfKEd3QfgtLiwnmgwJB6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431319; c=relaxed/simple;
	bh=OLsVf26jNfkPFiisfEugFBO1YbcQjLA5KAEGjzL2Fls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNeLVUvV6hg4EyMxmqJR8bYnEU5slG/N0l3JQ25HLONM4APrvB2QTN4mZ3R9YYyKfca05A1nHdXnHDjGITP6+TNaqvYTSQjOw1ERrCwx5kTH8Yvu05RGb2UkbAUnyWZtKKtVzi0aKRbuHEJukrji+2fPKZIa8eZbdn7s3nuRI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPzhtKkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E77C433F1;
	Thu, 14 Mar 2024 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710431319;
	bh=OLsVf26jNfkPFiisfEugFBO1YbcQjLA5KAEGjzL2Fls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bPzhtKkEhBHnuGWggN1nm4nQo0KhM1ldUYWfoBQTGfDO1T9hGpq67UPj8H7FDITGN
	 7wtXS/ZM5VHib8AGEgYWVDVOCqv82XEAoqMj06KxmU9riKG6pfIjLSEraOdgiMrj23
	 aZe1tDnBIWbb1ZM6blvYH/4vT1+9cS0DSomOKhTIIS/HTZsO3/hg4+O8vjIDfsUPaM
	 vpQQ2E2iux+1g7RXHDV2Eh65RwlcO0Ck6YP/WqcjTAs0i/XeoUqBSvS+kNZRHxalp3
	 vkXfXEnH1U0OyPie7GgK/OIlqhIppBH/fhEKTrekPwL5Y5X9vEJOuCJ8osMuh7KHap
	 L2XceuIrwXPkQ==
Date: Thu, 14 Mar 2024 15:48:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: linux-iio@vger.kernel.org, Conall O'Griofa <conall.ogriofa@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Message-ID: <20240314154824.37150a54@jic23-huawei>
In-Reply-To: <20240311162800.11074-1-sean.anderson@linux.dev>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 12:28:00 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> ams_enable_channel_sequence constructs a "scan_mask" for all the PS and
> PL channels. This works out fine, since scan_index for these channels is
> less than 64. However, it also includes the ams_ctrl_channels, where
> scan_index is greater than 64, triggering undefined behavior. Since we
> don't need these channels anyway, just exclude them.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Hi Sean,

I'd ideally like to understand why we have channels with such large
scan indexes.  Those values should only be used for buffered capture.
It feels like they are being abused here.  Can we set them to -1 instead
and check based on that?
For a channel, a scan index of -1 means it can't be captured via the buffered
interfaces but only accessed via sysfs reads.
I think that's what we have here?

I just feel like if we leave these as things stand, we will get bitten
by similar bugs in the future.  At least with -1 it should be obvious why!

Jonathan


> ---
> 
>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index a55396c1f8b2..4de7ce598e4d 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
>  
>  	/* Run calibration of PS & PL as part of the sequence */
>  	scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
> -	for (i = 0; i < indio_dev->num_channels; i++)
> -		scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		const struct iio_chan_spec *chan = &indio_dev->channels[i];
> +
> +		if (chan->scan_index < AMS_CTRL_SEQ_BASE)
> +			scan_mask |= BIT_ULL(chan->scan_index);
> +	}
>  
>  	if (ams->ps_base) {
>  		/* put sysmon in a soft reset to change the sequence */


