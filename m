Return-Path: <linux-kernel+bounces-60512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FB8505E5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307B71F24449
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816335D492;
	Sat, 10 Feb 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbAxYiQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B065380C;
	Sat, 10 Feb 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707588502; cv=none; b=QJhlR4swYbPn6fVrJhq4NBF6rwDy5oMUmfFn4uMx3+R0TvYwX/ilKcRgeLtl7sTp5ncedwR8wPX2R3cUDGp5egKFfaHcbvC2wRW+QIRfk2NkHYEw/VyryVzymajRwdSPcMLd0GMZDSq6sqqu/PxwPwMK8CC7oeum/ZLem783z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707588502; c=relaxed/simple;
	bh=pDQ9MEFZ8xbuu5cjngPIgjyWhjXzw1tFUlQOjXM53UU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRgN98XghnJFTOAedU6JT+U0n8AQ29AoSGFojmSV6xmDK5m9tiZA9gdKX5Z/+E8tdjkaA/wO7cmV5nP6oQUjJJEIUc2zGMhnywWb9YKy5wiecWzO6DW9pc2uG7zpmBoD80ZzdSFlDg8As4ob25QUCuuArk+lAC4JeyXR5dtSSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbAxYiQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3D3C433C7;
	Sat, 10 Feb 2024 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707588502;
	bh=pDQ9MEFZ8xbuu5cjngPIgjyWhjXzw1tFUlQOjXM53UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AbAxYiQBPcDTUZFpMI3VrfJxXdzpQnkE6EXur0GKqETKkOJl3zjcnVgoMY8TyZiE6
	 NMy1mnSuW5i4gq8qZCE0/xfNIjbt25I1MzVCp3WOF/o0lyBHcqsGRyWhzpO6e5Y8z5
	 JoUIE6b8UFbc1owojmnDGwY/a+pK3xwAhP3ji1xpJbLJWdkMG/Qkx4x3JxLrG/xCzx
	 N1JrpRiqxGWl6D1+5DVcpdStAVAdPgPrDGtSwUoIzLqThiCNOHqROGVkMbWBzpkrUh
	 CJ7Bvv3rQyJ94pQQ/nB3/gcqyea+8ENah1myGnT0/4eFGuFNWooWAzKj1ZIoN+123+
	 fV0lbTq8RtStw==
Date: Sat, 10 Feb 2024 18:08:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] docs: iio: add documentation for adis16475
 driver
Message-ID: <20240210180809.1a01733e@jic23-huawei>
In-Reply-To: <20240208100126.183697-4-ramona.gradinariu@analog.com>
References: <20240208100126.183697-1-ramona.gradinariu@analog.com>
	<20240208100126.183697-4-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 12:01:26 +0200
Ramona Gradinariu <ramona.gradinariu@analog.com> wrote:

> Add documentation for adis16475 driver which describes
> the driver device files and shows how the user may use the
> ABI for various scenarios (configuration, measurement, etc.).
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
> changes in v3:
>  - fixed wrapping
>  - added sentence showing device files location
>  - fixed typo in device file names by adding the in_ prefix
>  - added new section for channels processed values
>  - rephrased the trigger setting section
>  - gave reference to iio_devbuf documentation for raw data
>  Documentation/iio/adis16475.rst | 381 ++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst     |   1 +
>  2 files changed, 382 insertions(+)
>  create mode 100644 Documentation/iio/adis16475.rst
> 
> diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
> new file mode 100644
> index 000000000000..192ec1225de5
> --- /dev/null
> +++ b/Documentation/iio/adis16475.rst
> @@ -0,0 +1,381 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +ADIS16475 driver
> +================
> +
> +This driver supports Analog Device's IMUs on SPI bus.
> +
> +1. Supported devices
> +====================
> +
> +* `ADIS16465 <https://www.analog.com/ADIS16465>`_
> +* `ADIS16467 <https://www.analog.com/ADIS16467>`_
> +* `ADIS16470 <https://www.analog.com/ADIS16470>`_
> +* `ADIS16475 <https://www.analog.com/ADIS16475>`_
> +* `ADIS16477 <https://www.analog.com/ADIS16477>`_
> +* `ADIS16500 <https://www.analog.com/ADIS16500>`_
> +* `ADIS16505 <https://www.analog.com/ADIS16505>`_
> +* `ADIS16507 <https://www.analog.com/ADIS16507>`_
> +
> +Each supported device is a precision, miniature microelectromechanical system
> +(MEMS) inertial measurement unit (IMU) that includes a triaxial gyroscope and a
> +triaxial accelerometer. Each inertial sensor in the IMU device combines with
> +signal conditioning that optimizes dynamic performance. The factory calibration
> +characterizes each sensor for sensitivity, bias, alignment, linear acceleration
> +(gyroscope bias), and point of percussion (accelerometer location). As a result,
> +each sensor has dynamic compensation formulas that provide accurate sensor
> +measurements over a broad set of conditions.
> +
> +2. Device attributes
> +====================
> +
> +Accelerometer, gyroscope measures are always provided. Furthermore, the driver
measurements (probably what you mean)

> +offers the capability to retrieve the delta angle and the delta velocity
> +measurements computed by the device.
> +
> +The delta angle measurements represent a calculation of angular displacement
> +between each sample update, while  the delta velocity measurements represent a

looks like an accidental extra space after while.

> +calculation of linear velocity change between each sample update.
> +
> +Finally, temperature data are provided which show a coarse measurement of
> +the temperature inside of the IMU device. This data is most useful for
> +monitoring relative changes in the thermal environment.
>> +
> +Usage examples
> +--------------

Whilst useful to lay this out, perhaps reference some standard tools that do all this
for you? (either the really simple one in the kernel tree and/or libiio etc)

Overall very nice docs.

Thanks,

Jonathan




