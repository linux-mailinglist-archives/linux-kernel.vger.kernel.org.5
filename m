Return-Path: <linux-kernel+bounces-134011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA589AC18
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6CA1C20431
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28F93FB16;
	Sat,  6 Apr 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY2lnDp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B963839D;
	Sat,  6 Apr 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421935; cv=none; b=MUGXx0CpOrWn5JMuzyVp4g5C+fNzkff4oKxXHH7SY9PQrUTtTVa4XSEgyX3nSZD59EzgFCV7nKsZhEJWCZSuUnifTwt/Z/SMTzGRTnEfXrsOOwH58IGiAo5SP0GG/C2mkY8UtQdSJv+2ZvLUh1Se5tIMnbwfwOuhy85yqckJ+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421935; c=relaxed/simple;
	bh=Tnp1inQU7Buh6+yx2ER0/mIIwxvWAJA8D3UAlLEh2uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dfr/wCeNUduxAHOnUjLa13zoiixDMrKbFMx/c3x1ia1ZlTBxNC/5bVwTsSEfYq8A4r+79Xgn09tLiPkct57gtU1RG+YXYnPPymS78WF8/5ivSQr892S96Y37CM/6a1eZFKl+TU7RCjHQmqK8t6tveS9tOMZ+guwzYQ5N1rz6e5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY2lnDp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE5DC433C7;
	Sat,  6 Apr 2024 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712421934;
	bh=Tnp1inQU7Buh6+yx2ER0/mIIwxvWAJA8D3UAlLEh2uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eY2lnDp/Mbw2PeO85q5zSgscHcXApqQ/elAgRadwl2Zb57xKdzKzQ5eIl5Xp67DyF
	 sZnsSSVAvsWtiMPzEvGZh3PxVoBbOkt2rP7NodV9EXvDHp/rdYcRp/O3veROdnAsju
	 o7hqhNTn+kPtEuXZZtBriQ4qgK6hoLbaSHjH7cMyI5zicU9Dmb8hFyGmPW8qrwZyVZ
	 lMQub1IBE/WU1q779r4ZDE/vFg21NOdPkVELuf5M62JROC2WXG53GjnCDRW8dOYWcq
	 7JXEqutQTHp40q2ovn3wxX9F1RbKQAKTdUOEti4YuFOslhepjtoGoFuuA1dyPPwqZI
	 HIU4L7x9S+12g==
Date: Sat, 6 Apr 2024 17:45:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: document in_temp_input file
Message-ID: <20240406174513.13b4e9e4@jic23-huawei>
In-Reply-To: <20240406-in_temp_input-v1-1-a1744a4a49e3@z3ntu.xyz>
References: <20240406-in_temp_input-v1-1-a1744a4a49e3@z3ntu.xyz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Apr 2024 17:31:04 +0200
Luca Weiss <luca@z3ntu.xyz> wrote:

> For example the BMP280 barometric pressure sensor on Qualcomm
> MSM8974-based Nexus 5 smartphone exposes such file in sysfs.
> Document it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Hi Luca,

Applied with a note added on fixing the line above to not reuse X.
A good additional thing but needs mentioning in the commit message.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2e6d5ebfd3c7..7cee78ad4108 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -243,7 +243,8 @@ Description:
>  		less measurements. Units after application of scale and offset
>  		are milli degrees Celsius.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_input
>  KernelVersion:	2.6.38
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 
> ---
> base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> change-id: 20240406-in_temp_input-4505d7fafff8
> 
> Best regards,


