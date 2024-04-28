Return-Path: <linux-kernel+bounces-161460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934F8B4C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B61C20A14
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1A5FEED;
	Sun, 28 Apr 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbpNeXf9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087B8C1F;
	Sun, 28 Apr 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315652; cv=none; b=JEGVXWDWpQnFg49A2vX3J59TJ/BMrjVmD6pzpWu6dC7NUYnvEJHHzUnUe9g3nfMSrlgxgouH4kgPacFbmuKb9T9pgVI/xWAt0zM/Ni1xYn5CdGq+apFpT3DM9ryMMJr53JhSagpS+qUz5yz4oUGR/DKuEYoWN2R2dXTWW3IRtdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315652; c=relaxed/simple;
	bh=j3dgZxwRNCdjI+Z7qYMD9SW57AmVLugjFAeYYrRK/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udQZkj71zhe39tJAg3KZ4bYVWfXoo1EcguBoGD1ww+0KV4YSE+whkUVGrs4KYotCFF6n3KJwJ0ZM1nbnF99nhZn1eFPeO/SpRzd5GDLmHw+Oa8brrxcfZu0uRFbW3uPdAsCBoo+kVvTn6AvCbHQLrSemXbuWdBN79Nr2ct2R0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbpNeXf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35F1C113CC;
	Sun, 28 Apr 2024 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714315652;
	bh=j3dgZxwRNCdjI+Z7qYMD9SW57AmVLugjFAeYYrRK/KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fbpNeXf91akNWf9Z9oN/ywTA3xvo4Iv1flypFsbcpznkTXlDms019j7h21DKqAMaa
	 8qk8DSkZ+HTvE5XRyhx2KInErkxig4gFbIFZ4OHfo1ZzVTN81rNKpro5ub4/XyshHr
	 zRsAx15XPwMzLbdR0qApIgMPS+Hq+2PTlsmoZZRb7ZaWe8QcEccFeiRfF8hzVCyYbm
	 Fz+SLqos/JBw2hMKGzPTKES9OBycPXy2ldh0GKa4pEgl6YbQFGxj/XHBsV0lMN1LeI
	 BVPb3XgQ60MjmI8rau0K50/M1NM5zjqYC+7PvRpzIZuLO26U2FiwtmJKSxq+vMPRRp
	 bD7Mm8Q4iFVzQ==
Date: Sun, 28 Apr 2024 15:47:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, corbet@lwn.net, Ramona Gradinariu
 <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 1/1] docs: iio: adis16475: fix device files tables
Message-ID: <20240428154722.168cb7c2@jic23-huawei>
In-Reply-To: <20240424094152.103667-2-ramona.gradinariu@analog.com>
References: <20240424094152.103667-1-ramona.gradinariu@analog.com>
	<20240424094152.103667-2-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 12:41:52 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Remove in_accel_calibbias_x and in_anglvel_calibbias_x device files
> description, as they do not exist and were added by mistake.
> Add correct naming for in_accel_y_calibbias and in_anglvel_y_calibbias
> device files and update their description.
> 
> Fixes: 8243b2877eef ("docs: iio: add documentation for adis16475 driver")
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Applied
> ---
>  Documentation/iio/adis16475.rst | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
> index 91cabb7d8d05..130f9e97cc17 100644
> --- a/Documentation/iio/adis16475.rst
> +++ b/Documentation/iio/adis16475.rst
> @@ -66,11 +66,9 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
>  +-------------------------------------------+----------------------------------------------------------+
>  | in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
>  +-------------------------------------------+----------------------------------------------------------+
> -| in_accel_calibbias_x                      | x-axis acceleration offset correction                    |
> -+-------------------------------------------+----------------------------------------------------------+
>  | in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
>  +-------------------------------------------+----------------------------------------------------------+
> -| in_accel_calibbias_y                      | y-axis acceleration offset correction                    |
> +| in_accel_y_calibbias                      | Calibration offset for the Y-axis accelerometer channel. |
>  +-------------------------------------------+----------------------------------------------------------+
>  | in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
>  +-------------------------------------------+----------------------------------------------------------+
> @@ -94,11 +92,9 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
>  +---------------------------------------+------------------------------------------------------+
>  | in_anglvel_x_calibbias                | Calibration offset for the X-axis gyroscope channel. |
>  +---------------------------------------+------------------------------------------------------+
> -| in_anglvel_calibbias_x                | x-axis gyroscope offset correction                   |
> -+---------------------------------------+------------------------------------------------------+
>  | in_anglvel_x_raw                      | Raw X-axis gyroscope channel value.                  |
>  +---------------------------------------+------------------------------------------------------+
> -| in_anglvel_calibbias_y                | y-axis gyroscope offset correction                   |
> +| in_anglvel_y_calibbias                | Calibration offset for the Y-axis gyroscope channel. |
>  +---------------------------------------+------------------------------------------------------+
>  | in_anglvel_y_raw                      | Raw Y-axis gyroscope channel value.                  |
>  +---------------------------------------+------------------------------------------------------+


