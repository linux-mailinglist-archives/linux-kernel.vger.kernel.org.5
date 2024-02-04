Return-Path: <linux-kernel+bounces-51688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3B848E41
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF4A283445
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5BE224D5;
	Sun,  4 Feb 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2OkGu9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66B224E3;
	Sun,  4 Feb 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707055419; cv=none; b=iAYWX1/xOH2r2jLOYd8RzkuqnJYecTa+68OCtXxW0lt+9SF45H2+ZheGFuCma6Ywa6BajlD+4OiZQmA124sAXttg5wgCyPyYa0+5KLPUIuxh9G6KqP0bWi2b02LkBt05SGaWCdRzLljObLxZ7rhAh+6M8iSOQwGGLd3BZKD166w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707055419; c=relaxed/simple;
	bh=OjDQR+kQnogtrfINIjTJ/7u1fPkAFQGRWn9ydK3iKf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9/V/VMytIyPOr+va3mu98HJM+glZ2qwthlTJR7ol+Zhs8kq07AfHNbMRC/oq3MMhXVdL55C/Dm3bZiD/5VYLCgJbhyq9J84im55rBpSXXCWvisNa8ZMybiWUMhVVPnzePaFamNCgpFHMBHeIe4jCFI/2stqb6LFi/sOxhZDEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2OkGu9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01D9C433F1;
	Sun,  4 Feb 2024 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707055419;
	bh=OjDQR+kQnogtrfINIjTJ/7u1fPkAFQGRWn9ydK3iKf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t2OkGu9Omu0/pE3oUFVlOQnvHiRMcXOQg7qUcgDa48N6oiH7jkzObBOCeOTsLJUOU
	 wTvfxN2nEkKDvOOe5kPrj6etVvyYgYDl7LS8EL+naRp0OuoH7zO9DiTOTF0z9LojpQ
	 LTQ26jHStyDoTm3La04Z485mqrqzsb8plkV3Hbnv+bfXjcJbFi5qWwU8iVDX0pJiL/
	 ejCzAbqavMoYN5egJhHwex7Opo81Vf3SfjOxoJD2dQh6tpjknKPFQq3finGS7BXMZX
	 UettnuFrhmrJUG2gjj5/rGxwiJvvu+PxTlpnZqSCrWqBi3vlwo0Xn9/cZwYwvkqhqc
	 2FWsT9LAdaV5w==
Date: Sun, 4 Feb 2024 14:03:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensor-als: Return 0 for
 HID_USAGE_SENSOR_TIME_TIMESTAMP
Message-ID: <20240204140326.09a91224@jic23-huawei>
In-Reply-To: <20240204125617.2635574-1-srinivas.pandruvada@linux.intel.com>
References: <20240204125617.2635574-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Feb 2024 04:56:17 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> When als_capture_sample() is called with usage ID
> HID_USAGE_SENSOR_TIME_TIMESTAMP, return 0. The HID sensor core ignores
> the return value for capture_sample() callback, so return value doesn't
> make difference. But correct the return value to return success instead
> of -EINVAL.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied and marked for stable.

Whilst this is the minimal fix (and so the right one!) it would be good
to change this as a follow up to just use direct returns as then this
sort of bug won't get reintroduced and the code will be a bit simpler.

Jonathan

> ---
> As part of review comments for series "Add support of color temperature
> and chromaticity". This is separate from the series as this is
> unrelated.
> 
>  drivers/iio/light/hid-sensor-als.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 5cd27f04b45e..b6c4bef2a7bb 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -226,6 +226,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>  		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
>  								    *(s64 *)raw_data);
> +		ret = 0;
>  		break;
>  	default:
>  		break;


